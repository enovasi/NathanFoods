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
            //-------------------------------------------------------------------------------------------------------------
            //Manejo del numero secuencial de picking, se agrega a la tabla CONTPICK y se devuelve el numero actual de picking
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
            //-----------------------------------------------------------------------------------------------------------------------
          
            //Manejo del detalle del picking, consolidacion de las ordenes

            using (SqlConnection con = new SqlConnection("Data Source=servidordb;Initial Catalog=NATHAN;User ID=sa;Password=sap123"))

            {
                con.Open();
                foreach (GridViewRow row in GridView1.Rows)
                {
                    CheckBox myCheckBox = row.FindControl("myCheckBox") as CheckBox;
                    if (myCheckBox.Checked)
                    {
                        using (SqlCommand cmd = new SqlCommand("INSERT INTO CONSOLIDACION(idPicking,orderNumber) Values(@id,@numOrden)", con))
                        {
                            //cmd.Parameters.AddWithValue("PersonId", Convert.ToInt32(GridViewConsNames.DataKeys[row.RowIndex].Value));
                            string numOrden = row.Cells[1].Text;
                            string fecha = row.Cells[3].Text;
                            
                            string idPicking = cmd2.Parameters["@idPicking"].Value.ToString();



                            cmd.Parameters.AddWithValue("@id", idPicking);
                            cmd.Parameters.AddWithValue("@numOrden", numOrden);
                        
                    
                            
                           // cmd.Parameters.Add("@fechahoy", SqlDbType.DateTime).Value = DateTime.Now;
                            cmd.ExecuteNonQuery();


                        }
                    }
                }

                string message = "Se han insertado los articulos en el Picking.";
                string script = "window.onload = function(){ alert('";
                script += message;
                script += "')};";
                //ClientScript.RegisterStartupScript(this.GetType(), "SuccessMessage", script, true);
                //Response.Redirect("pack.aspx?id=" + cmd2.Parameters["@id"].Value.ToString());

            }







        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void CalculateButton_Click1(object sender, EventArgs e)
        {
          //  Int32 totalMVValue = 0;

            // Iterate through the Products.Rows property
            foreach (GridViewRow row in GridView1.Rows)
            {
                // Access the CheckBox
                CheckBox mvSelectorCheckBox = (CheckBox)row.FindControl("myCheckbox");
                if (mvSelectorCheckBox != null && mvSelectorCheckBox.Checked)
                {
                    // First, get the primaryId for the selected row
                    //int mvValue = Convert.ToInt32(row.("total"));
                    //int mvValue = Convert.ToInt32(GridView1.DataKeys[row.RowIndex].Value);
                   // totalMVValue += mvValue;
                   
                    // (mvValue);
                   // lblMessage.Text = Convert.ToString(mvValue);
                }
            

            }
        }

     
    }
}