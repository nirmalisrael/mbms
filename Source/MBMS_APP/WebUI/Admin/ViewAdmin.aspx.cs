﻿using MBMS_APP.Business.Users;
using MBMS_APP.Framework.Helper;
using System;
using System.Data;
using System.Web.UI.WebControls;

namespace MBMS_APP.WebUI.Admin
{
    public partial class ViewAdmin : System.Web.UI.Page
    {
        UserService userService = new UserService();

        public int RoleId { get; set; } = 0;

        #region Page Load
        protected void Page_Load(object sender, EventArgs e)
        {
            BindData();
        }
        #endregion

        #region Bind Data
        public void BindData()
        {
            int roleId = 1;
            RoleId = roleId;
            try
            {
                DataTable dt = userService.GetUserDetails(0, RoleId);
                gvUsers.DataSource = dt;
                gvUsers.DataBind();
            }
            catch (Exception ex)
            {
                new ErrorLog().WriteLog(ex);
            }
        }
        #endregion

        #region Page Size Change
        protected void ddlPageSize_SelectedIndexChanged(object sender, EventArgs e)
        {
            gvUsers.PageSize = ConversionHelper.ToInt32(ddlPageSize.SelectedValue);
            BindData();
        }
        #endregion

        #region Page Index Changing
        protected void gvUsers_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            if (e.NewPageIndex > 0)
            {
                gvUsers.PageIndex = e.NewPageIndex;
                BindData();
                GridViewRow pagerRow = gvUsers.BottomPagerRow;
                if (pagerRow != null)
                {
                    Label lblCurrentPage = (Label)pagerRow.FindControl("lblCurrentPage");
                    if (lblCurrentPage != null)
                    {
                        lblCurrentPage.Text = (e.NewPageIndex + 1).ToString();
                    }
                }
            }
        }
        #endregion

        #region Delete User
        protected void btnDelete_Click(object sender, EventArgs e)
        {
            string confirmValue = Request.Form["confirm_value"];
            if (confirmValue == "Yes")
            {
                try
                {
                    string arg = ((LinkButton)sender).CommandArgument;
                    int userId = ConversionHelper.ToInt32(arg);
                    int result = userService.DeleteUserDetails(userId);

                    this.Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('User deleted successfully!');", true);
                    BindData();
                }
                catch (Exception ex)
                {
                    new ErrorLog().WriteLog(ex);
                }
            }
            else
            {
                BindData();
            }
        }
        #endregion

        #region Edit User
        protected void btnEdit_Click(object sender, EventArgs e)
        {
            string userId = ((LinkButton)sender).CommandArgument;
            Response.Redirect("~/add-admin?UserId=" + userId);
        }
        #endregion
    }
}
