using System.Data;
using Microsoft.Data.SqlClient;

namespace Lab04.Datos
{
    public class NeptunoDatos
    {
        public DataTable ListarProductos()
        {
            return Ejecutar("usp_Productos_Listar");
        }

        public DataTable ListarCategorias()
        {
            return Ejecutar("usp_Categorias_Listar");
        }

        public DataTable BuscarProveedores(string nombreContacto, string ciudad)
        {
            return Ejecutar("usp_Proveedores_BuscarPorContactoCiudad",
                new SqlParameter("@nombrecontacto", nombreContacto),
                new SqlParameter("@ciudad", ciudad));
        }

        private DataTable Ejecutar(string procedimiento, params SqlParameter[] parametros)
        {
            DataTable tabla = new DataTable();
            using (SqlConnection cn = new SqlConnection(Conexion.Cadena))
            {
                SqlCommand cmd = new SqlCommand(procedimiento, cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddRange(parametros);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(tabla);
            }
            return tabla;
        }
    }
}
