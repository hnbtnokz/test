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
        <div id="estimate_detail_main">
<%--@@@@--%>
        <div class="head_data">
        
           <table class="head_data_table">
                 <tbody>
                 <tr>
                   <th width="80">見積件名</th>
                   <td width="365"><input type="text" name="Title" id="Title" value="テスト-リコー番号なし" maxlength="80">
                   </td>
                 </tr>
                 <tr>
                   <th style="vertical-align: top;">備考 <input type="button" value="参照" onclick="estimateSystemTemplateCommentOpen();"></th>
                   <td colspan="3"><textarea name="Other" id="Other"></textarea>
                   </td>
                 </tr>
                 <tr>
                   <th style="vertical-align: top;">メール文書</th>        
                   <td colspan="3"><textarea name="FixMailBody" id="FixMailBody">null</textarea><br>※ メール文書はサンワChからの依頼取込、またはアカウント連携後のサンワCh表示本登録時に送信されるメールへの差込文章になります。
                   </td>      
                 </tr>
                 <tr class="tr_sep">
                   <th>最終ユーザ名</th>
                   <td colspan="3"><input type="text" name="EndUserName" id="EndUserName" value="テスト エンドユーザー" maxlength="50">
                   <input type="button" value="件名をコピー" onclick="estimateSystemDetailUserNameCopy();">
                   </td>      
                 </tr>      
                 <tr>
                   <th>エンドユーザー業種</th>
                   <td><input type="text" name="EndUserAddress" id="EndUserAddress" placeholder="市区町村" value="" maxlength="50">
                   </td>      
                 </tr>
                 <tr>        
                 <th style="vertical-align: top;">営業メモ<br>(非公開)</th>        
                   <td colspan="3"><textarea name="SalesMemo" id="SalesMemo" placeholder="共有されない営業用のメモです。"></textarea>
                   </td>      
                 </tr>      
                 <tr>        
                   <td colspan="4" class="btn_area"><input type="button" value="最終ユーザ名・エンドユーザー業種・住所区分・メモ 保存" onclick="estimateSystemDetailMemoSave();">
                   </td>
                 </tr>    
                 </tbody>
           </table>
           
        </div>

<%--@@@@--%>
        </div>

        <!-- ****************************  商品情報表示部  ************************************* -->
        <div id="estimate_detail_product"></div>

        <!-- ***************************** 各種ボタン表示部 ************************************ -->
        <div class="detail_btn" id="detail_btn"></div>

    </div><%--estimate_system_detail--%>

<%--</form>--%>

</div><%--admin_main_contents--%>
<!-- ▲ メインコンテンツ閉め ▲ -->

</asp:Content>
