<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PopGroup.aspx.vb" Inherits="estimate_system.PopGroup" %>

<!DOCTYPE html>

<html lang="ja">
<head runat="server">

<%--20200316 DELETE--%>
<%--<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>--%>

    <meta charset="utf-8" />
    <meta http-equiv="Pragma" content="no-cache" />
    <meta http-equiv="Cache-Control" content="no-cache" />
    <title></title>

<%--20200312 EDIT--%>
<%--    <link href="../../Content/jquery-ui.min.css" rel="stylesheet" />--%>
<%--    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">--%>
<%--    <link rel="stylesheet" href="h ttp://code.jquery.com/ui/1.12.1/themes/cupertino/jquery-ui.css">--%>
<%--    <link rel="stylesheet" href="h ttps://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/smoothness/jquery-ui.css">--%>

<%--20200309 DELETE
    <link rel="stylesheet" href="../../Css/Common.css?ver=<%= EstimateSys.Common.Util.getCashClearstr() %>" />--%>
<%--20200310 ADD--%>
    <link href="../../Content/Site.css" rel="stylesheet" />
<%--20200312 DELETE--%>
<%--    <link href="../../Content/Pop.css" rel="stylesheet" />--%>

<%--20200310 ADD--%>
<%--    <script type="text/javascript" src="h ttps://code.jquery.com/jquery-3.3.1.min.js"></script>--%>

<%--    <script src="../../Scripts/jquery-3.4.1.js"></script>--%>
<%--    <script src="../../Scripts/jquery-ui.min.js"></script>--%>

<%--20200310 ADD--%>
<%--    <script src="h ttps://code.jquery.com/jquery-1.12.4.js"></script>--%>
<%--    <script src="h ttps://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>--%>



<%--20200327 DELETE--%>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>



    <%--20200316 DELETE--%>
<%--    <script src="h ttps://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>--%>

<%--    <script src="../../Scripts/js.cookie.js"></script>--%>

<%--    <script src="../../Scripts/Common.js?ver=<%= estimate_system.Common.Util.GetCashClearstr() %>"></script>--%>

    <script src="PopGroup.js?ver=<%= estimate_system.Common.Util.GetCashClearstr() %>"></script>

    <script src="../../Scripts/estimate_system.js"></script>

    <script>
        window.onload = function () {
            $(function () {
                parent.$.closeLoading();
            });
        }
        $(function () {
            //20200313 MOVE
            //$('#BtnBack').click(function () {
            //    parent.$.closeDialog();
            //});
        });
    </script>
</head>
<body>
    <!-- 見積システム 見積詳細 -->
    <form name="ESGroupWindow" method="post" action="#">

        <input type="hidden" name="SubmitMode" id="SubmitMode" value="" />
        <input type="hidden" name="Mode" id="Mode" value="" />

        <input type="hidden" name="CheckNum" id="CheckNum" value="" />
        <input type="hidden" name="GroupNo" id="GroupNo" value="" />
        <input type="hidden" name="NewAddChk" id="NewAddChk" value="" />

        <div id="estimate_system_group_window">
            <p class="group_ttl">グループ管理</p>

            <!-- ■■ グループ情報がある場合はグループの詳細画面 -->
            <div id="group_detail_area">
<%--                <p class="new_group">
                    <input type="button" value="一覧へ戻る" id="BtnBackToList" onclick="estimateSystemGroupWindowBack();" />
                </p>

                <p class="search_ttl">グループ情報</p>
                <table class="group_table" id="group_table">
                    <tr>
                        <th style="width: 100px">グループ番号</th>
                        <td colspan="3">
                            <input type="text" class="box1" name="rGroupNo" id="rGroupNo" value="" maxlength="11" readonly="true" /></td>
                    </tr>
                    <tr>
                        <th>グループ名</th>
                        <td colspan="3">
                            <input type="text" class="box3" name="rGroupName" id="rGroupName" value="" maxlength="100" readonly="true" /></td>
                    </tr>
                    <tr>
                        <th>案件リーダー</th>
                        <td colspan="3">
                            <input type="text" class="box1" name="rGroupLeader" id="rGroupLeader" value="" maxlength="10" readonly="true" /></td>
                    </tr>
                    <tr>
                        <th>サイクル</th>
                        <td colspan="3">--%>
                            <%--20200331 数字のみ--%>
<%--                            <input type="text" class="box4" name="rGroupCycle" id="rGroupCycle" value="" maxlength="2" readonly="true" />
                            ヶ月</td>
                    </tr>
                    <tr>
                        <th rowspan="6" id="group_table_th">所属見積<br />
                            <input type="button" class="btn1" value="見積追加" onclick="estimateSystemGroupWindowDetailNew();" /></th>
                        <th style="width: 110px">見積番号/営業</th>
                        <th>見積件名/得意先CD・名</th>
                        <th style="width: 120px"></th>
                    </tr>
                    <tr class="tr_new">
                        <td>X19060100004</td>
                        <td>得意先CD04：得意先名04</td>
                        <td>
                            <input type="button" class="btn3" id="new_add_btn" value="追 加" onclick="estimateSystemGroupWindowDetailAdd('X19060100004');" />
                        </td>
                    </tr>
                    <tr class="tr_new">
                      <td></td>
                      <td>不明データ</td>
                      <td></td>
                    </tr>
                    <tr id="LN_X19060100001" class="tr_leader">
                        <td>X19060100001<br />
                            <span class="leader_flag" id="LF_X19060100001">L </span>営業名1</td>
                        <td>見積件名1<br />
                            得意先CD1：得意先名1</td>
                        <td id="DL_X19060100001">
                            <input type="button" class="btn3" id="BN_X19060100001" value="ﾘｰﾀﾞｰ" onclick="estimateSystemGroupWindowDetailLeader('X19060100001');" disabled="disabled" />
                            <input type="button" class="btn3" value="削 除" onclick="estimateSystemGroupWindowDetailDelete('X19060100001');" /></td>
                    </tr>
                 
                    <tr id="LN_X19060100003" class="tr_delete">
                        <td>X19060100003<br />
                            <span class="leader_flag no_disp" id="LF_X19060100003">L </span>営業名3</td>
                        <td>見積件名3<br />
                            得意先CD3：得意先名3</td>
                        <td id="DL_X19060100003">削除</td>
                
                    <tr id="LN_X19060100002">
                        <td>X19060100002<br />
                            <span class="leader_flag no_disp" id="LF_X19060100002">L </span>営業名2</td>
                        <td>見積件名2<br />
                            得意先CD2：得意先名2</td>
                        <td id="DL_X19060100002">
                            <input type="button" class="btn3" id="BN_X19060100002" value="ﾘｰﾀﾞｰ" onclick="estimateSystemGroupWindowDetailLeader('X19060100002');" />
                            <input type="button" class="btn3" value="削 除" onclick="estimateSystemGroupWindowDetailDelete('X19060100002');" /></td>
                    </tr>

                </table>

                <p class="group_save">
                    <input type="button" class="btn2" value="保存する" onclick="estimateSystemGroupWindowDetailSave();" />
                </p>
                <p class="group_notice">※すべての操作は保存しないと反映されません。</p>

                <input type="hidden" name="CheckNumList" id="CheckNumList" value="" />
                <input type="hidden" name="LeaderCheckNum" id="LeaderCheckNum" value="X19060100001" />--%>
            </div>
            <%--group_detail_area--%>

            <!-- ■■ グループ情報が無い場合はグループの検索画面-->
            <div id="group_list_area">
                <p class="new_group">
                    <input type="button" value="新規作成" onclick="estimateSystemGroupWindowDetail('新規作成');" />
                </p>

                <p class="search_ttl">グループを検索する</p>
                <table class="group_search_table">
                    <tr>
                        <th style="width: 100px">グループ番号</th>
                        <td style="width: 150px">
                            <input type="text" class="box1" name="sGroupNo" id="sGroupNo" maxlength="11" value="" /></td>
                        <th style="width: 100px">グループ名</th>
                        <td style="width: 270px">
                            <input type="text" class="box2" name="sGroupName" id="sGroupName" maxlength="100" value="" /></td>
                        <td rowspan="2">
                            <input type="button" class="btn1" value="検 索" onclick="estimateSystemGroupWindowSubmit();" /></td>
                    </tr>
                    <tr>
                        <th style="width: 100px">品番</th>
                        <td style="width: 150px">
                            <input type="text" class="box1" name="sProductCode" id="sProductCode" maxlength="20" value="" /></td>
                        <th style="width: 100px">担当営業</th>
                        <td style="width: 270px">
                            <input type="text" class="box2" name="sSalesPerson" id="sSalesPerson" maxlength="10" value="" /></td>
                    </tr>
                </table>

                <!-- ■ 検索結果の表示-->
                 <%--20200325 div追加--%>
                <div id="group_result_table">
    <%--            <table class="group_result_table">
                    <tr>
                        <th style="width: 100px">グループ番号</th>
                        <th>グループ名</th>
                        <th style="width: 100px">案件リーダー</th>
                        <th style="width: 100px">詳細</th>
                    </tr>--%>
                    <%--●データありの場合--%>
    <%--                <tr>
                        <td>GROUP001</td>
                        <td>グループ名１</td>
                        <td>案件 利井田</td>
                        <td>
                            <input type="button" class="btn1" value="詳 細" onclick="estimateSystemGroupWindowDetail('GROUP001');" /></td>
                    </tr>--%>
                    <%--●データなしの場合--%>
    <%--                <tr>
                        <td colspan="4" class="td_nodata">グループが見つかりません。</td>
                    </tr>--%>
                    <%--●--%>
    <%--            </table>--%>
                </div>
                <!-- ■-->
            </div>
            <%--group_list_area--%>

        </div>
    </form>
</body>
</html>
