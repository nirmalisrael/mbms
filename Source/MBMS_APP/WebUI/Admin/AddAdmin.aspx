<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Admin.Master" CodeBehind="AddAdmin.aspx.cs" Inherits="MBMS_APP.WebUI.Admin.AddAdmin" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="AdminMasterPage" runat="server">
    <main>
        <div class="container-xxl flex-grow-1 container-p-y">
            <h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">Members /</span> Add Admin</h4>
            <!-- Basic Layout -->
            <asp:HiddenField ID="hfUser_Id" runat="server" />
            <div class="row">
                <div class="col-xl">
                    <div class="card mb-4">
                        <div class="card-header d-flex justify-content-between align-items-center">
                            <small class="text-muted float-end"></small>
                        </div>
                        <div class="card-body">
                            <asp:Panel ID="Panel1" runat="server" CssClass="row">
                                <%--First Name--%>
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <asp:Label ID="lblFirstName" runat="server" Text="First Name" CssClass="form-label" AssociatedControlID="txtFirstName"></asp:Label>
                                        <div class="input-group">
                                            <span id="basic-icon-default-fullname2" class="input-group-text">
                                                <i class="bx bx-user"></i>
                                            </span>
                                            <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control" Placeholder="John"></asp:TextBox>
                                        </div>
                                        <asp:RegularExpressionValidator
                                            ID="revFirstName"
                                            runat="server"
                                            ControlToValidate="txtFirstName"
                                            ErrorMessage="Invalid First name"
                                            ValidationExpression="^[a-zA-Z]+$"
                                            ForeColor="Red"
                                            Display="Dynamic">
                                        </asp:RegularExpressionValidator>
                                        <asp:RequiredFieldValidator
                                            ID="RequiredFieldValidator1"
                                            runat="server"
                                            ControlToValidate="txtFirstName"
                                            ErrorMessage="First name is required"
                                            ForeColor="Red"
                                            Display="Dynamic">
                                         </asp:RequiredFieldValidator>
                                    </div>
                                    <%--First Name--%>
                                    <%--Date Of Birth--%>
                                    <div class="mb-3">
                                        <asp:Label ID="lblDateOfBirth" runat="server" Text="Date Of Birth" CssClass="form-label" AssociatedControlID="txtDateOfBirth"></asp:Label>
                                        <asp:TextBox ID="txtDateOfBirth" runat="server" CssClass="form-control" TextMode="Date" Text="2021-06-18"></asp:TextBox>
                                    </div>
                                    <%--Date Of Birth--%>
                                    <%--E-mail--%>
                                    <div class="mb-3">
                                        <asp:Label ID="lblEmail" runat="server" Text="Email" CssClass="form-label" AssociatedControlID="txtEmail"></asp:Label>
                                        <div class="input-group input-group-merge">
                                            <span class="input-group-text">
                                                <i class="bx bx-envelope"></i>
                                            </span>
                                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" Placeholder="john.doe" aria-label="john.doe"></asp:TextBox>
                                            <span class="input-group-text">@example.com</span>
                                        </div>
                                        <asp:RegularExpressionValidator
                                            ID="revEmail"
                                            runat="server"
                                            ControlToValidate="txtEmail"
                                            ErrorMessage="Invalid Email format"
                                            ValidationExpression="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"
                                            ForeColor="Red"
                                            Display="Dynamic">
                                         </asp:RegularExpressionValidator>
                                        <asp:RequiredFieldValidator
                                            ID="RequiredFieldValidator2"
                                            runat="server"
                                            ControlToValidate="txtEmail"
                                            ErrorMessage="Email is required"
                                            ForeColor="Red"
                                            Display="Dynamic">
                                         </asp:RequiredFieldValidator>
                                    </div>
                                    <%--E-mail--%>
                                    <%--Phone Number--%>
                                    <div class="mb-3">
                                        <asp:Label ID="lblPhoneNumber" runat="server" Text="Phone No" CssClass="form-label" AssociatedControlID="txtPhoneNumber"></asp:Label>
                                        <div class="input-group">
                                            <span id="basic-icon-default-fullname5" class="input-group-text">
                                                <i class="bx bx-phone"></i>
                                            </span>
                                            <asp:TextBox ID="txtPhoneNumber" runat="server" CssClass="form-control phone-mask" Placeholder="658 799 8941"></asp:TextBox>
                                        </div>
                                        <asp:RegularExpressionValidator
                                            ID="revPhoneNumber"
                                            runat="server"
                                            ControlToValidate="txtPhoneNumber"
                                            ErrorMessage="Invalid Number"
                                            ValidationExpression="^[\d\s\+]+$"
                                            ForeColor="Red"
                                            Display="Dynamic">
                                        </asp:RegularExpressionValidator>
                                        <asp:RequiredFieldValidator
                                            ID="RequiredFieldValidator3"
                                            runat="server"
                                            ControlToValidate="txtPhoneNumber"
                                            ErrorMessage="Phone number is required"
                                            ForeColor="Red"
                                            Display="Dynamic">
                                         </asp:RequiredFieldValidator>
                                    </div>
                                    <%--Phone Number--%>
                                    <%--Roles--%>
                                    <div class="mb-3">
                                        <asp:Label ID="lblRole" runat="server" Text="Role" CssClass="form-label" AssociatedControlID="ddlRole"></asp:Label>
                                        <div class="input-group">
                                            <span id="basic-icon-default-fullname7" class="input-group-text">
                                                <i class="fa-regular fa-circle-user"></i>
                                            </span>
                                            <asp:DropDownList ID="ddlRole" runat="server" CssClass="form-select" />
                                        </div>
                                    </div>
                                    <%--Roles--%>
                                    <%--Address--%>
                                    <div class="mb-3">
                                        <asp:Label ID="lblAddress" runat="server" Text="Address" CssClass="form-label" AssociatedControlID="txtAddress"></asp:Label>
                                        <div class="input-group">
                                            <span id="basic-icon-default-fullname8" class="input-group-text">
                                                <i class="fa-regular fa-address-book"></i>
                                            </span>
                                            <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control phone-mask" TextMode="MultiLine" Placeholder="Athanavur, Yelagiri, Tamil Nadu 635853"></asp:TextBox>
                                        </div>
                                    </div>
                                    <asp:RequiredFieldValidator
                                        ID="rfvAddress"
                                        runat="server"
                                        ControlToValidate="txtAddress"
                                        ErrorMessage="Address is required"
                                        ForeColor="Red"
                                        Display="Dynamic">
                                        </asp:RequiredFieldValidator>
                                </div>
                                <%--Address--%>
                                <%--Last Name--%>
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <asp:Label ID="lblLastName" runat="server" Text="Last Name" CssClass="form-label" AssociatedControlID="txtLastName"></asp:Label>
                                        <div class="input-group">
                                            <span id="basic-icon-default-fullname3" class="input-group-text">
                                                <i class="bx bx-user"></i>
                                            </span>
                                            <asp:TextBox ID="txtLastName" runat="server" CssClass="form-control" Placeholder="Doe"></asp:TextBox>
                                        </div>
                                        <asp:RegularExpressionValidator
                                            ID="RegularExpressionValidator1"
                                            runat="server"
                                            ControlToValidate="txtLastName"
                                            ErrorMessage="Invalid Last name"
                                            ValidationExpression="^[a-zA-Z]+$"
                                            ForeColor="Red"
                                            Display="Dynamic">
                                        </asp:RegularExpressionValidator>
                                    </div>
                                    <%--Last Name--%>
                                    <br />
                                    <%--Gender--%>
                                    <div class="mb-3">
                                        <small class="text-bold fw-bold d-block">GENDER</small>
                                        <div class="form-check-inline">
                                            <asp:RadioButton
                                                ID="rbMale"
                                                runat="server"
                                                GroupName="Gender"
                                                CssClass="margin-right:10px" />
                                            <asp:Label runat="server" AssociatedControlID="rbMale" CssClass="form-check-label">Male</asp:Label>
                                        </div>
                                        <div class="form-check-inline">
                                            <asp:RadioButton
                                                ID="rbFemale"
                                                runat="server"
                                                GroupName="Gender"
                                                Css="margin-right:10px" />
                                            <asp:Label runat="server" AssociatedControlID="rbFemale" CssClass="form-check-label">Female</asp:Label>
                                        </div>
                                    </div>
                                    <%--Gender--%>
                                    <%--Aadhar Number--%>
                                    <div class="mb-3">
                                        <asp:Label ID="lblAadhar" runat="server" Text="Aadhar Number" CssClass="form-label" AssociatedControlID="txtAadharNumber"></asp:Label>
                                        <div class="input-group">
                                            <span id="basic-icon-default-fullname4" class="input-group-text">
                                                <i class="fa-regular fa-id-card"></i>
                                            </span>
                                            <asp:TextBox ID="txtAadharNumber" runat="server" CssClass="form-control phone-mask" Placeholder="8451 0786 5349"></asp:TextBox>
                                        </div>
                                        <asp:RegularExpressionValidator
                                            ID="revAadharNumber"
                                            runat="server"
                                            ControlToValidate="txtAadharNumber"
                                            ErrorMessage="Invalid Aadhar number"
                                            ValidationExpression="^\d{12}$"
                                            ForeColor="Red"
                                            Display="Dynamic">
                                            </asp:RegularExpressionValidator>
                                        <asp:RequiredFieldValidator
                                            ID="RequiredFieldValidator4"
                                            runat="server"
                                            ControlToValidate="txtAadharNumber"
                                            ErrorMessage="Aadhar Number is required"
                                            ForeColor="Red"
                                            Display="Dynamic">
                                        </asp:RequiredFieldValidator>
                                    </div>
                                    <%--Aadhar Number--%>
                                    <%--Password--%>
                                    <div class="mb-3">
                                        <asp:Label ID="lblPassword" runat="server" Text="Password" CssClass="form-label" AssociatedControlID="txtPassword"></asp:Label>
                                        <div class="input-group">
                                            <span id="basic-icon-default-fullname6" class="input-group-text">
                                                <i class="bx bxs-key"></i>
                                            </span>
                                            <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" Placeholder="Password123"></asp:TextBox>
                                            <span class="input-group-text" id="togglePassword">
                                                <i id="eyeIcon" class="bx bx-show"></i>
                                            </span>
                                        </div>
                                        <asp:RequiredFieldValidator
                                            ID="rfvPassword"
                                            runat="server"
                                            ControlToValidate="txtPassword"
                                            ErrorMessage="Password is required"
                                            ForeColor="Red"
                                            Display="Dynamic">
                                        </asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator
                                            ID="revPassword"
                                            runat="server"
                                            ControlToValidate="txtPassword"
                                            ErrorMessage="Password must be in a combination of (A , a , 0-1 , @#!)"
                                            ValidationExpression="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&#])[A-Za-z\d@$!%*?&#]{8,}$"
                                            ForeColor="Red"
                                            Display="Dynamic">
                                    </asp:RegularExpressionValidator>
                                    </div>
                                    <%--Password--%>
                                    <br />
                                    <%--Is Staff Member--%>
                                    <div class="form-check mb-3">
                                        <asp:CheckBox ID="chkIsStaffmember" runat="server" Css="margin-left:-10px" Checked="False" />
                                        <asp:Label runat="server" AssociatedControlID="chkIsStaffmember" CssClass="form-check-label">Also Dines in Mess</asp:Label>
                                    </div>
                                    <br>
                                    <div class="form-check mb-3">
                                        <asp:CheckBox ID="chkHostel" runat="server" Css="margin-left:-10px" Checked="False" />
                                        <asp:Label runat="server" AssociatedControlID="chkHostel" CssClass="form-check-label">Hostel</asp:Label>
                                    </div>
                                    <div class="mb-3">
                                        <asp:Label ID="lblOrganization" runat="server" Text="Organization" CssClass="form-label" AssociatedControlID="ddlOrganization"></asp:Label>
                                        <div class="input-group">
                                            <span id="basic-icon-default-fullname9" class="input-group-text">
                                                <i class="bx bx-buildings"></i>
                                            </span>
                                            <asp:DropDownList ID="ddlOrganization" runat="server" CssClass="form-select">
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                    <%--Is Staff Member--%>
                                    <%--SAVE AND CANCEL--%>
                                    <div class="mb-3 text-center">
                                        <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn btn-primary" OnClick="btnSave_Click" />
                                        <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-secondary" CausesValidation="False" OnClick="btnCancel_Click" />
                                    </div>
                                    <%--SAVE AND CANCEL--%>
                                </div>
                        </div>
                        </asp:Panel>
                    </div>
                </div>
            </div>
        </div>

    </main>
    <script type="text/javascript">
        document.addEventListener("DOMContentLoaded", function () {
            const passwordField = document.getElementById("<%= txtPassword.ClientID %>");
            const togglePassword = document.getElementById("togglePassword");
            const eyeIcon = document.getElementById("eyeIcon");

            togglePassword.addEventListener("click", function () {
                // Toggle the type attribute
                const type = passwordField.getAttribute("type") === "password" ? "text" : "password";
                passwordField.setAttribute("type", type);

                // Toggle the eye icon class
                if (type === "password") {
                    eyeIcon.classList.remove("bx-show");
                    eyeIcon.classList.add("bx-hide");
                } else {
                    eyeIcon.classList.remove("bx-hide");
                    eyeIcon.classList.add("bx-show");
                }
            });
        });
    </script>

</asp:Content>
