using System.IO;

namespace DecoderBuilder
{
    class Program
    {
        static void Main(string[] args)
        {
            var data = new byte[65536];

            for (var addr = 0; addr < data.Length; addr++)
                data[addr] = GenOutput(addr);

            File.WriteAllBytes("decoder.bin", data);
        }

        private static byte GenOutput(int addr)
        {
            var data = 0xFF;

            var M_IO = (addr & (1 << 13)) > 0 ? 1 : 0;
            var _RD = (addr & (1 << 14)) > 0 ? 1 : 0;
            var _WR = (addr & (1 << 15)) > 0 ? 1 : 0;

            if (M_IO == 1)
            {
                // memory access
                var memAddr = (addr & 0b0001111000000000) << 7;

                // RAM
                if (memAddr >= 0 && memAddr <= 0x3FFFF)
                {
                    if (_RD == 0)
                        data &= 0b11111110;
                    if (_WR == 0)
                        data &= 0b11111101;
                }

                // ROM
                if (memAddr >= 0xE0000 && memAddr <= 0xFFFFF)
                {
                    if (_RD == 0)
                        data &= 0b11111011;
                }
            }
            else
            {
                // I/O access
                var ioAddr = (addr & 0xFF) << 3;
                if (ioAddr >= 0x000 && ioAddr <= 0x007)
                {
                    // IO0
                    data &= 0b11110111;
                }
                if (ioAddr >= 0x008 && ioAddr <= 0x00F)
                {
                    // IO1
                    data &= 0b11101111;
                }
                if (ioAddr >= 0x010 && ioAddr <= 0x017)
                {
                    // IO2
                    data &= 0b11011111;
                }
                if (ioAddr >= 0x018 && ioAddr <= 0x01F)
                {
                    // IO3
                    data &= 0b10111111;
                }
                if (ioAddr >= 0x020 && ioAddr <= 0x027)
                {
                    // IO4
                    data &= 0b01111111;
                }
            }

            return (byte)data;
        }
    }
}
