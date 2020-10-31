using Emulator.Utils;
using System.Collections.Generic;

namespace Emulator.Lib.Components
{
    /// <summary>
    ///     hardware interrupts
    /// </summary>
    public enum HardwareInterrupt
    {
        IRQ0 = 0,
        IRQ1 = 1,
        IRQ2 = 2,
        IRQ3 = 3,
        IRQ4 = 4,
        IRQ5 = 5,
        IRQ6 = 6,
        IRQ7 = 7
    }

    /// <summary>
    ///     8259A programmable interrupt controller (PIC)
    /// </summary>
    public sealed class InterruptController : BaseComponent, IPortProvider
    {
        private const int DefaultOffset = 8;

        private int _basePort;
        private int? _currentInterrupt;
        private readonly object _interruptLock = new object();
        private readonly Queue<int> _pendingInterrupts = new Queue<int>();

        /// <summary>
        /// interrupt mask register (IMR, OCW1)
        /// </summary>
        private byte _intMaskReg; // bit is 1 = interrupt is disabled

        /// <summary>
        ///     in-service register (ISR)
        /// </summary>
        private byte _inServiceReg;

        /// <summary>
        ///     interrupt request register (IRR)
        /// </summary>
        private byte _intRequestReg;

        /// <summary>
        ///     ICW1-ICW4
        /// </summary>
        private readonly byte[] _initCommandWords = new byte[4];

        /// <summary>
        ///     OCW2 and OCW3
        /// </summary>
        private byte _opControlWord2;
        private byte _opControlWord3;

        private bool _initializationMode;
        private byte _writeByteNo;

        public InterruptController(int basePort)
        {
            _basePort = basePort;
            Reset();
        }

        public override void Reset()
        {
            base.Reset();

            lock (_interruptLock)
            {
                _currentInterrupt = null;
                _pendingInterrupts.Clear();

                _writeByteNo = 1;
                _intMaskReg = 0;
                _inServiceReg = 0;
                _intRequestReg = 0;
                _initCommandWords[1] = DefaultOffset;
            }
        }

        public ushort In(int addr)
        {
            // 0x20: command register
            // 0x21: data register
            switch (addr - _basePort)
            {
                case 0x00:
                    var value = _opControlWord3 & 0x03;
                    if (value == 2)
                        return _intRequestReg;
                    if (value == 3)
                    {
                        return _inServiceReg;
                    }
                    break;

                case 0x01:
                    if (!_initializationMode)
                        return _intMaskReg;
                    break;
            }
            return 0;
        }

        public void Out(int addr, ushort value, bool wordTransfer)
        {
            // 0x00: command register
            // 0x01: data register
            switch (addr - _basePort)
            {
                case 0x00:
                    if ((value & 0x10) > 0)
                    {
                        _initializationMode = true;
                        _initCommandWords[0] = (byte)value;
                        Reset();
                    }
                    else
                    {
                        _initializationMode = false;

                        var ocwSelector = (value >> 3) & 0x03;
                        if (ocwSelector == 0)
                        {
                            // write OCW2
                            _opControlWord2 = (byte)value;

                            var cmd = _opControlWord2 >> 5;
                            //var intNo = _opControlWord2 & 0x07;
                            switch (cmd)
                            {
                                // non-specific EOI
                                case 0x01:
                                    EndOfInterrupt();
                                    break;

                                // specific EOI
                                case 0x03:
                                    EndOfInterrupt();
                                    break;

                                // rotate on non-specific EOI command
                                case 0x05:
                                    break;

                                // rotate in automatic EOI mode (set)
                                case 0x04:
                                    break;

                                // rotate in automatic EOI mode (clear)
                                case 0x00:
                                    break;

                                // rotate on specific EOI command
                                case 0x07:
                                    break;

                                // set priority command
                                case 0x06:
                                    break;
                            }
                        }
                        else if (ocwSelector == 1 && (value & 0x80) == 0)
                        {
                            // write OCW3
                            _opControlWord3 = (byte)value;
                        }
                    }
                    break;

                case 0x01:
                    if (_initializationMode)
                    {
                        _initCommandWords[_writeByteNo++] = (byte)value;
                        if (_writeByteNo == 4 || (_writeByteNo == 3 && (_initCommandWords[0] & 0x01) == 0))
                        {
                            if (_writeByteNo == 3)
                                _initCommandWords[3] = 0;
                            _initializationMode = false;
                        }
                    }
                    else
                    {
                        _intMaskReg = (byte)value;
                    }
                    break;
            }
        }

        private void EndOfInterrupt()
        {
            lock (_interruptLock)
            {
                if (_currentInterrupt == null) return;

                _inServiceReg &= (byte)~(1 << _currentInterrupt.Value);
                if (_pendingInterrupts.Count > 0)
                    InternalDoInterrupt(_pendingInterrupts.Dequeue());
                else
                    _currentInterrupt = null;
            }
        }

        private void InternalDoInterrupt(int intNo)
        {

            var iVal = (byte)(1 << intNo);
            if ((_intMaskReg & iVal) == 0)
            {
                DoCpuInterrupt(intNo + (_initCommandWords[1] & 0xF8));
                _inServiceReg |= iVal;
                _currentInterrupt = intNo;
            }
        }

        /// <summary>
        ///     generate interrupt
        /// </summary>
        public void DoInterrupt(HardwareInterrupt intNo)
        {
            var intNoValue = (int)intNo;
            lock (_interruptLock)
            {
                if (_currentInterrupt == null)
                    InternalDoInterrupt(intNoValue);
                // TODO: this is not good.
                else //if (intNo != HardwareInterrupt.Timer || (_currentInterrupt != intNoValue && !_pendingInterrupts.Contains(intNoValue)))
                    _pendingInterrupts.Enqueue(intNoValue);
            }
        }
    }
}
