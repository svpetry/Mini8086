using System;
using System.Globalization;
using System.Windows.Data;

namespace Emulator.Views
{
    class HexConverter : IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
        {
            if (value is ushort intValue)
                return $"{intValue:X4}";
            return "";
        }

        public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
        {
            throw new NotImplementedException();
        }
    }
}
