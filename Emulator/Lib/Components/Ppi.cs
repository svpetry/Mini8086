using Emulator.Components;
using Emulator.Utils;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Emulator.Lib.Components
{
    public class Ppi : BaseComponent, IPortProvider
    {
        private int _basePort;

        public Ppi(int basePort)
        {
            _basePort = basePort;
        }

        public ushort In(int addr)
        {
            return 0;
        }

        public void Out(int addr, ushort value, bool wordTransfer)
        {
            switch (addr - _basePort)
            {
                // port A
                case 0x00:
                    break;

                // port B
                case 0x02:
                    break;

                // port C
                case 0x04:
                    break;

                // control port
                case 0x06:
                    break;
            }
        }
    }
}
