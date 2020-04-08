$(function () {

    //閉じる
    $('#BtnClose').click(function () {
        parent.$.closeDialog();
    });





    //const MaxDispLinePopProductOut = 100;
    //var NowDispMax;


    //*****************************************************
    //─────────────────────────────────────
    //機能： Load時イベント
    //引数： 
    //戻値： 
    //補足： 
    //─────────────────────────────────────
    $(document).ready(function () {

        // 画面遷移時、メッセージなし
        onChangeFlg = 0;

        estimateSystemItemDataCopyCall();

    });
});

// ************************
//   見積システム用JSファイル
// ************************
var MaxDispLine = 100;

//商品データコピー画面の初期処理 MOVE FROM estimate_system.js
function estimateSystemItemDataCopyCall() {
	OutputData = "";

	for (i = 1; i <= MaxDispLine; i++) {
		//if (window.opener.document.getElementById("ProductCode" + i).value != "") {
        if (parent.$("#ProductCode" + i).val() != "") {
            OutputData += i + "\t";

            //20200403 EDIT
			//OutputData += window.opener.document.getElementById("ProductCode" + i).value + "\t";
			//OutputData += window.opener.document.getElementById("RegularPrice" + i).value + "\t";
			//OutputData += window.opener.document.getElementById("UnitPrice" + i).value + "\t";
			//OutputData += window.opener.document.getElementById("Quantity" + i).value + "\t";
			//OutputData += window.opener.document.getElementById("EigyouGenka" + i).value + "\t";
			//OutputData += window.opener.document.getElementById("InvW_" + i).value + "\t";
			//OutputData += window.opener.document.getElementById("InvE_" + i).value + "\n";

            OutputData += parent.$("#ProductCode" + i).val() + "\t";
            OutputData += parent.$("#RegularPrice" + i).val() + "\t";
            OutputData += parent.$("#UnitPrice" + i).val() + "\t";
            OutputData += parent.$("#Quantity" + i).val() + "\t";
            OutputData += parent.$("#EigyouGenka" + i).val() + "\t";
            OutputData += parent.$("#InvW_" + i).val() + "\t";
            OutputData += parent.$("#InvE_" + i).val() + "\n";
		}
	}

    if (OutputData != "") {
        //20200403 EDIT
		//document.getElementById("ProductList").value = "行目\t品番\t定価\t見積金額\t数量\t営業原価\t岡山在庫\t東京在庫\n";
		//document.getElementById("ProductList").value += OutputData;
		//document.getElementById("ProductList").focus();
        document.getElementById("ProductList").value = "行目\t品番\t定価\t見積金額\t数量\t営業原価\t岡山在庫\t東京在庫\n";
        document.getElementById("ProductList").value += OutputData;
        document.getElementById("ProductList").focus();
	} else {
        alert("出力できるデータがありません。");

        //20200403 EDIT
        //window.close();
        parent.$.closeDialog();
	}
}

