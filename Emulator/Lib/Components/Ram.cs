using Emulator.Utils;
using System.Runtime.CompilerServices;

namespace Emulator.Lib.Components
{
    /// <summary>
    /// RAM
    /// </summary>
    internal sealed class Ram : BaseComponent, IMemoryProvider
    {
        private readonly byte[] _memory;
        private readonly int _offset;
        private readonly int _sizeKb;

        public Ram(int sizeKb, int offset)
        {
            _sizeKb = sizeKb;
            _offset = offset;
            _memory = new byte[_sizeKb * 1024];
        }

        public int AddrLo => _offset;

        public int AddrHi => _offset + _sizeKb * 1024;

        #region IMemoryProvider

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public byte Peek(int addr)
        {
            if (addr >= _offset && addr < _offset + _memory.Length)
                return _memory[addr - _offset];

            return 0;
        }

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public void Poke(int addr, byte value)
        {
            if (addr >= _offset && addr < _offset + _memory.Length)
                _memory[addr - _offset] = value;
        }

        public bool SupportWrite => true;

        public bool SupportRead => true;

        #endregion
    }
}
