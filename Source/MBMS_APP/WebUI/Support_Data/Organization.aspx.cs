using MBMS_APP.Business.SupportData;
using MBMS_APP.Business.Users;
using MBMS_APP.Framework.Helper;
using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MBMS_APP.WebUI.Support_Data
{
    public partial class Organization : System.Web.UI.Page
    {
        OrganizationService service = new OrganizationService();
        public int OrganizationId {  get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                BindOrganization();
            }
        }

        #region Bind Organization
        public void BindOrganization()
        {
            try
            {
                DataTable dataTable = service.GetOrganization();
                LoadOrganization(dataTable);
            }
            catch (Exception ex)
            {
                new ErrorLog().WriteLog(ex);
            }
        }
        public void LoadOrganization(DataTable dataTable)
        {
            try
            {
                if(dataTable.Rows.Count > 0)
                {
                    gvOrganization.DataSource = dataTable;
                    gvOrganization.DataBind();
                }
            }
            catch(Exception ex)
            {
                new ErrorLog().WriteLog(ex);
            }
        }
        #endregion

        #region Add Edit
        protected void btnNewOrganization_Click(object sender, EventArgs e)
        {
            hfOrganization_Id.Value = string.Empty;
            txtOrganizationName.Text = string.Empty;
            string script = "showModal();";
            ClientScript.RegisterStartupScript(this.GetType(), "Popup", script, true);
        }
        public void EditOrganization(int organizationId)
        {
            try
            {
                if (organizationId > 0)
                {
                    DataTable dataTable = service.GetOrganization(organizationId);
                    if (dataTable.Rows.Count > 0)
                    {
                        txtOrganizationName.Text = dataTable.Rows[0]["OrganizationName"].ToString();
                        hfOrganization_Id.Value = organizationId.ToString();
                    }
                }
            }
            catch (Exception ex)
            {
                new ErrorLog().WriteLog(ex);
            }
        }
        protected void btnEdit_Click(object sender, EventArgs e)
        {
            string organizationId = ((LinkButton)sender).CommandArgument;
            OrganizationId = int.Parse(organizationId);
            EditOrganization(OrganizationId);
            string script = "showModal();";
            ClientScript.RegisterStartupScript(this.GetType(), "Popup", script, true);
        }
        protected void btnSaveChanges_Click(object sender, EventArgs e)
        {
            try
            {
                int organizationId = string.IsNullOrEmpty(hfOrganization_Id.Value) ? 0 : int.Parse(hfOrganization_Id.Value);
                string organizationName = txtOrganizationName.Text.Trim();

                if (organizationId > 0)
                {
                    service.AddAndEditOrganization(organizationId, organizationName);
                }
                else
                {
                    service.AddAndEditOrganization(0, organizationName);
                }
                ScriptManager.RegisterStartupScript(this, this.GetType(), "closeModal", "closeModal();", true);
                BindOrganization();
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
                    int organizationId = int.Parse(arg);
                    int result = service.DeleteOrganization(organizationId);
                    if (result > 0)
                    {
                        this.Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Organization deleted successfully!');", true);
                        BindOrganization();
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
        protected void btnbutton_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/organization");
        }
        #endregion
    }
}