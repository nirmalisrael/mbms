using MBMS_APP.Business.Models;
using MBMS_APP.Business.Users;
using MBMS_APP.Framework.Helper;
using System;
using System.Data;

namespace MBMS_APP.WebUI.Admin
{
    public partial class AddAdmin : System.Web.UI.Page
    {
        UserService userService = new UserService();
        public int UserId { get; set; }

        #region Page Load
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                {
                    string userIdStr = Request.QueryString["UserId"];
                    if (!string.IsNullOrEmpty(userIdStr) && int.TryParse(userIdStr, out int userId))
                    {
                        UserId = userId;
                        LoadAdminDetails(userId);
                    }
                    LoadRolesAndOrganizations();
                }
            }
            catch (Exception ex)
            {
                new ErrorLog().WriteLog(ex);
            }
        }
        #endregion

        #region Bind Admin Data
        private void LoadRolesAndOrganizations()
        {
            try
            {
                DataSet dataSet = userService.GetRolesAndOrganization();
                if(dataSet.Tables.Count > 0)
                {
                    DataTable roleTable = dataSet.Tables[0];
                    DataTable organizationTable = dataSet.Tables[1];

                    ddlRole.DataSource = roleTable;
                    ddlRole.DataTextField = "RoleName";
                    ddlRole.DataValueField = "RoleId";
                    ddlRole.DataBind();

                    ddlOrganization.DataSource = organizationTable;
                    ddlOrganization.DataTextField = "OrganizationName";
                    ddlOrganization.DataValueField = "OrganizationId";
                    ddlOrganization.DataBind();
                }
            }
            catch (Exception ex)
            {
                new ErrorLog().WriteLog(ex);
            }
        }

        private void LoadAdminDetails(int userId)
        {
            try
            {
                if (UserId > 0)
                {
                    hfUser_Id.Value = UserId.ToString();
                    DataTable dataTable = userService.GetUserDetails(UserId);

                    if (dataTable.Rows.Count > 0)
                    {
                        DataRow row = dataTable.Rows[0];

                        txtFirstName.Text = row["FirstName"].ToString();
                        txtLastName.Text = row["LastName"].ToString();

                        // Ensure the date value is parsed correctly
                        DateTime dateOfBirth;
                        if (DateTime.TryParse(row["DateOfBirth"].ToString(), out dateOfBirth))
                        {
                            txtDateOfBirth.Text = dateOfBirth.ToString("yyyy-MM-dd");
                        }

                        ddlRole.SelectedValue = row["RoleId"].ToString();
                        ddlOrganization.SelectedValue = row["OrganizationId"].ToString();
                        txtPassword.Text = dataTable.Rows[0]["Password"].ToString();
                        chkHostel.Checked = Convert.ToBoolean(row["IsHostel"]);
                        txtEmail.Text = row["UserName"].ToString();
                        txtPhoneNumber.Text = row["PhoneNumber"].ToString();
                        txtAadharNumber.Text = row["AadharNumber"].ToString();
                        chkIsStaffmember.Checked = Convert.ToBoolean(row["IsStaffmember"]);
                        txtAddress.Text = row["Address"].ToString();

                        bool gender = Convert.ToBoolean(row["Gender"]);
                        rbMale.Checked = gender;
                        rbFemale.Checked = !gender;

                        UserId = Convert.ToInt32(row["UserId"]);
                    }
                }
            }
            catch (Exception ex)
            {
                new ErrorLog().WriteLog(ex);
            }
        }
        #endregion

        #region Save Admin
        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                bool gender = rbMale.Checked ?true: rbFemale.Checked;
                int userId = ConversionHelper.ToInt32(hfUser_Id.Value);
                User user = new User
                {
                    UserId = userId,
                    FirstName = txtFirstName.Text,
                    LastName = txtLastName.Text,
                    Password = txtPassword.Text,
                    IsHostel = ConversionHelper.ToBoolean(chkHostel.Checked),
                    IsStaffMember = ConversionHelper.ToBoolean(chkIsStaffmember.Checked),
                    DateOfBirth = DateTime.Parse(txtDateOfBirth.Text),
                    Gender = ConversionHelper.ToInt32(gender),
                    OrganizationId = Convert.ToInt32(ddlOrganization.SelectedValue),
                    PhoneNumber = txtPhoneNumber.Text,
                    Address = txtAddress.Text,
                    AadharNumber = txtAadharNumber.Text,
                    RoleId = Convert.ToInt32(ddlRole.SelectedValue),
                    Email = txtEmail.Text,
                };

                userService.SaveOrUpdateUserDetails(user);

                // Redirect to the details page after saving or updating
                Response.Redirect("~/view-admin", false);
            }
            catch (Exception ex)
            {
                new ErrorLog().WriteLog(ex);
            }
        }
        #endregion

        #region Cancel Action
        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/view-admin");
        }
        #endregion
    }
}
