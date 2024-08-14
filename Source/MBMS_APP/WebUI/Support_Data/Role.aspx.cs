using MBMS_APP.Business.SupportData;
using MBMS_APP.Framework.Helper;
using System;
using System.Data;
using System.Web.Services.Description;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MBMS_APP.WebUI.Support_Data.Role
{
    public partial class Role : System.Web.UI.Page
    {
        RoleService roleService = new RoleService();
        public int RoleId { get; set; }

        #region Page Load
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindRole();
            }
        }
        #endregion

        #region Load Role
        public void BindRole()
        {
            try
            {
                DataTable dataTable = roleService.GetRoles();
                LoadRole(dataTable);
            }
            catch (Exception ex)
            {
                new ErrorLog().WriteLog(ex);
            }
        }

        public void LoadRole(DataTable dataTable)
        {
            try
            {
                CommonMethods.AddSerialNumberColumnToDataTable(dataTable);
                gvRole.DataSource = dataTable;
                gvRole.DataBind();
            }
            catch (Exception ex)
            {
                new ErrorLog().WriteLog(ex);
            }
        }

        protected void btnNewRole_Click(object sender, EventArgs e)
        {
            hfRole_Id.Value = string.Empty;
            txtRoleName.Text = string.Empty;
            string script = "showModal();";
            ClientScript.RegisterStartupScript(this.GetType(), "Popup", script, true);
        }
        #endregion

        #region Edit and Delete
        protected void btnEdit_Click(object sender, EventArgs e)
        {
            string roleId = ((LinkButton)sender).CommandArgument;
            RoleId = int.Parse(roleId);
            LoadEditRole(RoleId);
            string script = "showModal();";
            ClientScript.RegisterStartupScript(this.GetType(), "Popup", script, true);
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            string confirmValue = Request.Form["confirm_value"];
            if (confirmValue == "Yes")
            {
                try
                {
                    string arg = ((LinkButton)sender).CommandArgument;
                    int roleId = int.Parse(arg);
                    int result = roleService.DeleteRole(roleId);
                    if (result > 0)
                    {
                        this.Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Role deleted successfully!');", true);
                        BindRole();
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

        public void LoadEditRole(int roleId)
        {
            try
            {
                if (roleId > 0)
                {
                    DataTable dataTable = roleService.GetRoles(roleId);
                    if (dataTable.Rows.Count > 0)
                    {
                        txtRoleName.Text = dataTable.Rows[0]["RoleName"].ToString();
                        hfRole_Id.Value = roleId.ToString();
                    }
                }
            }
            catch (Exception ex)
            {
                new ErrorLog().WriteLog(ex);
            }
        }
        #endregion

        #region Save Changes
        protected void SaveChanges_Click(object sender, EventArgs e)
        {
            try
            {
                int roleId = string.IsNullOrEmpty(hfRole_Id.Value) ? 0 : int.Parse(hfRole_Id.Value);
                string roleName = txtRoleName.Text.Trim();

                if (roleId > 0)
                {
                    roleService.AddAndEditRoles(roleId, roleName);
                }
                else
                {
                    roleService.AddAndEditRoles(0,roleName);
                }
                ScriptManager.RegisterStartupScript(this, this.GetType(), "closeModal", "closeModal();", true);
                BindRole();
            }
            catch (Exception ex)
            {
                new ErrorLog().WriteLog(ex);
            }
        }
        #endregion

        protected void btnClose_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/role");
        }
    }
}
