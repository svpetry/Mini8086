using System;
using System.Runtime.CompilerServices;

namespace Emulator.CPU
{
    [Flags]
    internal enum FlagValue
    {
        Carry = 0x0001, // bit 0
        Parity = 0x0004, // bit 2
        Adjust = 0x0010, // bit 4
        Zero = 0x0040, // bit 6
        Sign = 0x0080, // bit 7
        Trap = 0x0100, // bit 8
        IntEnable = 0x0200, // bit 9
        Direction = 0x0400, // bit 10
        Overflow = 0x0800 // bit 11
    }

    internal sealed class Flags
    {
        private ushort _value;

        public Flags()
        {
            Value = 0xf000;
        }

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        private void SetFlag(FlagValue flagValue)
        {
            Value |= (ushort)flagValue;
        }

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        private void ResetFlag(FlagValue flagValue)
        {
            Value &= (ushort)~((ushort)flagValue);
        }

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        private bool GetFlag(FlagValue flagValue)
        {
            return (Value & (ushort)flagValue) > 0;
        }

        /// <summary>
        /// carry flag
        /// </summary>
        public bool CF
        {
            [MethodImpl(MethodImplOptions.AggressiveInlining)]
            get => GetFlag(FlagValue.Carry);
            [MethodImpl(MethodImplOptions.AggressiveInlining)]
            set
            {
                if (value)
                    SetFlag(FlagValue.Carry);
                else
                    ResetFlag(FlagValue.Carry);
            }
        }

        /// <summary>
        /// parity flag
        /// </summary>
        public bool PF
        {
            [MethodImpl(MethodImplOptions.AggressiveInlining)]
            get => GetFlag(FlagValue.Parity);
            [MethodImpl(MethodImplOptions.AggressiveInlining)]
            set
            {
                if (value)
                    SetFlag(FlagValue.Parity);
                else
                    ResetFlag(FlagValue.Parity);
            }
        }

        /// <summary>
        /// adjust flag / auxiliary carry flag
        /// </summary>
        public bool AF
        {
            [MethodImpl(MethodImplOptions.AggressiveInlining)]
            get => GetFlag(FlagValue.Adjust);
            [MethodImpl(MethodImplOptions.AggressiveInlining)]
            set
            {
                if (value)
                    SetFlag(FlagValue.Adjust);
                else
                    ResetFlag(FlagValue.Adjust);
            }
        }

        /// <summary>
        /// zero flag
        /// </summary>
        public bool ZF
        {
            [MethodImpl(MethodImplOptions.AggressiveInlining)]
            get => GetFlag(FlagValue.Zero);
            [MethodImpl(MethodImplOptions.AggressiveInlining)]
            set
            {
                if (value)
                    SetFlag(FlagValue.Zero);
                else
                    ResetFlag(FlagValue.Zero);
            }
        }

        /// <summary>
        /// sign flag
        /// </summary>
        public bool SF
        {
            [MethodImpl(MethodImplOptions.AggressiveInlining)]
            get => GetFlag(FlagValue.Sign);
            [MethodImpl(MethodImplOptions.AggressiveInlining)]
            set
            {
                if (value)
                    SetFlag(FlagValue.Sign);
                else
                    ResetFlag(FlagValue.Sign);
            }
        }

        /// <summary>
        /// trap flag
        /// </summary>
        public bool TF
        {
            [MethodImpl(MethodImplOptions.AggressiveInlining)]
            get => GetFlag(FlagValue.Trap);
            [MethodImpl(MethodImplOptions.AggressiveInlining)]
            set
            {
                if (value)
                    SetFlag(FlagValue.Trap);
                else
                    ResetFlag(FlagValue.Trap);
            }
        }

        /// <summary>
        /// interrupt enable flag
        /// </summary>
        public bool IF
        {
            [MethodImpl(MethodImplOptions.AggressiveInlining)]
            get => GetFlag(FlagValue.IntEnable);
            [MethodImpl(MethodImplOptions.AggressiveInlining)]
            set
            {
                if (value)
                    SetFlag(FlagValue.IntEnable);
                else
                    ResetFlag(FlagValue.IntEnable);
            }
        }

        /// <summary>
        /// direction flag
        /// </summary>
        public bool DF
        {
            [MethodImpl(MethodImplOptions.AggressiveInlining)]
            get => GetFlag(FlagValue.Direction);
            [MethodImpl(MethodImplOptions.AggressiveInlining)]
            set
            {
                if (value)
                    SetFlag(FlagValue.Direction);
                else
                    ResetFlag(FlagValue.Direction);
            }
        }

        /// <summary>
        /// overflow flag
        /// </summary>
        public bool OF
        {
            [MethodImpl(MethodImplOptions.AggressiveInlining)]
            get => GetFlag(FlagValue.Overflow);
            [MethodImpl(MethodImplOptions.AggressiveInlining)]
            set
            {
                if (value)
                    SetFlag(FlagValue.Overflow);
                else
                    ResetFlag(FlagValue.Overflow);
            }
        }

        /// <summary>
        /// value of the flags register
        /// </summary>
        public ushort Value 
        {
            [MethodImpl(MethodImplOptions.AggressiveInlining)]
            get => _value;
            [MethodImpl(MethodImplOptions.AggressiveInlining)]
            set => _value = (ushort)(value | 0xf000);
        }

    }
}
