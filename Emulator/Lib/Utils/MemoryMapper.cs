#region

using System.Collections.Generic;
using System.Runtime.CompilerServices;

#endregion

namespace Emulator.Utils
{
    internal class MemoryMapping
    {
        public int AddrLo { get; set; }
        public int AddrHi { get; set; }
        public IMemoryProvider Provider { get; set; }
        public bool SupportRead { get; set; }
        public bool SupportWrite { get; set; }
    }

    public sealed class MemoryMapper : IMemoryProvider
    {
        private readonly List<MemoryMapping> _memoryMappings = new List<MemoryMapping>();
        private readonly List<MemoryMapping> _readMappings = new List<MemoryMapping>();
        private readonly List<MemoryMapping> _writeMappings = new List<MemoryMapping>();

        private readonly byte[] _ram;

        public MemoryMapper(int ramSizeKb)
        {
            _ram = new byte[ramSizeKb * 1024];
            MemUtils.RandomFill(_ram);
        }

        public byte[] Ram => _ram;

        #region IMemoryProvider

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public byte Peek(int addr)
        {
            if (addr < _ram.Length)
                return _ram[addr];

            for (var idx = 0; idx < _readMappings.Count; idx++)
            {
                var mapping = _readMappings[idx];
                if (mapping.AddrLo <= addr && mapping.AddrHi >= addr)
                    return mapping.Provider.Peek(addr);
            }
            return 0;
        }

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public void Poke(int addr, byte value)
        {
            if (addr < _ram.Length)
            {
                _ram[addr] = value;
                return;
            }

            for (var idx = 0; idx < _readMappings.Count; idx++)
            {
                var mapping = _readMappings[idx];
                if (mapping.AddrLo <= addr && mapping.AddrHi >= addr)
                {
                    mapping.Provider.Poke(addr, value);
                    return;
                }
            }
        }

        public bool SupportWrite => true;

        public bool SupportRead => true;

        #endregion

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public ushort PeekW(int addr)
        {
            if (addr < _ram.Length - 1)
                return (ushort)(_ram[addr] + (_ram[addr + 1] << 8));

            for (var idx = 0; idx < _readMappings.Count; idx++)
            {
                var mapping = _readMappings[idx];
                if (mapping.AddrLo <= addr && mapping.AddrHi >= addr)
                    return (ushort)(mapping.Provider.Peek(addr) + (mapping.Provider.Peek(addr + 1) << 8));
            }
            return 0;
        }

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public void PokeW(int addr, ushort value)
        {
            if (addr < _ram.Length - 1)
            {
                _ram[addr] = (byte)value;
                _ram[addr + 1] = (byte)(value >> 8);
                return;
            }

            for (var idx = 0; idx < _readMappings.Count; idx++)
            {
                var mapping = _readMappings[idx];
                if (mapping.AddrLo <= addr && mapping.AddrHi >= addr)
                {
                    mapping.Provider.Poke(addr, (byte)value);
                    mapping.Provider.Poke(addr + 1, (byte)(value >> 8));
                    return;
                }
            }
        }

        public void Register(int addrLo, int addrHigh, IMemoryProvider provider)
        {
            _memoryMappings.Add(
                new MemoryMapping
                {
                    AddrLo = addrLo,
                    AddrHi = addrHigh,
                    Provider = provider,
                    SupportRead = provider.SupportRead,
                    SupportWrite = provider.SupportWrite
                });
        }

        public void FinishRegistration()
        {
            foreach (var mapping in _memoryMappings)
            {
                if (mapping.SupportRead)
                    _readMappings.Add(mapping);
                if (mapping.SupportWrite)
                    _writeMappings.Add(mapping);
            }
        }
    }
}