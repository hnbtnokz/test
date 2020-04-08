$(function () {

    //閉じる
    $('#BtnClose').click(function () {
        parent.$.closeDialog();
    });




    //*****************************************************
    //var CheckNum;
    //var mode;

    var Code;
    var Name;
    var Index;
    var Tel;

    const MaxDispLinePopCustomerSearch = 1000;

    var NowDispMax;
    var NowCount;

    var KNA1_KUNNR = {};
    var ADRC_NAME1 = {};
    var EName = {};
    var AName = {};
    var ADRC_TEL_NUMBER = {};


    //─────────────────────────────────────
    //機能： 得意先検索画面Load時イベント
    //引数： 
    //戻値： 
    //補足： 
    //─────────────────────────────────────
    $(document).ready(function () {
        //test2
        //var querystr = window.location.search;
        // GET変数が存在する場合
        //if (querystr) {
        //    alert("PopCustomerSearch.js - querystr=" + querystr);
        //}
    });

//20200326 ADD
    //─────────────────────────────────────
    //機能： 得意先検索画面　初期化
    //引数： 
    //戻値： 
    //補足： 
    //─────────────────────────────────────
    $.pageInitMain = function () {
        Code = "";
        Name = "";
        Index = "";
        Tel = "";

        NowDispMax = MaxDispLinePopCustomerSearch;
        //20200330 ADD
        NowCount = 0;

        KNA1_KUNNR = {};
        ADRC_NAME1 = {};
        EName = {};
        AName = {};
        ADRC_TEL_NUMBER = {};

        for (trCnt = 0; trCnt < NowDispMax; trCnt++) {
            KNA1_KUNNR[trCnt] = "";
            ADRC_NAME1[trCnt] = "";
            EName[trCnt] = "";
            AName[trCnt] = "";
            ADRC_TEL_NUMBER[trCnt] = "";
        }
    }

//20200326 ADD
    //─────────────────────────────────────
    //機能： 得意先検索画面　検索結果データ編集
    //引数： 
    //戻値： 
    //補足： 
    //─────────────────────────────────────
    $.pageInit = function (cstData) {
        // 変数初期化
        $.pageInitMain();

        if (cstData == null) {
            NowDispMax = 0;
            NowCount = 0;
        //} else if (cstData.length < MaxDispLinePopCustomerSearch) {
        } else if (Object.keys(cstData).length < MaxDispLinePopCustomerSearch) {
            NowDispMax = Object.keys(cstData).length;
            NowCount = Object.keys(cstData).length;
        } else {
            //20200330 EDIT （注）他画面と異なる仕様
            //NowDispMax = MaxDispLinePopCustomerSearch;
            NowDispMax = 0;
            NowCount = Object.keys(cstData).length;
        }

        //検索結果
        if (NowDispMax > 0) {
            for (trCnt = 0; trCnt < NowDispMax; trCnt++) {
                KNA1_KUNNR[trCnt] = $.trim(cstData[trCnt]["KNA1_KUNNR"]);
                ADRC_NAME1[trCnt] = $.trim(cstData[trCnt]["ADRC_NAME1"]);
                EName[trCnt] = $.trim(cstData[trCnt]["EName"]);
                AName[trCnt] = $.trim(cstData[trCnt]["AName"]);
                ADRC_TEL_NUMBER[trCnt] = $.trim(cstData[trCnt]["ADRC_TEL_NUMBER"]);
            }
        }
    }

//20200326 ADD
    //─────────────────────────────────────
    //機能： 得意先検索画面　初期表示
    //引数： 
    //戻値： 
    //補足： 
    //─────────────────────────────────────
    $.pageDisplay = function () {

        $("#result_tbl").children().remove();

    }

//20200326 ADD
    //─────────────────────────────────────
    //機能： 得意先検索画面　検索結果データ表示
    //引数： 
    //戻値： 
    //補足： 
    //─────────────────────────────────────
    $.pageDisplaySearch = function () {

        $("#result_tbl").children().remove();

        var table_html = "";

        //データありの場合
        if (NowDispMax > 0) {
            table_html += '<table class="result_tbl">';
            table_html += '  <tr>';
            table_html += '      <th style="width: 90px">得意先CD</th>';
            table_html += '      <th>得意先略称</th>';
            table_html += '      <th style="width: 90px">営業</th>';
            table_html += '      <th style="width: 90px">ｱｼｽﾀﾝﾄ</th>';
            table_html += '      <th style="width: 110px">電話番号</th>';
            table_html += '      <th style="width: 80px"></th>';
            table_html += '  </tr>';

            //TODO:データをセットする
            for (trCnt = 1; trCnt <= NowDispMax; trCnt++) {
                table_html += '  <tr>';
                table_html += '      <td>' + KNA1_KUNNR[trCnt - 1] + '</td>';
                table_html += '      <td>' + ADRC_NAME1[trCnt - 1] + '</td>';
                table_html += '      <td>' + EName[trCnt - 1] + '</td>';
                table_html += '      <td>' + AName[trCnt - 1] + '</td>';
                table_html += '      <td>' + ADRC_TEL_NUMBER[trCnt - 1] + '</td>';
                table_html += '      <td><input type="button" value="選択" onclick="estimateSystemCustomerChoice(\'' + KNA1_KUNNR[trCnt - 1] + '\');" /></td>';
                table_html += '  </tr>';
            }
            table_html += '</table>';

            //データなしの場合
        } else {
            if (NowCount == 0) {
                table_html += '<p class="nodata">検索結果なし</p>';
            } else {
                table_html += '<p class="nodata">検索結果が1000件以上です。\n検索条件で絞ってください。</p>';
            }
        }
        $("#result_tbl").append(table_html);
    }

});





// ***********************************************
// イベント
// ***********************************************

// 得意先検索画面　選択ボタン
function estimateSystemCustomerChoice(ccode) {

    //子画面から親画面へ値を渡す
    //window.opener.document.getElementById("CustomerCode").value = ccode;
    //共通:詳細画面(検索アイコン) & 得意先検索画(選択)の顧客情報検索ajax
    //window.opener.estimateSystemCustomerSearch(); 

    document.getElementById("CustomerCode").value = ccode;
    estimateSystemCustomerSearch(); 

    //20200330 EDIT
    //window.close();
    parent.$.closeDialog();
}

//// 詳細画面(検索アイコン) & 得意先検索画(選択)の顧客情報検索ajax OK @estimate_system.js
//function estimateSystemCustomerSearch() 

//// 結果代入用 OK @estimate_system.js
//function handleHttpResponseAdminESCustSearch() {

//// リコーコードを検索 OK @estimate_system.js
//function estimateSystemRicohCodeSearch(cnt) 

//// 結果代入用 OK 得意先検索画面　@estimate_system.js
//function handleHttpResponseAdminESRicohCodeSearch() {

// 詳細画面の商品情報検索ajax @estimate_system.js
//function estimateSystemProductSearch(inArrVals)

// 2バイト文字変換 @estimate_system.js
//function estimateSystemAlphaChange(str)

// 詳細画面 & 得意先検索画面 価格総計算 OK @estimate_system.js
//function estimateSystemTotalCalc() 

// 得意先検索画面　検索ボタン
function estimateSystemCustomerListSearch() {

    //var pData = new Array();
    //pData.push({
    //    Code: document.getElementById("Code").value,
    //    Name: document.getElementById("Name").value,
    //    Index: document.getElementById("Index").value,
    //    Tel: document.getElementById("Tel").value
    //})
    Code = $.trim($("#Code").val());
    Name = $.trim($("#Name").val());
    Index = $.trim($("#Index").val());
    Tel = $.trim($("#Tel").val());

    //*****************************************************
    //本番
    var url = "./Pages/PopCustomerSearch/PopCustomerSearch.aspx/GetJsonCustomerData";

    //TODO:日本語はUrlEncode必要！！！h ttp://surferonwww.info/BlogEngine/post/2011/11/07/Encoding-of-URL-directly-written-in-address-bar-of-browser.aspx
    var data = JSON.stringify({ Code: Code, Name: Name, Index: Index, Tel: Tel });
    var result = parent.$.getAjaxData(url, data);

    //エラーの場合
    if (result.match(/エラー：/)) {
        alert(result);
        return false;
    }

    var cstData = JSON.parse(result);
    //test
    //if (cstData == null) {
    //    alert("該当データが見つかりませんでした。");
    //    return false;
    //}
    //if (cstData === "" || cstData === undefined) {
    //    alert("test:cstData === 空 || cstData === undefined");
    //    return false;
    //}
    //if (cstData.length === undefined) {
    //    alert("test:cstData.length === undefined");
    //    return false;
    //}
    //if (cstData.length == 0) {
    //    alert("test:cstData.length == 0");
    //    return false;
    //}
    //if (Object.keys(cstData).length == 0) {
    //    alert("test:cstData.length == 0");
    //    return false;
    //}

    if (cstData == null) {
        $.pageInit(null);
    } else {
        $.pageInit(cstData["result_tbl"]);
    }
    $.pageDisplaySearch();  //0件の場合もこのメソッドで画面表示する
    return false;
}
