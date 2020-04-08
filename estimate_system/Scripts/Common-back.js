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
        Cookie.set(key, data, { expires: 1 });
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

    // ダイアログ
    $.showModalDialog = function (path, width, height, title) {

        var dialogObj = $("#dialog");
        if (dialogObj.length > 0) {
            dialogObj.remove();
        }

        var dialogHtml
            = "<div id='dialog' style='padding:0px; overflow:hidden;'>"
            + "<iframe src='" + path + "' style='width:100%; height:100%; margin:0px; border: 0px;'>"
            + "</iframe>"
            + "</div>";

        $("body").append(dialogHtml);
        $("#dialog").dialog({
            modal: true,
            width: width,
            height: height,
            closeText: "閉じる",
            title: title
        });

        if (title === "" || title === undefined) {
            $(".ui-dialog-titlebar").removeClass('ui-widget-header');
        }
        $.showLoading();

    };

    $.closeDialog = function () {
        var dialogObj = $("#dialog");

        if (dialogObj.length > 0) {
            $(dialogObj).dialog("close");
        }
        else if (window.parent !== undefined) {
            dialogObj = window.parent.$("#dialog");
            if (dialogObj.length > 0) {
                dialogObj.dialog("close");
            }
        }
    }

    // セッション
    $.getSession = function (skey) {

        var result = "";

        $.ajax({
            type: "POST",
            async: false,
            cache: false,
            url: location.href + "/getSession",
            data: JSON.stringify({ skey: skey }),
            contentType: "application/json; charaset=utf-8",
            dataType: "json"
        }).done(function (data, textStatus, jqXHR) {
            result = JSON.parse(data.d);
        }).fail(function (jqXHR, textStatus, errorThrown) {
            //alert("エラー：" + jqXHR.status);
        });

        return result;
    };

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

    var result = "";

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
        //alert("エラー：" + jqXHR.status);
        result = "エラー：" + jqXHR.status;
    });

    return result;
};

