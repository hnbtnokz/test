<%@ Page Title="見積案件システム　検索" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Index.aspx.vb" Inherits="estimate_system.Index" %>

<%@ MasterType VirtualPath="~/Site.Master" %>

<asp:Content ID="Header" ContentPlaceHolderID="head" runat="server" ClientIDMode="Static">
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="body" runat="server" ClientIDMode="Static">

<%--20200310 ADD--%>
<%--20200312 DELETE--%>
<%--    <link href="Content/Pop.css" rel="stylesheet" />--%>

    <%--20200309 MOVE FROM MASTER--%>
    <script src="Scripts/Common.js?ver=<%= estimate_system.Common.Util.GetCashClearstr() %>"></script>

<script type="text/javascript" charset="utf-8">

// 一覧画面のグループ管理ボタン
function estimateSystemListGroupWindow(gno) {
    //window.open("./group_window.html?mode=list&gno=" + gno, "group_window", "width=780, height=700, menubar=no, toolbar=no, scrollbars=yes");

    //20200317 EDIT
    //var url = "./Pages/PopGroup/PopGroup.aspx?gno=" + gno;
    //20200323 EDIT
    var mode;
    var url;
    if (gno == "") {
        mode = "list";
        url = "./Pages/PopGroup/PopGroup.aspx?mode=" + mode;
    } else {
        mode = "detail";
        url = "./Pages/PopGroup/PopGroup.aspx?mode=" + mode + "&gno=" + gno;
    }

//20200310 EDIT
    //$.showModalDialog(url, 780, 700, "グループ管理画面");
    $.showModalDialog(url, 1000, 700, "グループ管理画面");
}

// 入力フォームでエンターを押した操作
//function estimateSystemEnterExe(key) {
//    if (key == 13) {
//        estimateSystemSearchButton();
//    }
//}

// 検索ページの本日ボタン
function estimateSystemListTodayBtn() {
    // フォーマット文字列内のキーワードを日付に置換する
    var date = new Date();
    var format = 'YYYY-MM-DD'   //HTML 5はyyyy-MM-dd形式の文字列を想定
    format = format.replace(/YYYY/g, date.getFullYear());
    format = format.replace(/MM/g, ('0' + (date.getMonth() + 1)).slice(-2));
    format = format.replace(/DD/g, ('0' + date.getDate()).slice(-2));
    document.getElementById("txtStartDate").value = format;
    document.getElementById("txtEndDate").value = format;
}

// ************************
//   estimate_system.js
// ************************

// 検索画面の検索ボタン
//function estimateSystemSearchButton() {
//	document.getElementById("HPage").value = 1;
//	document.getElementById("IssueNo").value = "";
//	document.getElementById("DeleteNo").value = "";
//	document.getElementById("DispNo").value = "";
//	document.getElementById("DispMode").value = "";
//	document.ESListForm.action = "Index.aspx";
//	document.ESListForm.target = "_self";
//	document.ESListForm.submit();
//}

// 検索画面の詳細ボタン
function estimateSystemSearchAdvance(cno){
	//location.href = "./detail.asp?cno=" + cno;

 //   document.getElementById("Mode").value = "Detail";
	//document.getElementById("CheckNum").value = cno;
	//document.getElementById("DispMode").value = "";
 //   document.getElementById("BtnSearch").click();   //OK

    location.href = "Detail.aspx?cno=" + cno;  //OK
}

// 検索画面の発行ボタン
function estimateSystemSearchIssue(cno) {
	//document.getElementById("IssueNo").value = cno;
	//document.getElementById("DeleteNo").value = "";
	//document.getElementById("DispNo").value = "";
	//document.getElementById("DispMode").value = "";
	//document.ESListForm.action = "./Index.aspx";
	//document.ESListForm.target = "_blank";
	////document.ESListForm.submit();

    //window.location.href = "Index.aspx?IssueNo=" + cno;  //OK
    
	//document.getElementById("Mode").value = "Issue";
	//document.getElementById("CheckNum").value = cno;
	//document.getElementById("DispMode").value = "";
 //   document.getElementById("BtnSearch").click();

    window.open("https://www.sanwa.co.jp/sanwa_ch/pdf/estimate_download.php?cno=" + cno & "&pname=" + cno, "_blank");
}

// 検索画面の回答ボタン
function estimateSystemSearchCheck(cno) {
	//location.href = "./check.asp?cno=" + cno;   //OK

    //20200303
	//document.getElementById("Mode").value = "Reply";
	//document.getElementById("CheckNum").value = cno;
	//document.getElementById("DispMode").value = "";
    //document.getElementById("BtnSearch").click();   //OK

    location.href = "./Pages/Check/Check.aspx?cno=" + cno;   //OK
}

// 検索画面の削除ボタン
function estimateSystemSearchDelete(cno) {
	if(confirm("見積番号 "+cno+" を削除します。\nよろしいですか？")) {
		//document.getElementById("DeleteNo").value = cno;
		//document.getElementById("IssueNo").value = "";
		//document.getElementById("DispNo").value = "";
		//document.getElementById("DispMode").value = "";
		//document.ESListForm.action = "./Index.aspx";
	    //document.ESListForm.target = "_self";
		////document.ESListForm.submit();

		//document.getElementById("form1").submit();  'OK

	    document.getElementById("Mode").value = "Delete";
	    document.getElementById("CheckNum").value = cno;
	    document.getElementById("DispMode").value = "";
        document.getElementById("BtnSearch").click();   //OK
	}
}

//var MaxDispLine = 100;

// 検索画面のCSVダウンロード
function estimateSystemSearchCSVDown() {
	//document.ESListForm.action = "./csv_download.asp";
    //document.ESListForm.submit();

	document.getElementById("Mode").value = "CSV";
    document.getElementById("CheckNum").value = "";
	document.getElementById("DispMode").value = "";
    document.getElementById("BtnSearch").click();   //OK
}

// 検索画面のページ送り
//function estimateSystemSearchAssist(pnum) {
	//document.getElementById("HPage").value = pnum;
	//document.getElementById("IssueNo").value = "";
	//document.getElementById("DeleteNo").value = "";
	//document.getElementById("DispNo").value = "";
	//document.getElementById("DispMode").value = "";
	//document.ESListForm.action = "./index.asp";
	//document.ESListForm.target = "_self";
	//document.ESListForm.submit();
//}

//// 検索画面の物件ボタン
//function estimateSystemSearchBukken(CNo) {
//	window.open("http://iw/bukken/main/index_est.asp?EstNum=" + CNo,"bukken","");
//}

// 検索画面からのサンワCh On Off
function estimateSystemDispChange(mode, cno) {
	compFlag = 0;

	if (mode == "on") {
		if (confirm(cno+"をサンワChで表示にします。\nよろしいですか？")) {
			compFlag = 1;
		}
	} else {
		if (confirm(cno+"をサンワChで非表示にします。\nよろしいですか？")) {
			compFlag = 1;
		}
	}

	if (compFlag == 1) {
		//document.getElementById("IssueNo").value = "";
		//document.getElementById("DeleteNo").value = "";
		//document.getElementById("DispNo").value = cno;
		//document.getElementById("DispMode").value = mode;
		//document.ESListForm.action = "./index.asp";
		//document.ESListForm.target = "_self";
		//document.ESListForm.submit();

        document.getElementById("Mode").value = "CH";
	    document.getElementById("CheckNum").value = cno;
	    document.getElementById("DispMode").value = mode;
        document.getElementById("BtnSearch").click();   //OK
	}
}

// 検索結果からの成約状況更新
function estimateSystemIndexConclusionChange(cno) {
	modeCode = "0";
	mode = document.getElementById("CSBtn_" + cno).innerHTML;

	switch (mode) {
		case "【継続中】":
			modeCode = "0";
			break;
		case "【成約】":
			modeCode = "1";
			break;
		case "【一部成約】":
			modeCode = "2";
			break;
		case "【不成約】":
			modeCode = "3";
			break;
	}
	//if (!Process_flg && http) {
	//	var url = "ES_ConclusionStatusChange.asp?CN=" + cno + "&CS=" + modeCode;
	//	http.open("GET", url, false);
	//	http.onreadystatechange = hdlHtpResIdxConclusionChg;
	//	Process_flg = true;
	//	http.send(null);
	//}
    document.getElementById("Mode").value = "Conclusion";
    document.getElementById("CheckNum").value = cno;
    document.getElementById("DispMode").value = modeCode;
    document.getElementById("BtnSearch").click();   //OK
}



</script>

<script type="text/javascript" charset="utf-8">
$(function () {
//    //https://www.softel.co.jp/blogs/tech/archives/4336
//    //https://blog.mach3.jp/2012/04/16/tips-for-jquery-ui-dialog.html
//    //$("#Button1").click(function () {
//    //    $("#div1").dialog({
//    //        modal: true, //モーダル表示
//    //        title: "テストダイアログ3", //タイトル
//    //        buttons: { //ボタン
//    //            "確認": function () {
//    //                $(this).dialog("close");
//    //            },
//    //            "キャンセル": function () {
//    //                $(this).dialog("close");
//    //            }
//    //        }
//    //    });
//    //});





//test OK 20200312
//    //https://jquery.keicode.com/ui/dialog.php
//    var d = $('#div1');
//    // 1ダイアログを初期化（自動オープンしない）
//    d.dialog({
//        modal: true,
//        autoOpen: false,
//        title: "テストダイアログ3",
////        closeText: "閉じる",
//        closeOnEscape: false,
//        buttons: {
//            "確認": function () {
//                $(this).dialog("close");
//            },
//            "キャンセル": function () {
//                $(this).dialog("close");
//            }
//        }
//    });
//    // ボタン・クリック時にダイアログを開く
//    $('#Button1').click(function(){
//        d.dialog('open');
//    });




//    //ADD 20200311 https://www.buildinsider.net/web/jqueryuiref/0012
//    //$('#Button1').click(function() {
//    //    var b = $(this);
//    //    // 2Ajax経由でダイアログの内容を取得
//    //    // ./Pages/Check/Check.aspx
//    //    $.get('./Pages/Check/' + b.data('Check') + '.aspx')
//    //     .done(function(data) {
//    //       $('<div title="' + b.val() + '">' + data + '</div>').dialog();
//    //    });
//    //});




//    //20200312 ADD https://www.softel.co.jp/blogs/tech/archives/4336
//////        $("#dialog").dialog();




//////    ↓↓ 初期状態で非表示にしておいたりして使う、ダイアログ用の要素
//////        < div id = "dialog" title = "Basic dialog" >
//////            <p>ダイアログの中身</p>
//////        </div >
//    //$("#dialogButton").click(function () {
//    //    /* 必要なときに、必要なdiv要素を生成して、利用する */
//    //    var x = $("<div></div>").dialog({ autoOpen: false });
//    //    /* ダイアログの中身は、どこかから取ってきたり、べた書きしたり */
//    //    x.html("ダイアログの中身");
//    //    /* ダイアログのオプションを設定して */
//    //    x.dialog("option", {
//    //        title: "ダイアログのタイトル",
//    //        width: 600,
//    //        height: 400,
//    //        buttons: {
//    //            "必要ならボタン類も": function () { $(this).dialog("close"); },
//    //            "追加できる": function () { $(this).dialog("close"); }
//    //        }
//    //    });
//    //    /* ダイアログを開きます */
//    //    x.dialog("open");
//    //});



    //─────────────────────────────────────
    //機能： Load時イベント
    //引数： 
    //戻値： 
    //補足： 
    //─────────────────────────────────────
    $(document).ready(function () {

        //// 画面遷移時、メッセージなし
        //onChangeFlg = 0;

        //// 日付カレンダー設定
        ////$('#txtStartDate').datepicker({
        ////    firstDay: 1
        ////});
        ////$('#txtEndDate').datepicker({
        ////    firstDay: 1
        ////});

        ///** 現在のDateオブジェクト作成 */
        //var dt, y, m, d
        //dt = new Date();
        ////3ヶ月前
        //dt.setMonth(dt.getMonth() - 3);
        //y = dt.getFullYear();
        //m = ('0' + (dt.getMonth() + 1)).slice(-2);
        //d = ('0' + dt.getDate()).slice(-2);
        ////$('#txtStartDate').val(y + '/' + m + '/' + d);
        //$('#txtStartDate').val(y + '-' + m + '-' + d);

        //dt = new Date();
        //y = dt.getFullYear();
        //m = ('0' + (dt.getMonth() + 1)).slice(-2);
        //d = ('0' + dt.getDate()).slice(-2);
        ////$('#txtEndDate').val(y + '/' + m + '/' + d);
        //$('#txtEndDate').val(y + '-' + m + '-' + d);
    });
});
</script>

    <%--    <asp:Menu ID="NavigationMenu" runat="server" CssClass="menu" EnableViewState="false"
    IncludeStyleBlock="false" Orientation="Horizontal">
    <Items>
        <asp:MenuItem NavigateUrl="~/Default.aspx" Text="Home" />
        <asp:MenuItem NavigateUrl="~/About.aspx" Text="About" />
        <asp:MenuItem NavigateUrl="~/Students.aspx" Text="Students">
            <asp:MenuItem NavigateUrl="~/StudentsAdd.aspx" Text="Add Students" />
        </asp:MenuItem>
        <asp:MenuItem NavigateUrl="~/Courses.aspx" Text="Courses">
            <asp:MenuItem NavigateUrl="~/CoursesAdd.aspx" Text="Add Courses" />
        </asp:MenuItem>
        <asp:MenuItem NavigateUrl="~/Instructors.aspx" Text="Instructors">
            <asp:MenuItem NavigateUrl="~/InstructorsCourses.aspx" Text="Course Assignments" />
            <asp:MenuItem NavigateUrl="~/OfficeAssignments.aspx" Text="Office Assignments" />
        </asp:MenuItem>
        <asp:MenuItem NavigateUrl="~/Departments.aspx" Text="Departments">
            <asp:MenuItem NavigateUrl="~/DepartmentsAdd.aspx" Text="Add Departments" />
        </asp:MenuItem>
    </Items>
    </asp:Menu>--%>

    <%--<div class="navbar navbar-inverse navbar-fixed-top">
        <div class="container">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" runat="server" href="~/">Wingtip Toys</a>
            </div>
            <div class="navbar-collapse collapse">
                <ul class="nav navbar-nav">
                    <li><a runat="server" href="~/">Home</a></li>
                    <li><a runat="server" href="~/About">About</a></li>
                    <li><a runat="server" href="~/Contact">Contact</a></li>
                </ul>
                <asp:LoginView runat="server" ViewStateMode="Disabled">
                    <AnonymousTemplate>
                        <ul class="nav navbar-nav navbar-right">
                            <li><a runat="server" href="~/Account/Register">Register</a></li>
                            <li><a runat="server" href="~/Account/Login">Log in</a></li>
                        </ul>
                    </AnonymousTemplate>
                    <LoggedInTemplate>
                        <ul class="nav navbar-nav navbar-right">
                            <li><a runat="server" href="~/Account/Manage" title="Manage your account">Hello, <%: Context.User.Identity.GetUserName()  %> !</a></li>
                            <li>
                                <asp:LoginStatus runat="server" LogoutAction="Redirect" LogoutText="Log off" LogoutPageUrl="~/" OnLoggingOut="Unnamed_LoggingOut" />
                            </li>
                        </ul>
                    </LoggedInTemplate>
                </asp:LoginView>
            </div>
        </div>
    </div>--%>

    <!-- ▼ メインコンテンツここから ▼ -->

    <div class="admin_main_contents clfx"><!-- width: 1880px;-->

        <!-- 見積システム 検索一覧 -->
        <asp:HiddenField ID="HPage" runat="server" Value="" />

<%--        <asp:HiddenField ID="DeleteNo" runat="server" Value="" />
        <asp:HiddenField ID="IssueNo" runat="server" Value="" />
        <asp:HiddenField ID="DispNo" runat="server" Value="" />
        <asp:HiddenField ID="DispMode" runat="server" Value="" />--%>

        <!-- ADD ボタン：グループ管理の引数-->
        <asp:HiddenField ID="Mode" runat="server" Value="" />
        <asp:HiddenField ID="CheckNum" runat="server" Value="" />
        <asp:HiddenField ID="DispMode" runat="server" Value="" />

        <%--20200228 DELETE--%>
<%--    <asp:HiddenField ID="GroupNo" runat="server" Value="" />
        <asp:HiddenField ID="GroupName" runat="server" Value="グループ管理" />--%>

        <!-- ■■■ 上部ボタン ■■■ -->
        <div class="estimate_system_list"><!--width: 1410px;-->
            <div class="top_button_area clfx"><!--padding: 3px 10px;-->
                    <p><input type="button" value="新規作成" onclick="location.href = './Detail.aspx'" /></p>
                    <p><input type="button" value="テストモード" onclick="location.href = './Detail.aspx?test=on'" /></p>
                    <p><input type="button" value="グループ管理" onclick="estimateSystemListGroupWindow('');" /></p>

<%--test No.1 OK 20200312--%>
<%--                    <p><input type="button" value="グループ管理 Button1" ID="Button1" /></p>--%>

<%--test No.2 20200312--%>
<%--                    <p><input type="button" value="グループ管理 Button2" onclick="estimateSystemListGroupWindow('');" ID="Button2" /></p>--%>

<%--
                <p><input type="button" value="マニュアル" class="btn btn-link" onclick="location.href = '~/data/manual/見積システムマニュアル_171218.ppt';" /></p>
                <p><input type="button" value="グラフ化" class="btn btn-link" onclick="location.href = '~/data/manual/20190801-0831_成約のみ.xlsm';" /></p>
                <p><input type="button" value="NJSSポータル" class="btn btn-link" onclick="javascript: window.open('http://njp.sanwa.local', '_blank');" /></p>
--%>
            </div>






<%--test OK 20200312--%>
<%--20200311 ADD https://www.buildinsider.net/web/jqueryuiref/0012 --%>
<%--<div id="div1" title="Backbone">
  <p>Backbone.jsはクライアントサイドMVCフレームワークの定番ライブラリの1つです。プレゼンテーションをView（ビュー）に、ビジネスロジック（ドメイン）をModel（モデル）に定義するスタイルで処理を記述します。</p>
  <p>このことにより、コードの保守性、再利用性、テスト可能性などを向上させることができます。</p>
</div>--%>




            <hr>
            <p class="admin_page_ttl">見積案件システム 検索一覧</p><!--padding: 3px 0 3px 8px;-->
<%--20200306<hr>--%>
            <div class="text-success text-left">
                <asp:Label ID="lblMsg" runat="Server" Text="検索条件を選択・入力してください" /></div>
            <div class="text-danger text-left">
                <asp:Label ID="lblErrMsg" runat="Server" Text="" /></div>

            <!-- ■■■ 検索エリア ■■■ -->
            <div class="search_area"><!--width: 1232px;-->
                <p class="search_ttl">検索</p>
<%--                <table class="search_item"><!--width: 1232px;-->--%>
                    <div class="row">
                        <div class="col-2 search_item_right">
                            <asp:Label ID="Label1" runat="server" Text="見積書番号" ViewStateMode="Disabled" />
                        </div>
                        <div class="col-4">
<%--EnableClientScript=true(デフォルト)により、DHTML でサポートされているブラウザー (Microsoft Internet Explorer 4.0 以降など) がクライアントで検証を実行できる--%>
                            <asp:TextBox ID="txtCheckNum" runat="server" MaxLength="12" ClientIDMode="Static" />
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="12文字までの半角英数字" 
                               ControlToValidate="txtCheckNum" ValidationExpression="^[a-zA-Z0-9]+$" CssClass="text-danger" SetFocusOnError="true" EnableClientScript="true" Display="Dynamic" />
                            
                            <%--ForeColor="#FF0066"--%> <%--CssClass="text-danger"--%>

                            <asp:Label ID="Label11" runat="server" Text="前方一致" CssClass="min_comment" ViewStateMode="Disabled" />
                        </div>

                        <div class="col-2 search_item_right">
                            <asp:Label ID="Label2" runat="server" Text="検索モード" ViewStateMode="Disabled" />
                        </div>
                        <div class="col-4 form-check">
                            <asp:RadioButtonList ID="rblPageMode" runat="server" RepeatDirection="Horizontal" ClientIDMode="Static">
                                <asp:ListItem Value="0" Text="明細非表示" Selected="True"/><asp:ListItem Value="1" Text="明細表示" Selected="False" />
                            </asp:RadioButtonList>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-2 search_item_right">
                            <asp:Label ID="Label3" runat="server" Text="検索期間" ViewStateMode="Disabled" />
                        </div>
                        <div class="col-4">
                            <label class="date-edit">
                              <%--<asp:TextBox ID="TextBox1" TextMode="Date" CssClass="date_box" runat="server" MaxLength="10" Text="" ClientIDMode="Static" />--%>
                              <asp:TextBox ID="txtStartDate" TextMode="Date" CssClass="date_box" runat="server" MaxLength="10" Text="" ClientIDMode="Static" CausesValidation="True" />
                            </label>
<%--frameworkのバグ　年が４桁入力できなくなる--%>
                            <asp:RangeValidator ID="RangeValidator1" runat="server" Type="Date" ErrorMessage="1900/01/01から2100/12/31の日付" CssClass="text-danger"
                                MinimumValue="1900/01/01" MaximumValue="2100/12/31" ControlToValidate="txtStartDate"
                                 SetFocusOnError="true" EnableClientScript="true" Display="Dynamic" ClientIDMode="Static" />

                            <asp:Label ID="Label34" runat="server" Text="～" ViewStateMode="Disabled" />
                            <label class="date-edit">
                              <asp:TextBox ID="txtEndDate" TextMode="Date" CssClass="date_box" runat="server" MaxLength="10" Text="" ClientIDMode="Static" />
                            </label>

                            <%--20200305 EDIT EnableViewState OnClientClick return--%>
                            <asp:Button ID="BtnToday" runat="server" Text="本日" CssClass="btn btn-info" OnClientClick="return estimateSystemListTodayBtn();" ClientIDMode="Static" UseSubmitBehavior="False" EnableViewState="False" />
                        </div>

                        <div class="col-2 search_item_right">
                            <asp:Label ID="Label4" runat="server" Text="所属" ViewStateMode="Disabled" />
                        </div>
                        <div class="col-4" style="padding-left: 5px;">
                            <asp:RadioButtonList ID="rblAreaCode" runat="server" RepeatDirection="Horizontal" ClientIDMode="Static">
                                <asp:ListItem Value="0">岡山</asp:ListItem>
                                <asp:ListItem Value="1">東京</asp:ListItem>
                                <asp:ListItem Value="2" Selected="True">両方</asp:ListItem>
                            </asp:RadioButtonList>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-2 search_item_right">
                            <asp:Label ID="Label5" runat="server" Text="販売店CD" ViewStateMode="Disabled" />
                        </div>
                        <div class="col-4">
                            <asp:TextBox ID="txtCustomerCode" runat="server" MaxLength="10" style="width: 80px;" ClientIDMode="Static" />
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="10文字までの半角" 
                               ControlToValidate="txtCustomerCode" ValidationExpression="^[a-zA-Z0-9!-/:-@&yen;[-`{-~]+$" CssClass="text-danger" SetFocusOnError="true" EnableClientScript="true" Display="Dynamic" />
                            <asp:Label ID="Label55" runat="server" text="完全一致(自動0埋め)" CssClass="min_comment" ViewStateMode="Disabled" />
<%--EDIT                    <asp:CheckBox ID="chbCustomerSort" runat="server" Text="得意先CDでソート" Checked="false" ClientIDMode="Static" />--%>
                        </div>

                        <div class="col-2 search_item_right">
                            <asp:Label ID="Label6" runat="server" Text="サンワ担当者名・コード" ViewStateMode="Disabled" />
                        </div>
                        <div class="col-4">
                            <asp:TextBox ID="txtSalesPerson" runat="server" MaxLength="15" style="width: 80px;" ClientIDMode="Static" />
                            <asp:Label ID="Label7" runat="server" text="部分一致" CssClass="min_comment" ViewStateMode="Disabled" />
                            <asp:Label ID="Label35" runat="server" text="( 開発・仕入担当：" ViewStateMode="Disabled" />
                            <asp:TextBox ID="txtDevSupPerson" runat="server" MaxLength="15" style="width: 80px;" ClientIDMode="Static" />
                            <asp:Label ID="Label36" runat="server" text=")" ViewStateMode="Disabled" />
                        </div>
                    </div>

                <%--EDIT--%>
                    <div class="row">
                        <div class="col-2 search_item_right">
                        </div>
                        <div class="col-4">
                            <asp:CheckBox ID="chbCustomerSort" runat="server" Text="得意先CDでソート" Checked="false" ClientIDMode="Static" />
                        </div>

                        <div class="col-2 search_item_right"></div>
                        <div class="col-4"></div>
                    </div>

                    <div class="row">
                        <div class="col-2 search_item_right">
                            <asp:Label ID="Label8" runat="server" Text="販売店・部署・担当者名" ViewStateMode="Disabled" />
                        </div>
                        <div class="col-4">
                            <asp:TextBox ID="txtSearchName" runat="server" MaxLength="50" Text="" ClientIDMode="Static" />
                            <asp:Label ID="Label9" runat="server" text="部分一致" CssClass="min_comment" ViewStateMode="Disabled" />
                        </div>

                        <div class="col-2 search_item_right">
                            <asp:Label ID="Label10" runat="server" Text="作成者名・コード" ViewStateMode="Disabled" />
                        </div>
                        <div class="col-4">
                            <asp:TextBox ID="txtCreatePerson" runat="server" MaxLength="15" ClientIDMode="Static" />
                            <asp:Label ID="Label12" runat="server" text="部分一致" CssClass="min_comment" ViewStateMode="Disabled" />
                        </div>
                    </div>

                     <div class="row">
                        <div class="col-2 search_item_right">
                            <asp:Label ID="Label13" runat="server" Text="見積件名" ViewStateMode="Disabled" />
                        </div>
                        <div class="col-4">
                            <asp:TextBox ID="txtSearchTitle" runat="server" MaxLength="50" Text="" ClientIDMode="Static" />
                            <asp:Label ID="Label14" runat="server" text="部分一致" CssClass="min_comment" ViewStateMode="Disabled" />
                        </div>

                        <div class="col-2 search_item_right">
                            <asp:Label ID="Label15" runat="server" Text="班" ViewStateMode="Disabled" />
                        </div>
                        <div class="col-4">
                            <asp:DropDownList  ID="ddlKOSTL" runat="server">
                            </asp:DropDownList>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-2 search_item_right">
                            <asp:Label ID="Label16" runat="server" Text="メモ書き" ViewStateMode="Disabled" />
                        </div>
                        <div class="col-4">
                            <asp:TextBox ID="txtSearchMemo" runat="server" MaxLength="50" Text="" ClientIDMode="Static" />
                            <asp:Label ID="Label17" runat="server" text="部分一致" CssClass="min_comment" ViewStateMode="Disabled" />
                        </div>

                        <div class="col-2 search_item_right">
                            <asp:Label ID="Label18" runat="server" Text="成約状況" ViewStateMode="Disabled" />
                        </div>
                        <div class="col-4">
                            <asp:DropDownList ID="ddlConclusionStatus" runat="server">
                                <asp:ListItem Value="" Selected="True">すべて</asp:ListItem>
                                <asp:ListItem Value="継続中">継続中</asp:ListItem>
                                <asp:ListItem Value="成約">成約 (一部成約含)</asp:ListItem>
                                <asp:ListItem Value="不成約">不成約</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                
                    <div class="row">
                        <div class="col-2 search_item_right">
                            <asp:Label ID="Label19" runat="server" Text="品番" ViewStateMode="Disabled" />
                        </div>
                        <div class="col-4">
                            <asp:TextBox ID="txtProductCode" runat="server" MaxLength="20" Text="" ClientIDMode="Static" />
                            <asp:Label ID="Label20" runat="server" text="部分一致" CssClass="min_comment" ViewStateMode="Disabled" />
                        </div>

                        <div class="col-2 search_item_right">
                            <asp:Label ID="Label21" runat="server" Text="数量" ViewStateMode="Disabled" />
                        </div>
                        <div class="col-4">
                            <asp:TextBox ID="txtQuantity" runat="server" MaxLength="10" Text="" ClientIDMode="Static" />
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ErrorMessage="10桁までの半角数字" 
                               ControlToValidate="txtQuantity" ValidationExpression="^[0-9]+$" CssClass="text-danger" SetFocusOnError="true" EnableClientScript="true" Display="Dynamic" />
                            <asp:DropDownList ID="ddlQuantityMark" runat="server">
                                <asp:ListItem Value="" Selected="True">等しい</asp:ListItem>
                                <asp:ListItem Value="以下">以下</asp:ListItem>
                                <asp:ListItem Value="以上">以上</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                
                    <div class="row">
                        <div class="col-2 search_item_right">
                            <asp:Label ID="Label22" runat="server" Text="継続案件フラグ" ViewStateMode="Disabled" />
                        </div>
                        <div class="col-4">
                            <asp:DropDownList ID="ddlContinuationFlag" runat="server">
                                <asp:ListItem Value="" Selected="True">未指定</asp:ListItem>
                                <asp:ListItem Value="組込案件">組込案件</asp:ListItem>
                                <asp:ListItem Value="年間契約">年間契約</asp:ListItem>
                                <asp:ListItem Value="リース案件">リース案件</asp:ListItem>
                                <asp:ListItem Value="すべて">継続案件すべて</asp:ListItem>
                                <asp:ListItem Value="以外">継続案件以外</asp:ListItem>
                            </asp:DropDownList>
                        </div>

                        <div class="col-2 search_item_right">
                            <asp:Label ID="Label24" runat="server" Text="エンドユーザ都道府県" ViewStateMode="Disabled" />
                        </div>
                        <div class="col-4">
                            <asp:DropDownList ID="ddlEndUserPref" runat="server">
                            </asp:DropDownList>
                        </div>
                    </div>
                
                    <div class="row">
                        <div class="col-2 search_item_right">
                            <asp:Label ID="Label23" runat="server" Text="案件管理" ViewStateMode="Disabled" />
                        </div>
                        <div class="col-4">
                            <asp:DropDownList ID="ddlProjectFlag" runat="server">
                                <asp:ListItem Value="" Selected="True">すべて</asp:ListItem>
                                <asp:ListItem Value="1">する</asp:ListItem>
                                <asp:ListItem Value="0">しない</asp:ListItem>
                            </asp:DropDownList>
                        </div>

                        <div class="col-2 search_item_right">
                            <asp:Label ID="Label26" runat="server" Text="最終ユーザ名" ViewStateMode="Disabled" />
                        </div>
                        <div class="col-4">
                            <asp:TextBox ID="txtEndUserName" runat="server" MaxLength="50" Text="" ClientIDMode="Static" />
                            <asp:Label ID="Label25" runat="server" text="部分一致" CssClass="min_comment" ViewStateMode="Disabled" />
                        </div>
                    </div>
                
                    <div class="row search_item_ricoh_area_top">
                        <div class="col-2 search_item_right">
                            <asp:Label ID="Label27" runat="server" Text="グループNo" ViewStateMode="Disabled" />
                        </div>
                        <div class="col-4">
                            <asp:TextBox ID="txtGroupNo" runat="server" MaxLength="11" Text="" ClientIDMode="Static" />
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ErrorMessage="11文字までの半角英数字" 
                               ControlToValidate="txtGroupNo" ValidationExpression="^[a-zA-Z0-9]+$" CssClass="text-danger" SetFocusOnError="true" EnableClientScript="true" Display="Dynamic" />
                        </div>

                        <div class="col-2 search_item_right">
                            <asp:Label ID="Label28" runat="server" Text="グループ名" ViewStateMode="Disabled" />
                        </div>
                        <div class="col-4">
                            <asp:TextBox ID="txtGroupName" runat="server" MaxLength="50" Text="" ClientIDMode="Static" />
                            <asp:Label ID="Label29" runat="server" text="部分一致" CssClass="min_comment" ViewStateMode="Disabled" />
                        </div>
                    </div>

                    <div class="row search_item_ricoh_area_btm">
                        <div class="col-2 search_item_right">
                            <asp:Label ID="Label30" runat="server" Text="案件番号(RICOH)" ViewStateMode="Disabled" />
                        </div>
                        <div class="col-4">
                            <asp:TextBox ID="txtRicohNum" runat="server" MaxLength="13" Text="" ClientIDMode="Static" />
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server" ErrorMessage="13文字までの半角英数字" 
                               ControlToValidate="txtRicohNum" ValidationExpression="^[a-zA-Z0-9]+$" CssClass="text-danger" SetFocusOnError="true" EnableClientScript="true" Display="Dynamic" />
                            <asp:Label ID="Label33" runat="server" text="部分一致" CssClass="min_comment" ViewStateMode="Disabled" />
                        </div>

                        <div class="col-2 search_item_right">
                            <asp:Label ID="Label31" runat="server" Text="品種コード(RICOH)" ViewStateMode="Disabled" />
                        </div>
                        <div class="col-4">
                            <asp:TextBox ID="txtRCode" runat="server" MaxLength="6" Text="" ClientIDMode="Static" />
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator6" runat="server" ErrorMessage="6文字までの半角" 
                               ControlToValidate="txtRCode" ValidationExpression="^[a-zA-Z0-9!-/:-@&yen;[-`{-~]+$" CssClass="text-danger" SetFocusOnError="true" EnableClientScript="true" Display="Dynamic" />
                            <asp:Label ID="Label32" runat="server" text="部分一致" CssClass="min_comment" ViewStateMode="Disabled" />
                        </div>
                    </div>

                    <div class="row btn_area">
                        <div class="col-12">
                            <asp:Button ID="BtnSearch" runat="server" Text=" 検 索 " CssClass="btn btn-primary align-middle" OnClick="BtnSearch_Click" ClientIDMode="Static" />
                            &nbsp;&nbsp;&nbsp;
                            <asp:CheckBox ID="chbFixCheck" runat="server" Text="仮登録のみ" Checked="false" ClientIDMode="Static" />
                        </div>
                    </div>

<%--            </table>--%>

            </div>  <%--width: 1232px;--%>

            <!-- ■■■ 検索結果カウント ■■■ -->
<%--
  <div class="search_result clfx">
    <p class="result_left"><%=ObjDWH.RecordCount %>件見つかりました。</p>
    <p class="result_right"><%=SearchResultPageAssist(ObjDWH.RecordCount, Page, PageSize, "estimateSystemSearchAssist") %></p>
  </div>--%>

            <div class="search_result clfx"><%--width: 1280px;--%>
              <div class="row">
                <div class="col-6 result_left">
                    <asp:Label ID="lblResultCount" runat="server" text="" ViewStateMode="Disabled" />
                </div>
                <div class="col-6 result_right">
<%--                    <%=SearchResultPageAssist(ObjDWH.RecordCount, Page, PageSize, "estimateSystemSearchAssist") %>--%>
                    <%--参考　独自ページング　http://www.csharpdoc.info/?p=25--%>
                    <%--データバインドをする実装に変更したうえでポストバック時のためにデータソースを保持し続ける方法ですが、SessionまたはViewStateに保存するのが適当です--%>
              </div>
              </div>
            </div><%--search_result--%>

            <!-- ■■■ リスト ■■■ -->
<%--20200303            <div id="result_table">--%>
            <div class="result_table"><%--width: 1410px;--%>

<%--  <table class="result_table"><!--width: 1410px;-->
    <tr>
      <th style="width: 115px;">見積番号</th>
      <th style="width: 30px;">販売店CD<br />販売店名<br />担当者名</th>
      <th>見積件名<br />品番</th>
      <th style="width:100px;">数量<br />金額</th>
      <th style="width: 100px;">担当営業<br />アシスタント</th>
      <th style="width: 100px;">見積者<br />最終更新日</th>
      <th style="width: 120;">状態</th>
      <th style="width: 120;"></th>
      <th style="width: 130;">案件管理<br />メール送信状況</th>
    </tr>

    <tr>
      <td class="td_num"><a href="javascript: estimateSystemSearchAdvance('X19122500157');">X19122500157</a></td>
      <td>0000013667<br />宇野株式会社<br />家弓様　久本</td>
      <td><span id="CSBtn_X19122500157" onclick="estimateSystemIndexConclusionChange('X19122500157');" class="ConcSt" style="color: #999;">【継続中】</span><br />0244722<br />TAP-F37CLAMP</td>
      <td style="text-align: right;">1<br />&yen;275</td>
      <td>後田 誠一<br />久山 真知子</td>
      <td>久山 真知子<br />2019/12/25</td>
      <td class="td_num"><span style="color: #00F;">本登録</span><br />
          <input type="button" style="width: 85px;" onclick="estimateSystemDispChange('on', 'X19122500157');" value="ｻﾝﾜCh非表示" />
      </td>
      <td class="td_btn">
        <input type="button" style="color: #000;" value="詳細" onclick="estimateSystemSearchAdvance('X19122500157');" />
        <input type="button" style="color: #00F;" value="発行" onclick="estimateSystemSearchIssue('X19122500157');" /><br />
        <input type="button" style="color: #0A0;" value="回答" onclick="estimateSystemSearchCheck('X19122500157');" />
        <input type="button" style="color: #F00;" value="削除" onclick="estimateSystemSearchDelete('X19122500157');" /></td>
<%--OK        <input type="button" id="btnDelete" style="color: #F00;" value="削除" /></td>--%>
<%--  <td>
        <p>案件管理：<span class="noexe_color">しない</span></p>
        <p>案件メール：<span class="noexe_color">未送信</span></p>
        <p>成約メール：<span class="noexe_color">未送信</span></p>
      </td>
    </tr>
  </table>--%>

<%--↓20200206／20200212 Width値設定--%>
    <asp:GridView ID="grvSearch_Result" runat="server" AllowPaging="True" AutoGenerateColumns="False" PageSize="20" Width="1410px">
        <Columns>
            <asp:TemplateField HeaderText="見積番号">
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("0") %>'></asp:Label>
                </ItemTemplate>
                <HeaderStyle BackColor="#606060" ForeColor="White" Width="115px" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="販売店CD&lt;br /&gt;販売店名&lt;br /&gt;担当者名">
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("1") %>'></asp:Label>
                </ItemTemplate>
                <HeaderStyle BackColor="#606060" ForeColor="White" Width="300px" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="見積件名&lt;br /&gt;最終ユーザー名&lt;br /&gt;品番">
                <ItemTemplate>
                    <asp:Label ID="Label3" runat="server" Text='<%# Bind("2") %>'></asp:Label>
                </ItemTemplate>
                <HeaderStyle BackColor="#606060" ForeColor="White" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="数量&lt;br /&gt;金額単価">
                <ItemTemplate>
                    <asp:Label ID="Label4" runat="server" Text='<%# Bind("3") %>'></asp:Label>
                </ItemTemplate>
                <HeaderStyle BackColor="#606060" ForeColor="White" Width="100px" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="担当営業&lt;br /&gt;アシスタント">
                <ItemTemplate>
                    <asp:Label ID="Label5" runat="server" Text='<%# Bind("4") %>'></asp:Label>
                </ItemTemplate>
                <HeaderStyle BackColor="#606060" ForeColor="White" Width="100px" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="見積者&lt;br /&gt;最終更新日">
                <ItemTemplate>
                    <asp:Label ID="Label6" runat="server" Text='<%# Bind("5") %>'></asp:Label>
                </ItemTemplate>
                <HeaderStyle BackColor="#606060" ForeColor="White" Width="100px" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="状態">
                <ItemTemplate>
                    <asp:Label ID="Label7" runat="server" Text='<%# Bind("6_text") %>'></asp:Label>
                    <br />
                    <%--20200219 サンワchボタンにイベント追加--%>
                    <asp:Button ID="btnSanwaCh" runat="server" Text='<%# Bind("6_button_text") %>' visible='<%# Bind("6_button_visible") %>' OnClientClick='<%# Bind("6_button_click") %>' UseSubmitBehavior="False" />
                </ItemTemplate>
                <HeaderStyle BackColor="#606060" ForeColor="White" Width="120px" />
            </asp:TemplateField>
            <asp:TemplateField>
                <%--↓20200212 ボタンテキストのカラーを指定--%>
                <ItemTemplate>
                    <asp:Button ID="btnShosai" runat="server" Text="詳細" OnClientClick='<%# Bind("7_shosai") %>' style="color: #000;" UseSubmitBehavior="False"/>
                    <asp:Button ID="btnHakko" runat="server" Text="発行" OnClientClick='<%# Bind("7_hakko") %>' style="color: #00F;" UseSubmitBehavior="False"/>
                    <br />
                    <asp:Button ID="btnKaito" runat="server" Text="回答" OnClientClick='<%# Bind("7_kaito") %>' visible='<%# Bind("7_kaito_visible") %>' style="color: #0A0;" UseSubmitBehavior="False"/>
                    <%--20200219 削除ボタンにイベント追加--%>
                     <asp:Button ID="btnSakujo" runat="server" Text="削除" OnClientClick='<%# Bind("7_sakujo") %>' style="color: #F00;" UseSubmitBehavior="False"/>
               </ItemTemplate>
                <%--↑20200212--%>
                <HeaderStyle BackColor="#606060" ForeColor="White" Width="120px" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="案件管理&lt;br /&gt;メール送信状況">
                <ItemTemplate>
                    <asp:Label ID="Label8" runat="server" Text="案件管理："></asp:Label>
                    <asp:Label ID="Label9" runat="server" Text='<%# Bind("8_project") %>'></asp:Label>
                    <br />
                    <asp:Label ID="Label10" runat="server" Text="案件メール："></asp:Label>
                    <asp:Label ID="Label11" runat="server" Text='<%# Bind("8_projectmail") %>'></asp:Label>
                    <br />
                    <asp:Label ID="Label12" runat="server" Text="成約メール："></asp:Label>
                    <asp:Label ID="Label13" runat="server" Text='<%# Bind("8_conclusionmail") %>'></asp:Label>
                </ItemTemplate>
                <HeaderStyle BackColor="#606060" ForeColor="White" Width="160px" />
            </asp:TemplateField>
        </Columns>
        <PagerTemplate>
            <asp:LinkButton ID="LinkButton1" runat="server" CommandName="Page" CommandArgument="First" CssClass="PagerStyle" Width="18px" >7</asp:LinkButton>
            <asp:LinkButton ID="LinkButton2" runat="server" CommandName="Page" CommandArgument="Prev" CssClass="PagerStyle" Width="18px" >3</asp:LinkButton>
            (<%= grvSearch_Result.PageIndex + 1 %>/ <%=grvSearch_Result.PageCount %>)
            <asp:LinkButton ID="LinkButton3" runat="server" CommandName="Page" CommandArgument="Next" CssClass="PagerStyle" Width="18px" >4</asp:LinkButton>
            <asp:LinkButton ID="LinkButton4" runat="server" CommandName="Page" CommandArgument="Last" CssClass="PagerStyle" Width="18px" >8</asp:LinkButton>
        </PagerTemplate>
    </asp:GridView>
    <style>
        .PagerStyle { font-family:  Webdings; text-decoration: none } 
    </style>
<%--↑20200206／20200212--%>
              </div><%--result_table--%>
<%--      <p class="no_result">--%>
<%--        検索結果が 0件 もしくは 10000件 以上の為、表示できません。<br />検索条件を変更して再度検索してください。--%>
          <%--20200305 EDIT--%>
          <p>
            <asp:Label ID="lblResultMsg" runat="server" text="" CssClass="no_result" ViewStateMode="Disabled" />
          </p>
          <p class="csvdown">
            <a href="javascript: estimateSystemSearchCSVDown();">検索結果をCSVでダウンロード</a>
          </p>
        </div><%--//estimate_system_list--%>
    </div><%--//admin_main_contents--%>

<%--    test--%>
<%--    //https://docs.microsoft.com/ja-jp/aspnet/web-forms/overview/presenting-and-managing-data/model-binding/integrating-jquery-ui
    
    <asp:GridView runat="server" ID="studentsGrid"
        ItemType="ContosoUniversity.Models.Student" DataKeyNames="StudentID"
        SelectMethod="studentsGrid_GetData"
        UpdateMethod="studentsGrid_UpdateItem" DeleteMethod="studentsGrid_DeleteItem"
        AllowSorting="true" AllowPaging="true" PageSize="20"
        AutoGenerateEditButton="true" AutoGenerateDeleteButton="true"   
        AutoGenerateColumns="false" AllowCustomPaging="True" PageIndex="1">
        <Columns>
            <asp:DynamicField DataField="StudentID" />
            <asp:DynamicField DataField="LastName" />
            <asp:DynamicField DataField="FirstName" />
            <asp:DynamicField DataField="Year" />          
            <asp:TemplateField HeaderText="Total Credits">
              <ItemTemplate>
                <asp:Label Text="<%# Item.Enrollments.Sum(en => en.Course.Credits) %>" 
                    runat="server" />
              </ItemTemplate>
            </asp:TemplateField>        
        </Columns>
    </asp:GridView>--%>

<%--    <asp:UpdatePanel ID="UpdatePanel1" runat="server">      
         <ContentTemplate>
             <asp:Label ID="Label37" runat="server" Text="Label"></asp:Label>
             <br />
             <asp:Button ID="Button1" runat="server" onclick="Button1_Click" Text="Update" />
         </ContentTemplate>
         <Triggers>
           <asp:AsyncPostBackTrigger ControlID="Button1" EventName="Click" />
         </Triggers>
    </asp:UpdatePanel>--%>

<%--    <asp:DataPager ID="DataPager1" runat="server">
        <Fields>
            <asp:NextPreviousPagerField FirstPageText="&lt;&lt;" LastPageText="&gt;&gt;" NextPageText="&gt;" PreviousPageText="&lt;" 
                ShowFirstPageButton="True" ShowLastPageButton="True" />
        </Fields>
    </asp:DataPager>--%>

    <!-- ▲ メインコンテンツ閉め ▲ -->
</asp:Content>
