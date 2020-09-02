using System.Collections.Generic;

namespace Emulator.Utils
{
    internal class PortMapping
    {
        public IPortProvider Provider { get; set; }
        public int PortLo { get; set; }
        public int PortHi { get; set; }
    }

    public sealed class PortMapper : IPortProvider
    {
        private readonly List<PortMapping> _portMappings = new List<PortMapping>();

        public ushort In(int addr)
        {
            for (var idx = 0; idx < _portMappings.Count; idx++)
            {
                var mapping = _portMappings[idx];
                if (mapping.PortLo <= addr && mapping.PortHi >= addr)
                    return mapping.Provider.In(addr);
            }
            return 0xFFFF;
        }

        public void Out(int addr, ushort value, bool wordTransfer)
        {
            for (var idx = 0; idx < _portMappings.Count; idx++)
            {
                var mapping = _portMappings[idx];
                if (mapping.PortLo <= addr && mapping.PortHi >= addr)
                {
                    mapping.Provider.Out(addr, value, wordTransfer);
                    return;
                }
            }
        }

        public void Register(int portLo, int portHi, IPortProvider provider)
        {
            _portMappings.Add(new PortMapping { Provider = provider, PortLo = portLo, PortHi = portHi });
        }

   }
}
