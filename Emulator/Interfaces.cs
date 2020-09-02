using System;

namespace E86LibPortable
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

    public interface ISoundGenerator : IDisposable
    {
        void SetFrequency(int frequency);
    }

    public interface IBitmap
    {
        void WritePixels(IntRect rect, uint[] data, int offset);

        void WriteAllPixels(uint[] data);

        void Freeze();

        int Width { get; }

        int Height { get; }
    }
}
