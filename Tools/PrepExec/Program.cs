using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PrepExec
{
    class Program
    {
        static void Main(string[] args)
        {
            if (args.Length != 5)
            {
                Console.WriteLine("usage PrepExec [input file] [output file] [size in KB] [process type] [priority]");
                return;
            }

            var filePath = args[0];
            var outputFilePath = args[1];
            var fileSize = (byte)int.Parse(args[2]);
            var procType = (byte)int.Parse(args[3]);
            var priority = (byte)int.Parse(args[4]);

            if (!File.Exists(filePath))
            {
                Console.WriteLine("File not found.");
                return;
            }

            var data = new List<byte>(File.ReadAllBytes(filePath));
            if (fileSize < (data.Count + 1023) / 1024 || fileSize > 64)
            {
                Console.WriteLine("Size must be >= file size and <= 64 KB");
                return;
            }

            var header = new List<byte>
            {
                0x45,
                0x58,
                fileSize,
                Crc8.Crc8Fast(Crc8.Crc8Fast(0, null, 0), data.ToArray(), data.Count),
                procType,
                priority
            };
            while (header.Count < 16)
                header.Add(0);
            data.InsertRange(0, header);

            File.WriteAllBytes(outputFilePath, data.ToArray());
        }
    }
}
