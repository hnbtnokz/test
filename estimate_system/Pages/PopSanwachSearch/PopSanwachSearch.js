$(function () {

    //閉じる
    $('#BtnClose').click(function () {
        parent.$.closeDialog();
    });




    //*****************************************************
    //var CheckNum;
    //var mode;

    const MaxDispLinePopSanwachSearch = 100;
    var NowDispMax;

    var LoginId = {};
    var UserName = {};
    var EmailAddress = {};



    //─────────────────────────────────────
    //機能： ログインID選択画面Load時イベント
    //引数： 
    //戻値： 
    //補足： 
    //─────────────────────────────────────
    $(document).ready(function () {

        //*****************************************************
        //test1
        //var url = "./PopGroup.aspx/GetJsonTestData";

        //var data = JSON.stringify({ test: 'TEST' });
        //var result = $.getAjaxData(url, data);
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

        //TODO:パラメータ取得
        //AC:0埋め10桁の文字列
        var vAccountCode = "";
        //LI
        var vLoginId = "";

        // GET変数が存在する場合
        if (querystr) {
            if (!querystr.match(/&/)) {
                //querystrに含む場合の処理
                if (querystr.split('=')[0].match(/AC/)) {
                    vAccountCode = querystr.split('=')[1];
                }
                //if (querystr.split('=')[0].match(/test/) && querystr.split('=')[1].match(/on/)) {
                //    TestMode = true;
                //} else if (querystr.split('=')[0].match(/test/) && querystr.split('=')[1].match(/off/)) {
                //    TestMode = false;
                //}
                if (querystr.split('=')[0].match(/LI/)) {
                    vLoginId = querystr.split('=')[1];
                }
            } else {
                // ?を取り除くため、1から始める。keyと値に分割。
                array = querystr.slice(1).split('&');
                qsarr = new Array();
                // GET変数を順に処理
                $.each(array,
                    function (index, elem) {
                        if (elem.split('=')[0].match(/AC/)) {
                            vAccountCode = elem.split('=')[1];
                        }
                        //if (elem.split('=')[0].match(/test/) && elem.split('=')[1].match(/on/)) {
                        //    TestMode = true;
                        //} else if (elem.split('=')[0].match(/test/) && elem.split('=')[1].match(/off/)) {
                        //    TestMode = false;
                        //}
                        if (elem.split('=')[0].match(/LI/)) {
                            vLoginId = elem.split('=')[1];
                        }
                    }
                );
            }
        }

        //数字可能文字の場合、0埋め10桁に加工
        if (vAccountCode != "" && isNumber(vAccountCode)) {
            vAccountCode = ("0000000000" + vAccountCode).slice(-10);
        }
        //alert("vAccountCode=" + vAccountCode);

        var url = "./Pages/PopSanwachSearch/PopSanwachSearch.aspx/GetJsonSanwaChData";
        var data = JSON.stringify({ AccountCode: vAccountCode, LoginId: vLoginId });
        var result = parent.$.getAjaxData(url, data);

        //エラーの場合
        if (result.match(/エラー：/)) {
            alert(result);
            return false;
        }

        var lidData = JSON.parse(result);

        if (lidData == null) {
            $.pageInit(null);
        } else {
            $.pageInit(lidData["result_area"]);
        }
        //AccountCodeが無い場合、"アカウントがありません。"表示
        //LoginIdが検索結果にある場合、背景色を選択状態に表示
        $.pageDisplay(vLoginId);  //0件の場合もこのメソッドで画面表示する
        return false;
    });

    //─────────────────────────────────────
    //機能： ログインID選択画面　初期化
    //引数： 
    //戻値： 
    //補足： 
    //─────────────────────────────────────
    $.pageInitMain = function () {

        NowDispMax = MaxDispLinePopSanwachSearch;

        LoginId = {};
        UserName = {};
        EmailAddress = {};

        for (trCnt = 0; trCnt < MaxDispLinePopSanwachSearch; trCnt++) {
            LoginId[trCnt] = "";
            UserName[trCnt] = "";
            EmailAddress[trCnt] = "";
        }
    }

    //─────────────────────────────────────
    //機能： ログインID選択画面　検索結果データ編集
    //引数： 
    //戻値： 
    //補足： 
    //─────────────────────────────────────
    $.pageInit = function (lidData) {
        // 変数初期化
        $.pageInitMain();

        //最大表示件数
        if (lidData == null) {
            NowDispMax = 0;
        } else if (Object.keys(lidData).length < MaxDispLinePopSanwachSearch) {
            NowDispMax = Object.keys(lidData).length;
        } else {
            NowDispMax = MaxDispLinePopSanwachSearch;
        }

        //検索結果
        if (NowDispMax > 0) {
            for (trCnt = 0; trCnt < NowDispMax; trCnt++) {
                LoginId[trCnt] = $.trim(lidData[trCnt]["LoginId"]);
                UserName[trCnt] = $.trim(lidData[trCnt]["UserName"]);
                EmailAddress[trCnt] = $.trim(lidData[trCnt]["EmailAddress"]);
            }
        }
    }

    //─────────────────────────────────────
    //機能： ログインID選択画面　初期表示
    //引数： 
    //戻値： 
    //補足： 
    //─────────────────────────────────────
    $.pageDisplay = function (vLoginId) {

        $("#result_area").children().remove();

        var table_html = "";

        // 一覧を表示
        table_html += '<table class="table table-striped">';
        //データありの場合
        if (NowDispMax > 0) {
            for (trCnt = 1; trCnt <= NowDispMax; trCnt++) {
                if (vLoginId == LoginId[trCnt - 1]) {
                    table_html += '  <tr class="select">';
                } else {
                    table_html += '  <tr>';
                }

                table_html += '    <td style="width:70px">' + LoginId[trCnt - 1] + '</td>';
                table_html += '    <td style="width:140px" class="center">' + UserName[trCnt - 1] + '</td>';
                table_html += '    <td class="center"><a href="mailto:' + EmailAddress[trCnt - 1] + '">' + EmailAddress[trCnt - 1] + '</a></td>';
                table_html += '    <td style="width:70px"><input type="button" value="連 携" onclick="estimateSystemDetail3chIDSelect(\'' + LoginId[trCnt - 1] + '\');" /></td>';
                table_html += '  </tr>';
            }
            //データなしの場合
        } else {
            table_html += '  <p class="no_account">アカウントがありません。</p>';
        }
        table_html += '</table>';

        $("#result_area").append(table_html);

        ////TODO:連携中の行の場合、「連 携」ボタンをread onlyにすべきでは？

        ////TODO:「連携解除」ボタンの制御すべきでは？
        ////連携ありの場合
        //    document.getElementById("BtnClear").style.display = "inline";
        ////連携なしの場合
        //    document.getElementById("BtnClear").style.display = "none";
    }

});



// ***********************************************
// 
// ***********************************************
// 入力値が数値 (符号なし　小数 不可　0埋め可) であることをチェックする
function isNumber(val) {
    var regexp = new RegExp(/^\d*$/);
    return regexp.test(val);
}



// ***********************************************
// イベント
// ***********************************************
// 3chログインID連携のウィンドウ:解除 MOVE FROM estimate_system.js
function estimateSystemDetail3chIDClear() {
    //20200402 EDIT
	//window.opener.document.getElementById("SanwaChLoginID").value = "";
	//window.opener.document.getElementById("SCID").innerHTML = "連携なし";
	//window.close();
    
    parent.$("#SanwaChLoginID").val("");
    parent.$("#SCID").html("連携なし");
    parent.$.closeDialog();
}

// 3chログインID連携のウィンドウ:選択 MOVE FROM estimate_system.js
function estimateSystemDetail3chIDSelect(LoginId) {
    //20200402 EDIT
	//window.opener.document.getElementById("SanwaChLoginID").value = LoginId;
	//window.opener.document.getElementById("SCID").innerHTML = LoginId;
    //window.close();

    parent.$("#SanwaChLoginID").val(LoginId);
    parent.$("#SCID").html(LoginId);
    parent.$.closeDialog();
}
