<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Admin.Master" CodeBehind="Goods.aspx.cs" Inherits="MBMS_APP.WebUI.Support_Data.Goods" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="AdminMasterPage" runat="server">
    <main>
        <div class="container-xxl flex-grow-1 container-p-y">
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
                <h5 class="card-header d-flex justify-content-between align-items-center">Table Goods
            
             <asp:LinkButton ID="btnGoods" runat="server" CssClass="btn btn-primary ms-auto" OnClick="btnGoods_Click">
                 New Goods
             </asp:LinkButton>
                </h5>
                <div class="table-responsive text-nowrap">
                    <asp:GridView ID="gvGoods" runat="server" CssClass="table" ClientIDMode="Static" AutoGenerateColumns="false"
                        AllowPaging="true" PageSize="10" HeaderStyle-CssClass="thead table-header"
                        OnPageIndexChanging="gvGoods_PageIndexChanging"
                        RowStyle-CssClass="table-row" AlternatingRowStyle-CssClass="table-row-alt">
                        <Columns>
                            <asp:BoundField DataField="SerialNumber" HeaderText="S.NO" />
                            <asp:BoundField DataField="ItemId" Visible="false" />
                            <asp:BoundField DataField="ItemName" HeaderText="Item Name" />
                            <asp:BoundField DataField="MeasurementId" Visible="false" />
                            <asp:BoundField DataField="MeasurementName" HeaderText="Measurement" />
                            <asp:TemplateField HeaderText="Actions">
                                <ItemStyle Width="150px" />
                                <ItemTemplate>
                                    <div class="d-flex justify-content-evenly">
                                        <asp:LinkButton ID="btnEdit"  runat="server" CommandArgument='<%# Eval("ItemId") %>' OnClick="btnEdit_Click">
                                     <i class="bx bx-edit-alt me-1"></i>
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnDelete" runat="server" CommandArgument='<%# Eval("ItemId") %>' OnClick="btnDelete_Click" OnClientClick="Goods()">
                                     <i class="bx bx-trash me-1"></i>
                                        </asp:LinkButton>
                                    </div>
                                </ItemTemplate>
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
        <div class="modal fade" id="basicModal" tabindex="-1" aria-labelledby="exampleModalLabel1" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel1">Add Item</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col mb-3">
                                <asp:Label ID="lblRole" runat="server" Text="Item" CssClass="form-label"></asp:Label>
                                <asp:TextBox ID="txtItemName" runat="server" CssClass="form-control" Placeholder="Enter Item"></asp:TextBox>
                            </div>
                            <br />
                            <div class="col-md-3">
                                <asp:Label ID="lblMeasurement" Text="Measurement" runat="server" CssClass="form-label"></asp:Label>
                                <asp:DropDownList ID="ddlMeasurement" runat="server" CssClass="form-control"></asp:DropDownList>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <asp:Button ID="btnSave" runat="server" CssClass="btn btn-primary" Text="Save" OnClick="btnSave_Click" />
                        <asp:Button ID="btnClose" runat="server" CssClass="btn btn-secondary" Text="Close" OnClick="btnClose_Click" OnClientClick="return closeModal();" />
                    </div>
                    <asp:HiddenField ID="hfItem_Id" runat="server" />
                </div>
            </div>
        </div>
    </main>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function showModal() {
            var myModal = new bootstrap.Modal(document.getElementById('basicModal'));
            myModal.show();
        }
        function Goods() {
            var confirm_value = document.createElement('INPUT');
            confirm_value.type = 'hidden';
            confirm_value.name = 'confirm_value';
            if (confirm("Are you sure you want to delete this Item?")) {
                confirm_value.value = 'Yes';
            }
            else {
                confirm_value.value = 'No';
            }
            document.forms[0].appendChild(confirm_value);
        }
    </script>
</asp:Content>
