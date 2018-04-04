using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.Sql;
using System.Data.SqlClient;
using System.Data;

namespace Nathan_Foods.Vistas
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void TextBox1_TextChanged(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {

        }

        protected void Button1_Click1(object sender, EventArgs e)
        {

            
            String strConnString = System.Configuration.ConfigurationManager.ConnectionStrings["NATHANFOODS"].ConnectionString;
            SqlConnection con2 = new SqlConnection(strConnString);
            SqlCommand cmd2 = new SqlCommand();
            cmd2.CommandType = CommandType.StoredProcedure;
            cmd2.CommandText = "idPicking";
            cmd2.Parameters.Add("@comentario", SqlDbType.VarChar).Value= textComentario.Text;
            cmd2.Parameters.Add("@idPicking", SqlDbType.Int).Direction = ParameterDirection.Output;
            cmd2.Connection = con2;
            try
            {
                con2.Open();
                cmd2.ExecuteNonQuery();
                string id = cmd2.Parameters["@idPicking"].Value.ToString();
                lblMessage.Text = "Record inserted successfully. ID = " + id;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                con2.Close();
                con2.Dispose();
            }

        }
    }
}