$(function () {
    var NowDispMax;

    var CheckNum;
    var mode;
    var MailSendFlag;

    //var DisplayDate, Other, SalesMemo;

    var ProjectMailSubmitFlag;
    var SupAnswerMailSubmitFlag;
    var SalesPersonName;
    var SalesEx;
    var AssistantName;
    var AssistantEx;
    var CreateTime;
    var UpdateTime;
    var CustomerCode;
    var CustomerName;
    var CustomerDivision;
    var CustomerPersonName;
    var ProfessionClass;
    var EndUserName;
    var EndUserAddress;
    var DeliveryMethod;
    var DeliveryMethodPeriod;
    var DeliveryMethodTimes;
    var DeliveryLimitDate;
    var ConclusionDate;
    var Contents;


    var Columns = {};
    var SupPersonName = {};
    var DevPersonName = {};
    var ImportantFlag = {};
    var ConclusionStatusDetail = {};
    var ProductCode = {};
    var Quantity = {};
    var PurchaseComment = {};
    var RivalOther = {};
    var RegularPrice = {};
    var UnitPrice = {};
    var LeaderPrice = {};
    var UnitRate = {};
    var LeaderRate = {};
    var EigyouGenka = {};
    var CorrectionPrice = {};
    var CorrectionRate = {};
    var RivalMaker = {};
    var RivalSku = {};
    var RivalPrice = {};

    //
    var LeaderMargin;
    var LeaderMarginRate;

    //
    var MarginPrice = {};
    var MarginRate = {};
    var PurchaseComment = {};
    var DevLeaderComment = {};
    var RivalOther = {};
    var ConclusionStatusDetail = {};
    var SupPersonName = {};


    //─────────────────────────────────────
    //機能： 回答画面Load時イベント
    //引数： 
    //戻値： 
    //補足： 
    //─────────────────────────────────────
    $(document).ready(function () {

        //test **************************
        //ADD 20200228 test
        ////var url = "./Pages/Check/Check.aspx/GetJsonTestData";
        //var url = "./Check.aspx/GetJsonTestData";

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
        var schData;

        //// GET変数が存在する場合
        //if (querystr) {
        //    mode = "";
        //    if (!querystr.match(/&/)) {
        //        //querystrに含む場合の処理
        //        if (querystr.split('=')[0].match(/cno/)) {
        //            CheckNum = querystr.split('=')[1];
        //        }
        //    } else {
        //        // ?を取り除くため、1から始める。keyと値に分割。
        //        array = querystr.slice(1).split('&');
        //        qsarr = new Array();
        //        // GET変数を順に処理
        //        $.each(array,
        //            function (index, elem) {
        //                if (elem.split('=')[0].match(/cno/)) {
        //                    CheckNum = elem.split('=')[1];
        //                }
        //            }
        //        );
        //    }

        //    if (!CheckNum) {
        //        $.pageInitMain();
        //        $.pageDisplay(null);
        //    } else {

        //        var url = "./Check.aspx/GetJsonEstimateData";
        //          //OR
        //        //var url = "./Pages/Check/Check.aspx/GetJsonEstimateData";

        //        var data = JSON.stringify({ cno: CheckNum, mode: mode });
        //        var result = $.getAjaxData(url, data);
        //        var estData = JSON.parse(result);
        //        //if (result.indexOf('エラー：') != -1) {
        //        if (estData.length == 0) {
        //            alert(esData);
        //            return false;
        //        }

        //        //20200325 EDIT
        //        //var retData = estData["estDT"];
        //        //$.pageInit(estData["estDT"]);
        //        //$.pageDisplay(estData["estDT"]);
        //        var estData1 = estData["estDT1"];
        //        var estData2 = estData["estDT2"];
        //        $.pageInit(estData1, estData2);
        //        $.pageDisplay(estData1, estData2);
        //    }

        //} else {
        //    $.pageInitMain();
        //    $.pageDisplay(null);
        //}
    });

    //─────────────────────────────────────
    //機能： 回答画面　初期化
    //引数： 
    //戻値： 
    //補足： 
    //─────────────────────────────────────
    $.pageInitMain = function () {
        //20200325 ADD
        NowDispMax = MaxDispLine;

        //
        ProjectMailSubmitFlag = "";
        SupAnswerMailSubmitFlag = "";
        CheckNum = "";
        SalesPersonName = "";
        SalesEx = "";
        AssistantName = "";
        AssistantEx = "";
        CreateTime = "";
        UpdateTime = "";
        CustomerCode = "";
        CustomerName = "";
        CustomerDivision = "";
        CustomerPersonName = "";
        ProfessionClass = "";
        EndUserName = "";
        EndUserAddress = "";
        DeliveryMethod = "";
        DeliveryMethodPeriod = "";
        DeliveryMethodTimes = "";
        DeliveryLimitDate = "";
        ConclusionDate = "";
        Contents = "";

        //
        Columns = {};
        SupPersonName = {};
        DevPersonName = {};
        ImportantFlag = {};
        ConclusionStatusDetail = {};
        ProductCode = {};
        Quantity = {};
        PurchaseComment = {};
        RivalOther = {};
        RegularPrice = {};
        UnitPrice = {};
        LeaderPrice = {};
        UnitRate = {};
        LeaderRate = {};
        EigyouGenka = {};
        CorrectionPrice = {};
        CorrectionRate = {};
        RivalMaker = {};
        RivalSku = {};
        RivalPrice = {};

        //
        LeaderMargin = "";
        LeaderMarginRate = "";

        //
        MarginPrice = {};
        MarginRate = {};
        PurchaseComment = {};
        DevLeaderComment = {};
        RivalOther = {};
        ConclusionStatusDetail = {};
        SupPersonName = {};

        for (trCnt = 0; trCnt < MaxDispLine; trCnt++) {
            //
            Columns[trCnt] = "";
            SupPersonName[trCnt] = "";
            DevPersonName[trCnt] = "";
            ImportantFlag[trCnt] = "";
            ConclusionStatusDetail[trCnt] = "";
            ProductCode[trCnt] = "";
            Quantity[trCnt] = "";
            PurchaseComment[trCnt] = "";
            RivalOther[trCnt] = "";
            RegularPrice[trCnt] = "";
            UnitPrice[trCnt] = "";
            LeaderPrice[trCnt] = "";
            UnitRate[trCnt] = "";
            LeaderRate[trCnt] = "";
            EigyouGenka[trCnt] = "";
            CorrectionPrice[trCnt] = "";
            CorrectionRate[trCnt] = "";
            RivalMaker[trCnt] = "";
            RivalSku[trCnt] = "";
            RivalPrice[trCnt] = "";

            //
            MarginPrice[trCnt] = "";
            MarginRate[trCnt] = "";
            PurchaseComment[trCnt] = "";
            DevLeaderComment[trCnt] = "";
            RivalOther[trCnt] = "";
            ConclusionStatusDetail[trCnt] = "";
            SupPersonName[trCnt] = "";
        }
    }

    //─────────────────────────────────────
    //機能： 回答画面　取得データ編集
    //引数： 
    //戻値： 
    //補足： 
    //─────────────────────────────────────
    //20200325 EDIT
    //$.pageInit = function (estData) {
    $.pageInit = function (estData1, estData2) {
        //20200325 ADD
        // 変数初期化
        $.pageInitMain();

        if (estData2.length > MaxDispLine) {
            NowDispMax = estData2.length;
        } else {
            NowDispMax = MaxDispLine;
        }

        if (estData1.length > 0) {
            ProjectMailSubmitFlag = $.trim(estData1[0]["ProjectMailSubmitFlag"]);
            SupAnswerMailSubmitFlag = $.trim(estData1[0]["SupAnswerMailSubmitFlag"]);
            CheckNum = $.trim(estData1[0]["CheckNum"]);
            SalesPersonName = $.trim(estData1[0]["SalesPersonName"]);
            SalesEx = $.trim(estData1[0]["SalesEx"]);
            AssistantName = $.trim(estData1[0]["AssistantName"]);
            AssistantEx = $.trim(estData1[0]["AssistantEx"]);
            CreateTime = $.trim(estData1[0]["CreateTime"]);
            UpdateTime = $.trim(estData1[0]["UpdateTime"]);
            CustomerCode = $.trim(estData1[0]["CustomerCode"]);
            CustomerName = $.trim(estData1[0]["CustomerName"]);
            CustomerDivision = $.trim(estData1[0]["CustomerDivision"]);
            CustomerPersonName = $.trim(estData1[0]["CustomerPersonName"]);
            ProfessionClass = $.trim(estData1[0]["ProfessionClass"]);
            EndUserName = $.trim(estData1[0]["EndUserName"]);
            EndUserAddress = $.trim(estData1[0]["EndUserAddress"]);
            DeliveryMethod = $.trim(estData1[0]["DeliveryMethod"]);
            DeliveryMethodPeriod = $.trim(estData1[0]["DeliveryMethodPeriod"]);
            DeliveryMethodTimes = $.trim(estData1[0]["DeliveryMethodTimes"]);
            DeliveryLimitDate = $.trim(estData1[0]["DeliveryLimitDate"]);
            ConclusionDate = $.trim(estData1[0]["ConclusionDate"]);
            Contents = $.trim(estData1[0]["Contents"]);
        }

        if (estData2.length > 0) {
            LeaderMargin = "";
            LeaderMarginRate = "";

            for (trCnt = 0; trCnt < NowDispMax; trCnt++) {
                //
                Columns[trCnt] = $.trim(estData2[trCnt]["Columns"]);
                SupPersonName[trCnt] = $.trim(estData2[trCnt]["SupPersonName"]);
                DevPersonName[trCnt] = $.trim(estData2[trCnt]["DevPersonName"]);
                ImportantFlag[trCnt] = $.trim(estData2[trCnt]["ImportantFlag"]);
                ConclusionStatusDetail[trCnt] = $.trim(estData2[trCnt]["ConclusionStatusDetail"]);
                ProductCode[trCnt] = $.trim(estData2[trCnt]["ProductCode"]);
                Quantity[trCnt] = $.trim(estData2[trCnt]["Quantity"]);
                PurchaseComment[trCnt] = $.trim(estData2[trCnt]["PurchaseComment"]);
                RivalOther[trCnt] = $.trim(estData2[trCnt]["RivalOther"]);
                RegularPrice[trCnt] = $.trim(estData2[trCnt]["RegularPrice"]);
                UnitPrice[trCnt] = $.trim(estData2[trCnt]["UnitPrice"]);
                LeaderPrice[trCnt] = $.trim(estData2[trCnt]["LeaderPrice"]);
                UnitRate[trCnt] = $.trim(estData2[trCnt]["UnitRate"]);
                LeaderRate[trCnt] = $.trim(estData2[trCnt]["LeaderRate"]);
                EigyouGenka[trCnt] = $.trim(estData2[trCnt]["EigyouGenka"]);
                CorrectionPrice[trCnt] = $.trim(estData2[trCnt]["CorrectionPrice"]);
                CorrectionRate[trCnt] = $.trim(estData2[trCnt]["CorrectionRate"]);
                RivalMaker[trCnt] = $.trim(estData2[trCnt]["RivalMaker"]);
                RivalSku[trCnt] = $.trim(estData2[trCnt]["RivalSku"]);
                RivalPrice[trCnt] = $.trim(estData2[trCnt]["RivalPrice"]);

                //
                MarginPrice[trCnt] = $.trim(estData2[trCnt]["MarginPrice"]);
                MarginRate[trCnt] = $.trim(estData2[trCnt]["MarginRate"]);
                PurchaseComment[trCnt] = $.trim(estData2[trCnt]["PurchaseComment"]);
                DevLeaderComment[trCnt] = $.trim(estData2[trCnt]["DevLeaderComment"]);
                RivalOther[trCnt] = $.trim(estData2[trCnt]["RivalOther"]);
                ConclusionStatusDetail[trCnt] = $.trim(estData2[trCnt]["ConclusionStatusDetail"]);
                SupPersonName[trCnt] = $.trim(estData2[trCnt]["SupPersonName"]);
            }
        }
    }

    //─────────────────────────────────────
    //機能： 回答画面　取得データ表示
    //引数： 
    //戻値： 
    //補足： 
    //─────────────────────────────────────
    $.pageDisplay = function (estData1, estData2) {

        //TODO:





        return false;
    }
});





// ***********************************************
// ***********************************************

// 開発・仕入・リーダー用確認の在庫ボタン
function estimateSystemCheckInvOpen() {
	// 在庫照会
	//document.ESCheckForm.target="check_zaiko";
	//document.ESCheckForm.action = "http://ss.sanwa.local/sap/zaiko/index.asp";
	//document.ESCheckForm.submit();

    document.getElementById("form1").target = "check_zaiko";
    document.getElementById("form1").action = "http://ss.sanwa.local/sap/zaiko/index.asp";
    document.getElementById("form1").submit();
}

// 開発・仕入・リーダー用確認のシミュレーションボタン
function estimateSystemCheckSimuOpen(sku) {
    //document.getElementById("ProductCode").value = sku;     //不要？

	window.open("http://ss.sanwa.local/sap/purchase/?sku=" + sku, "simuration", "width=1920, height=1000, menubar=yes, toolbar=yes, scrollbars=yes, resizable=yes");
}

// 開発・仕入・リーダー用確認の率計算
function estimateSystemCheckPriceCalc(line, type) {
	var RPrice = document.getElementById("RegularPrice" + line).value;

	switch (type) {
		case "LeaderPrice":
			var LPrice = document.getElementById("LeaderPrice" + line).value;
			if (RPrice != "" && LPrice != "") {
				var LRate = Math.round(parseInt(LPrice) / parseInt(RPrice) * 100,0);
			} else {
				var LRate = 0;
			}

			document.getElementById("LeaderRate" + line).value = LRate;
			break;

		case "LeaderRate":
			var LRate = document.getElementById("LeaderRate" + line).value;
			if (RPrice != "" && LRate != "") {
				var LPrice = Math.round(parseInt(RPrice) * parseFloat(LRate) / 100,0);
			} else {
				var LPrice = 0;
			}

			document.getElementById("LeaderPrice" + line).value = LPrice;
			break;

		case "CorrectionPrice":
			var CPrice = document.getElementById("CorrectionPrice" + line).value;
			if (RPrice != "" && CPrice != "") {
				var CRate = Math.round(parseInt(CPrice) / parseInt(RPrice) * 100,0);
			} else {
				var CRate = 0;
			}

			document.getElementById("CorrectionRate" + line).value = CRate;
			break;

		case "CorrectionRate":
			var CRate = document.getElementById("CorrectionRate" + line).value;
			if (RPrice != "" && CRate != "") {
				var CPrice = Math.round(parseInt(RPrice) * parseFloat(CRate) / 100,0);
			} else {
				var CPrice = 0;
			}

			document.getElementById("CorrectionPrice" + line).value = CPrice;
			break;
	}

	// 粗利表示ありの場合は粗利再計算
	if (document.getElementById("LeaderMargin" + line)) {
		if (document.getElementById("LeaderPrice" + line).value != "" && document.getElementById("LeaderPrice" + line).value != "0") {
			var LPrice = document.getElementById("LeaderPrice" + line).value;
		} else {
			var LPrice = document.getElementById("UnitPrice" + line).value;
		}

		if (document.getElementById("CorrectionPrice" + line).value != "" && document.getElementById("CorrectionPrice" + line).value != "0") {
			var CPrice = document.getElementById("CorrectionPrice" + line).value;
		} else {
			var CPrice = document.getElementById("EigyouGenka" + line).value;
		}

		var MPrice = LPrice - CPrice;
		var MRate = Math.round(parseInt(MPrice) / parseInt(LPrice) * 100,0);

		document.getElementById("LeaderMargin" + line).value = MPrice;
		document.getElementById("LeaderMarginRate" + line).value = MRate;
	}
}

// 開発・仕入・リーダー用確認の保存
function estimateSystemCheckSave(mode) {
    //document.getElementById("MailSendFlag").value = mode;
    //document.ESCheckForm.target="_self";
    //document.ESCheckForm.action = "./check.asp";
    //   document.ESCheckForm.submit();

    //document.getElementById("MailSendFlag").value = mode;
    //document.getElementById("form1").target = "_self";
    //document.getElementById("form1").action = "./Check.aspx";
    //document.getElementById("form1").submit();

    //document.getElementById("BtnSave").click();   //OK

    //20200325 ADD
    //保 存(メール送信)の場合、mode='submit'
    MailSendFlag = mode;
    CheckNum = $.trim($("#CheckNum").val());

    var trCnt = $("#product_table tr").length - 1;
    //alert("estimateSystemCheckSave - trCnt=" + trCnt);

    //パラメータをセット
    var pData = new Array();
    for (i = 1; i <= trCnt; i++) {
        if (document.getElementById("Columns" + i).value != "") {
            pData.push({
                Columns: document.getElementById("Columns" + i).value,
                LeaderPrice: document.getElementById("LeaderPrice" + i).value,
                LeaderRate: document.getElementById("LeaderRate" + i).value,
                CorrectionPrice: document.getElementById("CorrectionPrice" + i).value,
                CorrectionRate: document.getElementById("CorrectionRate" + i).value,
                PurchaseComment: document.getElementById("PurchaseComment" + i).value,
                DevLeaderComment: document.getElementById("DevLeaderComment" + i).value,
                ImportantFlag: document.getElementById("ImportantFlag" + i).value
            })
        }
    }

    // 保存する
    //EDIT
    //var url = "./Check.aspx/SetJsonEstimateCheckData";
    var url = "./Pages/Check/Check.aspx/SetJsonEstimateCheckData";
    //TODO:日本語はUrlEncode必要！！！h ttp://surferonwww.info/BlogEngine/post/2011/11/07/Encoding-of-URL-directly-written-in-address-bar-of-browser.aspx
    var data = JSON.stringify({ pdata: pData, checkNum: CheckNum, mailSendFlag: MailSendFlag });

    var result = $.getAjaxData(url, data);

    //エラーの場合
    //Common.js ajaxがreturn ""設定の場合
    if (result.match(/エラー：/)) {
        alert(result);
        return false;
    }

    var message = JSON.parse(result);

    //結果表示
    //EDIT
    //if (result == "null") {
    //    alert("該当の見積が見つかりませんでした。");
    //} else {
    //    if (MailSendFlag == "") {
    //        alert("保存しました。");
    //    } else {
    //        alert("保存・メール送信しました。");
    //    }
    //}
    alert(message["aaa"][0]["message"]);   //TODO:仮テーブル名
    return false;
}