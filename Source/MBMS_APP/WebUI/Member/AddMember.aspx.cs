using MBMS_APP.Business.Models;
using MBMS_APP.Business.Users;
using MBMS_APP.Framework.Helper;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MBMS_APP.WebUI.Member
{
    public partial class Add_Member : System.Web.UI.Page
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
                        LoadMemberDetails(userId);
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

        #region Bind Member Data
        private void LoadRolesAndOrganizations()
        {
            try
            {
                DataSet dataSet = userService.GetRolesAndOrganization();
                DataTable roleTable = dataSet.Tables[0];
                DataTable organizationTable = dataSet.Tables[1];

                ddlRole.DataSource = roleTable;
                ddlRole.DataTextField = "RoleName";
                ddlRole.DataValueField = "RoleId";
                ddlRole.DataBind();
                ddlRole.SelectedIndex = 0;

                ddlOrganization.DataSource = organizationTable;
                ddlOrganization.DataTextField = "OrganizationName";
                ddlOrganization.DataValueField = "OrganizationId";
                ddlOrganization.DataBind();
            }
            catch (Exception ex)
            {
                new ErrorLog().WriteLog(ex);
            }
        }
        private void LoadMemberDetails(int userId)
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
                        txtPassword.Text = row["AadharNumber"].ToString();
                        chkHostel.Checked = Convert.ToBoolean(row["IsHostel"]);
                        txtEmail.Text = row["UserName"].ToString();
                        txtPhoneNumber.Text = row["PhoneNumber"].ToString();

                        bool gender = Convert.ToBoolean(row["Gender"]);
                        rbMale.Checked = gender;
                        rbFemale.Checked = !gender;

                        UserId = Convert.ToInt32(row["UserId"]);
                    }
                }
            }
            catch(Exception ex)
            {
                new ErrorLog().WriteLog(ex);
            }
        }
        #endregion
        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                int gender = rbMale.Checked ? 1 : rbFemale.Checked ? 2 : 0;
                int userId = ConversionHelper.ToInt32(hfUser_Id.Value);
                User user = new User
                {
                    UserId = userId,
                    FirstName = txtFirstName.Text,
                    LastName = txtLastName.Text,
                    Password = txtPassword.Text,
                    IsHostel = ConversionHelper.ToBoolean(chkHostel.Checked),
                    DateOfBirth = DateTime.Parse(txtDateOfBirth.Text),
                    Gender = gender,
                    OrganizationId = Convert.ToInt32(ddlOrganization.SelectedValue),
                    PhoneNumber = txtPhoneNumber.Text,
                    RoleId = Convert.ToInt32(ddlRole.SelectedValue),
                    Email = txtEmail.Text,
                };

                userService.SaveOrUpdateUserDetails(user);

                // Redirect to the details page after saving or updating
                Response.Redirect("~/member-details", false);
            }
            catch (Exception ex)
            {
                new ErrorLog().WriteLog(ex);
            }
        }
        #region Save Member
        #endregion


        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("/member");
        }
    }
}