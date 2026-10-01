using System.Windows;
using Lab04.Datos;

namespace Lab04
{
    public partial class MainWindow : Window
    {
        NeptunoDatos datos = new NeptunoDatos();

        public MainWindow()
        {
            InitializeComponent();
        }

        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            try
            {
                dgProductos.ItemsSource = datos.ListarProductos().DefaultView;
                dgCategorias.ItemsSource = datos.ListarCategorias().DefaultView;
                dgProveedores.ItemsSource = datos.BuscarProveedores("", "").DefaultView;
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void btnBuscar_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                dgProveedores.ItemsSource = datos.BuscarProveedores(txtNombreContacto.Text, txtCiudad.Text).DefaultView;
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }
    }
}
