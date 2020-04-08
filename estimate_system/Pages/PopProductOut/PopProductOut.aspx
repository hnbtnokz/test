<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PopProductOut.aspx.vb" Inherits="estimate_system.PopProductOut" %>

<!DOCTYPE html>

<html lang="ja">
<head runat="server">
    <%--20200316 DELETE--%>
<%--<html xmlns="http://www.w3.org/1999/xhtml">--%>
<%--<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>--%>

    <meta charset="utf-8" />
    <meta http-equiv="Pragma" content="no-cache" />
    <meta http-equiv="Cache-Control" content="no-cache" />
    <title></title>
    <link href="../../Content/Site.css" rel="stylesheet" />
    <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
    <script src="./PopProductOut.js?ver=<%= estimate_system.Common.Util.GetCashClearstr() %>"></script>
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
<%--<body onload="estimateSystemItemDataCopyCall();">--%>
<body>
<!-- ▼ メインコンテンツここから ▼ -->
<!-- 見積システム 商品データ出力 -->
<form name="product_out" method="post" action="#">

<div id="estimate_system_product_out">
  <p id="admin_page_ttl">見積システム 商品データ出力</p>

  <p class="input_area"><textarea name="ProductList" id="ProductList" onfocus="this.select();"></textarea></p>

  <p class="btn_area"><input type="button" value="閉じる" id="BtnClose" /></p>
</div>

</form>
<!-- ▲ メインコンテンツ閉め ▲ -->
</body>
</html>
