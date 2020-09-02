using System.Runtime.CompilerServices;
using System.Threading.Tasks;
using Emulator.Utils;

namespace Emulator.Components
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

        public async Task Load(string fileName)
        {
            // TODO
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