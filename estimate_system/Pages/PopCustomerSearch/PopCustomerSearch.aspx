<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PopCustomerSearch.aspx.vb" Inherits="estimate_system.PopCustomerSearch" %>

<!DOCTYPE html>

<%--20200316 DELETE <html xmlns="http://www.w3.org/1999/xhtml">--%>
<html lang="ja">
<head runat="server">
<%--20200316 DELETE <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />--%>

<%--20200316 ADD--%>
    <meta charset="utf-8" />
    <meta http-equiv="Pragma" content="no-cache" />
    <meta http-equiv="Cache-Control" content="no-cache" />

    <title></title>

<%--20200316 DELETE 
    <link rel="stylesheet" href="../../Css/Common.css?ver=<%= EstimateSys.Common.Util.getCashClearstr() %>" />
    <script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
    <script type="text/javascript" src="../../Scripts/estimate_system.js?ver=<%= EstimateSys.Common.Util.GetCashClearstr() %>"></script>
--%>
<%--20200316 ADD--%>
    <link href="../../Content/Site.css" rel="stylesheet" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="../../Scripts/estimate_system.js?ver=<%= estimate_system.Common.Util.GetCashClearstr() %>"></script>
    <script src="PopCustomerSearch.js?ver=<%= estimate_system.Common.Util.GetCashClearstr() %>"></script>

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
    <!-- 見積システム 得意先検索 -->
    <form name="ESCustomerForm" method="post" action="#">

        <div id="estimate_system_customer_search">
            <p id="admin_page_ttl">見積システム 得意先検索</p>

            <table class="search_tbl">
                <tr>
                    <th style="width:90px">得意先コード：</th>
                    <td style="width:220px">
                        <input type="text" name="Code" id="Code" value="" maxlength="10" />
                        完全一致</td>
                    <th style="width:90px">得意先名称：</th>
                    <td>
                        <input type="text" name="Name" id="Name" value="" maxlength="30" />
                        部分一致</td>
                </tr>
                <tr>
                    <th>索引：</th>
                    <td>
                        <input type="text" name="Index" id="Index" value="" maxlength="10" />
                        部分一致</td>
                    <th>電話番号：</th>
                    <td>
                        <input type="text" name="Tel" id="Tel" value="" maxlength="13" />
                        部分一致</td>
                </tr>
                <tr>
                    <td colspan="4" class="btn_area">
<%--20200326 EDIT       <input type="submit" value="検　索" /></td>--%>
                        <input type="button" value="検　索" onclick="estimateSystemCustomerListSearch();" /></td>
                </tr>
            </table>

            <%--20200326 div ADD--%>
            <div id="result_tbl">
<%--
                <table class="result_tbl">
                    <tr>
                        <th style="width: 90px">得意先CD</th>
                        <th>得意先略称</th>
                        <th style="width: 90px">営業</th>
                        <th style="width: 90px">ｱｼｽﾀﾝﾄ</th>
                        <th style="width: 110px">電話番号</th>
                        <th style="width: 80px"></th>
                    </tr>
                    <tr>
                        <td>0000000001</td>
                        <td>三信電気</td>
                        <td>営業名１</td>
                        <td>アシスタント小林 藍</td>
                        <td>XX-XXXX-XXXX</td>
                        <td>
                            <input type="button" value="選択" onclick="estimateSystemCustomerChoice('0000000001');" /></td>
                    </tr>
                </table>

                <p class="nodata">検索結果が1000件以上です。<br>検索条件で絞ってください。</p>
                <p class="nodata">検索結果なし</p>
--%>

            </div>

            <%--20200330 ADD--%>
            <input type="hidden" name="CustomerCode" id="CustomerCode" value="" />

            <p class="btn_area"><input type="button" value="閉じる" id="BtnClose" /></p>
        </div>

    </form>
    <!-- ▲ メインコンテンツ閉め ▲ -->
</body>
</html>
