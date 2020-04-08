<%@ Page Title="見積案件システム　ログイン" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Login.aspx.vb" Inherits="estimate_system.Login" %>

<%@ MasterType VirtualPath="~/Site.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">

<%--<div id="admin_login" class="clfx">--%>
<%--<form name="admin_login_form" runat="server">--%>

    <div class="card-content">
        <div class="card">
            <article class="card-body">
                <h4 class="card-title text-left mb-4 mt-1">ログイン</h4>
                <hr>
                <div class="text-success text-left">
                    <asp:Label ID="lblMsg" runat="Server" Text="" /></div>
                <div class="text-danger text-left">
                    <asp:Label ID="lblErrMsg" runat="Server" Text="" /></div>
                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-prepend">
                            <span class="input-group-text"><i class="fa fa-user">ログインID</i></span>
                        </div>

                        <asp:TextBox ID="txtKGLoginName" runat="server" Text="" MaxLength="20" CssClass="form-control col-4" ToolTip="20文字までの半角英記号" TabIndex="0" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="必須入力です" ControlToValidate="txtKGLoginName"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="20文字までの半角英記号" 
                            ControlToValidate="txtKGLoginName" ValidationExpression="^[a-zA-Z!-/:-@¥[-`{-~]+$" ForeColor="#FF0066" SetFocusOnError="true" EnableClientScript="true" Display="Dynamic" />
                    </div>
                </div>
                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-prepend">
                            <span class="input-group-text"><i class="fa fa-lock">パスワード</i></span>
                        </div>
                        <asp:TextBox ID="txtKGPassword" runat="server" Text="" TextMode="Password" MaxLength="20" CssClass="form-control col-4" ToolTip="20文字までの半角数字" TabIndex="1" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="必須入力です" ControlToValidate="txtKGPassword"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="20文字までの半角数字" 
                            ControlToValidate="txtKGPassword" ValidationExpression="^[0-9]+$" ForeColor="#FF0066" SetFocusOnError="true" EnableClientScript="true" Display="Dynamic" />
                    </div>
                </div>
                <div class="input-group">
                    <div class="input-group-prepend">
                        <asp:Button ID="BtnLogin" runat="server" Text="ログイン" CssClass="btn btn-primary" OnClick="BtnLogin_Click" TabIndex="2" />
                    </div>
                </div>

            </article>
        </div>
    </div>

</asp:Content>
