<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Admin.Master" CodeBehind="Measurement.aspx.cs" Inherits="MBMS_APP.WebUI.Support_Data.Measurement" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="AdminMasterPage" runat="server">
    <main>
        <div class="container-xxl flex-grow-1 container-p-y">
            <div class="card">
                <h5 class="card-header d-flex justify-content-between align-items-center">Table Measurement
                   
                    <asp:Button
                        ID="btnNewMeasurement"
                        runat="server"
                        CssClass="btn btn-primary"
                        Text="New Measurement"
                        OnClick="btnNewMeasurement_Click" />
                </h5>
                <div class="table-responsive text-nowrap">
                    <asp:GridView ID="gvMeasurement" runat="server" CssClass="table" ClientIDMode="Static" AutoGenerateColumns="false"
                        AllowPaging="true" PageSize="10" HeaderStyle-CssClass="thead table-header"
                        RowStyle-CssClass="table-row" AlternatingRowStyle-CssClass="table-row-alt">
                        <Columns>
                            <asp:BoundField DataField="SerialNumber" HeaderText="S.NO" />
                            <asp:BoundField DataField="MeasurementId" Visible="false" />
                            <asp:BoundField DataField="MeasurementName" HeaderText="Measurement Name" />
                            <asp:TemplateField HeaderText="Actions">
                                <ItemStyle Width="150px" />
                                <ItemTemplate>
                                    <div class="d-flex justify-content-evenly">
                                        <asp:LinkButton ID="btnEdit" runat="server" CommandArgument='<%# Eval("MeasurementId") %>' OnClick="btnEdit_Click">
                                            <i class="bx bx-edit-alt me-1"></i>
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnDelete" runat="server"
                                            CommandArgument='<%# Eval("MeasurementId") %>'
                                            OnClick="btnDelete_Click"
                                            OnClientClick="Organization()">
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
        <div class="modal fade" id="basicModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel1">Add Measurement</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col mb-3">
                                <asp:Label ID="lblName" runat="server" Text="Measurement" CssClass="form-label"></asp:Label>
                                <asp:TextBox ID="txtMeasurementName" runat="server" CssClass="form-control" Placeholder="Enter Measurement"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <asp:Button ID="btnSaveChanges" runat="server" CssClass="btn btn-primary" Text="Save" OnClick="btnSaveChanges_Click" />
                        <asp:Button ID="btnbutton" runat="server" class="btn btn-secondary" Text="Close" OnClick="btnbutton_Click" data-bs-dismiss="modal"></asp:Button>
                    </div>
                    <asp:HiddenField ID="hfMeasurement_Id" runat="server" />
                </div>
            </div>
        </div>
    </main>
    <script src="../Admin/js/DeleteAdminConfirmation.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function showModal() {
            var myModal = new bootstrap.Modal(document.getElementById('basicModal'));
            myModal.show();
        }
        function Measurement() {
            var confirm_value = document.createElement('INPUT');
            confirm_value.type = 'hidden';
            confirm_value.name = 'confirm_value';
            if (confirm("Are you sure you want to delete this Measurement?")) {
                confirm_value.value = 'Yes';
            }
            else {
                confirm_value.value = 'No';
            }
            document.forms[0].appendChild(confirm_value);
        }
    </script>
</asp:Content>
