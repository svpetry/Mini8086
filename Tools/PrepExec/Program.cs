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
            if (args.Length != 3)
            {
                Console.WriteLine("usage PrepExec [input file] [output file] [size in KB]");
                return;
            }

            var filePath = args[0];
            var outputFilePath = args[1];
            var fileSize = int.Parse(args[2]);
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
                (byte)fileSize,
                0
            };
            while (header.Count < 16)
                header.Add(0);
            data.InsertRange(0, header);

            File.WriteAllBytes(outputFilePath, data.ToArray());
        }
    }
}
