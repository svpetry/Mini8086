using System;

namespace Emulator
{

    public interface IInterrupt
    {
        void DoInterrupt(int value);
    }

    public interface IEventTimer
    {
        int SetEvent(int timeoutMicroSeconds, Action e);

        void DeleteEvent(int id);

        long ClockCount { get; }
    }

    public interface IComponent
    {
        void Reset();

        IEventTimer EventTimer { set; }

        Action<int> DoCpuInterrupt { set; }
    }
}
