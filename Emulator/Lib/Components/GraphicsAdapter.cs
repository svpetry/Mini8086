﻿using Emulator.Components;
using Emulator.Utils;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Media;
using System.Windows.Media.Imaging;

namespace Emulator.Lib.Components
{
    internal enum GraphicsMode
    {
        Text = 0,
        Graphics320x200x8 = 1
    }

    internal class WritePixelsInfo
    {
        public Int32Rect Rect { get; set; }
        public byte[] Pixels { get; set; }
        public int Stride { get; set; }
    }

    public class GraphicsAdapter : BaseComponent, IPortProvider, IMemoryProvider
    {
        private const int ScreenWidth = 640;
        private const int ScreenHeight = 400;
        private const int RowCount = 25;
        private const int ColCount = 80;
        private const int CharWidth = 8;
        private const int CharHeight = 16;


        private IInterrupt _cpu;
        private readonly int _basePort;
        private readonly int _baseMemAddress;
        private readonly WriteableBitmap _screen;
        private readonly int _bytesPerPixel;
        private GraphicsMode _mode;

        private byte[][] _memory;
        private byte[] _charRom;

        private int _activePlane;
        private byte _backgroundColor;
        private bool _enableRetraceInterrupt;

        public GraphicsAdapter(IInterrupt cpu, int basePort, int baseMemAddress, string characterRomPath)
        {
            _cpu = cpu;
            _basePort = basePort;
            _baseMemAddress = baseMemAddress;

            _screen = new WriteableBitmap(ScreenWidth, ScreenHeight, 96, 96, PixelFormats.Bgr32, null);
            _bytesPerPixel = _screen.Format.BitsPerPixel / 8;

            // two planes with 64k bytes each
            _memory = new byte[2][];
            _memory[0] = new byte[0x10000];
            _memory[1] = new byte[0x10000];

            _charRom = File.ReadAllBytes(characterRomPath);
        }

        public WriteableBitmap Screen => _screen;

        public bool SupportWrite => true;

        public bool SupportRead => true;
        
        public ushort In(int addr)
        {
            switch (addr - _basePort)
            {
                // control port
                case 0x00:
                    var value = (byte)_mode;
                    if (_activePlane > 0)
                        value |= 0b00000100;
                    if (_enableRetraceInterrupt)
                        value |= 0b00100000;
                    return value;

                // background color
                case 0x02:
                    return _backgroundColor;

                case 0x04:
                    return 0x00;

                case 0x06:
                    return 0x00;
            }
            return 0x00;
        }

        public void Out(int addr, ushort value, bool wordTransfer)
        {
            switch (addr - _basePort)
            {
                // control port
                case 0x00:
                    _mode = (GraphicsMode)(value & 0b00000011);
                    _activePlane = (value & 0b00000100) > 0 ? 1 : 0;
                    _enableRetraceInterrupt = (value & 0b00100000) > 0;
                    break;

                // background color
                case 0x02:
                    _backgroundColor = (byte)value;
                    break;

                case 0x04:
                    break;

                case 0x06:
                    break;
            }
        }

        public byte Peek(int addr)
        {
                var memAddr = addr - _baseMemAddress;
            if (memAddr < 0x10000)
                return _memory[0][memAddr];
            return _memory[1][memAddr - 0x10000];
        }

        public void Poke(int addr, byte value)
        {
            var memAddr = addr - _baseMemAddress;
            if (memAddr < 0x10000)
                _memory[0][memAddr] = value;
            else
                _memory[1][memAddr - 0x10000] = value;
        }

        private WritePixelsInfo PrepareDrawChar(int col, int row)
        {
            if (col >= ColCount || row >= RowCount) return null;

            var rect = new Int32Rect(col * CharWidth, row * CharHeight, CharWidth, CharHeight);
            var stride = rect.Width * _bytesPerPixel;

            byte[] pixels;

            var addr = (row * ColCount + col) * 2;
            var chr = _memory[_activePlane][row * ColCount + col];
            var color = _memory[_activePlane][row * ColCount + col];
            pixels = GetChar(chr, color, _backgroundColor);
            return new WritePixelsInfo { Pixels = pixels, Rect = rect, Stride = stride };
        }

        public static byte[] GetChar(byte charCode, byte fgColor, byte bgColor)
        {
            var result = new byte[CharWidth * CharHeight * 4];
            var resultIdx = 0;

            for (int idx = 0; idx < CharWidth * CharHeight; idx++)
            {
                if (FCharacters[chrCode, idx] == (invert ? 0 : 1))
                {
                    result[resultIdx] = fgColor.B;
                    result[resultIdx + 1] = fgColor.G;
                    result[resultIdx + 2] = fgColor.R;
                }
                else
                {
                    result[resultIdx] = bgColor.B;
                    result[resultIdx + 1] = bgColor.G;
                    result[resultIdx + 2] = bgColor.R;
                }
                resultIdx += 4;
            }
            return result;
        }
    }
}