$(function () {

    //閉じる
    $('#BtnClose').click(function () {
        parent.$.closeDialog();
    });





    //const MaxDispLinePopProductIn = 100;
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

    });
});

// ************************
//   見積システム用JSファイル
// ************************
var MaxDispLine = 100;


//test data
//mr - faprnn	2
//mr - fa17cmkn	2
//mr - fa75kbn	2
//mr - fa75ntn	2
//aa - bb11ccc	123


// 商品一括入力画面 品番一括投入・・・入力ボタン
function estimateSystemItemAllInBtn() {
    inValue = document.getElementById("ProductList").value.split(/\r\n|\r|\n/);
    inCnt = 0;

    var inArrVals = new Array();

    for (i = 0; i < inValue.length; i++) {
        // if(inValue[i].replace(/(^[\s　]+)|([\s　]+$)/g, "") != "") {
        if ($.trim(inValue[i]) != "") {
            if (inCnt <= MaxDispLine) {
                inCnt++;
                amtVal = "";

                // 数量をタブ区切りで入力していた場合のみ処理
                if (inValue[i].indexOf("\t") != -1) {
                    inArrVal = inValue[i].split("\t");

                    if (inArrVal[1] != "" && !isNaN(inArrVal[1])) {
                        inValue[i] = inArrVal[0];

                        // 数量を挿入
                        amtVal = inArrVal[1];
                    } else {
                        inValue[i] = inArrVal[0];
                    }
                }

                //20200403 EDIT
                //window.opener.document.getElementById("ProductCode" + inCnt).value = inValue[i];
                parent.$("#ProductCode" + inCnt).val(inValue[i]);

                //20200403 EDIT
                //parent.estimateSystemProductSearch(inCnt);        //←既存　不要

                if (amtVal != "") {
                    //20200403 EDIT
                    //window.opener.document.getElementById("Quantity" + inCnt).value = amtVal;
                    parent.$("#Quantity" + inCnt).val(amtVal);
                }

                inArrVals.push({
                    pc: inValue[i],
                    qt: amtVal
                });
            }
        }
    }

    //20200403 EDIT
    //parent.estimateSystemProductSearchAll(inArrVals);         //←新規　作成必要 @estimate_system.js

    //既存
    //20200403 EDIT
    //var NowDispMax = window.opener.document.getElementById("NowDispMax").value;
    var NowDispMax = parent.$("#NowDispMax").val();

    if (inCnt * 1 > 0 && inCnt * 1 > NowDispMax * 1) {

        //20200403 EDIT
        //window.opener.document.getElementById("NowDispMax").value = inCnt;
        parent.$("#owDispMax").val(inCnt);

        for (cnt = NowDispMax * 1 + 1; cnt <= inCnt; cnt++) {

            //20200403 EDIT
            //window.opener.document.getElementById("Column_" + cnt).setAttribute('class', '');
            parent.$("#Column_" + cnt).attr('class', '');
            //20200403 TIPS:21移行には「class="tr_no_disp"」が付いている
            //<tr id="Column_21" class="tr_no_disp">

            //TODO:削除により、件数が減った場合が考慮されていない？？？
            //「parent.$("#Column_" + cnt).attr('class', 'tr_no_disp');」が必要？？？
        }
    }

    if (inCnt != 0) {
        //20200403 EDIT
        //window.parent.jQuery('#dialog').dialog('close');
        parent.$.closeDialog();
    }
}

// テキストエリアのタブ入力
function estimateSystemTabInput(object, e) {
    var kC = e.keyCode ? e.keyCode : e.charCode ? e.charCode : e.which;

    //Tab入力の場合
    if (kC == 9 && !e.shiftKey && !e.ctrlKey && !e.altKey) {
        var objectScroll = object.scrollTop;
        if (object.setSelectionRange) {
            var sS = object.selectionStart;
            var sE = object.selectionEnd;
            object.value = object.value.substring(0, sS) + "\t" + object.value.substr(sE);

            object.setSelectionRange(sS + 1, sS + 1);
            object.focus();

            //var s = window.getSelection();
            //var range = document.createRange();
            //range.selectNodeContents(object);
            //s.removeAllRanges();
            //s.addRange(range);

        } else if (object.createTextRange) {
            document.selection.createRange().text = "\t";
            e.returnValue = false;
        }

        object.scrollTop = objectScroll;

        if (e.preventDefault) {
            e.preventDefault();
        }

        return false;
    }
    return true;
}
