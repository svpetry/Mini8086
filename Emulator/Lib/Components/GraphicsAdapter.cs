using Emulator.Utils;
using System;
using System.IO;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Media;
using System.Windows.Media.Imaging;

namespace Emulator.Lib.Components
{
    internal enum GraphicsMode
    {
        Text = 0,
        Graphics320x200x8 = 1,
        Graphics320x400x8 = 2,
        Graphics640x200x8 = 3
    }

    public class GraphicsAdapter : BaseComponent, IPortProvider, IMemoryProvider
    {
        private const int ScreenWidth = 640;
        private const int ScreenHeight = 400;
        private const int RowCount = 25;
        private const int ColCount = 80;
        private const int CharWidth = 8;
        private const int CharHeight = 16;

        private static uint[] _dataBuffer = new uint[0];

        private readonly InterruptController _pic;
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

        public GraphicsAdapter(int basePort, int baseMemAddress, InterruptController pic, string characterRomPath)
        {
            _basePort = basePort;
            _baseMemAddress = baseMemAddress;
            _pic = pic;

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
                case 0x01:
                    return _backgroundColor;

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
                case 0x01:
                    _backgroundColor = (byte)value;
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

        private void UpdateScreenParallel(int width, int height, Func<int, int, int, Task> createTaskFunc)
        {
            var startLine = 0;
            var linesPerTask = height / Settings.ScreenTaskCount;
            var tasks = new Task[Settings.ScreenTaskCount];
            for (var idx = 0; idx < Settings.ScreenTaskCount; idx++)
            {
                var taskFunc = createTaskFunc(width, startLine, idx < Settings.ScreenTaskCount - 1 ? linesPerTask : height - startLine);
                startLine += linesPerTask;
                tasks[idx] = taskFunc;
                taskFunc.Start();
            }

            Task.WaitAll(tasks);
        }

        private Task CreateUpdateTextScreenTask(int cols, int startRow, int rows)
        {
            return new Task(() =>
            {
                var bgColor = GetColor32(_backgroundColor);
                for (var row = startRow; row < startRow + rows; row++)
                {
                    for (var col = 0; col < cols; col++)
                    {
                        var addr = (row * ColCount + col) * 2;
                        var charCode = _memory[_activePlane][addr];
                        var fgColor = GetColor32(_memory[_activePlane][addr + 1]);

                        var romAddr = charCode * CharHeight;
                        for (var charRow = 0; charRow < CharHeight; charRow++)
                        {
                            var bufAddr = (row * CharHeight + charRow) * ScreenWidth + col * CharWidth;
                            var data = _charRom[romAddr];
                            for (var charCol = 0; charCol < CharWidth; charCol++)
                            {
                                if ((data & (1 << charCol)) > 0)
                                    _dataBuffer[bufAddr] = fgColor;
                                else
                                    _dataBuffer[bufAddr] = bgColor;

                                bufAddr++;
                            }
                            romAddr++;
                        }
                    }
                }
            });
        }

        private Task CreateUpdateScreenTask(int width, int startLine, int height, bool doubleX, bool doubleY)
        {
            return new Task(
                () =>
                {
                    var mem = _memory[_activePlane];
                    var dataIndex = startLine * width;

                    for (var row = 0; row < height; row++)
                    {
                        var memIndex = (startLine + row) * width;
                        if (doubleY)
                            memIndex /= 2;

                        for (var col = 0; col < width; col++)
                        {
                            _dataBuffer[dataIndex] = GetColor32(mem[memIndex]);
                            if (!doubleX || (col & 1) > 0)
                                memIndex++;
                            dataIndex++;
                        }
                    }
                });
        }

        public async Task UpdateScreen()
        {
            await Task.Run(() =>
            {
                var hSize = ScreenWidth * ScreenHeight;
                if (_dataBuffer.Length != hSize)
                    _dataBuffer = new uint[hSize];

                switch (_mode)
                {
                    case GraphicsMode.Text:
                        UpdateScreenParallel(ColCount, RowCount, CreateUpdateTextScreenTask);
                        break;

                    case GraphicsMode.Graphics320x200x8:
                        UpdateScreenParallel(ScreenWidth, ScreenHeight,
                            (width, startLine, height) => CreateUpdateScreenTask(width, startLine, height, true, true));
                        break;

                    case GraphicsMode.Graphics320x400x8:
                        UpdateScreenParallel(ScreenWidth, ScreenHeight,
                            (width, startLine, height) => CreateUpdateScreenTask(width, startLine, height, true, false));
                        break;

                    case GraphicsMode.Graphics640x200x8:
                        UpdateScreenParallel(ScreenWidth, ScreenHeight,
                            (width, startLine, height) => CreateUpdateScreenTask(width, startLine, height, false, true));
                        break;
                }
            });

            var stride = ScreenWidth * 4;
            _screen.WritePixels(new Int32Rect(0, 0, ScreenWidth, ScreenHeight), _dataBuffer, stride, 0);
        }

        private void GetColors(byte color, out byte red, out byte green, out byte blue)
        {
            red = (byte)((color & 0b00000111) << 5);
            green = (byte)((color & 0b00111000) << 2);
            blue = (byte)(color & 0b11000000);
        }

        private uint GetColor32(byte color)
        {
            GetColors(color, out var red, out var green, out var blue);
            return (uint)(blue + (green << 8) + (red << 16));
        }
    }
}
