using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PicBuilder
{
    class Program
    {
        static void Main(string[] args)
        {
            var data = new byte[64000];
            var bmp = new Bitmap(args[0]);

            var dataIdx = 0;
            for (var y = 0; y < 200; y++)
            {
                for (var x = 0; x < 320; x++)
                {
                    var pixel = bmp.GetPixel(x, y);
                    var r = pixel.R >> 5;
                    var g = pixel.G >> 5;
                    var b = pixel.B >> 6;
                    data[dataIdx++] = (byte)(r | (g << 3) | (b << 6));
                }
            }

            File.WriteAllBytes(args[1], data);
        }
    }
}
