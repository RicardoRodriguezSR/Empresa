using Empresa.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Empresa.Controllers
{
    public class AreasController : Controller
    {
        public ActionResult Index()
        {
            return View();
        }

        [HttpGet]
        public JsonResult GetAreas()
        {
            List<Area> list = new List<Area>();
            DataSet ds = AccesoDatos.Reader("SELECT * FROM AreasEmpresa");
            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                list.Add(new Area(dr));
            }
            return Json(list, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public ActionResult CrearArea(Area area)
        {
            try
            {
                string query = @"INSERT INTO AreasEmpresa (NombreArea, Descripcion, Departamento, Responsable)
                         VALUES (@NombreArea, @Descripcion, @Departamento, @Responsable)";

                SqlParameter[] parameters = {
                    new SqlParameter("@NombreArea", area.NombreArea),
                    new SqlParameter("@Descripcion", area.Descripcion),
                    new SqlParameter("@Departamento", area.Departamento),
                    new SqlParameter("@Responsable", area.Responsable)
                };

                AccesoDatos.NonQuery(query, parameters);

                return Json(new { success = true });
            }
            catch (Exception ex)
            {
                return Json(new { success = false, message = ex.Message });
            }
        }

        [HttpPost]
        public ActionResult EliminarArea(int areaID)
        {
            try
            {
                string query = "DELETE FROM AreasEmpresa WHERE AreaID = @AreaID";

                SqlParameter[] parameters = {
                    new SqlParameter("@AreaID", areaID)
                };

                AccesoDatos.NonQuery(query, parameters);

                return Json(new { success = true });
            }
            catch (Exception ex)
            {
                return Json(new { success = false, message = ex.Message });
            }
        }

    }
}