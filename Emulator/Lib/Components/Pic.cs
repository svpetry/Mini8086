using Emulator.Components;
using Emulator.Utils;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Emulator.Lib.Components
{
    public class Pic : BaseComponent, IPortProvider
    {
        private int _basePort;

        private IInterrupt _cpu;

        public Pic(int basePort, IInterrupt cpu)
        {
            _basePort = basePort;
            _cpu = cpu;
        }

        public ushort In(int addr)
        {
            throw new NotImplementedException();
        }

        public void Out(int addr, ushort value, bool wordTransfer)
        {
        }
    }
}
