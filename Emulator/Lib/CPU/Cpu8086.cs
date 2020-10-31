using System;
using System.Collections.Generic;
using System.Runtime.CompilerServices;
using Emulator.Utils;
using System.Diagnostics;
using System.Threading;
using System.Threading.Tasks;

namespace Emulator.CPU
{
    internal enum Direction
    {
        RegToRm,
        RmToReg
    }

    internal enum Repeat
    {
        None,
        RepZ,
        RepNz,
        NoExecute
    }

    internal enum SegOverride
    {
        None,
        CS,
        DS,
        ES,
        SS
    }

    /// <summary>
    ///     80186 CPU
    /// </summary>
    public sealed class Cpu8086 : IInterrupt, IEventTimer
    {
        private readonly MemoryMapper _memoryProvider;
        private readonly IPortProvider _portProvider;

        private long _clockCount;

        private readonly bool[] _parities = new bool[0x100];

        private readonly Flags _flags = new Flags();

        private bool _doReset;

        private int? _softInterrupt;
        private int? _hardInterrupt;
        private bool _blockInterrupt;

        private ushort _instStartIp;

        private Repeat _stringOperation;
        private ushort _repeatOffset;
        private SegOverride _segOverride = SegOverride.None;

        private readonly List<CpuEvent> _cpuEvents = new List<CpuEvent>();
        private int _eventGen;

        #region registers

        public ushort AX { get; set; }
        public ushort BX { get; set; }
        public ushort CX { get; set; }
        public ushort DX { get; set; }

        public byte AL
        {
            get
            {
                return (byte)(AX & 0xff);
            }
            set
            {
                AX = (ushort)((AX & 0xff00) + value);
            }
        }

        public byte AH
        {
            get
            {
                return (byte)(AX >> 8);
            }
            set
            {
                AX = (ushort)((AX & 0x00ff) + (value << 8));
            }
        }

        public byte BL
        {
            get
            {
                return (byte)(BX & 0xff);
            }
            set
            {
                BX = (ushort)((BX & 0xff00) + value);
            }
        }

        public byte BH
        {
            get
            {
                return (byte)(BX >> 8);
            }
            set
            {
                BX = (ushort)((BX & 0x00ff) + (value << 8));
            }
        }

        public byte CL
        {
            get
            {
                return (byte)(CX & 0xff);
            }
            set
            {
                CX = (ushort)((CX & 0xff00) + value);
            }
        }

        public byte CH
        {
            get
            {
                return (byte)(CX >> 8);
            }
            set
            {
                CX = (ushort)((CX & 0x00ff) + (value << 8));
            }
        }

        public byte DL
        {
            get
            {
                return (byte)(DX & 0xff);
            }
            set
            {
                DX = (ushort)((DX & 0xff00) + value);
            }
        }

        public byte DH
        {
            get
            {
                return (byte)(DX >> 8);
            }
            set
            {
                DX = (ushort)((DX & 0x00ff) | (value << 8));
            }
        }

        public ushort SP { get; set; }
        public ushort BP { get; set; }

        public ushort SI { get; set; }
        public ushort DI { get; set; }

        public ushort CS { get; set; }
        public ushort SS { get; set; }
        public ushort ES { get; set; }
        public ushort DS { get; set; }

        public ushort IP { get; set; }

        public ushort FLAGS => _flags.Value;

        #endregion

        public bool Halt { get; private set; }

        public long InstCount { get; private set; }

        public long ClockCount
        {
            get
            {
                return _clockCount;
            }
            private set
            {
                _clockCount = value;
            }
        }

        public double WorkLoad { get; private set; }

        /// <summary>
        ///     constructor
        /// </summary>
        public Cpu8086(MemoryMapper memProvider, IPortProvider portProvider)
        {
            _memoryProvider = memProvider;
            _portProvider = portProvider;

            InitParities();
        }

        /// <summary>
        ///     initialize parity table
        /// </summary>
        private void InitParities()
        {
            for (var num = 0; num < 0x100; num++)
            {
                var bitCount =
                    ((num & 1) != 0 ? 1 : 0) +
                    ((num & 2) != 0 ? 1 : 0) +
                    ((num & 4) != 0 ? 1 : 0) +
                    ((num & 8) != 0 ? 1 : 0) +
                    ((num & 16) != 0 ? 1 : 0) +
                    ((num & 32) != 0 ? 1 : 0) +
                    ((num & 64) != 0 ? 1 : 0) +
                    ((num & 128) != 0 ? 1 : 0);

                _parities[num] = (bitCount & 1) == 0;
            }
        }

        /// <summary>
        ///     Resets the CPU
        /// </summary>
        public void Reset()
        {
            _doReset = true;
        }

        /// <summary>
        ///     start emulation
        /// </summary>
        public void Run(CancellationToken token)
        {
            const int updateFrequency = 50;
            var periodTicks = Stopwatch.Frequency / updateFrequency;
            var ticksPer10Ms = Stopwatch.Frequency / 100;

            long periodClockCount = (Settings.CpuFrequency * 1000) / updateFrequency;
            long sleepTicks = 0;

            var stopWatch = new Stopwatch();
            while (!token.IsCancellationRequested)
            {
                stopWatch.Restart();
                var endCount = ClockCount + periodClockCount;
                while (ClockCount < endCount)
                    ExecInstruction(GetMemByte(CS, IP++));
                stopWatch.Stop();

                if (stopWatch.ElapsedTicks >= periodTicks)
                    WorkLoad = 1.0;
                else
                {
                    WorkLoad = (double)stopWatch.ElapsedTicks / periodTicks;
                    sleepTicks += periodTicks - stopWatch.ElapsedTicks;

                    if (sleepTicks > ticksPer10Ms)
                    {
                        sleepTicks -= ticksPer10Ms;
                        // ReSharper disable MethodSupportsCancellation
                        Task.Delay(10).Wait();
                        // ReSharper restore MethodSupportsCancellation
                    }
                }
            }
        }

        /// <summary>
        ///     execute the next instruction (single step)
        /// </summary>
        public void ExecNextInstruction()
        {
            ExecInstruction(GetMemByte(CS, IP++));
        }

        /// <summary>
        ///     generate absolute memory address
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        private int GenAddr(ushort seg, ushort offs)
        {
            return ((seg << 4) + offs) & 0xFFFFF;
        }

        /// <summary>
        ///     generate absolute memory address
        /// </summary>
        private int GenAddr(ushort defaultSeg, SegOverride segOverride, ushort offs)
        {
            var segment = 0;
            switch (segOverride)
            {
                case SegOverride.None:
                    segment = defaultSeg;
                    break;
                case SegOverride.CS:
                    segment = CS;
                    ClearSegOverride();
                    break;
                case SegOverride.DS:
                    segment = DS;
                    ClearSegOverride();
                    break;
                case SegOverride.ES:
                    segment = ES;
                    ClearSegOverride();
                    break;
                case SegOverride.SS:
                    segment = SS;
                    ClearSegOverride();
                    break;
            }

            return ((segment << 4) + offs) & 0xFFFFF;
        }

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        private void ClearSegOverride()
        {
            _segOverride = SegOverride.None;
        }

        private void DoReset()
        {
            lock (_cpuEvents)
                _cpuEvents.Clear();
            _hardInterrupt = null;
            _softInterrupt = null;
            _blockInterrupt = false;
            _stringOperation = Repeat.None;
            _repeatOffset = 0;
            ClearSegOverride();

            _flags.Value = 0x0000;
            IP = 0xfff0;
            CS = 0xf000;
            DS = 0x0000;
            ES = 0x0000;
            SS = 0x0000;

            Halt = false;
#if DEBUG
            AX = 0;
            BX = 0;
            CX = 0;
            DX = 0;
            SP = 0;
            BP = 0;
            DS = 0;
            ES = 0;
            SP = 0;
            SI = 0;
            DI = 0;
#endif
        }

        /// <summary>
        ///     execute an instruction
        /// </summary>
        /// <param name="opCode"></param>
        private void ExecInstruction(ushort opCode)
        {
            // perform reset if needed
            if (_doReset)
            {
                _doReset = false;
                DoReset();
                return;
            }

            _instStartIp = IP;

			// handle REP prefixes
			switch (opCode)
            {
                // REP
                case 0xf3:
                    ClockCount += 7;
                    if (CheckRepeat(false))
                    {
                        _stringOperation = Repeat.RepZ;
                        _repeatOffset = (ushort)(IP - 1);
                    }
                    else
                        _stringOperation = Repeat.NoExecute;
                    opCode = GetMemByte(CS, IP++);
                    break;

                // REPNE/REPNZ
                case 0xf2:
                    ClockCount += 7;
                    if (CheckRepeat(false))
                    {
                        _stringOperation = Repeat.RepNz;
                        _repeatOffset = (ushort)(IP - 1);
                    }
                    else
                        _stringOperation = Repeat.NoExecute;
                    opCode = GetMemByte(CS, IP++);
                    break;
            }

            // handle other prefixes
            switch (opCode)
            {
                // LOCK
                case 0xf0:
                    ClockCount += 2;
                    // do nothing
                    opCode = GetMemByte(CS, IP++);
                    break;

                // CS
                case 0x2e:
                    ClockCount += 2;
                    _segOverride = SegOverride.CS;
                    opCode = GetMemByte(CS, IP++);
                    break;

                // DS
                case 0x3e:
                    ClockCount += 2;
                    _segOverride = SegOverride.DS;
                    opCode = GetMemByte(CS, IP++);
                    break;

                // ES
                case 0x26:
                    ClockCount += 2;
                    _segOverride = SegOverride.ES;
                    opCode = GetMemByte(CS, IP++);
                    break;

                // SS
                case 0x36:
                    ClockCount += 2;
                    _segOverride = SegOverride.SS;
                    opCode = GetMemByte(CS, IP++);
                    break;
            }

            switch (opCode)
            {
                // AAA
                case 0x37:
                    ClockCount += 8;
                    if ((AL & 0x0f) > 9 || _flags.AF)
                    {
                        AL = (byte)(AL + 6);
                        AH = (byte)(AH + 1);
                        _flags.CF = true;
                        _flags.AF = true;
                    }
                    else
                    {
                        _flags.CF = false;
                        _flags.AF = false;
                    }
                    AL = (byte)(AL & 0x0f);
                    CalcParitySignZeroFlag(AX);
                    break;

                // AAD
                case 0xd5:
                    {
                        ClockCount += 15;
                        var baseValue = GetMemByte(CS, IP++);
                        AL = (byte)(AH * baseValue + AL);
                        AH = 0;
                        CalcParitySignZeroFlag(AX);
                        break;
                    }

                // AAM
                case 0xd4:
                    {
                        ClockCount += 19;
                        var baseValue = GetMemByte(CS, IP++);
                        AH = (byte)(AL / baseValue);
                        AL = (byte)(AL % baseValue);
                        CalcParitySignZeroFlag(AX);
                        break;
                    }

                // AAS
                case 0x3f:
                    ClockCount += 7;
                    if ((AL & 0x0f) > 9 || _flags.AF)
                    {
                        AL = (byte)(AL - 6);
                        AH = (byte)(AH - 1);
                        _flags.CF = true;
                        _flags.AF = true;
                    }
                    else
                    {
                        _flags.CF = false;
                        _flags.AF = false;
                    }
                    AL = (byte)(AL & 0x0f);
                    break;

                // ADC r/m8, reg8
                case 0x10:
                    DoByteOperation(
                        Direction.RegToRm,
                        AdcByte,
                        3, 10);
                    break;

                // ADC r/m16, reg16
                case 0x11:
                    DoWordOperation(
                        Direction.RegToRm,
                        AdcWord,
                        3, 10);
                    break;

                // ADC reg8, r/m8
                case 0x12:
                    DoByteOperation(
                        Direction.RmToReg,
                        AdcByte,
                        3, 10);
                    break;

                // ADC reg16, r/m16
                case 0x13:
                    DoWordOperation(
                        Direction.RmToReg,
                        AdcWord,
                        3, 10);
                    break;

                // ADC AL, imm8
                case 0x14:
                    {
                        ClockCount += 3;
                        var operand = GetMemByte(CS, IP++);
                        AL = AdcByte(AL, operand);
                        break;
                    }

                // ADC AX, imm16
                case 0x15:
                    {
                        ClockCount += 4;
                        var operand = GetMemWord(CS, IP);
                        IP += 2;
                        AX = AdcWord(AX, operand);
                        break;
                    }

                // ADD r/m8, reg8
                case 0x00:
                    DoByteOperation(
                        Direction.RegToRm,
                        AddByte,
                        3, 10);
                    break;

                // ADD r/m16, reg16
                case 0x01:
                    DoWordOperation(
                        Direction.RegToRm,
                        AddWord,
                        3, 10);
                    break;

                // ADD reg8, r/m8
                case 0x02:
                    DoByteOperation(
                        Direction.RmToReg,
                        AddByte,
                        3, 10);
                    break;

                // ADD reg16, r/m16
                case 0x03:
                    DoWordOperation(
                        Direction.RmToReg,
                        AddWord,
                        3, 10);
                    break;

                // ADD AL, imm8
                case 0x04:
                    {
                        ClockCount += 3;
                        var operand = GetMemByte(CS, IP++);
                        AL = AddByte(AL, operand);
                        break;
                    }

                // ADD AX, imm16
                case 0x05:
                    {
                        ClockCount += 4;
                        var operand = GetMemWord(CS, IP);
                        IP += 2;
                        AX = AddWord(AX, operand);
                        break;
                    }

                // AND r/m8, reg8
                case 0x20:
                    DoByteOperation(
                        Direction.RegToRm,
                        (value, operand) =>
                        {
                            var result = (byte)(value & operand);
                            _flags.CF = _flags.OF = false;
                            CalcParitySignZeroFlag(result);
                            return result;
                        },
                        3, 10);
                    break;

                // AND r/m16, reg16
                case 0x21:
                    DoWordOperation(
                        Direction.RegToRm,
                        (value, operand) =>
                        {
                            var result = (ushort)(value & operand);
                            _flags.CF = _flags.OF = false;
                            CalcParitySignZeroFlag(result);
                            return result;
                        },
                        3, 10);
                    break;

                // AND reg8, r/m8
                case 0x22:
                    DoByteOperation(
                        Direction.RmToReg,
                        (value, operand) =>
                        {
                            var result = (byte)(value & operand);
                            _flags.CF = _flags.OF = false;
                            CalcParitySignZeroFlag(result);
                            return result;
                        },
                        3, 10);
                    break;

                // AND reg16, r/m16
                case 0x23:
                    DoWordOperation(
                        Direction.RmToReg,
                        (value, operand) =>
                        {
                            var result = (ushort)(value & operand);
                            _flags.CF = _flags.OF = false;
                            CalcParitySignZeroFlag(result);
                            return result;
                        },
                        3, 10);
                    break;

                // AND AL, imm8
                case 0x24:
                    {
                        ClockCount += 3;
                        var operand = GetMemByte(CS, IP++);
                        var result = (byte)(AL & operand);
                        _flags.CF = _flags.OF = false;
                        AL = result;
                        CalcParitySignZeroFlag(result);
                        break;
                    }

                // AND AX, imm16
                case 0x25:
                    {
                        ClockCount += 4;
                        var operand = GetMemWord(CS, IP);
                        IP += 2;
                        var result = (ushort)(AX & operand);
                        _flags.CF = _flags.OF = false;
                        AX = result;
                        CalcParitySignZeroFlag(result);
                        break;
                    }

                // BOUND reg16, r/m16 (80186+)
                case 0x62:
                    {
                        ClockCount += 34;

                        int mode, reg, rm, rmAddr;
                        ReadAndDecodeAddressByte(out mode, out reg, out rm, out rmAddr);
                        if (mode == 3)
                            HandleIllegalOpcode();
                        {
                            var lowerBound = (short)_memoryProvider.PeekW(rmAddr);
                            var upperBound = (short)_memoryProvider.PeekW(rmAddr + 2);
                            var index = (short)GetRegWord(reg);
                            if (index < lowerBound || index > upperBound + 2)
                            {
                                IP -= 2;
                                DoSoftInterrupt(5);
                            }
                        }
                    }
                    break;

                // CALL near
                case 0xe8:
                    {
                        ClockCount += 19;
                        var destOffs = (short)GetMemWord(CS, IP);
                        IP += 2;
                        PushWord(IP);
                        IP = (ushort)(IP + destOffs);
                        break;
                    }

                // CALL far
                case 0x9a:
                    {
                        ClockCount += 31;
                        var destOffs = GetMemWord(CS, IP);
                        IP += 2;
                        var destSeg = GetMemWord(CS, IP);
                        IP += 2;
                        PushWord(CS);
                        PushWord(IP);
                        CS = destSeg;
                        IP = destOffs;
                        break;
                    }

                // CBW
                case 0x98:
                    ClockCount += 2;
                    // ReSharper disable once ConvertIfStatementToConditionalTernaryExpression
                    if (AL > 127)
                        AH = 0xff;
                    else
                        AH = 0x00;
                    break;

                // CLC
                case 0xf8:
                    ClockCount += 2;
                    _flags.CF = false;
                    break;

                // CLD
                case 0xfc:
                    ClockCount += 2;
                    _flags.DF = false;
                    break;

                // CLI
                case 0xfa:
                    ClockCount += 2;
                    _flags.IF = false;
                    break;

                // CMC
                case 0xf5:
                    ClockCount += 2;
                    _flags.CF = !_flags.CF;
                    break;

                // CMP r/m8, reg8
                case 0x38:
                    DoByteOperation(
                        Direction.RegToRm,
                        (value, operand) =>
                        {
                            SubByte(value, operand);
                            return 0;
                        },
                        3, 10,
                        false);
                    break;

                // CMP r/m16, reg16
                case 0x39:
                    DoWordOperation(
                        Direction.RegToRm,
                        (value, operand) =>
                        {
                            SubWord(value, operand);
                            return 0;
                        },
                        3, 10,
                        false,
                        false);
                    break;

                // CMP reg8, r/m8
                case 0x3a:
                    DoByteOperation(
                        Direction.RmToReg,
                        (value, operand) =>
                        {
                            SubByte(value, operand);
                            return 0;
                        },
                        3, 10,
                        false);
                    break;

                // CMP reg16, r/m16
                case 0x3b:
                    DoWordOperation(
                        Direction.RmToReg,
                        (value, operand) =>
                        {
                            SubWord(value, operand);
                            return 0;
                        },
                        3, 10,
                        false,
                        false);
                    break;

                // CMP AL, imm8
                case 0x3c:
                    ClockCount += 3;
                    SubByte(AL, GetMemByte(CS, IP++));
                    break;

                // CMP AX, imm16
                case 0x3d:
                    {
                        ClockCount += 4;
                        var operand = GetMemWord(CS, IP);
                        IP += 2;
                        SubWord(AX, operand);
                        break;
                    }

                // CMPSB
                case 0xa6:
                    {
                        if (_stringOperation != Repeat.NoExecute)
                        {
                            ClockCount += 22;

                            SubByte(GetMemByte(DS, _segOverride, SI), GetMemByte(ES, DI));
                            if (_flags.DF)
                            {
                                SI--;
                                DI--;
                            }
                            else
                            {
                                SI++;
                                DI++;
                            }
                            HandleRepeat(true);
                        }
                        else
                            ClearSegOverride();
                        _stringOperation = Repeat.None;
                        break;
                    }

                // CMPSW
                case 0xa7:
                    if (_stringOperation != Repeat.NoExecute)
                    {
                        ClockCount += 22;

                        SubWord(GetMemWord(DS, _segOverride, SI), GetMemWord(ES, DI));
                        if (_flags.DF)
                        {
                            SI -= 2;
                            DI -= 2;
                        }
                        else
                        {
                            SI += 2;
                            DI += 2;
                        }
                        HandleRepeat(true);
                    }
                    else
                        ClearSegOverride();
                    _stringOperation = Repeat.None;
                    break;

                // CWD
                case 0x99:
                    ClockCount += 4;
                    DX = (ushort)(AX >= 0x8000 ? 0xffff : 0);
                    break;

                // DAA
                case 0x27:
                    ClockCount += 4;

                    // algorithm: https://courses.engr.illinois.edu/ece390/books/artofasm/CH06/CH06-2.html#HEADING2-28
                    if ((AL & 0x0f) > 9 || _flags.AF)
                    {
                        AL = (byte)(AL + 6);
                        _flags.AF = true;
                    }

                    if (AL > 0x9f || _flags.CF)
                    {
                        AL = (byte)(AL + 0x60);
                        _flags.CF = true;
                    }

                    CalcParitySignZeroFlag(AL);
                    break;

                // DAS
                case 0x2f:
                    ClockCount += 4;

                    // algorithm: https://courses.engr.illinois.edu/ece390/books/artofasm/CH06/CH06-2.html#HEADING2-28
                    if ((AL & 0x0f) > 9 || _flags.AF)
                    {
                        AL = (byte)(AL - 6);
                        _flags.AF = true;
                    }

                    if (AL > 0x9f || _flags.CF)
                    {
                        AL = (byte)(AL - 0x60);
                        _flags.CF = true;
                    }

                    CalcParitySignZeroFlag(AL);
                    break;

                // DEC AX
                case 0x48:
                    {
                        ClockCount += 3;
                        AX--;
                        CalcParitySignZeroFlag(AX);
                        _flags.OF = AX == 0x7fff;
                        _flags.AF = (AX & 0x0f) == 0x0f;
                        break;
                    }

                // DEC CX
                case 0x49:
                    {
                        ClockCount += 3;
                        CX--;
                        CalcParitySignZeroFlag(CX);
                        _flags.OF = CX == 0x7fff;
                        _flags.AF = (CX & 0x0f) == 0x0f;
                    }
                    break;

                // DEC DX
                case 0x4a:
                    {
                        ClockCount += 3;
                        DX--;
                        CalcParitySignZeroFlag(DX);
                        _flags.OF = DX == 0x7fff;
                        _flags.AF = (DX & 0x0f) == 0x0f;
                        break;
                    }

                // DEC BX
                case 0x4b:
                    {
                        ClockCount += 3;
                        BX--;
                        CalcParitySignZeroFlag(BX);
                        _flags.OF = BX == 0x7fff;
                        _flags.AF = (BX & 0x0f) == 0x0f;
                        break;
                    }

                // DEC SP
                case 0x4c:
                    {
                        ClockCount += 3;
                        SP--;
                        CalcParitySignZeroFlag(SP);
                        _flags.OF = SP == 0x7fff;
                        _flags.AF = (SP & 0x0f) == 0x0f;
                        break;
                    }

                // DEC BP
                case 0x4d:
                    {
                        ClockCount += 3;
                        BP--;
                        CalcParitySignZeroFlag(BP);
                        _flags.OF = BP == 0x7fff;
                        _flags.AF = (BP & 0x0f) == 0x0f;
                        break;
                    }

                // DEC SI
                case 0x4e:
                    {
                        ClockCount += 3;
                        SI--;
                        CalcParitySignZeroFlag(SI);
                        _flags.OF = SI == 0x7fff;
                        _flags.AF = (SI & 0x0f) == 0x0f;
                        break;
                    }

                // DEC DI
                case 0x4f:
                    {
                        ClockCount += 3;
                        DI--;
                        CalcParitySignZeroFlag(DI);
                        _flags.OF = DI == 0x7fff;
                        _flags.AF = (DI & 0x0f) == 0x0f;
                        break;
                    }

                // ENTER imm16, imm8 (80186+)
                case 0xC8:
                    {
                        var size = GetMemWord(CS, IP);
                        IP += 2;
                        var level = (int)GetMemByte(CS, IP++);

                        if (level == 0)
                            ClockCount += 19;
                        else if (level == 1)
                            ClockCount += 29;
                        else
                            ClockCount += 26 + 20 * (level - 1);

                        // source: http://pdos.csail.mit.edu/6.828/2008/readings/i386/ENTER.htm
                        level = level & 0x1F;
                        PushWord(BP);
                        var framePtr = SP;
                        if (level > 0)
                        {
                            for (var idx = 1; idx < level; idx++)
                            {
                                BP -= 2;
                                PushWord(GetMemWord(SS, BP));
                            }
                            PushWord(framePtr);
                        }
                        BP = framePtr;
                        SP -= size;
                        break;
                    }

                // HLT
                case 0xf4:
                    ClockCount += 2;
                    Halt = true;
                    IP--;
                    break;

                // IMUL reg16, r/m16, imm8 (80186+)
                case 0x6B:
                    DoWordOperation(
                        Direction.RmToReg,
                        (value, operand) =>
                        {
                            var result = (short)operand * (sbyte)GetMemByte(CS, IP++);
                            var hiWord = (ushort)((result & 0xffff0000) >> 16);
                            _flags.CF = _flags.OF = hiWord != 0 && hiWord != 0xffff;
                            _flags.ZF = false; // reset zero flag, otherwise the cpu could be detected as NEC V20
                            return (ushort)(result & 0xffff);
                        },
                        24, 31);
                    break;

                // IMUL reg16, r/m16, imm16 (80186+)
                case 0x69:
                    DoWordOperation(
                        Direction.RmToReg,
                        (value, operand) =>
                        {
                            var result = (short)operand * (short)GetMemWord(CS, IP);
                            IP += 2;
                            var hiWord = (ushort)((result & 0xffff0000) >> 16);
                            _flags.CF = _flags.OF = hiWord != 0 && hiWord != 0xffff;
                            _flags.ZF = false; // reset zero flag, otherwise the cpu could be detected as NEC V20
                            return (ushort)(result & 0xffff);
                        },
                        24, 31);
                    break;

                // IN AL, imm8
                case 0xe4:
                    {
                        ClockCount += 10;

                        var port = GetMemByte(CS, IP++);
                        AL = (byte)_portProvider.In(port);
                        break;
                    }

                // IN AX, imm8
                case 0xe5:
                    {
                        ClockCount += 10;

                        var port = GetMemByte(CS, IP++);
                        AX = _portProvider.In(port);
                        break;
                    }

                // IN AL, DX
                case 0xec:
                    ClockCount += 8;
                    AL = (byte)_portProvider.In(DX);
                    break;

                // IN AX, DX
                case 0xed:
                    ClockCount += 8;
                    AX = _portProvider.In(DX);
                    break;

                // INC AX
                case 0x40:
                    {
                        ClockCount += 3;
                        AX++;
                        CalcParitySignZeroFlag(AX);
                        _flags.OF = AX == 0x8000;
                        _flags.AF = (AX & 0x0f) == 0;
                        break;
                    }

                // INC CX
                case 0x41:
                    {
                        ClockCount += 3;
                        CX++;
                        CalcParitySignZeroFlag(CX);
                        _flags.OF = CX == 0x8000;
                        _flags.AF = (CX & 0x0f) == 0;
                        break;
                    }

                // INC DX
                case 0x42:
                    {
                        ClockCount += 3;
                        DX++;
                        CalcParitySignZeroFlag(DX);
                        _flags.OF = DX == 0x8000;
                        _flags.AF = (DX & 0x0f) == 0;
                        break;
                    }

                // INC BX
                case 0x43:
                    {
                        ClockCount += 3;
                        BX++;
                        CalcParitySignZeroFlag(BX);
                        _flags.OF = BX == 0x8000;
                        _flags.AF = (BX & 0x0f) == 0;
                        break;
                    }

                // INC SP
                case 0x44:
                    {
                        ClockCount += 3;
                        SP++;
                        CalcParitySignZeroFlag(SP);
                        _flags.OF = SP == 0x8000;
                        _flags.AF = (SP & 0x0f) == 0;
                        break;
                    }

                // INC BP
                case 0x45:
                    {
                        ClockCount += 3;
                        BP++;
                        CalcParitySignZeroFlag(BP);
                        _flags.OF = BP == 0x8000;
                        _flags.AF = (BP & 0x0f) == 0;
                        break;
                    }

                // INC SI
                case 0x46:
                    {
                        ClockCount += 3;
                        SI++;
                        CalcParitySignZeroFlag(SI);
                        _flags.OF = SI == 0x8000;
                        _flags.AF = (SI & 0x0f) == 0;
                        break;
                    }

                // INC DI
                case 0x47:
                    {
                        ClockCount += 3;
                        DI++;
                        CalcParitySignZeroFlag(DI);
                        _flags.OF = DI == 0x8000;
                        _flags.AF = (DI & 0x0f) == 0;
                        break;
                    }

                // INSB (80186+)
                case 0x6C:
                    {
                        if (_stringOperation != Repeat.NoExecute)
                        {
                            ClockCount += _stringOperation == Repeat.None ? 14 : 8;

                            SetMemByte(ES, DI, (byte)_portProvider.In(DX));
                            if (_flags.DF)
                                DI--;
                            else
                                DI++;
                            HandleRepeat(false);
                        }
                        _stringOperation = Repeat.None;
                        break;
                    }

                // INSW (80186+)
                case 0x6D:
                    {
                        if (_stringOperation != Repeat.NoExecute)
                        {
                            ClockCount += _stringOperation == Repeat.None ? 14 : 8;

                            SetMemWord(ES, DI, _portProvider.In(DX));
                            if (_flags.DF)
                                DI -= 2;
                            else
                                DI += 2;
                            HandleRepeat(false);
                        }
                        _stringOperation = Repeat.None;
                        break;
                    }

                // INT3
                case 0xcc:
                    ClockCount += 45;
                    DoSoftInterrupt(3);
                    break;

                // INT imm8
                case 0xcd:
                    ClockCount += 47;
                    DoSoftInterrupt(GetMemByte(CS, IP++));
                    break;

                // INTO
                case 0xce:
                    if (_flags.OF)
                    {
                        ClockCount += 48;
                        DoSoftInterrupt(4);
                    }
                    else
                        ClockCount += 4;
                    break;

                // IRET
                case 0xcf:
                    {
                        ClockCount += 28;

                        IP = PopWord();
                        CS = PopWord();
                        _flags.Value = PopWord();
                        _blockInterrupt = true;
                        break;
                    }

                // JA
                case 0x77:
                    {
                        var addr = (sbyte)GetMemByte(CS, IP++);
                        if (!_flags.CF && !_flags.ZF)
                        {
                            ClockCount += 13;
                            IP = (ushort)(IP + addr);
                        }
                        else
                            ClockCount += 4;
                        break;
                    }

                // JAE/JNC
                case 0x73:
                    {
                        var addr = (sbyte)GetMemByte(CS, IP++);
                        if (!_flags.CF)
                        {
                            ClockCount += 13;
                            IP = (ushort)(IP + addr);
                        }
                        else
                            ClockCount += 4;
                        break;
                    }

                // JB/JC
                case 0x72:
                    {
                        var addr = (sbyte)GetMemByte(CS, IP++);
                        if (_flags.CF)
                        {
                            ClockCount += 13;
                            IP = (ushort)(IP + addr);
                        }
                        else
                            ClockCount += 4;
                        break;
                    }

                // JBE
                case 0x76:
                    {
                        var addr = (sbyte)GetMemByte(CS, IP++);
                        if (_flags.CF || _flags.ZF)
                        {
                            ClockCount += 13;
                            IP = (ushort)(IP + addr);
                        }
                        else
                            ClockCount += 4;
                        break;
                    }

                // JCXZ:
                case 0xe3:
                    {
                        var addr = (sbyte)GetMemByte(CS, IP++);
                        if (CX == 0)
                        {
                            ClockCount += 15;
                            IP = (ushort)(IP + addr);
                        }
                        else
                            ClockCount += 5;
                        break;
                    }

                // JE/JZ
                case 0x74:
                    {
                        var addr = (sbyte)GetMemByte(CS, IP++);
                        if (_flags.ZF)
                        {
                            ClockCount += 13;
                            IP = (ushort)(IP + addr);
                        }
                        else
                            ClockCount += 4;
                        break;
                    }

                // JG
                case 0x7f:
                    {
                        var addr = (sbyte)GetMemByte(CS, IP++);
                        if (!_flags.ZF && _flags.SF == _flags.OF)
                        {
                            ClockCount += 13;
                            IP = (ushort)(IP + addr);
                        }
                        else
                            ClockCount += 4;
                        break;
                    }

                // JGE
                case 0x7d:
                    {
                        var addr = (sbyte)GetMemByte(CS, IP++);
                        if (_flags.SF == _flags.OF)
                        {
                            ClockCount += 13;
                            IP = (ushort)(IP + addr);
                        }
                        else
                            ClockCount += 4;
                        break;
                    }

                // JL
                case 0x7c:
                    {
                        var addr = (sbyte)GetMemByte(CS, IP++);
                        if (_flags.SF != _flags.OF)
                        {
                            ClockCount += 13;
                            IP = (ushort)(IP + addr);
                        }
                        else
                            ClockCount += 4;
                        break;
                    }

                // JLE
                case 0x7e:
                    {
                        var addr = (sbyte)GetMemByte(CS, IP++);
                        if (_flags.ZF || _flags.SF != _flags.OF)
                        {
                            ClockCount += 13;
                            IP = (ushort)(IP + addr);
                        }
                        else
                            ClockCount += 4;
                        break;
                    }

                // JMP short
                case 0xeb:
                    {
                        ClockCount += 14;
                        var dest = (sbyte)GetMemByte(CS, IP++);
                        IP = (ushort)(IP + dest);
                        break;
                    }

                // JMP near
                case 0xe9:
                    {
                        ClockCount += 14;
                        var dest = (Int16)GetMemWord(CS, IP);
                        IP += 2;
                        IP = (ushort)(IP + dest);
                        break;
                    }

                // JMP far
                case 0xea:
                    {
                        ClockCount += 14;
                        var destOffs = GetMemWord(CS, IP);
                        IP += 2;
                        var destSeg = GetMemWord(CS, IP);
                        CS = destSeg;
                        IP = destOffs;
                        break;
                    }

                // JNE/JNZ
                case 0x75:
                    {
                        var addr = (sbyte)GetMemByte(CS, IP++);
                        if (!_flags.ZF)
                        {
                            ClockCount += 13;
                            IP = (ushort)(IP + addr);
                        }
                        else
                            ClockCount += 4;
                        break;
                    }

                // JNO
                case 0x71:
                    {
                        var addr = (sbyte)GetMemByte(CS, IP++);
                        if (!_flags.OF)
                        {
                            ClockCount += 13;
                            IP = (ushort)(IP + addr);
                        }
                        else
                            ClockCount += 4;
                        break;
                    }

                // JNS
                case 0x79:
                    {
                        var addr = (sbyte)GetMemByte(CS, IP++);
                        if (!_flags.SF)
                        {
                            ClockCount += 13;
                            IP = (ushort)(IP + addr);
                        }
                        else
                            ClockCount += 4;
                        break;
                    }

                // JNP/JPO
                case 0x7b:
                    {
                        var addr = (sbyte)GetMemByte(CS, IP++);
                        if (!_flags.PF)
                        {
                            ClockCount += 13;
                            IP = (ushort)(IP + addr);
                        }
                        else
                            ClockCount += 4;
                        break;
                    }

                // JO
                case 0x70:
                    {
                        var addr = (sbyte)GetMemByte(CS, IP++);
                        if (_flags.OF)
                        {
                            ClockCount += 13;
                            IP = (ushort)(IP + addr);
                        }
                        else
                            ClockCount += 4;
                        break;
                    }

                // JP
                case 0x7a:
                    {
                        var addr = (sbyte)GetMemByte(CS, IP++);
                        if (_flags.PF)
                        {
                            ClockCount += 13;
                            IP = (ushort)(IP + addr);
                        }
                        else
                            ClockCount += 4;
                        break;
                    }

                // JS
                case 0x78:
                    {
                        var addr = (sbyte)GetMemByte(CS, IP++);
                        if (_flags.SF)
                        {
                            ClockCount += 13;
                            IP = (ushort)(IP + addr);
                        }
                        else
                            ClockCount += 4;
                        break;
                    }

                // LAHF
                case 0x9f:
                    ClockCount += 2;
                    AH = (byte)(_flags.Value & 0xff);
                    break;

                // LDS
                case 0xc5:
                    {
                        ClockCount += 18;

                        int mode, reg, rm, rmAddr;
                        ReadAndDecodeAddressByte(out mode, out reg, out rm, out rmAddr);
                        if (mode == 3)
                            HandleIllegalOpcode();
                        else
                        {
                            var offs = _memoryProvider.PeekW(rmAddr);
                            DS = _memoryProvider.PeekW(rmAddr + 2);
                            SetRegWord(reg, offs);
                        }
                    }
                    break;

                // LEA
                case 0x8d:
                    {
                        ClockCount += 6;

                        int mode, reg, rm;
                        var addressByte = GetMemByte(CS, IP++);
                        mode = (addressByte & 0xc0) >> 6;
                        reg = (addressByte & 0x38) >> 3;
                        rm = addressByte & 0x07;
                        if (mode == 3)
                            HandleIllegalOpcode();
                        else
                            SetRegWord(reg, CalcEa(mode, rm));
                    }
                    break;

                // LEAVE (80186+)
                case 0xC9:
                    {
                        ClockCount += 8;
                        SP = BP;
                        BP = PopWord();
                        break;
                    }

                // LES
                case 0xc4:
                    {
                        ClockCount += 18;

                        int mode, reg, rm, rmAddr;
                        ReadAndDecodeAddressByte(out mode, out reg, out rm, out rmAddr);
                        if (mode == 3)
                            HandleIllegalOpcode();
                        else
                        {
                            var offs = _memoryProvider.PeekW(rmAddr);
                            ES = _memoryProvider.PeekW(rmAddr + 2);
                            SetRegWord(reg, offs);
                        }
                    }
                    break;

                // LOCK
                case 0xf0:
                    break;

                // LODSB
                case 0xac:
                    if (_stringOperation != Repeat.NoExecute)
                    {
                        ClockCount += _stringOperation == Repeat.None ? 12 : 11;

                        AL = GetMemByte(DS, _segOverride, SI);
                        if (_flags.DF)
                            SI--;
                        else
                            SI++;
                        HandleRepeat(false);
                    }
                    else
                        ClearSegOverride();
                    _stringOperation = Repeat.None;
                    break;

                // LODSW
                case 0xad:
                    if (_stringOperation != Repeat.NoExecute)
                    {
                        ClockCount += _stringOperation == Repeat.None ? 12 : 11;

                        AX = GetMemWord(DS, _segOverride, SI);
                        if (_flags.DF)
                            SI -= 2;
                        else
                            SI += 2;
                        HandleRepeat(false);
                    }
                    else
                        ClearSegOverride();
                    _stringOperation = Repeat.None;
                    break;

                // LOOP
                case 0xe2:
                    {
                        var addr = (sbyte)GetMemByte(CS, IP++);
                        if (--CX > 0)
                        {
                            ClockCount += 16;
                            IP = (ushort)(IP + addr);
                        }
                        else
                            ClockCount += 6;
                        break;
                    }

                // LOOPE/LOOPZ
                case 0xe1:
                    {
                        var addr = (sbyte)GetMemByte(CS, IP++);
                        if (--CX > 0 && _flags.ZF)
                        {
                            ClockCount += 16;
                            IP = (ushort)(IP + addr);
                        }
                        else
                            ClockCount += 6;
                        break;
                    }

                // LOOPNE/LOOPNZ
                case 0xe0:
                    {
                        var addr = (sbyte)GetMemByte(CS, IP++);
                        if (--CX > 0 && !_flags.ZF)
                        {
                            ClockCount += 16;
                            IP = (ushort)(IP + addr);
                        }
                        else
                            ClockCount += 6;
                        break;
                    }

                // MOV AL, memoffs
                case 0xa0:
                    {
                        ClockCount += 8;
                        var offs = GetMemWord(CS, IP);
                        IP += 2;
                        AL = GetMemByte(DS, _segOverride, offs);
                        break;
                    }

                // MOV AX, memoffs
                case 0xa1:
                    {
                        ClockCount += 8;
                        var offs = GetMemWord(CS, IP);
                        IP += 2;
                        AX = GetMemWord(DS, _segOverride, offs);
                        break;
                    }

                // MOV memoffs, AL
                case 0xa2:
                    {
                        ClockCount += 9;
                        var offs = GetMemWord(CS, IP);
                        IP += 2;
                        SetMemByte(DS, _segOverride, offs, AL);
                        break;
                    }

                // MOV memoffs, AX
                case 0xa3:
                    {
                        ClockCount += 9;
                        var offs = GetMemWord(CS, IP);
                        IP += 2;
                        SetMemWord(DS, _segOverride, offs, AX);
                        break;
                    }

                // MOV AL, imm8
                case 0xb0:
                    ClockCount += 3;
                    AL = GetMemByte(CS, IP++);
                    break;

                // MOV CL, imm8
                case 0xb1:
                    ClockCount += 3;
                    CL = GetMemByte(CS, IP++);
                    break;

                // MOV DL, imm8
                case 0xb2:
                    ClockCount += 3;
                    DL = GetMemByte(CS, IP++);
                    break;

                // MOV BL, imm8
                case 0xb3:
                    ClockCount += 3;
                    BL = GetMemByte(CS, IP++);
                    break;

                // MOV AH, imm8
                case 0xb4:
                    ClockCount += 3;
                    AH = GetMemByte(CS, IP++);
                    break;

                // MOV CH, imm8
                case 0xb5:
                    ClockCount += 3;
                    CH = GetMemByte(CS, IP++);
                    break;

                // MOV DH, imm8
                case 0xb6:
                    ClockCount += 3;
                    DH = GetMemByte(CS, IP++);
                    break;

                // MOV BH, imm8
                case 0xb7:
                    ClockCount += 3;
                    BH = GetMemByte(CS, IP++);
                    break;

                // MOV AX, imm16
                case 0xb8:
                    ClockCount += 4;
                    AX = GetMemWord(CS, IP);
                    IP += 2;
                    break;

                // MOV CX, imm16
                case 0xb9:
                    ClockCount += 4;
                    CX = GetMemWord(CS, IP);
                    IP += 2;
                    break;

                // MOV DX, imm16
                case 0xba:
                    ClockCount += 4;
                    DX = GetMemWord(CS, IP);
                    IP += 2;
                    break;

                // MOV BX, imm16
                case 0xbb:
                    ClockCount += 4;
                    BX = GetMemWord(CS, IP);
                    IP += 2;
                    break;

                // MOV SP, imm16
                case 0xbc:
                    ClockCount += 4;
                    SP = GetMemWord(CS, IP);
                    IP += 2;
                    break;

                // MOV BP, imm16
                case 0xbd:
                    ClockCount += 4;
                    BP = GetMemWord(CS, IP);
                    IP += 2;
                    break;

                // MOV SI, imm16
                case 0xbe:
                    ClockCount += 4;
                    SI = GetMemWord(CS, IP);
                    IP += 2;
                    break;

                // MOV DI, imm16
                case 0xbf:
                    ClockCount += 4;
                    DI = GetMemWord(CS, IP);
                    IP += 2;
                    break;

                // MOV r/m8, imm8
                case 0xc6:
                    {
                        ClockCount += 12;
                        int mode, reg, rm, rmAddr;
                        ReadAndDecodeAddressByte(out mode, out reg, out rm, out rmAddr);

                        var value = GetMemByte(CS, IP++);

                        SetRmByte(mode, rm, rmAddr, value);
                        break;
                    }

                // MOV r/m16, imm16
                case 0xc7:
                    {
                        ClockCount += 13;
                        int mode, reg, rm, rmAddr;
                        ReadAndDecodeAddressByte(out mode, out reg, out rm, out rmAddr);

                        var value = GetMemWord(CS, IP);
                        IP += 2;

                        SetRmWord(mode, rm, rmAddr, value);
                        break;
                    }

                // MOV r/m8, reg8
                case 0x88:
                    DoByteOperation(Direction.RegToRm, value => value, 2, 12);
                    break;

                // MOV r/m16, reg16
                case 0x89:
                    DoWordOperation(Direction.RegToRm, value => value, 2, 12);
                    break;

                // MOV reg8, r/m8
                case 0x8a:
                    DoByteOperation(Direction.RmToReg, value => value, 2, 9);
                    break;

                // MOV reg16, r/m16
                case 0x8b:
                    DoWordOperation(Direction.RmToReg, value => value, 2, 9);
                    break;

                // MOV r/m16, segreg
                case 0x8c:
                    DoWordOperation(Direction.RegToRm, value => value, 2, 11, true);
                    break;

                // MOV segreg, r/m16
                case 0x8e:
                    DoWordOperation(Direction.RmToReg, value => value, 2, 9, true);
                    break;

                // MOVSB
                case 0xa4:
                    if (_stringOperation != Repeat.NoExecute)
                    {
                        ClockCount += _stringOperation == Repeat.None ? 14 : 8;

                        SetMemByte(ES, DI, GetMemByte(DS, _segOverride, SI));
                        if (_flags.DF)
                        {
                            SI--;
                            DI--;
                        }
                        else
                        {
                            SI++;
                            DI++;
                        }
                        HandleRepeat(false);
                    }
                    else
                        ClearSegOverride();
                    _stringOperation = Repeat.None;
                    break;

                // MOVSW
                case 0xa5:
                    if (_stringOperation != Repeat.NoExecute)
                    {
                        ClockCount += _stringOperation == Repeat.None ? 14 : 8;

                        SetMemWord(ES, DI, GetMemWord(DS, _segOverride, SI));
                        if (_flags.DF)
                        {
                            SI -= 2;
                            DI -= 2;
                        }
                        else
                        {
                            SI += 2;
                            DI += 2;
                        }
                        HandleRepeat(false);
                    }
                    else
                        ClearSegOverride();
                    _stringOperation = Repeat.None;
                    break;

                // NOP
                case 0x90:
                    ClockCount += 3;
                    break;

                // OR r/m8, reg8
                case 0x08:
                    DoByteOperation(
                        Direction.RegToRm,
                        (value, operand) =>
                        {
                            var result = (byte)(value | operand);
                            _flags.CF = _flags.OF = false;
                            CalcParitySignZeroFlag(result);
                            return result;
                        },
                        3, 10);
                    break;

                // OR r/m16, reg16
                case 0x09:
                    DoWordOperation(
                        Direction.RegToRm,
                        (value, operand) =>
                        {
                            var result = (ushort)(value | operand);
                            _flags.CF = _flags.OF = false;
                            CalcParitySignZeroFlag(result);
                            return result;
                        },
                        3, 10);
                    break;

                // OR reg8, r/m8
                case 0x0a:
                    DoByteOperation(
                        Direction.RmToReg,
                        (value, operand) =>
                        {
                            var result = (byte)(value | operand);
                            _flags.CF = _flags.OF = false;
                            CalcParitySignZeroFlag(result);
                            return result;
                        },
                        3, 10);
                    break;

                // OR reg16, r/m16
                case 0x0b:
                    DoWordOperation(
                        Direction.RmToReg,
                        (value, operand) =>
                        {
                            var result = (ushort)(value | operand);
                            _flags.CF = _flags.OF = false;
                            CalcParitySignZeroFlag(result);
                            return result;
                        },
                        3, 10);
                    break;

                // OR AL, imm8
                case 0x0c:
                    {
                        ClockCount += 3;
                        var operand = GetMemByte(CS, IP++);
                        var result = (byte)(AL | operand);
                        _flags.CF = _flags.OF = false;
                        AL = result;
                        CalcParitySignZeroFlag(AL);
                        break;
                    }

                // OR AX, imm16
                case 0x0d:
                    {
                        ClockCount += 4;
                        var operand = GetMemWord(CS, IP);
                        IP += 2;
                        var result = (ushort)(AX | operand);
                        _flags.CF = _flags.OF = false;
                        AX = result;
                        CalcParitySignZeroFlag(AX);
                        break;
                    }

                // OUT imm8, AL
                case 0xe6:
                    {
                        ClockCount += 9;
                        var port = GetMemByte(CS, IP++);
                        _portProvider.Out(port, AL, false);
                        break;
                    }

                // OUT imm8, AX
                case 0xe7:
                    {
                        ClockCount += 9;
                        var port = GetMemByte(CS, IP++);
                        _portProvider.Out(port, AX, true);
                        break;
                    }

                // OUT DX, AL
                case 0xee:
                    ClockCount += 7;
                    _portProvider.Out(DX, AL, false);
                    break;

                // OUT DX, AX
                case 0xef:
                    ClockCount += 7;
                    _portProvider.Out(DX, AX, true);
                    break;

                // OUTSB (80186+)
                case 0x6E:
                    {
                        if (_stringOperation != Repeat.NoExecute)
                        {
                            ClockCount += _stringOperation == Repeat.None ? 14 : 8;

                            _portProvider.Out(DX, GetMemByte(DS, _segOverride, SI), false);
                            if (_flags.DF)
                                SI--;
                            else
                                SI++;
                            HandleRepeat(false);
                        }
                        else
                            ClearSegOverride();
                        _stringOperation = Repeat.None;
                        break;
                    }

                // OUTSW (80186+)
                case 0x6F:
                    {
                        if (_stringOperation != Repeat.NoExecute)
                        {
                            ClockCount += _stringOperation == Repeat.None ? 14 : 8;

                            _portProvider.Out(DX, GetMemWord(DS, _segOverride, SI), true);
                            if (_flags.DF)
                                SI -= 2;
                            else
                                SI += 2;
                            HandleRepeat(false);
                        }
                        else
                            ClearSegOverride();
                        _stringOperation = Repeat.None;
                        break;
                    }

                // POP AX
                case 0x58:
                    ClockCount += 10;
                    AX = PopWord();
                    break;

                // POP CX
                case 0x59:
                    ClockCount += 10;
                    CX = PopWord();
                    break;

                // POP DX
                case 0x5a:
                    ClockCount += 10;
                    DX = PopWord();
                    break;

                // POP BX
                case 0x5b:
                    ClockCount += 10;
                    BX = PopWord();
                    break;

                // POP SP
                case 0x5c:
                    ClockCount += 10;
                    SP = PopWord();
                    break;

                // POP BP
                case 0x5d:
                    ClockCount += 10;
                    BP = PopWord();
                    break;

                // POP SI
                case 0x5e:
                    ClockCount += 10;
                    SI = PopWord();
                    break;

                // POP DI
                case 0x5f:
                    ClockCount += 10;
                    DI = PopWord();
                    break;

                // POP ES
                case 0x07:
                    ClockCount += 8;
                    ES = PopWord();
                    break;

                // POP SS
                case 0x17:
                    ClockCount += 8;
                    SS = PopWord();
                    _blockInterrupt = true;
                    break;

                // POP DS
                case 0x1f:
                    ClockCount += 8;
                    DS = PopWord();
                    break;

                // POP r/m16
                case 0x8f:
                    {
                        ClockCount += 20;

                        int mode, reg, rm, rmAddr;
                        ReadAndDecodeAddressByte(out mode, out reg, out rm, out rmAddr);

                        SetRmWord(mode, rm, rmAddr, PopWord());
                        break;
                    }

                // POPA (80186+)
                case 0x61:
                    ClockCount += 51;

                    DI = PopWord();
                    SI = PopWord();
                    BP = PopWord();
                    SP += 2;
                    BX = PopWord();
                    CX = PopWord();
                    DX = PopWord();
                    AX = PopWord();
                    break;

                // POPF
                case 0x9d:
                    ClockCount += 8;
                    _flags.Value = PopWord();
                    break;

                // PUSH AX
                case 0x50:
                    ClockCount += 10;
                    PushWord(AX);
                    break;

                // PUSH CX
                case 0x51:
                    ClockCount += 10;
                    PushWord(CX);
                    break;

                // PUSH DX
                case 0x52:
                    ClockCount += 10;
                    PushWord(DX);
                    break;

                // PUSH BX
                case 0x53:
                    ClockCount += 10;
                    PushWord(BX);
                    break;

                // PUSH SP
                case 0x54:
                    ClockCount += 10;
                    PushWord((ushort)(SP - 2)); // 80286+: push SP as original value
                    break;

                // PUSH BP
                case 0x55:
                    ClockCount += 10;
                    PushWord(BP);
                    break;

                // PUSH SI
                case 0x56:
                    ClockCount += 10;
                    PushWord(SI);
                    break;

                // PUSH DI
                case 0x57:
                    ClockCount += 10;
                    PushWord(DI);
                    break;

                // PUSH ES
                case 0x06:
                    ClockCount += 9;
                    PushWord(ES);
                    break;

                // PUSH CS
                case 0x0e:
                    ClockCount += 9;
                    PushWord(CS);
                    break;

                // PUSH SS
                case 0x16:
                    ClockCount += 9;
                    PushWord(SS);
                    break;

                // PUSH DS
                case 0x1e:
                    ClockCount += 9;
                    PushWord(DS);
                    break;

                // PUSH imm8 (80186+)
                case 0x6A:
                    ClockCount += 10;
                    PushWord(GetMemByte(CS, IP++));
                    break;

                // PUSH imm16 (80186+)
                case 0x68:
                    ClockCount += 10;
                    PushWord(GetMemWord(CS, IP));
                    IP += 2;
                    break;

                // PUSHA (80186+)
                case 0x60:
                    ClockCount += 36;

                    var tempSp = SP;
                    PushWord(AX);
                    PushWord(CX);
                    PushWord(DX);
                    PushWord(BX);
                    PushWord(tempSp);
                    PushWord(BP);
                    PushWord(SI);
                    PushWord(DI);
                    break;

                // PUSHF
                case 0x9c:
                    ClockCount += 9;
                    PushWord(_flags.Value);
                    break;

                // RET
                case 0xc3:
                    ClockCount += 16;
                    IP = PopWord();
                    break;

                // RET imm16
                case 0xc2:
                    {
                        ClockCount += 18;
                        var increment = GetMemWord(CS, IP);
                        IP = PopWord();
                        SP += increment;
                        break;
                    }

                // RETF
                case 0xcb:
                    ClockCount += 22;
                    IP = PopWord();
                    CS = PopWord();
                    break;

                // RETF imm16
                case 0xca:
                    {
                        ClockCount += 25;
                        var increment = GetMemWord(CS, IP);
                        IP = PopWord();
                        CS = PopWord();
                        SP += increment;
                        break;
                    }

                // SAHF
                case 0x9e:
                    ClockCount += 3;
                    _flags.Value = (ushort)((_flags.Value & 0xff00) | AH);
                    break;

                // SBB r/m8, reg8
                case 0x18:
                    DoByteOperation(
                        Direction.RegToRm,
                        SbbByte,
                        3, 10);
                    break;

                // SBB r/m16, reg16
                case 0x19:
                    DoWordOperation(
                        Direction.RegToRm,
                        SbbWord,
                        3, 10);
                    break;

                // SBB reg8, r/m8
                case 0x1a:
                    DoByteOperation(
                        Direction.RmToReg,
                        SbbByte,
                        3, 10);
                    break;

                // SBB reg16, r/m16
                case 0x1b:
                    DoWordOperation(
                        Direction.RmToReg,
                        SbbWord,
                        3, 10);
                    break;

                // SBB AL, imm8
                case 0x1c:
                    {
                        ClockCount += 2;
                        AL = SbbByte(AL, GetMemByte(CS, IP++));                           
                        break;
                    }

                // SBB AX, imm16
                case 0x1d:
                    {
                        ClockCount += 3;

                        AX = SbbWord(AX, GetMemWord(CS, IP));
                        IP += 2;
                        break;
                    }

                // SCASB
                case 0xae:
                    if (_stringOperation != Repeat.NoExecute)
                    {
                        ClockCount += 15;
                            
                        SubByte(AL, GetMemByte(ES, DI));
                        if (_flags.DF)
                            DI--;
                        else
                            DI++;
                        HandleRepeat(true);
                    }
                    _stringOperation = Repeat.None;
                    break;

                // SCASW
                case 0xaf:
                    if (_stringOperation != Repeat.NoExecute)
                    {
                        ClockCount += 15;

                        SubWord(AX, GetMemWord(ES, DI));
                        if (_flags.DF)
                            DI -= 2;
                        else
                            DI += 2;
                        HandleRepeat(true);
                    }
                    _stringOperation = Repeat.None;
                    break;

                // STC
                case 0xf9:
                    ClockCount += 2;
                    _flags.CF = true;
                    break;

                // STD
                case 0xfd:
                    ClockCount += 2;
                    _flags.DF = true;
                    break;

                // STI
                case 0xfb:
                    ClockCount += 2;
                    _flags.IF = true;
                    _blockInterrupt = true;
                    break;

                // STOSB
                case 0xaa:
                    if (_stringOperation != Repeat.NoExecute)
                    {
                        ClockCount += _stringOperation == Repeat.None ? 10 : 9;

                        SetMemByte(ES, DI, AL);
                        if (_flags.DF)
                            DI--;
                        else
                            DI++;
                        HandleRepeat(false);
                    }
                    _stringOperation = Repeat.None;
                    break;

                // STOSW
                case 0xab:
                    if (_stringOperation != Repeat.NoExecute)
                    {
                        ClockCount += _stringOperation == Repeat.None ? 10 : 9;

                        SetMemWord(ES, DI, AX);
                        if (_flags.DF)
                            DI -= 2;
                        else
                            DI += 2;
                        HandleRepeat(false);
                    }
                    _stringOperation = Repeat.None;
                    break;

                // SUB r/m8, reg8
                case 0x28:
                    DoByteOperation(Direction.RegToRm, SubByte, 3, 10);
                    break;

                // SUB r/m16, reg16
                case 0x29:
                    DoWordOperation(Direction.RegToRm, SubWord, 3, 10);
                    break;

                // SUB reg8, r/m8
                case 0x2a:
                    DoByteOperation(Direction.RmToReg, SubByte, 3, 10);
                    break;

                // SUB reg16, r/m16
                case 0x2b:
                    DoWordOperation(Direction.RmToReg, SubWord, 3, 10);
                    break;

                // SUB AL, imm8
                case 0x2c:
                    {
                        ClockCount += 2;
                        var operand = GetMemByte(CS, IP++);
                        AL = SubByte(AL, operand);
                        break;
                    }

                // SUB AX, imm16
                case 0x2d:
                    {
                        ClockCount += 3;
                        var operand = GetMemWord(CS, IP);
                        IP += 2;
                        AX = SubWord(AX, operand);
                        break;
                    }

                // TEST r/m8, reg8
                case 0x84:
                    DoByteOperation(
                        Direction.RegToRm,
                        (value, operand) =>
                        {
                            var result = (byte)(value & operand);
                            _flags.CF = _flags.OF = false;
                            CalcParitySignZeroFlag(result);
                            return 0;
                        },
                        3, 10,
                        false);
                    break;

                // TEST r/m16, reg16
                case 0x85:
                    DoWordOperation(
                        Direction.RegToRm,
                        (value, operand) =>
                        {
                            var result = (ushort)(value & operand);
                            _flags.CF = _flags.OF = false;
                            CalcParitySignZeroFlag(result);
                            return 0;
                        },
                        3, 10,
                        false,
                        false);
                    break;

                // TEST AL, imm8
                case 0xa8:
                    {
                        ClockCount += 3;
                        var operand = GetMemByte(CS, IP++);
                        var result = (byte)(AL & operand);
                        _flags.CF = _flags.OF = false;
                        CalcParitySignZeroFlag(result);
                        break;
                    }

                // TEST AX, imm16
                case 0xa9:
                    {
                        ClockCount += 4;
                        var operand = GetMemWord(CS, IP);
                        IP += 2;
                        var result = (ushort)(AX & operand);
                        _flags.CF = _flags.OF = false;
                        CalcParitySignZeroFlag(result);
                        break;
                    }

                // WAIT
                case 0x9b:
                    ClockCount += 6;
                    // wait for coprocessor: do nothing
                    break;

                // XCHG AX, CX
                case 0x91:
                    {
                        ClockCount += 3;
                        var temp = AX;
                        AX = CX;
                        CX = temp;
                        break;
                    }

                // XCHG AX, DX
                case 0x92:
                    {
                        ClockCount += 3;
                        var temp = AX;
                        AX = DX;
                        DX = temp;
                        break;
                    }

                // XCHG AX, BX
                case 0x93:
                    {
                        ClockCount += 3;
                        var temp = AX;
                        AX = BX;
                        BX = temp;
                        break;
                    }

                // XCHG AX, SP
                case 0x94:
                    {
                        ClockCount += 3;
                        var temp = AX;
                        AX = SP;
                        SP = temp;
                        break;
                    }

                // XCHG AX, BP
                case 0x95:
                    {
                        ClockCount += 3;
                        var temp = AX;
                        AX = BP;
                        BP = temp;
                        break;
                    }

                // XCHG AX, SI
                case 0x96:
                    {
                        ClockCount += 3;
                        var temp = AX;
                        AX = SI;
                        SI = temp;
                        break;
                    }

                // XCHG AX, DI
                case 0x97:
                    {
                        ClockCount += 3;
                        var temp = AX;
                        AX = DI;
                        DI = temp;
                        break;
                    }

                // XCHG reg8, r/m8
                case 0x86:
                    {
                        int mode, reg, rm, rmAddr;
                        ReadAndDecodeAddressByte(out mode, out reg, out rm, out rmAddr);
                        ClockCount += mode == 3 ? 4 : 17;

                        var temp = GetRmByte(mode, rm, rmAddr);
                        SetRmByte(mode, rm, rmAddr, GetRegByte(reg));
                        SetRegByte(reg, temp);
                        break;
                    }

                // XCHG reg16, r/m16
                case 0x87:
                    {
                        int mode, reg, rm, rmAddr;
                        ReadAndDecodeAddressByte(out mode, out reg, out rm, out rmAddr);
                        ClockCount += mode == 3 ? 4 : 17;

                        var temp = GetRmWord(mode, rm, rmAddr);
                        SetRmWord(mode, rm, rmAddr, GetRegWord(reg));
                        SetRegWord(reg, temp);
                        break;
                    }

                // XLAT
                case 0xd7:
                    ClockCount += 11;
                    AL = GetMemByte(DS, _segOverride, (ushort)(BX + AL));
                    break;

                // XOR r/m8, reg8
                case 0x30:
                    DoByteOperation(
                        Direction.RegToRm,
                        (value, operand) =>
                        {
                            var result = (byte)(value ^ operand);
                            _flags.CF = _flags.OF = false;
                            CalcParitySignZeroFlag(result);
                            return result;
                        },
                        3, 10);
                    break;

                // XOR r/m16, reg16
                case 0x31:
                    DoWordOperation(
                        Direction.RegToRm,
                        (value, operand) =>
                        {
                            var result = (ushort)(value ^ operand);
                            _flags.CF = _flags.OF = false;
                            CalcParitySignZeroFlag(result);
                            return result;
                        }, 
                        3, 10);
                    break;

                // XOR reg8, r/m8
                case 0x32:
                    DoByteOperation(
                        Direction.RmToReg,
                        (value, operand) =>
                        {
                            var result = (byte)(value ^ operand);
                            _flags.CF = _flags.OF = false;
                            CalcParitySignZeroFlag(result);
                            return result;
                        },
                        3, 10);
                    break;

                // XOR reg16, r/m16
                case 0x33:
                    DoWordOperation(
                        Direction.RmToReg,
                        (value, operand) =>
                        {
                            var result = (ushort)(value ^ operand);
                            _flags.CF = _flags.OF = false;
                            CalcParitySignZeroFlag(result);
                            return result;
                        },
                        3, 10);
                    break;

                // XOR AL, imm8
                case 0x34:
                    {
                        ClockCount += 3;
                        var operand = GetMemByte(CS, IP++);
                        var result = (byte)(AL ^ operand);
                        _flags.CF = _flags.OF = false;
                        AL = result;
                        CalcParitySignZeroFlag(AL);
                        break;
                    }

                // XOR AX, imm16
                case 0x35:
                    {
                        ClockCount += 4;
                        var operand = GetMemWord(CS, IP);
                        IP += 2;
                        var result = (ushort)(AX ^ operand);
                        _flags.CF = _flags.OF = false;
                        AX = result;
                        CalcParitySignZeroFlag(AX);
                        break;
                    }

                // special opcodes
                case 0xfe:
                    HandleOpcodeFeFf(false);
                    break;

                case 0xff:
                    HandleOpcodeFeFf(true);
                    break;

                case 0x80:
                    HandleOpcode80();
                    break;

                case 0x81:
                    HandleOpcode81();
                    break;

                case 0x83:
                    HandleOpcode83();
                    break;

                case 0xf6:
                    HandleOpcodeF6();
                    break;

                case 0xf7:
                    HandleOpcodeF7();
                    break;

                // RCL/RCR/ROL/ROR/SAL/SAR/SHL/SHR r/m8, 1
                case 0xd0:
                    HandleOpcodeD0();
                    break;

                // RCL/RCR/ROL/ROR/SAL/SAR/SHL/SHR r/m16, 1
                case 0xd1:
                    HandleOpcodeD1();
                    break;

                // RCL/RCR/ROL/ROR/SAL/SAR/SHL/SHR r/m8, CL
                case 0xd2:
                    HandleOpcodeD2();
                    break;

                // RCL/RCR/ROL/ROR/SAL/SAR/SHL/SHR r/m16, CL
                case 0xd3:
                    HandleOpcodeD3();
                    break;

                // RCL/RCR/ROL/ROR/SAL/SAR/SHL/SHR r/m8, imm8 (80186+)
                case 0xC0:
                    HandleOpcodeC0();
                    break;

                // RCL/RCR/ROL/ROR/SAL/SAR/SHL/SHR r/m16, imm8 (80186+)
                case 0xC1:
                    HandleOpcodeC1();
                    break;

                // FPU instructions
                case 0xD8:
                case 0xD9:
                case 0xDA:
                case 0xDB:
                case 0xDC:
                case 0xDD:
                case 0xDE:
                case 0xDF:
                    HandleFpuInstruction(opCode);
                    break;

                default:
                    HandleIllegalOpcode();
                    break;
            }

            if (_segOverride != SegOverride.None)
            {
                HandleIllegalOpcode();
                ClearSegOverride();
            }

            if (_blockInterrupt)
                _blockInterrupt = false;
            else
            {
                if (_flags.TF)
                    DoSoftInterrupt(1);

                if (_softInterrupt != null || _hardInterrupt != null)
                    ProcessInterrupt();
            }

            if ((InstCount & 0x0F) == 0)
                HandleCpuEvents();
            InstCount++;
        }

        private void HandleIllegalOpcode()
        {
            IP = _instStartIp;
            DoSoftInterrupt(6);
        }

        // ReSharper disable once UnusedParameter.Local
        private void HandleFpuInstruction(ushort opCode)
        {
            ClockCount += 3;

            var cmd = GetMemByte(CS, IP++);
            if (cmd < 0xC0)
            {
                IP--;
                int mode, reg, rm, rmAddr;
                ReadAndDecodeAddressByte(out mode, out reg, out rm, out rmAddr);
            }
        }

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        private void HandleCpuEvents()
        {
            lock (_cpuEvents)
            {
                for (var idx = _cpuEvents.Count - 1; idx >= 0; idx--)
                {
                    var cpuEvent = _cpuEvents[idx];
                    if (cpuEvent.ClockCount <= ClockCount)
                    {
                        cpuEvent.Action();
                        _cpuEvents.RemoveAt(idx);
                    }
                }
            }
        }

        /// <summary>
        ///     handle string operations
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        private void HandleRepeat(bool checkZeroFlag)
        {
            if (_stringOperation != Repeat.None)
            {
                CX--;
                if (CheckRepeat(checkZeroFlag))
                    IP = _repeatOffset;
            }
        }

        /// <summary>
        /// check repeat condition
        /// </summary>
        /// <param name="checkZeroFlag"></param>
        /// <returns></returns>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        private bool CheckRepeat(bool checkZeroFlag)
        {
            return CX != 0 && 
                (!checkZeroFlag || (_stringOperation == Repeat.RepZ && _flags.ZF) || (_stringOperation == Repeat.RepNz && !_flags.ZF));
        }

        /// <summary>
        ///     process interrupt
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        private void ProcessInterrupt()
        {
            // interrupts
            // 00: divide by zero
            // 01: single step
            // 02: NMI
            // 03: 1-byte INT/breakpoint
            // 04: overflow
            // 08-0F: IRQ0-IRQ7

            int interrupt;
            if (_softInterrupt != null)
            {
                interrupt = _softInterrupt.Value;
                _softInterrupt = null;
                PushWord(_flags.Value);
            }
            else if (_hardInterrupt != null && _flags.IF)
            {
                ClockCount += 40;

                if (Halt)
                {
                    Halt = false;
                    IP++;
                }

                interrupt = _hardInterrupt.Value;
                _hardInterrupt = null;
                PushWord(_flags.Value);
                _flags.IF = false;
            }
            else
                return;

            _flags.TF = false;
            PushWord(CS);
            PushWord(IP);

            IP = _memoryProvider.PeekW(interrupt * 4);
            CS = _memoryProvider.PeekW(interrupt * 4 + 2);
        }

        /// <summary>
        ///     handle opcodes 0xFE and 0xFF
        /// </summary>
        /// <param name="wordOperation"></param>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        private void HandleOpcodeFeFf(bool wordOperation)
        {
            int mode, reg, rm, rmAddr;
            ReadAndDecodeAddressByte(out mode, out reg, out rm, out rmAddr);

            switch (reg)
            {
                // INC r/m8, r/m16
                case 0:
                    ClockCount += mode == 3 ? 3 : 15;

                    if (wordOperation)
                    {
                        var value = GetRmWord(mode, rm, rmAddr);
                        value++;
                        SetRmWord(mode, rm, rmAddr, value);

                        CalcParitySignZeroFlag(value);
                        _flags.OF = value == 0x8000;
                        _flags.AF = (value & 0x0f) == 0;
                    }
                    else
                    {
                        var value = GetRmByte(mode, rm, rmAddr);
                        value++;
                        SetRmByte(mode, rm, rmAddr, value);

                        CalcParitySignZeroFlag(value);
                        _flags.OF = value == 0x80;
                        _flags.AF = (value & 0x0f) == 0;
                    }
                    break;

                // DEC r/m8, r/m16
                case 1:
                    ClockCount += mode == 3 ? 3 : 15;

                    if (wordOperation)
                    {
                        var value = GetRmWord(mode, rm, rmAddr);
                        value--;
                        SetRmWord(mode, rm, rmAddr, value);

                        CalcParitySignZeroFlag(value);
                        _flags.OF = value == 0x7fff;
                        _flags.AF = (value & 0x0f) == 0x0f;
                    }
                    else
                    {
                        var value = GetRmByte(mode, rm, rmAddr);
                        value--;
                        SetRmByte(mode, rm, rmAddr, value);

                        CalcParitySignZeroFlag(value);
                        _flags.OF = value == 0x7f;
                        _flags.AF = (value & 0x0f) == 0x0f;
                    }
                    break;

                // CALL near r/m
                case 2:
                    ClockCount += mode == 3 ? 13 : 19;
                    PushWord(IP);
                    IP = GetRmWord(mode, rm, rmAddr);
                    break;

                // CALL far r/m
                case 3:
                    {
                        ClockCount += 38;

                        if (mode == 3)
                            HandleIllegalOpcode();
                        else
                        {
                            PushWord(CS);
                            PushWord(IP);
                            var destOffs = _memoryProvider.PeekW(rmAddr);
                            rmAddr += 2;
                            var destSeg = _memoryProvider.PeekW(rmAddr);
                            CS = destSeg;
                            IP = destOffs;
                        }
                    }
                    break;

                // JMP near r/m16
                case 4:
                    ClockCount += mode == 3 ? 11 : 17;
                    IP = GetRmWord(mode, rm, rmAddr);
                    break;

                // JMP far r/m16
                case 5:
                    {
                        ClockCount += 26;

                        if (mode == 3)
                            HandleIllegalOpcode();
                        else
                        {
                            var destOffs = _memoryProvider.PeekW(rmAddr);
                            rmAddr += 2;
                            var destSeg = _memoryProvider.PeekW(rmAddr);
                            CS = destSeg;
                            IP = destOffs;
                        }
                    }
                    break;

                // PUSH r/m16
                case 6:
                    ClockCount += 16;
                    PushWord(GetRmWord(mode, rm, rmAddr));
                    break;

                default:
                    HandleIllegalOpcode();
                    break;
            }
        }

        /// <summary>
        ///     handle opcode 0x80
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        private void HandleOpcode80()
        {
            int mode, reg, rm, rmAddr;
            ReadAndDecodeAddressByte(out mode, out reg, out rm, out rmAddr);

            switch (reg)
            {
                // ADD r/m8, imm8
                case 0:
                    {
                        ClockCount += mode == 3 ? 4 : 16;

                        var value = GetRmByte(mode, rm, rmAddr);
                        var operand = GetMemByte(CS, IP++);
                        var result = AddByte(value, operand);
                        SetRmByte(mode, rm, rmAddr, result);
                        break;
                    }

                // OR r/m8, imm8
                case 1:
                    {
                        ClockCount += mode == 3 ? 4 : 16;

                        var value = GetRmByte(mode, rm, rmAddr);
                        var operand = GetMemByte(CS, IP++);
                        var result = (byte)(value | operand);
                        _flags.CF = _flags.OF = false;
                        CalcParitySignZeroFlag(result);

                        SetRmByte(mode, rm, rmAddr, result);
                        break;
                    }

                // ADC r/m8, imm8
                case 2:
                    {
                        ClockCount += mode == 3 ? 4 : 16;

                        var value = GetRmByte(mode, rm, rmAddr);
                        var operand = GetMemByte(CS, IP++);
                        var result = AdcByte(value, operand);

                        SetRmByte(mode, rm, rmAddr, result);
                        break;
                    }

                // SBB r/m8, imm8
                case 3:
                    {
                        ClockCount += mode == 3 ? 4 : 16;

                        var value = GetRmByte(mode, rm, rmAddr);
                        var operand = GetMemByte(CS, IP++);
                        var result = SbbByte(value, operand);

                        SetRmByte(mode, rm, rmAddr, result);
                        break;
                    }

                // AND r/m8, imm8
                case 4:
                    {
                        ClockCount += mode == 3 ? 4 : 16;

                        var value = GetRmByte(mode, rm, rmAddr);
                        var operand = GetMemByte(CS, IP++);
                        var result = (byte)(value & operand);
                        _flags.CF = _flags.OF = false;
                        CalcParitySignZeroFlag(result);

                        SetRmByte(mode, rm, rmAddr, result);
                        break;
                    }

                // SUB r/m8, imm8
                case 5:
                    {
                        ClockCount += mode == 3 ? 4 : 16;

                        var value = GetRmByte(mode, rm, rmAddr);
                        var operand = GetMemByte(CS, IP++);
                        var result = SubByte(value, operand);

                        SetRmByte(mode, rm, rmAddr, result);
                        break;
                    }

                // XOR r/m8, imm8
                case 6:
                    {
                        ClockCount += mode == 3 ? 4 : 16;

                        var value = GetRmByte(mode, rm, rmAddr);
                        var operand = GetMemByte(CS, IP++);
                        var result = (byte)(value ^ operand);
                        _flags.CF = _flags.OF = false;
                        CalcParitySignZeroFlag(result);

                        SetRmByte(mode, rm, rmAddr, result);
                        break;
                    }

                // CMP r/m8, imm8
                case 7:
                    {
                        ClockCount += mode == 3 ? 3 : 10;

                        var value = GetRmByte(mode, rm, rmAddr);
                        var operand = GetMemByte(CS, IP++);
                        SubByte(value, operand);
                        break;
                    }

                default:
                    HandleIllegalOpcode();
                    break;

            }
        }

        /// <summary>
        ///     handle opcode 0x81
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        private void HandleOpcode81()
        {
            int mode, reg, rm, rmAddr;
            ReadAndDecodeAddressByte(out mode, out reg, out rm, out rmAddr);

            switch (reg)
            {
                // ADD r/m16, imm16
                case 0:
                    {
                        ClockCount += mode == 3 ? 4 : 16;

                        var value = GetRmWord(mode, rm, rmAddr);
                        var operand = GetMemWord(CS, IP);
                        IP += 2;
                        var result = AddWord(value, operand);

                        SetRmWord(mode, rm, rmAddr, result);
                        break;
                    }

                // OR r/m16, imm16
                case 1:
                    {
                        ClockCount += mode == 3 ? 4 : 16;

                        var value = GetRmWord(mode, rm, rmAddr);
                        var operand = GetMemWord(CS, IP);
                        IP += 2;
                        var result = (ushort)(value | operand);
                        _flags.CF = _flags.OF = false;
                        CalcParitySignZeroFlag(result);

                        SetRmWord(mode, rm, rmAddr, result);
                    }
                    break;

                // ADC r/m16, imm16
                case 2:
                    {
                        ClockCount += mode == 3 ? 4 : 16;

                        var value = GetRmWord(mode, rm, rmAddr);
                        var operand = GetMemWord(CS, IP);
                        IP += 2;
                        var result = AdcWord(value, operand);

                        SetRmWord(mode, rm, rmAddr, result);
                        break;
                    }

                // SBB r/m16, imm16
                case 3:
                    {
                        ClockCount += mode == 3 ? 4 : 16;

                        var value = GetRmWord(mode, rm, rmAddr);
                        var operand = GetMemWord(CS, IP);
                        IP += 2;
                        var result = SbbWord(value, operand);

                        SetRmWord(mode, rm, rmAddr, result);
                        break;
                    }

                // AND r/m16, imm16
                case 4:
                    {
                        ClockCount += mode == 3 ? 4 : 16;

                        var value = GetRmWord(mode, rm, rmAddr);
                        var operand = GetMemWord(CS, IP);
                        IP += 2;
                        var result = (ushort)(value & operand);
                        _flags.CF = _flags.OF = false;
                        CalcParitySignZeroFlag(result);

                        SetRmWord(mode, rm, rmAddr, result);
                        break;
                    }

                // SUB r/m16, imm16
                case 5:
                    {
                        ClockCount += mode == 3 ? 4 : 16;

                        var value = GetRmWord(mode, rm, rmAddr);
                        var operand = GetMemWord(CS, IP);
                        IP += 2;
                        var result = SubWord(value, operand);
                        SetRmWord(mode, rm, rmAddr, result);
                        break;
                    }

                // XOR r/m16, imm16
                case 6:
                    {
                        ClockCount += mode == 3 ? 4 : 16;

                        var value = GetRmWord(mode, rm, rmAddr);
                        var operand = GetMemWord(CS, IP);
                        IP += 2;
                        var result = (ushort)(value ^ operand);
                        _flags.CF = _flags.OF = false;
                        CalcParitySignZeroFlag(result);

                        SetRmWord(mode, rm, rmAddr, result);
                        break;
                    }

                // CMP r/m16, imm16
                case 7:
                    {
                        ClockCount += mode == 3 ? 3 : 10;

                        var value = GetRmWord(mode, rm, rmAddr);
                        var operand = GetMemWord(CS, IP);
                        IP += 2;
                        SubWord(value, operand);
                        break;
                    }

                default:
                    HandleIllegalOpcode();
                    break;

            }
        }

        /// <summary>
        ///     handle opcode 0x83
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        private void HandleOpcode83()
        {
            int mode, reg, rm, rmAddr;
            ReadAndDecodeAddressByte(out mode, out reg, out rm, out rmAddr);

            switch (reg)
            {
                // ADD r/m16, imm8
                case 0:
                    {
                        ClockCount += mode == 3 ? 4 : 16;

                        var value = GetRmWord(mode, rm, rmAddr);
                        var byteOperand = GetMemByte(CS, IP++);
                        var operand = (ushort)(byteOperand > 127 ? byteOperand + 0xff00 : byteOperand);
                        var result = AddWord(value, operand);

                        SetRmWord(mode, rm, rmAddr, result);
                        break;
                    }

                // OR r/m16, imm8
                case 1:
                    {
                        ClockCount += mode == 3 ? 4 : 16;

                        var value = GetRmWord(mode, rm, rmAddr);
                        var byteOperand = GetMemByte(CS, IP++);
                        var operand = (ushort)(byteOperand > 127 ? byteOperand + 0xff00 : byteOperand);
                        var result = (ushort)(value | operand);
                        _flags.CF = _flags.OF = false;
                        CalcParitySignZeroFlag(result);

                        SetRmWord(mode, rm, rmAddr, result);
                        break;
                    }

                // ADC r/m16, imm8
                case 2:
                    {
                        ClockCount += mode == 3 ? 4 : 16;

                        var value = GetRmWord(mode, rm, rmAddr);
                        var byteOperand = GetMemByte(CS, IP++);
                        var operand = (ushort)(byteOperand > 127 ? byteOperand + 0xff00 : byteOperand);
                        var result = AdcWord(value, operand);

                        SetRmWord(mode, rm, rmAddr, result);
                        break;
                    }

                // SBB r/m16, imm8
                case 3:
                    {
                        ClockCount += mode == 3 ? 4 : 16;

                        var value = GetRmWord(mode, rm, rmAddr);
                        var byteOperand = GetMemByte(CS, IP++);
                        var operand = (ushort)(byteOperand > 127 ? byteOperand + 0xff00 : byteOperand);
                        var result = SbbWord(value, operand);

                        SetRmWord(mode, rm, rmAddr, result);
                        break;
                    }

                // AND r/m16, imm8
                case 4:
                    {
                        ClockCount += mode == 3 ? 4 : 16;

                        var value = GetRmWord(mode, rm, rmAddr);
                        var byteOperand = GetMemByte(CS, IP++);
                        var operand = (ushort)(byteOperand > 127 ? byteOperand + 0xff00 : byteOperand); // sign-extended!
                        var result = (ushort)(value & operand);
                        _flags.CF = _flags.OF = false;
                        CalcParitySignZeroFlag(result);

                        SetRmWord(mode, rm, rmAddr, result);
                        break;
                    }

                // SUB r/m16, imm8
                case 5:
                    {
                        ClockCount += mode == 3 ? 4 : 16;

                        var value = GetRmWord(mode, rm, rmAddr);
                        var byteOperand = GetMemByte(CS, IP++);
                        var operand = (ushort)(byteOperand > 127 ? byteOperand + 0xff00 : byteOperand);
                        var result = SubWord(value, operand);

                        SetRmWord(mode, rm, rmAddr, result);
                        break;
                    }

                // XOR r/m16, imm8
                case 6:
                    {
                        ClockCount += mode == 3 ? 4 : 16;

                        var value = GetRmWord(mode, rm, rmAddr);
                        var byteOperand = GetMemByte(CS, IP++);
                        var operand = (ushort)(byteOperand > 127 ? byteOperand + 0xff00 : byteOperand);
                        var result = (ushort)(value ^ operand);
                        _flags.CF = _flags.OF = false;
                        CalcParitySignZeroFlag(result);

                        SetRmWord(mode, rm, rmAddr, result);
                        break;
                    }

                // CMP r/m16, imm8
                case 7:
                    {
                        ClockCount += mode == 3 ? 3 : 10;

                        var value = GetRmWord(mode, rm, rmAddr);
                        var byteOperand = GetMemByte(CS, IP++);
                        var operand = (ushort)(byteOperand > 127 ? byteOperand + 0xff00 : byteOperand);
                        SubWord(value, operand);
                        break;
                    }

                default:
                    HandleIllegalOpcode();
                    break;
            }
        }

        /// <summary>
        ///     handle opcode 0xf6
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        private void HandleOpcodeF6()
        {
            int mode, reg, rm, rmAddr;
            ReadAndDecodeAddressByte(out mode, out reg, out rm, out rmAddr);

            switch (reg)
            {
                // TEST r/m8, imm8
                case 0:
                    {
                        ClockCount += mode == 3 ? 4 : 10;

                        var operand = GetMemByte(CS, IP++);
                        var result = (byte)(GetRmByte(mode, rm, rmAddr) & operand);
                        _flags.CF = _flags.OF = false;
                        CalcParitySignZeroFlag(result);
                        break;
                    }

                // NOT r/m8
                case 2:
                    {
                        ClockCount += mode == 3 ? 3 : 10;

                        var value = GetRmByte(mode, rm, rmAddr);
                        value = (byte)~value;
                        SetRmByte(mode, rm, rmAddr, value);
                        break;
                    }

                // NEG r/m8
                case 3:
                    {
                        ClockCount += mode == 3 ? 3 : 10;

                        // substract operand from 0
                        var value = GetRmByte(mode, rm, rmAddr);
                        var result = SubByte(0, value);
                        SetRmByte(mode, rm, rmAddr, result);
                        break;
                    }

                // MUL r/m8
                case 4:
                    {
                        ClockCount += mode == 3 ? 27 : 33;

                        var result = AL * GetRmByte(mode, rm, rmAddr);
                        _flags.CF = _flags.OF = result > 0xff;
                        _flags.ZF = false; // reset zero flag, otherwise the cpu could be detected as NEC V20
                        AX = (ushort)result;
                        break;
                    }

                // IMUL r/m8
                case 5:
                    {
                        ClockCount += mode == 3 ? 27 : 33;

                        var result = (sbyte)AL * (sbyte)GetRmByte(mode, rm, rmAddr);
                        AX = (ushort)result;
                        _flags.CF = _flags.OF = AH != 0 && AH != 0xff;
                        _flags.ZF = false; // reset zero flag, otherwise the cpu could be detected as NEC V20
                        break;
                    }

                // DIV r/m8
                case 6:
                    {
                        ClockCount += mode == 3 ? 29 : 35;

                        var dividend = AX;
                        var divisor = GetRmByte(mode, rm, rmAddr);
                        if (divisor == 0)
                            DoSoftInterrupt(0);
                        else
                        {
                            AL = (byte)(dividend / divisor);
                            AH = (byte)(dividend % divisor);
                        }
                        break;
                    }

                // IDIV r/m8
                case 7:
                    {
                        ClockCount += mode == 3 ? 48 : 54;

                        var dividend = (Int16)AX;
                        var divisor = (sbyte)GetRmByte(mode, rm, rmAddr);
                        if (divisor == 0)
                            DoSoftInterrupt(0);
                        else
                        {
                            AL = (byte)(dividend / divisor);
                            AH = (byte)(dividend % divisor);
                        }
                        break;
                    }

                default:
                    HandleIllegalOpcode();
                    break;
            }
        }

        /// <summary>
        ///     handle opcode 0xf7
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        private void HandleOpcodeF7()
        {
            int mode, reg, rm, rmAddr;
            ReadAndDecodeAddressByte(out mode, out reg, out rm, out rmAddr);

            switch (reg)
            {
                // TEST r/m16, imm16
                case 0:
                    {
                        ClockCount += mode == 3 ? 4 : 10;

                        var operand = GetMemWord(CS, IP);
                        IP += 2;
                        var result = (ushort)(GetRmWord(mode, rm, rmAddr) & operand);
                        _flags.CF = _flags.OF = false;
                        CalcParitySignZeroFlag(result);
                        break;
                    }

                // NOT r/m16
                case 2:
                    {
                        ClockCount += mode == 3 ? 3 : 10;

                        var value = GetRmWord(mode, rm, rmAddr);
                        value = (ushort)~value;
                        SetRmWord(mode, rm, rmAddr, value);
                        break;
                    }

                // NEG r/m16
                case 3:
                    {
                        ClockCount += mode == 3 ? 3 : 10;

                        // substract operand from 0
                        var value = GetRmWord(mode, rm, rmAddr);
                        var result = SubWord(0, value);
                        SetRmWord(mode, rm, rmAddr, result);
                        break;

                    }

                // MUL r/m16
                case 4:
                    {
                        ClockCount += mode == 3 ? 36 : 42;

                        var result = AX * (UInt32)GetRmWord(mode, rm, rmAddr);
                        _flags.CF = _flags.OF = result > 0xffff;
                        _flags.ZF = false; // reset zero flag, otherwise the cpu could be detected as NEC V20
                        AX = (ushort)(result & 0xffff);
                        DX = (ushort)((result & 0xffff0000) >> 16);
                        break;
                    }

                // IMUL r/m16
                case 5:
                    {
                        ClockCount += mode == 3 ? 36 : 42;

                        var result = (Int16)AX * (Int16)GetRmWord(mode, rm, rmAddr);
                        AX = (ushort)(result & 0xffff);
                        DX = (ushort)((result & 0xffff0000) >> 16);
                        _flags.CF = _flags.OF = DX != 0 && DX != 0xffff;
                        _flags.ZF = false; // reset zero flag, otherwise the cpu could be detected as NEC V20
                        break;
                    }

                // DIV r/m16
                case 6:
                    {
                        ClockCount += mode == 3 ? 38 : 44;

                        var dividend = (UInt32)((DX << 16) + AX);
                        var divisor = GetRmWord(mode, rm, rmAddr);
                        if (divisor == 0)
                            _softInterrupt = 0;
                        else
                        {
                            AX = (ushort)(dividend / divisor);
                            DX = (ushort)(dividend % divisor);
                        }
                        break;
                    }

                // IDIV r/m16
                case 7:
                    {
                        ClockCount += mode == 3 ? 57 : 63;

                        var dividend = (DX << 16) + AX;
                        var divisor = (Int16)GetRmWord(mode, rm, rmAddr);
                        if (divisor == 0)
                            _softInterrupt = 0;
                        else
                        {
                            AX = (ushort)(dividend / divisor);
                            DX = (ushort)(dividend % divisor);
                        }
                        break;
                    }

                default:
                    HandleIllegalOpcode();
                    break;
            }
        }

        /// <summary>
        ///     handle opcode 0xd0
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        private void HandleOpcodeD0()
        {
            int mode, reg, rm, rmAddr;
            ReadAndDecodeAddressByte(out mode, out reg, out rm, out rmAddr);

            ClockCount += mode == 3 ? 2 : 15;

            switch (reg)
            {
                // ROL r/m8, 1
                case 0:
                    {
                        var value = GetRmByte(mode, rm, rmAddr);
                        var newValue = (byte)((value << 1) | (value >> 7));
                        SetRmByte(mode, rm, rmAddr, newValue);
                        _flags.OF = (value & 0x80) != (newValue & 0x80);
                        _flags.CF = (value & 0x80) > 0;
                        break;
                    }

                // ROR r/m8, 1
                case 1:
                    {
                        var value = GetRmByte(mode, rm, rmAddr);
                        var newValue = (byte)((value >> 1) | (value << 7));
                        SetRmByte(mode, rm, rmAddr, newValue);
                        _flags.OF = (value & 0x80) != (newValue & 0x80);
                        _flags.CF = (value & 0x01) > 0;
                        break;
                    }

                // RCL r/m8, 1
                case 2:
                    {
                        var value = GetRmByte(mode, rm, rmAddr);
                        var newValue = (byte)((value << 1) + (_flags.CF ? 1 : 0));
                        SetRmByte(mode, rm, rmAddr, newValue);
                        _flags.OF = (value & 0x80) != (newValue & 0x80);
                        _flags.CF = (value & 0x80) > 0;
                        break;
                    }

                // RCR r/m8, 1
                case 3:
                    {
                        var value = GetRmByte(mode, rm, rmAddr);
                        var newValue = (byte)((value >> 1) + (_flags.CF ? 0x80 : 0));
                        SetRmByte(mode, rm, rmAddr, newValue);
                        _flags.OF = (value & 0x80) != (newValue & 0x80);
                        _flags.CF = (value & 0x01) > 0;
                        break;
                    }

                // SHL r/m8, 1
                case 4:
                    {
                        // OF = 0: operand keeps original sign
                        // CF: bit shifted out
                        var value = GetRmByte(mode, rm, rmAddr);
                        var newValue = (byte)(value << 1);
                        SetRmByte(mode, rm, rmAddr, newValue);
                        CalcParitySignZeroFlag(newValue);
                        _flags.OF = (value & 0x80) != (newValue & 0x80);
                        _flags.CF = (value & 0x80) > 0;
                        break;
                    }

                // SHR r/m8, 1
                case 5:
                    {
                        // OF = 0: operand keeps original sign
                        // CF: bit shifted out
                        var value = GetRmByte(mode, rm, rmAddr);
                        var newValue = (byte)(value >> 1);
                        SetRmByte(mode, rm, rmAddr, newValue);
                        CalcParitySignZeroFlag(newValue);
                        _flags.OF = (value & 0x80) != (newValue & 0x80);
                        _flags.CF = (value & 0x01) > 0;
                        break;
                    }

                // SAR r/m8, 1
                case 7:
                    {
                        // OF = 0: operand keeps original sign
                        // CF: bit shifted out
                        var value = GetRmByte(mode, rm, rmAddr);
                        var neg = value & 0x80;
                        var newValue = (byte)((value >> 1) | neg);
                        SetRmByte(mode, rm, rmAddr, newValue);
                        CalcParitySignZeroFlag(newValue);
                        _flags.OF = false;
                        _flags.CF = (value & 0x01) > 0;
                        break;
                    }

                default:
                    HandleIllegalOpcode();
                    break;
            }
        }

        /// <summary>
        ///     handle opcode 0xd1
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        private void HandleOpcodeD1()
        {
            int mode, reg, rm, rmAddr;
            ReadAndDecodeAddressByte(out mode, out reg, out rm, out rmAddr);

            ClockCount += mode == 3 ? 2 : 15;

            switch (reg)
            {
                // ROL r/m16, 1
                case 0:
                    {
                        var value = GetRmWord(mode, rm, rmAddr);
                        var newValue = (ushort)((value << 1) | (value >> 15));
                        SetRmWord(mode, rm, rmAddr, newValue);
                        _flags.OF = (value & 0x8000) != (newValue & 0x8000);
                        _flags.CF = (value & 0x8000) > 0;
                        break;
                    }

                // ROR r/m16, 1
                case 1:
                    {
                        var value = GetRmWord(mode, rm, rmAddr);
                        var newValue = (ushort)((value >> 1) | (value << 15));
                        SetRmWord(mode, rm, rmAddr, newValue);
                        _flags.OF = (value & 0x8000) != (newValue & 0x8000);
                        _flags.CF = (value & 0x0001) > 0;
                        break;
                    }

                // RCL r/m16, 1
                case 2:
                    {
                        var value = GetRmWord(mode, rm, rmAddr);
                        var newValue = (ushort)((value << 1) + (_flags.CF ? 1 : 0));
                        SetRmWord(mode, rm, rmAddr, newValue);
                        _flags.OF = (value & 0x8000) != (newValue & 0x8000);
                        _flags.CF = (value & 0x8000) > 0;
                        break;
                    }

                // RCR r/m16, 1
                case 3:
                    {
                        var value = GetRmWord(mode, rm, rmAddr);
                        var newValue = (ushort)((value >> 1) + (_flags.CF ? 0x8000 : 0));
                        SetRmWord(mode, rm, rmAddr, newValue);
                        _flags.OF = (value & 0x8000) != (newValue & 0x8000);
                        _flags.CF = (value & 0x0001) > 0;
                        break;
                    }

                // SHL r/m16, 1
                case 4:
                    {
                        // OF = 0: operand keeps original sign
                        // CF: bit shifted out
                        var value = GetRmWord(mode, rm, rmAddr);
                        var newValue = (ushort)(GetRmWord(mode, rm, rmAddr) << 1);
                        SetRmWord(mode, rm, rmAddr, newValue);
                        CalcParitySignZeroFlag(newValue);
                        _flags.OF = (value & 0x8000) != (newValue & 0x8000);
                        _flags.CF = (value & 0x8000) > 0;
                        break;
                    }

                // SHR r/m16, 1
                case 5:
                    {
                        // OF = 0: operand keeps original sign
                        // CF: bit shifted out
                        var value = GetRmWord(mode, rm, rmAddr);
                        var newValue = (ushort)(value >> 1);
                        SetRmWord(mode, rm, rmAddr, newValue);
                        CalcParitySignZeroFlag(newValue);
                        _flags.OF = (value & 0x8000) != (newValue & 0x8000);
                        _flags.CF = (value & 0x0001) > 0;
                        break;
                    }

                // SAR r/m16, 1
                case 7:
                    {
                        // OF = 0: operand keeps original sign
                        // CF: bit shifted out
                        var value = GetRmWord(mode, rm, rmAddr);
                        var neg = value & 0x8000;
                        var newValue = (ushort)((value >> 1) | neg);
                        SetRmWord(mode, rm, rmAddr, newValue);
                        CalcParitySignZeroFlag(newValue);
                        _flags.OF = false;
                        _flags.CF = (value & 0x0001) > 0;
                        break;
                    }

                default:
                    HandleIllegalOpcode();
                    break;

            }
        }

        /// <summary>
        ///     handle opcode 0xC0
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        private void HandleOpcodeC0()
        {
            int mode, reg, rm, rmAddr;
            ReadAndDecodeAddressByte(out mode, out reg, out rm, out rmAddr);

            var count = GetMemByte(CS, IP++) & 0x1F;
              
            ClockCount += mode == 3 ? 5 + count : 17 + count;

            switch (reg)
            {
                // ROL r/m8, imm8 (80186+)
                case 0:
                    RolByte(mode, rm, rmAddr, count);
                    break;

                // ROR r/m8, imm8 (80186+)
                case 1:
                    RorByte(mode, rm, rmAddr, count);
                    break;

                // RCL r/m8, imm8 (80186+)
                case 2:
                    RclByte(mode, rm, rmAddr, count);
                    break;

                // RCR r/m8, imm8 (80186+)
                case 3:
                    RcrByte(mode, rm, rmAddr, count);
                    break;

                // SHL r/m8, imm8 (80186+)
                case 4:
                    ShlByte(mode, rm, rmAddr, count);
                    break;

                // SHR r/m8, imm8 (80186+)
                case 5:
                    ShrByte(mode, rm, rmAddr, count);
                    break;

                // SAR r/m8, imm8 (80186+)
                case 7:
                    SarByte(mode, rm, rmAddr, count);
                    break;

                default:
                    HandleIllegalOpcode();
                    break;
            }
        }

        /// <summary>
        ///     handle opcode 0xC1
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        private void HandleOpcodeC1()
        {
            int mode, reg, rm, rmAddr;
            ReadAndDecodeAddressByte(out mode, out reg, out rm, out rmAddr);

            var count = GetMemByte(CS, IP++);

            ClockCount += mode == 3 ? 5 + count : 17 + count;

            switch (reg)
            {
                // ROL r/m16, imm8 (80186+)
                case 0:
                    RolWord(mode, rm, rmAddr, count);
                    break;

                // ROR r/m16, imm8 (80186+)
                case 1:
                    RorWord(mode, rm, rmAddr, count);
                    break;

                // RCL r/m16, imm8 (80186+)
                case 2:
                    RclWord(mode, rm, rmAddr, count);
                    break;

                // RCR r/m16, imm8 (80186+)
                case 3:
                    RcrWord(mode, rm, rmAddr, count);
                    break;

                // SHL r/m16, imm8 (80186+)
                case 4:
                    ShlWord(mode, rm, rmAddr, count);
                    break;

                // SHR r/m16, imm8 (80186+)
                case 5:
                    ShrWord(mode, rm, rmAddr, count);
                    break;

                // SAR r/m16, imm8 (80186+)
                case 7:
                    SarWord(mode, rm, rmAddr, count);
                    break;

                default:
                    HandleIllegalOpcode();
                    break;
            }
        }

        /// <summary>
        ///     handle opcode 0xd2
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        private void HandleOpcodeD2()
        {
            int mode, reg, rm, rmAddr;
            ReadAndDecodeAddressByte(out mode, out reg, out rm, out rmAddr);

            ClockCount += mode == 3 ? 5 + CL : 17 + CL;

            switch (reg)
            {
                // ROL r/m8, CL
                case 0:
                    RolByte(mode, rm, rmAddr, CL);
                    break;

                // ROR r/m8, CL
                case 1:
                    RorByte(mode, rm, rmAddr, CL);
                    break;

                // RCL r/m8, CL
                case 2:
                    RclByte(mode, rm, rmAddr, CL);
                    break;

                // RCR r/m8, CL
                case 3:
                    RcrByte(mode, rm, rmAddr, CL);
                    break;

                // SHL r/m8, CL
                case 4:
                    ShlByte(mode, rm, rmAddr, CL);
                    break;

                // SHR r/m8, CL
                case 5:
                    ShrByte(mode, rm, rmAddr, CL);
                    break;

                // SAR r/m8, CL
                case 7:
                    SarByte(mode, rm, rmAddr, CL);
                    break;

                default:
                    HandleIllegalOpcode();
                    break;
            }
        }

        /// <summary>
        ///     handle opcode 0xd3
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        private void HandleOpcodeD3()
        {
            int mode, reg, rm, rmAddr;
            ReadAndDecodeAddressByte(out mode, out reg, out rm, out rmAddr);

            ClockCount += mode == 3 ? 5 + CL : 17 + CL;

            switch (reg)
            {
                // ROL r/m16, CL
                case 0:
                    RolWord(mode, rm, rmAddr, CL);
                    break;

                // ROR r/m16, CL
                case 1:
                    RorWord(mode, rm, rmAddr, CL);
                    break;

                // RCL r/m16, CL
                case 2:
                    RclWord(mode, rm, rmAddr, CL);
                    break;

                // RCR r/m16, CL
                case 3:
                    RcrWord(mode, rm, rmAddr, CL);
                    break;

                // SHL r/m16, CL
                case 4:
                    ShlWord(mode, rm, rmAddr, CL);
                    break;

                // SHR r/m16, CL
                case 5:
                    ShrWord(mode, rm, rmAddr, CL);
                    break;

                // SAR r/m16, CL
                case 7:
                    SarWord(mode, rm, rmAddr, CL);
                    break;

                default:
                    HandleIllegalOpcode();
                    break;

            }
        }

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        private void RolByte(int mode, int rm, int rmAddr, int count)
        {
            var bits = count & 0x07;
            var value = GetRmByte(mode, rm, rmAddr);
            var newValue = (byte)((value << bits) | (value >> 8 - bits));
            SetRmByte(mode, rm, rmAddr, newValue);
            if (bits > 0)
            {
                if (bits == 1)
                    _flags.OF = (value & 0x80) != (newValue & 0x80);
                _flags.CF = (value & (1 << (8 - bits))) > 0;
            }
        }

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        private void RorByte(int mode, int rm, int rmAddr, int count)
        {
            var bits = count & 0x07;
            var value = GetRmByte(mode, rm, rmAddr);
            var newValue = (byte)((value >> bits) | (value << 8 - bits));
            SetRmByte(mode, rm, rmAddr, newValue);
            if (bits > 0)
            {
                if (bits == 1)
                    _flags.OF = (value & 0x80) != (newValue & 0x80);
                _flags.CF = (value & (1 << (bits - 1))) > 0;
            }
        }

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        private void RclByte(int mode, int rm, int rmAddr, int count)
        {
            var bits = (count & 0x1F) % 9;
            var value = GetRmByte(mode, rm, rmAddr);
            var cfValue = (bits > 0 && _flags.CF) ? 1 << bits - 1 : 0;
            var newValue = (byte)((value << bits) | cfValue | (value >> 9 - bits));
            SetRmByte(mode, rm, rmAddr, newValue);
            if (bits > 0)
            {
                if (bits == 1)
                    _flags.OF = (value & 0x80) != (newValue & 0x80);
                _flags.CF = (value & (1 << (8 - bits))) > 0;
            }
        }

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        private void RcrByte(int mode, int rm, int rmAddr, int count)
        {
            var bits = (count & 0x1F) % 9;
            var value = GetRmByte(mode, rm, rmAddr);
            var cfValue = (bits > 0 && _flags.CF) ? 1 << 8 - bits : 0;
            var newValue = (byte)((value >> bits) | cfValue | (value << 9 - bits));
            SetRmByte(mode, rm, rmAddr, newValue);
            if (bits > 0)
            {
                if (bits == 1)
                    _flags.OF = (value & 0x80) != (newValue & 0x80);
                _flags.CF = (value & (1 << (bits - 1))) > 0;
            }
        }

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        private void ShlByte(int mode, int rm, int rmAddr, int count)
        {
            // OF = 0: operand keeps original sign
            // CF: bit shifted out
            var bits = count & 0x1F;
            var value = GetRmByte(mode, rm, rmAddr);
            var newValue = (byte)(value << bits);
            SetRmByte(mode, rm, rmAddr, newValue);
            CalcParitySignZeroFlag(newValue);
            if (bits == 1)
                _flags.OF = (value & 0x80) != (newValue & 0x80);
            _flags.CF = bits <= 8 && (value & (1 << (8 - bits))) > 0;
        }

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        private void ShrByte(int mode, int rm, int rmAddr, int count)
        {
            // OF = 0: operand keeps original sign
            // CF: bit shifted out
            var bits = count & 0x1F;
            var value = GetRmByte(mode, rm, rmAddr);
            var newValue = (byte)(value >> bits);
            SetRmByte(mode, rm, rmAddr, newValue);
            CalcParitySignZeroFlag(newValue);
            if (bits == 1)
                _flags.OF = (value & 0x80) != (newValue & 0x80);
            _flags.CF = bits > 0 && (value & (1 << (bits - 1))) > 0;
        }

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        private void SarByte(int mode, int rm, int rmAddr, int count)
        {
            // OF = 0: operand keeps original sign
            // CF: bit shifted out
            var bits = count & 0x1F;
            var value = GetRmByte(mode, rm, rmAddr);
            var neg = (value & 0x80) > 0 ? 0xff << 8 - bits : 0;
            var newValue = (byte)((value >> bits) | neg);
            SetRmByte(mode, rm, rmAddr, newValue);
            CalcParitySignZeroFlag(newValue);
            _flags.OF = false;
            _flags.CF = bits > 0 && (value & (1 << (bits - 1))) > 0;
        }

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        private void RolWord(int mode, int rm, int rmAddr, int count)
        {
            var bits = count & 0x0f;
            var value = GetRmWord(mode, rm, rmAddr);
            var newValue = (ushort)((value << bits) | (value >> 16 - bits));
            SetRmWord(mode, rm, rmAddr, newValue);
            if (bits > 0)
            {
                if (bits == 1)
                    _flags.OF = (value & 0x8000) != (newValue & 0x8000);
                _flags.CF = (value & (1 << (16 - bits))) > 0;
            }
        }

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        private void RorWord(int mode, int rm, int rmAddr, int count)
        {
            var bits = count & 0x0f;
            var value = GetRmWord(mode, rm, rmAddr);
            var newValue = (ushort)((value >> bits) | (value << 16 - bits));
            SetRmWord(mode, rm, rmAddr, newValue);
            if (bits > 0)
            {
                if (bits == 1)
                    _flags.OF = (value & 0x8000) != (newValue & 0x8000);
                _flags.CF = (value & (1 << (bits - 1))) > 0;
            }
        }

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        private void RclWord(int mode, int rm, int rmAddr, int count)
        {
            var bits = (count & 0x1F) % 17;
            var value = GetRmWord(mode, rm, rmAddr);
            var cfValue = (bits > 0 && _flags.CF) ? 1 << bits - 1 : 0;
            var newValue = (ushort)((value << bits) | cfValue | (value >> 17 - bits));
            SetRmWord(mode, rm, rmAddr, newValue);
            if (bits > 0)
            {
                if (bits == 1)
                    _flags.OF = (value & 0x8000) != (newValue & 0x8000);
                _flags.CF = (value & (1 << (16 - bits))) > 0;
            }
        }

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        private void RcrWord(int mode, int rm, int rmAddr, int count)
        {
            var bits = (count & 0x1F) % 17;
            var value = GetRmWord(mode, rm, rmAddr);
            var cfValue = (bits > 0 && _flags.CF) ? 1 << 16 - bits : 0;
            var newValue = (ushort)((value >> bits) | cfValue | (value << 17 - bits));
            SetRmWord(mode, rm, rmAddr, newValue);
            if (bits > 0)
            {
                if (bits == 1)
                    _flags.OF = (value & 0x8000) != (newValue & 0x8000);
                _flags.CF = (value & (1 << (bits - 1))) > 0;
            }
        }

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        private void ShlWord(int mode, int rm, int rmAddr, int count)
        {
            // OF = 0: operand keeps original sign
            // CF: bit shifted out
            var bits = count & 0x1F;
            var value = GetRmWord(mode, rm, rmAddr);
            var newValue = (ushort)(value << bits);
            SetRmWord(mode, rm, rmAddr, newValue);
            CalcParitySignZeroFlag(newValue);
            if (bits == 1)
                _flags.OF = (value & 0x8000) != (newValue & 0x8000);
            _flags.CF = bits <= 16 && (value & (1 << (16 - bits))) > 0;

        }

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        private void ShrWord(int mode, int rm, int rmAddr, int count)
        {
            // OF = 0: operand keeps original sign
            // CF: bit shifted out
            var bits = count & 0x1F;
            var value = GetRmWord(mode, rm, rmAddr);
            var newValue = (ushort)(value >> bits);
            SetRmWord(mode, rm, rmAddr, newValue);
            CalcParitySignZeroFlag(newValue);
            if (bits == 1)
                _flags.OF = (value & 0x8000) != (newValue & 0x8000);
            _flags.CF = bits > 0 && (value & (1 << (bits - 1))) > 0;
        }

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        private void SarWord(int mode, int rm, int rmAddr, int count)
        {
            // OF = 0: operand keeps original sign
            // CF: bit shifted out
            var bits = count & 0x1F;
            var value = GetRmWord(mode, rm, rmAddr);
            var neg = (value & 0x8000) > 0 ? 0xffff << 16 - bits : 0;
            var newValue = (ushort)((value >> bits) | neg);
            SetRmWord(mode, rm, rmAddr, newValue);
            CalcParitySignZeroFlag(newValue);
            _flags.OF = false;
            _flags.CF = bits > 0 && (value & (1 << (bits - 1))) > 0;
        }

        /// <summary>
        ///     substract byte, set all flags accordingly
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        private byte SubByte(byte val1, byte val2)
        {
            var result = val1 - val2;
            var signedResult = (sbyte)val1 - (sbyte)val2;
            _flags.CF = result < 0;
            _flags.OF = signedResult > 127 || signedResult < -128;
            _flags.AF = (val1 & 0x0f) - (val2 & 0x0f) < 0;
            CalcParitySignZeroFlag((byte)result);
            return (byte)result;
        }

        /// <summary>
        ///     substract word, set all flags accordingly
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        private ushort SubWord(ushort val1, ushort val2)
        {
            var result = val1 - val2;
            var signedResult = (short)val1 - (short)val2;
            _flags.CF = result < 0;
            _flags.OF = signedResult > 32767 || signedResult < -32768;
            _flags.AF = (val1 & 0x0f) - (val2 & 0x0f) < 0;
            CalcParitySignZeroFlag((ushort)result);
            return (ushort)result;
        }

        /// <summary>
        ///     substract byte with borrow, set all flags accordingly
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        private byte SbbByte(byte val1, byte val2)
        {
            var borrow = _flags.CF ? 1 : 0;
            var result = val1 - val2 - borrow;
            var signedResult = (sbyte)val1 - (sbyte)val2 - borrow;
            _flags.CF = result < 0;
            _flags.OF = signedResult > 127 || signedResult < -128;
            _flags.AF = (val1 & 0x0f) - (val2 & 0x0f) - borrow < 0;
            CalcParitySignZeroFlag((ushort)result);
            return (byte)result;
        }

        /// <summary>
        ///     substract word with borrow, set all flags accordingly
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        private ushort SbbWord(ushort val1, ushort val2)
        {
            var borrow = _flags.CF ? 1 : 0;
            var result = val1 - val2 - borrow;
            var signedResult = (short)val1 - (short)val2 - borrow;
            _flags.CF = result < 0;
            _flags.OF = signedResult > 32767 || signedResult < -32768;
            _flags.AF = (val1 & 0x0f) - (val2 & 0x0f) - borrow < 0;
            CalcParitySignZeroFlag((ushort)result);
            return (ushort)result;
        }

        /// <summary>
        ///     add byte, set all flags accordingly
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        private byte AddByte(byte val1, byte val2)
        {
            var result = val1 + val2;
            var signedResult = (sbyte)val1 + (sbyte)val2;
            _flags.CF = result > 0xFF;
            _flags.OF = signedResult > 127 || signedResult < -128;
            _flags.AF = (val1 & 0x0f) + (val2 & 0x0f) > 0x0f;
            CalcParitySignZeroFlag((byte)result);
            return (byte)result;
        }

        /// <summary>
        ///     add word, set all flags accordingly
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        private ushort AddWord(ushort val1, ushort val2)
        {
            var result = val1 + val2;
            var signedResult = (short)val1 + (short)val2;
            _flags.CF = result > 0xFFFF;
            _flags.OF = signedResult > 32767 || signedResult < -32768;
            _flags.AF = (val1 & 0x0f) + (val2 & 0x0f) > 0x0f;
            CalcParitySignZeroFlag((ushort)result);
            return (ushort)result;
        }

        /// <summary>
        ///     add byte with carry, set all flags accordingly
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        private byte AdcByte(byte val1, byte val2)
        {
            var carry = _flags.CF ? 1 : 0;
            var result = val1 + val2 + carry;
            var signedResult = (sbyte)val1 + (sbyte)val2 + carry;
            _flags.CF = result > 0xFF;
            _flags.OF = signedResult > 127 || signedResult < -128;
            _flags.AF = (val1 & 0x0f) + (val2 & 0x0f) + carry > 0x0f;
            CalcParitySignZeroFlag((byte)result);
            return (byte)result;
        }

        /// <summary>
        ///     add word with carry, set all flags accordingly
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        private ushort AdcWord(ushort val1, ushort val2)
        {
            var carry = _flags.CF ? 1 : 0;
            var result = val1 + val2 + carry;
            var signedResult = (short)val1 + (short)val2 + carry;
            _flags.CF = result > 0xFFFF;
            _flags.OF = signedResult > 32767 || signedResult < -32768;
            _flags.AF = (val1 & 0x0f) + (val2 & 0x0f) + carry > 0x0f;
            CalcParitySignZeroFlag((ushort)result);
            return (ushort)result;
        }

        /// <summary>
        ///     push word onto stack
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        private void PushWord(ushort value)
        {
            SP -= 2;
            SetMemWord(SS, SP, value);
        }

        /// <summary>
        ///     pop word from stack
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        private ushort PopWord()
        {
            var value = GetMemWord(SS, SP);
            SP += 2;
            return value;
        }

        /// <summary>
        ///     calculate the PF, SF and ZF flags from a given value
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        private void CalcParitySignZeroFlag(byte value)
        {
            _flags.PF = _parities[value];
            _flags.SF = (value & 0x80) > 0;
            _flags.ZF = value == 0;
        }

        /// <summary>
        ///     calculate the PF, SF and ZF flags from a given value
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        private void CalcParitySignZeroFlag(ushort value)
        {
            _flags.PF = _parities[value & 0x00ff];
            _flags.SF = (value & 0x8000) > 0;
            _flags.ZF = value == 0;
        }

        /// <summary>
        ///     read and decode the address byte. increments IP.
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        private void ReadAndDecodeAddressByte(out int mode, out int reg, out int rm, out int rmAddr)
        {
            var addressByte = GetMemByte(CS, IP++);
            mode = (addressByte & 0xc0) >> 6;
            reg = (addressByte & 0x38) >> 3;
            rm = addressByte & 0x07;
            rmAddr = mode == 3 ? 0 : CalcRmAddr(mode, rm);
        }

        /// <summary>
        ///     performs an operation with byte values
        /// </summary>
        private void DoByteOperation(Direction direction, Func<byte, byte> operation, int regClocks, int memClocks, bool saveOutput = true)
        {
            int mode, reg, rm, rmAddr;
            ReadAndDecodeAddressByte(out mode, out reg, out rm, out rmAddr);
            ClockCount += mode == 3 ? regClocks : memClocks;

            if (direction == Direction.RegToRm)
            {
                var output = operation(GetRegByte(reg));
                if (saveOutput)
                    SetRmByte(mode, rm, rmAddr, output);
            }
            else
            {
                var output = operation(GetRmByte(mode, rm, rmAddr));
                if (saveOutput)
                    SetRegByte(reg, output);
            }
        }

        /// <summary>
        ///     performs an operation with byte values
        /// </summary>
        private void DoByteOperation(Direction direction, Func<byte, byte, byte> operation, int regClocks, int memClocks, bool saveOutput = true)
        {
            int mode, reg, rm, rmAddr;
            ReadAndDecodeAddressByte(out mode, out reg, out rm, out rmAddr);
            ClockCount += mode == 3 ? regClocks : memClocks;

            if (direction == Direction.RegToRm)
            {
                var output = operation(GetRmByte(mode, rm, rmAddr), GetRegByte(reg));
                if (saveOutput)
                        SetRmByte(mode, rm, rmAddr, output);
            }
            else
            {
                var output = operation(GetRegByte(reg), GetRmByte(mode, rm, rmAddr));
                if (saveOutput)
                    SetRegByte(reg, output);
            }
        }

        /// <summary>
        ///     performs an operation with word values
        /// </summary>
        private void DoWordOperation(Direction direction, Func<ushort, ushort> operation, int regClocks, int memClocks, bool useSreg = false, bool saveOutput = true)
        {
            int mode, reg, rm, rmAddr;
            ReadAndDecodeAddressByte(out mode, out reg, out rm, out rmAddr);
            ClockCount += mode == 3 ? regClocks : memClocks;

            if (direction == Direction.RegToRm)
            {
                var output = operation(GetRegWord(reg, useSreg));
                if (saveOutput)
                    SetRmWord(mode, rm, rmAddr, output);
            }
            else
            {
                var output = operation(GetRmWord(mode, rm, rmAddr));
                if (saveOutput)
                    SetRegWord(reg, output, useSreg);
            }
        }

        /// <summary>
        ///     performs an operation with word values
        /// </summary>
        private void DoWordOperation(Direction direction, Func<ushort, ushort, ushort> operation, int regClocks, int memClocks, bool useSreg = false, bool saveOutput = true)
        {
            int mode, reg, rm, rmAddr;
            ReadAndDecodeAddressByte(out mode, out reg, out rm, out rmAddr);
            ClockCount += mode == 3 ? regClocks : memClocks;

            if (direction == Direction.RegToRm)
            {
                var output = operation(GetRmWord(mode, rm, rmAddr), GetRegWord(reg, useSreg));
                if (saveOutput)
                    SetRmWord(mode, rm, rmAddr, output);
            }
            else
            {
                var output = operation(GetRegWord(reg, useSreg), GetRmWord(mode, rm, rmAddr));
                if (saveOutput)
                    SetRegWord(reg, output, useSreg);
            }
        }

        /// <summary>
        ///     calculates an absolute address from the mode and r/m values
        /// </summary>
        private int CalcRmAddr(int mode, int rm)
        {
            switch (mode)
            {
                case 0:
                    switch (rm)
                    {
                        case 0:
                            return GenAddr(DS, _segOverride, (ushort)(BX + SI));
                        case 1:
                            return GenAddr(DS, _segOverride, (ushort)(BX + DI));
                        case 2:
                            return GenAddr(SS, _segOverride, (ushort)(BP + SI));
                        case 3:
                            return GenAddr(SS, _segOverride, (ushort)(BP + DI));
                        case 4:
                            return GenAddr(DS, _segOverride, SI);
                        case 5:
                            return GenAddr(DS, _segOverride, DI);
                        case 6:
                            var offs = GetMemWord(CS, IP);
                            IP += 2;
                            return GenAddr(DS, _segOverride, offs);
                        case 7:
                            return GenAddr(DS, _segOverride, BX);
                    }
                    break;
                case 1:
                    var disp8 = (sbyte)GetMemByte(CS, IP++);
                    switch (rm)
                    {
                        case 0:
                            return GenAddr(DS, _segOverride, (ushort)(BX + SI + disp8));
                        case 1:
                            return GenAddr(DS, _segOverride, (ushort)(BX + DI + disp8));
                        case 2:
                            return GenAddr(SS, _segOverride, (ushort)(BP + SI + disp8));
                        case 3:
                            return GenAddr(SS, _segOverride, (ushort)(BP + DI + disp8));
                        case 4:
                            return GenAddr(DS, _segOverride, (ushort)(SI + disp8));
                        case 5:
                            return GenAddr(DS, _segOverride, (ushort)(DI + disp8));
                        case 6:
                            return GenAddr(SS, _segOverride, (ushort)(BP + disp8));
                        case 7:
                            return GenAddr(DS, _segOverride, (ushort)(BX + disp8));
                    }
                    break;
                case 2:
                    var disp16 = GetMemWord(CS, IP);
                    IP += 2;
                    switch (rm)
                    {
                        case 0:
                            return GenAddr(DS, _segOverride, (ushort)(BX + SI + disp16));
                        case 1:
                            return GenAddr(DS, _segOverride, (ushort)(BX + DI + disp16));
                        case 2:
                            return GenAddr(SS, _segOverride, (ushort)(BP + SI + disp16));
                        case 3:
                            return GenAddr(SS, _segOverride, (ushort)(BP + DI + disp16));
                        case 4:
                            return GenAddr(DS, _segOverride, (ushort)(SI + disp16));
                        case 5:
                            return GenAddr(DS, _segOverride, (ushort)(DI + disp16));
                        case 6:
                            return GenAddr(SS, _segOverride, (ushort)(BP + disp16));
                        case 7:
                            return GenAddr(DS, _segOverride, (ushort)(BX + disp16));
                    }
                    break;
            }
            return 0;
        }

        /// <summary>
        ///     calculates an effective address from the mode and r/m values
        /// </summary>
        private ushort CalcEa(int mode, int rm)
        {
            switch (mode)
            {
                case 0:
                    switch (rm)
                    {
                        case 0:
                            return (ushort)(BX + SI);
                        case 1:
                            return (ushort)(BX + DI);
                        case 2:
                            return (ushort)(BP + SI);
                        case 3:
                            return (ushort)(BP + DI);
                        case 4:
                            return SI;
                        case 5:
                            return DI;
                        case 6:
                            var offs = GetMemWord(CS, IP);
                            IP += 2;
                            return offs;
                        case 7:
                            return BX;
                    }
                    break;
                case 1:
                    var disp8 = (sbyte)GetMemByte(CS, IP++);
                    switch (rm)
                    {
                        case 0:
                            return (ushort)(BX + SI + disp8);
                        case 1:
                            return (ushort)(BX + DI + disp8);
                        case 2:
                            return (ushort)(BP + SI + disp8);
                        case 3:
                            return (ushort)(BP + DI + disp8);
                        case 4:
                            return (ushort)(SI + disp8);
                        case 5:
                            return (ushort)(DI + disp8);
                        case 6:
                            return (ushort)(BP + disp8);
                        case 7:
                            return (ushort)(BX + disp8);
                    }
                    break;
                case 2:
                    var disp16 = GetMemWord(CS, IP);
                    IP += 2;
                    switch (rm)
                    {
                        case 0:
                            return (ushort)(BX + SI + disp16);
                        case 1:
                            return (ushort)(BX + DI + disp16);
                        case 2:
                            return (ushort)(BP + SI + disp16);
                        case 3:
                            return (ushort)(BP + DI + disp16);
                        case 4:
                            return (ushort)(SI + disp16);
                        case 5:
                            return (ushort)(DI + disp16);
                        case 6:
                            return (ushort)(BP + disp16);
                        case 7:
                            return (ushort)(BX + disp16);
                    }
                    break;
            }
            return 0;
        }

        /// <summary>
        ///     get byte from register
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        private byte GetRegByte(int reg)
        {
            switch (reg)
            {
                case 0:
                    return AL;
                case 1:
                    return CL;
                case 2:
                    return DL;
                case 3:
                    return BL;
                case 4:
                    return AH;
                case 5:
                    return CH;
                case 6:
                    return DH;
                case 7:
                    return BH;
            }
            return 0;
        }

        /// <summary>
        ///     set byte to register
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        private void SetRegByte(int reg, byte value)
        {
            switch (reg)
            {
                case 0:
                    AL = value;
                    break;
                case 1:
                    CL = value;
                    break;
                case 2:
                    DL = value;
                    break;
                case 3:
                    BL = value;
                    break;
                case 4:
                    AH = value;
                    break;
                case 5:
                    CH = value;
                    break;
                case 6:
                    DH = value;
                    break;
                case 7:
                    BH = value;
                    break;
            }
        }

        /// <summary>
        ///     get byte from r/m
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public byte GetRmByte(int mode, int rm, int rmAddr)
        {
            return mode == 3 ? GetRegByte(rm) : _memoryProvider.Peek(rmAddr);
        }

        /// <summary>
        ///     set byte to r/m
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public void SetRmByte(int mode, int rm, int rmAddr, byte value)
        {
            if (mode == 3)
                SetRegByte(rm, value);
            else
                _memoryProvider.Poke(rmAddr, value);
        }

        /// <summary>
        ///     get word from register
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        private ushort GetRegWord(int res, bool useSreg)
        {
            if (useSreg)
            {
                switch (res)
                {
                    case 0:
                        return ES;
                    case 1:
                        return CS;
                    case 2:
                        return SS;
                    case 3:
                        return DS;
                }
            }
            else
                return GetRegWord(res);
            return 0;
        }

        /// <summary>
        ///     get word from register
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        private ushort GetRegWord(int res)
        {
            switch (res)
            {
                case 0:
                    return AX;
                case 1:
                    return CX;
                case 2:
                    return DX;
                case 3:
                    return BX;
                case 4:
                    return SP;
                case 5:
                    return BP;
                case 6:
                    return SI;
                case 7:
                    return DI;
            }
            return 0;
        }

        /// <summary>
        ///     set word to register
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        private void SetRegWord(int reg, ushort value, bool useSreg = false)
        {
            if (useSreg)
            {
                switch (reg)
                {
                    case 0:
                        ES = value;
                        break;
                    case 1:
                        CS = value;
                        break;
                    case 2:
                        SS = value;
                        break;
                    case 3:
                        DS = value;
                        break;
                }
            }
            else
            {
                switch (reg)
                {
                    case 0:
                        AX = value;
                        break;
                    case 1:
                        CX = value;
                        break;
                    case 2:
                        DX = value;
                        break;
                    case 3:
                        BX = value;
                        break;
                    case 4:
                        SP = value;
                        break;
                    case 5:
                        BP = value;
                        break;
                    case 6:
                        SI = value;
                        break;
                    case 7:
                        DI = value;
                        break;
                }
            }
        }

        /// <summary>
        ///     get word from r/m
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public ushort GetRmWord(int mode, int rm, int rmAddr)
        {
            return mode == 3 ? GetRegWord(rm) : _memoryProvider.PeekW(rmAddr);
        }

        /// <summary>
        ///     set word to r/m
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public void SetRmWord(int mode, int rm, int rmAddr, ushort value)
        {
            if (mode == 3)
                SetRegWord(rm, value);
            else
                _memoryProvider.PokeW(rmAddr, value);
        }

        /// <summary>
        ///     set byte in memory
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        private void SetMemByte(ushort seg, ushort offs, byte value)
        {
            _memoryProvider.Poke(GenAddr(seg, offs), value);
        }

        /// <summary>
        ///     set byte in memory
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        private void SetMemByte(ushort seg, SegOverride segOverride, ushort offs, byte value)
        {
            _memoryProvider.Poke(GenAddr(seg, segOverride, offs), value);
        }

        /// <summary>
        ///     set word in memory
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        private void SetMemWord(ushort seg, ushort offs, ushort value)
        {
            _memoryProvider.PokeW(GenAddr(seg, offs), value);
        }

        /// <summary>
        ///     set word in memory
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        private void SetMemWord(ushort seg, SegOverride segOverride, ushort offs, ushort value)
        {
            _memoryProvider.PokeW(GenAddr(seg, segOverride, offs), value);
        }

        /// <summary>
        ///     get byte from memory
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public byte GetMemByte(ushort seg, ushort offs)
        {
            return _memoryProvider.Peek(GenAddr(seg, offs));
        }

        /// <summary>
        ///     get byte from memory
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        private byte GetMemByte(ushort seg, SegOverride segOverride, ushort offs)
        {
            return _memoryProvider.Peek(GenAddr(seg, segOverride, offs));
        }

        /// <summary>
        ///     get word from memory
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public ushort GetMemWord(ushort seg, ushort offs)
        {
            return _memoryProvider.PeekW(GenAddr(seg, offs));
        }

        /// <summary>
        ///     get word from memory
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        private ushort GetMemWord(ushort seg, SegOverride segOverride, ushort offs)
        {
            return _memoryProvider.PeekW(GenAddr(seg, segOverride, offs));
        }

        /// <summary>
        ///     generate software interrupt
        /// </summary>
        private void DoSoftInterrupt(int value)
        {
            if (HandleSoftInterrupt(value)) return;
            _softInterrupt = value;

        }

        private bool HandleSoftInterrupt(int value)
        {
            switch (value)
            {
                // INT 13h
                case 0x13:
                    if (AH == 0x04)
                    {
                        // verify sectors
                        AH = 0;
                        _flags.CF = false;
                        return true;
                    }
                    break;
            }

            return false;
        }
        
        /// <summary>
        ///     generate hardware interrupt
        /// </summary>
        public void DoInterrupt(int value)
        {
            _hardInterrupt = value;
        }

        /// <summary>
        ///     set e
        /// </summary>
        public int SetEvent(int timeoutMicroSeconds, Action e)
        {
            lock (_cpuEvents)
            {
                var newId = ++_eventGen;
                _cpuEvents.Add(
                    new CpuEvent
                    {
                        Action = e,
                        ClockCount = ClockCount + (timeoutMicroSeconds * (long)Settings.CpuFrequency) / 1000,
                        Id = newId
                    });
                return newId;
            }
        }

        /// <summary>
        ///     delete e
        /// </summary>
        public void DeleteEvent(int id)
        {
            lock (_cpuEvents)
            {
                for (var idx = 0; idx < _cpuEvents.Count; idx++)
                {
                    if (_cpuEvents[idx].Id == id)
                    {
                        _cpuEvents.RemoveAt(idx);
                        break;
                    }
                }
            }
        }

        private class CpuEvent
        {
            public Action Action { get; set; }
            public long ClockCount { get; set; }
            public int Id { get; set; }
        }

    }
}