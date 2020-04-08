<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PopProductIn.aspx.vb" Inherits="estimate_system.PopProductIn" %>

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
    <script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
    <script type="text/javascript" src="./PopProductIn.js?ver=<%= estimate_system.Common.Util.GetCashClearstr() %>"></script>
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
<!-- 見積システム 商品一括入力 -->
<form name="product_in" method="post" action="#">

<div id="estimate_system_product_in">
  <p id="admin_page_ttl">見積システム 商品一括入力</p>

  <p class="input_area"><textarea name="ProductList" id="ProductList" onkeydown="estimateSystemTabInput(this, event);"></textarea></p>
  <p class="notice">※ タブ区切りで品番と数量を同時に入力も可能です。</p>

  <p class="btn_area"><input type="button" value="入　力" onclick="estimateSystemItemAllInBtn();" /> <input type="button" value="閉じる" id="BtnClose" /></p>
</div>

</form>
<!-- ▲ メインコンテンツ閉め ▲ -->
</body>
</html>
