using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace Empresa.Models
{
    public class Area
    {
        public int AreaID { get; set; }
        public string NombreArea { get; set; }
        public string Descripcion { get; set; }
        public string Departamento { get; set; }
        public string Responsable { get; set; }
        public string FechaCreacion { get; set; }
        public bool Estado { get; set; }

        public Area(DataRow dr)
        {
            AreaID = int.Parse(dr["AreaID"].ToString());
            NombreArea = dr["NombreArea"].ToString();
            Descripcion = dr["Descripcion"].ToString();
            Departamento = dr["Departamento"].ToString();
            Responsable = dr["Responsable"].ToString();
            FechaCreacion = DateTime.Parse(dr["FechaCreacion"].ToString()).ToString("dd/MM/yyyy");
            Estado = bool.Parse(dr["Estado"].ToString());
        }

        public Area(int areaID, string nombreArea)
        {
            AreaID = areaID;
            NombreArea = nombreArea;
        }

        public Area()
        {

        }
    }

}