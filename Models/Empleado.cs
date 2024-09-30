using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace Empresa.Models
{
    public class Empleado
    {
        public int EmpleadoID { get; set; }
        public string NombreEmpleado { get; set; }
        public int Edad { get; set; }
        public string CorreoElectronico { get; set; }
        public string NombreArea { get; set; }
        public int AreaID { get; set; }

        public Empleado(DataRow dr)
        {
            EmpleadoID = int.Parse(dr["EmpleadoID"].ToString());
            NombreEmpleado = dr["NombreEmpleado"].ToString();
            Edad = int.Parse(dr["Edad"].ToString());
            CorreoElectronico = dr["CorreoElectronico"].ToString();
            NombreArea = dr["NombreArea"].ToString();
        }

        public Empleado()
        {

        }
    }
}