using Emulator.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace Emulator
{
    /// <summary>
    /// Interaktionslogik für MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        private MainViewModel _viewModel;

        public MainWindow()
        {
            InitializeComponent();
            _viewModel = new MainViewModel();
            DataContext = _viewModel;
            _viewModel.PropertyChanged += ViewModel_PropertyChanged;
        }

        private void ViewModel_PropertyChanged(object sender, System.ComponentModel.PropertyChangedEventArgs e)
        {
            if (e.PropertyName == "PortA")
            {
                SetSegment(SegA, 0);
                SetSegment(SegB, 1);
                SetSegment(SegC, 2);
                SetSegment(SegD, 3);
                SetSegment(SegE, 4);
                SetSegment(SegF, 5);
                SetSegment(SegG, 6);
            }

            if (e.PropertyName == "DisassembledLines")
                Dispatcher.Invoke(() => ScrollViewer.ScrollToBottom());
        }

        private void SetSegment(Rectangle rect, int bitNo)
        {
            Dispatcher.Invoke(() =>
            {
                if ((_viewModel.PortA & (1 << bitNo)) == 0)
                    rect.Fill = Brushes.Red;
                else
                    rect.Fill = Brushes.Black;
            });
        }
    }
}
