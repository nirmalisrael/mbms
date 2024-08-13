<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NewPurchaseRequest.aspx.cs" MasterPageFile="~/Admin.Master" Inherits="MBMS_APP.WebUI.Purchase.NewPurchaseRequest" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="AdminMasterPage" runat="server">
    <main>
        <div class="container-xxl flex-grow-1 container-p-y">
            <h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">Purchase Details/</span> New Request</h4>
            <div class="row">
                <div class="col-xl">
                    <div class="card mb-4">
                        <div class="card-body">
                            <div class="mb-3">
                                <asp:Label CssClass="form-label" runat="server" ID="lblRequestName" AssociatedControlID="txtRequestName">Request Name</asp:Label>
                                <asp:TextBox runat="server" ID="txtRequestName" CssClass="form-control" placeholder="June month request..   " />
                                <asp:RequiredFieldValidator
                                    ID="rfvRequestName"
                                    runat="server"
                                    ControlToValidate="txtRequestName"
                                    InitialValue=""
                                    ErrorMessage="Request Name is required"
                                    CssClass="text-danger"
                                    Display="Dynamic" />

                            </div>

                            <div class="mb-3">
                                <div class="row">
                                    <div class="col-lg-4">
                                        <asp:Label CssClass="form-label" runat="server" ID="lblItems" AssociatedControlID="ddlItems">Items</asp:Label>
                                        <asp:DropDownList runat="server" ClientIDMode="Static" ID="ddlItems" CssClass="form-select" OnSelectedIndexChanged="ddlItems_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                                    </div>
                                    <div class="col-lg-3">
                                        <asp:Label CssClass="form-label" runat="server" ID="lblQuantity" AssociatedControlID="txtQuantity">Quantity</asp:Label>
                                        <asp:TextBox runat="server" ID="txtQuantity" TextMode="Number" CssClass="form-control" placeholder="20.00" />
                                        <asp:RequiredFieldValidator
                                            ID="rfvQuantity"
                                            runat="server"
                                            ControlToValidate="txtQuantity"
                                            InitialValue=""
                                            CssClass="text-danger"
                                            ErrorMessage="Quantity is required"
                                            Display="Dynamic" />
                                    </div>
                                    <div class="col-lg-3">
                                        <asp:Label CssClass="form-label" runat="server" ID="lblAvailableQuantity" AssociatedControlID="txtAvailableQuantity">Available Quantity</asp:Label>
                                        <asp:TextBox runat="server" ID="txtAvailableQuantity" TextMode="Number" CssClass="form-control" Enabled="false" placeholder="20.00" />
                                    </div>
                                    <div class="col-lg-2">
                                        <asp:Label CssClass="form-label" runat="server" ID="lblMeasurements" AssociatedControlID="txtMeasurement">Measurements</asp:Label>
                                        <asp:TextBox runat="server" ID="txtMeasurement" CssClass="form-control" Enabled="false" />
                                    </div>
                                </div>
                            </div>
                            <div class="mb-3 d-flex justify-content-end">
                                <asp:Button runat="server" ID="btnAddToList" CssClass="btn btn-sm btn-outline-primary" Text="Add to List" OnClick="btnAddToList_Click" />
                            </div>
                            <div class="mb-3 table-responsive text-nowrap">
                                <asp:GridView runat="server" ID="gvRequestedItems" CssClass="table text-center" AutoGenerateColumns="false">
                                    <Columns>
                                        <asp:BoundField DataField="SerialNumber" HeaderText="S. No" />
                                        <asp:BoundField DataField="ItemId" HeaderText="Item ID" Visible="false" />
                                        <asp:BoundField DataField="ItemName" HeaderText="Item Name" />
                                        <asp:BoundField DataField="Quantity" HeaderText="Quantity" />
                                        <asp:BoundField DataField="MeasurementName" HeaderText="Measurement" />
                                        <asp:TemplateField HeaderText="Actions">
                                            <ItemStyle Width="150px" />
                                            <ItemTemplate>
                                                <div class="d-flex justify-content-evenly">
                                                    <asp:LinkButton ID="btnEdit" CssClass="dropdown-item" runat="server" CommandArgument='<%# Eval("ItemId") %>' OnClick="btnEdit_Click">                                                     <i class="bx bx-edit-alt me-1"></i>                                                    </asp:LinkButton>
                                                    <asp:LinkButton ID="btnRemove" CssClass="dropdown-item" runat="server" CommandArgument='<%# Eval("ItemId") %>' OnClick="btnRemove_Click">                                                     <i class="bx bx-trash me-1"></i>                                                    </asp:LinkButton>
                                                </div>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </div>

                            <div class="d-flex justify-content-end">
                                <asp:LinkButton ID="btnDraft" runat="server" type="submit" class="btn btn-primary mx-1" OnClick="btnDraft_Click">Draft</asp:LinkButton>
                                <asp:LinkButton ID="btnSend" runat="server" type="submit" class="btn btn-primary mx-1" OnClick="btnSend_Click">Send</asp:LinkButton>
                                <a href="/purchase-orders" class="btn btn-secondary mx-1">Cancel</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>
    <script type="text/javascript">
        function onChangeItem() {
            var selectedValue = $('#ddlItems').val();

            $.ajax({
                type: "POST",
                url: "<%= ResolveUrl("~/WebUI/Purchase/PurchaseRequest.aspx/GetMeasurementByItem") %>",
                data: JSON.stringify({ selectedValue: selectedValue }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    console.log("Response: ", response.d);
                },
                error: function (xhr, status, error) {
                    console.error("Error: " + error);
                }
            });
        }
    </script>

</asp:Content>

