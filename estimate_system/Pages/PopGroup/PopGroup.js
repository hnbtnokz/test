$(function () {

//*****************************************************
// グルーバル変数
//*****************************************************
    var mode = "";
    var checkNum = "";
    var groupNo = "";

    //20200323 ADD ?
    //var SubmitMode = "";

    //20200317 ADD 詳細・見積追加
    var CheckNum = "";          //results[1]
    var SalesPersonName = "";   //results[2]
    var Title = "";             //results[3]
    var CustomerCode = "";      //results[4]
    var CustomerName = "";      //results[5]

    //20200323 ADD
    const MaxDispLine = 20;
    var NowDispMax;

    //リスト・検索
    var GroupNoArr = {};
    var rGroupNameArr = {};
    var SalesPersonNameArr = {};

    //詳細
    //var GroupNoArr = {};
    //var rGroupNameArr = {};
    var LeaderNameArr = {};
    var rGroupCycleArr = {};

    var CheckNumArr = {};
    //var SalesPersonNameArr = {};
    var LeaderFlagArr = {};
    var TitleArr = {};
    var CustomerCodeArr = {};
    var CustomerNameArr = {};

    //20200407 ADD
    var EditFlagArr = {};
    var NewCheckNumFlagArr = {};


//*****************************************************

    ////20200313 MOVE
    ////一覧へ戻る
    //$('#BtnBack').click(function () {
    //    //parent.$.closeDialog();   //ok
    //    location.href = "./PopGroup.aspx?mode=list";   //グループ管理　リストへ戻る
    //});

    ////20200313 ADD test reloadDialog
    //$('#BtnTest').click(function () {
    //    parent.$.reloadDialog();    //ok
    //});



    //─────────────────────────────────────
    //機能： グループ管理画面Load時イベント
    //引数： 
    //戻値： 
    //補足： 
    //─────────────────────────────────────
    $(document).ready(function () {
        //test
        //alert("$(#SubmitMode).val()=" + $("#SubmitMode").val());
        //alert("$(#sGroupNo).val()=" + $("#sGroupNo").val());
        //alert("sGroupNo=" + sGroupNo);

        //test2
        //var querystr = window.location.search;
        // GET変数が存在する場合
        //if (querystr) {
            //alert("PopGroup.js - querystr=" + querystr);
        //}
        //*****************************************************
        //test1
        //var url = "./Pages/PopGroup/PopGroup.aspx/GetJsonTestData";

        //var data = JSON.stringify({ test: 'TEST' });
        //var result = parent.$.getAjaxData(url, data);
        //var esData = JSON.parse(result);
        ////if (result.indexOf('エラー：') != -1) {
        //if (result.match(/エラー：/)) {
        //    alert(esData);
        //    return false;
        //}
        //alert(esData["DT1"][0]["A"] + ':' + esData["DT1"][0]["B"] + ':' + esData["DT1"][0]["C"]);
        //alert(esData["DT2"][0]["A"]);
        //*****************************************************
        var querystr = window.location.search;

        //TODO:検索条件の値は持ち回る←保留

        // GET変数が存在する場合
        mode = "";
        checkNum = "";
        groupNo = "";

        if (querystr) {
            if (!querystr.match(/&/)) {
                //querystrに含む場合の処理
                if (querystr.split('=')[0].match(/mode/)) {
                    mode = querystr.split('=')[1];
                }
                //if (querystr.split('=')[0].match(/test/) && querystr.split('=')[1].match(/on/)) {
                //    TestMode = true;
                //} else if (querystr.split('=')[0].match(/test/) && querystr.split('=')[1].match(/off/)) {
                //    TestMode = false;
                //}
                if (querystr.split('=')[0].match(/cno/)) {
                    checkNum = querystr.split('=')[1];
                }
                if (querystr.split('=')[0].match(/gno/)) {
                    groupNo = querystr.split('=')[1];
                }

            } else {
                // ?を取り除くため、1から始める。keyと値に分割。
                array = querystr.slice(1).split('&');
                qsarr = new Array();
                // GET変数を順に処理
                $.each(array,
                    function (index, elem) {
                        if (elem.split('=')[0].match(/mode/)) {
                            mode = elem.split('=')[1];
                        }
                        //if (elem.split('=')[0].match(/test/) && elem.split('=')[1].match(/on/)) {
                        //    TestMode = true;
                        //} else if (elem.split('=')[0].match(/test/) && elem.split('=')[1].match(/off/)) {
                        //    TestMode = false;
                        //}
                        if (elem.split('=')[0].match(/cno/)) {
                            checkNum = elem.split('=')[1];
                        }
                        if (elem.split('=')[0].match(/gno/)) {
                            groupNo = elem.split('=')[1];
                        }
                    }
                );
            }
        }

        //画面切り替え
        $.pageInitSwitch(mode);

        //mode="list"の場合、リストへ
        if (mode == "list") {
            ////var url = "./Pages/PopGroup/PopGroup.aspx/GetJsonGroupData";
            //$.pageInitDisplay();    //検索結果エリア:非表示
            //TODO: 検索条件を持ち回る

        }
        //mode="detail"の場合、詳細へ
        if (mode == "detail") {
            //test data
            //groupNo = "GROUP001";
            //checkNum = "X19060100001";
            //Title = "GroupTitle1";     //新規の場合のタイトル
            //注意：新規作成の場合、gno = '新規作成'->新規作成用のデータも積む
            if (groupNo == "新規作成") {
                //$.pageInitMainDetail();
            } else {

            }
            var url = "./Pages/PopGroup/PopGroup.aspx/GetJsonGroupDetailData";
            var data = JSON.stringify({ GroupNo: groupNo, CheckNum: checkNum });
            var result = parent.$.getAjaxData(url, data);

            //エラーの場合
            if (result.match(/エラー：/)) {
                alert(result);
                return false;
            }

            var retData = JSON.parse(result);
            var grpData1 = null;
            var grpData2 = null;
            if (retData != null) {
                grpData1 = retData["group_table1"]
                grpData2 = retData["group_table2"]

                $.pageInitDetail(grpData1, grpData2);
                $.pageDisplayDetail(groupNo, checkNum);
            } else {

            }
        }

        $("#Mode").val(mode);
        $("#CheckNum").val(checkNum);
        $("#GroupNo").val(groupNo);
    });

    //─────────────────────────────────────
    //機能： グループ管理画面　初期化
    //引数： 
    //戻値： 
    //補足： 
    //─────────────────────────────────────
    $.pageInitMain = function () {

    }

    //─────────────────────────────────────
    //機能： グループ管理画面　取得データ編集
    //引数： 
    //戻値： 
    //補足： 
    //─────────────────────────────────────
    $.pageInit = function (grpData) {

    }

    //─────────────────────────────────────
    //機能： グループ管理画面　取得データ表示
    //引数： 
    //戻値： 
    //補足： 
    //─────────────────────────────────────
    $.pageDisplay = function () {


    }

    //*****************************リスト画面・詳細画面　切替表示*****************
    //─────────────────────────────────────
    //機能： グループ管理・リスト　初期表示
    //引数： 
    //戻値： 
    //補足： 
    //─────────────────────────────────────
    $.pageInitSwitch = function (mode) {

        if (mode == "list") {
            $("#group_detail_area").children().remove();
        }
        if (mode == "detail") {
            $("#group_list_area").children().remove();
        }
    }

   //*****************************リスト　初期***********************************
   //─────────────────────────────────────
    //機能： グループ管理・リスト　初期表示
    //引数： 
    //戻値： 
    //補足： 
    //─────────────────────────────────────
    $.pageInitDisplay = function () {

        $("#group_result_table").children().remove();

    }

    //*****************************詳細　見積追加***********************************
    //20200317 ADD
    //─────────────────────────────────────
    //機能： グループ管理・詳細・見積追加 初期化
    //引数： 
    //戻値： 
    //補足： 
    //─────────────────────────────────────
    $.pageInitMainDetailNew = function () {
                                //results[0]="T"->廃止
        CheckNum = "";          //results[1]->results[0]
        SalesPersonName = "";   //results[2]->results[1]
        Title = "";             //results[3]->results[2]
        CustomerCode = "";      //results[4]->results[3]
        CustomerName = "";      //results[5]->results[4]
    }

    //20200317 ADD
    //─────────────────────────────────────
    //機能： グループ管理・詳細・見積追加 データ編集
    //引数： 
    //戻値： 
    //補足： 
    //─────────────────────────────────────
    $.pageInitDetailNew = function (grpData) {
        // 変数初期化
        $.pageInitMainDetailNew();

        if (Object.keys(grpData).length > 0) {
            CheckNum = $.trim(grpData[0]["CheckNum"])
            SalesPersonName = $.trim(grpData[0]["SalesPersonName"])
            Title = $.trim(grpData[0]["Title"])
            CustomerCode = $.trim(grpData[0]["CustomerCode"])
            CustomerName = $.trim(grpData[0]["CustomerName"])
        }
    }

    //20200317 ADD
    //─────────────────────────────────────
    //機能： グループ管理・詳細・見積追加 データ表示
    //引数： 
    //戻値： 
    //補足： 
    //─────────────────────────────────────
    $.pageDisplayDetailNew = function () {

        // DOM操作
        group_table = document.getElementById("group_table");
        group_table_th = document.getElementById("group_table_th");

        // 結合を増やす
        document.getElementById("group_table_th").rowSpan = group_table_th.rowSpan + 1;

        // 行を増やす
        rows = group_table.insertRow(-1);
        cell1 = rows.insertCell(-1);
        cell2 = rows.insertCell(-1);
        cell3 = rows.insertCell(-1);

        rows.setAttribute('id', 'LN_' + CheckNum);

        //innerHTMLはidに対して
        cell1.innerHTML = CheckNum + '<br /><span class="leader_flag no_disp" id="LF_' + CheckNum + '">L </span>' + SalesPersonName;
        cell2.innerHTML = Title + '<br />' + CustomerCode + '：' + CustomerName;

        cell3.setAttribute('id', 'DL_' + CheckNum);
        cell3.innerHTML = '<input type="button" class="btn3" id="BN_' + CheckNum + '" value="ﾘｰﾀﾞｰ" onclick="estimateSystemGroupWindowDetailLeader(\'' + CheckNum + '\');" /> '
            + '< input type = "button" class="btn3" value = "削 除" onclick="estimateSystemGroupWindowDetailDelete(\'' + CheckNum + '\');" /> ';

        // 結果の値に追加
        if (document.getElementById("CheckNumList").value != "") {
            document.getElementById("CheckNumList").value = document.getElementById("CheckNumList").value + "," + CheckNum;
        } else {
            document.getElementById("CheckNumList").value = CheckNum;
        }

        // グループ名が空の場合は件名を自動挿入
        if (document.getElementById("rGroupName").value == "") {
            document.getElementById("rGroupName").value = Title;
        }
    }

    //*****************************リスト　検索***********************************
    //20200324 ADD
    //─────────────────────────────────────
    //機能： グループ管理・リスト・検索 初期化
    //引数： 
    //戻値： 
    //補足： 
    //─────────────────────────────────────
    $.pageInitMainSearch = function () {
        NowDispMax = MaxDispLine;

        GroupNo = {};
        rGroupName = {};
        SalesPersonName = {};

        for (trCnt = 0; trCnt < NowDispMax; trCnt++) {
            GroupNo[trCnt] = "";
            rGroupName[trCnt] = "";
            SalesPersonName[trCnt] = "";
        }
    }

    //20200324 ADD
    //─────────────────────────────────────
    //機能： グループ管理・リスト・検索 データ編集
    //引数： 
    //戻値： 
    //補足： 
    //─────────────────────────────────────
    $.pageInitSearch = function (grpData) {
        // 変数初期化
        $.pageInitMainSearch();

        //最大表示件数
        if (grpData == null) {
            NowDispMax = 0;
        } else if (Object.keys(grpData).length < MaxDispLine) {
            NowDispMax = Object.keys(grpData).length;
        } else {
            NowDispMax = MaxDispLine;
        }

        //検索結果
        if (NowDispMax > 0) {
            for (trCnt = 0; trCnt < NowDispMax; trCnt++) {
                GroupNo[trCnt] = $.trim(grpData[trCnt]["GroupNo"]);
                rGroupName[trCnt] = $.trim(grpData[trCnt]["rGroupName"]);
                SalesPersonName[trCnt] = $.trim(grpData[trCnt]["SalesPersonName"]);
            }
        }
    }

    //20200324 ADD
    //─────────────────────────────────────
    //機能： グループ管理・リスト・検索 データ表示
    //引数： 
    //戻値： 
    //補足： 
    //─────────────────────────────────────
    $.pageDisplaySearch = function () {

        $("#group_result_table").children().remove();

        var table_html = "";

        table_html += '<table class="group_result_table">';
        table_html += '  <tr>';
        table_html += '      <th style="width: 100px">グループ番号</th>';
        table_html += '      <th>グループ名</th>';
        table_html += '      <th style="width: 100px">案件リーダー</th>';
        table_html += '      <th style="width: 100px">詳細</th>';
        table_html += '  </tr>';

        // グループ一覧を表示
        if (NowDispMax > 0) {
            //<%--●データありの場合--%>

            //TODO:データをセットする
            for (trCnt = 1; trCnt <= NowDispMax; trCnt++) {
                table_html += '  <tr>';
                table_html += '      <td>' + GroupNo[trCnt - 1] + '</td>';
                table_html += '      <td>' + rGroupName[trCnt - 1] + '</td>';
                table_html += '      <td>' + SalesPersonName[trCnt - 1] + '</td>';
                table_html += '      <td><input type="button" class="btn1" value="詳 細" onclick="estimateSystemGroupWindowDetail(\' ' + GroupNo[trCnt - 1] + ' \');" /></td>';
                table_html += '  </tr>';
            }
        } else {
            //<%--●データなしの場合--%>
            table_html += '   <tr>';
            table_html += '      <td colspan="4" class="td_nodata">グループが見つかりません。</td>';
            table_html += '  </tr>';
        }

        table_html += '</table>';
        $("#group_result_table").append(table_html);
    }

    //*****************************詳細***********************************
    //─────────────────────────────────────
    //機能： グループ管理・詳細 初期化
    //引数： 
    //戻値： 
    //補足： 
    //─────────────────────────────────────
    $.pageInitMainDetail = function () {
        NowDispMax = MaxDispLine;

        GroupNoArr = {};
        rGroupNameArr = {};
        LeaderNameArr = {};
        rGroupCycleArr = {};

        GroupNoArr[0] = "";
        rGroupNameArr[0] = "";
        LeaderNameArr[0] = "";
        rGroupCycleArr[0] = "";

        CheckNumArr = {};
        SalesPersonNameArr = {};
        LeaderFlagArr = {};
        TitleArr = {};
        CustomerCodeArr = {};
        CustomerNameArr = {};

        for (trCnt = 0; trCnt < NowDispMax; trCnt++) {
            CheckNumArr[trCnt] = "";
            SalesPersonNameArr[trCnt] = "";
            LeaderFlagArr[trCnt] = "0";
            TitleArr[trCnt] = "";
            CustomerCodeArr[trCnt] = "";
            CustomerNameArr[trCnt] = "";

            EditFlagArr[trCnt] = "0";
            NewCheckNumFlagArr[trCnt] = "0";
        }
    }

    //─────────────────────────────────────
    //機能： グループ管理・詳細 データ編集
    //引数： 
    //戻値： 
    //補足： 
    //─────────────────────────────────────
    $.pageInitDetail = function (grpData1, grpData2) {
        // 変数初期化
        $.pageInitMainSearch();

        //最大表示件数
        if (grpData1 == null) {
            NowDispMax = 0;
        } else if (Object.keys(grpData1).length < MaxDispLine) {
            NowDispMax = Object.keys(grpData1).length;
        } else {
            NowDispMax = 0;
        }
        //検索結果
        if (NowDispMax > 0) {
            GroupNoArr[0] = $.trim(grpData1[0]["GroupNo"]);
            rGroupNameArr[0] = $.trim(grpData1[0]["rGroupName"]);
            LeaderNameArr[0] = $.trim(grpData1[0]["LeaderName"]);
            rGroupCycleArr[0] = $.trim(grpData1[0]["rGroupCycle"]);
        }

        //最大表示件数
        if (grpData2 == null) {
            NowDispMax = 0;
        } else if (Object.keys(grpData2).length < MaxDispLine) {
            NowDispMax = Object.keys(grpData2).length;
        } else {
            NowDispMax = MaxDispLine;
        }
        //検索結果
        if (NowDispMax > 0) {
            for (trCnt = 0; trCnt < NowDispMax; trCnt++) {
                CheckNumArr[trCnt] = $.trim(grpData2[trCnt]["CheckNum"]);
                SalesPersonNameArr[trCnt] = $.trim(grpData2[trCnt]["SalesPersonName"]);
                LeaderFlagArr[trCnt] = $.trim(grpData2[trCnt]["LeaderFlag"]);
                TitleArr[trCnt] = $.trim(grpData2[trCnt]["Title"]);
                CustomerCodeArr[trCnt] = $.trim(grpData2[trCnt]["CustomerCode"]);
                CustomerNameArr[trCnt] = $.trim(grpData2[trCnt]["CustomerName"]);

                EditFlagArr[trCnt] = $.trim(grpData2[trCnt]["EditFlag"]);                  //新規作成
                NewCheckNumFlagArr[trCnt] = $.trim(grpData2[trCnt]["NewCheckNumFlag"]);    //紐づけの有無
            }
        }
    }

    //─────────────────────────────────────
    //機能： グループ管理・詳細 データ表示
    //引数： 
    //戻値： 
    //補足： 
    //─────────────────────────────────────
    $.pageDisplayDetail = function (groupNo, checkNum) {

        $("#group_detail_area").children().remove();

        var count = NowDispMax + 1;
        var table_html = "";

        table_html += '<p class="new_group">';
        table_html += '  <input type="button" value="一覧へ戻る" id="BtnBackToList" onclick="estimateSystemGroupWindowBack();" />';
        table_html += '</p>';
        table_html += '<p class="search_ttl">グループ情報</p>';
        table_html += '<table class="group_table" id="group_table">';
        table_html += '  <tr>';
        table_html += '    <th style="width: 100px">グループ番号</th>';
        table_html += '    <td colspan="3">';
        table_html += '      <input type="text" class="box1" name="rGroupNo" id="rGroupNo" value="' + GroupNoArr[0] + '" maxlength="11" readonly />';
        table_html += '    </td>';
        table_html += '  </tr>';
        table_html += '  <tr>';
        table_html += '    <th>グループ名</th>';
        table_html += '    <td colspan="3">';
        if (EditFlagArr[0] == "0") {
            table_html += '      <input type="text" class="box3" name="rGroupName" id="rGroupName" value="' + rGroupNameArr[0] + '" maxlength="100" readonly />';
        } else {
            table_html += '      <input type="text" class="box3" name="rGroupName" id="rGroupName" value="' + rGroupNameArr[0] + '" maxlength="100" />';
        }
        table_html += '    </td>';
        table_html += '  </tr>';
        table_html += '  <tr>';
        table_html += '    <th>案件リーダー</th>';
        table_html += '    <td colspan="3">';
        table_html += '      <input type="text" class="box1" name="rGroupLeader" id="rGroupLeader" value="' + LeaderNameArr[0] + '" maxlength="10" readonly />';
        table_html += '    </td>';
        table_html += '  </tr>';
        table_html += '  <tr>';
        table_html += '    <th>サイクル</th>';
        table_html += '    <td colspan="3">';
        if (EditFlagArr[0] == "0") {
            table_html += '      <input type="text" class="box4" name="rGroupCycle" id="rGroupCycle" value="' + rGroupCycleArr[0] + '" maxlength="2" readonly />';
        } else {
            table_html += '      <input type="text" class="box4" name="rGroupCycle" id="rGroupCycle" value="' + rGroupCycleArr[0] + '" maxlength="2" />';
        }
        table_html += '    </td>';
        table_html += '  <tr>';
        table_html += '    <th rowspan="' + count + '" id="group_table_th">所属見積<br>';
        table_html += '      <input type="button" class="btn1" value="見積追加" onclick="estimateSystemGroupWindowDetailNew();" /></th>';
        table_html += '    <th style="width: 110px">見積番号/営業</th>';
        table_html += '    <th>見積件名/得意先CD・名</th>';
        table_html += '    <th style="width: 120px"></th>';
        table_html += '  </tr>';

        var CheckNumListValue = "";
        var LeaderFlagValue = "";

        // グループ一覧を表示
        if (NowDispMax > 0) {
            //<%--●データありの場合--%>
            for (trCnt = 1; trCnt <= NowDispMax; trCnt++) {
                //新規作成の場合
                if (EditFlagArr[trCnt-1] == "1") {
                    //見積番号がある場合
                    if (NewCheckNumFlagArr[trCnt - 1] == "1") {
                        table_html += '  <tr class="tr_new">';
                        //table_html += '    <td><a href="../../Detail.aspx?cno=' + CheckNumArr[trCnt - 1] + '" target="_blank">' + CheckNumArr[trCnt - 1] + '</a><br>' + SalesPersonNameArr[trCnt - 1] + '</td>';
                        table_html += '    <td><a href="javascript: estimateSystemGroupWindowClose(\'' + CheckNumArr[trCnt - 1] + '\');">' + CheckNumArr[trCnt - 1] + '</a><br>' + SalesPersonNameArr[trCnt - 1] + '</td>';

                        table_html += '    <td>' + TitleArr[trCnt - 1] + '<br>' + CustomerCodeArr[trCnt - 1] + '：' + CustomerNameArr[trCnt - 1] + '</td>';
                        table_html += '    <td>';
                        table_html += '      <input type="button" class="btn3" id="new_add_btn" value="追 加" onclick="estimateSystemGroupWindowDetailAdd(\'' + CheckNumArr[trCnt - 1] + '\');" />';
                        table_html += '    </td>';
                        table_html += '  </tr>';
                        //見積番号がない場合
                    } else {
                        table_html += '  <tr class="tr_new">';
                        table_html += '    <td>' + CheckNumArr[trCnt - 1] + '</td>';
                        table_html += '    <td>' + TitleArr[trCnt - 1] + '</td>';  // 不明データ
                        table_html += '    <td>aaa</td>';
                        table_html += '  </tr>';
                    }
                    //新規作成でない場合
                } else {
                    //リーダの場合
                    if (LeaderFlagArr[trCnt - 1] == "1") {
                        table_html += '  <tr id="LN_' + CheckNumArr[trCnt - 1] + '" class="tr_leader">';
                        //table_html += '    <td><a href="../../Detail.aspx?cno=' + CheckNumArr[trCnt - 1] + '" target="_blank">' + CheckNumArr[trCnt - 1] + '</a><br>';
                        table_html += '    <td><a href="javascript: estimateSystemGroupWindowClose(\'' + CheckNumArr[trCnt - 1] + '\');">' + CheckNumArr[trCnt - 1] + '</a><br>';

                        table_html += '      <span class="leader_flag" id="LF_' + CheckNumArr[trCnt - 1] + '">L </span>' + SalesPersonNameArr[trCnt - 1] + '</td>';
                        table_html += '    <td>' + TitleArr[trCnt - 1] + '<br>' + CustomerCodeArr[trCnt - 1] + '：' + CustomerNameArr[trCnt - 1] + '</td>';
                        table_html += '    <td id="DL_' + CheckNumArr[trCnt - 1] + '">';
                        table_html += '      <input type="button" class="btn3" id="BN_' + CheckNumArr[trCnt - 1] + '" value="ﾘｰﾀﾞｰ" onclick="estimateSystemGroupWindowDetailLeader(\'' + CheckNumArr[trCnt - 1] + '\');" disabled="disabled" />';
                        table_html += '      <input type="button" class="btn3" value="削 除" onclick="estimateSystemGroupWindowDetailDelete(\'' + CheckNumArr[trCnt - 1] + '\');" />';
                        table_html += '    </td>';
                        table_html += '  </tr>';

                        LeaderFlagValue = CheckNumArr[trCnt - 1];

                    } else {
                        //リーダでない場合
                        table_html += '  <tr id="LN_' + CheckNumArr[trCnt - 1] + '">';
                        //table_html += '    <td><a href="../../Detail.aspx?cno=' + CheckNumArr[trCnt - 1] + '" target="_blank">' + CheckNumArr[trCnt - 1] + '</a><br>';
                        table_html += '    <td><a href="javascript: estimateSystemGroupWindowClose(\'' + CheckNumArr[trCnt - 1] + '\');">' + CheckNumArr[trCnt - 1] + '</a><br>';

                        table_html += '      <span class="leader_flag no_disp" id="LF_' + CheckNumArr[trCnt - 1] + '">L </span>' + SalesPersonNameArr[trCnt - 1] + '</td>';
                        table_html += '    <td>' + TitleArr[trCnt - 1] + '<br>' + CustomerCodeArr[trCnt - 1] + '：' + CustomerNameArr[trCnt - 1] + '</td>';
                        table_html += '    <td id="DL_' + CheckNumArr[trCnt - 1] + '">';
                        table_html += '      <input type="button" class="btn3" id="BN_' + CheckNumArr[trCnt - 1] + '" value="ﾘｰﾀﾞｰ" onclick="estimateSystemGroupWindowDetailLeader(\'' + CheckNumArr[trCnt - 1] + '\');" />';
                        table_html += '      <input type="button" class="btn3" value="削 除" onclick="estimateSystemGroupWindowDetailDelete(\'' + CheckNumArr[trCnt - 1] + '\');" />';
                        table_html += '    </td>';
                        table_html += '  </tr>';
                    }

                    if (CheckNumListValue != "") {
                        CheckNumListValue = CheckNumListValue + "," ;
                    }                  
                    CheckNumListValue = CheckNumListValue + CheckNumArr[trCnt - 1];

                }
            }//for

            table_html += '</table>';

            table_html += '<p class="group_save">';
            table_html += '<input type="button" class="btn2" value="保存する" onclick="estimateSystemGroupWindowDetailSave();" />';
            table_html += '</p>';
            table_html += '<p class="group_notice">※すべての操作は保存しないと反映されません。</p>';


            table_html += '<input type="hidden" name="CheckNumList" id="CheckNumList" value="' + CheckNumListValue + '" />';
            table_html += '<input type="hidden" name="LeaderCheckNum" id="LeaderCheckNum" value="' + LeaderFlagValue + '" />';

        } else {
            //<%--●データなしの場合--%>
            //TODO:データをセットする

        }

        $("#group_detail_area").append(table_html);
    }


});





// ***********************************************
// イベント
// ***********************************************

// グループ管理・グループリスト 検索
//20200323 EDIT
//function estimateSystemGroupWindowSubmit(mode) {
//    document.getElementById("SubmitMode").value = mode;
//    document.ESGroupWindow.submit();
//}
function estimateSystemGroupWindowSubmit() {
    //var mode = "group_search";
    //document.getElementById("SubmitMode").value = mode;
    //document.getElementById("Mode").value = "list";
    //location.href = "./PopGroup.aspx?mode=" + mode;

    //SubmitMode = mode;
    //Mode = "list;"
    //var gno = $.trim($("#GroupNo").val());
    //var cno = $.trim($("#CheckNum").val());
    //document.ESGroupWindow.action = "./PopGroup.aspx?mode=" + mode;
    //document.ESGroupWindow.submit();        //グループ管理 一覧画面へ

    //event.preventDefault();

    var sGroupNo = $.trim($("#sGroupNo").val());
    var sGroupName = $.trim($("#sGroupName").val());
    var sProductCode = $.trim($("#sProductCode").val());
    var sSalesPerson = $.trim($("#sSalesPerson").val());

    //alert("estimateSystemGroupWindowSubmit-$(#sGroupNo).val()=" + $("#sGroupNo").val());

    //TODO:20200327 test:ok
    //parent.$.setCookie("sGroupNo", $.trim($("#sGroupNo").val()));
    //alert("getCookie(sGroupNo)=" + parent.$.getCookie("sGroupNo"));

    //*****************************************************
    //本番
    var url = "./Pages/PopGroup/PopGroup.aspx/GetJsonGroupData";

    //TODO:日本語はUrlEncode必要！！！h ttp://surferonwww.info/BlogEngine/post/2011/11/07/Encoding-of-URL-directly-written-in-address-bar-of-browser.aspx
    var data = JSON.stringify({ sGroupNo: sGroupNo, sGroupName: sGroupName, sProductCode: sProductCode, sSalesPerson: sSalesPerson });

    //TODO:日本語はUrlEncode必要***************sample***************
    //data = $.param(data);   //jq
    //data = encodeURI(data); //js
    //data = decodeURIComponent($.param(data));

    var result = parent.$.getAjaxData(url, data);   //jQuery.Ajax

    //エラーの場合
    if (result.match(/エラー：/)) {
        alert(result);
        return false;
    }

    var grpData = JSON.parse(result);
    //test
    //if (grpData == null) {
    //    alert("該当データが見つかりませんでした。");
    //    return false;
    //} 
    //if (grpData === "" || grpData === undefined) {
    //    alert("test:grpData === 空 || grpData === undefined");
    //    return false;
    //}
    //if (grpData.length === undefined) {
    //    alert("test:grpData.length === undefined");
    //    return false;
    //}
    //if (grpData.length == 0) {
    //    alert("test:grpData.length == 0");
    //    return false;
    //}
    //if (Object.keys(grpData).length == 0) {
    //    alert("test:Object.keys(grpData).length == 0");
    //    return false;
    //}

    if (grpData == null) {
        $.pageInitSearch(null);
    } else {
        $.pageInitSearch(grpData["group_result_table"]);
    }
    $.pageDisplaySearch();  //0件の場合もこのメソッドで画面表示する
    return false;
}

// グループ管理・グループ詳細 詳細・新規作成 20200317 EDIT
function estimateSystemGroupWindowDetail(gno) {
    //document.getElementById("GroupNo").value = gno;
	//document.ESGroupWindow.submit();

    //20200325 EDIT modeを追加
    var mode = "detail";
    //location.href = "./PopGroup.aspx?mode=" + mode + "&gno=" + gno;   //新規作成の場合、gno='新規作成'

    //20200323 EDIT mode, cnoを追加
    //TODO:詳細画面のグループ管理ボタン押下時、見積番号を持ち回る
    var cno = $.trim($("#CheckNum").val());
    
    location.href = "./PopGroup.aspx?mode=" + mode + "&gno=" + gno + "&cno=" + cno;   //新規作成の場合、gno='新規作成'        //グループ管理 詳細画面へ
}

// 
function estimateSystemGroupWindowClose(cno) {
    parent.$.closeDialog();

    parent.location.href = "../../Detail.aspx?cno=" + cno;
}








// グループ管理・グループ詳細 一覧へ戻る 20200318 ADD
function estimateSystemGroupWindowBack() {
    //var mode = "group_back";    //session取得
    //document.getElementById("SubmitMode").value = mode;
    //document.getElementById("Mode").value = "list";
    //TODO:必要なパラメータをセットする
    //document.ESGroupWindow.action = "./PopGroup.aspx?mode=" + mode;
    //document.ESGroupWindow.submit();        //グループ管理 一覧画面へ

    //20200325 EDIT modeを追加
    var mode = "list";
    location.href = "./PopGroup.aspx?mode=" + mode + "&gno=";

    //20200323 EDIT cnoを追加
    //TODO:詳細画面のグループ管理ボタン押下時、見積番号を持ち回る場合 20200325<-保留
    //var cno = /document.getElementById("CheckNum").value;
    //location.href = "./PopGroup.aspx?mode=" + mode + "&gno=" + "&cno=" + cno;
}

// グループ管理・グループ詳細・追加ボタン
function estimateSystemGroupWindowDetailAdd(CNo) {
	// 保存用に見積番号の受け渡し
	document.getElementById("NewAddChk").value = CNo;
	document.getElementById("new_add_btn").style.display = "none";

	if (document.getElementById("CheckNumList").value != "") {
		document.getElementById("CheckNumList").value = document.getElementById("CheckNumList").value + "," + CNo;
	} else {
		document.getElementById("CheckNumList").value = CNo;
	}
}

// グループ管理・グループ詳細・保存ボタン
function estimateSystemGroupWindowDetailSave() {
    //if (document.getElementById("CheckNumList").value == "") {
    //	if (!confirm("紐付いた見積が無い為、削除されます。\nよろしいですか？")) {
    //		return false;
    //	}
    //}

    //if (document.getElementById("rGroupName").value == "") {
    //	alert("グループ名を設定してください。");
    //	return false;
    //}

    //20200324 EDIT
    //document.getElementById("SubmitMode").value = "save";
    //document.ESGroupWindow.submit();

    var rGroupNo = $.trim($("#rGroupNo").val());
    var rGroupName = $.trim($("#rGroupName").val());
    var rGroupCycle = $.trim($("#rGroupCycle").val());
    var LeaderCheckNum = $.trim($("#LeaderCheckNum").val());
    var CheckNumList = $.trim($("#CheckNumList").val());

    //*****************************************************
    //本番
    var url = "./Pages/PopGroup/PopGroup.aspx/SaveJsonGroupData";

    //TODO:日本語はUrlEncode必要！！！h ttp://surferonwww.info/BlogEngine/post/2011/11/07/Encoding-of-URL-directly-written-in-address-bar-of-browser.aspx
    var data = JSON.stringify({ GroupNo: rGroupNo, GroupName: rGroupName, GroupCycle: rGroupCycle, LeaderCheckNum: LeaderCheckNum, CheckNumList: CheckNumList });
    var result = parent.$.getAjaxData(url, data);

    //エラーの場合
    //Common.js ajaxがreturn ""設定の場合
    if (result.match(/エラー：/)) {
        alert(result);
        return false;
    }
    var message = JSON.parse(result);
    //if (message == null) {
    //    alert("該当データが見つかりませんでした。");
    //    return false;
    //}
    //if (message.length == 0) {
    //    alert("該当データが見つかりませんでした。");
    //    return false;
    //}    
    //if (Object.keys(message).length == 0) {
    //    alert("該当データが見つかりませんでした。");
    //    return false;
    //}

    //結果表示
    alert(message["aaa"][0]["message"]);   //TODO:仮テーブル名

    //Common.js ajaxがreturn null設定の場合
    //if (result == "null") {
    //    alert("該当データが見つかりませんでした。");
    //} else {
    //    alert("保存しました。");
    //}
    return false;
}

// グループ管理・グループ詳細・リーダー選択
function estimateSystemGroupWindowDetailLeader(cno) {
	var now_cno = document.getElementById("LeaderCheckNum").value;

	if (document.getElementById("LF_" + now_cno)) {
		document.getElementById("LF_" + now_cno).style.display = "none";
        document.getElementById("BN_" + now_cno).disabled = false;
        //$('button').prop('disabled', true);

		if (document.getElementById("LN_" + now_cno).className == "tr_leader") {
			document.getElementById("LN_" + now_cno).className = "";
		}
	}

	document.getElementById("LF_" + cno).style.display = "inline";
	document.getElementById("BN_" + cno).disabled = true;
	document.getElementById("LN_" + cno).className = "tr_leader";
	document.getElementById("LeaderCheckNum").value = cno;
}

// グループ管理・グループ詳細・削除
function estimateSystemGroupWindowDetailDelete(cno) {
	document.getElementById("LN_" + cno).className = "tr_delete";
	document.getElementById("DL_" + cno).innerHTML = "削除";

	if (document.getElementById("LeaderCheckNum").value == cno) {
		document.getElementById("LeaderCheckNum").value = "";
		document.getElementById("LF_" + cno).style.display = "none";
	}

	var CList = document.getElementById("CheckNumList").value;
	if (CList.indexOf("," + cno) !== -1) {
		document.getElementById("CheckNumList").value = CList.replace("," + cno,"");
	} else if (CList.indexOf(cno + ",") !== -1) {
		document.getElementById("CheckNumList").value = CList.replace(cno + ",","");
	} else if (CList.indexOf(cno) !== -1) {
		document.getElementById("CheckNumList").value = CList.replace(cno,"");
	}
}

// グループ管理・グループ詳細・見積追加 20200317 EDIT
function estimateSystemGroupWindowDetailNew() {
    var cno = window.prompt("追加する見積番号を入力してください。", "");

    if (cno != "" && cno != null) {
        var CList = document.getElementById("CheckNumList").value;
        //CNo + "," + CNo
        if (CList.indexOf(cno) !== -1) {
            alert("すでに追加されている見積番号です。");
            return false;   //ADD
        } else {
            // 見積番号の内容を取得する
            //参考：https://developer.mozilla.org/ja/docs/Learn/JavaScript/Objects/JSON

            //*****************************************************
            //test1
            //var url = "./Pages/PopGroup/PopGroup.aspx/GetJsonTestData";

            //var data = JSON.stringify({ test: 'TEST' });
            //var result = $.getAjaxData(url, data);
            //var esData = JSON.parse(result);
            ////if (result.indexOf('エラー：') != -1) {
            //if (esData.match(/エラー：/)) {
            //    alert(esData);
            //    return false;
            //}
            //alert(esData["DT1"][0]["A"] + ':' + esData["DT1"][0]["B"] + ':' + esData["DT1"][0]["C"]);
            //alert(esData["DT2"][0]["A"]);
            //*****************************************************
            //本番
            var url = "./Pages/PopGroup/PopGroup.aspx/GetJsonGroupDetailNew";

            //TODO:日本語はUrlEncode必要！！！h ttp://surferonwww.info/BlogEngine/post/2011/11/07/Encoding-of-URL-directly-written-in-address-bar-of-browser.aspx
            var data = JSON.stringify({ cno: cno });

            var result = parent.$.getAjaxData(url, data);

            //エラーの場合
            if (result.match(/エラー：/)) {
                alert(result);
                return false;
            }

            //TODO:
            var grpData = JSON.parse(result);
            if (grpData == null) {
                alert("該当データが見つかりません。");
                return false;
            }
            //if (grpData == null) {
            //    $.pageInitDetailNew(null);
            //} else {
            $.pageInitDetailNew(grpData["xxx"]);  //TODO:仮テーブル名
            //}
            $.pageDisplayDetailNew();
            return false;
        }
    }
}

//// グループ管理・グループ詳細・見積追加 20200317 EDIT
//function estimateSystemGroupWindowDetailNew() {
//    cno = window.prompt("追加する見積番号を入力してください。", "");

//    if (cno != "" && cno != null) {
//        CList = document.getElementById("CheckNumList").value;
//        if (CList.indexOf(cno) !== -1) {
//            alert("すでに追加されている見積番号です。");
//        } else {
//            // 見積番号の内容を取得する
//            var url = "ES_GroupEstimate.asp?CNO=" + cno;
//            http.open("GET", url, false);
//            http.onreadystatechange = hhrAdminGroupWindowDetailNew;
//            Process_flg = true;
//            http.send(null);
//        }
//    }
//}

//// 結果代入用 ・・・ 見積追加 20200317 EDIT
//function hhrAdminGroupWindowDetailNew() {
//    if (http.readyState == 4) {
//        if (http.status == 200) {
//            if (http.responseText.indexOf('invalid') == -1) {
//                results = http.responseText.split("@");

//                if (results[0] == "T") {
//                    // DOM操作
//                    group_table = document.getElementById("group_table");
//                    group_table_th = document.getElementById("group_table_th");

//                    // 結合を増やす
//                    document.getElementById("group_table_th").rowSpan = group_table_th.rowSpan + 1;

//                    // 行を増やす
//                    rows = group_table.insertRow(-1);
//                    cell1 = rows.insertCell(-1);
//                    cell2 = rows.insertCell(-1);
//                    cell3 = rows.insertCell(-1);

//                    rows.setAttribute('id', 'LN_' + results[1]);

//                    cell1.innerHTML = results[1] + '<br /><span class="leader_flag no_disp" id="LF_' + results[1] + '">L </span>' + results[2];
//                    cell2.innerHTML = results[3] + '<br />' + results[4] + '：' + results[5];

//                    cell3.setAttribute('id', 'DL_' + results[1]);
//                    cell3.innerHTML = '<input type="button" class="btn3" id="BN_' + results[1] + '" value="ﾘｰﾀﾞｰ" onclick="estimateSystemGroupWindowDetailLeader(\'' + results[1] + '\');" /> <input type="button" class="btn3" value="削 除" onclick="estimateSystemGroupWindowDetailDelete(\'' + results[1] + '\');" />';

//                    // 結果の値に追加
//                    if (document.getElementById("CheckNumList").value != "") {
//                        document.getElementById("CheckNumList").value = document.getElementById("CheckNumList").value + "," + results[1];
//                    } else {
//                        document.getElementById("CheckNumList").value = results[1];
//                    }

//                    // グループ名が空の場合は件名を自動挿入
//                    if (document.getElementById("rGroupName").value == "") {
//                        document.getElementById("rGroupName").value = results[3];
//                    }
//                } else {
//                    alert("該当の見積が見つかりません。");
//                }

//                Process_flg = false;
//            }
//        }
//    }
//}

//20200318 ADD -> EDIT:changed to estimateSystemGroupWindowBack
// グループ管理・グループ詳細 一覧へ戻る
//function estimateSystemGroupWindowDetailBack() {
//    location.href = "./PopGroup.aspx?mode=list";   //グループ管理 一覧画面へ戻る
//}

//sample**************************************
//h ttps://www.sejuku.net/blog/42985
//$('form').submit(function (event) {
//    event.preventDefault(); //画面が必ず更新されるというブラウザの仕様をキャンセルするため

//    //post()の処理をここに記述する
//    $.post('https://httpbin.org/post', 'name=太郎')

//    .done(function (data) {

//        console.log(data.form);

//    })
//})