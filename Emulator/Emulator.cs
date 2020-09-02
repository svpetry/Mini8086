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
    public class Emulator
    {
        private Cpu8086 _cpu;
        private Rom _bios;
        private Ppi _ppi;

        private MemoryMapper _memMapper;
        private PortMapper _portMapper;

        private Disassembler _disassembler;

        public Emulator()
        {
            _memMapper = new MemoryMapper(64);
            _portMapper = new PortMapper();

            _cpu = new Cpu8086(_memMapper, _portMapper);
            _bios = new Rom(0xE0000);
            _ppi = new Ppi(0x008);
            _portMapper.Register(0x008, 0x00F, _ppi);

            _disassembler = new Disassembler(_cpu, _memMapper);
        }
    }
}
