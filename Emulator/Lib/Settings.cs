namespace Emulator
{
    public static class Settings
    {
        /// <summary>
        ///     CPU frequency in KHz
        /// </summary>
        public static int CpuFrequency = 12000;

        /// <summary>
        ///     Screen update rate in fps
        /// </summary>
        public static int ScreenUpdateRate = 20;

        /// <summary>
        ///     Number of tasks to perform the screen update
        /// </summary>
        public static int ScreenTaskCount = 4;
    }
}
