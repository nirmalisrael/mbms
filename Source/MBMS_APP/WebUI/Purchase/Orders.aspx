﻿<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Admin.Master" CodeBehind="Orders.aspx.cs" Inherits="MBMS_APP.WebUI.Purchsase.Orders" %>

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
                                    <div class="dropdown">
                                        <button type="button" class="btn p-0 hide-arrow" data-bs-toggle="modal" data-bs-target="#viewRequestItems">
                                            <%--<i class="bx bx-dots-vertical-rounded"></i>--%>
                                            <i class="fa-regular fa-eye me-1"></i>
                                        </button>
                                        <div class="dropdown-menu">
                                            <a class="dropdown-item" href="javascript:void(0);"><i class="bx bx-edit-alt me-1"></i>Edit</a>
                                            <a class="dropdown-item" href="javascript:void(0);"><i class="fa-regular fa-eye me-1"></i></i>View</a>
                                        </div>
                                    </div>
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
            <div class="modal-dialog modal-dialog-scrollable modal-lg" role="document">
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
                        <div class="row g-2">
                            <div class="col mb-0">
                                <label for="emailLarge" class="form-label">Email</label>
                                <input type="text" id="emailLarge" class="form-control" placeholder="xxxx@xxx.xx">
                            </div>
                            <div class="col mb-0">
                                <label for="dobLarge" class="form-label">DOB</label>
                                <input type="text" id="dobLarge" class="form-control" placeholder="DD / MM / YY">
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                            Close
                        </button>
                        <button type="button" class="btn btn-primary">Save changes</button>
                    </div>
                </div>
            </div>
        </div>
        <div class="bs-toast toast toast-message m-4 fade top-0 end-0 hide" role="alert" aria-live="assertive" aria-atomic="true" data-delay="2000">
            <div class="toast-header">
                <i class="bx bx-bell me-2"></i>
                <div class="me-auto fw-semibold">Bootstrap</div>
                <small>11 mins ago</small>
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
    </script>
</asp:Content>
