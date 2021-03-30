using Emulator.Utils;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Emulator.Lib.Components
{
    /// <summary>
    ///     SD controller
    /// </summary>
    public class SdController : BaseComponent, IPortProvider
    {
        private int _basePort;

        private ISdCard _sdCard;

        private byte _control;

        private byte _receivedByte;

        public SdController(int basePort, string imgPath)
        {
            this._basePort = basePort;
            this._sdCard = new SdCard(imgPath);
        }

        public ushort In(int addr)
        {
            addr -= _basePort;
            switch (addr)
            {
                // control port
                case 0:
                    return _control;

                // status port
                case 1:
                    return 0b00000010;

                // data port
                case 2:
                    return _receivedByte;
            }
            return 0;
        }

        public void Out(int addr, ushort value, bool wordTransfer)
        {
            addr -= _basePort;
            switch (addr)
            {
                // control port
                case 0:
                    _control = (byte)value;
                    break;

                // data port
                case 2:
                    _receivedByte = _sdCard.TransferByte((byte)value);
                    break;
            }
        }
    }
}
