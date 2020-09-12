using Emulator.Components;
using Emulator.CPU;
using Emulator.Lib.Components;
using Emulator.Utils;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Emulator
{
    public class Mini8086Emulator
    {
        private Cpu8086 _cpu;
        private Rom _bios;
        private Ppi _ppi;

        private MemoryMapper _memMapper;
        private PortMapper _portMapper;

        private Disassembler _disassembler;

        public Ppi Ppi => _ppi;

        public Cpu8086 Cpu => _cpu;

        public MemoryMapper MemMapper => _memMapper;

        public string DisassembledLine => _disassembler.DisassembledLine;

        public Mini8086Emulator()
        {
            _memMapper = new MemoryMapper(64);
            _portMapper = new PortMapper();

            _cpu = new Cpu8086(_memMapper, _portMapper);
            _disassembler = new Disassembler(_cpu, _memMapper);

            _bios = new Rom(0xE0000);
            _memMapper.Register(0xE0000, 0xFFFFF, _bios);

            _ppi = new Ppi(0x008);
            _portMapper.Register(0x008, 0x00F, _ppi);

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
    }
}
