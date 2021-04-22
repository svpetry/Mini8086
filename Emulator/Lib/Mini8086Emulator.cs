using Emulator.CPU;
using Emulator.Lib;
using Emulator.Lib.Components;
using Emulator.Utils;
using System.Collections.Generic;
using System.Threading.Tasks;
using System.Windows.Media.Imaging;

namespace Emulator
{
    public class Mini8086Emulator
    {
        private Cpu8086 _cpu;
        private Rom _bios;
        private Ppi _ppi;
        private InterruptController _pic;
        private Timer _timer;
        private KeybController _keybController;
        private GraphicsAdapter _graphicsAdapter;
        private Lcd44780 _lcd;
        private SdController _sdController;

        private MemoryMapper _memMapper;
        private PortMapper _portMapper;

        private Disassembler _disassembler;

        public Ppi Ppi => _ppi;

        public Lcd44780 Lcd => _lcd;

        public KeybController KeybController => _keybController;

        public Cpu8086 Cpu => _cpu;

        public MemoryMapper MemMapper => _memMapper;

        public string DisassembledLine => _disassembler.DisassembledLine;

        public WriteableBitmap Screen => _graphicsAdapter.Screen;

        public bool EnableDisassembler { get; set; }

        public Mini8086Emulator()
        {
            var components = new List<BaseComponent>();

            _memMapper = new MemoryMapper(256);
            _portMapper = new PortMapper();

            _cpu = new Cpu8086(_memMapper, _portMapper);
            _disassembler = new Disassembler(_cpu, _memMapper);

            components.Add(_bios = new Rom(Config.BiosMemAddress));
            _memMapper.Register(Config.BiosMemAddress, Config.BiosMemAddress + Config.BiosMemSize - 1, _bios);

            components.Add(_pic = new InterruptController(Config.PicBasePort));
            _portMapper.Register(Config.PicBasePort, Config.PicBasePort + 0x07, _pic);

            components.Add(_timer = new Timer(Config.TimerBasePort, _pic));
            _portMapper.Register(Config.TimerBasePort, Config.TimerBasePort + 0x07, _timer);

            components.Add(_graphicsAdapter = new GraphicsAdapter(Config.VgaBasePort, Config.VgaMemAddress, _pic, @"..\..\..\ROMs\charrom.bin"));
            _portMapper.Register(Config.VgaBasePort, Config.VgaBasePort + 0x07, _graphicsAdapter);
            _memMapper.Register(Config.VgaMemAddress, Config.VgaMemAddress + Config.VgaMemSize - 1, _graphicsAdapter);

            components.Add(_lcd = new Lcd44780(Config.LcdBasePort));
            _portMapper.Register(Config.LcdBasePort, Config.LcdBasePort + 0x07, _lcd);

            //components.Add(_ppi = new Ppi(Config.PpiBasePort));
            //_portMapper.Register(Config.PpiBasePort, Config.PpiBasePort + 0x07, _ppi);

            components.Add(_keybController = new KeybController(Config.KeybControllerBasePort, _pic));
            _portMapper.Register(Config.KeybControllerBasePort, Config.KeybControllerBasePort + 0x07, _keybController);

            components.Add(_sdController = new SdController(Config.SdControllerBasePort, Config.SdImagePath));
            _portMapper.Register(Config.SdControllerBasePort, Config.SdControllerBasePort + 0x07, _sdController);

            _memMapper.FinishRegistration();
            
            components.ForEach(_ =>
            {
                _.EventTimer = _cpu;
                _.DoCpuInterrupt = _cpu.DoInterrupt;
            });
        }

        public void Init() 
        {
            _bios.Load(@"..\..\..\Apps\BIOS\bin\ROM0.bin", @"..\..\..\Apps\BIOS\bin\ROM1.bin");
        }

        public void Reset()
        {
            _cpu.Reset();
            _cpu.ExecNextInstruction();
            if (EnableDisassembler)
                _disassembler.DoDisassemble();
        }

        public void Step()
        {
            _cpu.ExecNextInstruction();
            if (EnableDisassembler)
                _disassembler.DoDisassemble();
        }

        public async Task UpdateScreen()
        {
            await _graphicsAdapter.UpdateScreen();
        }
    }
}
