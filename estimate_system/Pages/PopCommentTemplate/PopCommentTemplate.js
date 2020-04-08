$(function () {

    //閉じる
    $('#BtnClose').click(function () {
        parent.$.closeDialog();
    });




    //*****************************************************
    //var CheckNum;
    //var mode;

    const MaxDispLinePopCommentTemplate = 15;
    var NowDispMax;

    var Comment = {};


    //─────────────────────────────────────
    //機能： コメントテンプレート画面Load時イベント
    //引数： 
    //戻値： 
    //補足： 
    //─────────────────────────────────────
    $(document).ready(function () {

        var url = "./Pages/PopCommentTemplate/PopCommentTemplate.aspx/GetJsonCommentData";

        var data = JSON.stringify({  });
        var result = parent.$.getAjaxData(url, data);

        //エラーの場合
        if (result.match(/エラー：/)) {
            alert(result);
            return false;
        }

        var cmtData = JSON.parse(result);

        if (cmtData == null) {
            $.pageInit(null);
        } else {
            $.pageInit(cmtData["template_table"]);  //テーブル名
        }
        $.pageDisplay();
    });

    //─────────────────────────────────────
    //機能： コメントテンプレート画面　初期化
    //引数： 
    //戻値： 
    //補足： 
    //─────────────────────────────────────
    $.pageInitMain = function () {

        NowDispMax = MaxDispLinePopCommentTemplate;

        Comment = {};

        for (trCnt = 0; trCnt < NowDispMax; trCnt++) {
            Comment[trCnt] = "";
        }
    }

    //─────────────────────────────────────
    //機能： コメントテンプレート画面　初期データ編集
    //引数： 
    //戻値： 
    //補足： 
    //─────────────────────────────────────
    $.pageInit = function (cmtData) {
        // 変数初期化
        $.pageInitMain();

        //最大表示件数
        if (cmtData == null) {
            NowDispMax = 0;
        } else if (Object.keys(cmtData).length < MaxDispLinePopCommentTemplate) {
            NowDispMax = Object.keys(cmtData).length;
        } else {
            NowDispMax = MaxDispLinePopCommentTemplate;
        }

        //検索結果
        if (NowDispMax > 0) {
            for (trCnt = 0; trCnt < NowDispMax; trCnt++) {
                Comment[trCnt] = cmtData[trCnt]["Comment"];     //trimしない
            }
        }
    }

    //─────────────────────────────────────
    //機能： コメントテンプレート画面　初期データ表示
    //引数： 
    //戻値： 
    //補足： 
    //─────────────────────────────────────
    $.pageDisplay = function () {

        $("#template_table").children().remove();

        var table_html = "";

        // 一覧を表示
        table_html += '<table class="template_table">';
        //データありの場合
        if (NowDispMax > 0) {
            //TODO:データをセットする
            for (trCnt = 1; trCnt <= NowDispMax; trCnt++) {
                table_html += '  <tr>';
                table_html += '      <th style="width: 70px">定型文' + trCnt + '</th>';
                table_html += '      <td>';
                table_html += '          <textarea name="template' + trCnt + '" id="template' + trCnt + '">' + Comment[trCnt -1] + '</textarea>';
                table_html += '      </td>';
                table_html += '      <td style="width: 90px">';
                table_html += '          <p>';
                table_html += '              <input type="button" value="備考へ挿入" onclick="estimateSystemTemplateCommentRef(\' ' + trCnt + ' \');" />';
                table_html += '          </p>';
                table_html += '          <p class="save_btn">';
                table_html += '              <input type="button" value="保　存" onclick="estimateSystemTemplateCommentSave(\' ' + trCnt + ' \');" />';
                table_html += '          </p>';
                table_html += '      </td>';
                table_html += '  </tr>';
            }
            //データなしの場合
        } else {
            table_html += '  <tr>';
            table_html += '      <th style="width: 70px">定型文</th>';
            table_html += '      <td>';
            table_html += '          <textarea name="template1" id="template1"></textarea>';
            table_html += '      </td>';
            table_html += '      <td style="width: 90px">';
            table_html += '          <p>';
            table_html += '              <input type="button" value="備考へ挿入" onclick="estimateSystemTemplateCommentRef(\'1\');" />';
            table_html += '          </p>';
            table_html += '          <p class="save_btn">';
            table_html += '              <input type="button" value="保　存" onclick="estimateSystemTemplateCommentSave(\'1\');" />';
            table_html += '          </p>';
            table_html += '      </td>';
            table_html += '  </tr>';
        }
        table_html += '</table>';

        $("#template_table").append(table_html);

    }

});





// ***********************************************
// イベント
// ***********************************************

// コメントテンプレートの反映ボタン 20200330 MOVE FROM estimate_system.js
function estimateSystemTemplateCommentRef(seq) {
    //詳細画面のid=Otherに、定型文を最後に追加
    //20200401 EDIT
    //window.opener.document.getElementById("Other").value += document.getElementById("template" + seq).value;
    var newComment = document.getElementById("template" + seq).value;
    var parentComment = parent.$("#Other").val();
    parent.$("#Other").val(parentComment + newComment);

    //20200401 EDIT
    //window.close();
    parent.$.closeDialog();
}

// コメントテンプレートの保存ボタン 20200330 MOVE FROM estimate_system.js
function estimateSystemTemplateCommentSave(seq) {
    document.getElementById("SaveNo").value = seq;

    //20200330 EDIT
	//document.comment_template.submit();

    //本番
    var SaveComment = document.getElementById("template" + seq).value;

    var url = "./Pages/PopCommentTemplate/PopCommentTemplate.aspx/SetJsonCommentData";

    //TODO:日本語はUrlEncode必要！！！h ttp://surferonwww.info/BlogEngine/post/2011/11/07/Encoding-of-URL-directly-written-in-address-bar-of-browser.aspx
    var data = JSON.stringify({ SaveNo: seq, Comment: SaveComment });
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
    return false;
}
