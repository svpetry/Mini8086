using System;

namespace Emulator.Lib.Components
{
    public abstract class BaseComponent : IComponent
    {
        public virtual void Reset()
        {
        }

        public IEventTimer EventTimer { get; set; }

        public Action<int> DoCpuInterrupt { get; set; }
    }
}
