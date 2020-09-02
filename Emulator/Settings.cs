namespace E86LibPortable
{
    public static class Settings
    {
        /// <summary>
        /// CPU frequency in KHz
        /// </summary>
        public static int CpuFrequency = 4770;

        /// <summary>
        /// amount of RAM in kilobytes
        /// </summary>
        public static int RamAmount = 640;

        /// <summary>
        /// number of floppy drives
        /// </summary>
        public static int FloppyCount = 2;

        /// <summary>
        /// type of graphics adapter
        /// </summary>
        public static GraphicsType GraphicsAdapterType = GraphicsType.CGA;

        /// <summary>
        /// enabled MFM harddisk controller
        /// </summary>
        public static bool EnableHdController = true;

        /// <summary>
        /// enable UMA from 0xD0000 to 0xEFFFF
        /// </summary>
        public static bool EnableUma = true;

        /// <summary>
        /// enable Real Time Clock
        /// </summary>
        public static bool EnableRtc = true;

        /// <summary>
        /// monochrome graphics
        /// </summary>
        public static bool MonochromeGraphics => GraphicsAdapterType == GraphicsType.MDA || GraphicsAdapterType == GraphicsType.Hercules;

        /// <summary>
        /// COM1
        /// </summary>
        public static ComDevice Com1Device = ComDevice.EmulatedMouse;

        /// <summary>
        /// Name of COM Port, if COM1 is connected to a hardware port
        /// </summary>
        public static string Com1PortName = "";

        /// <summary>
        /// COM2
        /// </summary>
        public static ComDevice Com2Device = ComDevice.None;

        /// <summary>
        /// Name of COM Port, if COM2 is connected to a hardware port
        /// </summary>
        public static string Com2PortName = "";

        /// <summary>
        /// directory of HD images
        /// </summary>
        public static string HdImageDir = @"HdImages\";

        /// <summary>
        /// number of tasks to perform the screen update
        /// </summary>
        public static int ScreenTaskCount = 4;

        /// <summary>
        /// do not draw the screen while retrace happens
        /// </summary>
        public static bool NoScreenUpdateWhileRetrace = true;
    }

    public enum GraphicsType
    {
        // ReSharper disable InconsistentNaming
        MDA,
        Hercules,
        CGA,
        EGA,
        VGA
        // ReSharper restore InconsistentNaming
    }

    public enum ComDevice
    {
        None,
        NotConnected,
        HardwareComPort,
        EmulatedMouse
    }
}
