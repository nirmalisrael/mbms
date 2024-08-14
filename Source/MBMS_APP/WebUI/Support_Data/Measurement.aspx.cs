using MBMS_APP.Business.SupportData;
using MBMS_APP.Framework.Helper;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services.Description;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MBMS_APP.WebUI.Support_Data
{
    public partial class Measurement : System.Web.UI.Page
    {
        MeasurementService measurementService = new MeasurementService();
        public int MeasurementId { get; set; }
        #region Bind Measurement
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindMeasurement();
            }
        }
        public void BindMeasurement()
        {
            try
            {
                DataTable datatable = measurementService.GetMeasurement();
                LoadMeasurement(datatable);
            }
            catch (Exception ex)
            {
                new ErrorLog().WriteLog(ex);
            }
        }
        public void LoadMeasurement(DataTable dataTable)
        {
            try
            {
                if(dataTable.Rows.Count > 0)
                {
                    CommonMethods.AddSerialNumberColumnToDataTable(dataTable);
                    gvMeasurement.DataSource = dataTable;
                    gvMeasurement.DataBind();
                }
            }
            catch(Exception ex)
            {
                new ErrorLog().WriteLog(ex);
            }
        }
        #endregion

        #region Add and Edit
        protected void btnEdit_Click(object sender, EventArgs e)
        {
            string organizationId = ((LinkButton)sender).CommandArgument;
            MeasurementId = int.Parse(organizationId);
            EditMeasurement(MeasurementId);
            string script = "showModal();";
            ClientScript.RegisterStartupScript(this.GetType(), "Popup", script, true);
        }
        public void EditMeasurement(int measurementId)
        {
            try
            {
                if (measurementId > 0)
                {
                    DataTable dataTable = measurementService.GetMeasurement(measurementId);
                    if (dataTable.Rows.Count > 0)
                    {
                        hfMeasurement_Id.Value = measurementId.ToString();
                        txtMeasurementName.Text = dataTable.Rows[0]["MeasurementName"].ToString();
                    }
                }
            }
            catch (Exception ex)
            {
                new ErrorLog().WriteLog(ex);
            }
        }

        protected void btnNewMeasurement_Click(object sender, EventArgs e)
        {
            hfMeasurement_Id.Value = string.Empty;
            txtMeasurementName.Text = string.Empty;
            string script = "showModal();";
            ClientScript.RegisterStartupScript(this.GetType(), "Popup", script, true);
        }

        protected void btnSaveChanges_Click(object sender, EventArgs e)
        {
            try
            {
                int measurementId = string.IsNullOrEmpty(hfMeasurement_Id.Value) ? 0 : int.Parse(hfMeasurement_Id.Value);
                string measurementName = txtMeasurementName.Text.Trim();

                if (measurementId > 0)
                {
                    measurementService.AddAndMeasurement(measurementId, measurementName);
                }
                else
                {
                    measurementService.AddAndMeasurement(0, measurementName);
                }
                ScriptManager.RegisterStartupScript(this, this.GetType(), "closeModal", "closeModal();", true);
                BindMeasurement();
            }
            catch (Exception ex)
            {
                new ErrorLog().WriteLog(ex);
            }
        }
        #endregion

        #region Delete
        protected void btnbutton_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/measurement");
        }
        protected void btnDelete_Click(object sender, EventArgs e)
        {
            string confirmValue = Request.Form["confirm_value"];
            if (confirmValue == "Yes")
            {
                try
                {
                    string arg = ((LinkButton)sender).CommandArgument;
                    int measurementId = int.Parse(arg);
                    int result = measurementService.DeleteMeasurement(measurementId);
                    if (result > 0)
                    {
                        this.Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Organization deleted successfully!');", true);
                        BindMeasurement();
                    }
                    else
                    {
                        this.Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Something went wrong while deleting the organization!');", true);
                    }
                }
                catch (Exception ex)
                {
                    new ErrorLog().WriteLog(ex);
                }
            }
        }
        #endregion
    }
}