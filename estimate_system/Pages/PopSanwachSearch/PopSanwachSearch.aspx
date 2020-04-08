<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PopSanwachSearch.aspx.vb" Inherits="estimate_system.PopSanwachSearch" %>

<!DOCTYPE html>

<%--20200330 DELETE <html xmlns="http://www.w3.org/1999/xhtml">--%>
<html lang="ja">
<head runat="server">
<%--20200330 DELETE <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />--%>

<%--20200330 ADD--%>
    <meta charset="utf-8" />
    <meta http-equiv="Pragma" content="no-cache" />
    <meta http-equiv="Cache-Control" content="no-cache" />

    <title></title>
<%--
    <link rel="stylesheet" href="../../Css/Common.css?ver=<%= EstimateSys.Common.Util.getCashClearstr() %>" />
    <script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
    <script type="text/javascript" src="../../Scripts/estimate_system.js?ver=<%= EstimateSys.Common.Util.GetCashClearstr() %>"></script>
--%>
    <%--20200402 ADD--%>
    <link href="../../Content/bootstrap.css" rel="stylesheet" />
<%--20200330 ADD--%>
    <link href="../../Content/Site.css" rel="stylesheet" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="../../Scripts/estimate_system.js?ver=<%= estimate_system.Common.Util.GetCashClearstr() %>"></script>
    <script src="PopSanwachSearch.js?ver=<%= estimate_system.Common.Util.GetCashClearstr() %>"></script>

    <script>
        window.onload = function () {
            $(function () {
                parent.$.closeLoading();
            });
        }
        //$(function () {
        //    $('#btnClose').click(function () {
        //        parent.$.closeDialog();
        //    });
        //});
    </script>
</head>
<body>
    <!-- ▼ メインコンテンツここから ▼ -->
    <!-- 見積システム ログインID検索 -->
    <form name="ESSanwaChForm" method="post" action="#">

    <div id="estimate_system_loginid_search">
      <p id="admin_page_ttl">見積システム ログインID選択</p>

      <div class="result_area" id="result_area">

<%--        <p class="no_account">アカウントがありません。</p>--%>

<%--20200402 EDIT--%>
<%--        <table>--%>
<%--        <table class="table table-striped">--%>

<%--20200402 EDIT--%>
<%--
          If LoginId = ObjWB("LoginId") Then->class="select" --->>> <tr class="info"> 20200402 EDIT
          ElseIf Cnt mod 2 = 0 Then %> class="zebra" --->>> <table class="table table-striped"> 20200402 EDIT
--%>
          <%--<tr class="select"> or <tr class="zebra">--%>
<%--            <td style="width:70px"></td>
            <td style="width:140px" class="center"></td>
            <td class="center"><a href="mailto:"></a></td>
            <td style="width:70px"><input type="button" value="連 携" onclick="estimateSystemDetail3chIDSelect('');" /></td>
          </tr>
        </table>--%>

      </div><%--result_area--%>

      <p class="notice">※ メールアドレスの登録の無いアカウントは表示されません。</p>

      <p class="btn_area">

<%--20200402 EDIT--%>
<%--          <input type="button" value="連携解除" onclick="estimateSystemDetail3chIDClear();" />&nbsp;&nbsp;&nbsp;--%>
          <input type="button" value="連携解除" id="BtnClear" onclick="estimateSystemDetail3chIDClear();" />&nbsp;&nbsp;&nbsp;

          <input type="button" value="閉じる" id="BtnClose" />
      </p>
    </div>

    </form>
    <!-- ▲ メインコンテンツ閉め ▲ -->
</body>
</html>
