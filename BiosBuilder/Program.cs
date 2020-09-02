using System;
using System.IO;

namespace BiosBuilder
{
    class Program
    {
        static void Main(string[] args)
        {
            var bios = new byte[2 * 65536];
            for (var i = 0; i < bios.Length; i++)
                bios[i] = 0x90; // NOP

            Add(bios, "resetvector.bin", 0xFFFF0);
            var initializerSize = Add(bios, "initializer.bin", 0xF0000);
            Add(bios, "bios0.bin", 0xF0000 + initializerSize);

            SplitBiosAndSave(bios);
        }

        private static int Add(byte[] bios, string fileName, int offset, int skip = 0)
        {
            const int biosOffset = 0xE0000;

            var data = File.ReadAllBytes(fileName);
            Array.Copy(data, skip, bios, offset - biosOffset, data.Length - skip);
            return data.Length - skip;
        }

        private static void SplitBiosAndSave(byte[] bios)
        {
            var evenRom = new byte[65536];
            var oddRom = new byte[65536];

            for (var i = 0; i < bios.Length; i++)
            {
                if ((i & 1) == 0)
                    evenRom[i / 2] = bios[i];
                else
                    oddRom[i / 2] = bios[i];
            }

            File.WriteAllBytes("ROM0.bin", evenRom);
            File.WriteAllBytes("ROM1.bin", oddRom);
        }
    }
}
