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
    public partial class Goods : System.Web.UI.Page
    {
        ItemService itemService = new ItemService();
        public int ItemId {  get; set; }

        #region Bind Goods
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                BindGoods();
            }
            LoadMeasurement();
        }
        public void BindGoods()
        {
            try
            {
                DataTable dataTable = itemService.GetItems();
                LoadGoods(dataTable);
            }
            catch (Exception ex)
            {
                new ErrorLog().WriteLog(ex);
            }
        }
        public void LoadGoods(DataTable dataTable)
        {
            try
            {
                if (dataTable.Rows.Count > 0)
                {
                    CommonMethods.AddSerialNumberColumnToDataTable(dataTable);
                    gvGoods.DataSource = dataTable;
                    gvGoods.DataBind();
                }
            }
            catch (Exception ex)
            {
                new ErrorLog().WriteLog(ex);
            }
        }
        #endregion

        #region Add and Edit
        protected void btnGoods_Click(object sender, EventArgs e)
        {
            hfItem_Id.Value = string.Empty;
            txtItemName.Text = string.Empty;
            string script = "showModal();";
            ClientScript.RegisterStartupScript(this.GetType(), "Popup", script, true);
        }
        public void LoadMeasurement()
        {
            try
            {
                DataTable dataTable = itemService.GetMeasurement();
                if(dataTable.Rows.Count > 0)
                {
                    ddlMeasurement.DataSource = dataTable;
                    ddlMeasurement.DataTextField = "MeasurementName";
                    ddlMeasurement.DataValueField = "MeasurementId";
                    ddlMeasurement.DataBind();
                    ddlMeasurement.SelectedIndex = 0;
                }
            }
            catch (Exception ex)
            {
                new ErrorLog().WriteLog(ex);
            }
        }
        protected void btnEdit_Click(object sender, EventArgs e)
        {
            string itemId = ((LinkButton)sender).CommandArgument;
            ItemId = int.Parse(itemId);
            LoadEditGoods(ItemId);
            string script = "showModal();";
            ClientScript.RegisterStartupScript(this.GetType(), "Popup", script, true);
        }
        private void LoadEditGoods(int itemId)
        {
            try
            {
                if (itemId > 0)
                {
                    DataTable dataTable = itemService.GetItems(itemId);
                    if (dataTable.Rows.Count > 0)
                    {
                        txtItemName.Text = dataTable.Rows[0]["ItemName"].ToString();
                        hfItem_Id.Value = itemId.ToString();
                        ddlMeasurement.SelectedValue = dataTable.Rows[0]["MeasurementId"].ToString();
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
                int itemId = string.IsNullOrEmpty(hfItem_Id.Value) ? 0 : int.Parse(hfItem_Id.Value);
                string itemName = txtItemName.Text.Trim();
                int measurementId = ConversionHelper.ToInt32( ddlMeasurement.SelectedValue);

                if (itemId > 0)
                {
                    itemService.AddAndEditItems(itemId, itemName , measurementId);
                }
                else
                {
                    itemService.AddAndEditItems(0, itemName , measurementId);
                }
                ScriptManager.RegisterStartupScript(this, this.GetType(), "closeModal", "closeModal();", true);
                BindGoods();
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
                    int itemId = int.Parse(arg);
                    int result = itemService.DeleteItem(itemId);
                    if (result > 0)
                    {
                        this.Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Role deleted successfully!');", true);
                        BindGoods();
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
            Response.Redirect("/goods");
        }
        #endregion

        #region Page Indexing
        protected void ddlPageSize_SelectedIndexChanged(object sender, EventArgs e)
        {
            gvGoods.PageSize = ConversionHelper.ToInt32(ddlPageSize.SelectedValue);
            BindGoods();
        }
        protected void gvGoods_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvGoods.PageIndex = e.NewPageIndex;
            BindGoods();
            GridViewRow pagerRow = gvGoods.BottomPagerRow;
            if (pagerRow != null)
            {
                Label lblCurrentPage = (Label)pagerRow.FindControl("lblCurrentPage");
                if (lblCurrentPage != null)
                {
                    lblCurrentPage.Text = (e.NewPageIndex + 1).ToString();
                }
            }
        }
        #endregion
    }
}