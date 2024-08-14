<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Admin.Master" CodeBehind="PurchaseStatus.aspx.cs" Inherits="MBMS_APP.WebUI.Support_Data.PurchaseStatus" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="AdminMasterPage" runat="server">
    <main>
        <div class="container-xxl flex-grow-1 container-p-y">
            <div class="card">
                <h5 class="card-header d-flex justify-content-between align-items-center">Table Purchase Status
            
             <asp:LinkButton ID="btnNewStatus" runat="server" CssClass="btn btn-primary ms-auto" OnClick="btnNewStatus_Click">
                 New Status
             </asp:LinkButton>
                </h5>
                <div class="table-responsive text-nowrap">
                    <asp:GridView ID="gvStatus" runat="server" CssClass="table" ClientIDMode="Static" AutoGenerateColumns="false"
                        AllowPaging="true" PageSize="10" HeaderStyle-CssClass="thead table-header"
                        RowStyle-CssClass="table-row" AlternatingRowStyle-CssClass="table-row-alt">
                        <Columns>
                            <asp:BoundField DataField="SerialNumber" HeaderText="S.NO" />
                            <asp:BoundField DataField="StatusId" Visible="false" />
                            <asp:BoundField DataField="StatusName" HeaderText="Status Name" />
                            <asp:TemplateField HeaderText="Actions">
                                <ItemStyle Width="150px" />
                                <ItemTemplate>
                                    <div class="d-flex justify-content-evenly">
                                        <asp:LinkButton ID="btnEdit" runat="server" CommandArgument='<%# Eval("StatusId") %>' OnClick="btnEdit_Click">
                                     <i class="bx bx-edit-alt me-1"></i>
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnDelete" runat="server" CommandArgument='<%# Eval("StatusId") %>' OnClick="btnDelete_Click" OnClientClick="PurchaseStatus()">
                                     <i class="bx bx-trash me-1"></i>
                                        </asp:LinkButton>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>
        <div class="modal fade" id="basicModal" tabindex="-1" aria-labelledby="exampleModalLabel1" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel1">Add Status</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col mb-3">
                                <asp:Label ID="lblStatus" runat="server" Text="Status" CssClass="form-label"></asp:Label>
                                <asp:TextBox ID="txtStatusName" runat="server" CssClass="form-control" Placeholder="Enter Status"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <asp:Button ID="btnSave" runat="server" CssClass="btn btn-primary" Text="Save" OnClick="btnSave_Click" />
                        <asp:Button ID="btnClose" runat="server" CssClass="btn btn-secondary" Text="Close" OnClick="btnClose_Click" OnClientClick="return closeModal();" />
                    </div>
                    <asp:HiddenField ID="hfStatus_Id" runat="server" />
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
        function PurchaseStatus() {
            var confirm_value = document.createElement('INPUT');
            confirm_value.type = 'hidden';
            confirm_value.name = 'confirm_value';
            if (confirm("Are you sure you want to delete this Status?")) {
                confirm_value.value = 'Yes';
            }
            else {
                confirm_value.value = 'No';
            }
            document.forms[0].appendChild(confirm_value);
        }
    </script>
</asp:Content>
