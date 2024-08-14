<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Admin.Master" CodeBehind="Orders.aspx.cs" Inherits="MBMS_APP.WebUI.Purchsase.Orders" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="AdminMasterPage" runat="server">
    <main>
        <div class="container-xxl flex-grow-1 container-p-y">
            <h5 class="fw-bold py-2 mb-4"><span class="text-muted fw-light">Purchases Details/</span> Orders</h5>
            <!-- Basic Bootstrap Table -->
            <div class="row mb-3">
                <div class="col-md-2">
                    <asp:DropDownList ID="ddlPageSize" runat="server" CssClass="form-select" AutoPostBack="True" OnSelectedIndexChanged="ddlPageSize_SelectedIndexChanged">
                        <asp:ListItem Value="10">10 rows</asp:ListItem>
                        <asp:ListItem Value="15">15 rows</asp:ListItem>
                        <asp:ListItem Value="20">20 rows</asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>
            <div class="card">
                <h5 class="card-header d-flex justify-space-between align-items-center">Orders                   
                    <a class="btn btn-primary ms-auto" href="/purchase-orders/new-request">New Request</a>
                </h5>

                <div class="table-responsive text-nowrap">
                    <asp:GridView runat="server" ID="gvPurchaseOrders" ClientIDMode="Static" AutoGenerateColumns="false" CssClass="table datatable table-responsive text-center"
                        OnRowDataBound="gvPurchaseOrders_RowDataBound"
                        HeaderStyle-CssClass="thead"
                        AllowPaging="True" PageSize="10"
                        OnPageIndexChanging="gvPurchaseOrders_PageIndexChanging">
                        <Columns>
                            <asp:BoundField DataField="RequestId" HeaderText="ID" Visible="false" />
                            <asp:BoundField DataField="SerialNumber" HeaderText="S. No" />
                            <asp:BoundField DataField="RequestName" HeaderText="Request Name" />
                            <asp:BoundField DataField="NoOfItems" HeaderText="No Of Items" />
                            <asp:BoundField DataField="StatusId" Visible="false" />
                            <asp:BoundField DataField="RequestedDate" HeaderText="Requested Date" DataFormatString="{0:dd-MM-yyyy}" />
                            <asp:TemplateField HeaderText="Status">
                                <ItemTemplate>
                                    <span class='<%# GetBadgeClass(Eval("Status").ToString()) %>'>
                                        <%# Eval("Status") %>
                                    </span>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Amount" HeaderText="Amount">
                                <ItemStyle CssClass="text-end" />
                            </asp:BoundField>

                            <asp:TemplateField HeaderText="Actions">
                                <ItemTemplate>
                                    <asp:LinkButton runat="server" ID="btnViewItems" type="button" CssClass="btn p-0 hide-arrow" OnClick="btnViewItems_Click"
                                        CommandArgument='<%# Eval("RequestId") %>'>
                                        <i class="fa-regular fa-eye me-1"></i>
                                    </asp:LinkButton>
                                </ItemTemplate>
                                <ItemStyle CssClass="table-border-bottom-0" />
                            </asp:TemplateField>
                        </Columns>
                        <PagerStyle CssClass="table-alt-row table-border-bottom-0" />
                        <PagerTemplate>
                            <nav aria-label="Page navigation">
                                <ul class="pagination">
                                    <li class="page-item">
                                        <asp:LinkButton runat="server" CommandName="Page" CommandArgument="Prev" CssClass="page-link" Text="<i class='bx bx-chevron-left'></i>" />
                                    </li>
                                    <li class="page-item">
                                        <asp:Label ID="lblCurrentPage" Text="1" runat="server" CssClass="bx page-link" />
                                    </li>
                                    <li class="page-item">
                                        <asp:LinkButton runat="server" CommandName="Page" CommandArgument="Next" CssClass="page-link" Text="<i class='bx bx-chevron-right'></i>" />
                                    </li>
                                </ul>
                            </nav>
                        </PagerTemplate>
                    </asp:GridView>

                </div>
            </div>
        </div>
        <div class="modal fade" id="viewRequestItems" tabindex="-1" style="display: none;" aria-hidden="true">
            <div class="modal-dialog modal-dialog-scrollable modal-xl" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="modalScrollableTitle">Modal title</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col mb-3">
                                <asp:Label CssClass="form-label" runat="server" ID="lblRequestName" AssociatedControlID="txtRequestName">Request Name</asp:Label>
                                <asp:TextBox runat="server" ID="txtRequestName" CssClass="form-control" placeholder="June month request..   " />
                            </div>
                        </div>
                        <div class="collapse" id="collapsibleForm">
                            <div class="row g-2 mb-4">
                                <div class="col-lg-6">
                                    <asp:Label CssClass="form-label" runat="server" ID="lblItems" AssociatedControlID="ddlItems">Items</asp:Label>
                                    <asp:DropDownList runat="server" ClientIDMode="Static" ID="ddlItems" CssClass="form-select"></asp:DropDownList>
                                </div>
                                <div class="col-lg-3">
                                    <asp:Label CssClass="form-label" runat="server" ID="lblQuantity" AssociatedControlID="txtQuantity">Quantity</asp:Label>
                                    <asp:TextBox runat="server" ID="txtQuantity" TextMode="Number" CssClass="form-control" placeholder="20.00" />
                                </div>
                                <div class="col-lg-3">
                                    <asp:Label CssClass="form-label" runat="server" ID="lblMeasurements" AssociatedControlID="txtMeasurement">Measurements</asp:Label>
                                    <asp:TextBox runat="server" ID="txtMeasurement" CssClass="form-control" Enabled="false" />
                                </div>
                            </div>
                        </div>
                        <asp:GridView runat="server" ID="gvRequestedItems" ClientIDMode="Static" CssClass="table text-center text-dark table-light table-striped small rounded" AutoGenerateColumns="false"
                            HeaderStyle-CssClass="bg-secondary thead-text-white">
                            <Columns>
                                <asp:BoundField DataField="SerialNumber" HeaderText="S. No" />
                                <asp:BoundField DataField="RequestXrefId" Visible="false" />
                                <asp:BoundField DataField="RequestId" Visible="false" />
                                <asp:BoundField DataField="ItemId" Visible="false" />
                                <asp:BoundField DataField="ItemName" HeaderText="Item Name" />
                                <asp:BoundField DataField="RequestedQuantity" HeaderText="Requested Quantity" />
                                <asp:TemplateField HeaderText="Approvabe Quantity">
                                    <ItemStyle Width="15%" />
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtApprovableQuantity" runat="server" CssClass="form-control text-info" Text='<%# Eval("ApprovedQuantity") %>'></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="AvailableQuantity" ItemStyle-CssClass="text-success" HeaderText="Available Quantity" />
                                <asp:BoundField DataField="MeasurementName" HeaderText="Measurement" />
                                <asp:BoundField DataField="IsReject" Visible="false" />
                                <asp:TemplateField HeaderText="Action">
                                    <ItemStyle Font-Size="Medium" />
                                    <ItemTemplate>
                                        <asp:LinkButton
                                            ID="btnReject"
                                            CssClass="text-danger "
                                            runat="server"
                                            CommandArgument='<%# Eval("RequestXrefId") %>'
                                            data-bs-toggle="tooltip"
                                            data-bs-offset="0,4"
                                            data-bs-placement="top"
                                            data-bs-html="true"
                                            title="<span>Reject this item</span>"                                            OnClick="btnReject_Click">                                            <i class="bi bi-slash-circle-fill"></i>                                            </asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                            Close
                        </button>
                        <button type="button" class="btn btn-primary" data-bs-toggle="collapse" data-bs-target="#collapsibleForm" aria-expanded="false" aria-controls="collapsibleForm">Save changes</button>
                    </div>
                </div>
            </div>
        </div>
        <div class="bs-toast toast toast-message m-4 fade top-0 end-0 hide" role="alert" aria-live="assertive" aria-atomic="true" data-delay="2000">
            <div class="toast-header">
                <i class="bx bx-bell me-2"></i>
                <div class="me-auto fw-semibold">Bootstrap</div>
                <small>Just now</small>
                <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
            </div>
            <div class="toast-body">Fruitcake chocolate bar tootsie roll gummies gummies jelly beans cake.</div>
        </div>
    </main>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Scripts" runat="server">
    <script src="<%= ResolveUrl("~/assets/js/ui-toasts.js") %>"></script>
    <script type="text/javascript">
        function callShowToast(message, type, iconClass, title) {
            if (window.showToast) {
                window.showToast(message, type, iconClass, title);
            } else {
                console.error('showToast function is not defined');
            }
        }
        function showModal() {
            var myModal = new bootstrap.Modal(document.getElementById('viewRequestItems'));
            myModal.show();
        }

    </script>
</asp:Content>
