using Emulator.Components;
using Emulator.CPU;
using Emulator.Lib;
using Emulator.Lib.Components;
using Emulator.Utils;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Media.Imaging;
using System.Windows.Threading;

namespace Emulator
{
    public class Mini8086Emulator
    {
        private Cpu8086 _cpu;
        private Rom _bios;
        private Ppi _ppi;
        private Pic _pic;
        private Timer _timer;
        private KeybController _keybController;
        private GraphicsAdapter _graphicsAdapter;

        private MemoryMapper _memMapper;
        private PortMapper _portMapper;

        private Disassembler _disassembler;

        public Ppi Ppi => _ppi;

        public Cpu8086 Cpu => _cpu;

        public MemoryMapper MemMapper => _memMapper;

        public string DisassembledLine => _disassembler.DisassembledLine;

        public WriteableBitmap Screen => _graphicsAdapter.Screen;

        public Mini8086Emulator()
        {
            _memMapper = new MemoryMapper(512);
            _portMapper = new PortMapper();

            _cpu = new Cpu8086(_memMapper, _portMapper);
            _disassembler = new Disassembler(_cpu, _memMapper);

            _bios = new Rom(Config.BiosMemAddress);
            _memMapper.Register(Config.BiosMemAddress, Config.BiosMemAddress + Config.BiosMemSize - 1, _bios);

            _timer = new Timer(Config.TimerBasePort);
            _portMapper.Register(Config.TimerBasePort, Config.TimerBasePort + 0x07, _timer);

            _pic = new Pic(Config.PicBasePort, _cpu);
            _portMapper.Register(Config.PicBasePort, Config.PicBasePort + 0x07, _pic);

            _graphicsAdapter = new GraphicsAdapter(_cpu, Config.VgaBasePort, Config.VgaMemAddress, @"..\..\..\ROMs\charrom.bin");
            _portMapper.Register(Config.VgaBasePort, Config.VgaBasePort + 0x07, _graphicsAdapter);
            _memMapper.Register(Config.VgaMemAddress, Config.VgaMemAddress + Config.VgaMemSize - 1, _graphicsAdapter);

            _ppi = new Ppi(Config.PpiBasePort);
            _portMapper.Register(Config.PpiBasePort, Config.PpiBasePort + 0x07, _ppi);

            _memMapper.FinishRegistration();
        }

        public void Init() 
        {
            _bios.Load(@"..\..\..\BIOS\ROM0.bin", @"..\..\..\BIOS\ROM1.bin");
        }

        public void Reset()
        {
            _cpu.Reset();
            _cpu.ExecNextInstruction();
            _disassembler.DoDisassemble();
        }

        public void Step()
        {
            _cpu.ExecNextInstruction();
            _disassembler.DoDisassemble();
        }

        public void UpdateScreen()
        {
            _graphicsAdapter.UpdateScreen();
        }
    }
}
