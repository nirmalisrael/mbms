using MBMS_APP.Business.Purchase;
using MBMS_APP.Framework.Helper;
using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace MBMS_APP.WebUI.Purchsase
{
    public partial class Orders : Page
    {
        #region Properties
        private PurchaseService _purchaseService;
        #endregion Properties

        #region Contructors
        public Orders()
        {
            _purchaseService = new PurchaseService();
        }
        #endregion Contructors

        #region Methods
        public void BindOrdersGrid()
        {
            try
            {
                DataSet dataSet = _purchaseService.GetPurchaseRequest(0, 0, 1);
                DataTable ordersDT = new DataTable();
                ordersDT = dataSet.Tables[0];
                CommonMethods.AddSerialNumberColumnToDataTable(ordersDT);
                if (ordersDT.Rows.Count > 0)
                {
                    gvPurchaseOrders.DataSource = ordersDT;
                    gvPurchaseOrders.DataBind();
                }
            }
            catch (Exception ex)
            {
                new ErrorLog().WriteLog(ex);
            }
        }

        protected string GetBadgeClass(string status)
        {
            switch (status)
            {
                case "Draft":
                    return "badge bg-label-secondary text-dark me-1";
                case "Requested":
                    return "badge bg-label-primary text-dark me-1";
                case "Approved":
                    return "badge bg-label-success text-dark me-1";
                case "Purchased":
                    return "badge bg-label-info text-dark me-1";
                case "Received":
                    return "badge bg-label-warning text-dark me-1";
                case "Rejected":
                    return "badge bg-label-danger text-dark me-1";
                default:
                    return "badge bg-label-secondary text-dark me-1";
            }
        }

        public void ShowToastMessage()
        {
            if (Session["ToastMessage"] != null)
            {
                string toastMessage = Session["ToastMessage"].ToString();
                string toastType = Session["ToastType"].ToString();
                string iconClass = Session["ToastIconClass"]?.ToString() ?? "bx bx-bell me-2";
                string title = Session["ToastTitle"]?.ToString() ?? "Notification";

                string script = $@"
                <script type='text/javascript'>
                    showToast('{toastMessage}', '{toastType}', '{iconClass}', '{title}');
                </script>";

                ClientScript.RegisterStartupScript(this.GetType(), "ShowToast", script);

                // Clear the session variables after use
                Session["ToastMessage"] = null;
                Session["ToastType"] = null;
                Session["ToastIconClass"] = null;
                Session["ToastTitle"] = null;
            }
        }
        #endregion Methods

        #region Events
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindOrdersGrid();
            }
            ShowToastMessage();
        }

        protected void ddlPageSize_SelectedIndexChanged(object sender, EventArgs e)
        {
            gvPurchaseOrders.PageSize = ConversionHelper.ToInt32(ddlPageSize.SelectedValue);
            BindOrdersGrid();
        }

        protected void gvPurchaseOrders_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            if (e.NewPageIndex >= 0)
            {
                gvPurchaseOrders.PageIndex = e.NewPageIndex;
                BindOrdersGrid();
                GridViewRow pagerRow = gvPurchaseOrders.BottomPagerRow;
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

        protected void gvPurchaseOrders_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string status = DataBinder.Eval(e.Row.DataItem, "Status").ToString();

                if (status != null && status != "")
                {
                    TableCell statusCell = e.Row.Cells[0];

                    statusCell.Controls.Clear();

                    var badge = new HtmlGenericControl("span");
                    badge.Attributes.Add("class", GetBadgeClass(status));
                    badge.InnerText = status;

                    statusCell.Controls.Add(badge);
                }
            }
        }

        protected void btnViewItems_Click(object sender, EventArgs e)
        {
            try
            {
                LinkButton btn = (LinkButton)sender;
                int requestId = ConversionHelper.ToInt32(btn.CommandArgument);
                if (requestId > 0)
                {
                    DataTable requestedItemsDT = _purchaseService.GetPurchaseRequestItems(requestId);
                    CommonMethods.AddSerialNumberColumnToDataTable(requestedItemsDT);
                    gvRequestedItems.DataSource = requestedItemsDT;
                    gvRequestedItems.DataBind();
                }
                ClientScript.RegisterStartupScript(this.GetType(), "showModal", "showModal()", true);
            }
            catch (Exception ex)
            {
                new ErrorLog().WriteLog(ex);
            }
        }
        #endregion Events
    }
}