using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Emulator.Lib
{
    static class Config
    {
        public static int TimerBasePort => 0x00;

        public static int PicBasePort => 0x08;

        public static int PpiBasePort => 0x10;

        public static int KeybControllerBasePort => 0x28;

        public static int UartBasePort => 0x020;

        public static int VgaBasePort => 0x28;

        public static int VgaMemAddress => 0xC0000;

        public static int VgaMemSize => 0x20000;

        public static int BiosMemAddress => 0xE0000;

        public static int BiosMemSize => 0x20000;

        public static string CharacterRomPath => @"..\..\..\ROMs\charrom.bin";
    }
}
