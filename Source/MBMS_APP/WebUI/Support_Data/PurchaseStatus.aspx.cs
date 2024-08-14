using MBMS_APP.Business.SupportData;
using MBMS_APP.Framework.Helper;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.ApplicationServices;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MBMS_APP.WebUI.Support_Data
{
    public partial class PurchaseStatus : System.Web.UI.Page
    {
        PurchaseStatusService service = new PurchaseStatusService();
        public int StatusId { get; set; }
        #region Bind Status
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                BindStatus();
            }
        }
        public void BindStatus()
        {
            try
            {
                DataTable dataTable = service.GetStatus();
                LoadPurchaseStatus(dataTable);
            }
            catch (Exception ex)
            {
                new ErrorLog().WriteLog(ex);
            }
        }
        public void LoadPurchaseStatus(DataTable dataTable)
        {
            try
            {
                if(dataTable.Rows.Count > 0)
                {
                    CommonMethods.AddSerialNumberColumnToDataTable(dataTable);
                    gvStatus.DataSource = dataTable;
                    gvStatus.DataBind();
                }
                else
                {
                    gvStatus.DataSource = null;
                }
            }
            catch(Exception ex)
            {
                new ErrorLog().WriteLog(ex);
            }
        }
        #endregion

        #region Add and Edit
        protected void btnNewStatus_Click(object sender, EventArgs e)
        {
            hfStatus_Id.Value = string.Empty;
            txtStatusName.Text = string.Empty;
            string script = "showModal();";
            ClientScript.RegisterStartupScript(this.GetType(), "Popup", script, true);
        }

        protected void btnEdit_Click(object sender, EventArgs e)
        {
            string statusId = ((LinkButton)sender).CommandArgument;
            StatusId = int.Parse(statusId);
            LoadEditStatus(StatusId);
            string script = "showModal();";
            ClientScript.RegisterStartupScript(this.GetType(), "Popup", script, true);
        }
        public void LoadEditStatus(int statusId)
        {
            try
            {
                if (statusId > 0)
                {
                    DataTable dataTable = service.GetStatus(statusId);
                    if (dataTable.Rows.Count > 0)
                    {
                        txtStatusName.Text = dataTable.Rows[0]["StatusName"].ToString();
                        hfStatus_Id.Value = statusId.ToString();
                    }
                }
            }
            catch (Exception ex)
            {
                new ErrorLog().WriteLog(ex);
            }
        }
        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                int statusId = string.IsNullOrEmpty(hfStatus_Id.Value) ? 0 : int.Parse(hfStatus_Id.Value);
                string statusName = txtStatusName.Text.Trim();

                if (statusId > 0)
                {
                    service.AddAndEditStatus(statusId, statusName);
                }
                else
                {
                    service.AddAndEditStatus(statusId, statusName);
                }
                ScriptManager.RegisterStartupScript(this, this.GetType(), "closeModal", "closeModal();", true);
                BindStatus();
            }
            catch (Exception ex)
            {
                new ErrorLog().WriteLog(ex);
            }
        }
        #endregion

        #region Delete
        protected void btnDelete_Click(object sender, EventArgs e)
        {
            string confirmValue = Request.Form["confirm_value"];
            if (confirmValue == "Yes")
            {
                try
                {
                    string arg = ((LinkButton)sender).CommandArgument;
                    int statusId = int.Parse(arg);
                    int result = service.DeleteStatus(statusId);
                    if (result > 0)
                    {
                        this.Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Role deleted successfully!');", true);
                        BindStatus();
                    }
                    else
                    {
                        this.Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Something went wrong while deleting the Role!');", true);
                    }
                }
                catch (Exception ex)
                {
                    new ErrorLog().WriteLog(ex);
                }
            }
        }
        protected void btnClose_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/purchase-status");
        }
        #endregion
    }
}