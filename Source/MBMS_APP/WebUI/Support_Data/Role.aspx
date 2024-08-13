<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Admin.Master" CodeBehind="Role.aspx.cs" Inherits="MBMS_APP.WebUI.Support_Data.Role.Role" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="AdminMasterPage" runat="server">
    <main>
        <div class="container-xxl flex-grow-1 container-p-y">
            <div class="card">
                <h5 class="card-header d-flex justify-content-between align-items-center">Table Role
                   
                    <asp:LinkButton ID="btnNewRole" runat="server" CssClass="btn btn-primary ms-auto" OnClick="btnNewRole_Click">
                        New Role
                    </asp:LinkButton>
                </h5>
                <div class="table-responsive text-nowrap">
                    <asp:GridView ID="gvRole" runat="server" CssClass="table" ClientIDMode="Static" AutoGenerateColumns="false"
                        AllowPaging="true" PageSize="10" HeaderStyle-CssClass="thead table-header thead-bg-color"
                        RowStyle-CssClass="table-row" AlternatingRowStyle-CssClass="table-row-alt">
                        <Columns>
                            <asp:BoundField DataField="RoleId" Visible="false" />
                            <asp:BoundField DataField="RoleName" HeaderText="Role Name" />
                            <asp:TemplateField HeaderText="Actions">
                                <ItemStyle Width="150px" />
                                <ItemTemplate>
                                    <div class="d-flex justify-content-evenly">
                                        <asp:LinkButton ID="btnEdit" CssClass="dropdown-item" runat="server" CommandArgument='<%# Eval("RoleId") %>' OnClick="btnEdit_Click">
                                            <i class="bx bx-edit-alt me-1"></i>
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnDelete" CssClass="dropdown-item" runat="server" CommandArgument='<%# Eval("RoleId") %>' OnClick="btnDelete_Click" OnClientClick="Role()">
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

        <!-- Modal Implementation -->
        <div class="modal fade" id="basicModal" tabindex="-1" aria-labelledby="exampleModalLabel1" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel1">Add Role</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col mb-3">
                                <asp:Label ID="lblRole" runat="server" Text="Role" CssClass="form-label"></asp:Label>
                                <asp:TextBox ID="txtRoleName" runat="server" CssClass="form-control" Placeholder="Enter Role"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <asp:Button ID="btnSaveChanges" runat="server" CssClass="btn btn-primary" Text="Save" OnClick="SaveChanges_Click" />
                        <asp:Button ID="btnClose" runat="server" CssClass="btn btn-secondary" Text="Close" OnClick="btnClose_Click" OnClientClick="return closeModal();" />
                    </div>
                    <asp:HiddenField ID="hfRole_Id" runat="server" />
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
        function Role() {
            var confirm_value = document.createElement('INPUT');
            confirm_value.type = 'hidden';
            confirm_value.name = 'confirm_value';
            if (confirm("Are you sure you want to delete this Role?")) {
                confirm_value.value = 'Yes';
            }
            else {
                confirm_value.value = 'No';
            }
            document.forms[0].appendChild(confirm_value);
        }
</script>
</asp:Content>

