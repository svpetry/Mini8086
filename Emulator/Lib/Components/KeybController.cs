using Emulator.Utils;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Emulator.Lib.Components
{
    /// <summary>
    ///     8042 keyboard controller
    /// </summary>
    public class KeybController : BaseComponent, IPortProvider
    {
        private int _basePort;

        public KeybController(int basePort)
        {
            this._basePort = basePort;
        }

        public ushort In(int addr)
        {
            return 0;
        }

        public void Out(int addr, ushort value, bool wordTransfer)
        {
        }
    }
}
