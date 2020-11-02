using Emulator.Utils;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Media;

namespace Emulator.Lib.Components
{
    public enum CursorDir
    {
        Left,
        Right
    }


    /// <summary>
    ///     HD44780 based 16x2 LC display (write-only)
    ///     
    ///     port bit    wire
    ///     0           D4
    ///     1           D5
    ///     2           D6
    ///     3           D7
    ///     4           RS
    ///     5           E
    ///     6           -
    ///     7           -
    /// </summary>
    public class Lcd44780 : BaseComponent, IPortProvider
    {
        private int _basePort;
        private int _lastE;
        private CursorDir _cursorDir;
        private bool _shift;

        private int _lastData;
        private int _dataPos;

        public Lcd44780(int basePort)
        {
            _basePort = basePort;
            Clear();
        }

        public event Action DisplayChanged;

        public string[] Lines { get; private set; } = new string[2];

        public bool DisplayActive { get; private set; }

        public bool CursorVisible { get; private set; }

        public bool CursorBlink { get; private set; }

        public int CursorCol { get; private set; }

        public int CursorRow { get; private set; }

        public ushort In(int addr)
        {
            throw new NotImplementedException();
        }

        public void Out(int addr, ushort value, bool wordTransfer)
        {
            switch (addr - _basePort)
            {
                case 0x00:
                    processPortChange((byte)value);
                    break;
            }
        }

        private void Clear()
        {
            Lines[0] = "                ";
            Lines[1] = "                ";
            CursorCol = 0;
            CursorRow = 0;
        }

        private void processPortChange(byte value)
        {
            var e = (value & 0b00100000) > 0 ? 1 : 0;
            if (_lastE == 1 && e == 0)
            {
                if (_dataPos == 0)
                {
                    _dataPos = 1;
                    _lastData = value & 0x0F;
                }
                else
                {
                    _dataPos = 0;
                    var data = (byte)((value & 0x0F) | (_lastData << 4));
                    var rs = (value & 0b00010000) > 0 ? 1 : 0;
                    if (rs == 0)
                        ExecuteCommand(data);
                    else
                        ProcessData(data);
                }
            }
            _lastE = e;
        }

        private void ExecuteCommand(byte cmd)
        {
            if (cmd == 1)
            {
                Clear();
            }
            else if (cmd < 4)
            {
                CursorCol = 0;
                CursorRow = 0;
            }
            else if (cmd < 8)
            {
                _shift = (cmd & 0x01) > 0;
                _cursorDir = (cmd & 0x02) > 0 ? CursorDir.Right : CursorDir.Left;
            }
            else if (cmd < 16)
            {
                DisplayActive = (cmd & 0x04) > 0;
                CursorVisible = (cmd & 0x02) > 0;
                CursorBlink = (cmd & 0x01) > 0;
            }
            else if (cmd < 32)
            {
                // cursor/display shift

            }
            else if (cmd < 64)
            {
                // function set
            }
            else if (cmd < 128)
            {
                // CG RAM address set
            }
            else
            {
                // DD RAM address set
                var addr = cmd & 0b01111111;
                if (addr < 0x40)
                {
                    CursorRow = 0;
                    CursorCol = addr;
                }
                else
                {
                    CursorRow = 1;
                    CursorCol = addr - 0x40;
                }
            }
        }

        private void ProcessData(byte data)
        {
            if (CursorCol < 16)
            {
                var chars = Lines[CursorRow].ToCharArray();
                chars[CursorCol] = (char)data;
                Lines[CursorRow] = new String(chars);

                if (_cursorDir == CursorDir.Right)
                    CursorCol++;
                else if (CursorCol > 0)
                    CursorCol--;

                DisplayChanged?.Invoke();
            }
        }
    }
}
