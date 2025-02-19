﻿<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Admin.Master" CodeBehind="ViewStaff.aspx.cs" Inherits="MBMS_APP.WebUI.Staff.ViewStaff" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="AdminMasterPage" runat="server">
    <main>
        <div class="container-xxl flex-grow-1 container-p-y">
            <h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">Users /</span> Staff Details</h4>

            <!-- Staff Data Table -->
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
                <div class="table-responsive text-nowrap">
                    <asp:GridView ID="gvUsers" runat="server" AutoGenerateColumns="False" CssClass="table" DataKeyNames="UserId"
                        AllowPaging="true" PageSize="10" OnPageIndexChanging="gvUsers_PageIndexChanging" HeaderStyle-CssClass="thead table-header thead-bg-color">
                        <Columns>
                            <asp:BoundField DataField="FirstName" HeaderText="First Name" />
                            <asp:BoundField DataField="LastName" HeaderText="Last Name" />

                            <asp:TemplateField HeaderText="Gender">
                                <ItemTemplate>
                                    <asp:Label ID="lblGender" runat="server"
                                        Text='<%# Convert.ToBoolean(Eval("Gender")) ? "Male" : "Female" %>'>
                                    </asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="DateOfBirth" HeaderText="Date of Birth" DataFormatString="{0:dd/MM/yyyy}" />
                            <asp:BoundField DataField="Username" HeaderText="Username" />
                            <asp:BoundField DataField="PhoneNumber" HeaderText="Phone Number" />
                            <asp:BoundField DataField="AadharNumber" HeaderText="Aadhar Number" />
                            <asp:BoundField DataField="Address" HeaderText="Address" />
                            <asp:BoundField DataField="OrganizationName" HeaderText="Organization Name" />
                            <asp:BoundField DataField="RoleName" HeaderText="Role Name" />
                            <asp:TemplateField HeaderText="User Status">
                                <ItemTemplate>
                                    <asp:Label ID="lblUserStatus" runat="server"
                                        Text='<%# Convert.ToBoolean(Eval("IsActive")) ?"Active" : "Inactive" %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Actions">
                                <ItemStyle Width="150px" />
                                <ItemTemplate>
                                    <div class="d-flex justify-content-evenly">
                                        <asp:LinkButton ID="btnEdit" runat="server" CommandName="Edit" CommandArgument='<%#Eval("UserId") %>'
                                            OnClick="btnEdit_Click">
                                                <i class="bx bx-edit-alt me-1"></i>
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" CommandArgument='<%#Eval("UserId") %>'
                                            OnClick="btnDelete_Click" OnClientClick="Confirm()">
                                                 <i class="bx bx-trash me-1"></i>
                                        </asp:LinkButton>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
            <!--/ User Data Table -->
        </div>
    </main>
</asp:Content>
