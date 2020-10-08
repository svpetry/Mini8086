using System;

namespace Emulator
{
    public struct Point
    {
        public double X;
        public double Y;
    }

    public struct IntRect
    {
        public int X;
        public int Y;
        public int Width;
        public int Height;

        public IntRect(int x, int y, int width, int height)
        {
            X = x;
            Y = y;
            Width = width;
            Height = height;
        }
    }

    public static class MemUtils
    {
        private static Random _rnd = new Random();

        public static void RandomFill(byte[] data)
        {
            _rnd.NextBytes(data);
        }
    }
}
