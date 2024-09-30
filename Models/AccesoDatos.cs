using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace Empresa.Models
{
    public static class AccesoDatos
    {
        private static string connectionString = ConfigurationManager.ConnectionStrings["CadCon"].ConnectionString;

        public static DataSet Reader(string query, SqlParameter[] parameters = null)
        {
            DataSet ds = new DataSet();
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand command = new SqlCommand(query, connection);
                if (parameters != null)
                {
                    command.Parameters.AddRange(parameters);
                }
                connection.Open();
                SqlDataAdapter adapter = new SqlDataAdapter(command);
                adapter.Fill(ds);
                connection.Close();
            }

            return ds;
        }

        public static void NonQuery(string query, SqlParameter[] parameters = null)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand command = new SqlCommand(query, connection);
                if (parameters != null)
                {
                    command.Parameters.AddRange(parameters);
                }
                connection.Open();
                command.ExecuteNonQuery();
                connection.Close();
            }
        }
    }
}