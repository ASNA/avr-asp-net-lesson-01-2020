<%@ Page Language="AVR" MasterPageFile="~/MasterPageNoNav.master" AutoEventWireup="false" CodeFile="login.aspx.vr" Inherits="views_login" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Content" Runat="Server">

    <div class="container">
        <div class="form-group">
            <label for="user">User</label>
            <asp:TextBox placeholder="User name" CssClass="form-control" ID="user" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator CssClass="form-text error-message" ID="userRequiredValidator" ControlToValidate="user" runat="server" ErrorMessage="Please enter user name" Display="Dynamic"></asp:RequiredFieldValidator>
        </div>
        <div class="form-group">
            <label for="password">Password</label>
            <asp:TextBox placeholder="password" CssClass="form-control" ID="password" runat="server" TextMode="Password"></asp:TextBox>
            <asp:RequiredFieldValidator CssClass="form-text error-message" ID="passwordRequiredValidator" ControlToValidate="user" runat="server" ErrorMessage="Please enter your password" Display="Dynamic"></asp:RequiredFieldValidator>
        </div>
        <div class="form-group form-check">
            <asp:CheckBox CssClass="form-check-input" ID="rememberme" runat="server" />
            <label class="form-check-label" for="rememberme">Remember me</label>
        </div>
        <br />
        <asp:Button CssClass="btn btn-primary" ID="buttonlogin" runat="server" Text="Login" />
        <asp:CustomValidator CssClass="alert alert-danger" ID="loginFailedValidator" runat="server" ErrorMessage="Login failed" Display="Dynamic"></asp:CustomValidator>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PageScripts" Runat="Server">

<scri
    applib.removeAspNetCheckboxWrapper('#content_rememberme')
</script>
</asp:Content>

