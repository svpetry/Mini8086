﻿using Emulator.Components;
using Emulator.Utils;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Emulator.Lib.Components
{
    public class KeybController : BaseComponent, IPortProvider
    {
        int _basePort;

        public KeybController(int basePort)
        {
            this._basePort = basePort;
        }

        public ushort In(int addr)
        {
            throw new NotImplementedException();
        }

        public void Out(int addr, ushort value, bool wordTransfer)
        {
            throw new NotImplementedException();
        }
    }
}
