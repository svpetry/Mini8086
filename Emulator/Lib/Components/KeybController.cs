using Emulator.Utils;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Input;

namespace Emulator.Lib.Components
{
    public enum KeyAction
    {
        Press,
        Release
    }

    /// <summary>
    ///     8042 keyboard controller
    /// </summary>
    public class KeybController : BaseComponent, IPortProvider
    {
        private int _basePort;
        private InterruptController _interruptController;

        private Queue<byte> _outputBuffer = new Queue<byte>();
        private Queue<byte> _inputBuffer = new Queue<byte>();

        private byte _configReg;
        private bool _writeConfigActive;

        public KeybController(int basePort, InterruptController interruptController)
        {
            this._basePort = basePort;
            this._interruptController = interruptController;
        }

        public bool KeyboardEnabled => (_configReg & 0b00010000) == 0;

        public ushort In(int addr)
        {
            addr -= _basePort;
            switch (addr)
            {
                // output register
                case 0x00:
                    if (_outputBuffer.Count > 0) return _outputBuffer.Dequeue();
                    break;

                // status register
                case 0x04:
                    return _outputBuffer.Count > 0 ? (ushort)0b00010001 : (ushort)0b00010000;
            }
            return 0;
        }

        public void Out(int addr, ushort value, bool wordTransfer)
        {
            addr -= _basePort;
            switch (addr)
            {
                // data register
                case 0x00:
                    {
                        if (_writeConfigActive)
                        {
                            _configReg = (byte)value;
                            _writeConfigActive = false;
                        }
                        break;
                    }

                // command register
                case 0x04:
                    {
                        ProcessCommand((byte)value);
                        break;
                    }
            }
        }

        public void KeyUp(Key key)
        {
            if (!KeyboardEnabled) return;
            var keyCodes = GetScanCodes(key, KeyAction.Release);
            foreach (var code in keyCodes)
                _outputBuffer.Enqueue(code);
            if ((_configReg & 0x01) > 0)
                _interruptController.DoInterrupt(HardwareInterrupt.IRQ1);
        }

        public void KeyDown(Key key)
        {
            if (!KeyboardEnabled) return;
            var keyCodes = GetScanCodes(key, KeyAction.Press);
            foreach (var code in keyCodes)
                _outputBuffer.Enqueue(code);
        }

        private void ProcessCommand(byte command)
        {
            switch (command)
            {
                // read configuration byte
                case 0x20:
                    _outputBuffer.Enqueue(_configReg);
                    break;
                // write configuration byte
                case 0x60:
                    _writeConfigActive = true;
                    break;
                // auxiliary interface test
                case 0xA9:
                    _outputBuffer.Enqueue(0x00);
                    break;
                // self test
                case 0xAA:
                    _outputBuffer.Enqueue(0x55);
                    break;
                // keyboard interface test
                case 0xAB:
                    _outputBuffer.Enqueue(0x00);
                    break;
                // enable keyboard interface
                case 0xAE:
                    _configReg = (byte)(_configReg & 0b11101111);
                    break;
            }
        }

        private byte[] GetScanCodes(Key key, KeyAction keyAction)
        {
            var scanCodes = new List<byte>();
            switch (key)
            {
                case Key.Escape:
                    scanCodes.Add(0x76);
                    break;
                case Key.D1:
                    scanCodes.Add(0x16);
                    break;
                case Key.D2:
                    scanCodes.Add(0x1E);
                    break;
                case Key.D3:
                    scanCodes.Add(0x26);
                    break;
                case Key.D4:
                    scanCodes.Add(0x25);
                    break;
                case Key.D5:
                    scanCodes.Add(0x2E);
                    break;
                case Key.D6:
                    scanCodes.Add(0x36);
                    break;
                case Key.D7:
                    scanCodes.Add(0x3D);
                    break;
                case Key.D8:
                    scanCodes.Add(0x3E);
                    break;
                case Key.D9:
                    scanCodes.Add(0x46);
                    break;
                case Key.D0:
                    scanCodes.Add(0x45);
                    break;
                //case Key.Oem4:
                //    scanCodes.Add(0x0C);
                //    break;
                //case Key.Oem6:
                //    scanCodes.Add(0x0D);
                //    break;
                case Key.Back:
                    scanCodes.Add(0x66);
                    break;
                case Key.Tab:
                    scanCodes.Add(0x0D);
                    break;
                case Key.Q:
                    scanCodes.Add(0x15);
                    break;
                case Key.W:
                    scanCodes.Add(0x1D);
                    break;
                case Key.E:
                    scanCodes.Add(0x24);
                    break;
                case Key.R:
                    scanCodes.Add(0x2D);
                    break;
                case Key.T:
                    scanCodes.Add(0x2C);
                    break;
                case Key.Z:
                    scanCodes.Add(0x35);
                    break;
                case Key.U:
                    scanCodes.Add(0x3C);
                    break;
                case Key.I:
                    scanCodes.Add(0x34);
                    break;
                case Key.O:
                    scanCodes.Add(0x44);
                    break;
                case Key.P:
                    scanCodes.Add(0x4D);
                    break;
                //case Key.Oem1:
                //    scanCodes.Add(0x1A);
                //    break;
                //case Key.OemPlus:
                //    scanCodes.Add(0x1B);
                //    break;
                case Key.Return:
                    scanCodes.Add(0x5A);
                    break;
                case Key.CapsLock:
                    scanCodes.Add(0x58);
                    break;
                case Key.A:
                    scanCodes.Add(0x1C);
                    break;
                case Key.S:
                    scanCodes.Add(0x1B);
                    break;
                case Key.D:
                    scanCodes.Add(0x23);
                    break;
                case Key.F:
                    scanCodes.Add(0x2B);
                    break;
                case Key.G:
                    scanCodes.Add(0x34);
                    break;
                case Key.H:
                    scanCodes.Add(0x33);
                    break;
                case Key.J:
                    scanCodes.Add(0x3B);
                    break;
                case Key.K:
                    scanCodes.Add(0x42);
                    break;
                case Key.L:
                    scanCodes.Add(0x4B);
                    break;
                //case Key.Oem3:
                //    scanCodes.Add(0x27);
                //    break;
                //case Key.Oem7:
                //    scanCodes.Add(0x28);
                //    break;
                //case Key.Oem2:
                //    scanCodes.Add(0x29);
                //    break;
                case Key.LeftShift:
                    scanCodes.Add(0x12);
                    break;
                //case Key.Oem102:
                //    scanCodes.Add(0x2B);
                //    break;
                case Key.Y:
                    scanCodes.Add(0x1A);
                    break;
                case Key.X:
                    scanCodes.Add(0x22);
                    break;
                case Key.C:
                    scanCodes.Add(0x21);
                    break;
                case Key.V:
                    scanCodes.Add(0x2A);
                    break;
                case Key.B:
                    scanCodes.Add(0x32);
                    break;
                case Key.N:
                    scanCodes.Add(0x31);
                    break;
                case Key.M:
                    scanCodes.Add(0x3A);
                    break;
                case Key.OemComma:
                    scanCodes.Add(0x41);
                    break;
                case Key.OemPeriod:
                    scanCodes.Add(0x49);
                    break;
                case Key.OemMinus:
                    scanCodes.Add(0x4A);
                    break;
                case Key.RightShift:
                    scanCodes.Add(0x59);
                    break;
                case Key.LeftCtrl:
                    scanCodes.Add(0x14);
                    break;
                case Key.LeftAlt:
                    scanCodes.Add(0x11);
                    break;
                case Key.Space:
                    scanCodes.Add(0x29);
                    break;
                case Key.RightAlt:
                    scanCodes.Add(0xE0);
                    scanCodes.Add(0x11);
                    break;
                case Key.RightCtrl:
                    scanCodes.Add(0xE0);
                    scanCodes.Add(0x14);
                    break;
                case Key.F1:
                    scanCodes.Add(0x05);
                    break;
                case Key.F2:
                    scanCodes.Add(0x06);
                    break;
                case Key.F3:
                    scanCodes.Add(0x04);
                    break;
                case Key.F4:
                    scanCodes.Add(0x0C);
                    break;
                case Key.F5:
                    scanCodes.Add(0x03);
                    break;
                case Key.F6:
                    scanCodes.Add(0x0B);
                    break;
                case Key.F7:
                    scanCodes.Add(0x83);
                    break;
                case Key.F8:
                    scanCodes.Add(0x0A);
                    break;
                case Key.F9:
                    scanCodes.Add(0x01);
                    break;
                case Key.F10:
                case Key.System:
                    scanCodes.Add(0x09);
                    break;
                case Key.F11:
                    scanCodes.Add(0x78);
                    break;
                case Key.F12:
                    scanCodes.Add(0x07);
                    break;
                //case Key.Prior:
                //    scanCodes.Add(0x49);
                //    break;
                //case Key.Next:
                //    scanCodes.Add(0x51);
                //    break;
                case Key.Left:
                    scanCodes.Add(0xE0);
                    scanCodes.Add(0x6B);
                    break;
                case Key.Right:
                    scanCodes.Add(0xE0);
                    scanCodes.Add(0x74);
                    break;
                case Key.Up:
                    scanCodes.Add(0xE0);
                    scanCodes.Add(0x75);
                    break;
                case Key.Down:
                    scanCodes.Add(0xE0);
                    scanCodes.Add(0x72);
                    break;
                case Key.Home:
                    scanCodes.Add(0x6C);
                    break;
                case Key.End:
                    scanCodes.Add(0x69);
                    break;
                case Key.Delete:
                    scanCodes.Add(0x71);
                    break;
                case Key.Insert:
                    scanCodes.Add(0x70);
                    break;
            }
            if (keyAction == KeyAction.Release && scanCodes.Count > 0)
                scanCodes.Insert(0, 0xF0);
            return scanCodes.ToArray();
        }
    }
}
