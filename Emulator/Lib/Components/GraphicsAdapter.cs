using Emulator.Components;
using Emulator.Utils;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Input;
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
        private GraphicsMode _mode = GraphicsMode.Text;

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
            foreach (var mem in _memory)
                MemUtils.RandomFill(mem);
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

        public void UpdateScreen()
        {
            WritePixelsInfo[] writePixelsInfos = null;

            switch (_mode)
            {
                case GraphicsMode.Text:
                    writePixelsInfos = new WritePixelsInfo[RowCount * ColCount];
                    Parallel.For(
                        0,
                        RowCount,
                        row =>
                        {
                            for (var col = 0; col < ColCount; col++)
                                writePixelsInfos[row * ColCount + col] = PrepareDrawChar(col, row);
                        });
                    break;

                case GraphicsMode.Graphics320x200x8:
                    writePixelsInfos = new WritePixelsInfo[RowCount];
                    var mem = _memory[_activePlane];
                    Parallel.For(
                        0,
                        RowCount,
                        row =>
                        {
                            var rect = new Int32Rect(0, row * CharHeight, ScreenWidth, CharHeight);
                            var pixels = new byte[rect.Width * rect.Height * _bytesPerPixel];

                            var ramBaseAddr = (row * CharHeight / 2) * 320;
                            for (var y = 0; y < CharHeight; y++)
                            {
                                for (var x = 0; x < ScreenWidth; x++)
                                {
                                    var data = mem[ramBaseAddr + (y / 2) * 320 + x / 2];
                                    GetColors(data, out var red, out var green, out var blue);
                                    var pxAddr = (y * 640 + x) * 4;
                                    pixels[pxAddr] = blue;
                                    pixels[pxAddr + 1] = green;
                                    pixels[pxAddr + 2] = red;
                                }
                            }

                            var wpi = new WritePixelsInfo
                            {
                                Rect = rect,
                                Stride = rect.Width * _bytesPerPixel,
                                Pixels = pixels
                            };
                            writePixelsInfos[row] = wpi;
                        });
                    break;
            }

            if (writePixelsInfos != null)
            {
                foreach (var info in writePixelsInfos.Where(pixelInfo => pixelInfo != null))
                    _screen.WritePixels(info.Rect, info.Pixels, info.Stride, 0);
            }
        }

        private WritePixelsInfo PrepareDrawChar(int col, int row)
        {
            if (col >= ColCount || row >= RowCount) return null;

            var rect = new Int32Rect(col * CharWidth, row * CharHeight, CharWidth, CharHeight);
            var stride = rect.Width * _bytesPerPixel;

            byte[] pixels;

            var addr = (row * ColCount + col) * 2;
            var chr = _memory[_activePlane][addr];
            var color = _memory[_activePlane][addr + 1];
            pixels = GetCharBytes(chr, color, _backgroundColor);
            return new WritePixelsInfo { Pixels = pixels, Rect = rect, Stride = stride };
        }

        private byte[] GetCharBytes(byte charCode, byte fgColor, byte bgColor)
        {
            var result = new byte[CharWidth * CharHeight * 4];
            var resultIdx = 0;

            var romAddr = charCode * CharHeight;
            for (var row = 0; row < CharHeight; row++)
            {
                var data = _charRom[romAddr];
                for (var col = 0; col < CharWidth; col++)
                {
                    byte red, green, blue;
                    if ((data & (1 << col)) > 0)
                        GetColors(fgColor, out red, out green, out blue);
                    else
                        GetColors(bgColor, out red, out green, out blue);

                    result[resultIdx] = blue;
                    result[resultIdx + 1] = green;
                    result[resultIdx + 2] = red;
                    resultIdx += 4;
                }
                romAddr++;
            }

            return result;
        }

        private void GetColors(byte color, out byte red, out byte green, out byte blue)
        {
            red = (byte)((color & 0b00000111) << 5);
            green = (byte)((color & 0b00111000) << 2);
            blue = (byte)(color & 0b11000000);
        }
    }
}
