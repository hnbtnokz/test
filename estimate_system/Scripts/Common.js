// ステータス
const STATUS_CREATE = "1";              // 作成中
const STATUS_SUBMISSION = "2";          // 提出
const STATUS_APPROVAL_PROGRESS = "3";   // 承認中
const STATUS_NONAPPROVED = "4";         // 非承認
const STATUS_APPROVED = "5";            // 承認済
const STATUS_REPLY = "6";               // 返信
const STATUS_DISCUSSION = "7";          // 完了(検討予定)
const STATUS_NOANSWER = "8";            // 完了(対応なし)
const STATUS_FINISH = "9";              // 完了
const READ_EXIT = "1";
const READ_EXIT_NM = "閲覧済";
const FILE_SELECT_MAX = 3;
const PRINT_URL = "http://ss.sanwa.local/hanabata/pdf/repo_print.php?";
const PRINT_URL2 = "http://ss.sanwa.local/hanabata/pdf/repo_print_2.php?";
//const PRINT_URL = "http://localhost/weeklyreportsys/repo_print.php?";
const PRINT_MODE = "repoeva";
const MaxDispLine = 20;                 // 最大表示行数

// セレクト要素
// 都道府県
const ARR_PREF = "北海道,青森県,岩手県,宮城県,秋田県,山形県,福島県,茨城県,栃木県,群馬県,埼玉県,千葉県,東京都,神奈川県,新潟県,富山県,石川県,福井県,山梨県,長野県,岐阜県,静岡県,愛知県,三重県,滋賀県,京都府,大阪府,兵庫県,奈良県,和歌山県,鳥取県,島根県,岡山県,広島県,山口県,徳島県,香川県,愛媛県,高知県,福岡県,佐賀県,長崎県,熊本県,大分県,宮崎県,鹿児島県,沖縄県";
// ケースパターン
const CASE_PATTERN = "組込案件,年間契約,リース案件";

// 職業区分
const PRO_LIST1 = "工場・製造業,一般企業,一般企業,一般企業,一般企業,一般企業,一般企業,文教,文教,文教,文教,文教,官公庁,官公庁,官公庁,官公庁,医療";
const PRO_LIST2 = "工場・製造業・建設業,電気・ガス・熱供給・水道業・運輸業・郵便業,情報通信業,卸売業・小売業,金融業・保険業,サービス業,上記に分類されない企業,大学,小・中学校,高等学校,中高一貫校,その他教育機関,市区町村の関連機関,国の関連機関,自衛隊,都道府県の関連機関,医療施設";



var onChangeFlg = 0;

$(function () {
    // placeholder属性がJQueryでコピーできないので、ここで処理する
    // 参考：http://black-flag.net/jquery/20120321-3727.html

    $("[class~='helptext']").each(function () {
        var thisTitle = $(this).attr('title');
        if (!(thisTitle === '' || thisTitle === null)) {
            $(this).wrapAll('<span style="text-align:left;display:inline-block;position:relative;"></span>');
            $(this).parent('span').append('<span class="placeholder">' + thisTitle + '</span>');
            $('.placeholder').css({
                top: '4px',
                left: '5px',
                fontSize: '100%',
                lineHeight: '120%',
                textAlign: 'left',
                color: '#999',
                overflow: 'hidden',
                position: 'absolute'
                //position: 'absolute',
                //zIndex: '99'
            }).click(function () {
                $(this).prev().focus();
            });

            $(this).focus(function () {
                $(this).next('span').css({ display: 'none' });
            });

            $(this).blur(function () {
                var thisVal = $(this).val();
                if (thisVal === '') {
                    $(this).next('span').css({ display: 'inline-block' });
                } else {
                    $(this).next('span').css({ display: 'none' });
                }
            });

            var thisVal = $(this).val();
            if (thisVal === '') {
                $(this).next('span').css({ display: 'inline-block' });
            } else {
                $(this).next('span').css({ display: 'none' });
            }
        }
    });

    // cookie保存
    $.setCookie = function (key, data) {
        //20200327 EDIT
        //Cookie.set(key, data, { expires: 1 });
        Cookies.set(key, data, { expires: 1 });
    };
    // Cookies 20200327 ADD
    $.getCookie = function (skey) {

        var result = "";

        //20200324 EDIT
        //$.ajax({
        //    type: "POST",
        //    async: false,
        //    cache: false,
        //    url: location.href + "/getSession",
        //    data: JSON.stringify({ skey: skey }),
        //    contentType: "application/json; charaset=utf-8",
        //    dataType: "json"
        //}).done(function (data, textStatus, jqXHR) {
        //    result = JSON.parse(data.d);
        //}).fail(function (jqXHR, textStatus, errorThrown) {
        //    //alert("エラー：" + jqXHR.status);
        //});

        if (!skey || skey == "") {
            result = Cookies.get();
        } else {
            result = Cookies.get(skey);
        }

        return result;
    };

    // セッション
    $.getSession = function (skey) {

        var result = "";

        //20200324 EDIT
        //$.ajax({
        //    type: "POST",
        //    async: false,
        //    cache: false,
        //    url: location.href + "/getSession",
        //    data: JSON.stringify({ skey: skey }),
        //    contentType: "application/json; charaset=utf-8",
        //    dataType: "json"
        //}).done(function (data, textStatus, jqXHR) {
        //    result = JSON.parse(data.d);
        //}).fail(function (jqXHR, textStatus, errorThrown) {
        //    //alert("エラー：" + jqXHR.status);
        //});

        if (!skey || skey == "") {
            result = Cookies.get();
        } else {
            result = Cookies.get(skey);
        }

        return result;
    };

    $.cnvNumberToBool = function (num) {
        if (num === "1") {
            return true;
        }

        return false;
    };


    // 読み込み中
    $.showLoading = function () {

        var dialogObj = $("#loading");
        if (dialogObj.length > 0) {
            dialogObj.remove();
        }

        var dialogHtml
            = "<div id='loading' style='z-index:99999; position: fixed; top:35%; left:49%;'>"
            + "<img src='../../img/ajax-loader.gif' /></div>";

        $("body").append(dialogHtml);

    };

    $.closeLoading = function () {

        var dialogObj = $("#loading");
        if (dialogObj.length > 0) {
            dialogObj.remove();
        }
    }
    //};

    // ダイアログ
    $.showModalDialog = function (path, width, height, title) {

        //var dialogObj = $("#dialog");
        //20200313 EDIT
        var dialogObj = $("#dialog1");
        if (dialogObj.length > 0) {
            dialogObj.remove();
        }

        //------------------------
        ////original
        ////var dialogHtml = "<div id='dialog' style='padding:0px; overflow:hidden;'>"

        ////html dialog tag
        ////var dialogHtml = "<dialog id='dialog' style='width:" + width + "px; height:" + height + "px; padding:0px; overflow:hidden;'>"

        ////var dialogHtml = "<div class='modal-backdrop fade in'>"
        //var dialogHtml = "<div id='dialog' class='dialog' style='width:" + width + "px; height:" + height + "px; padding:0px; overflow:hidden;' title='グループ管理' >"

        //    //20200310 ADD
        //    + "<iframe src='" + path + "' style='width:100%; height:100%; margin:0px; border: 1px;'>"
        //    //+ "<iframe src='" + path + "' style='width:" + width + "px; height:" + height + "px; margin: 0px; border: 0px;' >"
        //    //+ "<iframe src='" + path + "' >"
        //    //+ "<iframe src='" + path + "' sandbox ='allow-modals allow-forms'>"
        //    //https://reference.hyper-text.org/html5/attribute/sandbox/#sample-code-area
        
        //    + "</iframe>"
        //    //+ "</dialog>";
        //    + "</div>";
        //--------------------

        //20200312 No.1 OK
        //var dialogHtml = "<div tabindex='-1' role='dialog' "
        //    + " class='ui-dialog ui-corner-all ui-widget ui-widget-content ui-front ui-dialog-buttons ui-draggable ui-resizable' "
        //    + " aria-describedby='dialog1' "
        //    + " aria-labelledby='ui-id-1' "
        //    //+ " style='position: absolute; width:" + width + "px; height:" + height + "px; top: auto; left: auto; z-index: 101;'>"
        //    + " style='position: absolute; width:" + width + "px; height:" + height + "px; top: 100px; left: 291.5px; z-index: 101;'>"       

        //    + "  <div class='ui-dialog-titlebar ui-corner-all ui-widget-header ui-helper-clearfix ui-draggable-handle'>"
        //    + "    <span id='ui-id-1' class='ui-dialog-title'>グループ管理</span>"
        //    + "    <button type='button' class='ui-button ui-corner-all ui-widget ui-button-icon-only ui-dialog-titlebar-close' title='Close'>"
        //    + "      <span class='ui-button-icon ui-icon ui-icon-closethick'></span>"
        //    + "      <span class='ui-button-icon-space'> </span>Close</button></div>"

        //    //+ "  <div id='dialog1' class='ui-dialog-content ui-widget-content' style='width: auto; min-height: 31.855px; max-height: none; height: auto;'>"
        //    + "  <div id='dialog1' class='ui-dialog-content ui-widget-content' style='width: 100%; min-height: 31.855px; max-height: none; height: 100%;'>"

        //    + "    <iframe src='" + path + "' style='width:100%; height:100%; margin:0px; border: 1px;'></iframe>"
        //    + "  </div>"

        ////    + "  <div class='ui-dialog-buttonpane ui-widget-content ui-helper-clearfix'>"
        ////    + "    <div class='ui-dialog-buttonset'>"
        ////    + "    <button type='button' class='ui-button ui-corner-all ui-widget'>確認</button>"
        ////    + "    <button type='button' class='ui-button ui-corner-all ui-widget'>キャンセル</button>"
        ////    + "    </div>"
        ////    + "  </div>"

        //    + "  <div class='ui-resizable-handle ui-resizable-n' style='z-index: 90;'></div>"
        //    + "  <div class='ui-resizable-handle ui-resizable-e' style='z-index: 90;'></div>"
        //    + "  <div class='ui-resizable-handle ui-resizable-s' style='z-index: 90;'></div>"
        //    + "  <div class='ui-resizable-handle ui-resizable-w' style='z-index: 90;'></div>"
        //    + "  <div class='ui-resizable-handle ui-resizable-se ui-icon ui-icon-gripsmall-diagonal-se' style='z-index: 90;'></div>"
        //    + "  <div class='ui-resizable-handle ui-resizable-sw' style='z-index: 90;'></div>"
        //    + "  <div class='ui-resizable-handle ui-resizable-ne' style='z-index: 90;'></div>"
        //    + "  <div class='ui-resizable-handle ui-resizable-nw' style='z-index: 90;'></div>"

        //    + "</div>"

        //    + "<div class='ui-widget-overlay ui-front' style='z-index: 100;'></div>";
        //--------------------

        ////20200313 No.2 EDIT
        //var dialogHtml = "<div id='dialog1' style='width:" + width + "px; height:" + height + "px; padding:0px; overflow:hidden;' >"
        //    + "<iframe src='" + path + "' style='width:100%; height:100%; margin:0px; border: 1px;'></iframe>"
        //    + "</div>";
        //    //+ "</div>"

        ////20200312
        //    //+ "<div class='ui-widget-overlay ui-front' style='z-index: 100;'></div>";

        ////20200313 No.3 EDIT
        var dialogHtml = "<div id='dialog1' style='width:" + width + "px; height:" + height + "px; padding:0px; overflow:hidden;' >"
            + "<iframe id='iframe_id' class='iframe' src='" + path + "' style='width:100%; height:100%; margin:0px; border: 1px;'></iframe>"
            + "</div>";

        

        //--------------------

        $("body").append(dialogHtml);

        //20200310 MOVE TO *A
        //$("#dialog").dialog({
        //    modal: true,
        //    width: width,
        //    height: height,
        //    closeText: "閉じる",
        //    title: title
        //});

        //20200312 No.2
        var dialogObj = $('#dialog1');
        // ダイアログを初期化（自動オープンする）
        dialogObj.dialog({
            show: "fade",   //20200313 ADD https://blog.mach3.jp/2012/04/16/tips-for-jquery-ui-dialog.html
            hide: "fade",   //20200313 ADD
            modal: true,
            //autoOpen: false,  //20200313 EDIT（自動オープンしない->する
            width: width,   //20200313 ADD
            height: height,   //20200313 ADD

            //20200316 EDIT
            //title: "グループ管理",
            title: title,

            closeText: "閉じる",
            closeOnEscape: false
            //closeOnEscape: false,
            //dialogClass: "dialog-no-close",   //閉じるボタン無しにする
            //buttons: {
            //    "確認": function () {
            //        $(this).dialog("close");
            //    },
            //    "キャンセル": function () {
            //        $(this).dialog("close");
            //    }
            //}
        });

        //20200313 ADD https://blog.mach3.jp/2012/04/16/tips-for-jquery-ui-dialog.html
        //$(".ui-widget-overlay").css("z-index", 999);

        if (title === "" || title === undefined) {
            $(".ui-dialog-titlebar").removeClass('ui-widget-header');
        }
        $.showLoading();

    };




    //20200313 ADD https://www.softel.co.jp/blogs/tech/archives/1001
    //背後のオーバーレイ（ダイアログの外の半透明の部分）をクリックしたとき、ダイアログを閉じる
    //$(document).on("click", ".ui-widget-overlay", function () {
    //    $(this).prev().find(".ui-dialog-content").dialog("close");
    //});

    //20200313 ADD https://blog.mach3.jp/2012/04/16/tips-for-jquery-ui-dialog.html
    //ダイアログ内ボタンをクリックしたとき、ダイアログを閉じる
    //$(document).on("click", ".ui-dialog .dialog-button-close", function () {
    //    $(this).closest(".ui-dialog-content").dialog("close");
    //});

    //20200313 ADD 
    //ダイアログ内タイトルボタンをクリックしたとき、ダイアログを閉じる
    //複数画面の複数ダイアログ対応が必要かも？？？
    //$(document).on("click", ".ui-dialog .ui-dialog-titlebar-close", function () {
    //    $(this).closest(".ui-dialog-content").dialog("close");
    //});



    $.closeDialog = function () {
        //var dialogObj = $("#dialog");
        //20200313 EDIT
        var dialogObj = $("#dialog1");

        if (dialogObj.length > 0) {

            //20200316 EDIT
            //$(dialogObj).dialog("close");
            dialogObj.dialog("close");

            //20200313 ADD https://blog.ijoru.com/?p=71
            //dialogObj.remove(); // ←DOM要素を消す
        }
        else if (window.parent !== undefined) {
            //dialogObj = window.parent.$("#dialog");
            dialogObj = window.parent.$("#dialog1");
            if (dialogObj.length > 0) {
                dialogObj.dialog("close");

                //20200312 ADD https://blog.ijoru.com/?p=71
                //dialogObj.remove(); // ←DOM要素を消す
            }
        }
    }
    //};

    //20200313 ADD
    $.reloadDialog = function () {
        var iframeObj = $("#iframe_id");

        if (iframeObj.length > 0) {
            //$(iframeObj).contentDocument.location.reload(true);//NG

            //iframeObj.document.location.reload(true);//NG

            var src = $(".iframe").attr("src");
            $(".iframe").attr("src", "");
            $(".iframe").attr("src", src);  //OK
        }
        else if (window.parent !== undefined) {
            iframeObj = window.parent.$("#iframe_id");
            if (iframeObj.length > 0) {
                //iframeObj.contentDocument.location.reload(true);
                var src = $(".iframe").attr("src");
                $(".iframe").attr("src", "");
                $(".iframe").attr("src", src);
            }
        }
    }
//20200313 ADD test
//Javascriptでのiframe操作tips(iframeの中身を差し替える) https://qiita.com/nntsugu/items/640762a7ba8fd7cc50dd

////jQuery
////$('#iframe_id')[0].contentDocument.location.reload(true);
//$('#iframe_id').contentDocument.location.reload(true);
////素のJavascript
////document.getElementById('iframe_id')[0].contentDocument.location.reload(true);
//document.getElementById('iframe_id').contentDocument.location.reload(true);


////iframeのコンテンツを差し替える(別のURLからコンテンツを取得する)
////iframeの中身を差し替えたい場合は、location.srcを書き換えてlocation.reloadしてもダメ。
////location.replaceしましょう。
////jQuery
////$('#iframe_id')[0].contentDocument.location.replace('target_url or target_path');
//$('#iframe_id').contentDocument.location.replace('target_url or target_path');
////素のJavascript
////document.getElementById('iframe_id')[0].contentDocument.location.replace('target_url or target_path');
//document.getElementById('iframe_id').contentDocument.location.replace('target_url or target_path');
////Sample
////$('#iframe_id')[0].contentDocument.location.replace('/preview/show/20140320');
//$('#iframe_id').contentDocument.location.replace('/preview/show/20140320');


//jQuery だけで、reloadを使わずに行う方法 https://9-bb.com/jquery%E3%81%A0%E3%81%91%E3%81%A7iframe%E3%82%92%E5%86%8D%E8%AA%AD%E3%81%BF%E8%BE%BC%E3%81%BFreload%E3%81%95%E3%81%9B%E3%82%8B%E6%96%B9%E6%B3%95%E3%81%A8javascript%E3%82%92%E4%BD%BF%E3%81%A3/
//var src = $(".iframe").attr("src");
//$(".iframe").attr("src", "");
//$(".iframe").attr("src", src);

 

    // メッセージ出力
    $.ShowJQueryAlertDialog = function (MSGCD, message, rowno) {
        switch (MSGCD) {
            case "MSG_W001":
                alert(rowno + "件目の" + message + "を入力して下さい。");
                break;

            case "MSG_W002":
                alert(rowno + "件目の承認、非承認のいずれかにチェックを入力してください。");
                break;

            case "MSG_W003":
                alert(rowno + "件目の型番を1000件以内で追加してください。");
                break;

            case "MSG_I001":
                alert(message + "が正常に終了しました。 ");
                break;
        }
    };

    $.CssSetStatus = function (tblObj, status) {
        $(tblObj).find("#tdSts").removeClass($(tblObj).find("#tdSts").prop("class"));
        $(tblObj).find("#tdStsSub").removeClass($(tblObj).find("#tdStsSub").prop("class"));
        $(tblObj).find("#tdRepono").removeClass($(tblObj).find("#tdRepono").prop("class"));
        switch (status) {
            case STATUS_CREATE:
                $(tblObj).find("#tdSts").addClass("tdSts1");
                $(tblObj).find("#tdStsSub").addClass("tdSts1");
                $(tblObj).find("#tdRepono").addClass("tdSts1");
                break;
            case STATUS_SUBMISSION:
                $(tblObj).find("#tdSts").addClass("tdSts2");
                $(tblObj).find("#tdStsSub").addClass("tdSts2");
                $(tblObj).find("#tdRepono").addClass("tdSts2");
                break;
            case STATUS_APPROVAL_PROGRESS:
                $(tblObj).find("#tdSts").addClass("tdSts3");
                $(tblObj).find("#tdStsSub").addClass("tdSts3");
                $(tblObj).find("#tdRepono").addClass("tdSts3");
                break;
            case STATUS_NONAPPROVED:
                $(tblObj).find("#tdSts").addClass("tdSts4");
                $(tblObj).find("#tdStsSub").addClass("tdSts4");
                $(tblObj).find("#tdRepono").addClass("tdSts4");
                break;
            case STATUS_APPROVED:
                $(tblObj).find("#tdSts").addClass("tdSts5");
                $(tblObj).find("#tdStsSub").addClass("tdSts5");
                $(tblObj).find("#tdRepono").addClass("tdSts5");
                break;
            case STATUS_REPLY:
                $(tblObj).find("#tdSts").addClass("tdSts6");
                $(tblObj).find("#tdStsSub").addClass("tdSts6");
                $(tblObj).find("#tdRepono").addClass("tdSts6");
                break;
            case STATUS_DISCUSSION:
                $(tblObj).find("#tdSts").addClass("tdSts7");
                $(tblObj).find("#tdStsSub").addClass("tdSts7");
                $(tblObj).find("#tdRepono").addClass("tdSts7");
                break;
            case STATUS_NOANSWER:
                $(tblObj).find("#tdSts").addClass("tdSts8");
                $(tblObj).find("#tdStsSub").addClass("tdSts8");
                $(tblObj).find("#tdRepono").addClass("tdSts8");
                break;
            case STATUS_FINISH:
                $(tblObj).find("#tdSts").addClass("tdSts9");
                $(tblObj).find("#tdStsSub").addClass("tdSts9");
                $(tblObj).find("#tdRepono").addClass("tdSts9");
                break;
            default:
                $(tblObj).find("#tdSts").addClass("tdSts0");
                $(tblObj).find("#tdStsSub").addClass("tdSts0");
                $(tblObj).find("#tdRepono").addClass("tdSts0");
                break;
        }
    };

});

// 入力変更時のフラグをセットする
function changeFlgSet() {
    onChangeFlg = 1;
}

//─────────────────────────────────────
//機能： Ajax送信・結果取得
//引数： aUrl: 送信先URL, aData: 送信データ
//戻値： result: 返却データ
//補足： 
//─────────────────────────────────────
$.getAjaxData = function (aUrl, aData) {

    //20200327 EDIT
    var result = "";

    //TODO:test DELETE必要
    //var result = null;

    $.ajax({
        type: "POST",
        async: false,
        cache: false,
        url: aUrl,
        data: aData,
        contentType: "application/json; charaset=utf-8",
        dataType: "json"
    }).done(function (data, textStatus, jqXHR) {
        result = data.d;
    }).fail(function (jqXHR, textStatus, errorThrown) {
        //h ttps://qiita.com/hanaita0102/items/9e2f7984ecb71440c322
        //h ttp://www.tohoho-web.com/js/jquery/ajax.htm
        //20200304

        //TODO:test DELETE必要
        alert("エラー：" + jqXHR.status + "-" + textStatus + "-" + errorThrown.message);    //エラー：404-error-undefined
        result = "エラー：" + jqXHR.status;
    });

    return result;
};

