using System;

namespace Emulator.Utils
{
    public interface IMemoryProvider
    {
        byte Peek(int addr);
        void Poke(int addr, byte value);
        bool SupportWrite { get; }
        bool SupportRead { get; }
    }

    public interface IPortProvider
    {
        UInt16 In(int addr);
        void Out(int addr, UInt16 value, bool wordTransfer);
    }

}
