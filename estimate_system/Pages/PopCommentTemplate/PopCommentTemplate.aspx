<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PopCommentTemplate.aspx.vb" Inherits="estimate_system.PopCommentTemplate" %>

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
<%--20200330 DELETE
    <link rel="stylesheet" href="../../Css/Common.css?ver=<%= EstimateSys.Common.Util.getCashClearstr() %>" />
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="../../Scripts/estimate_system.js?ver=<%= EstimateSys.Common.Util.GetCashClearstr() %>"></script>
--%>
<%--20200330 ADD--%>
    <link href="../../Content/Site.css" rel="stylesheet" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="../../Scripts/estimate_system.js?ver=<%= estimate_system.Common.Util.GetCashClearstr() %>"></script>
    <script src="PopCommentTemplate.js?ver=<%= estimate_system.Common.Util.GetCashClearstr() %>"></script>

<script>
    window.onload = function () {
        $(function () {
            parent.$.closeLoading();
        });
    }
    //$(function () {
    //    $('#BtnClose').click(function () {
    //        parent.$.closeDialog();
    //    });
    //});
</script>
</head>
<body>
    <!-- ▼ メインコンテンツここから ▼ -->
    <!-- 見積システム テンプレートコメント -->
    <form name="comment_template" method="post" action="#">
        <input type="hidden" name="SaveNo" id="SaveNo" value="" />

        <div id="estimate_system_comment_template">
            <p id="admin_page_ttl">見積システム テンプレートコメント</p>
            <div id="template_table">
<%--
                <table class="template_table">
                    <tr>
                        <th style="width: 70px">定型文1</th>
                        <td>
                            <textarea name="template1" id="template1">コメント1</textarea></td>
                        <td style="width: 90px">
                            <p>
                                <input type="button" value="備考へ挿入" onclick="estimateSystemTemplateCommentRef('1');" /></p>
                            <p class="save_btn">
                                <input type="button" value="保　存" onclick="estimateSystemTemplateCommentSave('1');" /></p>
                        </td>
                    </tr>
                </table>
--%>
            </div>
            <p class="cls_btn">
                <input type="button" value="閉じる" id="BtnClose" /></p>

        </div>

    </form>
    <!-- ▲ メインコンテンツ閉め ▲ -->
</body>
</html>
