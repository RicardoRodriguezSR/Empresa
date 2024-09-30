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
    public class EmpleadosController : Controller
    {
        public ActionResult Index()
        {
            return View();
        }

        [HttpGet]
        public JsonResult GetEmpleados()
        {
            List<Empleado> list = new List<Empleado>();
            DataSet ds = AccesoDatos.Reader("SELECT E.EmpleadoID, E.NombreEmpleado, E.Edad, E.CorreoElectronico, A.NombreArea FROM Empleados E INNER JOIN AreasEmpresa A ON E.AreaID = A.AreaID;");
            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                list.Add(new Empleado(dr));
            }
            return Json(list, JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
        public JsonResult GetAreas()
        {
            List<Area> list = new List<Area>();
            DataSet ds = AccesoDatos.Reader("select * from AreasEmpresa order by NombreArea ASC");
            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                list.Add(new Area(Convert.ToInt32(dr["AreaID"]), dr["NombreArea"].ToString()));
            }
            return Json(list, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult CrearEmpleado(Empleado empleado)
        {
            try
            {
                string query = "INSERT INTO Empleados (NombreEmpleado, Edad, CorreoElectronico, AreaID) " +
                               "VALUES (@NombreEmpleado, @Edad, @CorreoElectronico, @AreaID)";

                List<SqlParameter> parametros = new List<SqlParameter>
                {
                    new SqlParameter("@NombreEmpleado", empleado.NombreEmpleado),
                    new SqlParameter("@Edad", empleado.Edad),
                    new SqlParameter("@CorreoElectronico", empleado.CorreoElectronico),
                    new SqlParameter("@AreaID", empleado.AreaID)
                };

                AccesoDatos.NonQuery(query, parametros.ToArray());

                return Json(new { success = true, message = "Empleado creado exitosamente" });
            }
            catch (Exception ex)
            {
                return Json(new { success = false, message = "Error al crear el empleado: " + ex.Message });
            }
        }

        [HttpGet]
        public JsonResult GetEmpleado(int empleadoID)
        {
            Empleado empleado = null;
            string query = "SELECT * FROM Empleados WHERE EmpleadoID = @EmpleadoID;";
            SqlParameter[] parameters = {
                new SqlParameter("@EmpleadoID", empleadoID)
            };
            DataSet ds = AccesoDatos.Reader(query, parameters);
            if (ds.Tables[0].Rows.Count > 0)
            {
                DataRow dr = ds.Tables[0].Rows[0];
                empleado = new Empleado
                {
                    EmpleadoID = Convert.ToInt32(dr["EmpleadoID"]),
                    NombreEmpleado = dr["NombreEmpleado"].ToString(),
                    Edad = Convert.ToInt32(dr["Edad"]),
                    CorreoElectronico = dr["CorreoElectronico"].ToString(),
                    AreaID = Convert.ToInt32(dr["AreaID"])
                };
            }

            return Json(empleado, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult ActualizarEmpleado(Empleado empleado)
        {
            try
            {
                string query = "UPDATE Empleados SET NombreEmpleado = @NombreEmpleado, Edad = @Edad, CorreoElectronico = @CorreoElectronico, AreaID = @AreaID WHERE EmpleadoID = @EmpleadoID";

                SqlParameter[] parametros = new SqlParameter[]
                {
                    new SqlParameter("@EmpleadoID", empleado.EmpleadoID),
                    new SqlParameter("@NombreEmpleado", empleado.NombreEmpleado),
                    new SqlParameter("@Edad", empleado.Edad),
                    new SqlParameter("@CorreoElectronico", empleado.CorreoElectronico),
                    new SqlParameter("@AreaID", empleado.AreaID)
                };

                AccesoDatos.NonQuery(query, parametros);

                return Json(new { success = true, message = "Empleado actualizado exitosamente" });
            }
            catch (Exception ex)
            {
                return Json(new { success = false, message = "Error al actualizar el empleado: " + ex.Message });
            }
        }

        [HttpPost]
        public ActionResult EliminarEmpleado(int empleadoID)
        {
            try
            {
                string query = "DELETE FROM Empleados WHERE EmpleadoID = @EmpleadoID";
                SqlParameter[] parameters = {
                    new SqlParameter("@EmpleadoID", empleadoID)
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