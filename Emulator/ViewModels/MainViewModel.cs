using CommonUtils;
using Emulator.CPU;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Diagnostics;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Media;
using System.Windows.Threading;

namespace Emulator.ViewModels
{
    public class MainViewModel : BaseViewModel
    {
        Mini8086Emulator _emulator;
        Disassembler _disassembler;

        private byte _portA;
        private byte _portB;
        private byte _portC;

        private string _lcdLine1;
        private string _lcdLine2;

        private bool _doStop;

        private DispatcherTimer _screenTimer;

        private ImageSource _screenSource;

        #region Register fields

        private ushort _ax;
        private ushort _bx;
        private ushort _cx;
        private ushort _dx;
        private ushort _si;
        private ushort _di;
        private ushort _bp;
        private ushort _sp;
        private ushort _cs;
        private ushort _ds;
        private ushort _es;
        private ushort _ss;

        #endregion

        public ObservableCollection<string> DisassembledLines { get; } = new ObservableCollection<string>();

        #region Ports

        public byte PortA
        {
            get => _portA;
            set
            {
                if (_portA == value) return;
                _portA = value;
                OnPropertyChanged();
            }
        }

        public byte PortB
        {
            get => _portB;
            set
            {
                if (_portB == value) return;
                _portB = value;
                OnPropertyChanged();
            }
        }

        public byte PortC
        {
            get => _portC;
            set
            {
                if (_portC == value) return;
                _portC = value;
                OnPropertyChanged();
            }
        }

        public string LcdLine1
        {
            get => _lcdLine1;
            set
            {
                if (_lcdLine1 == value) return;
                _lcdLine1 = value;
                OnPropertyChanged();
            }
        }

        public string LcdLine2
        {
            get => _lcdLine2;
            set
            {
                if (_lcdLine2 == value) return;
                _lcdLine2 = value;
                OnPropertyChanged();
            }
        }

        #endregion

        #region Registers

        public ushort AX
        {
            get => _ax;
            set
            {
                if (_ax == value) return;
                _ax = value;
                OnPropertyChanged();
            }
        }

        public ushort BX
        {
            get => _bx;
            set
            {
                if (_bx == value) return;
                _bx = value;
                OnPropertyChanged();
            }
        }

        public ushort CX
        {
            get => _cx;
            set
            {
                if (_cx == value) return;
                _cx = value;
                OnPropertyChanged();
            }
        }

        public ushort DX
        {
            get => _dx;
            set
            {
                if (_dx == value) return;
                _dx = value;
                OnPropertyChanged();
            }
        }

        public ushort SI
        {
            get => _si;
            set
            {
                if (_si == value) return;
                _si = value;
                OnPropertyChanged();
            }
        }

        public ushort DI
        {
            get => _di;
            set
            {
                if (_di == value) return;
                _di = value;
                OnPropertyChanged();
            }
        }

        public ushort SP
        {
            get => _sp;
            set
            {
                if (_sp == value) return;
                _sp = value;
                OnPropertyChanged();
            }
        }

        public ushort BP
        {
            get => _bp;
            set
            {
                if (_bp == value) return;
                _bp = value;
                OnPropertyChanged();
            }
        }

        public ushort CS
        {
            get => _cs;
            set
            {
                if (_cs == value) return;
                _cs = value;
                OnPropertyChanged();
            }
        }

        public ushort DS
        {
            get => _ds;
            set
            {
                if (_ds == value) return;
                _ds = value;
                OnPropertyChanged();
            }
        }

        public ushort ES
        {
            get => _es;
            set
            {
                if (_es == value) return;
                _es = value;
                OnPropertyChanged();
            }
        }

        public ushort SS
        {
            get => _ss;
            set
            {
                if (_ss == value) return;
                _ss = value;
                OnPropertyChanged();
            }
        }

        #endregion

        public ActionCommand StartCommand { get; }

        public ActionCommand StopCommand { get; }

        public ActionCommand StepCommand { get; }

        public ActionCommand ResetCommand { get; }

        public bool EnableDisassembler
        {
            get => _emulator.EnableDisassembler;
            set
            {
                if (_emulator.EnableDisassembler == value) return;
                _emulator.EnableDisassembler = value;
                OnPropertyChanged();
            }
        }

        public ImageSource ScreenSource
        {
            get
            {
                return _screenSource;
            }
            set
            {
                _screenSource = value;
                OnPropertyChanged();
            }
        }

        public MainViewModel()
        {
            StartCommand = new ActionCommand(Start);
            StopCommand = new ActionCommand(Stop) { Enabled = false };
            StepCommand = new ActionCommand(Step);
            ResetCommand = new ActionCommand(Reset);

            _emulator = new Mini8086Emulator();
            _emulator.Init();
            //_emulator.Ppi.PortChanged += Ppi_PortChanged;
            _emulator.Lcd.DisplayChanged += Lcd_DisplayChanged;

            _disassembler = new Disassembler(_emulator.Cpu, _emulator.MemMapper);

            Reset(null);
        }

        private void Lcd_DisplayChanged()
        {
            LcdLine1 = _emulator.Lcd.Lines[0];
            LcdLine2 = _emulator.Lcd.Lines[1];
        }

        private void Start(object Param)
        {
            if (_screenTimer == null)
                InitScreenTimer();

            StartCommand.Enabled = false;
            StepCommand.Enabled = false;
            ResetCommand.Enabled = false;
            StopCommand.Enabled = true;

            Task.Run(() =>
            {
                const int updateFrequency = 50;
                var periodTicks = Stopwatch.Frequency / updateFrequency;
                var ticksPer10Ms = Stopwatch.Frequency / 100;

                long periodClockCount = (Settings.CpuFrequency * 1000) / updateFrequency;
                long sleepTicks = 0;

                var lines = new Queue<string>();

                var stopWatch = new Stopwatch();
                while (!_doStop)
                {
                    stopWatch.Restart();
                    var endCount = _emulator.Cpu.ClockCount + periodClockCount;
                    while (_emulator.Cpu.ClockCount < endCount && !_doStop)
                    {
                        _emulator.Step();
                        if (_emulator.EnableDisassembler)
                        {
                            lines.Enqueue(_emulator.DisassembledLine);
                            if (lines.Count > 1000)
                                lines.Dequeue();
                        }
                    }
                    stopWatch.Stop();

                    if (stopWatch.ElapsedTicks < periodTicks && !_doStop)
                    {
                        sleepTicks += periodTicks - stopWatch.ElapsedTicks;

                        if (sleepTicks > ticksPer10Ms)
                        {
                            sleepTicks -= ticksPer10Ms;
                            Task.Delay(10).Wait();
                        }
                    }
                }
                _doStop = false;

                Application.Current.Dispatcher.Invoke(() =>
                    {
                        DisassembledLines.Clear();
                        foreach (var line in lines)
                            DisassembledLines.Add(line);
                        UpdateRegisters();
                        StartCommand.Enabled = true;
                        StepCommand.Enabled = true;
                        ResetCommand.Enabled = true;
                        StopCommand.Enabled = false;
                    });
            });
        }

        private void Stop(object Param)
        {
            _doStop = true;
        }

        private void Step(object Param)
        {
            _emulator.Step();
            if (_emulator.EnableDisassembler)
                DisassembledLines.Add(_emulator.DisassembledLine);
            OnPropertyChanged(nameof(DisassembledLines));
            UpdateRegisters();
        }

        private void Reset(object Param)
        {
            DisassembledLines.Clear();
            _emulator.Reset();
            if (_emulator.EnableDisassembler)
            {
                DisassembledLines.Add(_emulator.DisassembledLine);
                if (DisassembledLines.Count > 1000)
                    DisassembledLines.RemoveAt(0);
            }
            OnPropertyChanged(nameof(DisassembledLines));
            UpdateRegisters();
        }

        private void UpdateRegisters()
        {
            AX = _emulator.Cpu.AX;
            BX = _emulator.Cpu.BX;
            CX = _emulator.Cpu.CX;
            DX = _emulator.Cpu.DX;
            SI = _emulator.Cpu.SI;
            DI = _emulator.Cpu.DI;
            SP = _emulator.Cpu.SP;
            BP = _emulator.Cpu.BP;
            CS = _emulator.Cpu.CS;
            DS = _emulator.Cpu.DS;
            ES = _emulator.Cpu.ES;
            SS = _emulator.Cpu.SS;
        }

        private void InitScreenTimer()
        {
            _screenTimer?.Stop();

            _screenTimer = new DispatcherTimer { Interval = new TimeSpan(0, 0, 0, 0, 1000 / Settings.ScreenUpdateRate) };
            _screenTimer.Tick += UpdateScreen;
            _screenTimer.Start();
        }

        private async void UpdateScreen(object sender, EventArgs e)
        {
            await _emulator.UpdateScreen();
            ScreenSource = _emulator.Screen;
        }
    }
}
