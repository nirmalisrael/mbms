using MBMS_APP.Business.Models;
using MBMS_APP.Business.Purchase;
using MBMS_APP.Business.SupportData;
using MBMS_APP.Framework.Helper;
using System;
using System.Data;
using System.Linq;
using System.Web.UI.WebControls;

namespace MBMS_APP.WebUI.Purchase
{
    public partial class NewPurchaseRequest : System.Web.UI.Page
    {
        #region Properties
        private ItemService _itemService;
        private MeasurementService _measurementService;
        private PurchaseService _purchaseService;
        #endregion Properties

        #region Constructors
        public NewPurchaseRequest()
        {
            _itemService = new ItemService();
            _measurementService = new MeasurementService();
            _purchaseService = new PurchaseService();
        }
        #endregion Constructors

        #region Methods
        public void BindItemsDDL()
        {
            try
            {
                DataTable itemsDT = _itemService.GetItems();
                if (itemsDT.Rows.Count > 0)
                {
                    ddlItems.DataSource = itemsDT;
                    ddlItems.DataTextField = "ItemName";
                    ddlItems.DataValueField = "ItemId";
                    ddlItems.DataBind();

                    int itemId = ConversionHelper.ToInt32(ddlItems.SelectedValue);
                    if (itemId > 0)
                    {
                        DataTable measurementDT = _measurementService.GetMeasurement(0, itemId);
                        if (measurementDT.Rows.Count > 0)
                        {
                            txtMeasurement.Text = measurementDT.Rows[0]["MeasurementName"].ToString();
                            txtAvailableQuantity.Text = measurementDT.Rows[0]["AvailableQuantity"].ToString();
                        }
                    }
                }

            }
            catch (Exception ex)
            {
                new ErrorLog().WriteLog(ex);
            }
        }

        private void BindRequestedItems(DataTable dt)
        {
            try
            {
                gvRequestedItems.DataSource = dt;
                gvRequestedItems.DataBind();
            }
            catch (Exception ex)
            {
                new ErrorLog().WriteLog(ex);
            }
        }

        public DataTable CreateRequestedItemsDT()
        {
            DataTable requestedItemsDT = new DataTable();
            try
            {
                requestedItemsDT.Columns.Add("ItemId", typeof(int));
                requestedItemsDT.Columns.Add("ItemName", typeof(string));
                requestedItemsDT.Columns.Add("Quantity", typeof(int));
                requestedItemsDT.Columns.Add("MeasurementName", typeof(string));
            }
            catch (Exception ex)
            {
                new ErrorLog().WriteLog(ex);
            }
            return requestedItemsDT;
        }

        protected void RemoveRowByItemId(int itemId)
        {
            DataTable dt = ViewState["RequestedItemsDT"] as DataTable;

            if (dt != null)
            {
                DataRow rowToRemove = dt.AsEnumerable()
                    .FirstOrDefault(row => row.Field<int>("ItemId") == itemId);
                if (rowToRemove != null)
                {
                    dt.Rows.Remove(rowToRemove);
                    ViewState["RequestedItemsDT"] = dt;
                    BindRequestedItems(dt);
                }
            }
        }

        protected void EditRowByItemId(int itemId)
        {
            DataTable dt = ViewState["RequestedItemsDT"] as DataTable;

            if (dt != null)
            {
                DataRow rowToEdit = dt.AsEnumerable()
                    .FirstOrDefault(row => row.Field<int>("ItemId") == itemId);
                if (rowToEdit != null)
                {
                    ddlItems.SelectedValue = itemId.ToString();
                    txtQuantity.Text = ConversionHelper.ToString(rowToEdit["Quantity"]);
                    if (itemId > 0)
                    {
                        DataTable measurementDT = _measurementService.GetMeasurement(0, itemId);
                        if (measurementDT.Rows.Count > 0)
                        {
                            txtMeasurement.Text = measurementDT.Rows[0]["MeasurementName"].ToString();
                            txtAvailableQuantity.Text = measurementDT.Rows[0]["AvailableQuantity"].ToString();
                        }
                    }
                }
            }
        }
        #endregion Methods

        #region Events
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindItemsDDL();
                DataTable dt = CreateRequestedItemsDT();
                ViewState["RequestedItemsDT"] = dt;
            }
        }

        protected void ddlItems_SelectedIndexChanged(object sender, EventArgs e)
        {
            int itemId = ConversionHelper.ToInt32(ddlItems.SelectedValue);
            if (itemId > 0)
            {
                DataTable measurementDT = _measurementService.GetMeasurement(0, itemId);
                if (measurementDT.Rows.Count > 0)
                {
                    txtMeasurement.Text = measurementDT.Rows[0]["MeasurementName"].ToString();
                    txtAvailableQuantity.Text = measurementDT.Rows[0]["AvailableQuantity"].ToString();
                }
            }
        }

        protected void btnAddToList_Click(object sender, EventArgs e)
        {
            int itemId = ConversionHelper.ToInt32(ddlItems.SelectedValue);
            string itemName = ddlItems.SelectedItem.ToString();
            decimal quantity = ConversionHelper.ToDecimal(txtQuantity.Text);
            string measurementName = txtMeasurement.Text;

            DataTable dt = ViewState["RequestedItemsDT"] as DataTable;
            if (dt == null)
                dt = CreateRequestedItemsDT();

            DataRow existingRow = dt.AsEnumerable()
                .FirstOrDefault(row => row.Field<int>("ItemId") == itemId);
            if (existingRow != null)
            {
                existingRow["ItemName"] = itemName;
                existingRow["Quantity"] = quantity;
                existingRow["MeasurementName"] = measurementName;
            }
            else
            {
                DataRow row = dt.NewRow();
                row["ItemId"] = itemId;
                row["ItemName"] = itemName;
                row["Quantity"] = quantity;
                row["MeasurementName"] = measurementName;
                dt.Rows.Add(row);
            }
            CommonMethods.AddSerialNumberColumnToDataTable(dt);
            ViewState["RequestedItemsDT"] = dt;
            BindRequestedItems(dt);
        }

        protected void btnEdit_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            int itemId = ConversionHelper.ToInt32(btn.CommandArgument);
            EditRowByItemId(itemId);
        }

        protected void btnRemove_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            int itemId = ConversionHelper.ToInt32(btn.CommandArgument);
            RemoveRowByItemId(itemId);
        }

        protected void btnSend_Click(object sender, EventArgs e)
        {
            try
            {
                DataTable dt = ViewState["RequestedItemsDT"] as DataTable;
                if (dt != null && dt.Rows.Count > 0)
                {
                    PurchaseRequest newRequest = new PurchaseRequest();
                    newRequest.RequestName = txtRequestName.Text;
                    newRequest.StatusId = 2;
                    string itemIdList = CommonMethods.ConvertColumnToString(dt, "ItemId");
                    string requestedQuantityList = CommonMethods.ConvertColumnToString(dt, "Quantity");

                    int result = _purchaseService.InsertAndUpdatePurchaseRequest(newRequest, itemIdList, requestedQuantityList);
                    if (result > 0)
                    {
                        Session["ToastMessage"] = "Purchase request sent!";
                        Session["ToastType"] = "bg-success";
                        Session["ToastIconClass"] = "bx bx-check-circle me-2";
                        Session["ToastTitle"] = "Success";
                    }
                    else
                    {
                        Session["ToastMessage"] = "Failed to send purchase request!";
                        Session["ToastType"] = "bg-danger";
                        Session["ToastIconClass"] = "bx bx-error me-2";
                        Session["ToastTitle"] = "Failure";
                    }
                    Response.Redirect("~/purchase-orders", false);
                }
            }
            catch (Exception ex)
            {
                new ErrorLog().WriteLog(ex);
                Session["ToastMessage"] = "Failed to send purchase request!";
                Session["ToastType"] = "bg-danger";
                Session["ToastIconClass"] = "bx bx-error me-2";
                Session["ToastTitle"] = "Failure";

                Response.Redirect("~/purchase-orders");
            }
        }

        protected void btnDraft_Click(object sender, EventArgs e)
        {
            DataTable dt = ViewState["RequestedItemsDT"] as DataTable;
            Session["ToastMessage"] = "Failed to send purchase request!";
            Session["ToastType"] = "bg-success";
            Session["ToastIconClass"] = "bx bx-error me-2";
            Session["ToastTitle"] = "Failure";

            Response.Redirect("~/purchase-orders");
        }
        #endregion Events
    }
}