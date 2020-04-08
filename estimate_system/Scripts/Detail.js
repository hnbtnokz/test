$(function () {
    var DispMaxLine, DispMinLine, NowDispMax, DetailLineClass;
    var CreatePersonName, UpdateTime, CheckNum, DispFlag, RICOHFlag, RicohNum, IssueRicohNum;
    var CustomerCode, CustomerName, CustomerDivision, CustomerPersonName;
    var SalesPersonCode, SalesPersonName, AssistantCode, AssistantName;
    var Tel, Fax;
    var Title, PackingFare, DeliveryLimit, DeliverySchedule, DeliveryPlace, EstimateLimit, EstimateLimitDisp, ConclusionDate;
    var DisplayDate, EndUserName, Other, Contents, SalesMemo;

    var ProductCode = {};
    var ProductName = {};
    var OpenPrice = {};
    var RegularPrice = {};
    var Quantity = {};
    var UnitRate = {};
    var UnitPrice = {};
    var OutletFlag = {};
    var RCode = {};
    var FeeFlag = {};
    var SuperBigFlag = {};
    var Inventory = {};
    var Inventory2 = {};
    var Haishi = {};
    var NormalPrice = {};
    var NormalRate = {};
    var LimitPrice = {};
    var SubTotalPrice = {};
    var DeliveryTime = {};
    var Memo = {};
    var EigyouGenka = {};
    var MarginRank = {};
    var MarginPrice = {};
    var MarginRate = {};
    var MarginPriceSub = {};
    var DeleteFlag = {};
    var RivalMaker = {};
    var RivalSku = {};
    var RivalPrice = {};
    var RivalOther = {};
    var NotCompletedReason1 = {};
    var NotCompletedReason2 = {};
    var NotCompletedReason3 = {};
    var NotCompletedReason4 = {};
    var NotCompletedReason5 = {};
    var NotCompletedReason6 = {};
    var NotCompletedReason7 = {};
    var NotCompletedReason9 = {};
    var LeaderPrice = {};
    var LeaderRate = {};
    var CorrectionPrice = {};
    var CorrectionRate = {};
    var ConclusionStatusDetail = {};
    var PurchaseComment = {};
    var DevLeaderComment = {};
    var AutoAnswerFlag = {};
    var ImportantFlag = {};

    //var ProductName, OpenPrice, RegularPrice, Quantity, RCode;
    //var UnitRate, UnitPrice, NormalPrice, NormalRate, SubTotalPrice, DeliveryTime, Memo;
    //var EigyouGenka, MarginRank, MarginPrice, MarginRate, LimitPrice, MarginPriceSub, DeleteFlag, OutletFlag, FeeFlag, SuperBigFlag;
    var TotalPrice, trCnt, OpenPriceDisp, TaxDispFlag, DefaultTaxPercent, TaxPercent, MarginPriceSum, MarginRateSum, MarginRankSum, TotalDispFlag, NoPriceDisp;
    var ObjKikan;
    var YMD, SeqNo, Columns, Values;
    var TestMode, ReplyDate;
    var rRequestDate, rTitle, rReplyDate, rEndUserName, rDeliveryDate, rMemo;
    var rCompanyName, rCustomerName, rMailAddress;
    var RequestNumber, Status, ParentCheckNum, ChildCheckNum;
    var FixFlag;
    var PDF_URL;
    var ObjSAP;
    var CustGroup, todayD;
    var SanwaChLoginID, FixMailBody;
    var ObjDataTable, adInteger, adFldIsNullable, SaveCnt;
    var SanwaChOrderBreakFlag;
    var ChkPCode;
    var ConclusionStatus;
    var ProfessionClass1, ProfessionClass2, EndUserPref, EndUserAddress;
    var ProfessionList1, ProfessionList2, Pref, ArrData, ArrCnt;
    var MATKL, ProductClass;;
    var TotalQuantity, TotalFee
    var CommentCnt, DispCnt, ArrCmtProduct, ArrCmt, OutputDate;
    var CasePattern;
    var ContinuationFlag, ContinuationCycle, ContinuationAlertFix, ContinuationAlert, CycleCount;
    var GroupNo, GroupTitle, GroupLeader;
    var ProjectFlag, DeliveryLimitDate, AlertDate;
    var DeliveryMethod, DeliveryMethodPeriod, DeliveryMethodTimes;
    //var RivalMaker, RivalSku, RivalPrice, RivalOther, ConclusionStatusDetail, PurchaseComment, DevLeaderComment;
    //var LeaderPrice, LeaderRate, CorrectionPrice, CorrectionRate, AutoAnswerFlag, ImportantFlag;
    //var NotCompletedReason1, NotCompletedReason2, NotCompletedReason3, NotCompletedReason4, NotCompletedReason5, NotCompletedReason6, NotCompletedReason7, NotCompletedReason9;
    var LeaderPersonCode, LeaderPersonName, LeaderPersonMail, DevPersonCode, DevPersonName, DevPersonMail, SupPersonCode, SupPersonName, SupPersonMail;
    var AllAutoAnswerFlag;
    var ConclusionHead, MaxItemCnt;
    var ProjectMailSubmitFlag, ConclusionMailSubmitFlag, mode;

    //─────────────────────────────────────
    //機能： Load時イベント
    //引数： 
    //戻値： 
    //補足： 
    //─────────────────────────────────────
    $(document).ready(function () {

        var querystr = window.location.search;
        var schData;









        //TODO:20200401 test

        //// GET変数が存在する場合
        //if (querystr) {
        //    mode = "";
        //    if (!querystr.match(/&/)) {
        //        //querystrに含む場合の処理
        //        if (querystr.split('=')[0].match(/cno/)) {
        //            CheckNum = querystr.split('=')[1];
        //        }
        //        if (querystr.split('=')[0].match(/test/) && querystr.split('=')[1].match(/on/)) {
        //            TestMode = true;
        //        } else if (querystr.split('=')[0].match(/test/) && querystr.split('=')[1].match(/off/)) {
        //            TestMode = false;
        //        }
        //        if (querystr.split('=')[0].match(/mode/)) {
        //            mode = querystr.split('=')[1];
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
        //                if (elem.split('=')[0].match(/test/) && elem.split('=')[1].match(/on/)) {
        //                    TestMode = true;
        //                } else if (elem.split('=')[0].match(/test/) && elem.split('=')[1].match(/off/)) {
        //                    TestMode = false;
        //                }
        //                if (elem.split('=')[0].match(/mode/)) {
        //                    mode = elem.split('=')[1];
        //                }
        //            }
        //        );
        //    }

        //    if (!CheckNum) {
        //        $.pageInitMain();
        //        $.pageDisplay(null);
        //    } else {
        //        //var url = "./Detail.aspx/GetJsonEstimateData";
        //        var url = "Detail.aspx/GetJsonEstimateData";
        //        var data = JSON.stringify({ cno: CheckNum, mode: mode });
        //        var result = $.getAjaxData(url, data);
        //        var estData = JSON.parse(result);
        //        //if (result.indexOf('エラー：') != -1) {
        //        if (estData.length == 0) {

        //            alert("estData.length == 0 -->>" + esData );

        //            return false;
        //        }

        //        var retData = estData["estDT"];
        //        $.pageInit(estData["estDT"]);
        //        $.pageDisplay(estData["cmtDT"]);
        //    }

        //} else {
        //    $.pageInitMain();
        //    $.pageDisplay(null);
        //}
    });

    //─────────────────────────────────────
    //機能： テストボタン クリックイベント
    //引数： 
    //戻値： 
    //補足： 
    //─────────────────────────────────────
    $("#btnTest").click(function () {
        // 入力データを取得する

        var url = "./Detail.aspx/GetJsonTestData";
        var data = JSON.stringify({ test: 'TEST' });
        var result = $.getAjaxData(url, data);
        var esData = JSON.parse(result);
        //if (result.indexOf('エラー：') != -1) {
        if (result.match(/エラー：/)) {
            alert(esData);
            return false;
        }

        alert(esData["DT1"][0]["A"] + ':' + esData["DT1"][0]["B"] + ':' + esData["DT1"][0]["C"]);
        alert(esData["DT2"][0]["A"]);
    });

    //─────────────────────────────────────
    //機能： リセットボタン クリックイベント
    //引数： 
    //戻値： 
    //補足： 
    //─────────────────────────────────────
    $("#btnReset").click(function () {
        $.pageInitMain();
    });

    //─────────────────────────────────────
    //機能： 見積明細ページ初期化
    //引数： 
    //戻値： 
    //補足： 
    //─────────────────────────────────────
    $.pageInitMain = function () {

        CreatePersonName = "";
        UpdateTime = "";
        CheckNum = "";
        DispFlag = 0;
        CustomerCode = "";
        CustomerName = "";
        CustomerDivision = "";
        CustomerPersonName = "";
        SalesPersonCode = "";
        SalesPersonName = "";
        AssistantCode = "";
        AssistantName = "";
        Tel = "";
        Fax = "";
        Title = "";
        PackingFare = "貴社との取り決めによる";
        DeliveryLimit = "別途";
        DeliverySchedule = "";
        DeliveryPlace = "貴社ご指定";
        EstimateLimit = "30";
        EstimateLimitDisp = "";
        ConclusionDate = "";
        DisplayDate = "";
        EndUserName = "";
        Other = "";
        Contents = "";
        SalesMemo = "";
        TaxDispFlag = 0;
        TaxPercent = 10;
        DefaultTaxPercent = TaxPercent;
        OpenPriceDisp = 0;
        NoPriceDisp = 0;
        TotalPrice = 0;
        TotalQuantity = 0;
        TotalFee = 0;
        TotalDispFlag = 1;
        ReplyDate = "";
        Status = "新規登録";
        ParentCheckNum = "";
        ChildCheckNum = "";
        FixFlag = 0;
        RICOHFlag = 0;
        RicohNum = "";
        IssueRicohNum = "";
        SanwaChOrderBreakFlag = 0;
        SanwaChLoginID = "";
        FixMailBody = "";
        ConclusionStatus = "継続中";
        ProfessionClass1 = "";
        ProfessionClass2 = "";
        EndUserPref = "";
        EndUserAddress = "";
        ContinuationFlag = "";
        ContinuationCycle = "0";
        adInteger = 3;
        adFldIsNullable = 32;

        // グループ設定
        GroupNo = "";
        GroupTitle = "";
        GroupLeader = "";

        // 案件情報
        ProjectFlag = "";
        DeliveryLimitDate = "";
        AlertDate = "";
        DeliveryMethod = "";
        DeliveryMethodPeriod = "";
        DeliveryMethodTimes = "";

        // サンワCh依頼からの取込
        RequestNumber = "";
        rRequestDate = "";
        rTitle = "";
        rReplyDate = "";
        rEndUserName = "";
        rDeliveryDate = "";
        rMemo = "";
        rCompanyName = "";
        rCustomerName = "";
        rMailAddress = "";

        // メール送信有無
        ProjectMailSubmitFlag = 0;
        ConclusionMailSubmitFlag = 0

        //var dt, y, m, d
        //dt = new Date();
        //y = dt.getFullYear();
        //m = ('0' + (dt.getMonth() + 1)).slice(-2);
        //d = ('0' + dt.getDate()).slice(-2);
        //todayD = y + '/' + m + '/' + d;

        $.pageInitProduct();
    }

    //─────────────────────────────────────
    //機能： 見積明細ページ初期化
    //引数： 
    //戻値： 
    //補足： 
    //─────────────────────────────────────
    $.pageInitProduct = function () {

        // 商品詳細
        NowDispMax = MaxDispLine;

        ProductCode = {};
        ProductName = {};
        OpenPrice = {};
        RegularPrice = {};
        Quantity = {};
        UnitRate = {};
        UnitPrice = {};
        OutletFlag = {};
        RCode = {};
        FeeFlag = {};
        SuperBigFlag = {};
        Inventory = {};
        Inventory2 = {};
        Haishi = {};
        NormalPrice = {};
        NormalRate = {};
        LimitPrice = {};
        SubTotalPrice = {};
        DeliveryTime = {};
        Memo = {};
        EigyouGenka = {};
        MarginRank = {};
        MarginPrice = {};
        MarginRate = {};
        MarginPriceSub = {};
        DeleteFlag = {};
        RivalMaker = {};
        RivalSku = {};
        RivalPrice = {};
        RivalOther = {};
        NotCompletedReason1 = {};
        NotCompletedReason2 = {};
        NotCompletedReason3 = {};
        NotCompletedReason4 = {};
        NotCompletedReason5 = {};
        NotCompletedReason6 = {};
        NotCompletedReason7 = {};
        NotCompletedReason9 = {};
        LeaderPrice = {};
        LeaderRate = {};
        CorrectionPrice = {};
        CorrectionRate = {};
        ConclusionStatusDetail = {};
        PurchaseComment = {};
        DevLeaderComment = {};
        AutoAnswerFlag = {};
        ImportantFlag = {};

        for (trCnt = 0; trCnt < MaxDispLine; trCnt++) {
            ProductCode[trCnt] = "";
            ProductName[trCnt] = "";
            OpenPrice[trCnt] = 0;
            RegularPrice[trCnt] = 0;
            Quantity[trCnt] = 0;
            UnitRate[trCnt] = 0;
            UnitPrice[trCnt] = 0;

            OutletFlag[trCnt] = "";
            RCode[trCnt] = "";
            FeeFlag[trCnt] = 0;
            SuperBigFlag[trCnt] = 0;
            Inventory[trCnt] = "";
            Inventory2[trCnt] = "";
            Haishi[trCnt] = "";

            NormalPrice[trCnt] = 0;
            NormalRate[trCnt] = 0;
            LimitPrice[trCnt] = 0;
            SubTotalPrice[trCnt] = 0;
            DeliveryTime[trCnt] = "";
            Memo[trCnt] = "";

            // コピーの場合は営業原価を再提案
            EigyouGenka[trCnt] = 0;
            MarginRank[trCnt] = "";
            MarginPrice[trCnt] = 0;
            MarginRate[trCnt] = 0;
            MarginPriceSub[trCnt] = 0;
            DeleteFlag[trCnt] = 0;

            // 案件情報
            RivalMaker[trCnt] = "";
            RivalSku[trCnt] = "";
            RivalPrice[trCnt] = 0;
            RivalOther[trCnt] = "";

            NotCompletedReason1[trCnt] = "";
            NotCompletedReason2[trCnt] = "";
            NotCompletedReason3[trCnt] = "";
            NotCompletedReason4[trCnt] = "";
            NotCompletedReason5[trCnt] = "";
            NotCompletedReason6[trCnt] = "";
            NotCompletedReason7[trCnt] = "";
            NotCompletedReason9[trCnt] = "";

            LeaderPrice[trCnt] = 0;
            LeaderRate[trCnt] = 0;
            CorrectionPrice[trCnt] = 0;
            CorrectionRate[trCnt] = 0;

            ConclusionStatusDetail[trCnt] = "";

            PurchaseComment[trCnt] = "";
            DevLeaderComment[trCnt] = "";

            AutoAnswerFlag[trCnt] = 0;
            ImportantFlag[trCnt] = 0;
        }

        TotalQuantity = 0;
        TotalPrice = 0;
        TotalFee = 0;
        MarginPriceSum = 0;
        MarginRateSum = 0;
        MarginRankSum = "";

    }

    //─────────────────────────────────────
    //機能： 取得データ編集
    //引数： 
    //戻値： 
    //補足： 
    //─────────────────────────────────────
    $.pageInit = function (estData) {
        // 変数初期化
        $.pageInitMain();

        if (estData.length > 0) {
            CustomerCode = $.trim(estData[0]["CustomerCode"])

            // ■ コピーモード判定
            if (mode == "copy") {
                CreatePersonName = $.trim($("#EstPersonName").val());
            } else {
                // レコードが見つかった場合のみ処理
                if (estData[0]["CreatePersonName"] == null) {
                    CreatePersonName = $.trim($("#EstPersonName").val());
                } else {
                    CreatePersonName = estData[0]["CreatePersonName"];
                }
            }

            CheckNum = $.trim(estData[0]["CheckNum"]);
            UpdateTime = estData[0]["UpdateTime"];
            Status = estData[0]["Status"];
            FixFlag = estData[0]["FixFlag"];
            RequestNumber = estData[0]["SanwaChRequestNumber"];
            ParentCheckNum = estData[0]["ParentCheckNum"];
            ChildCheckNum = estData[0]["ChildCheckNum"];

            RicohNum = estData[0]["RicohNum"];

            SalesPersonCode = $.trim(estData[0]["SalesPersonCode"]);
            SalesPersonName = $.trim(estData[0]["SalesPersonName"]);
            AssistantCode = $.trim(estData[0]["AssistantCode"]);
            AssistantName = $.trim(estData[0]["AssistantName"]);
            Tel = $.trim(estData[0]["Tel"]);
            Fax = $.trim(estData[0]["Fax"]);

            if (estData[0]["SanwaChDispFlag"] == 1) {
                DispFlag = 1;
            }

            CustomerName = $.trim(estData[0]["CustomerName"]);
            CustomerDivision = $.trim(estData[0]["CustomerDivision"]);
            CustomerPersonName = $.trim(estData[0]["CustomerPersonName"]);
            Title = $.trim(estData[0]["Title"]);
            PackingFare = $.trim(estData[0]["PackingFare"]);
            DeliveryLimit = $.trim(estData[0]["DeliveryLimit"]);
            DeliverySchedule = $.trim(estData[0]["DeliverySchedule"]);
            DeliveryPlace = $.trim(estData[0]["DeliveryPlace"]);
            EstimateLimit = $.trim(estData[0]["EstimateLimit"].replace("日", ""));
            EstimateLimitDisp = $.trim(estData[0]["EstimateLimitDisp"]);
            ConclusionDate = $.trim(estData[0]["ConclusionDate"]);
            DisplayDate = estData[0]["DisplayDate"];
            EndUserName = $.trim(estData[0]["EndUserName"]);
            Other = $.trim(estData[0]["Other"]);
            Contents = $.trim(estData[0]["Contents"]);
            SalesMemo = $.trim(estData[0]["SalesMemo"]);

            if (estData[0]["TaxDispFlag"] == 1) {
                TaxDispFlag = 1;
            } else if (estData[0]["TaxDispFlag"] == 2) {
                TaxDispFlag = 2;
            }

            if (estData[0]["TaxPercent"] == 5) {
                TaxPercent = 5;
            } else if (estData[0]["TaxPercent"] == 8) {
                TaxPercent = 8;
            } else {
                TaxPercent = 10;
            }

            if (estData[0]["OpenPriceDisp"] == 1) {
                OpenPriceDisp = 1;
            }

            if (estData[0]["NoPriceDisp"] == "1") {
                NoPriceDisp = 1;
            }

            if (estData[0]["TotalDispFlag"] == "0") {
                TotalDispFlag = 0;
            }

            TotalPrice = estData[0]["TotalPrice"];
            MarginPriceSum = estData[0]["MarginPriceSum"];
            MarginRateSum = estData[0]["MarginRateSum"];
            MarginRankSum = estData[0]["MarginRankSum"];
            ReplyDate = estData[0]["ReplyDate"];
            SanwaChLoginID = estData[0]["SanwaChLoginID"];
            FixMailBody = estData[0]["FixMailBody"];
            ConclusionStatus = estData[0]["ConclusionStatus"];

            if (ConclusionStatus == null) {
                ConclusionStatus = "";
            }

            if (estData[0]["SanwaChOrderBreakFlag"] == 1) {
                SanwaChOrderBreakFlag = 1;
            }

            // 追加情報
            ProfessionClass1 = estData[0]["ProfessionClass1"];
            ProfessionClass2 = estData[0]["ProfessionClass2"];
            EndUserPref = estData[0]["EndUserPref"];
            EndUserAddress = estData[0]["EndUserAddress"];

            // 継続案件情報
            ContinuationFlag = estData[0]["ContinuationFlag"];
            ContinuationCycle = estData[0]["ContinuationCycle"];

            // グループ設定
            GroupNo = estData[0]["GroupNo"];
            GroupTitle = estData[0]["GroupName"];
            GroupLeader = $.trim(estData[0]["SalesPersonName"]);

            // 案件情報
            ProjectFlag = estData[0]["ProjectFlag"];
            DeliveryLimitDate = estData[0]["DeliveryLimitDate"];
            AlertDate = estData[0]["AlertDate"];
            DeliveryMethod = estData[0]["DeliveryMethod"];
            DeliveryMethodPeriod = estData[0]["DeliveryMethodPeriod"];
            DeliveryMethodTimes = estData[0]["DeliveryMethodTimes"];

            // サンワCh依頼からの取込
            RequestNumber = estData[0]["SanwaChRequestNumber"];
            rRequestDate = estData[0]["rRequestDate"];
            rTitle = estData[0]["rTitle"];
            rReplyDate = estData[0]["rReplyDate"];
            rEndUserName = estData[0]["rEndUserName"];
            rDeliveryDate = estData[0]["rDeliveryDate"];
            rMemo = estData[0]["rMemo"];
            rCompanyName = estData[0]["rCompanyName"];
            rCustomerName = estData[0]["rCustomerName"];
            rMailAddress = estData[0]["rMailAddress"];

            // メール送信有無
            // コピーの場合は確認しない
            if (mode != "copy") {
                ProjectMailSubmitFlag = estData[0]["ProjectMailSubmitFlag"];
                ConclusionMailSubmitFlag = estData[0]["ConclusionMailSubmitFlag"];
            }

            // 商品情報の取得
            //trCnt = 0
            //    On Error Resume Next	' 仕切価格判定用にエラーを飛ばす

            //    todayD = CDate(Year(Now) & "/" & Month(Now) & "/" & Day(Now))
            var dt, y, m, d
            dt = new Date();
            y = dt.getFullYear();
            m = ('0' + (dt.getMonth() + 1)).slice(-2);
            d = ('0' + dt.getDate()).slice(-2);
            todayD = y + '/' + m + '/' + d;

            // RICOHモード
            if (CustomerCode.slice(0, 5) == "00018") {
                RICOHFlag = 1;
            }

            if (estData.length > MaxDispLine) {
                NowDispMax = estData.length;
            } else {
                NowDispMax = MaxDispLine;
            }

            // 商品詳細
            for (trCnt = 0; trCnt < NowDispMax; trCnt++) {
                if (estData.length < MaxDispLine) {
                    if (estData.length <= trCnt) {
                        ProductCode[trCnt] = "";
                        ProductName[trCnt] = "";
                        OpenPrice[trCnt] = 0;
                        RegularPrice[trCnt] = 0;
                        Quantity[trCnt] = 0;
                        UnitRate[trCnt] = 0;
                        UnitPrice[trCnt] = 0;

                        OutletFlag[trCnt] = "";
                        RCode[trCnt] = "";
                        FeeFlag[trCnt] = 0;
                        SuperBigFlag[trCnt] = 0;
                        Inventory[trCnt] = "";
                        Inventory2[trCnt] = "";
                        Haishi[trCnt] = "";

                        NormalPrice[trCnt] = 0;
                        NormalRate[trCnt] = 0;
                        LimitPrice[trCnt] = 0;
                        SubTotalPrice[trCnt] = 0;
                        DeliveryTime[trCnt] = "";
                        Memo[trCnt] = "";

                        // コピーの場合は営業原価を再提案
                        EigyouGenka[trCnt] = 0;
                        MarginRank[trCnt] = "";
                        MarginPrice[trCnt] = 0;
                        MarginRate[trCnt] = 0;
                        MarginPriceSub[trCnt] = 0;
                        DeleteFlag[trCnt] = 0;

                        // 案件情報
                        RivalMaker[trCnt] = "";
                        RivalSku[trCnt] = "";
                        RivalPrice[trCnt] = 0;
                        RivalOther[trCnt] = "";

                        NotCompletedReason1[trCnt] = "";
                        NotCompletedReason2[trCnt] = "";
                        NotCompletedReason3[trCnt] = "";
                        NotCompletedReason4[trCnt] = "";
                        NotCompletedReason5[trCnt] = "";
                        NotCompletedReason6[trCnt] = "";
                        NotCompletedReason7[trCnt] = "";
                        NotCompletedReason9[trCnt] = "";

                        LeaderPrice[trCnt] = 0;
                        LeaderRate[trCnt] = 0;
                        CorrectionPrice[trCnt] = 0;
                        CorrectionRate[trCnt] = 0;

                        ConclusionStatusDetail[trCnt] = "";

                        PurchaseComment[trCnt] = "";
                        DevLeaderComment[trCnt] = "";

                        AutoAnswerFlag[trCnt] = 0;
                        ImportantFlag[trCnt] = 0;
                    } else {
                        ProductCode[trCnt] = $.trim(estData[trCnt]["ProductCode"]);
                        ProductName[trCnt] = $.trim(estData[trCnt]["ProductName"]);
                        OpenPrice[trCnt] = estData[trCnt]["OpenPrice"];
                        RegularPrice[trCnt] = estData[trCnt]["RegularPrice"];
                        Quantity[trCnt] = estData[trCnt]["Quantity"];
                        UnitRate[trCnt] = estData[trCnt]["UnitRate"];
                        UnitPrice[trCnt] = estData[trCnt]["UnitPrice"];

                        OutletFlag[trCnt] = estData[trCnt]["OutletFlag"];
                        RCode[trCnt] = $.trim(estData[trCnt]["RCode"]);

                        FeeFlag[trCnt] = estData[trCnt]["FeeFlag"];
                        SuperBigFlag[trCnt] = estData[trCnt]["SuperBigFlag"];
                        Inventory[trCnt] = estData[trCnt]["Inventory"];
                        Inventory2[trCnt] = estData[trCnt]["Inventory2"];
                        Haishi[trCnt] = estData[trCnt]["Haishi"];

                        NormalPrice[trCnt] = estData[trCnt]["NormalPrice"];
                        NormalRate[trCnt] = estData[trCnt]["NormalRate"];

                        LimitPrice[trCnt] = estData[trCnt]["LimitPrice"];

                        SubTotalPrice[trCnt] = estData[trCnt]["SubTotalPrice"];
                        DeliveryTime[trCnt] = $.trim(estData[trCnt]["DeliveryTime"]);
                        Memo[trCnt] = $.trim(estData[trCnt]["Memo"]);

                        EigyouGenka[trCnt] = estData[trCnt]["EigyouGenka"];
                        MarginRank[trCnt] = estData[trCnt]["MarginRank"];
                        MarginPrice[trCnt] = estData[trCnt]["MarginPrice"];

                        MarginRate[trCnt] = estData[trCnt]["MarginRate"];
                        MarginPriceSub[trCnt] = estData[trCnt]["MarginPriceSub"];
                        DeleteFlag[trCnt] = estData[trCnt]["DeleteFlag"];

                        // 案件情報
                        RivalMaker[trCnt] = estData[trCnt]["RivalMaker"];
                        RivalSku[trCnt] = estData[trCnt]["RivalSku"];
                        RivalPrice[trCnt] = estData[trCnt]["RivalPrice"];
                        RivalOther[trCnt] = estData[trCnt]["RivalOther"];

                        NotCompletedReason1[trCnt] = estData[trCnt]["NotCompletedReason1"];
                        NotCompletedReason2[trCnt] = estData[trCnt]["NotCompletedReason2"];
                        NotCompletedReason3[trCnt] = estData[trCnt]["NotCompletedReason3"];
                        NotCompletedReason4[trCnt] = estData[trCnt]["NotCompletedReason4"];
                        NotCompletedReason5[trCnt] = estData[trCnt]["NotCompletedReason5"];
                        NotCompletedReason6[trCnt] = estData[trCnt]["NotCompletedReason6"];
                        NotCompletedReason7[trCnt] = estData[trCnt]["NotCompletedReason7"];
                        NotCompletedReason9[trCnt] = estData[trCnt]["NotCompletedReason9"];

                        LeaderPrice[trCnt] = estData[trCnt]["LeaderPrice"];
                        LeaderRate[trCnt] = estData[trCnt]["LeaderRate"];
                        CorrectionPrice[trCnt] = estData[trCnt]["CorrectionPrice"];
                        CorrectionRate[trCnt] = estData[trCnt]["CorrectionRate"];

                        if (estData[trCnt]["ConclusionStatusDetail"] == null || estData[trCnt]["ConclusionStatusDetail"] == "") {
                            ConclusionStatusDetail[trCnt] = "継続中";
                        } else {
                            ConclusionStatusDetail[trCnt] = estData[trCnt]["ConclusionStatusDetail"];
                        }

                        PurchaseComment[trCnt] = estData[trCnt]["PurchaseComment"];
                        DevLeaderComment[trCnt] = estData[trCnt]["DevLeaderComment"];

                        AutoAnswerFlag[trCnt] = estData[trCnt]["AutoAnswerFlag"];
                        ImportantFlag[trCnt] = estData[trCnt]["ImportantFlag"];
                    }
                } else {

                    ProductCode[trCnt] = $.trim(estData[trCnt]["ProductCode"]);
                    ProductName[trCnt] = $.trim(estData[trCnt]["ProductName"]);
                    OpenPrice[trCnt] = estData[trCnt]["OpenPrice"];
                    RegularPrice[trCnt] = estData[trCnt]["RegularPrice"];
                    Quantity[trCnt] = estData[trCnt]["Quantity"];
                    UnitRate[trCnt] = estData[trCnt]["UnitRate"];
                    UnitPrice[trCnt] = estData[trCnt]["UnitPrice"];

                    OutletFlag[trCnt] = estData[trCnt]["OutletFlag"];
                    RCode[trCnt] = $.trim(estData[trCnt]["RCode"]);

                    FeeFlag[trCnt] = estData[trCnt]["FeeFlag"];
                    SuperBigFlag[trCnt] = estData[trCnt]["SuperBigFlag"];
                    Inventory[trCnt] = estData[trCnt]["Inventory"];
                    Inventory2[trCnt] = estData[trCnt]["Inventory2"];
                    Haishi[trCnt] = estData[trCnt]["Haishi"];

                    NormalPrice[trCnt] = estData[trCnt]["NormalPrice"];
                    NormalRate[trCnt] = estData[trCnt]["NormalRate"];

                    LimitPrice[trCnt] = estData[trCnt]["LimitPrice"];

                    SubTotalPrice[trCnt] = estData[trCnt]["SubTotalPrice"];
                    DeliveryTime[trCnt] = $.trim(estData[trCnt]["DeliveryTime"]);
                    Memo[trCnt] = $.trim(estData[trCnt]["Memo"]);

                    EigyouGenka[trCnt] = estData[trCnt]["EigyouGenka"];
                    MarginRank[trCnt] = estData[trCnt]["MarginRank"];
                    MarginPrice[trCnt] = estData[trCnt]["MarginPrice"];

                    MarginRate[trCnt] = estData[trCnt]["MarginRate"];
                    MarginPriceSub[trCnt] = estData[trCnt]["MarginPriceSub"];
                    DeleteFlag[trCnt] = estData[trCnt]["DeleteFlag"];

                    // 案件情報
                    RivalMaker[trCnt] = estData[trCnt]["RivalMaker"];
                    RivalSku[trCnt] = estData[trCnt]["RivalSku"];
                    RivalPrice[trCnt] = estData[trCnt]["RivalPrice"];
                    RivalOther[trCnt] = estData[trCnt]["RivalOther"];

                    NotCompletedReason1[trCnt] = estData[trCnt]["NotCompletedReason1"];
                    NotCompletedReason2[trCnt] = estData[trCnt]["NotCompletedReason2"];
                    NotCompletedReason3[trCnt] = estData[trCnt]["NotCompletedReason3"];
                    NotCompletedReason4[trCnt] = estData[trCnt]["NotCompletedReason4"];
                    NotCompletedReason5[trCnt] = estData[trCnt]["NotCompletedReason5"];
                    NotCompletedReason6[trCnt] = estData[trCnt]["NotCompletedReason6"];
                    NotCompletedReason7[trCnt] = estData[trCnt]["NotCompletedReason7"];
                    NotCompletedReason9[trCnt] = estData[trCnt]["NotCompletedReason9"];

                    LeaderPrice[trCnt] = estData[trCnt]["LeaderPrice"];
                    LeaderRate[trCnt] = estData[trCnt]["LeaderRate"];
                    CorrectionPrice[trCnt] = estData[trCnt]["CorrectionPrice"];
                    CorrectionRate[trCnt] = estData[trCnt]["CorrectionRate"];

                    if (estData[trCnt]["ConclusionStatusDetail"] == null || estData[trCnt]["ConclusionStatusDetail"] == "") {
                        ConclusionStatusDetail[trCnt] = "継続中";
                    } else {
                        ConclusionStatusDetail[trCnt] = estData[trCnt]["ConclusionStatusDetail"];
                    }

                    PurchaseComment[trCnt] = estData[trCnt]["PurchaseComment"];
                    DevLeaderComment[trCnt] = estData[trCnt]["DevLeaderComment"];

                    AutoAnswerFlag[trCnt] = estData[trCnt]["AutoAnswerFlag"];
                    ImportantFlag[trCnt] = estData[trCnt]["ImportantFlag"];
                }
            }
        }
    }

    //─────────────────────────────────────
    //機能： 取得データ表示
    //引数： 
    //戻値： 
    //補足： 
    //─────────────────────────────────────
    $.pageDisplay = function (cmtData) {
        ////////////////////////
        //    コメント部分
        ////////////////////////
        if (cmtData) {

            $("#CommentArea").children().remove();

            var comment_html = "";

            // ■ 商品コメントがあった場合表示
            comment_html += '<a id="SaveProductCommentBtn" href="javascript: estimateSystemDetailCommentBtn();">商品コメントを見る</a>';
            comment_html += '<div id="SaveProductCommentArea">';
            for (trCnt = 0; trCnt < cmtData.length; trCnt++) {
                comment_html += '<p class="comment_ttl">' + cmtData[trCnt]["CmtProduct"] + '</p><p>' + cmtData[trCnt]["Cmt"] + '</p>';
            }
            comment_html += '</div>';

            $("#CommentArea").append(comment_html);
        }


        ////////////////////////
        //    見積詳細部分
        ////////////////////////
        $("#estimate_detail_main").children().remove();

        var main_html = "";

        main_html += '<p><input type="button" value="<< 一覧へ戻る" onclick="location.href=\'../../Index.aspx\'" />';
        if (CheckNum != "") {
            main_html += '&nbsp;&nbsp;&nbsp; <input type="button" value="見積書発行" onclick="estimateSystemDetailIssue();" />';
        }
        if (TestMode) {
            main_html += '&nbsp;&nbsp;&nbsp; <input type="button" value="テストモード切替え" onclick="estimateSystemDetailTestDisp();" />';
        }
        main_html += '&nbsp;&nbsp;&nbsp; <input type="button" value="依頼番号取得" onclick="window.open(\'http://iw/getnum/main.asp\',\'iw\');" />';
        if (CheckNum != "") {
            main_html += '&nbsp;&nbsp;&nbsp; <input type="button" value="コピー" onclick="location.href=\'./Detail.aspx?cno=' + CheckNum + '&mode=copy\'" />';
        }
        main_html += '&nbsp;&nbsp;&nbsp; <input type="button" value="新規作成" onclick="location.href=\'./Detail.aspx\';" /></p >';

        if (ParentCheckNum != "" || ParentCheckNum == null) {
            // ◆◆◆ 成約状況 ◆◆◆ 
            if (ConclusionStatus == "継続中") {
                main_html += '  <p class="conclusion_area"><input type="button" class="status_select" value="継続中" />';
            } else {
                main_html += '  <p class="conclusion_area"><input type="button" value="継続中" onclick="estimateSystemDetailConclusionSave(\'継続中\');" />';
            }
            if (ConclusionStatus == "成約") {
                main_html += '    <input type="button" class="status_select" value="成約" />';
            } else {
                main_html += '    <input type="button" value="成約" onclick="estimateSystemDetailConclusionSave(\'成約\');" />';
            }
            if (ConclusionStatus == "一部成約") {
                main_html += '    <input type="button" class="status_select" value="一部成約" />';
            } else {
                main_html += '    <input type="button" value="一部成約" onclick="estimateSystemDetailConclusionSave(\'一部成約\');" />';
            }
            if (ConclusionStatus == "継続中") {
                main_html += '    <input type="button" class="status_select" value="不成約" /></p>';
            } else {
                main_html += '    <input type="button" value="不成約" onclick="estimateSystemDetailConclusionSave(\'不成約\');" /></p>';
            }
        }
        // ◆◆◆ 見積書情報 ◆◆◆ 
        main_html += '  <table class="index_data">';
        main_html += '    <tr>';
        main_html += '      <th width="100">見積状況：</th>';
        main_html += '      <td>' + Status + '</td>';
        main_html += '      <th width="100">最終更新日：</th>';
        main_html += '      <td width="180">' + UpdateTime + '</td>';
        main_html += '    </tr>';
        main_html += '    <tr>';
        main_html += '      <th>見積作成者：</th>';
        main_html += '      <td><input type="text" name="CreatePersonName" id="CreatePersonName" value="' + CreatePersonName + '" readonly /></td>';
        main_html += '      <th style="background-color: #DDD;">サンワCh表示：</th>';
        if (DispFlag == 0) {
            main_html += '      <td style="background-color: #DDD;"><label for="DispFlag0"><input type="radio" name="DispFlag" id="DispFlag0" value="0" checked /> 非表示</label>&nbsp;&nbsp;&nbsp;';
        } else {
            main_html += '      <td style="background-color: #DDD;"><label for="DispFlag0"><input type="radio" name="DispFlag" id="DispFlag0" value="0" /> 非表示</label>&nbsp;&nbsp;&nbsp;';
        }
        if (DispFlag == 1) {
            main_html += '                                          <label for="DispFlag1"><input type="radio" name="DispFlag" id="DispFlag1" value="1" checked /> 表示</label></td>';
        } else {
            main_html += '                                          <label for="DispFlag1"><input type="radio" name="DispFlag" id="DispFlag1" value="1" /> 表示</label></td>';
        }
        main_html += '    </tr>';
        main_html += '    <tr>';
        main_html += '      <th>見積書番号：</th>';
        main_html += '      <td><input type="text" name="CheckNum" id="CheckNum" value="' + CheckNum + '" readonly style="width:150px"/></td>';
        main_html += '      <th style="background-color: #DDD;">分割購入</th>';
        if (SanwaChOrderBreakFlag == 0) {
            main_html += '      <td style="background-color: #DDD;"><label for="SCOdrBrkFlg0"><input type="radio" name="SanwaChOrderBreakFlag" id="SCOdrBrkFlg0" value="0" checked /> 不可</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;';
        } else {
            main_html += '      <td style="background-color: #DDD;"><label for="SCOdrBrkFlg0"><input type="radio" name="SanwaChOrderBreakFlag" id="SCOdrBrkFlg0" value="0" /> 不可</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;';
        }
        if (SanwaChOrderBreakFlag == 1) {
            main_html += '                                          <label for="SCOdrBrkFlg1"><input type="radio" name="SanwaChOrderBreakFlag" id="SCOdrBrkFlg1" value="1" checked /> 可能</label></td>';
        } else {
            main_html += '                                          <label for="SCOdrBrkFlg1"><input type="radio" name="SanwaChOrderBreakFlag" id="SCOdrBrkFlg1" value="1" /> 可能</label></td>';
        }
        main_html += '    </tr>';
        main_html += '    <tr>';
        if (RICOHFlag == 0) {
            main_html += '      <th><span class="NoDisp" id="RicohNumTtl">ﾘｺｰ案件番号：</span></th>';
        } else {
            main_html += '      <th><span id="RicohNumTtl">ﾘｺｰ案件番号：</span></th>';
        }
        if (RICOHFlag == 0) {
            main_html += '      <td><input type="text" class="NoDisp" name="RicohNum" id="RicohNum" value="' + RicohNum + '" readonly /></td>';
        } else {
            main_html += '      <td><input type="text" name="RicohNum" id="RicohNum" value="' + RicohNum + '" readonly /></td>';
        }
        main_html += '      <th>引継後：<br />引継前：</th>';
        if (ParentCheckNum != "") {
            main_html += '      <td><a href="./detail.asp?cno=' + ParentCheckNum + '">' + ParentCheckNum + '</a><br />';
            if (ChildCheckNum != "") {
                main_html += ' <a href="./detail.asp?cno=' + ChildCheckNum + '">' + ChildCheckNum + '</a> </td > ';
            } else {
                main_html += ' 　</td > ';
            }
        } else {
            main_html += '      <td>　<br />';
            if (ChildCheckNum != "") {
                main_html += '  <a href="./detail.asp?cno=' + ChildCheckNum + '">' + ChildCheckNum + '</a></td > ';
            } else {
                main_html += '　</td > ';
            }
        }
        main_html += '    </tr>';
        main_html += '  </table>';

        // ◆◆◆ 顧客情報 ◆◆◆ 
        main_html += '  <p class="section_ttl">顧客情報</p>';
        main_html += '  <div class="customer_data">';
        main_html += '    <table class="customer_data_table">';
        main_html += '      <tr>';
        main_html += '        <th width="70">得意先CD</th>';
        main_html += '        <td width="380"><input type="text" name="CustomerCode" id="CustomerCode" value="' + CustomerCode + '" maxlength="10" /> <a href="javascript: estimateSystemCustomerSearch();">';
        main_html += '                        <img src="../../Img/search.png" width="16" height="17" class="search_icon" align="absmiddle" /></a > <a href="javascript: estimateSystemCustomerListOpen();">検索</a></td > ';
        main_html += '        <th width="70">得意先名</th>';
        if (TestMode) {
            main_html += '        <td><input type="text" name="CustomerName" id="CustomerName" value="' + CustomerName + '" maxlength="50" readonly /></td>';
        } else {
            main_html += '        <td><input type="text" name="CustomerName" id="CustomerName" value="' + CustomerName + '" maxlength="50"/></td>';
        }
        main_html += '      </tr>';
        if (TestMode) {
            main_html += '      <tr class="test">';
        } else {
            main_html += '      <tr>';
        }
        main_html += '        <th>支店名</th>';
        main_html += '        <td><input type="text" name="CustomerDivision" id="CustomerDivision" value="' + CustomerDivision + '" maxlength="45" /></td>';
        main_html += '        <th>担当者</th>';
        main_html += '        <td><input type="text" name="CustomerPersonName" id="CustomerPersonName" value="' + CustomerPersonName + '" maxlength="10" onkeydown="estimateSystemCursorPersonNext(event.keyCode);" /></td>';
        main_html += '      </tr>';
        main_html += '    </table>';
        if (TestMode) {
            main_html += '    <table class="customer_data_table2 test">';
        } else {
            main_html += '    <table class="customer_data_table2">';
        }
        main_html += '      <tr>';
        main_html += '        <th width="70">発行者</th>';
        main_html += '        <td width="380">営業CD <input type="text" name="SalesPersonCode" id="SalesPersonCode" value="' + SalesPersonCode + '" maxlength="10" onchange="estimateSystemSalesSearch(\'S\');" /> <input type="text" name="SalesPersonName" id="SalesPersonName" value="' + SalesPersonName + '" readonly /></td>';
        main_html += '        <th width="70">TEL</th>';
        main_html += '        <td><input type="text" name="Tel" id="Tel" value="' + Tel + '" maxlength="13" /></td>';
        main_html += '      </tr>';
        main_html += '      <tr>';
        main_html += '        <th></th>';
        main_html += '        <td>アシCD <input type="text" name="AssistantCode" id="AssistantCode" value="' + AssistantCode + '" maxlength="10" onchange="estimateSystemSalesSearch(\'A\');" /> <input type="text" name="AssistantName" id="AssistantName" value="' + AssistantName + '" readonly /></td>';
        main_html += '        <th>FAX</th>';
        main_html += '        <td><input type="text" name="Fax" id="Fax" value="' + Fax + '" maxlength="13" /></td>';
        main_html += '      </tr>';
        main_html += '    </table>';
        main_html += '  </div>';

        // ◆◆◆ 見積情報 ◆◆◆ 
        if (TestMode) {
            main_html += '  <p class="section_ttl test">見積情報</p>';
            main_html += '  <div class="head_data test">';
        } else {
            main_html += '  <p class="section_ttl">見積情報</p>';
            main_html += '  <div class="head_data">';
        }
        main_html += '    <table class="head_data_table">';
        main_html += '      <tr>';
        main_html += '        <th width="80">見積件名</th>';
        main_html += '        <td width="365"><input type="text" name="Title" id="Title" value="' + Title + '" maxlength="80" /></td>';
        main_html += '        <th width="95">配送費</th>';
        main_html += '        <td><input type="text" name="PackingFare" id="PackingFare" value="' + PackingFare + '" maxlength="50" />';
        main_html += '            <input type="button" value="定型1" onclick="estimateSystemDetailPackingFareForm(1);" />';
        main_html += '            <input type="button" value="定型2" onclick="estimateSystemDetailPackingFareForm(2);" /></td>';
        main_html += '      </tr>';
        main_html += '      <tr>';
        main_html += '        <th>納入期日</th>';
        main_html += '        <td><input type="text" name="DeliveryLimit" id="DeliveryLimit" value="' + DeliveryLimit + '" maxlength="50" /></td>';
        main_html += '        <th>搬入予定日</th>';
        main_html += '        <td><input type="text" name="DeliverySchedule" id="DeliverySchedule" value="' + DeliverySchedule + '" maxlength="50" /></td>';
        main_html += '      </tr>';
        main_html += '      <tr>';
        main_html += '        <th>納入場所</th>';
        main_html += '        <td><input type="text" name="DeliveryPlace" id="DeliveryPlace" value="' + DeliveryPlace + '" maxlength="50" /></td>';
        main_html += '        <th>見積有効期限</th>';
        main_html += '        <td><input type="text" name="EstimateLimit" id="EstimateLimit" value="' + EstimateLimit + '" maxlength="3" /> 日　表示用：<input type="text" name="EstimateLimitDisp" id="EstimateLimitDisp" value="' + EstimateLimitDisp + '" maxlength="20" /></td>';
        main_html += '      </tr>';
        main_html += '      <tr>';
        main_html += '        <th>見積書日付</th>';
        main_html += '        <td><input type="text" name="DisplayDate" id="DatePickBox1" value="' + DisplayDate + '" /> <input type="button" value="クリア" onclick="estimateSystemDispDateClear(1);" /></td>';
        main_html += '        <th>見積希望回答日</th>';
        main_html += '        <td><input type="text" name="ReplyDate" id="DatePickBox2" value="' + ReplyDate + '" /> <input type="button" value="クリア" onclick="estimateSystemDispDateClear(2);" /></td>';
        main_html += '      </tr>';
        main_html += '      <tr>';
        main_html += '        <th style="vertical-align: top;">備考 <input type="button" value="参照" onclick="estimateSystemTemplateCommentOpen();" /></th>';
        main_html += '        <td colspan="3"><textarea name="Other" id="Other">' + Other + '</textarea></td>';
        main_html += '      </tr>';
        main_html += '      <tr>';
        main_html += '        <th style="vertical-align: top;">メール文書</th>';
        main_html += '        <td colspan="3"><textarea name="FixMailBody" id="FixMailBody">' + FixMailBody + '</textarea><br />※ メール文書はサンワChからの依頼取込、またはアカウント連携後のサンワCh表示本登録時に送信されるメールへの差込文章になります。</td>';
        main_html += '      </tr>';

        main_html += '      <tr class="tr_sep">';
        main_html += '        <th>最終ユーザ名</th>';
        main_html += '        <td colspan="3"><input type="text" name="EndUserName" id="EndUserName" value="' + EndUserName + '" maxlength="50" />';
        main_html += '                        <input type="button" value="件名をコピー" onclick="estimateSystemDetailUserNameCopy();" /></td>';
        main_html += '      </tr>';
        main_html += '      <tr>';
        main_html += '        <th>エンドユーザー業種</th>';
        main_html += '        <td><select name="ProfessionClass2" id="ProfessionClass2">';
        main_html += '              <option value=""></option>';

        // 職業区分を表示
        var ProfessionList2 = PRO_LIST2.split(',');
        $.each(ProfessionList2,
            function (index, elem) {
                if (ProfessionClass2 == elem) {
                    main_html += '              <option value="' + elem + '" selected>' + elem + '</option>';
                } else {
                    main_html += '              <option value="' + elem + '">' + elem + '</option>';
                }
            }
        );
        main_html += '            </select></td>';
        main_html += '        <th>住所区分</th>';
        main_html += '        <td><select name="EndUserPref" id="EndUserPref">';
        main_html += '              <option value=""></option>';
        main_html += '              <optgroup label="北海道・東北">';

        // 都道府県をエリアにわけて表示
        var Pref = ARR_PREF.split(',');
        $.each(Pref,
            function (index, elem) {
                switch (elem) {
                    case "茨城県":
                        main_html += '              </optgroup>';
                        main_html += '              <optgroup label="関東">';
                        break;
                    case "新潟県":
                        main_html += '              </optgroup>';
                        main_html += '              <optgroup label="中部">';
                        break;
                    case "三重県":
                        main_html += '              </optgroup>';
                        main_html += '              <optgroup label="近畿">';
                        break;
                    case "鳥取県":
                        main_html += '              </optgroup>';
                        main_html += '              <optgroup label="中国">';
                        break;
                    case "徳島県":
                        main_html += '              </optgroup>';
                        main_html += '              <optgroup label="四国">';
                        break;
                    case "福岡県":
                        main_html += '              </optgroup>';
                        main_html += '              <optgroup label="九州・沖縄">';
                        break;
                }
                if (EndUserPref == elem) {
                    main_html += '                <option value="' + elem + '" selected>' + elem + '</option>';
                } else {
                    main_html += '                <option value="' + elem + '">' + elem + '</option>';
                }
            }
        );
        main_html += '              </optgroup>';
        main_html += '            </select>';
        main_html += '            <input type="text" name="EndUserAddress" id="EndUserAddress" placeholder="市区町村" value="' + EndUserAddress + '" maxlength="50" /></td>';
        main_html += '      </tr>';
        main_html += '      <tr>';
        main_html += '        <th style="vertical-align: top;">営業メモ<br />(非公開)</th>';
        main_html += '        <td colspan="3"><textarea name="SalesMemo" id="SalesMemo" placeholder="共有されない営業用のメモです。">' + SalesMemo + '</textarea></td>';
        main_html += '      </tr>';

        if (CheckNum != "") {
            main_html += '      <tr>';
            main_html += '        <td colspan="4" class="btn_area"><input type="button" value="最終ユーザ名・エンドユーザー業種・住所区分・メモ 保存" onclick="estimateSystemDetailMemoSave();" /></td>';
            main_html += '      </tr>';
        }
        main_html += '    </table>';
        main_html += '  </div>';

        // ■ 申請内容
        if (RequestNumber != "") {
            main_html += '  <p class="section_ttl">申請内容</p>';
            main_html += '  <div class="head_data">';
            main_html += '    <table class="head_data_table2">';
            main_html += '      <tr>';
            main_html += '        <th width="80">依頼番号</th>';
            main_html += '        <td width="370">' + RequestNumber + '</td>';
            main_html += '        <th width="80">依頼日</th>';
            main_html += '        <td>' + rRequestDate + '</td>';
            main_html += '      </tr>';
            main_html += '      <tr>';
            main_html += '        <th>会社名</th>';
            main_html += '        <td>' + rCompanyName + '</td>';
            main_html += '        <th>担当者名</th>';
            main_html += '        <td>' + rCustomerName + '</td>';
            main_html += '      </tr>';
            main_html += '      <tr>';
            main_html += '        <th>案件名</th>';
            main_html += '        <td>' + rTitle + '</td>';
            main_html += '        <th>希望回答日</th>';
            main_html += '        <td>' + rReplyDate + '</td>';
            main_html += '      </tr>';
            main_html += '      <tr>';
            main_html += '        <th>最終ユーザ</th>';
            main_html += '        <td>' + rEndUserName + '</td>';
            main_html += '        <th>納期希望</th>';
            main_html += '        <td>' + rDeliveryDate + '</td>';
            main_html += '      </tr>';
            main_html += '      <tr>';
            main_html += '        <th>申請内容</th>';
            main_html += '        <td><pre>' + rMemo + '</pre></td>';
            main_html += '        <th>ﾒｰﾙｱﾄﾞﾚｽ</th>';
            main_html += '        <td><a href="mailto:' + rMailAddress + '">' + rMailAddress + '</a></td>';
            main_html += '      </tr>';
            main_html += '    </table>';
            main_html += '  </div>';
        } else {
            // 申請内容が無い場合はログインIDを絡めるエリアを作成';
            if (TestMode) {
                main_html += '  <p class="section_ttl test">サンワCh アカウント連携</p>';
            } else {
                main_html += '  <p class="section_ttl">サンワCh アカウント連携</p>';
            }
            if (TestMode) {
                main_html += '  <div class="head_data test">';
            } else {
                main_html += '  <div class="head_data">';
            }
            main_html += '    <table class="head_data_table2">';
            main_html += '      <tr>';
            main_html += '        <th width="80">ログインID</th>';
            if (SanwaChLoginID == "") {
                main_html += '        <td>【 <a href="javascript: estimateSystemDetail3chIDSearch();" id="SCID">連携なし</a> 】<input type="hidden" name="SanwaChLoginID" id="SanwaChLoginID" value="' + SanwaChLoginID + '" /></td>';
            } else {
                main_html += '        <td>【 <a href="javascript: estimateSystemDetail3chIDSearch();" id="SCID">' + SanwaChLoginID + '</a> 】<input type="hidden" name="SanwaChLoginID" id="SanwaChLoginID" value="' + SanwaChLoginID + '" /></td>';
            }
            main_html += '      </tr>';
            main_html += '    </table>';
            main_html += '  </div>';
        }

        // ■ 継続案件・商品情報
        // ◆◆◆ 継続案件 ◆◆◆
        if (TestMode) {
            main_html += '  <p class="section_ttl test">継続案件</p>';
            main_html += '  <div class="head_data test">';
        } else {
            main_html += '  <p class="section_ttl">継続案件</p>';
            main_html += '  <div class="head_datat">';
        }
        main_html += '    <table class="head_data_table2">';
        main_html += '      <tr>';
        main_html += '        <th width="80">継続案件ﾌﾗｸﾞ</th>';
        main_html += '        <td width="200"><select name="ContinuationFlag" id="ContinuationFlag">';
        main_html += '                          <option value=""></option>';

        // ケースパターンを表示
        var CasePattern = CASE_PATTERN.split(',');
        $.each(CasePattern,
            function (index, elem) {
                if (ContinuationFlag == elem) {
                    main_html += '                          <option value="' + elem + '" selected>' + elem + '</option>';
                } else {
                    main_html += '                          <option value="' + elem + '">' + elem + '</option>';
                }
            }
        );
        main_html += '                        </select></td>';
        main_html += '        <th width="80">案件サイクル</th>';
        main_html += '        <td width="300"><input type="text" name="ContinuationCycle" id="ContinuationCycle" value="' + ContinuationCycle + '" maxlength="3" onfocus="this.select();" /> ヶ月</td>';
        main_html += '      </tr>';
        main_html += '      <tr>';
        main_html += '        <td colspan="3"></td>';
        if (CheckNum != "") {
            main_html += '        <td class="td_notice">※ 継続案件フラグが指定されている場合のみ通知されます</td>';
            main_html += '        <td class="cont_btn_area" width="320"><input type="button" value="継続情報のみ保存" onclick="estimateSystemDetailContSave();" /></td>';
            main_html += '        <td></td>';
        } else {
            main_html += '        <td colspan="3" class="td_notice">※ 継続案件フラグが指定されている場合のみ通知されます</td>';
            main_html += '        <td></td>';
        }
        main_html += '      </tr>';
        main_html += '    </table>';
        main_html += '  </div>';

        // ◆◆◆ グループ設定 ◆◆◆
        if (TestMode) {
            main_html += '  <p class="section_ttl test">グループ設定</p>';
            main_html += '  <div class="head_data test">';
        } else {
            main_html += '  <p class="section_ttl">グループ設定</p>';
            main_html += '  <div class="head_data">';
        }
        main_html += '    <table class="head_data_table2">';
        main_html += '      <tr>';
        main_html += '        <th width="80">グループ番号</th>';
        main_html += '        <td><input type="text" name="GroupNo" id="GroupNo" value="' + GroupNo + '" readonly /></td>';
        if (CheckNum != "") {
            main_html += '        <td rowspan="3" class="td_group_btn"><input type="button" value="グループ管理" onclick="estimateSystemGroupWindow();" /></td>';
        } else {
            main_html += '        <td rowspan="3" class="td_group_btn">※見積番号を発行後にグループ管理ができます<br />※先に仮登録、または本登録を行ってください</td>';
        }
        main_html += '      </tr>';
        main_html += '      <tr>';
        main_html += '        <th>グループ名</th>';
        main_html += '        <td><input type="text" name="GroupTitle" id="GroupTitle" value="' + GroupTitle + '" readonly /></td>';
        main_html += '      </tr>';
        main_html += '      <tr>';
        main_html += '        <th>案件リーダー</th>';
        main_html += '        <td><input type="text" name="GroupLeader" id="GroupLeader" value="' + GroupLeader + '" readonly /></td>';
        main_html += '      </tr>';
        main_html += '    </table>';
        main_html += '  </div>';

        // ◆◆◆ 案件情報 ◆◆◆
        if (TestMode) {
            main_html += '  <p class="section_ttl test">案件管理 ・・・ <label for="ProjectFlag"><input type="checkbox" name="ProjectFlag" id="ProjectFlag" value="1"';
        } else {
            main_html += '  <p class="section_ttl">案件管理 ・・・ <label for="ProjectFlag"><input type="checkbox" name="ProjectFlag" id="ProjectFlag" value="1"';
        }
        if (ProjectFlag == "1") {
            main_html += ' checked onclick="estimateSystemDetailProjectCheck();" /> する</label></p>';
        } else {
            main_html += '  onclick="estimateSystemDetailProjectCheck();" /> する</label></p>';
        }
        if (TestMode) {
            main_html += '  <div class="head_data project_data test">';
        } else {
            main_html += '  <div class="head_data project_data">';
        }
        main_html += '    <table class="head_data_table2">';
        main_html += '      <tr>';
        main_html += '        <th width="80">納期</th>';
        main_html += '        <td width="130"><input type="text" name="DeliveryLimitDate" id="DatePickBox3" value="' + DeliveryLimitDate + '" /></td>';
        main_html += '        <th width="90">お知らせメール</th>';
        main_html += '        <td width="120"><input type="text" name="AlertDate" id="DatePickBox5" value="' + AlertDate + '" /></td>';
        main_html += '        <th width="70">入札予定日</th>';
        main_html += '        <td colspan="2"><input type="text" name="ConclusionDate" id="ConclusionDate" value="' + ConclusionDate + '" maxlength="50" placeholder="YYYY/MM/DD 入力時3日前にメール自動配信有" /></td>';
        main_html += '      </tr>';
        main_html += '      <tr>';
        main_html += '        <th>納入方法</th>';
        main_html += '        <td colspan="4"><select name="DeliveryMethod" id="DeliveryMethod">';

        if (DeliveryMethod == "一括納入") {
            main_html += '              <option value="一括納入" selected>一括納入</option>';
        } else {
            main_html += '              <option value="一括納入">一括納入</option>';
        }
        if (DeliveryMethod == "分割納入") {
            main_html += '              <option value="分割納入" selected>分割納入</option>';
        } else {
            main_html += '              <option value="分割納入">分割納入</option>';
        }
        main_html += '            </select>';
        main_html += '            (';
        main_html += '              期間：<input type="text" name="DeliveryMethodPeriod" id="DeliveryMethodPeriod" value="' + DeliveryMethodPeriod + '" maxlength="20" />';
        main_html += '              回数：<input type="text" name="DeliveryMethodTimes" id="DeliveryMethodTimes" value="' + DeliveryMethodTimes + '" maxlength="20" />';
        main_html += '            )</td>';
        main_html += '        <td width="230"></td>';
        main_html += '        <td></td>';
        main_html += '      </tr>';
        main_html += '      <tr>';
        main_html += '        <th style="vertical-align: top;">メモ書き<br />(公開)</th>';
        main_html += '        <td colspan="5"><textarea name="Contents" id="Contents" placeholder="案件管理の際に各部署確認できるメモです。(仕入・開発・リーダー)">' + Contents + '</textarea></td>';
        if (CheckNum != "" && FixFlag == 1) {
            main_html += '        <td class="td_project_save"><input type="button" class="prj_save_btn" value="案件情報保存" onclick="estimateSystemDetailProjectSave();" title="見積番号は変更されず緑色になっている部分のみが保存されます。" /></td>';
        } else {
            main_html += '        <td class="td_project_save"></td>';
        }
        main_html += '      </tr>';
        main_html += '    </table>';
        main_html += '  </div>';

        $("#estimate_detail_main").append(main_html);


        ////////////////////////
        //    商品全体部分
        ////////////////////////
        $("#estimate_detail_product").children().remove();

        var product_html = "";
        product_html += '<p class="section_ttl">';
        product_html += '    商品情報';
        //product_html += '    <input type="button" value="リセット" id="btnReset" />';
        product_html += '    <input type="button" value="リセット" onclick="estimateSystemItemReset();" />';
        product_html += '    <input type="button" value="再提案" onclick="estimateSystemItemReCalc(\'normal\');" />';
        product_html += '    <input type="button" value="営業原価再提案" onclick="estimateSystemItemReCalc(\'genka\');" />';
        product_html += '    <input type="button" value="一括仕切設定" onclick="estimateSystemItemRateAllIn();" />';
        product_html += '    <input type="button" value="一括数量設定" onclick="estimateSystemItemAmountAllIn();" />';
        product_html += '    <input type="button" value="一括品番入力" onclick="estimateSystemItemAllIn();" />';
        product_html += '    <input type="button" value="通常仕切ｺﾋﾟｰ" onclick="estimateSystemItemPriceCopy();" />';
        product_html += '    <input type="button" value="一括仕切率計算" onclick="estimateSystemItemRateCalc();" />';
        product_html += '    <input type="button" value="データコピー" onclick="estimateSystemItemDataCopy();" />';
        product_html += '    <input type="button" value="在庫照会" onclick="estimateSystemItemInventOpen();" />';
        product_html += '</p>';
        product_html += '<div class="body_data">';
        product_html += '    <p style="margin: 5px 0 0 0;">';
        product_html += '        <b>合計金額 ： </b>';
        product_html += '        <input type="text" name="TotalPrice" id="TotalPrice" value="' + TotalPrice + '" readonly="" />';
        product_html += '    </p>';
        product_html += '    <!-- ★body_data_table1 START★ -->';
        product_html += '    <table class="body_data_table1">';
        product_html += '        <tr>';

        product_html += '            <td style="width: 120px">';
        product_html += '                <label for="TotalDispFlag">';
        if (TotalDispFlag == 1) {
            product_html += '                <input type="checkbox" name="TotalDispFlag" id="TotalDispFlag" value="1" checked /> 合計金額表示</label></td>';
        } else {
            product_html += '                <input type="checkbox" name="TotalDispFlag" id="TotalDispFlag" value="1" /> 合計金額表示</label></td>';
        }
        product_html += '            <td style="width: 100px">';
        product_html += '                <label for="TaxDispFlag">';
        if (TaxDispFlag == 1) {
            product_html += '                <input type="checkbox" name="TaxDispFlag" id="TaxDispFlag" value="1" checked onclick="estimateSystemTaxCheck(\'all\');" /> 税込表示</label></td>';
        } else {
            product_html += '                <input type="checkbox" name="TaxDispFlag" id="TaxDispFlag" value="1" onclick="estimateSystemTaxCheck(\'all\');" /> 税込表示</label></td>';
        }
        product_html += '            <td style="width: 170px">';
        product_html += '                <label for="TaxDispFlag2">';
        if (TaxDispFlag == 2) {
            product_html += '                <input type="checkbox" name="TaxDispFlag" id="TaxDispFlag2" value="2" checked onclick="estimateSystemTaxCheck(\'total\');" /> 税込表示(合計金額のみ)</label></td>';
        } else {
            product_html += '                <input type="checkbox" name="TaxDispFlag" id="TaxDispFlag2" value="2" onclick="estimateSystemTaxCheck(\'total\');" /> 税込表示(合計金額のみ)</label></td>';
        }
        product_html += '            <td style="width: 140px">税率：<select name="TaxPercent" id="TaxPercent" onchange="estimateSystemDetailTaxChange(\'\');">';
        if (TaxPercent == 5) {
            product_html += '                <option value="5" selected>5%</option>';
        } else {
            product_html += '                <option value="5">5%</option>';
        }
        if (TaxPercent == 8) {
            product_html += '                <option value="8" selected>8%</option>';
        } else {
            product_html += '                <option value="8">8%</option>';
        }
        if (TaxPercent == 10) {
            product_html += '                <option value="10" selected="selected">10%</option>';
        } else {
            product_html += '                <option value="10">10%</option>';
        }
        product_html += '            </select></td>';

        product_html += '            <td style="width: 400px"><b>オープンプライス ： </b>';
        product_html += '                <label for="OpenPrice0">';
        if (OpenPriceDisp == 0) {
            product_html += '                <input type="radio" name="OpenPrice" id="OpenPrice0" value="0" checked /> オープンと表示</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;';
        } else {
            product_html += '                <input type="radio" name="OpenPrice" id="OpenPrice0" value="0" /> オープンと表示</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;';
        }
        product_html += '                <label for="OpenPrice1">';
        if (OpenPriceDisp == 1) {
            product_html += '                <input type="radio" name="OpenPrice" id="OpenPrice1" value="1" checked /> 参考定価を表示</label></td>';
        } else {
            product_html += '                <input type="radio" name="OpenPrice" id="OpenPrice1" value="1" /> 参考定価を表示</label></td>';
        }
        product_html += '            <td><b>定価・仕切率 ： </b>';
        product_html += '                <label for="NoPriceDisp">';
        if (NoPriceDisp == 1) {
            product_html += '                <input type="checkbox" name="NoPriceDisp" id="NoPriceDisp" value="1" checked /> 表示しない</label></td>';
        } else {
            product_html += '                <input type="checkbox" name="NoPriceDisp" id="NoPriceDisp" value="1" /> 表示しない</label></td>';
        }
        product_html += '        </tr>';
        product_html += '    </table>';
        product_html += '    <!-- ★body_data_table1 END★ -->';

        // 商品明細表示部
        product_html += '    <!-- ★body_data_table2 START★ -->';
        product_html += '    <div id="body_data_table2" runat="server"></div>';
        product_html += '    <!-- ★body_data_table2 END★ -->';

        product_html += '    <p id="DetailAddBtn">';
        product_html += '        <input type="button" value="+ 行追加" onclick="estimateSystemDetailAddLine()" />';
        product_html += '    </p>';
        product_html += '    <input type="hidden" name="NowDispMax" id="NowDispMax" value="" />';
        product_html += '</div>';

        $("#estimate_detail_product").append(product_html);


        ////////////////////////
        //    商品明細部分
        ////////////////////////
        $("#body_data_table2").children().remove();

        var table_html = "";
        // ヘッダー部分
        table_html += '<table class="body_data_table2">';
        table_html += '    <tr>';
        table_html += '        <th style="width: 35px">削除</th>';
        table_html += '        <th style="width: 170px">型番<br />';
        table_html += '            品名<br />';
        table_html += '            在庫状況</th>';
        table_html += '        <th style="width: 25px">Op<br />';
        table_html += '            en</th>';
        table_html += '        <th style="width: 75px">定価<br />';
        table_html += '            通常仕切<br />';
        table_html += '            通常仕切率</th>';
        table_html += '        <th style="width: 75px">仕切率<br />';
        table_html += '            仕切価格</th>';
        table_html += '        <th style="width: 60px">数量</th>';
        table_html += '        <th style="width: 75px">小計</th>';
        table_html += '        <th>納期';
        table_html += '            <input type="button" value="一括コピー" onclick="estimateSystemDetailNoukiCopy();" /><br />';
        table_html += '            メモ</th>';
        table_html += '        <th style="width: 75px">営業原価<br />粗利<br />リミット単価</th>';
        table_html += '        <th style="width: 75px">粗利計<br />粗利率</th>';
        table_html += '        <th style="width: 25px">判<br />定</th>';
        table_html += '        <th style="width: 265px" class="th_project">納期(仕入)';
        if (CheckNum != "" && ProjectFlag == "1") {
            table_html += '        <label for= "ReAnswerFlag" > <input type="checkbox" name="ReAnswerFlag" id="ReAnswerFlag" value="1" onclick="estimateSystemDetailReAnswerCheck();" />';
            table_html += '        再回答依頼</label > <br />';
        }
        table_html += '            メッセージ(開発・リーダー)</th>';
        table_html += '        <th style="width: 100px" class="th_project">成否';
        if (CheckNum != "" && (ParentCheckNum == "" || ParentCheckNum == null)) {
            table_html += '        <br /><input type="button" id="all_seiyaku" value="成約" />&nbsp;<input type="button" id="all_fuseiyaku" value="不成約" />';
        }
        table_html += '        </th>';
        table_html += '        <th style="width: 165px" class="th_project">その他情報</th>';
        table_html += '        <th style="width: 160px" class="th_project">競合状況</th>';
        table_html += '        <th style="width: 75px" class="th_project">リーダー<br />';
        table_html += '            回答仕切<br />';
        table_html += '            回答仕切率</th>';
        table_html += '        <th style="width: 75px" class="th_project">原価訂正</th>';
        table_html += '        <th style="width: 200px" class="th_project">不成約理由<br />';
        table_html += '            <input type="button" value="一括コピー" onclick="estimateSystemDetailNotCompletedReasonCopy();" /></th>';
        table_html += '    </tr>';

        // ボディ部分
        for (trCnt = 1; trCnt <= NowDispMax; trCnt++) {
            var DetailLineClass = "";

            if (DeleteFlag[trCnt - 1] == 1) {
                DetailLineClass = "tr_delete";
            }

            if (DetailLineClass != "") {
                table_html += '  <tr id="Column_' + trCnt + '" class="' + DetailLineClass + '">';
            } else {
                table_html += '  <tr id="Column_' + trCnt + '">';
            }
            table_html += '    <td><input type="text" class="ColumnNo" name="ColumnNo' + trCnt + '" id="ColumnNo' + trCnt + '" value="' + trCnt + '" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(' + trCnt + ');" maxlength="3" /><br />';
            if (DeleteFlag[trCnt - 1] == 1) {
                table_html += '        <input type="checkbox" name="DeleteCheck' + trCnt + '" id="DeleteCheck' + trCnt + '" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk(\' ' + trCnt + ' \');" checked /><br />';
            } else {
                table_html += '        <input type="checkbox" name="DeleteCheck' + trCnt + '" id="DeleteCheck' + trCnt + '" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk(\' ' + trCnt + ' \');" /><br />';
            }
            table_html += '        <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(' + trCnt + ');" /></td>';
            table_html += '    <td>';
            table_html += '      <p><input type="text" class="ProductCode2" name="ProductCode' + trCnt + '" id="ProductCode' + trCnt + '" value="' + ProductCode[trCnt - 1] + '" maxlength="20" onchange="estimateSystemProductSearch(' + trCnt + ');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> ';
            if (OutletFlag[trCnt - 1] == "1") {
                table_html += '      <input type="checkbox" name="OutletCheck' + trCnt + '" id="OutletCheck' + trCnt + '" value="1" onclick="estimateSystemOutletChack(' + trCnt + ');" title="アウトレットフラグ" checked /><input type="hidden" name="FeeFlag' + trCnt + '" id="FeeFlag' + trCnt + '" value="' + FeeFlag[trCnt - 1] + '" / > <input type="hidden" name="SuperBigFlag' + trCnt + '" id="SuperBigFlag' + trCnt + '" value="' + SuperBigFlag[trCnt - 1] + '" /></p > ';
            } else {
                table_html += '      <input type="checkbox" name="OutletCheck' + trCnt + '" id="OutletCheck' + trCnt + '" value="1" onclick="estimateSystemOutletChack(' + trCnt + ');" title="アウトレットフラグ"d /><input type="hidden" name="FeeFlag' + trCnt + '" id="FeeFlag' + trCnt + '" value="' + FeeFlag[trCnt - 1] + '" / > <input type="hidden" name="SuperBigFlag' + trCnt + '" id="SuperBigFlag' + trCnt + '" value="' + SuperBigFlag[trCnt - 1] + '" /></p > ';
            }
            if (Haishi[trCnt - 1] == 1) {
                table_html += '      <p><input type="text" class="ProductName" style="color: #F00;" name="ProductName' + trCnt + '" id="ProductName' + trCnt + '" value="' + ProductName[trCnt - 1] + '" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>';
            } else {
                table_html += '      <p><input type="text" class="ProductName" style="color: #000;" name="ProductName' + trCnt + '" id="ProductName' + trCnt + '" value="' + ProductName[trCnt - 1] + '" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>';
            }
            if (RICOHFlag == 0) {
                table_html += '      <p class="NoDisp" id="RCodeLine' + trCnt + '">Rコード <input type="text" class="ProductCode3" name="RCode' + trCnt + '" id="RCode' + trCnt + '" value="' + RCode[trCnt - 1] + '" maxlength="6" onchange="estimateSystemProductSearchRICOH(' + trCnt + ');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>';
            } else {
                table_html += '      <p id="RCodeLine' + trCnt + '">Rコード <input type="text" class="ProductCode3" name="RCode' + trCnt + '" id="RCode' + trCnt + '" value="' + RCode[trCnt - 1] + '" maxlength="6" onchange="estimateSystemProductSearchRICOH(' + trCnt + ');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>';
            }
            table_html += '      <p class="InventoryArea" id="InventoryArea' + trCnt + '">' + Inventory[trCnt - 1] + '<div class="InventoryLayer" id="InventoryLayer' + trCnt + '">' + Inventory2[trCnt - 1] + '</div></p>';
            table_html += '    </td>';
            if (OpenPrice[trCnt - 1] == "1") {
                table_html += '    <td><input type="checkbox" name="OpenCheck' + trCnt + '" id="OpenCheck' + trCnt + '" value="1" checked /></td>';
            } else {
                table_html += '    <td><input type="checkbox" name="OpenCheck' + trCnt + '" id="OpenCheck' + trCnt + '" value="1" /></td>';
            }
            table_html += '    <td>';
            table_html += '      <p><input type="text" class="PriceBox" name="RegularPrice' + trCnt + '" id="RegularPrice' + trCnt + '" value="' + RegularPrice[trCnt - 1] + '" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>';
            table_html += '      <p><input type="text" class="PriceBox" name="NormalPrice' + trCnt + '" id="NormalPrice' + trCnt + '" value="' + NormalPrice[trCnt - 1] + '" readonly onfocus="estimateSystemCursorAdvance(\'normal\',' + trCnt + ');" /></p>';
            table_html += '      <p><input type="text" class="PercentBox" name="NormalRate' + trCnt + '" id="NormalRate' + trCnt + '" value="' + NormalRate[trCnt - 1] + '" readonly onfocus="estimateSystemCursorAdvance(\'normal\',' + trCnt + ');" />%</p>';
            table_html += '    </td>';
            table_html += '    <td>';
            table_html += '      <p><input type="text" class="PercentBox" name="UnitRate' + trCnt + '" id="UnitRate' + trCnt + '" value="' + UnitRate[trCnt - 1] + '" maxlength="5" onchange="estimateSystemUnitPercent(' + trCnt + ', \'率\');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>';
            table_html += '      <p><input type="text" class="PriceBox" name="UnitPrice' + trCnt + '" id="UnitPrice' + trCnt + '" value="' + UnitPrice[trCnt - 1] + '" maxlength="10" onchange="estimateSystemUnitPercent(' + trCnt + ', \'価格\');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>';
            table_html += '    </td>';
            table_html += '    <td><input type="number" class="AmountBox" name="Quantity' + trCnt + '" id="Quantity' + trCnt + '" value="' + Quantity[trCnt - 1] + '" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(' + trCnt + '); estimateSystemCursorColorDisable(this.id);" /></td>';
            table_html += '    <td><input type="text" class="PriceBox" name="SubTotalPrice' + trCnt + '" id="SubTotalPrice' + trCnt + '" value="' + SubTotalPrice[trCnt - 1] + '" readonly onfocus="estimateSystemCursorAdvance(\'sub\',' + trCnt + ');" /></td>';
            table_html += '    <td>';
            table_html += '      <p><input type="text" class="CommentBox" name="DeliveryTime' + trCnt + '" id="DeliveryTime' + trCnt + '" value="' + DeliveryTime[trCnt - 1] + '" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" title="全角20文字程度" /></p>';
            table_html += '      <p><input type="text" class="CommentBox" name="Memo' + trCnt + '" id="Memo' + trCnt + '" value="' + Memo[trCnt - 1] + '" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" title="全角40文字程度" /></p>';
            if (FeeFlag[trCnt - 1] == "1" || FeeFlag[trCnt - 1] == "2") {
                table_html += '      <p class="ProductNotice" id="ProductNotice' + trCnt + '">★大物商品</p>';
            } else {
                if (SuperBigFlag[trCnt - 1] == "1") {
                    table_html += '      <p class="ProductNotice" id="ProductNotice' + trCnt + '">★車上渡し商品</p>';
                } else {
                    table_html += '      <p class="ProductNotice" id="ProductNotice' + trCnt + '"></p>';
                }
            }
            table_html += '    </td>';
            table_html += '    <td>';
            table_html += '      <p><input type="text" class="PriceBox" name="EigyouGenka' + trCnt + '" id="EigyouGenka' + trCnt + '" value="' + EigyouGenka[trCnt - 1] + '" readonly onfocus="estimateSystemCursorAdvance(\'next\',' + trCnt + ');" /></p>';
            table_html += '      <p><input type="text" class="PriceBox" name="MarginPrice' + trCnt + '" id="MarginPrice' + trCnt + '" value="' + MarginPrice[trCnt - 1] + '" readonly onfocus="estimateSystemCursorAdvance(\'next\',' + trCnt + ');" /></p>';
            table_html += '      <p><input type="text" class="LimitBox" name="LimitPrice' + trCnt + '" id="LimitPrice' + trCnt + '" value="' + LimitPrice[trCnt - 1] + '" readonly onfocus="estimateSystemCursorAdvance(\'next\',' + trCnt + ');" /></p>';
            table_html += '    </td>';
            table_html += '    <td>';
            table_html += '      <p><input type="text" class="PriceBox" name="MarginTotal' + trCnt + '" id="MarginTotal' + trCnt + '" value="' + MarginPriceSub[trCnt - 1] + '" readonly onfocus="estimateSystemCursorAdvance(\'next\',' + trCnt + ');" /></p>';
            table_html += '      <p><input type="text" class="PercentBox" name="MarginRate' + trCnt + '" id="MarginRate' + trCnt + '" value="' + MarginRate[trCnt - 1] + '" readonly onfocus="estimateSystemCursorAdvance(\'next\',' + trCnt + ');" />%</p>';
            table_html += '    </td>';
            table_html += '    <td id="MarginRank' + trCnt + '">' + MarginRank[trCnt - 1] + '</td>';
            table_html += '    <td class="td_project">';
            table_html += '      <p><textarea class="TextBox2" name="PurchaseComment' + trCnt + '" id="PurchaseComment' + trCnt + '" readonly>' + PurchaseComment[trCnt - 1] + '</textarea></p>';
            table_html += '      <p><textarea class="TextBox2" name="DevLeaderComment' + trCnt + '" id="DevLeaderComment' + trCnt + '" readonly>' + DevLeaderComment[trCnt - 1] + '</textarea><input type="hidden" name="AutoAnswerFlag' + trCnt + '" id="AutoAnswerFlag' + trCnt + '" value="' + AutoAnswerFlag[trCnt - 1] + '" /><input type="hidden" name="ImportantFlag' + trCnt + '" id="ImportantFlag' + trCnt + '" value="' + ImportantFlag[trCnt - 1] + '" /></p>';
            table_html += '    </td>';
            if (FixFlag == 1 && (ParentCheckNum == "" || ParentCheckNum == null) && ConclusionStatusDetail[trCnt - 1] != "") {
                table_html += '    <td class="td_project"><input type="button" class="con_btn" id="ConclusionStatusDetailBtn' + trCnt + '" value="' + ConclusionStatusDetail[trCnt - 1] + '" onclick="estimateSystemDetailConclusionChange(\' ' + trCnt + ' \');" data-conclusion /><input type="hidden" name="ConclusionStatusDetail' + trCnt + '" id="ConclusionStatusDetail' + trCnt + '" value="' + ConclusionStatusDetail[trCnt - 1] + '" data-conclusion /></td>';
            } else {
                table_html += '    <td class="td_project"></td>';
            }
            table_html += '    <td class="td_project"><textarea class="TextBox1" name="RivalOther' + trCnt + '" id="RivalOther' + trCnt + '" placeholder="仕入へのメッセージなど">' + RivalOther[trCnt - 1] + '</textarea></td>';
            table_html += '    <td class="td_project">';
            table_html += '      <p><input type="text" class="CommentBox" name="RivalMaker' + trCnt + '" id="RivalMaker' + trCnt + '" value="' + RivalMaker[trCnt - 1] + '" placeholder="メーカー" /></p>';
            table_html += '      <p><input type="text" class="CommentBox" name="RivalSku' + trCnt + '" id="RivalSku' + trCnt + '" value="' + RivalSku[trCnt - 1] + '" placeholder="品番" /></p>';
            table_html += '      <p><input type="text" class="CommentBox" name="RivalPrice' + trCnt + '" id="RivalPrice' + trCnt + '" value="' + RivalPrice[trCnt - 1] + '" placeholder="価格" /></p>';
            table_html += '    </td>';
            table_html += '    <td class="td_project">';
            table_html += '      <p><input type="text" class="PriceBox" name="LeaderPrice' + trCnt + '" id="LeaderPrice' + trCnt + '" value="' + LeaderPrice[trCnt - 1] + '" readonly onfocus="estimateSystemCursorAdvance(\'quantity\',' + trCnt + ');" /></p>';
            table_html += '      <p><input type="text" class="PercentBox" name="LeaderRate' + trCnt + '" id="LeaderRate' + trCnt + '" value="' + LeaderRate[trCnt - 1] + '" readonly onfocus="estimateSystemCursorAdvance(\'quantity\',' + trCnt + ');" />%</p>';
            table_html += '    </td>';
            table_html += '    <td class="td_project">';
            table_html += '      <p><input type="text" class="PriceBox" name="CorrectionPrice' + trCnt + '" id="CorrectionPrice' + trCnt + '" value="' + CorrectionPrice[trCnt - 1] + '" readonly onfocus="estimateSystemCursorAdvance(\'next\',' + trCnt + ');" /></p>';
            table_html += '      <p><input type="text" class="PercentBox" name="CorrectionRate' + trCnt + '" id="CorrectionRate' + trCnt + '" value="' + CorrectionRate[trCnt - 1] + '" readonly onfocus="estimateSystemCursorAdvance(\'next\',' + trCnt + ');" />%</p>';
            table_html += '    </td>';
            table_html += '    <td class="td_project">';
            if (FixFlag == 1 && (ParentCheckNum == "" || ParentCheckNum == null) && ConclusionStatusDetail[trCnt - 1] != "") {
                table_html += '      <ul class="not_completed_reason">';
                if (NotCompletedReason1[trCnt - 1] == "1") {
                    table_html += '        <li><label for="NotCompletedReason1_' + trCnt + '"><input type="checkbox" name="NotCompletedReason1_' + trCnt + '" id="NotCompletedReason1_' + trCnt + '" value="1" checked /> 価格</label></li>';
                } else {
                    table_html += '        <li><label for="NotCompletedReason1_' + trCnt + '"><input type="checkbox" name="NotCompletedReason1_' + trCnt + '" id="NotCompletedReason1_' + trCnt + '" value="1" /> 価格</label></li>';
                }
                if (NotCompletedReason2[trCnt - 1] == "1") {
                    table_html += '        <li><label for="NotCompletedReason2_' + trCnt + '"><input type="checkbox" name="NotCompletedReason2_' + trCnt + '" id="NotCompletedReason2_' + trCnt + '" value="1" checked /> 納期</label></li>';
                } else {
                    table_html += '        <li><label for="NotCompletedReason2_' + trCnt + '"><input type="checkbox" name="NotCompletedReason2_' + trCnt + '" id="NotCompletedReason2_' + trCnt + '" value="1" /> 納期</label></li>';
                }
                if (NotCompletedReason3[trCnt - 1] == "1") {
                    table_html += '        <li><label for="NotCompletedReason3_' + trCnt + '"><input type="checkbox" name="NotCompletedReason3_' + trCnt + '" id="NotCompletedReason3_' + trCnt + '" value="1" checked /> 本体ありき</label></li>';
                } else {
                    table_html += '        <li><label for="NotCompletedReason3_' + trCnt + '"><input type="checkbox" name="NotCompletedReason3_' + trCnt + '" id="NotCompletedReason3_' + trCnt + '" value="1" /> 本体ありき</label></li>';
                }
                if (NotCompletedReason4[trCnt - 1] == "1") {
                    table_html += '        <li><label for="NotCompletedReason4_' + trCnt + '"><input type="checkbox" name="NotCompletedReason4_' + trCnt + '" id="NotCompletedReason4_' + trCnt + '" value="1" checked /> 仕様あわず</label></li>';
                } else {
                    table_html += '        <li><label for="NotCompletedReason4_' + trCnt + '"><input type="checkbox" name="NotCompletedReason4_' + trCnt + '" id="NotCompletedReason4_' + trCnt + '" value="1" /> 仕様あわず</label></li>';
                }
                if (NotCompletedReason5[trCnt - 1] == "1") {
                    table_html += '        <li><label for="NotCompletedReason5_' + trCnt + '"><input type="checkbox" name="NotCompletedReason5_' + trCnt + '" id="NotCompletedReason5_' + trCnt + '" value="1" checked /> 販社辞退</label></li>';
                } else {
                    table_html += '        <li><label for="NotCompletedReason5_' + trCnt + '"><input type="checkbox" name="NotCompletedReason5_' + trCnt + '" id="NotCompletedReason5_' + trCnt + '" value="1" /> 販社辞退</label></li>';
                }
                if (NotCompletedReason6[trCnt - 1] == "1") {
                    table_html += '        <li><label for="NotCompletedReason6_' + trCnt + '"><input type="checkbox" name="NotCompletedReason6_' + trCnt + '" id="NotCompletedReason6_' + trCnt + '" value="1" checked /> 社内競合</label></li>';
                } else {
                    table_html += '        <li><label for="NotCompletedReason6_' + trCnt + '"><input type="checkbox" name="NotCompletedReason6_' + trCnt + '" id="NotCompletedReason6_' + trCnt + '" value="1" /> 社内競合</label></li>';
                }
                if (NotCompletedReason7[trCnt - 1] == "1") {
                    table_html += '        <li><label for="NotCompletedReason7_' + trCnt + '"><input type="checkbox" name="NotCompletedReason7_' + trCnt + '" id="NotCompletedReason7_' + trCnt + '" value="1" checked /> 型番数量違い</label></li>';
                } else {
                    table_html += '        <li><label for="NotCompletedReason7_' + trCnt + '"><input type="checkbox" name="NotCompletedReason7_' + trCnt + '" id="NotCompletedReason7_' + trCnt + '" value="1" /> 型番数量違い</label></li>';
                }
                if (NotCompletedReason9[trCnt - 1] == "1") {
                    table_html += '        <li><label for="NotCompletedReason9_' + trCnt + '"><input type="checkbox" name="NotCompletedReason9_' + trCnt + '" id="NotCompletedReason9_' + trCnt + '" value="1" checked /> その他</label></li>';
                } else {
                    table_html += '        <li><label for="NotCompletedReason9_' + trCnt + '"><input type="checkbox" name="NotCompletedReason9_' + trCnt + '" id="NotCompletedReason9_' + trCnt + '" value="1" /> その他</label></li>';
                }
                table_html += '      </ul>';
            }
            table_html += '    </td>';
            table_html += '  </tr>';

            if (Quantity[trCnt - 1] != "") {
                TotalQuantity = TotalQuantity + Quantity[trCnt - 1]

                if (FeeFlag[trCnt - 1] == "1") {
                    TotalFee = TotalFee + Quantity[trCnt - 1]
                }
            }
        }

        table_html += '<tr>';
        table_html += '    <td colspan="5" class="td_total">合計</td>';
        table_html += '    <td><input type="text" class="PercentBox" name="TotalQuantity" id="TotalQuantity" value="' + TotalQuantity + '" readonly /></td>';
        table_html += '    <td><input type="text" class="PriceBox" name="UnderTotalPrice" id="UnderTotalPrice" value="' + TotalPrice + '" readonly /></td>';
        table_html += '    <td colspan="2">大物送料対象：<input type="text" class="PriceBox" name="TotalFee" id="TotalFee" value="' + TotalFee + '" readonly /></td>';
        table_html += '    <td>';
        table_html += '        <p><input type="text" class="PriceBox" name="MarginTotalTotal" id="MarginTotalTotal" value="' + MarginPriceSum + '" readonly /></p>';
        table_html += '        <p><input type="text" class="PercentBox" name="MarginRateTotal" id="MarginRateTotal" value="' + MarginRateSum + '" readonly />%</p>';
        table_html += '    </td>';
        table_html += '    <td id="MarginRankTotal">' + MarginRankSum + '</td>';
        table_html += '    <td colspan="7"></td>';
        table_html += '</tr>';

        table_html += '</table>';

        $("#body_data_table2").append(table_html);


        /////////////////////////
        //    保存ボタン部分
        /////////////////////////
        var BtnValue;
        var ErFlag = 0;

        $("#detail_btn").children().remove();

        // 特殊要件：3chアラート
        if ($("#EstPersonCode").val() == "00009953" || $("#EstPersonCode").val() == "00009687" || $("#EstPersonCode").val() == "00010773") {
            ErFlag = 1;
        }

        // ◆◆◆ 各種ボタン ◆◆◆
        if (CheckNum != "") {
            if (FixFlag == 0) {
                // 仮登録データ
                BtnValue = '<input type="button" class="copy_btn" value="コピー" onclick="estimateSystemDetailCopy(\'' + CheckNum + '\');" />&nbsp;&nbsp;&nbsp;&nbsp;';
                BtnValue += '<input type="button" class="issue_btn" value="発行" onclick="estimateSystemDetailIssue();" />&nbsp;&nbsp;&nbsp;&nbsp;';
                BtnValue += '<input type="button" class="issue_btn" value="CSV" onclick="estimateSystemDetailCSVDL();" />&nbsp;&nbsp;&nbsp;&nbsp;';

                BtnValue += '<input type="button" class="save_btn" value="保存" onclick="estimateSystemDetailSave(\'\',\'仮\',\'' + ErFlag + '\');" />&nbsp;&nbsp;&nbsp;&nbsp;';
                BtnValue += '<input type="button" class="save_btn" value="本登録" onclick="estimateSystemDetailSave(\'\',\'本\',\'' + ErFlag + '\');" />';
            } else {
                // 請求書発行ボタン
                BtnValue = '<input type="button" class="bill_btn" value="請求書発行 &#13;&#10; (先入金用)" onclick="estimateSystemDetailIssue(\'bill\'); " />&nbsp;&nbsp;&nbsp;&nbsp;';
                BtnValue += '<input type="button" class="copy_btn" value="コピー" onclick="estimateSystemDetailCopy(\'' + CheckNum + '\');" />&nbsp;&nbsp;&nbsp;&nbsp;';
                BtnValue += '<input type="button" class="issue_btn" value="発行" onclick="estimateSystemDetailIssue();" />&nbsp;&nbsp;&nbsp;&nbsp;';
                BtnValue += '<input type="button" class="issue_btn" value="CSV" onclick="estimateSystemDetailCSVDL();" />&nbsp;&nbsp;&nbsp;&nbsp;';
                // 本登録データ
                BtnValue += '<input type="button" class="save_btn" value="引継いで仮登録" onclick="estimateSystemDetailSave(\'継\',\'仮\',\'' + ErFlag + '\');" />&nbsp;&nbsp;&nbsp;&nbsp;';
                BtnValue += '<input type="button" class="save_btn" value="引継いで本登録" onclick="estimateSystemDetailSave(\'継\',\'本\',\'' + ErFlag + '\');" />&nbsp;&nbsp;&nbsp;&nbsp;';
                BtnValue += '<input type="button" class="prj_save_btn" value="案件情報保存" onclick="estimateSystemDetailProjectSave();" title="見積番号は変更されず緑色になっている部分のみが保存されます。" />';
            }
        } else {
            // 新規登録 or コピーデータ
            BtnValue = '<input type="button" class="save_btn" value="仮登録" onclick="estimateSystemDetailSave(\'\', \'仮\', \'' + ErFlag + '\'); " />&nbsp;&nbsp;&nbsp;&nbsp;';
            BtnValue += '<input type="button" class="save_btn" value="本登録" onclick="estimateSystemDetailSave(\'\', \'本\', \'' + ErFlag + '\'); " />';
        }

        var button_html = "";

        if (TestMode) {
            button_html = '<p class="button_area test">' + BtnValue + '</p>';
            button_html += '<p class="mail_area test<label for="ProjectMailFlag">案件メールを送信する(開発・仕入・リーダー)';
        } else {
            button_html = '<p class="button_area">' + BtnValue + '</p>';
            button_html += '<p class="mail_area"><label for="ProjectMailFlag">案件メールを送信する(開発・仕入・リーダー)';
        }
        if (ProjectMailSubmitFlag == "1") {
            button_html += '<span style="color: #0A0; font-weight: bold;">【送信済】</span>';
        }
        button_html += '<input type="checkbox" name="ProjectMailFlag" id="ProjectMailFlag" value="1" onclick="estimateSystemDetailProjectMailToggle(\'Project\');" /></label ></p >';
        if (FixFlag == 1 && (ParentCheckNum == "" || ParentCheckNum == null)) {
            if (TestMode) {
                button_html += '<p class="mail_area2 test"><label for="ConclusionMailFlag">成約状況メールを送信する(仕入)';
            } else {
                button_html += '<p class="mail_area2"><label for="ConclusionMailFlag">成約状況メールを送信する(仕入)';
            }
            if (ProjectMailSubmitFlag == "1") {
                button_html += '<span style="color: #0A0; font-weight: bold;">【送信済】</span>';
            }
            button_html += '<input type="checkbox" name="ConclusionMailFlag" id="ConclusionMailFlag" value="1" onclick="estimateSystemDetailProjectMailToggle(\'Conclusion\');" /></label></p>';
        }
        button_html += '<p class="mail_notice">※メール送信は案件管理している場合のみ有効です。</p>';

        $("#detail_btn").append(button_html);

        return false;
    }
});


// 詳細画面の明細行追加
function estimateSystemDetailAddLine() {
    $.pageInitMain();
    var trCnt = $("#body_data_table2 tr").length - 1;
    var table_html = "";

    table_html += '  <tr id="Column_' + trCnt + '">';
    table_html += '    <td><input type="text" class="ColumnNo" name="ColumnNo' + trCnt + '" id="ColumnNo' + trCnt + '" value="' + trCnt + '" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(' + trCnt + ');" maxlength="3" /><br />';
    table_html += '        <input type="checkbox" name="DeleteCheck' + trCnt + '" id="DeleteCheck' + trCnt + '" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk(\' ' + trCnt + ' \');" /><br />';
    table_html += '        <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(' + trCnt + ');" /></td>';
    table_html += '    <td>';
    table_html += '      <p><input type="text" class="ProductCode2" name="ProductCode' + trCnt + '" id="ProductCode' + trCnt + '" value="" maxlength="20" onchange="estimateSystemProductSearch(' + trCnt + ');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> ';
    table_html += '      <input type="checkbox" name="OutletCheck' + trCnt + '" id="OutletCheck' + trCnt + '" value="1" onclick="estimateSystemOutletChack(' + trCnt + ');" title="アウトレットフラグ"d /><input type="hidden" name="FeeFlag' + trCnt + '" id="FeeFlag' + trCnt + '" value="" / > <input type="hidden" name="SuperBigFlag' + trCnt + '" id="SuperBigFlag' + trCnt + '" value="" /></p > ';
    table_html += '      <p><input type="text" class="ProductName" style="color: #000;" name="ProductName' + trCnt + '" id="ProductName' + trCnt + '" value="" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>';
    table_html += '      <p class="NoDisp" id="RCodeLine' + trCnt + '">Rコード <input type="text" class="ProductCode3" name="RCode' + trCnt + '" id="RCode' + trCnt + '" value="" maxlength="6" onchange="estimateSystemProductSearchRICOH(' + trCnt + ');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>';
    //table_html += '      <p class="InventoryArea" id="InventoryArea' + trCnt + '">' + Inventory + '<div class="InventoryLayer" id="InventoryLayer' + trCnt + '">' + Inventory2 + '</div></p>';
    table_html += '    </td>';
    table_html += '    <td><input type="checkbox" name="OpenCheck' + trCnt + '" id="OpenCheck' + trCnt + '" value="1" /></td>';
    table_html += '    <td>';
    table_html += '      <p><input type="text" class="PriceBox" name="RegularPrice' + trCnt + '" id="RegularPrice' + trCnt + '" value="" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>';
    table_html += '      <p><input type="text" class="PriceBox" name="NormalPrice' + trCnt + '" id="NormalPrice' + trCnt + '" value="" readonly onfocus="estimateSystemCursorAdvance(\'normal\',' + trCnt + ');" /></p>';
    table_html += '      <p><input type="text" class="PercentBox" name="NormalRate' + trCnt + '" id="NormalRate' + trCnt + '" value="" readonly onfocus="estimateSystemCursorAdvance(\'normal\',' + trCnt + ');" />%</p>';
    table_html += '    </td>';
    table_html += '    <td>';
    table_html += '      <p><input type="text" class="PercentBox" name="UnitRate' + trCnt + '" id="UnitRate' + trCnt + '" value="" maxlength="5" onchange="estimateSystemUnitPercent(' + trCnt + ', \'率\');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>';
    table_html += '      <p><input type="text" class="PriceBox" name="UnitPrice' + trCnt + '" id="UnitPrice' + trCnt + '" value="" maxlength="10" onchange="estimateSystemUnitPercent(' + trCnt + ', \'価格\');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>';
    table_html += '    </td>';
    table_html += '    <td><input type="number" class="AmountBox" name="Quantity' + trCnt + '" id="Quantity' + trCnt + '" value="" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(' + trCnt + '); estimateSystemCursorColorDisable(this.id);" /></td>';
    table_html += '    <td><input type="text" class="PriceBox" name="SubTotalPrice' + trCnt + '" id="SubTotalPrice' + trCnt + '" value="" readonly onfocus="estimateSystemCursorAdvance(\'sub\',' + trCnt + ');" /></td>';
    table_html += '    <td>';
    table_html += '      <p><input type="text" class="CommentBox" name="DeliveryTime' + trCnt + '" id="DeliveryTime' + trCnt + '" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" title="全角20文字程度" /></p>';
    table_html += '      <p><input type="text" class="CommentBox" name="Memo' + trCnt + '" id="Memo' + trCnt + '" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" title="全角40文字程度" /></p>';
    table_html += '      <p class="ProductNotice" id="ProductNotice' + trCnt + '"></p>';
    table_html += '    </td>';
    table_html += '    <td>';
    table_html += '      <p><input type="text" class="PriceBox" name="EigyouGenka' + trCnt + '" id="EigyouGenka' + trCnt + '" value="" readonly onfocus="estimateSystemCursorAdvance(\'next\',' + trCnt + ');" /></p>';
    table_html += '      <p><input type="text" class="PriceBox" name="MarginPrice' + trCnt + '" id="MarginPrice' + trCnt + '" value="" readonly onfocus="estimateSystemCursorAdvance(\'next\',' + trCnt + ');" /></p>';
    table_html += '      <p><input type="text" class="LimitBox" name="LimitPrice' + trCnt + '" id="LimitPrice' + trCnt + '" value="" readonly onfocus="estimateSystemCursorAdvance(\'next\',' + trCnt + ');" /></p>';
    table_html += '    </td>';
    table_html += '    <td>';
    table_html += '      <p><input type="text" class="PriceBox" name="MarginTotal' + trCnt + '" id="MarginTotal' + trCnt + '" value="" readonly onfocus="estimateSystemCursorAdvance(\'next\',' + trCnt + ');" /></p>';
    table_html += '      <p><input type="text" class="PercentBox" name="MarginRate' + trCnt + '" id="MarginRate' + trCnt + '" value="" readonly onfocus="estimateSystemCursorAdvance(\'next\',' + trCnt + ');" />%</p>';
    table_html += '    </td>';
    table_html += '    <td id="MarginRank' + trCnt + '"></td>';
    table_html += '    <td class="td_project">';
    table_html += '      <p><textarea class="TextBox2" name="PurchaseComment' + trCnt + '" id="PurchaseComment' + trCnt + '" readonly></textarea></p>';
    table_html += '      <p><textarea class="TextBox2" name="DevLeaderComment' + trCnt + '" id="DevLeaderComment' + trCnt + '" readonly></textarea><input type="hidden" name="AutoAnswerFlag' + trCnt + '" id="AutoAnswerFlag' + trCnt + '" value="" /><input type="hidden" name="ImportantFlag' + trCnt + '" id="ImportantFlag' + trCnt + '" value="" /></p>';
    table_html += '    </td>';
    table_html += '    <td class="td_project"></td>';
    table_html += '    <td class="td_project"><textarea class="TextBox1" name="RivalOther' + trCnt + '" id="RivalOther' + trCnt + '" placeholder="仕入へのメッセージなど"></textarea></td>';
    table_html += '    <td class="td_project">';
    table_html += '      <p><input type="text" class="CommentBox" name="RivalMaker' + trCnt + '" id="RivalMaker' + trCnt + '" value="" placeholder="メーカー" /></p>';
    table_html += '      <p><input type="text" class="CommentBox" name="RivalSku' + trCnt + '" id="RivalSku' + trCnt + '" value="" placeholder="品番" /></p>';
    table_html += '      <p><input type="text" class="CommentBox" name="RivalPrice' + trCnt + '" id="RivalPrice' + trCnt + '" value="" placeholder="価格" /></p>';
    table_html += '    </td>';
    table_html += '    <td class="td_project">';
    table_html += '      <p><input type="text" class="PriceBox" name="LeaderPrice' + trCnt + '" id="LeaderPrice' + trCnt + '" value="" readonly onfocus="estimateSystemCursorAdvance(\'quantity\',' + trCnt + ');" /></p>';
    table_html += '      <p><input type="text" class="PercentBox" name="LeaderRate' + trCnt + '" id="LeaderRate' + trCnt + '" value="" readonly onfocus="estimateSystemCursorAdvance(\'quantity\',' + trCnt + ');" />%</p>';
    table_html += '    </td>';
    table_html += '    <td class="td_project">';
    table_html += '      <p><input type="text" class="PriceBox" name="CorrectionPrice' + trCnt + '" id="CorrectionPrice' + trCnt + '" value="" readonly onfocus="estimateSystemCursorAdvance(\'next\',' + trCnt + ');" /></p>';
    table_html += '      <p><input type="text" class="PercentBox" name="CorrectionRate' + trCnt + '" id="CorrectionRate' + trCnt + '" value="" readonly onfocus="estimateSystemCursorAdvance(\'next\',' + trCnt + ');" />%</p>';
    table_html += '    </td>';
    table_html += '    <td class="td_project">';
    table_html += '      <ul class="not_completed_reason">';
    table_html += '        <li><label for="NotCompletedReason1_' + trCnt + '"><input type="checkbox" name="NotCompletedReason1_' + trCnt + '" id="NotCompletedReason1_' + trCnt + '" value="1" /> 価格</label></li>';
    table_html += '        <li><label for="NotCompletedReason2_' + trCnt + '"><input type="checkbox" name="NotCompletedReason2_' + trCnt + '" id="NotCompletedReason2_' + trCnt + '" value="1" /> 納期</label></li>';
    table_html += '        <li><label for="NotCompletedReason3_' + trCnt + '"><input type="checkbox" name="NotCompletedReason3_' + trCnt + '" id="NotCompletedReason3_' + trCnt + '" value="1" /> 本体ありき</label></li>';
    table_html += '        <li><label for="NotCompletedReason4_' + trCnt + '"><input type="checkbox" name="NotCompletedReason4_' + trCnt + '" id="NotCompletedReason4_' + trCnt + '" value="1" /> 仕様あわず</label></li>';
    table_html += '        <li><label for="NotCompletedReason5_' + trCnt + '"><input type="checkbox" name="NotCompletedReason5_' + trCnt + '" id="NotCompletedReason5_' + trCnt + '" value="1" /> 販社辞退</label></li>';
    table_html += '        <li><label for="NotCompletedReason6_' + trCnt + '"><input type="checkbox" name="NotCompletedReason6_' + trCnt + '" id="NotCompletedReason6_' + trCnt + '" value="1" /> 社内競合</label></li>';
    table_html += '        <li><label for="NotCompletedReason7_' + trCnt + '"><input type="checkbox" name="NotCompletedReason7_' + trCnt + '" id="NotCompletedReason7_' + trCnt + '" value="1" /> 型番数量違い</label></li>';
    table_html += '        <li><label for="NotCompletedReason9_' + trCnt + '"><input type="checkbox" name="NotCompletedReason9_' + trCnt + '" id="NotCompletedReason9_' + trCnt + '" value="1" /> その他</label></li>';
    table_html += '      </ul>';
    table_html += '    </td>';
    table_html += '  </tr>';

    $("#body_data_table2 tr:last").before(table_html);
    //if (NowDispMax == DispMaxLine) {
    //    document.getElementById("DetailAddBtn").style.display = "none";
    //}
}

// 詳細画面の得意先画面への検索リンク MOVE FROM estimate_system.js
function estimateSystemCustomerListOpen() {
    //window.open("./customer_search.asp","customer_search","width=820, height=800, menubar=no, toolbar=no, scrollbars=yes");

    //20200326 EDIT
    //var url = "../PopCustomerSearch/PopCustomerSearch.aspx";
    var url = "./Pages/PopCustomerSearch/PopCustomerSearch.aspx";

    $.showModalDialog(url, 820, 800, "得意先検索画面");
}

// 3chログインID連携のウィンドウ MOVE FROM estimate_system.js
function estimateSystemDetail3chIDSearch() {
    CCode = document.getElementById("CustomerCode").value;
    if (CCode == "") {
        alert("得意先コードが入力されていません。");
    } else {
        SCID = document.getElementById("SanwaChLoginID").value;
        //window.open("./sanwach_search.asp?AC=" + CCode + "&LI=" + SCID, "sanwach_search", "width=630, height=500, menubar=no, toolbar=no, scrollbars=yes");
        //20200330 EDIT
        //var url = "../PopSanwachSearch/PopSanwachSearch.aspx";
        var url = "./Pages/PopSanwachSearch/PopSanwachSearch.aspx?AC=" + CCode + "&LI=" + SCID;

        //20200402 EDIT
        //$.showModalDialog(url, 630, 550, "ログインID選択画面");
        $.showModalDialog(url, 650, 590, "ログインID選択画面");
    }
}

// コメントテンプレートを開く MOVE FROM estimate_system.js
function estimateSystemTemplateCommentOpen() {
    //window.open("./comment_template.asp", "comment_temp", "width=630, height=700, menubar=no, toolbar=no, scrollbars=yes");
    var url = "./Pages/PopCommentTemplate/PopCommentTemplate.aspx";
    $.showModalDialog(url, 630, 700, "テンプレートコメント画面");
}


// 詳細画面の得意先画面への検索リンク ダブリ 20200303 MOVE FROM estimate_system.js
//function estimateSystemCustomerListOpen() {
//    //window.open("./customer_search.asp","customer_search","width=820, height=800, menubar=no, toolbar=no, scrollbars=yes");
//    var url = "./Pages/PopCustomerSearch/PopCustomerSearch.aspx";
//    $.showModalDialog(url, 820, 800, "得意先検索画面");

//}

// 詳細画面　「データコピー」ボタンを押すと、商品データコピー画面へ遷移 MOVE FROM estimate_system.js
function estimateSystemItemDataCopy() {
    //window.open("./product_out.asp","product_out","width=420, height=400, menubar=no, toolbar=no, scrollbars=yes");
    var url = "./Pages/PopProductOut/PopProductOut.aspx";
    $.showModalDialog(url, 700, 500, "商品データ出力画面");
}

// 詳細画面　「一括品番入力」ボタンを押すと、品番一括投入画面へ遷移 MOVE FROM estimate_system.js
function estimateSystemItemAllIn() {
    //window.open("./product_in.asp", "product_in", "width=420, height=400, menubar=no, toolbar=no, scrollbars=yes");
    var url = "./Pages/PopProductIn/PopProductIn.aspx";
    $.showModalDialog(url, 450, 490, "商品一括入力画面");
}

// 在庫情報表示 MOVE FROM estimate_system.js
function estimateSystemInventoryLayer(LN) {
    //document.getElementById("InventoryLayer" + LN).style.display = "block";
    var area = document.getElementById("InventoryArea" + LN).getBoundingClientRect();
    var element = document.getElementById("InventoryLayer" + LN);
    element.style.position = 'fixed';
    element.style.left = area.left + 'px';
    var ptop = area.top - 170;
    element.style.top = ptop + 'px';
    //element.style.bottom = '40%';  
    element.style.display = "block";
}

// 在庫情報非表示 MOVE FROM estimate_system.js
function estimateSystemInventoryLayerClose(LN) {
    document.getElementById("InventoryLayer" + LN).style.display = "none";
}

// 詳細画面 & 得意先検索画面 & 商品一括入力画面の商品情報検索ajax 20200330 MOVE TO @estimate_system.js
//function estimateSystemProductSearch(inArrVals) {
//    var pData = new Array();

//    for (i = 0; i < inArrVals.length; i++) {
//        PC = inArrVals[i].pc;
//        PC = estimateSystemAlphaChange(PC);
//        PC = $.$.trim(PC);
//        AC = 'test123';
//        RF = document.getElementById("RICOHFlag").value;
//        //document.getElementById("ProductCode" + cnt).value = PC;
//        //if (document.getElementById("OutletCheck" + cnt).checked) {
//        //    OF = 1;
//        //    alert("アウトレット品として見積します。");
//        //} else {
//        OF = 0;
//        //}
//        pData.push({
//            PC: PC,
//            AC: AC,
//            RF: RF,
//            OF: OF
//        })
//    }

//    if (AC != "") {
//        // 商品情報を取得する
//        var url = "./Detail.aspx/GetJsonProductDataAll";
//        var data = JSON.stringify({ pdata: pData });
//        var result = $.getAjaxData(url, data);
//        if (result.match(/エラー：/)) {
//            alert(result);
//            return false;
//        }
//        var pdtData = JSON.parse(result);
//        alert(pdtData[0]);


//        //if (pdtData.length == 0 || estData.length > 10000) {
//        //    //if (estData.length >= 0) {
//        //    $("#search_result").hide();
//        //    $("#no_result").show();
//        //    return false;
//        //}
//        //var url = "ES_ProductSearch.asp?PC=" + PC + "&LN=" + cnt + "&AC=" + AC + "&OF=" + OF + "&RF=" + RF;

//        //http.open("GET", url, false);
//        //http.onreadystatechange = handleHttpResponseAdminESProductSearch;
//        //Process_flg = true;
//        //http.send(null);
//    } else {
//        alert("先に得意先コードを入力してください。");
//        document.getElementById("FirstCustomerErrorFlag").value = "1";
//    }
//}

// 詳細でコメントを表示
function estimateSystemDetailCommentBtn(e) {
    if (document.getElementById("SaveProductCommentArea").style.display == "block") {
        document.getElementById("SaveProductCommentBtn").innerHTML = "商品コメントを見る";
        document.getElementById("SaveProductCommentArea").style.display = "none";
    } else {
        document.getElementById("SaveProductCommentBtn").innerHTML = "商品コメントを閉じる";
        document.getElementById("SaveProductCommentArea").style.top = window.pageYOffset + "px";
        document.getElementById("SaveProductCommentArea").style.display = "block";
    }
}


// 2バイト文字変換 Detail用 20200330 移動@estimate_system.js
//function estimateSystemAlphaChange(str) {
//    var reStr = "";
//    for (var i = 0; i < str.length; i++) {
//        switch (str.substring(i, i + 1)) {
//            case "ー": reStr += "-"; break;
//            case "－": reStr += "-"; break;
//            case "―": reStr += "-"; break;
//            case "ａ": reStr += "A"; break;
//            case "ｂ": reStr += "B"; break;
//            case "ｃ": reStr += "C"; break;
//            case "ｄ": reStr += "D"; break;
//            case "ｅ": reStr += "E"; break;
//            case "ｆ": reStr += "F"; break;
//            case "ｇ": reStr += "G"; break;
//            case "ｈ": reStr += "H"; break;
//            case "ｉ": reStr += "I"; break;
//            case "ｊ": reStr += "J"; break;
//            case "ｋ": reStr += "K"; break;
//            case "ｌ": reStr += "L"; break;
//            case "ｍ": reStr += "M"; break;
//            case "ｎ": reStr += "N"; break;
//            case "ｏ": reStr += "O"; break;
//            case "ｐ": reStr += "P"; break;
//            case "ｑ": reStr += "Q"; break;
//            case "ｒ": reStr += "R"; break;
//            case "ｓ": reStr += "S"; break;
//            case "ｔ": reStr += "T"; break;
//            case "ｕ": reStr += "U"; break;
//            case "ｖ": reStr += "V"; break;
//            case "ｗ": reStr += "W"; break;
//            case "ｘ": reStr += "X"; break;
//            case "ｙ": reStr += "Y"; break;
//            case "ｚ": reStr += "Z"; break;
//            case "Ａ": reStr += "A"; break;
//            case "Ｂ": reStr += "B"; break;
//            case "Ｃ": reStr += "C"; break;
//            case "Ｄ": reStr += "D"; break;
//            case "Ｅ": reStr += "E"; break;
//            case "Ｆ": reStr += "F"; break;
//            case "Ｇ": reStr += "G"; break;
//            case "Ｈ": reStr += "H"; break;
//            case "Ｉ": reStr += "I"; break;
//            case "Ｊ": reStr += "J"; break;
//            case "Ｋ": reStr += "K"; break;
//            case "Ｌ": reStr += "L"; break;
//            case "Ｍ": reStr += "M"; break;
//            case "Ｎ": reStr += "N"; break;
//            case "Ｏ": reStr += "O"; break;
//            case "Ｐ": reStr += "P"; break;
//            case "Ｑ": reStr += "Q"; break;
//            case "Ｒ": reStr += "R"; break;
//            case "Ｓ": reStr += "S"; break;
//            case "Ｔ": reStr += "T"; break;
//            case "Ｕ": reStr += "U"; break;
//            case "Ｖ": reStr += "V"; break;
//            case "Ｗ": reStr += "W"; break;
//            case "Ｘ": reStr += "X"; break;
//            case "Ｙ": reStr += "Y"; break;
//            case "Ｚ": reStr += "Z"; break;
//            case "０": reStr += "0"; break;
//            case "１": reStr += "1"; break;
//            case "２": reStr += "2"; break;
//            case "３": reStr += "3"; break;
//            case "４": reStr += "4"; break;
//            case "５": reStr += "5"; break;
//            case "６": reStr += "6"; break;
//            case "７": reStr += "7"; break;
//            case "８": reStr += "8"; break;
//            case "９": reStr += "9"; break;
//            default: reStr += str.substring(i, i + 1); break;
//        }
//    }
//    return reStr;
//}