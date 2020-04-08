<%@ Page Title="見積案件システム　詳細" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Detail.aspx.vb" Inherits="estimate_system.Detail" %>

<%@ MasterType VirtualPath="~/Site.Master" %>

<asp:Content ID="Header" ContentPlaceHolderID="head" runat="server" ClientIDMode="Static">
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="body" runat="server" ClientIDMode="Static">

    <%--20200309 MOVE FROM MASTER--%>
    <script src="Scripts/Common.js?ver=<%= estimate_system.Common.Util.GetCashClearstr() %>"></script>

    <script src="Scripts/Detail.js?ver=<%= estimate_system.Common.Util.GetCashClearstr() %>"></script>
    <script src="Scripts/estimate_system.js"></script>

<!-- ▼ メインコンテンツここから ▼ -->
<div id="admin_main_contents" class="clfx">
<%--<div class="admin_main_contents"><!-- width: 1880px;-->--%>

<!-- 見積システム 見積詳細 -->
<%--<form name="ESDetailForm" runat="server" method="post" action="#">--%>

<%--    20200323 DELETE ダブリ--%>
<%--<asp:HiddenField ID="CheckNum" runat="server" value="" />--%>

<asp:HiddenField ID="SubmitMode" runat="server" value="" />
<asp:HiddenField ID="RequestNumber" runat="server" value="aaa" />
<asp:HiddenField ID="FixFlag" runat="server" value="bbb" />
<asp:HiddenField ID="SubmitFixFlag" runat="server" value="" />
<asp:HiddenField ID="FirstCustomerErrorFlag" runat="server" value="0" />
<asp:HiddenField ID="RICOHFlag" runat="server" value="ccc" />
<asp:HiddenField ID="ConclusionStatus" runat="server" value="" />
<input type="hidden" id="EstPersonName" value="<%= Session("EstPersonName") %>" />

    <div id="estimate_system_detail">
<%--<div class="estimate_system_detail"><!--width: 1880px;-->--%>
<%--
    <p class="admin_page_ttl">見積案件システム 見積詳細</p>
    <hr>
    <div class="text-success text-left">
        <asp:Label ID="lblMsg" runat="Server" Text="検索条件を選択・入力してください" />
    </div>
    <div class="text-danger text-left">
        <asp:Label ID="lblErrMsg" runat="Server" Text="" />
    </div>
--%>

        <!-- ***************************** コメント表示部 ************************************** -->
        <div id="CommentArea"></div>

        <%--20200306--%>
<%--        <p id="admin_page_ttl">見積案件システム 見積詳細</p>--%>
        <p class="admin_page_ttl" id="admin_page_ttl">見積案件システム 見積詳細</p>

        <!-- **************************** 見積詳細情報表示部 *********************************** -->
        <div id="estimate_detail_main"></div>

        <!-- ****************************  商品情報表示部  ************************************* -->
        <div id="estimate_detail_product"></div>

        <!-- ***************************** 各種ボタン表示部 ************************************ -->
        <div class="detail_btn" id="detail_btn"></div>

    </div><%--estimate_system_detail--%>

<%--</form>--%>

</div><%--admin_main_contents--%>
<!-- ▲ メインコンテンツ閉め ▲ -->

</asp:Content>
