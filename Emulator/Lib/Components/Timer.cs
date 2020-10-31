using Emulator.Utils;
using System;

namespace Emulator.Lib.Components
{
    internal enum CounterAccess
    {
        LowNibble,
        HighNibble,
        LowAndHigh
    }

    internal enum CountMode
    {
        M16Bit,
        Bcd
    }

    internal sealed class Counter
    {
        const int CountsPerSec = 1000000; // 1 MHz
        const int CountsPerMs = CountsPerSec / 1000;

        private readonly Timer _timer;
        private readonly InterruptController _pic;
        private readonly int _counterNo;

        private int _byteNo;
        private CounterAccess _accessMode;
        private bool _isLatched;
        private ushort _latchValue;
        private int _mode;
        private bool _isRunning;

        private int _startValue;
        private long _startClockCount;
        private int _eventId;

        public Counter(Timer timer, InterruptController pic, int counterNo)
        {
            _timer = timer;
            _pic = pic;
            _counterNo = counterNo;
        }

        public event Action OnChangeFrequency;

        public CounterAccess AccessMode
        {
            get => _accessMode;
            set
            {
                _accessMode = value;
                _byteNo = 0;
            }
        }

        public int Frequency => CountsPerSec / _startValue;

        public CountMode CountMode { get; set; }

        public int Mode
        {
            get
            {
                return _mode;
            }
            set
            {
                _mode = value;

                if (_eventId > 0)
                    _timer.EventTimer.DeleteEvent(_eventId);

                switch (_mode)
                {
                    // interrupt on terminal count
                    case 0:
                        break;

                    // programmable one-shot
                    case 1:
                        throw new NotImplementedException();

                    // rate generator
                    case 2:
                        break;

                    // square wave generator
                    case 3:
                        break;

                    // software triggered strobe
                    case 4:
                        throw new NotImplementedException();

                    // hardware triggered strobe
                    case 5:
                        throw new NotImplementedException();
                }
            }
        }

        public HardwareInterrupt? GenerateTimerInt { get; set; }

        private ushort CalcValue()
        {
            if (_isRunning)
            {
                var elapsedMicroSeconds = ((_timer.EventTimer.ClockCount - _startClockCount) * 1000) / Settings.CpuFrequency;
                return (ushort)(_startValue - (int)((elapsedMicroSeconds * CountsPerMs) / 1000));
            }
            return 0;
        }

        private void WriteFinished()
        {
            _isRunning = true;
            if (_startValue == 0)
                _startValue = 0x10000;
            if (Mode == 3 || Mode == 2 || Mode == 0)
            {
                if (_eventId > 0)
                    _timer.EventTimer.DeleteEvent(_eventId);
                _startClockCount = _timer.EventTimer.ClockCount;
                _eventId = _timer.EventTimer.SetEvent((_startValue * 1000) / CountsPerMs, OnCountZero);

                OnChangeFrequency?.Invoke();
            }
        }

        private void OnCountZero()
        {
            if (GenerateTimerInt != null)
                _pic.DoInterrupt(GenerateTimerInt.Value);

            switch (Mode)
            {
                case 0:
                    _isRunning = false;
                    break;

                case 2:
                case 3:
                    _startClockCount = _timer.EventTimer.ClockCount;
                    _eventId = _timer.EventTimer.SetEvent((_startValue * 1000) / CountsPerMs, OnCountZero);
                    break;
            }

        }

        public void Reset()
        {
            _mode = 0;
            _eventId = 0;
            _isRunning = false;
            _byteNo = 0;
        }

        public void Write(byte value)
        {
            switch (AccessMode)
            {
                case CounterAccess.LowNibble:
                    _startValue = (ushort)((_startValue & 0xFF00) | value);
                    WriteFinished();
                    break;

                case CounterAccess.HighNibble:
                    _startValue = (ushort)((_startValue & 0x00FF) | (value << 8));
                    WriteFinished();
                    break;

                case CounterAccess.LowAndHigh:
                    if (_byteNo == 0)
                        _startValue = (ushort)((_startValue & 0xFF00) | value);
                    else
                    {
                        _startValue = (ushort)((_startValue & 0x00FF) | (value << 8));
                        WriteFinished();
                    }
                    _byteNo = 1 - _byteNo;
                    break;
            }
        }

        public byte Read()
        {
            byte result = 0;
            var val = _isLatched ? _latchValue : CalcValue();

            switch (AccessMode)
            {
                case CounterAccess.LowNibble:
                    result = (byte)(val & 0xFF);
                    _isLatched = false;
                    break;

                case CounterAccess.HighNibble:
                    result = (byte)(val >> 8);
                    _isLatched = false;
                    break;

                case CounterAccess.LowAndHigh:
                    if (_byteNo == 0)
                        result = (byte)(val & 0xFF);
                    else
                    {
                        result = (byte)(val >> 8);
                        _isLatched = false;
                    }
                    _byteNo = 1 - _byteNo;
                    break;
            }
            return result;
        }

        public void DoLatch()
        {
            _latchValue = CalcValue();
            _isLatched = true;
        }
    }

    /// <summary>
    ///     Timer 8254 (PIT)
    /// </summary>
    internal class Timer : BaseComponent, IPortProvider
    {
        private int _basePort;

        /// <summary>
        //      timer 0: IRQ0
        ///     timer 1: IRQ2
        ///     timer 2
        /// </summary>
        private readonly Counter[] _counters = new Counter[3];

        public Timer(int basePort, InterruptController pic)
        {
            _basePort = basePort;

            for (var idx = 0; idx < _counters.Length; idx++)
                _counters[idx] = new Counter(this, pic, idx);

            _counters[0].GenerateTimerInt = HardwareInterrupt.IRQ0;
            _counters[1].GenerateTimerInt = HardwareInterrupt.IRQ2;
        }

        public override void Reset()
        {
            base.Reset();
            foreach (var counter in _counters)
                counter.Reset();
        }

        #region IPortProvider

        public ushort In(int addr)
        {
            if (addr >= 0x40 && addr <= 0x42)
                return _counters[addr - 0x40].Read();

            return 0;
        }

        public void Out(int addr, ushort value, bool wordTransfer)
        {
            addr -= _basePort;

            if (addr >= 0x00 && addr <= 0x02)
                _counters[addr].Write((byte)(value & 0xff));

            // mode port
            if (addr == 0x03)
            {
                var cntrNo = (value >> 6) & 0x03;
                if (cntrNo > 2) return;

                var counter = _counters[cntrNo];
                var command = (value >> 4) & 0x03;
                var mode = (value >> 1) & 0x07;

                switch (command)
                {
                    // counter latch
                    case 0:
                        counter.DoLatch();
                        break;
                    case 1:
                        counter.AccessMode = CounterAccess.LowNibble;
                        break;
                    case 2:
                        counter.AccessMode = CounterAccess.HighNibble;
                        break;
                    case 3:
                        counter.AccessMode = CounterAccess.LowAndHigh;
                        break;
                }

                if (command != 0)
                {
                    counter.CountMode = (value & 1) > 0 ? CountMode.Bcd : CountMode.M16Bit;
                    counter.Mode = mode;
                }
            }
        }

        #endregion
    }
}

