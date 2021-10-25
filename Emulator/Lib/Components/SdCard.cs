using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Emulator.Lib.Components
{
    enum SdState
    {
        Idle,
        ReadCommand,
        ReadBlock,
        WriteMultipleIdle,
        WriteMultiple,
        WriteSingleIdle,
        WriteSingle,
    }

    enum R1Flags
    {
        InIdleState = 0x01,
        EraseReset = 0x02,
        IllegalCommand = 0x04,
        CommandCrcError = 0x08,
        EraseSequenceError = 0x10,
        AddressError = 0x20,
        ParameterError = 0x40
    }

    public interface ISdCard
    {
        /// <summary>
        ///     Transfers a byte via SPI to the SD card and returs the response.
        /// </summary>
        byte TransferByte(byte input);
    }

    /// <summary>
    ///     Simple SD card emulation (SPI protocol)
    /// </summary>
    public class SdCard : ISdCard
    {
        private string _imgPath;

        private FileInfo _fileInfo;

        private SdState _state = SdState.Idle;

        private bool _acmd;

        private int _blockSize = 512;

        private int? _blockCount;

        private byte[] _currentBlock = new byte[512];

        private int _currentBlockNo;

        private int _currentByteNo;

        private readonly Queue<byte> _commandQueue = new Queue<byte>();

        private readonly Queue<byte> _responseQueue = new Queue<byte>();

        public SdCard(string imgPath)
        {
            _imgPath = imgPath;
            _fileInfo = new FileInfo(imgPath);
        }

        public byte TransferByte(byte input)
        {
            switch (_state)
            {
                case SdState.Idle:
                    {
                        if (_responseQueue.Count > 0)
                            return _responseQueue.Dequeue();
                        if ((input & 0b11000000) == 0b01000000)
                        {
                            _state = SdState.ReadCommand;
                            _commandQueue.Enqueue(input);
                        }
                        return 0xFF;
                    }
                case SdState.ReadCommand:
                    {
                        _commandQueue.Enqueue(input);
                        if (_commandQueue.Count == 6)
                        {
                            var command = (byte)(_commandQueue.Dequeue() - 0x40);
                            uint param = 0;
                            for (var i = 0; i < 4; i++)
                                param = (param << 8) + _commandQueue.Dequeue();
                            _commandQueue.Dequeue(); // skip CRC

                            ProcessCommand(command, param);

                            if (_state == SdState.ReadCommand)
                                _state = SdState.Idle;
                        }
                        return 0;
                    }
                case SdState.ReadBlock:
                    {
                        // break on CMD12
                        if (input == 12 + 0x40)
                        {
                            _state = SdState.ReadCommand;
                            _commandQueue.Enqueue(input);
                            return 0;
                        }

                        if (_responseQueue.Count > 0)
                            return _responseQueue.Dequeue();

                        var result = _currentBlock[_currentByteNo++];
                        if (_currentByteNo == _blockSize)
                        {
                            // fake CRC
                            _responseQueue.Enqueue(0x00);
                            _responseQueue.Enqueue(0x00);

                            if (_blockCount > 0 || _blockCount == null)
                                InitReadMultiple();
                            else
                            {
                                _state = SdState.Idle;
                                _blockCount = null;
                            }
                        }
                        return result;
                    }
                case SdState.WriteSingleIdle:
                    {
                        if (input == 0xFE)
                        {
                            _currentBlock = new byte[_blockSize];
                            _currentByteNo = 0;
                            _state = SdState.WriteSingle;
                        }
                        return 0;
                    }
                case SdState.WriteSingle:
                    {
                        if (_currentByteNo < _blockSize)
                            _currentBlock[_currentByteNo++] = input; // read block
                        else if (_currentByteNo < _blockSize + 2)
                            _currentByteNo++; // read CRC (2 bytes)
                        else
                        {
                            FinishWrite();
                            _state = SdState.Idle;
                            return 0x05;
                        }
                        return 0;
                   }
                case SdState.WriteMultipleIdle:
                    {
                        // break on stop tran token
                        if (input == 0xFD)
                        {
                            _state = SdState.ReadCommand;
                            _commandQueue.Enqueue(input);
                            return 0;
                        }
                        if (input == 0xFC)
                        {
                            _currentBlock = new byte[_blockSize];
                            _currentByteNo = 0;
                            _state = SdState.WriteMultiple;
                        }
                        return 0;
                    }
                case SdState.WriteMultiple:
                    {
                        if (_currentByteNo < _blockSize)
                            _currentBlock[_currentByteNo++] = input; // read block
                        else if (_currentByteNo < _blockSize + 2)
                            _currentByteNo++; // read CRC (2 bytes)
                        else
                        {
                            FinishWrite();
                            _state = SdState.WriteMultipleIdle;
                            return 0x05;
                        }

                        return 0;
                    }
            }
            return 0xFF;
        }

        public void ProcessCommand(byte command, UInt32 param)
        {
            if (_acmd)
            {
                _acmd = false;
                switch (command)
                {
                    // SET_WR_BLOCK_ERASE_COUNT
                    case 23:
                        _responseQueue.Enqueue(0x00);
                        break;
                    // APP_SEND_OP_COND
                    case 41:
                        _responseQueue.Enqueue(0x00);
                        break;
                }
            }
            else
            {
                switch (command)
                {
                    // GO_IDLE_STATE
                    case 0:
                        _responseQueue.Enqueue((byte)R1Flags.InIdleState);
                        break;
                    // SEND_OP_COND
                    case 1:
                        _responseQueue.Enqueue((byte)R1Flags.InIdleState);
                        break;
                    // SEND_IF_COND
                    case 8:
                        _responseQueue.Enqueue((byte)R1Flags.InIdleState);
                        _responseQueue.Enqueue(0x00);
                        _responseQueue.Enqueue(0x00);
                        _responseQueue.Enqueue(0x01);
                        _responseQueue.Enqueue(0xAA);
                        break;
                    // SEND_CSD
                    case 9:
                        _responseQueue.Enqueue(0x00);
                        break;
                    // SEND_CID
                    case 10:
                        _responseQueue.Enqueue(0x00);
                        break;
                    // STOP_TRANSMISSION
                    case 12:
                        _blockCount = null;
                        _currentBlock = new byte[0];
                        _currentBlockNo = 0;
                        _currentByteNo = 0;
                        _responseQueue.Enqueue(0x00); // stuff byte
                        _responseQueue.Enqueue(0x00);
                        break;
                    // SET_BLOCKLEN
                    case 16:
                        _blockSize = (int)param;
                        _responseQueue.Enqueue(0x00);
                        break;
                    // READ_SINGLE_BLOCK
                    case 17:
                        _blockCount = 1;
                        _currentBlockNo = (int)param;
                        _responseQueue.Enqueue(0x00);
                        InitReadMultiple();
                        _state = SdState.ReadBlock;
                        break;
                    // READ_MULTIPLE_BLOCK
                    case 18:
                        _currentBlockNo = (int)param;
                        _responseQueue.Enqueue(0x00);
                        InitReadMultiple();
                        _state = SdState.ReadBlock;
                        break;
                    // SET_BLOCK_COUNT
                    case 23:
                        _blockCount = (int)param;
                        _responseQueue.Enqueue(0x00);
                        break;
                    // WRITE_BLOCK
                    case 24:
                        _currentBlockNo = (int)param;
                        _responseQueue.Enqueue(0x00);
                        _state = SdState.WriteSingleIdle;
                        break;
                    // WRITE_MULTIPLE_BLOCK
                    case 25:
                        _currentBlockNo = (int)param;
                        _responseQueue.Enqueue(0x00);
                        _state = SdState.WriteMultipleIdle;
                        break;
                    // APP_CMD (ACMD prefix)
                    case 55:
                        _acmd = true;
                        _responseQueue.Enqueue((byte)R1Flags.InIdleState);
                        break;
                    // READ_OCR
                    case 58:
                        _responseQueue.Enqueue(0x00);
                        break;
                    default:
                        _responseQueue.Enqueue((byte)R1Flags.IllegalCommand);
                        break;
                }
            }
        }

        private void InitReadMultiple()
        {
            _currentByteNo = 0;
            if (_blockCount > 0) _blockCount--;
            var blockStart = _currentBlockNo * _blockSize;
            _currentBlock = new byte[_blockSize];
            if (blockStart < _fileInfo.Length)
            {
                using (var fs = File.OpenRead(_imgPath))
                {
                    fs.Seek(blockStart, SeekOrigin.Begin);
                    fs.Read(_currentBlock, 0, (int)Math.Min(_fileInfo.Length - blockStart, _blockSize));
                }
                _currentBlockNo++;
            }
            _responseQueue.Enqueue(0xFF);
            _responseQueue.Enqueue(0xFE);
        }

        private void FinishWrite()
        {
            _currentByteNo = 0;
            var blockStart = _currentBlockNo * _blockSize;
            var size = (int)Math.Min(_fileInfo.Length - blockStart, _blockSize);
            if (size > 0)
            {
                using (var fs = File.OpenWrite(_imgPath))
                {
                    fs.Seek(blockStart, SeekOrigin.Begin);
                    fs.Write(_currentBlock, 0, size);
                }
            }
        }
    }
}
