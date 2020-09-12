using Emulator.Components;
using Emulator.Utils;
using System;
using System.Reflection;

namespace Emulator.Lib.Components
{
    public class Ppi : BaseComponent, IPortProvider
    {
        private int _basePort;

        private byte _portA;
        private byte _portB;
        private byte _portC;

        public event Action PortChanged;

        public Ppi(int basePort)
        {
            _basePort = basePort;
        }

        public byte PortA => _portA;

        public byte PortB => _portB;

        public byte PortC => _portB;

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
                    _portA = (byte)value;
                    PortChanged?.Invoke();
                    break;

                // port B
                case 0x02:
                    _portB = (byte)value;
                    PortChanged?.Invoke();
                    break;

                // port C
                case 0x04:
                    _portC = (byte)value;
                    PortChanged?.Invoke();
                    break;

                // control port
                case 0x06:
                    break;
            }
        }
    }
}
