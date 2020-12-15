using System.Drawing;
using System.IO;
using System.Linq.Expressions;

namespace DecoderBuilder
{
    enum Signal
    {
        MEMRD = 1,
        MEMWR = 2,
        ROMRD = 4,
        IO_TIMER = 8,
        IO_PIC = 16,
        IO_DBG = 32,
        VGA_MEM = 64,
        VGA_IO = 128
    }

    class Program
    {
        static void Main(string[] args)
        {
            GenerateDecoder(@"..\..\..\ROMs\decoder.bin");
            GenerateCharacterRom(@"..\..\..\ROMs\charrom.bin");
        }

        private static void GenerateDecoder(string filePath)
        {
            var data = new byte[65536];

            for (var addr = 0; addr < data.Length; addr++)
                data[addr] = GenDecoderOutput(addr);

            File.WriteAllBytes(filePath, data);
        }

        private static byte GenDecoderOutput(int addr)
        {
            byte data = 0xFF;

            var M_IO = (addr & (1 << 13)) > 0 ? 1 : 0;
            var _RD = (addr & (1 << 14)) > 0 ? 1 : 0;
            var _WR = (addr & (1 << 15)) > 0 ? 1 : 0;

            if (_RD == 0 || _WR == 0)
            {

                if (M_IO == 1)
                {
                    // memory access
                    var memAddr = (addr & 0b0001111000000000) << 7;

                    // RAM
                    if (memAddr >= 0 && memAddr <= 0x7FFFF)
                    {
                        if (_RD == 0)
                            SetSignal(ref data, Signal.MEMRD);
                        if (_WR == 0)
                            SetSignal(ref data, Signal.MEMWR);
                    }

                    // ROM
                    if (memAddr >= 0xE0000 && memAddr <= 0xFFFFF)
                    {
                        if (_RD == 0)
                            SetSignal(ref data, Signal.ROMRD);
                    }

                    // VGA memory
                    if (memAddr >= 0xC0000 && memAddr <= 0xDFFFF)
                        SetSignal(ref data, Signal.VGA_MEM);
                }
                else
                {
                    // I/O access
                    var ioAddr = (addr & 0xFF) << 3;
                    if (ioAddr >= 0x040 && ioAddr <= 0x047)
                    {
                        // IO_TIMER
                        SetSignal(ref data, Signal.IO_TIMER);
                    }
                    if (ioAddr >= 0x020 && ioAddr <= 0x027)
                    {
                        // IO_PIC
                        SetSignal(ref data, Signal.IO_PIC);
                    }
                    if (ioAddr >= 0x010 && ioAddr <= 0x017)
                    {
                        // IO_DBG
                        SetSignal(ref data, Signal.IO_DBG);
                    }
                    if (ioAddr >= 0x050 && ioAddr <= 0x057)
                    {
                        // VGA_IO
                        SetSignal(ref data, Signal.VGA_IO);
                    }
                }
            }

            return (byte)data;
        }

        private static void SetSignal(ref byte data, Signal signal)
        {
            data &= (byte)~signal;
        }

        private static void GenerateCharacterRom(string filePath)
        {
            var data = new byte[65536];
            var dataIdx = 0;
            const int invOffset = 128 * 16;

            var bmp = new Bitmap(@"..\..\..\VGA\Characters.png");
            for (var charNo = 0; charNo < 128; charNo++)
            {
                var charX = (charNo % 32) * 16;
                var charY = (charNo / 32) * 16;
                for (var y = 0; y < 16; y++)
                {
                    byte d = 0;
                    for (var x = 0; x < 8; x++)
                    {
                        if (bmp.GetPixel(charX + x, charY + y).G == 0)
                            d = (byte)(d | (1 << x));
                    }
                    data[dataIdx] = d;
                    data[invOffset + dataIdx] = (byte)~d;
                    dataIdx++;
                }
            }

            File.WriteAllBytes(filePath, data);
        }
    }
}
