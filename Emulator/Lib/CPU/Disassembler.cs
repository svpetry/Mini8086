using Emulator.Utils;
using System;
using System.Collections.Generic;

namespace Emulator.CPU
{
    public sealed class Disassembler
    {
        private readonly Cpu8086 _cpu;
        private readonly IMemoryProvider _memory;
        private readonly List<byte> _hexValues = new List<byte>();
        private int _startAddress;
        private int _localAddress;
        private string _segOverride;

        public string Instruction { get; private set; }

        /// <summary>
        /// byte values of current instruction
        /// </summary>
        public string InstBytes
        {
            get
            {
                var str = "";
                foreach (var v in _hexValues)
                {
                    if (str != "")
                        str += " ";
                    str += $"{v:X2}";
                }
                return str;
            }
        }

        /// <summary>
        /// full disassembled line
        /// </summary>
        public string DisassembledLine
        {
            get
            {
                var instructionBytes = InstBytes.PadRight(20);
                return $"{_startAddress:X5}  {instructionBytes}    {Instruction}";
            }
        }

        /// <summary>
        /// constructor
        /// </summary>
        public Disassembler(Cpu8086 cpu, IMemoryProvider memory)
        {
            _cpu = cpu;
            _memory = memory;
        }

        /// <summary>
        /// disassembles current CPU instruction
        /// </summary>
        public void DoDisassemble(int address = -1)
        {
            _hexValues.Clear();
            Instruction = "";

            if (address == -1)
                _startAddress = (_cpu.CS << 4) + _cpu.IP;
            else
                _startAddress = address;
            _localAddress = _startAddress;

            var opcode = GetNextByte();

            // handle REP prefixes
            switch (opcode)
            {
                // REP
                case 0xf3:
                    Instruction += "REP ";
                    opcode = GetNextByte();
                    break;

                // REPNZ
                case 0xf2:
                    Instruction += "REPNZ ";
                    opcode = GetNextByte();
                    break;
            }

            // handle other prefixes
            switch (opcode)
            {
                // LOCK
                case 0xf0:
                    Instruction += "LOCK ";
                    opcode = GetNextByte();
                    break;

                // CS
                case 0x2e:
                    _segOverride = "CS:";
                    opcode = GetNextByte();
                    break;

                // DS
                case 0x3e:
                    _segOverride = "DS:";
                    opcode = GetNextByte();
                    break;

                // ES
                case 0x26:
                    _segOverride = "ES:";
                    opcode = GetNextByte();
                    break;

                // SS
                case 0x36:
                    _segOverride = "SS:";
                    opcode = GetNextByte();
                    break;

            }

            ProcessOpcode(opcode);
            _segOverride = "";
        }

        /// <summary>
        /// process an opcode
        /// </summary>
        /// <param name="opcode"></param>
        private void ProcessOpcode(byte opcode)
        {
            switch (opcode)
            {
                // AAA
                case 0x37:
                    Instruction = "AAA";
                    break;

                // AAD
                case 0xd5:
                    Instruction = "AAD";
                    break;

                // AAM
                case 0xd4:
                    Instruction = "AAM";
                    break;

                // AAS
                case 0x3f:
                    Instruction = "AAS";
                    break;

                // ADC r/m8, reg8
                case 0x10:
                    {
                        string regStr;
                        string rmStr;
                        ReadAndDecodeAddressByte(out regStr, out rmStr, true);
                        Instruction = "ADC " + rmStr + ", " + regStr;
                    }
                    break;

                // ADC r/m16, reg16
                case 0x11:
                    {
                        string regStr;
                        string rmStr;
                        ReadAndDecodeAddressByte(out regStr, out rmStr, false);
                        Instruction = "ADC " + rmStr + ", " + regStr;
                    }
                    break;

                // ADC reg8, r/m8
                case 0x12:
                    {
                        string regStr;
                        string rmStr;
                        ReadAndDecodeAddressByte(out regStr, out rmStr, true);
                        Instruction = "ADC " + regStr + ", " + rmStr;
                    }
                    break;

                // ADC reg16, r/m16
                case 0x13:
                    {
                        string regStr;
                        string rmStr;
                        ReadAndDecodeAddressByte(out regStr, out rmStr, false);
                        Instruction = "ADC " + regStr + ", " + rmStr;
                    }
                    break;

                // ADC AL, imm8
                case 0x14:
                    Instruction = "ADC AL, " + ByteToHex(GetNextByte());
                    break;

                // ADC AX, imm16
                case 0x15:
                    Instruction = "ADC AX, " + WordToHex(GetNextWord());
                    break;

                // ADD r/m8, reg8
                case 0x00:
                    {
                        string regStr;
                        string rmStr;
                        ReadAndDecodeAddressByte(out regStr, out rmStr, true);
                        Instruction = "ADD " + rmStr + ", " + regStr;
                    }
                    break;

                // ADD r/m16, reg16
                case 0x01:
                    {
                        string regStr;
                        string rmStr;
                        ReadAndDecodeAddressByte(out regStr, out rmStr, false);
                        Instruction = "ADD " + rmStr + ", " + regStr;
                    }
                    break;

                // ADD reg8, r/m8
                case 0x02:
                    {
                        string regStr;
                        string rmStr;
                        ReadAndDecodeAddressByte(out regStr, out rmStr, true);
                        Instruction = "ADD " + regStr + ", " + rmStr;
                    }
                    break;

                // ADD reg16, r/m16
                case 0x03:
                    {
                        string regStr;
                        string rmStr;
                        ReadAndDecodeAddressByte(out regStr, out rmStr, false);
                        Instruction = "ADD " + regStr + ", " + rmStr;
                    }
                    break;

                // ADD AL, imm8
                case 0x04:
                    Instruction = "ADD AL, " + ByteToHex(GetNextByte());
                    break;

                // ADD AX, imm16
                case 0x05:
                    Instruction = "ADD AX, " + WordToHex(GetNextWord());
                    break;

                // AND r/m8, reg8
                case 0x20:
                    {
                        string regStr;
                        string rmStr;
                        ReadAndDecodeAddressByte(out regStr, out rmStr, true);
                        Instruction = "AND " + rmStr + ", " + regStr;
                    }
                    break;

                // AND r/m16, reg16
                case 0x21:
                    {
                        string regStr;
                        string rmStr;
                        ReadAndDecodeAddressByte(out regStr, out rmStr, false);
                        Instruction = "AND " + rmStr + ", " + regStr;
                    }
                    break;

                // AND reg8, r/m8
                case 0x22:
                    {
                        string regStr;
                        string rmStr;
                        ReadAndDecodeAddressByte(out regStr, out rmStr, true);
                        Instruction = "AND " + regStr + ", " + rmStr;
                    }
                    break;

                // AND reg16, r/m16
                case 0x23:
                    {
                        string regStr;
                        string rmStr;
                        ReadAndDecodeAddressByte(out regStr, out rmStr, false);
                        Instruction = "AND " + regStr + ", " + rmStr;
                    }
                    break;

                // AND AL, imm8
                case 0x24:
                    Instruction = "AND AL, " + ByteToHex(GetNextByte());
                    break;

                // AND AX, imm16
                case 0x25:
                    Instruction = "AND AX, " + WordToHex(GetNextWord());
                    break;

                // BOUND reg16, r/m16 (80186+)
                case 0x62:
                    {
                        string regStr;
                        string rmStr;
                        ReadAndDecodeAddressByte(out regStr, out rmStr, false);
                        Instruction = "BOUND " + regStr + ", " + rmStr;
                    }
                    break;

                // CALL near
                case 0xe8:
                    Instruction = "CALL " + SWordToHex((Int16)GetNextWord());
                    break;

                // CALL far
                case 0x9a:
                    {
                        var destOffs = GetNextWord();
                        var destSeg = GetNextWord();
                        Instruction = "CALL FAR " + WordToHex(destSeg) + ":" + WordToHex(destOffs);
                    }
                    break;

                // CBW
                case 0x98:
                    Instruction = "CBW";
                    break;

                // CLC
                case 0xf8:
                    Instruction = "CLC";
                    break;

                // CLD
                case 0xfc:
                    Instruction = "CLD";
                    break;

                // CLI
                case 0xfa:
                    Instruction = "CLI";
                    break;

                // CMC
                case 0xf5:
                    Instruction = "CMC";
                    break;

                // CMP r/m8, reg8
                case 0x38:
                    {
                        string regStr;
                        string rmStr;
                        ReadAndDecodeAddressByte(out regStr, out rmStr, true);
                        Instruction = "CMP " + rmStr + ", " + regStr;
                    }
                    break;

                // CMP r/m16, reg16
                case 0x39:
                    {
                        string regStr;
                        string rmStr;
                        ReadAndDecodeAddressByte(out regStr, out rmStr, false);
                        Instruction = "CMP " + rmStr + ", " + regStr;
                    }
                    break;

                // CMP reg8, r/m8
                case 0x3a:
                    {
                        string regStr;
                        string rmStr;
                        ReadAndDecodeAddressByte(out regStr, out rmStr, true);
                        Instruction = "CMP " + regStr + ", " + rmStr;
                    }
                    break;

                // CMP reg16, r/m16
                case 0x3b:
                    {
                        string regStr;
                        string rmStr;
                        ReadAndDecodeAddressByte(out regStr, out rmStr, false);
                        Instruction = "CMP " + regStr + ", " + rmStr;
                    }
                    break;

                // CMP AL, imm8
                case 0x3c:
                    Instruction = "CMP AL, " + ByteToHex(GetNextByte());
                    break;

                // CMP AX, imm16
                case 0x3d:
                    Instruction = "CMP AX, " + WordToHex(GetNextWord());
                    break;

                // CMPSB
                case 0xa6:
                    Instruction += "CMPSB";
                    if (_segOverride != "")
                        Instruction += " " + _segOverride + "[SI], ES:[DI]";
                    break;

                // CMPSW
                case 0xa7:
                    Instruction += "CMPSW";
                    if (_segOverride != "")
                        Instruction += " " + _segOverride + "[SI], ES:[DI]";
                    break;

                // CWD
                case 0x99:
                    Instruction = "CWD";
                    break;

                // DAA
                case 0x27:
                    Instruction = "DAA";
                    break;

                // DAS
                case 0x2f:
                    Instruction = "DAS";
                    break;

                // DEC AX
                case 0x48:
                    Instruction = "DEC AX";
                    break;

                // DEC CX
                case 0x49:
                    Instruction = "DEC CX";
                    break;

                // DEC DX
                case 0x4a:
                    Instruction = "DEC DX";
                    break;

                // DEC BX
                case 0x4b:
                    Instruction = "DEC BX";
                    break;

                // DEC SP
                case 0x4c:
                    Instruction = "DEC SP";
                    break;

                // DEC BP
                case 0x4d:
                    Instruction = "DEC BP";
                    break;

                // DEC SI
                case 0x4e:
                    Instruction = "DEC SI";
                    break;

                // DEC DI
                case 0x4f:
                    Instruction = "DEC DI";
                    break;

                // ENTER imm16, imm8 (80186+)
                case 0xC8:
                    Instruction = "ENTER " + WordToHex(GetNextWord()) + ", " + ByteToHex(GetNextByte());
                    break;

                // HLT
                case 0xf4:
                    Instruction = "HLT";
                    break;

                // IMUL reg16, r/m16, imm8 (80186+)
                case 0x6B:
                    {
                        string regStr;
                        string rmStr;
                        ReadAndDecodeAddressByte(out regStr, out rmStr, false);
                        if (regStr == rmStr)
                            Instruction = "IMUL " + regStr + ", " + ByteToHex(GetNextByte());
                        else
                            Instruction = "IMUL " + regStr + ", " + rmStr + ", " + ByteToHex(GetNextByte());
                    }
                    break;

                // IMUL reg16, r/m16, imm16 (80186+)
                case 0x69:
                    {
                        string regStr;
                        string rmStr;
                        ReadAndDecodeAddressByte(out regStr, out rmStr, false);
                        if (regStr == rmStr)
                            Instruction = "IMUL " + regStr + ", " + WordToHex(GetNextWord());
                        else
                            Instruction = "IMUL " + regStr + ", " + rmStr + ", " + WordToHex(GetNextWord());
                    }
                    break;

                // IN AL, imm8
                case 0xe4:
                    Instruction = "IN AL, " + ByteToHex(GetNextByte());
                    break;

                // IN AX, imm8
                case 0xe5:
                    Instruction = "IN AX, " + ByteToHex(GetNextByte());
                    break;

                // IN AL, DX
                case 0xec:
                    Instruction = "IN AL, DX";
                    break;

                // IN AX, DX
                case 0xed:
                    Instruction = "IN AX, DX";
                    break;

                // INC AX
                case 0x40:
                    Instruction = "INC AX";
                    break;

                // INC CX
                case 0x41:
                    Instruction = "INC CX";
                    break;

                // INC DX
                case 0x42:
                    Instruction = "INC DX";
                    break;

                // INC BX
                case 0x43:
                    Instruction = "INC BX";
                    break;

                // INC SP
                case 0x44:
                    Instruction = "INC SP";
                    break;

                // INC BP
                case 0x45:
                    Instruction = "INC BP";
                    break;

                // INC SI
                case 0x46:
                    Instruction = "INC SI";
                    break;

                // INC DI
                case 0x47:
                    Instruction = "INC DI";
                    break;

                // INSB (80186+)
                case 0x6C:
                    Instruction += "INSB";
                    break;

                // INSW (80186+)
                case 0x6D:
                    Instruction += "INSW";
                    break;

                // INT3
                case 0xcc:
                    Instruction = "INT3";
                    break;

                // INT imm8
                case 0xcd:
                    Instruction = "INT " + ByteToHex(GetNextByte());
                    break;

                // INTO
                case 0xce:
                    Instruction = "INTO";
                    break;

                // IRET
                case 0xcf:
                    Instruction = "IRET";
                    break;

                // JA
                case 0x77:
                    Instruction = "JA " + SByteToHex((sbyte)GetNextByte());
                    break;

                // JAE/JNC
                case 0x73:
                    Instruction = "JAE/JNC " + SByteToHex((sbyte)GetNextByte());
                    break;

                // JB/JC
                case 0x72:
                    Instruction = "JB/JC " + SByteToHex((sbyte)GetNextByte());
                    break;

                // JBE
                case 0x76:
                    Instruction = "JBE " + SByteToHex((sbyte)GetNextByte());
                    break;

                // JCXZ:
                case 0xe3:
                    Instruction = "JCXZ " + SByteToHex((sbyte)GetNextByte());
                    break;

                // JE/JZ
                case 0x74:
                    Instruction = "JE " + SByteToHex((sbyte)GetNextByte());
                    break;

                // JG
                case 0x7f:
                    Instruction = "JG " + SByteToHex((sbyte)GetNextByte());
                    break;

                // JGE
                case 0x7d:
                    Instruction = "JGE " + SByteToHex((sbyte)GetNextByte());
                    break;

                // JL
                case 0x7c:
                    Instruction = "JL " + SByteToHex((sbyte)GetNextByte());
                    break;

                // JLE
                case 0x7e:
                    Instruction = "JLE " + SByteToHex((sbyte)GetNextByte());
                    break;

                // JMP short
                case 0xeb:
                    Instruction = "JMP " + SByteToHex((sbyte)GetNextByte());
                    break;

                // JMP near
                case 0xe9:
                    Instruction = "JMP " + SWordToHex((Int16)GetNextWord());
                    break;

                // JMP far
                case 0xea:
                    {
                        var destOffs = GetNextWord();
                        var destSeg = GetNextWord();
                        Instruction = "JMP FAR " + WordToHex(destSeg) + ":" + WordToHex(destOffs);
                    }
                    break;

                // JNE/JNZ
                case 0x75:
                    Instruction = "JNE " + SByteToHex((sbyte)GetNextByte());
                    break;

                // JNO
                case 0x71:
                    Instruction = "JNO " + SByteToHex((sbyte)GetNextByte());
                    break;

                // JNS
                case 0x79:
                    Instruction = "JNS " + SByteToHex((sbyte)GetNextByte());
                    break;

                // JNP/JPO
                case 0x7b:
                    Instruction = "JNP " + SByteToHex((sbyte)GetNextByte());
                    break;

                // JO
                case 0x70:
                    Instruction = "JO " + SByteToHex((sbyte)GetNextByte());
                    break;

                // JP
                case 0x7a:
                    Instruction = "JP " + SByteToHex((sbyte)GetNextByte());
                    break;

                // JS
                case 0x78:
                    Instruction = "JS " + SByteToHex((sbyte)GetNextByte());
                    break;

                // LAHF
                case 0x9f:
                    Instruction = "LAHF";
                    break;

                // LDS
                case 0xc5:
                    {
                        string regStr;
                        string rmStr;
                        ReadAndDecodeAddressByte(out regStr, out rmStr, false);
                        Instruction = "LDS " + regStr + ", " + rmStr;
                    }
                    break;

                // LEA
                case 0x8d:
                    {
                        string regStr;
                        string rmStr;
                        ReadAndDecodeAddressByte(out regStr, out rmStr, false);
                        Instruction = "LEA " + regStr + ", " + rmStr;
                    }
                    break;

                // LEAVE (80186+)
                case 0xC9:
                    Instruction = "LEAVE";
                    break;

                // LES
                case 0xc4:
                    {
                        string regStr;
                        string rmStr;
                        ReadAndDecodeAddressByte(out regStr, out rmStr, false);
                        Instruction = "LES " + regStr + ", " + rmStr;
                    }
                    break;

                // LOCK
                case 0xf0:
                    Instruction = "LOCK";
                    break;

                // LODSB
                case 0xac:
                    Instruction += "LODSB";
                    if (_segOverride != "")
                        Instruction += " " + _segOverride + "[SI]";
                    break;

                // LODSW
                case 0xad:
                    Instruction += "LODSW";
                    if (_segOverride != "")
                        Instruction += " " + _segOverride + "[SI]";
                    break;

                // LOOP
                case 0xe2:
                    Instruction = "LOOP " + SByteToHex((sbyte)GetNextByte());
                    break;

                // LOOPE/LOOPZ
                case 0xe1:
                    Instruction = "LOOPZ " + SByteToHex((sbyte)GetNextByte());
                    break;

                // LOOPNE/LOOPNZ
                case 0xe0:
                    Instruction = "LOOPNZ " + SByteToHex((sbyte)GetNextByte());
                    break;

                // MOV AL, memoffs
                case 0xa0:
                    Instruction = "MOV AL, " + _segOverride + "[" + WordToHex(GetNextWord()) + "]";
                    break;

                // MOV AX, memoffs
                case 0xa1:
                    Instruction = "MOV AX, " + _segOverride + "[" + WordToHex(GetNextWord()) + "]";
                    break;

                // MOV memoffs, AL
                case 0xa2:
                    Instruction = "MOV " + _segOverride + "[" + WordToHex(GetNextWord()) + "], AL";
                    break;

                // MOV memoffs, AX
                case 0xa3:
                    Instruction = "MOV " + _segOverride + "[" + WordToHex(GetNextWord()) + "], AX";
                    break;

                // MOV AL, imm8
                case 0xb0:
                    Instruction = "MOV AL, " + ByteToHex(GetNextByte());
                    break;

                // MOV CL, imm8
                case 0xb1:
                    Instruction = "MOV CL, " + ByteToHex(GetNextByte());
                    break;

                // MOV DL, imm8
                case 0xb2:
                    Instruction = "MOV DL, " + ByteToHex(GetNextByte());
                    break;

                // MOV BL, imm8
                case 0xb3:
                    Instruction = "MOV BL, " + ByteToHex(GetNextByte());
                    break;

                // MOV AH, imm8
                case 0xb4:
                    Instruction = "MOV AH, " + ByteToHex(GetNextByte());
                    break;

                // MOV CH, imm8
                case 0xb5:
                    Instruction = "MOV CH, " + ByteToHex(GetNextByte());
                    break;

                // MOV DH, imm8
                case 0xb6:
                    Instruction = "MOV DH, " + ByteToHex(GetNextByte());
                    break;

                // MOV BH, imm8
                case 0xb7:
                    Instruction = "MOV BH, " + ByteToHex(GetNextByte());
                    break;

                // MOV AX, imm16
                case 0xb8:
                    Instruction = "MOV AX, " + WordToHex(GetNextWord());
                    break;

                // MOV CX, imm16
                case 0xb9:
                    Instruction = "MOV CX, " + WordToHex(GetNextWord());
                    break;

                // MOV DX, imm16
                case 0xba:
                    Instruction = "MOV DX, " + WordToHex(GetNextWord());
                    break;

                // MOV BX, imm16
                case 0xbb:
                    Instruction = "MOV BX, " + WordToHex(GetNextWord());
                    break;

                // MOV SP, imm16
                case 0xbc:
                    Instruction = "MOV SP, " + WordToHex(GetNextWord());
                    break;

                // MOV BP, imm16
                case 0xbd:
                    Instruction = "MOV BP, " + WordToHex(GetNextWord());
                    break;

                // MOV SI, imm16
                case 0xbe:
                    Instruction = "MOV SI, " + WordToHex(GetNextWord());
                    break;

                // MOV DI, imm16
                case 0xbf:
                    Instruction = "MOV DI, " + WordToHex(GetNextWord());
                    break;

                // MOV r/m8, imm8
                case 0xc6:
                    {
                        string regStr;
                        string rmStr;
                        ReadAndDecodeAddressByte(out regStr, out rmStr, true);
                        Instruction = "MOV " + rmStr + ", " + ByteToHex(GetNextByte());
                    }
                    break;

                // MOV r/m16, imm16
                case 0xc7:
                    {
                        string regStr;
                        string rmStr;
                        ReadAndDecodeAddressByte(out regStr, out rmStr, false);
                        Instruction = "MOV " + rmStr + ", " + WordToHex(GetNextWord());
                    }
                    break;

                // MOV r/m8, reg8
                case 0x88:
                    {
                        string regStr;
                        string rmStr;
                        ReadAndDecodeAddressByte(out regStr, out rmStr, true);
                        Instruction = "MOV " + rmStr + ", " + regStr;
                    }
                    break;

                // MOV r/m16, reg16
                case 0x89:
                    {
                        string regStr;
                        string rmStr;
                        ReadAndDecodeAddressByte(out regStr, out rmStr, false);
                        Instruction = "MOV " + rmStr + ", " + regStr;
                    }
                    break;

                // MOV reg8, r/m8
                case 0x8a:
                    {
                        string regStr;
                        string rmStr;
                        ReadAndDecodeAddressByte(out regStr, out rmStr, true);
                        Instruction = "MOV " + regStr + ", " + rmStr;
                    }
                    break;

                // MOV reg16, r/m16
                case 0x8b:
                    {
                        string regStr;
                        string rmStr;
                        ReadAndDecodeAddressByte(out regStr, out rmStr, false);
                        Instruction = "MOV " + regStr + ", " + rmStr;
                    }
                    break;

                // MOV r/m16, segreg
                case 0x8c:
                    {
                        string regStr;
                        string rmStr;
                        ReadAndDecodeAddressByte(out regStr, out rmStr, false, true);
                        Instruction = "MOV " + rmStr + ", " + regStr;
                    }
                    break;

                // MOV segreg, r/m16
                case 0x8e:
                    {
                        string regStr;
                        string rmStr;
                        ReadAndDecodeAddressByte(out regStr, out rmStr, false, true);
                        Instruction = "MOV " + regStr + ", " + rmStr;
                    }
                    break;

                // MOVSB
                case 0xa4:
                    Instruction += "MOVSB";
                    if (_segOverride != "")
                        Instruction += " ES:[DI] " + _segOverride + "[SI]";
                    break;

                // MOVSW
                case 0xa5:
                    Instruction += "MOVSW";
                    if (_segOverride != "")
                        Instruction += " ES:[DI] " + _segOverride + "[SI]";
                    break;

                // NOP
                case 0x90:
                    Instruction = "NOP";
                    break;

                // OR r/m8, reg8
                case 0x08:
                    {
                        string regStr;
                        string rmStr;
                        ReadAndDecodeAddressByte(out regStr, out rmStr, true);
                        Instruction = "OR " + rmStr + ", " + regStr;
                    }
                    break;

                // OR r/m16, reg16
                case 0x09:
                    {
                        string regStr;
                        string rmStr;
                        ReadAndDecodeAddressByte(out regStr, out rmStr, false);
                        Instruction = "OR " + rmStr + ", " + regStr;
                    }
                    break;

                // OR reg8, r/m8
                case 0x0a:
                    {
                        string regStr;
                        string rmStr;
                        ReadAndDecodeAddressByte(out regStr, out rmStr, true);
                        Instruction = "OR " + regStr + ", " + rmStr;
                    }
                    break;

                // OR reg16, r/m16
                case 0x0b:
                    {
                        string regStr;
                        string rmStr;
                        ReadAndDecodeAddressByte(out regStr, out rmStr, false);
                        Instruction = "OR " + regStr + ", " + rmStr;
                    }
                    break;

                // OR AL, imm8
                case 0x0c:
                    Instruction = "OR AL, " + ByteToHex(GetNextByte());
                    break;

                // OR AX, imm16
                case 0x0d:
                    Instruction = "OR AX, " + WordToHex(GetNextWord());
                    break;

                // OUT imm8, AL
                case 0xe6:
                    Instruction = "OUT " + ByteToHex(GetNextByte()) + ", AL";
                    break;

                // OUT imm8, AX
                case 0xe7:
                    Instruction = "OUT " + ByteToHex(GetNextByte()) + ", AX";
                    break;

                // OUT DX, AL
                case 0xee:
                    Instruction = "OUT DX, AL";
                    break;

                // OUT DX, AX
                case 0xef:
                    Instruction = "OUT DX, AX";
                    break;

                // OUTSB (80186+)
                case 0x6E:
                    Instruction += "OUTSB";
                    break;

                // OUTSW (80186+)
                case 0x6F:
                    Instruction += "OUTSW";
                    break;

                // POP AX
                case 0x58:
                    Instruction = "POP AX";
                    break;

                // POP CX
                case 0x59:
                    Instruction = "POP CX";
                    break;

                // POP DX
                case 0x5a:
                    Instruction = "POP DX";
                    break;

                // POP BX
                case 0x5b:
                    Instruction = "POP BX";
                    break;

                // POP SP
                case 0x5c:
                    Instruction = "POP SP";
                    break;

                // POP BP
                case 0x5d:
                    Instruction = "POP BP";
                    break;

                // POP SI
                case 0x5e:
                    Instruction = "POP SI";
                    break;

                // POP DI
                case 0x5f:
                    Instruction = "POP DI";
                    break;

                // POP ES
                case 0x07:
                    Instruction = "POP ES";
                    break;

                // POP SS
                case 0x17:
                    Instruction = "POP SS";
                    break;

                // POP DS
                case 0x1f:
                    Instruction = "POP DS";
                    break;

                // POP r/m16
                case 0x8f:
                    {
                        string regStr;
                        string rmStr;
                        ReadAndDecodeAddressByte(out regStr, out rmStr, true);
                        Instruction = "POP " + rmStr;
                    }
                    break;

                // POPA (80186+)
                case 0x61:
                    Instruction = "POPA";
                    break;
                
                // POPF
                case 0x9d:
                    Instruction = "POPF";
                    break;

                // PUSH AX
                case 0x50:
                    Instruction = "PUSH AX";
                    break;

                // PUSH CX
                case 0x51:
                    Instruction = "PUSH CX";
                    break;

                // PUSH DX
                case 0x52:
                    Instruction = "PUSH DX";
                    break;

                // PUSH BX
                case 0x53:
                    Instruction = "PUSH BX";
                    break;

                // PUSH SP
                case 0x54:
                    Instruction = "PUSH SP";
                    break;

                // PUSH BP
                case 0x55:
                    Instruction = "PUSH BP";
                    break;

                // PUSH SI
                case 0x56:
                    Instruction = "PUSH SI";
                    break;

                // PUSH DI
                case 0x57:
                    Instruction = "PUSH DI";
                    break;

                // PUSH ES
                case 0x06:
                    Instruction = "PUSH ES";
                    break;

                // PUSH CS
                case 0x0e:
                    Instruction = "PUSH CS";
                    break;

                // PUSH SS
                case 0x16:
                    Instruction = "PUSH SS";
                    break;

                // PUSH DS
                case 0x1e:
                    Instruction = "PUSH DS";
                    break;

                // PUSH imm8 (80186+)
                case 0x6A:
                    Instruction = "PUSH " + ByteToHex(GetNextByte());
                    break;

                // PUSH imm16 (80186+)
                case 0x68:
                    Instruction = "PUSH " + WordToHex(GetNextWord());
                    break;

                // PUSHA (80186+)
                case 0x60:
                    Instruction = "PUSHA";
                    break;

                // PUSHF
                case 0x9c:
                    Instruction = "PUSHF";
                    break;

                // RET
                case 0xc3:
                    Instruction = "RET";
                    break;

                // RET imm16
                case 0xc2:
                    Instruction = "RET " + WordToHex(GetNextWord());
                    break;

                // RETF
                case 0xcb:
                    Instruction = "RETF";
                    break;

                // RETF imm16
                case 0xca:
                    Instruction = "RETF " + WordToHex(GetNextWord());
                    break;

                // SAHF
                case 0x9e:
                    Instruction = "SAHF";
                    break;

                // SBB r/m8, reg8
                case 0x18:
                    {
                        string regStr;
                        string rmStr;
                        ReadAndDecodeAddressByte(out regStr, out rmStr, true);
                        Instruction = "SBB " + rmStr + ", " + regStr;
                    }
                    break;

                // SBB r/m16, reg16
                case 0x19:
                    {
                        string regStr;
                        string rmStr;
                        ReadAndDecodeAddressByte(out regStr, out rmStr, false);
                        Instruction = "SBB " + rmStr + ", " + regStr;
                    }
                    break;

                // SBB reg8, r/m8
                case 0x1a:
                    {
                        string regStr;
                        string rmStr;
                        ReadAndDecodeAddressByte(out regStr, out rmStr, true);
                        Instruction = "SBB " + regStr + ", " + rmStr;
                    }
                    break;

                // SBB reg16, r/m16
                case 0x1b:
                    {
                        string regStr;
                        string rmStr;
                        ReadAndDecodeAddressByte(out regStr, out rmStr, false);
                        Instruction = "SBB " + regStr + ", " + rmStr;
                    }
                    break;

                // SBB AL, imm8
                case 0x1c:
                    Instruction = "SBB AL, " + ByteToHex(GetNextByte());
                    break;

                // SBB AX, imm16
                case 0x1d:
                    Instruction = "SBB AX, " + WordToHex(GetNextWord());
                    break;

                // SCASB
                case 0xae:
                    Instruction += "SCASB";
                    break;

                // SCASW
                case 0xaf:
                    Instruction += "SCASW";
                    break;

                // STC
                case 0xf9:
                    Instruction = "STC";
                    break;

                // STD
                case 0xfd:
                    Instruction = "STD";
                    break;

                // STI
                case 0xfb:
                    Instruction = "STI";
                    break;

                // STOSB
                case 0xaa:
                    Instruction += "STOSB";
                    break;

                // STOSW
                case 0xab:
                    Instruction += "STOSW";
                    break;

                // SUB r/m8, reg8
                case 0x28:
                    {
                        string regStr;
                        string rmStr;
                        ReadAndDecodeAddressByte(out regStr, out rmStr, true);
                        Instruction = "SUB " + rmStr + ", " + regStr;
                    }
                    break;

                // SUB r/m16, reg16
                case 0x29:
                    {
                        string regStr;
                        string rmStr;
                        ReadAndDecodeAddressByte(out regStr, out rmStr, false);
                        Instruction = "SUB " + rmStr + ", " + regStr;
                    }
                    break;

                // SUB reg8, r/m8
                case 0x2a:
                    {
                        string regStr; 
                        string rmStr;
                        ReadAndDecodeAddressByte(out regStr, out rmStr, true);
                        Instruction = "SUB " + regStr + ", " + rmStr;
                    }
                    break;

                // SUB reg16, r/m16
                case 0x2b:
                    {
                        string regStr;
                        string rmStr;
                        ReadAndDecodeAddressByte(out regStr, out rmStr, false);
                        Instruction = "SUB " + regStr + ", " + rmStr;
                    }
                    break;

                // SUB AL, imm8
                case 0x2c:
                    Instruction = "SUB AL, " + ByteToHex(GetNextByte());
                    break;

                // SUB AX, imm16
                case 0x2d:
                    Instruction = "SUB AX, " + WordToHex(GetNextWord());
                    break;

                // TEST r/m8, reg8
                case 0x84:
                    {
                        string regStr;
                        string rmStr;
                        ReadAndDecodeAddressByte(out regStr, out rmStr, true);
                        Instruction = "TEST " + rmStr + ", " + regStr;
                    }
                    break;

                // TEST r/m16, reg16
                case 0x85:
                    {
                        string regStr;
                        string rmStr;
                        ReadAndDecodeAddressByte(out regStr, out rmStr, false);
                        Instruction = "TEST " + rmStr + ", " + regStr;
                    }
                    break;

                // TEST AL, imm8
                case 0xa8:
                    Instruction = "TEST AL, " + ByteToHex(GetNextByte());
                    break;

                // TEST AX, imm16
                case 0xa9:
                    Instruction = "TEST AX, " + WordToHex(GetNextWord());
                    break;

                // WAIT
                case 0x9b:
                    Instruction = "WAIT";
                    break;

                // XCHG AX, CX
                case 0x91:
                    Instruction = "XCHG AX, CX";
                    break;

                // XCHG AX, DX
                case 0x92:
                    Instruction = "XCHG AX, DX";
                    break;

                // XCHG AX, BX
                case 0x93:
                    Instruction = "XCHG AX, BX";
                    break;

                // XCHG AX, SP
                case 0x94:
                    Instruction = "XCHG AX, SP";
                    break;

                // XCHG AX, BP
                case 0x95:
                    Instruction = "XCHG AX, BP";
                    break;

                // XCHG AX, SI
                case 0x96:
                    Instruction = "XCHG AX, SI";
                    break;

                // XCHG AX, DI
                case 0x97:
                    Instruction = "XCHG AX, DI";
                    break;

                // XCHG reg8, r/m8
                case 0x86:
                    {
                        string regStr;
                        string rmStr;
                        ReadAndDecodeAddressByte(out regStr, out rmStr, true);
                        Instruction = "XCHG " + regStr + ", " + rmStr;
                    }
                    break;

                // XCHG reg16, r/m16
                case 0x87:
                    {
                        string regStr;
                        string rmStr;
                        ReadAndDecodeAddressByte(out regStr, out rmStr, false);
                        Instruction = "XCHG " + regStr + ", " + rmStr;
                    }
                    break;

                // XLAT
                case 0xd7:
                    Instruction = "XLAT " + _segOverride + "[BX]";
                    break;

                // XOR r/m8, reg8
                case 0x30:
                    {
                        string regStr;
                        string rmStr;
                        ReadAndDecodeAddressByte(out regStr, out rmStr, true);
                        Instruction = "XOR " + rmStr + ", " + regStr;
                    }
                    break;

                // XOR r/m16, reg16
                case 0x31:
                    {
                        string regStr;
                        string rmStr;
                        ReadAndDecodeAddressByte(out regStr, out rmStr, false);
                        Instruction = "XOR " + rmStr + ", " + regStr;
                    }
                    break;

                // XOR reg8, r/m8
                case 0x32:
                    {
                        string regStr;
                        string rmStr;
                        ReadAndDecodeAddressByte(out regStr, out rmStr, true);
                        Instruction = "XOR " + regStr + ", " + rmStr;
                    }
                    break;

                // XOR reg16, r/m16
                case 0x33:
                    {
                        string regStr;
                        string rmStr;
                        ReadAndDecodeAddressByte(out regStr, out rmStr, false);
                        Instruction = "XOR " + regStr + ", " + rmStr;
                    }
                    break;

                // XOR AL, imm8
                case 0x34:
                    Instruction = "XOR AL, " + ByteToHex(GetNextByte());
                    break;

                // XOR AX, imm16
                case 0x35:
                    Instruction = "XOR AX, " + WordToHex(GetNextWord());
                    break;

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

                case 0xd0:
                    HandleOpcodeD0();
                    break;

                case 0xd1:
                    HandleOpcodeD1();
                    break;

                case 0xd2:
                    HandleOpcodeD2();
                    break;

                case 0xd3:
                    HandleOpcodeD3();
                    break;

                // RCL/RCR/ROL/ROR/SAL/SAR/SHL/SHR (80186+)
                case 0xC0:
                    HandleOpcodeC0();
                    break;

                // RCL/RCR/ROL/ROR/SAL/SAR/SHL/SHR (80186+)
                case 0xC1:
                    HandleOpcodeC1();
                    break;

            }
        }

        private void HandleOpcodeFeFf(bool wordOperation)
        {
            string regStr;
            string rmStr;
            var reg = ReadAndDecodeAddressByte(out regStr, out rmStr, !wordOperation);

            switch (reg)
            {
                // INC r/m8, INC r/m16
                case 0:
                    Instruction = "INC " + rmStr;
                    break;

                // DEC r/m8, DEC r/m16
                case 1:
                    Instruction = "DEC " + rmStr;
                    break;

                // JMP near r/m16
                case 4:
                    Instruction = "JMP " + rmStr;
                    break;

                // CALL near
                case 2:
                    Instruction = "CALL " + rmStr;
                    break;

                // CALL far
                case 3:
                    Instruction = "CALL FAR " + rmStr;
                    break;

                // JMP far r/m16
                case 5:
                    Instruction = "JMP FAR " + rmStr;
                    break;

                // PUSH r/m16
                case 6:
                    if (wordOperation)
                        Instruction = "PUSH " + rmStr;
                    break;
            }
        }

        private void HandleOpcode80()
        {
            string regStr;
            string rmStr;
            var reg = ReadAndDecodeAddressByte(out regStr, out rmStr, true);

            switch (reg)
            {
                // ADD r/m8, imm8
                case 0:
                    Instruction = "ADD " + rmStr + ", " + ByteToHex(GetNextByte());
                    break;

                // OR r/m8, imm8
                case 1:
                    Instruction = "OR " + rmStr + ", " + ByteToHex(GetNextByte());
                    break;

                // ADC r/m8, imm8
                case 2:
                    Instruction = "ADC " + rmStr + ", " + ByteToHex(GetNextByte());
                    break;

                // SBC r/m8, imm8
                case 3:
                    Instruction = "SBC " + rmStr + ", " + ByteToHex(GetNextByte());
                    break;

                // AND r/m8, imm8
                case 4:
                    Instruction = "AND " + rmStr + ", " + ByteToHex(GetNextByte());
                    break;

                // SUB r/m8, imm8
                case 5:
                    Instruction = "SUB " + rmStr + ", " + ByteToHex(GetNextByte());
                    break;

                // XOR r/m8, imm8
                case 6:
                    Instruction = "XOR " + rmStr + ", " + ByteToHex(GetNextByte());
                    break;

                // CMP r/m8, imm8
                case 7:
                    Instruction = "CMP " + rmStr + ", " + ByteToHex(GetNextByte());
                    break;
            }
        }

        private void HandleOpcode81()
        {
            string regStr;
            string rmStr;
            var reg = ReadAndDecodeAddressByte(out regStr, out rmStr, false);

            switch (reg)
            {
                // ADD r/m16, imm16
                case 0:
                    Instruction = "ADD " + rmStr + ", " + WordToHex(GetNextWord());
                    break;

                // OR r/m16, imm16
                case 1:
                    Instruction = "OR " + rmStr + ", " + WordToHex(GetNextWord());
                    break;

                // ADC r/m16, imm16
                case 2:
                    Instruction = "ADC " + rmStr + ", " + WordToHex(GetNextWord());
                    break;

                // SBC r/m16, imm16
                case 3:
                    Instruction = "SBC " + rmStr + ", " + WordToHex(GetNextWord());
                    break;

                // AND r/m16, imm16
                case 4:
                    Instruction = "AND " + rmStr + ", " + WordToHex(GetNextWord());
                    break;

                // SUB r/m16, imm16
                case 5:
                    Instruction = "SUB " + rmStr + ", " + WordToHex(GetNextWord());
                    break;

                // XOR r/m16, imm16
                case 6:
                    Instruction = "XOR " + rmStr + ", " + WordToHex(GetNextWord());
                    break;

                // CMP r/m16, imm16
                case 7:
                    Instruction = "CMP " + rmStr + ", " + WordToHex(GetNextWord());
                    break;
            }
        }

        private void HandleOpcode83()
        {
            string regStr;
            string rmStr;
            var reg = ReadAndDecodeAddressByte(out regStr, out rmStr, false);

            switch (reg)
            {
                // ADD r/m16, imm8
                case 0:
                    Instruction = "ADD " + rmStr + ", " + ByteToHex(GetNextByte());
                    break;

                // OR r/m16, imm8
                case 1:
                    Instruction = "OR " + rmStr + ", " + ByteToHex(GetNextByte());
                    break;

                // ADC r/m16, imm8
                case 2:
                    Instruction = "ADC " + rmStr + ", " + ByteToHex(GetNextByte());
                    break;

                // SBC r/m16, imm8
                case 3:
                    Instruction = "SBC " + rmStr + ", " + ByteToHex(GetNextByte());
                    break;

                // AND r/m16, imm8
                case 4:
                    Instruction = "AND " + rmStr + ", " + ByteToHex(GetNextByte());
                    break;

                // SUB r/m16, imm8
                case 5:
                    Instruction = "SUB " + rmStr + ", " + ByteToHex(GetNextByte());
                    break;

                // XOR r/m16, imm8
                case 6:
                    Instruction = "XOR " + rmStr + ", " + ByteToHex(GetNextByte());
                    break;
                    
                // CMP r/m16, imm8
                case 7:
                    Instruction = "CMP " + rmStr + ", " + ByteToHex(GetNextByte());
                    break;
            }
        }

        private void HandleOpcodeF6()
        {
            string regStr;
            string rmStr;
            var reg = ReadAndDecodeAddressByte(out regStr, out rmStr, true);

            switch (reg)
            {
                // TEST r/m8, imm8
                case 0:
                    Instruction = "TEST " + rmStr + ", " + ByteToHex(GetNextByte());
                    break;

                // NOT r/m8
                case 2:
                    Instruction = "NOT " + rmStr;
                    break;

                // NEG r/m8
                case 3:
                    Instruction = "NEG " + rmStr;
                    break;

                // MUL r/m8
                case 4:
                    Instruction = "MUL " + rmStr;
                    break;

                // IMUL r/m8
                case 5:
                    Instruction = "IMUL " + rmStr;
                    break;

                // DIV r/m8
                case 6:
                    Instruction = "DIV " + rmStr;
                    break;

                // IDIV r/m8
                case 7:
                    Instruction = "IDIV " + rmStr;
                    break;
            }
        }

        private void HandleOpcodeF7()
        {
            string regStr;
            string rmStr;
            var reg = ReadAndDecodeAddressByte(out regStr, out rmStr, false);

            switch (reg)
            {
                // TEST r/m16, imm16
                case 0:
                    Instruction = "TEST " + rmStr + ", " + WordToHex(GetNextWord());
                    break;

                // NOT r/m16
                case 2:
                    Instruction = "NOT " + rmStr;
                    break;

                // NEG r/m16
                case 3:
                    Instruction = "NEG " + rmStr;
                    break;

                // MUL r/m16
                case 4:
                    Instruction = "MUL " + rmStr;
                    break;

                // IMUL r/m16
                case 5:
                    Instruction = "IMUL " + rmStr;
                    break;

                // DIV r/m16
                case 6:
                    Instruction = "DIV " + rmStr;
                    break;

                // IDIV r/m16
                case 7:
                    Instruction = "IDIV " + rmStr;
                    break;
            }
        }

        private void HandleOpcodeD0()
        {
            string regStr;
            string rmStr;
            var reg = ReadAndDecodeAddressByte(out regStr, out rmStr, true);

            switch (reg)
            {
                // ROL r/m8, 1
                case 0:
                    Instruction = "ROL " + rmStr + ", 1";
                    break;

                // ROR r/m8, 1
                case 1:
                    Instruction = "ROR " + rmStr + ", 1";
                    break;

                // RCL r/m8, 1
                case 2:
                    Instruction = "RCL " + rmStr + ", 1";
                    break;

                // RCR r/m8, 1
                case 3:
                    Instruction = "RCR " + rmStr + ", 1";
                    break;

                // SHL r/m8, 1
                case 4:
                    Instruction = "SHL " + rmStr + ", 1";
                    break;

                // SHR r/m8, 1
                case 5:
                    Instruction = "SHR " + rmStr + ", 1";
                    break;

                // SAL r/m8, 1
                case 6:
                    Instruction = "SAL " + rmStr + ", 1";
                    break;

                // SAR r/m8, 1
                case 7:
                    Instruction = "SAR " + rmStr + ", 1";
                    break;
            }
        }

        private void HandleOpcodeD1()
        {
            string regStr;
            string rmStr;
            var reg = ReadAndDecodeAddressByte(out regStr, out rmStr, false);

            switch (reg)
            {
                // ROL r/m16, 1
                case 0:
                    Instruction = "ROL " + rmStr + ", 1";
                    break;

                // ROR r/m16, 1
                case 1:
                    Instruction = "ROR " + rmStr + ", 1";
                    break;

                // RCL r/m16, 1
                case 2:
                    Instruction = "RCL " + rmStr + ", 1";
                    break;

                // RCR r/m16, 1
                case 3:
                    Instruction = "RCR " + rmStr + ", 1";
                    break;

                // SHL r/m16, 1
                case 4:
                    Instruction = "SHL " + rmStr + ", 1";
                    break;

                // SHR r/m16, 1
                case 5:
                    Instruction = "SHR " + rmStr + ", 1";
                    break;

                // SAL r/m16, 1
                case 6:
                    Instruction = "SAL " + rmStr + ", 1";
                    break;

                // SAR r/m16, 1
                case 7:
                    Instruction = "SAR " + rmStr + ", 1";
                    break;
            }
        }

        private void HandleOpcodeD2()
        {
            string regStr;
            string rmStr;
            var reg = ReadAndDecodeAddressByte(out regStr, out rmStr, true);

            switch (reg)
            {
                // ROL r/m8, CL
                case 0:
                    Instruction = "ROL " + rmStr + ", CL";
                    break;

                // ROR r/m8, CL
                case 1:
                    Instruction = "ROR " + rmStr + ", CL";
                    break;

                // RCL r/m8, CL
                case 2:
                    Instruction = "RCL " + rmStr + ", CL";
                    break;

                // RCR r/m8, CL
                case 3:
                    Instruction = "RCR " + rmStr + ", CL";
                    break;

                // SHL r/m8, CL
                case 4:
                    Instruction = "SHL " + rmStr + ", CL";
                    break;

                // SHR r/m8, CL
                case 5:
                    Instruction = "SHR " + rmStr + ", CL";
                    break;

                // SAL r/m8, CL
                case 6:
                    Instruction = "SAL " + rmStr + ", CL";
                    break;

                // SAR r/m8, CL
                case 7:
                    Instruction = "SAR " + rmStr + ", CL";
                    break;
            }
        }

        private void HandleOpcodeD3()
        {
            string regStr;
            string rmStr;
            var reg = ReadAndDecodeAddressByte(out regStr, out rmStr, false);

            switch (reg)
            {
                // ROL r/m16, CL
                case 0:
                    Instruction = "ROL " + rmStr + ", CL";
                    break;

                // ROR r/m16, CL
                case 1:
                    Instruction = "ROR " + rmStr + ", CL";
                    break;

                // RCL r/m16, CL
                case 2:
                    Instruction = "RCL " + rmStr + ", CL";
                    break;

                // RCR r/m16, CL
                case 3:
                    Instruction = "RCR " + rmStr + ", CL";
                    break;

                // SHL r/m16, CL
                case 4:
                    Instruction = "SHL " + rmStr + ", CL";
                    break;

                // SHR r/m16, CL
                case 5:
                    Instruction = "SHR " + rmStr + ", CL";
                    break;

                // SAL r/m16, CL
                case 6:
                    Instruction = "SAL " + rmStr + ", CL";
                    break;

                // SAR r/m16, CL
                case 7:
                    Instruction = "SAR " + rmStr + ", CL";
                    break;
            }
        }

        private void HandleOpcodeC0()
        {
            string regStr;
            string rmStr;
            var reg = ReadAndDecodeAddressByte(out regStr, out rmStr, true);

            switch (reg)
            {
                // ROL r/m8, imm8 (80186+)
                case 0:
                    Instruction = "ROL " + rmStr + ", " + ByteToHex(GetNextByte());
                    break;

                // ROR r/m8, imm8 (80186+)
                case 1:
                    Instruction = "ROR " + rmStr + ", " + ByteToHex(GetNextByte());
                    break;

                // RCL r/m8, imm8 (80186+)
                case 2:
                    Instruction = "RCL " + rmStr + ", " + ByteToHex(GetNextByte());
                    break;

                // RCR r/m8, imm8 (80186+)
                case 3:
                    Instruction = "RCR " + rmStr + ", " + ByteToHex(GetNextByte());
                    break;

                // SHL r/m8, imm8 (80186+)
                case 4:
                    Instruction = "SHL " + rmStr + ", " + ByteToHex(GetNextByte());
                    break;

                // SHR r/m8, imm8 (80186+)
                case 5:
                    Instruction = "SHR " + rmStr + ", " + ByteToHex(GetNextByte());
                    break;

                // SAL r/m8, imm8 (80186+)
                case 6:
                    Instruction = "SAL " + rmStr + ", " + ByteToHex(GetNextByte());
                    break;

                // SAR r/m8, imm8 (80186+)
                case 7:
                    Instruction = "SAR " + rmStr + ", " + ByteToHex(GetNextByte());
                    break;
            }
        }

        private void HandleOpcodeC1()
        {
            string regStr;
            string rmStr;
            var reg = ReadAndDecodeAddressByte(out regStr, out rmStr, false);

            switch (reg)
            {
                // ROL r/m16, imm8 (80186+)
                case 0:
                    Instruction = "ROL " + rmStr + ", " + ByteToHex(GetNextByte());
                    break;

                // ROR r/m16, imm8 (80186+)
                case 1:
                    Instruction = "ROR " + rmStr + ", " + ByteToHex(GetNextByte());
                    break;

                // RCL r/m16, imm8 (80186+)
                case 2:
                    Instruction = "RCL " + rmStr + ", " + ByteToHex(GetNextByte());
                    break;

                // RCR r/m16, imm8 (80186+)
                case 3:
                    Instruction = "RCR " + rmStr + ", " + ByteToHex(GetNextByte());
                    break;

                // SHL r/m16, imm8 (80186+)
                case 4:
                    Instruction = "SHL " + rmStr + ", " + ByteToHex(GetNextByte());
                    break;

                // SHR r/m16, imm8 (80186+)
                case 5:
                    Instruction = "SHR " + rmStr + ", " + ByteToHex(GetNextByte());
                    break;

                // SAL r/m16, imm8 (80186+)
                case 6:
                    Instruction = "SAL " + rmStr + ", " + ByteToHex(GetNextByte());
                    break;

                // SAR r/m16, imm8 (80186+)
                case 7:
                    Instruction = "SAR " + rmStr + ", " + ByteToHex(GetNextByte());
                    break;
            }
        }
        
        private int ReadAndDecodeAddressByte(out string regStr, out string rmStr, bool byteOperation, bool useSreg = false)
        {
            var addressByte = GetNextByte();
            var mode = (addressByte & 0xc0) >> 6;
            var reg = (addressByte & 0x38) >> 3;
            var rm = addressByte & 0x07;

            regStr = byteOperation ? GetRegByte(reg) : GetRegWord(reg, useSreg);
            rmStr = "";

            switch (mode)
            {
                case 0:
                    switch (rm)
                    {
                        case 0:
                            rmStr = _segOverride + "[BX + SI]";
                            break;
                        case 1:
                            rmStr = _segOverride + "[BX + DI]";
                            break;
                        case 2:
                            rmStr = _segOverride + "[BP + SI]";
                            break;
                        case 3:
                            rmStr = _segOverride + "[BP + DI]";
                            break;
                        case 4:
                            rmStr = _segOverride + "[SI]";
                            break;
                        case 5:
                            rmStr = _segOverride + "[DI]";
                            break;
                        case 6:
                            var offs = GetNextWord();
                            rmStr = _segOverride + "[" + WordToHex(offs) + "]";
                            break;
                        case 7:
                            rmStr = _segOverride + "[BX]";
                            break;
                    }
                    break;

                case 1:
                    var disp8 = (sbyte)GetNextByte();
                    switch (rm)
                    {
                        case 0:
                            rmStr = _segOverride + "[BX + SI " + SByteToHex(disp8) + "]";
                            break;
                        case 1:
                            rmStr = _segOverride + "[BX + DI " + SByteToHex(disp8) + "]";
                            break;
                        case 2:
                            rmStr = _segOverride + "[BP + SI " + SByteToHex(disp8) + "]";
                            break;
                        case 3:
                            rmStr = _segOverride + "[BP + DI " + SByteToHex(disp8) + "]";
                            break;
                        case 4:
                            rmStr = _segOverride + "[SI " + SByteToHex(disp8) + "]";
                            break;
                        case 5:
                            rmStr = _segOverride + "[DI " + SByteToHex(disp8) + "]";
                            break;
                        case 6:
                            rmStr = _segOverride + "[BP " + SByteToHex(disp8) + "]";
                            break;
                        case 7:
                            rmStr = _segOverride + "[BX " + SByteToHex(disp8) + "]";
                            break;
                    }
                    break;

                case 2:
                    var disp16 = GetNextWord();
                    switch (rm)
                    {
                        case 0:
                            rmStr = _segOverride + "[BX + SI + " + WordToHex(disp16) + "]";
                            break;
                        case 1:
                            rmStr = _segOverride + "[BX + DI + " + WordToHex(disp16) + "]";
                            break;
                        case 2:
                            rmStr = _segOverride + "[BP + SI + " + WordToHex(disp16) + "]";
                            break;
                        case 3:
                            rmStr = _segOverride + "[BP + DI + " + WordToHex(disp16) + "]";
                            break;
                        case 4:
                            rmStr = _segOverride + "[SI + " + WordToHex(disp16) + "]";
                            break;
                        case 5:
                            rmStr = _segOverride + "[DI + " + WordToHex(disp16) + "]";
                            break;
                        case 6:
                            rmStr = _segOverride + "[BP + " + WordToHex(disp16) + "]";
                            break;
                        case 7:
                            rmStr = _segOverride + "[BX + " + WordToHex(disp16) + "]";
                            break;
                    }
                    break;

                case 3:
                    rmStr = byteOperation ? GetRegByte(rm) : GetRegWord(rm);
                    break;
            }
            return reg;
        }

        private string GetRegByte(int reg)
        {
            switch (reg)
            {
                case 0:
                    return "AL";
                case 1:
                    return "CL";
                case 2:
                    return "DL";
                case 3:
                    return "BL";
                case 4:
                    return "AH";
                case 5:
                    return "CH";
                case 6:
                    return "DH";
                case 7:
                    return "BH";
            }
            return "";
        }

        private string GetRegWord(int reg, bool useSreg = false)
        {
            if (useSreg)
            {
                switch (reg)
                {
                    case 0:
                        return "ES";
                    case 1:
                        return "CS";
                    case 2:
                        return "SS";
                    case 3:
                        return "DS";
                }
            }
            else
            {
                switch (reg)
                {
                    case 0:
                        return "AX";
                    case 1:
                        return "CX";
                    case 2:
                        return "DX";
                    case 3:
                        return "BX";
                    case 4:
                        return "SP";
                    case 5:
                        return "BP";
                    case 6:
                        return "SI";
                    case 7:
                        return "DI";
                }
            }
            return "";
        }

        /// <summary>
        /// converts byte to hex string
        /// </summary>
        /// <param name="value"></param>
        /// <returns></returns>
        private string ByteToHex(byte value)
        {
            return $"{value:X2}h";
        }

        /// <summary>
        /// convert word to hex string
        /// </summary>
        /// <param name="value"></param>
        /// <returns></returns>
        private string WordToHex(UInt16 value)
        {
            return $"{value:X4}h";
        }

        /// <summary>
        /// convert signed byte to hex string
        /// </summary>
        /// <param name="value"></param>
        /// <returns></returns>
        private static string SByteToHex(sbyte value)
        {
            return value > 0 ? $"+ {value:X2}h" : $"- {-value:X2}h";
        }

        /// <summary>
        /// convert signed word to hex string
        /// </summary>
        /// <param name="value"></param>
        /// <returns></returns>
        private static string SWordToHex(short value)
        {
            return value > 0 ? $"+ {value:X4}h" : $"- {-value:X4}h";
        }

        /// <summary>
        /// get next byte
        /// </summary>
        /// <returns></returns>
        private byte GetNextByte()
        {
            var b = _memory.Peek(_localAddress++);
            _hexValues.Add(b);
            return b;
        }

        /// <summary>
        /// get next word
        /// </summary>
        /// <returns></returns>
        private UInt16 GetNextWord()
        {
            var loByte = _memory.Peek(_localAddress++);
            _hexValues.Add(loByte);
            var hiByte = _memory.Peek(_localAddress++);
            _hexValues.Add(hiByte);
            return (UInt16)(loByte + (hiByte << 8));
        }
    }
}
