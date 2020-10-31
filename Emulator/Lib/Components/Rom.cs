using System.IO;
using System.Runtime.CompilerServices;
using Emulator.Utils;

namespace Emulator.Lib.Components
{
    internal sealed class Rom : BaseComponent, IMemoryProvider
    {
        private readonly int _startAddr;
        private byte[] _data;

        public Rom(int startAddr)
        {
            _startAddr = startAddr;
        }

        public Rom(byte[] data, int startAddr)
        {
            _startAddr = startAddr;
            _data = data;
        }

        public void Load(string filenameEven, string filenameOdd)
        {
            if (!File.Exists(filenameEven) || !File.Exists(filenameOdd))
                throw new FileNotFoundException($"Rom files {filenameEven}, {filenameOdd} not found!");
            var rom0 = File.ReadAllBytes(filenameEven);
            var rom1 = File.ReadAllBytes(filenameOdd);
            if (rom0.Length != rom1.Length)
                throw new System.Exception("Even and odd ROM files do not have the same size!");

            _data = new byte[rom0.Length * 2];
            for (var i = 0; i < _data.Length; i++)
                _data[i] = (i & 1) == 0 ? rom0[i / 2] : rom1[i / 2];
        }

        public int StartAddr => _startAddr;

        public int EndAddr => _startAddr + Size - 1;

        public int Size => _data?.Length ?? 0;

        #region IMemoryProvider

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public byte Peek(int addr)
        {
            return _data[addr - _startAddr];
        }

        public void Poke(int addr, byte value)
        {
        }

        public bool SupportWrite => false;

        public bool SupportRead => true;

        #endregion
    }
}