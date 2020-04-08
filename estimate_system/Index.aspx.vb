Imports estimate_system.Common

Public Class Index
    Inherits System.Web.UI.Page

#Region "変数"

#End Region

    Public Sub New()

    End Sub

    'ページ初期化前
    Private Sub Index_PreInit(sender As Object, e As EventArgs) Handles Me.PreInit

    End Sub

    'ページの初期化タイミング
    Private Sub Index_Init(sender As Object, e As EventArgs) Handles Me.Init

    End Sub

#Region "ページの起動時"
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        '20200303 MOVE
        ' セッション切れ処理終了
        If HttpContext.Current.Session("SESSIONID") <> Session.SessionID Then
            Response.Redirect("Login.aspx")
        End If

        'ページロード時
        If Not IsPostBack Then

            'セッションを確認
            If IsNothing(Session("EstPersonCode")) OrElse IsNothing(Session("EstPersonName")) Then
                ' ログインページへ
                Response.Redirect("Login.aspx")
            End If

            'クッキーを確認
            If IsNothing(Request.Cookies("estimate_system")) OrElse IsNothing(Request.Cookies("estimate_system").Values("UID")) Then
                ' ログインページへ
                Response.Redirect("Login.aspx")
            End If

            '20200303 MOVE
            '' セッション切れ処理終了
            'If HttpContext.Current.Session("SESSIONID") <> Session.SessionID Then
            '    Response.Redirect("Login.aspx", False)
            'End If


            ''テキストボックス入力時の[Enter]キーで動作するボタン=デフォルトボタンを設定
            'Form.DefaultButton = BtnSearch.UniqueID
            'txtCheckNum.Focus()

            SetListKOSTL()          '20200206 班:ddlKOSTL DBセット
            SetListEndUserPref()    'エンドユーザ都道府県:ddlEndUserPref

            ''初期値セット
            ''TODO:
            'Dim strGroupNo As String = ""               'DBから取得
            'Dim strGroupName As String = "グループ管理"    'DBから取得

            Dim now As DateTime = DateTime.Now
            now = now.AddMonths(-3)
            txtStartDate.Text = now.ToString("yyyy-MM-dd")  '3ヶ月前
            now = DateTime.Now()
            txtEndDate.Text = now.ToString("yyyy-MM-dd")

            'hidden値セット
            HPage.Value = "1"
            Mode.Value = "Search"
            CheckNum.Value = ""
            DispMode.Value = ""
            'GroupNo.Value = strGroupNo
            'GroupName.Value = strGroupName

            'ADD 20200210
            'grvSearch_Result.Visible = False
            lblResultMsg.Visible = False

        Else    'Postbackの時

            'ADD 20200210
            'grvSearch_Result.Visible = True
            lblResultMsg.Visible = False

        End If

    End Sub
#End Region

#Region "BtnSearch_Click"
    Protected Sub BtnSearch_Click(sender As Object, e As EventArgs) Handles BtnSearch.Click
        Dim flg As Boolean = False

        'hidden値取得
        Dim strHPage = HPage.Value.Trim()
        'Dim strDeleteNo = DeleteNo.Value
        'Dim strIssueNo = IssueNo.Value
        'Dim strDispNo = DispNo.Value
        'Dim strDispMode = DispMode.Value
        'Dim strGroupNo = GroupNo.Value
        Dim strHMode = Mode.Value.Trim()
        Dim strHCheckNum = CheckNum.Value.Trim()
        Dim strHDispMode = DispMode.Value.Trim()

        '20200228 DELETE
        'Dim strHGroupNo = GroupNo.Value.Trim()
        'Dim strHGroupName = GroupName.Value.Trim()

        '20200219
        Dim Search_Class As New index_Class

        Select Case strHMode
            Case "Detail"   '20200212 javascriptで実施
                ''詳細画面へ遷移　detail.asp
                ''strHCheckNum
                'Server.Transfer("Detail.aspx")

            Case "Issue"    '20200218 javascriptで実施
                '発行処理　Index.asp
                'strHCheckNum
                'TODO: データ取得
                'Dim Title = Trim(ObjDWH("Title"))
                'Dim IssueRicohNum = ObjDWH("RicohNum")

                'TODO: release時
                'PDFの発行
                'If IssueRicohNum <> "" And IsNothing(IssueRicohNum) = False Then
                '    ' Response.Redirect "https://cust.sanwa.co.jp/php/pdf/admin_estimate_system_pdf.php?cno=" & Trim(Request.Form("IssueNo")) & "&pname=" & IssueRicohNum
                '    'Response.Redirect "https://www.sanwa.co.jp/sanwa_ch/pdf/estimate_download.php?cno=" & Trim(Request.Form("IssueNo")) & "&pname=" & IssueRicohNum
                '    Response.Redirect("https://www.sanwa.co.jp/sanwa_ch/pdf/estimate_download.php?cno=" & strHCheckNum & "&pname=" & IssueRicohNum)
                'Else
                '    If Title <> "" Then
                '        ' Response.Redirect "https://cust.sanwa.co.jp/php/pdf/admin_estimate_system_pdf.php?cno=" & Trim(Request.Form("IssueNo")) & "&pname=" & Title
                '        'Response.Redirect "https://www.sanwa.co.jp/sanwa_ch/pdf/estimate_download.php?cno=" & Trim(Request.Form("IssueNo")) & "&pname=" & Title
                '        Response.Redirect("https://www.sanwa.co.jp/sanwa_ch/pdf/estimate_download.php?cno=" & strHCheckNum & "&pname=" & Title)
                '    Else
                '        ' Response.Redirect "https://cust.sanwa.co.jp/php/pdf/admin_estimate_system_pdf.php?cno=" & Trim(Request.Form("IssueNo")) & "&pname=" & Trim(Request.Form("IssueNo"))
                '        'Response.Redirect "https://www.sanwa.co.jp/sanwa_ch/pdf/estimate_download.php?cno=" & Trim(Request.Form("IssueNo")) & "&pname=" & Trim(Request.Form("IssueNo"))
                '        Response.Redirect("https://www.sanwa.co.jp/sanwa_ch/pdf/estimate_download.php?cno=" & strHCheckNum & "&pname=" & strHCheckNum)
                '    End If
                'End If

            Case "Reply"    '20200302 javascriptで実施
                'TODO:
                '回答画面へ遷移　check.asp
                'strHCheckNum

                '20200302 EDIT
                'Server.Transfer("~/Pages/Check/Check.aspx")

            Case "Delete"
                '20200219 削除処理追加
                Search_Class.DeleteButton_Click_Class(strHCheckNum)

                'データ再取得
                '※検索処理を流用。別の仕組みを考えたい
                Dim strMassage As String = String.Empty

                strMassage = Search_Result()
                lblErrMsg.Text = strMassage

                'TODO:
                '削除処理　Index.aspx
                'strHCheckNum
                flg = True

            Case "Conclusion"
                '20200219 成約状況更新処理
                Search_Class.ConclusionStatusChange(strHCheckNum, strHDispMode)

                'データ再取得
                '※検索処理を流用。別の仕組みを考えたい
                Dim strMassage As String = String.Empty

                strMassage = Search_Result()
                lblErrMsg.Text = strMassage

                'TODO:
                '成約状況更新処理　（既存：ES_ConclusionStatusChange.asp）
                'strHCheckNum
                'strHDispMode=0,1,2,3

                flg = True

            Case "CSV"
                'TODO:
                'CSVダウンロード処理　（既存：csv_download.asp）
                'strHCheckNum

                '↓20200311
                flg = DownloadCSV_index(Response, strHMode)
                '↑20200311

                'TODO:画面表示

                flg = True

            Case "CH"
                'TODO:
                'サンワCh表示処理　index.asp
                'strHCheckNum
                'strHDispMode
                If Not String.IsNullOrEmpty(strHCheckNum) AndAlso Not String.IsNullOrEmpty(strHDispMode) Then
                    '20200219 削除処理追加
                    Search_Class.SanwaChButton_Click_Class(strHCheckNum, strHDispMode)

                    'データ再取得
                    '※検索処理を流用。別の仕組みを考えたい
                    Dim strMassage As String = String.Empty

                    strMassage = Search_Result()
                    lblErrMsg.Text = strMassage

                    'If strHDispMode.Equals("on") Then
                    '    'TODO: データ取得
                    '    'ObjDWH("SanwaChDispFlag") = 1
                    'Else
                    '    'TODO: データ取得
                    '    'ObjDWH("SanwaChDispFlag") = 0
                    'End If
                    'TODO: ｻﾝﾜCh　一覧再表示
                    flg = True
                End If

            Case Else
                '20200206 検索結果表示処理
                '↓20200212 エラーメッセージ対応
                Dim strMassage As String = String.Empty

                strMassage = Search_Result()
                lblErrMsg.Text = strMassage

                'TODO:try-catch必要あり
                'TODO:検索結果をreturnして、エラー画面への遷移判断必要
                'Search_Result()
                '↑20200212

                flg = True
        End Select

        'TODO:
        If flg Then
            '成功の場合

        Else
            'エラーの場合
            'TODO:エラー画面へ

        End If

        'hiddenクリア
        Mode.Value = "Search"

    End Sub
#End Region

    'Protected Sub BtnToday_Click(sender As Object, e As EventArgs) Handles BtnToday.Click

    'End Sub

    'Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click
    '    Label37.Text = DateTime.Now.ToString()

    'End Sub

#Region "Privateメソッド"

#Region "入力値チェック処理"
    Private Function GetParam(ByVal Require As Requirement) As StringBuilder

        Dim bufMsg As StringBuilder = New StringBuilder()

        'TODO:trimとhtmlencode必要

        Require.CheckNum = txtCheckNum.Text                                 '見積書番号

        Require.PageMode = rblPageMode.SelectedValue                        '検索モード radio

        'TODO: 仮 検索期間
        Dim strFromDate As String = Util.getHankaku(Server.HtmlEncode(txtStartDate.Text.Trim))
        Dim strToDate As String = Util.getHankaku(Server.HtmlEncode(txtEndDate.Text.Trim))
        Dim fromDate As DateTime = Nothing
        Dim toDate As DateTime = Nothing
        Dim flgDate As Boolean = True
        Try
            'fromDate = DateTime.Parse(strFromDate)
            flgDate = Util.IsValidatedDate(strFromDate, "yyyy-MM-dd", fromDate)
            If Not flgDate Then
                bufMsg.Append("検索期間:開始の日付が正しくない")
            End If
        Catch ex As Exception
            bufMsg.Append("検索期間:開始の日付が正しくない")
            bufMsg.AppendLine()
            flgDate = False
        End Try
        Try
            'toDate = DateTime.Parse(strToDate)
            flgDate = Util.IsValidatedDate(strToDate, "yyyy-MM-dd", toDate)
            If Not flgDate Then
                bufMsg.Append("検索期間:終了の日付が正しくない")
            End If
        Catch ex As Exception
            bufMsg.Append("検索期間:終了の日付が正しくない")
            bufMsg.AppendLine()
            flgDate = False
        End Try
        If flgDate Then
            If Util.IsRange(fromDate, toDate) Then
                Require.StartDate = strFromDate
                Require.EndDate = strToDate
            Else
                bufMsg.Append("検索期間:開始と終了の日付が正しくない")
                bufMsg.AppendLine()
                flgDate = False
            End If
        End If

        Require.StartDate = txtStartDate.Text                               '検索期間
        Require.EndDate = txtEndDate.Text

        Require.AreaCode = rblAreaCode.SelectedValue                        '所属 radio
        Require.CustomerCode = txtCustomerCode.Text                         '販売店CD
        Require.CustomerSort = chbCustomerSort.Checked                      '得意先CDでソート checkbox
        Require.SalesPerson = txtSalesPerson.Text                           'サンワ担当者名・コード
        Require.DevSupPerson = txtDevSupPerson.Text                         '開発・仕入担当
        Require.SearchName = txtSearchName.Text                             '販売店・部署・担当者名
        Require.CreatePerson = txtCreatePerson.Text                         '作成者名・コード
        Require.SearchTitle = txtSearchTitle.Text                           '見積件名
        Require.KOSTL = ddlKOSTL.SelectedValue                              '班 
        Require.SearchMemo = txtSearchMemo.Text                             'メモ書き
        Require.ConclusionStatus = ddlConclusionStatus.Text                 '成約状況
        Require.ProductCode = txtProductCode.Text                           '品番
        Require.Quantity = txtQuantity.Text                                 '数量
        Require.QuantityMark = ddlQuantityMark.SelectedItem.Text            '数量マーク Selectedvalue
        Require.ContinuationFlag = ddlContinuationFlag.SelectedItem.Text    '継続案件フラグ
        Require.EndUserPref = ddlEndUserPref.SelectedItem.Text              'エンドユーザ都道府県
        Require.ProjectFlag = ddlProjectFlag.SelectedItem.Text              '案件管理
        Require.EndUserName = txtEndUserName.Text                           '最終ユーザ名
        Require.GroupNo = txtGroupNo.Text                                   'グループNo
        Require.GroupName = txtGroupName.Text                               'グループ名
        Require.RicohNum = txtRicohNum.Text                                 '案件番号(RICOH)
        Require.RCode = txtRCode.Text                                       '品種コード(RICOH)
        Require.FixCheck = chbFixCheck.Checked                              '仮登録のみ

        Return bufMsg

    End Function
#End Region

    '20200212 検索結果ページ切り替え処理
    Private Sub grvSearch_Result_PageIndexChanging(sender As Object, e As GridViewPageEventArgs) Handles grvSearch_Result.PageIndexChanging
        '20200219 1ページ目・最終ページでは処理を行わない
        If e.NewPageIndex > -1 AndAlso e.NewPageIndex < grvSearch_Result.PageCount Then
            Dim strMassage As String = String.Empty

            grvSearch_Result.PageIndex = e.NewPageIndex
            strMassage = Search_Result()
            lblErrMsg.Text = strMassage

            'ページングボタン有効・無効制御
            grvSearch_Result_PagingButton_Enabled()
        End If
    End Sub

    '20200219 ページングボタン有効・無効制御
    Private Sub grvSearch_Result_PagingButton_Enabled()
        Dim gvrPager As GridViewRow = grvSearch_Result.BottomPagerRow
        Dim firstbutton As LinkButton = CType(gvrPager.Cells(0).FindControl("LinkButton1"), LinkButton)
        Dim prevbutton As LinkButton = CType(gvrPager.Cells(0).FindControl("LinkButton2"), LinkButton)
        Dim nextbutton As LinkButton = CType(gvrPager.Cells(0).FindControl("LinkButton3"), LinkButton)
        Dim endbutton As LinkButton = CType(gvrPager.Cells(0).FindControl("LinkButton4"), LinkButton)

        If grvSearch_Result.PageIndex = 0 Then
            firstbutton.Enabled = False
            prevbutton.Enabled = False
        ElseIf grvSearch_Result.PageIndex = grvSearch_Result.PageCount - 1 Then
            nextbutton.Enabled = False
            endbutton.Enabled = False
        End If
    End Sub

    '↓20200206／20200212 Search_Result()をStringに変更
#Region "検索結果表示処理"
    Private Function Search_Result() As String
        Dim Message As String = String.Empty

        Try
            Dim Search_Class As New index_Class
            Dim Require As New Requirement
            Dim Result_DataTable As DataTable

            'TODO:20200228 日付チェック＆範囲チェック　StartDate　EndDate必要↓
            'Util.IsValidatedDate 作成済
            'Util.IsRange 作成済
            'TODO:20200228 数字のみ、記号有無チェック必要↓
            'TODO:20200228 クラスを作成して、別メソッドで共通部品として実装すべき↓

            '検索条件
            '↓20200212 エンコード追加 (Util.getAllHankaku(Server.HtmlEncode(xxxxxx.Text.Trim)))
            '20200219 半角判定が必要なもののみ、Util.getHankakuを適用するよう変更
            '20200311 検索条件の処理を関数化
            Require = Require_Set()
            '↑20200212

            'TODO:複数件のエラーの場合の処理必要↓

            '↓20200219 入力文字列チェック
            '20200311 入力チェック処理を関数化
            Message = Require_Check(Require)

            '入力エラーメッセージ有
            If Message <> "" Then
                Return Message
            End If
            '↑20200219

            '検索結果取得
            Result_DataTable = Search_Class.SearchButton_Click_Class(Require)

            '20200212 0件条件追加
            If Result_DataTable.Rows.Count = 0 Then
                'データ表示不可
                grvSearch_Result.Visible = False

                '20200219 改行をEnvironment.NewLine→<br />に変更
                'Message = "検索結果が 0件 の為、表示できません。<br />検索条件を変更して再度検索してください。"
                '20200305 EDIT 改行を削除
                Message = "検索結果が 0件 の為、表示できません。検索条件を変更して再度検索してください。"

                'ADD 20200228
                lblResultCount.Text = Result_DataTable.Rows.Count.ToString + "件見つかりました。"
                lblResultMsg.Text = ""
                lblResultMsg.Visible = False
                'lblErrMsg.Text = Message

            ElseIf Result_DataTable.Rows.Count >= 10000 Then
                '20200219 不等号を">"から">="に修正
                'データ表示不可
                grvSearch_Result.Visible = False

                '20200219 改行をEnvironment.NewLine→<br />に変更
                'Message = "検索結果が 10000件 以上の為、表示できません。<br />検索条件を変更して再度検索してください。"
                '20200305 EDIT 改行を削除
                Message = "検索結果が 10000件 以上の為、表示できません。検索条件を変更して再度検索してください。"

                'ADD 20200228
                lblResultCount.Text = ""
                lblResultMsg.Text = Message
                lblResultMsg.Visible = True
                'lblErrMsg.Text = Message

            Else
                grvSearch_Result.Visible = True

                Message = Result_DataTable.Rows.Count.ToString + "件見つかりました。"

                'ADD 20200228
                lblResultCount.Text = Message
                lblErrMsg.Text = ""
                lblResultMsg.Text = ""
                lblResultMsg.Visible = False

                '※明細表示・非表示で数量／金額単価ヘッダーの文字列を変更する
                If Require.PageMode = 0 Then
                    '金額
                    grvSearch_Result.Columns(3).HeaderText = "数量<br />金額"
                Else
                    '単価
                    grvSearch_Result.Columns(3).HeaderText = "数量<br />単価"
                End If

                Dim SearchResult_Table As New DataTable

                For i As Integer = 0 To 17
                    SearchResult_Table.Columns.Add()
                Next

                SearchResult_Table.Columns(0).ColumnName = "0"
                SearchResult_Table.Columns(1).ColumnName = "1"
                SearchResult_Table.Columns(2).ColumnName = "2"
                SearchResult_Table.Columns(3).ColumnName = "3"
                SearchResult_Table.Columns(4).ColumnName = "4"
                SearchResult_Table.Columns(5).ColumnName = "5"
                SearchResult_Table.Columns(6).ColumnName = "6_text"
                SearchResult_Table.Columns(7).ColumnName = "6_button_text"
                SearchResult_Table.Columns(8).ColumnName = "6_button_visible"
                SearchResult_Table.Columns(9).ColumnName = "6_button_click"
                SearchResult_Table.Columns(10).ColumnName = "7_shosai"
                SearchResult_Table.Columns(11).ColumnName = "7_hakko"
                SearchResult_Table.Columns(12).ColumnName = "7_kaito"
                SearchResult_Table.Columns(13).ColumnName = "7_kaito_visible"
                SearchResult_Table.Columns(14).ColumnName = "7_sakujo"
                SearchResult_Table.Columns(15).ColumnName = "8_project"
                SearchResult_Table.Columns(16).ColumnName = "8_projectmail"
                SearchResult_Table.Columns(17).ColumnName = "8_conclusionmail"

                For Each data As DataRow In Result_DataTable.Rows
                    Dim row As DataRow = SearchResult_Table.NewRow
                    Dim arrCheckNum As Array
                    Dim dCheckNum As String = String.Empty

                    '見積番号
                    If InStr(data("CheckNum").ToString, "-") > 0 Then
                        'DBの抽出条件用に"-"以降を排除
                        arrCheckNum = Split(data("CheckNum").ToString, "-")
                        dCheckNum = Trim(arrCheckNum(0).ToString)
                    Else
                        dCheckNum = Trim(data("CheckNum").ToString)
                    End If

                    '20200220 明細表示モードの見積番号表示は"-"付きにする
                    row("0") = "<a href=""javascript: estimateSystemSearchAdvance('" + dCheckNum + "');"">" + data("CheckNum") + "</a>"
                    'row("0") = "<a href=""./Detail.aspx?cno=" + dCheckNum + """>" + data("CheckNum") + "</a>"

                    '↓20200219 案件番号(RICOH)表示対応
                    If Require.PageMode = 1 Then
                        '明細表示の場合
                        If data("RicohNum").ToString <> "" Then
                            row("0") += "<span style=""color: #F00;"">" + data("RicohNum") + "</span>"
                        End If
                    End If
                    '↑20200219

                    '販売店CD／販売店名／担当者名
                    Dim CustomerName As String = String.Empty

                    If data("CustomerName").ToString.Length > 30 Then
                        For i As Integer = 0 To 30
                            If Util.LenB(CustomerName + data("CustomerName").substring(i, 1)) <= 30 Then
                                CustomerName += data("CustomerName").substring(i, 1)
                            Else
                                Exit For
                            End If
                        Next
                    Else
                        CustomerName = data("CustomerName").ToString
                    End If

                    row("1") = data("CustomerCode").ToString + "<br />" + CustomerName + "<br />" + data("CustomerPersonName").ToString

                    If data("GroupNo").ToString <> "" Then
                        row("1") += "<br />" + data("GroupNo").ToString + "    " + data("GroupName").ToString
                    End If

                    '見積件名／最終ユーザー名／品番
                    Dim GroupDisp As String = String.Empty
                    Dim DispConclusionStatus As String = String.Empty
                    Dim Title As String = String.Empty

                    If data("GroupNo").ToString <> "" Then
                        GroupDisp = "<a href=""javascript: estimateSystemListGroupWindow('" + data("GroupNo") + "');"">【" + data("GroupNo") + "】" + data("GroupName") + "</a>"
                    End If

                    If GroupDisp <> "" Then
                        row("2") = GroupDisp + "<br />"
                    End If

                    If data("ConclusionStatus").ToString <> "" Then
                        Select Case data("ConclusionStatus")
                            Case "継続中"
                                DispConclusionStatus = "<span id=""CSBtn_" + dCheckNum + """ onclick=""estimateSystemIndexConclusionChange('" + dCheckNum + "');"" class=""ConcSt"" style=""color: #999;"">【"
                            Case "成約"
                                DispConclusionStatus = "<span id=""CSBtn_" + dCheckNum + """ onclick=""estimateSystemIndexConclusionChange('" + dCheckNum + "');"" class=""ConcSt"" style=""color: #00F;"">【"
                            Case "一部成約"
                                DispConclusionStatus = "<span id=""CSBtn_" + dCheckNum + """ onclick=""estimateSystemIndexConclusionChange('" + dCheckNum + "');"" class=""ConcSt"" style=""color: #00F;"">【"
                            Case "不成約"
                                DispConclusionStatus = "<span id=""CSBtn_" + dCheckNum + """ onclick=""estimateSystemIndexConclusionChange('" + dCheckNum + "');"" class=""ConcSt"" style=""color: #F00;"">【"
                        End Select

                        DispConclusionStatus += data("ConclusionStatus") + "】</span><br />"
                    Else
                        DispConclusionStatus = ""
                    End If

                    If data("Title").ToString.Length > 35 Then
                        For i As Integer = 0 To 35
                            If Util.LenB(Title + data("Title").substring(i, 1)) <= 35 Then
                                Title += data("Title").substring(i, 1)
                            Else
                                Exit For
                            End If
                        Next
                    Else
                        Title = data("Title").ToString
                    End If

                    If Title <> "" Then
                        row("2") += DispConclusionStatus + Title
                    End If

                    If data("ProjectFlag").ToString = "1" Then
                        If data("EndUserName").ToString <> "" Then
                            If row("2").ToString <> "" Then
                                row("2") += "<br />"
                            End If

                            row("2") += data("EndUserName")
                        End If
                    Else
                        If data("RCode").ToString <> "" Then
                            If row("2").ToString <> "" Then
                                row("2") += "<br />"
                            End If

                            row("2") += data("RCode")
                        End If
                    End If

                    '数量／金額単価
                    If data("Quantity").ToString <> "" AndAlso data("SubTotalPrice").ToString <> "" Then
                        row("3") = FormatNumber(data("Quantity"), 0, -1, 0, -1) + "<br />&yen;" + FormatNumber(data("SubTotalPrice"), 0, -1, 0, -1)
                    Else
                        row("3") = ""
                    End If

                    '担当営業／アシスタント
                    row("4") = data("SalesPersonName").ToString + "<br />" + data("AssistantName").ToString

                    '見積者／最終更新日
                    '↓20200212 UpdateTime 10桁表示対応
                    Dim updatetime As String = String.Empty

                    updatetime = data("UpdateTime").ToString

                    If data("UpdateTime").ToString.Length > 10 Then
                        updatetime = Left(data("UpdateTime").ToString, 10)
                    Else
                        updatetime = data("UpdateTime").ToString
                    End If

                    row("5") = data("CreatePersonName").ToString + "<br />" + updatetime
                    '↑20200212

                    '状態
                    If data("ParentCheckNum").ToString <> "" Then
                        row("6_text") = "継続:<br /><a href=""./Detail.aspx?cno=" + Trim(data("ParentCheckNum")) + """>" + Trim(data("ParentCheckNum")) + "</a>ｻﾝﾜCh非表示"
                        row("6_button_text") = ""
                        row("6_button_visible") = "false"
                        row("6_button_click") = ""
                    ElseIf data("FixFlag").ToString = "1" OrElse IsDBNull(data("FixFlag")) = True Then
                        row("6_text") = "本登録"
                        row("6_button_visible") = "true"

                        If data("SanwaChDispFlag").ToString = "1" Then
                            row("6_button_text") = "ｻﾝﾜCh表示"
                            row("6_button_click") = "estimateSystemDispChange('off','" + Trim(dCheckNum) + "'); return true;"
                        Else
                            row("6_button_text") = "ｻﾝﾜCh非表示"
                            row("6_button_click") = "estimateSystemDispChange('on','" + Trim(dCheckNum) + "'); return true;"
                        End If
                    Else
                        row("6_text") = "仮登録<br />ｻﾝﾜCh非表示"
                        row("6_button_text") = ""
                        row("6_button_visible") = "false"
                        row("6_button_click") = ""
                    End If

                    'ボタン
                    '20200219 記述修正
                    row("7_shosai") = "estimateSystemSearchAdvance('" + Trim(dCheckNum) + "'); return true;"
                    row("7_hakko") = "estimateSystemSearchIssue('" + Trim(dCheckNum) + "'); return true;"
                    row("7_kaito") = "estimateSystemSearchCheck('" + Trim(dCheckNum) + "'); return true;"
                    row("7_sakujo") = "estimateSystemSearchDelete('" + Trim(dCheckNum) + "'); return true;"

                    If Session("AdminFlag") = "1" Then
                        '回答ボタン表示
                        row("7_kaito_visible") = True
                    Else
                        '回答ボタン非表示
                        row("7_kaito_visible") = False
                    End If

                    '案件管理／メール送信状況
                    If data("ProjectFlag").ToString = "1" Then
                        row("8_project") = "する"
                    Else
                        row("8_project") = "しない"
                    End If

                    If data("ProjectMailSubmitFlag").ToString = "1" Then
                        row("8_projectmail") = "送信済"
                    Else
                        row("8_projectmail") = "未送信"
                    End If

                    If data("ConclusionMailSubmitFlag").ToString = "1" Then
                        row("8_conclusionmail") = "送信済"
                    Else
                        row("8_conclusionmail") = "未送信"
                    End If

                    SearchResult_Table.Rows.Add(row)
                Next

                grvSearch_Result.DataSource = SearchResult_Table
                grvSearch_Result.DataBind()

                '20200219 ページングボタン有効・無効制御
                grvSearch_Result_PagingButton_Enabled()
            End If
        Catch ex As Exception
            If Message <> "" Then
                Message = "検索結果の取得に失敗しました：" + Environment.NewLine + Message
            Else
                Message = "検索結果の取得に失敗しました：" + Environment.NewLine + ex.Message
            End If

            Return Message
        End Try

        Return Message
    End Function
#End Region
    '↑20200206

    '↓20200311
    '入力された検索条件をセット
    Private Function Require_Set() As Requirement
        Dim Result As New Requirement

        '検索条件
        Result.CheckNum = Util.getHankaku(Server.HtmlEncode(txtCheckNum.Text.Trim))                '見積書番号
        Result.PageMode = rblPageMode.SelectedValue                                                '検索モード radio
        Result.StartDate = Util.getHankaku(Server.HtmlEncode(txtStartDate.Text.Trim))              '検索期間
        Result.EndDate = Util.getHankaku(Server.HtmlEncode(txtEndDate.Text.Trim))
        Result.AreaCode = rblAreaCode.SelectedValue                                                '所属 radio
        Result.CustomerCode = Util.getHankaku(Server.HtmlEncode(txtCustomerCode.Text.Trim))        '販売店CD
        Result.CustomerSort = chbCustomerSort.Checked                                              'checkbox
        Result.SalesPerson = Server.HtmlEncode(txtSalesPerson.Text.Trim)                           'サンワ担当者名・コード
        Result.DevSupPerson = Server.HtmlEncode(txtDevSupPerson.Text.Trim)                         '開発・仕入担当
        Result.SearchName = Server.HtmlEncode(txtSearchName.Text.Trim)                             '販売店・部署・担当者名
        Result.CreatePerson = Server.HtmlEncode(txtCreatePerson.Text.Trim)                         '作成者名・コード
        Result.SearchTitle = Server.HtmlEncode(txtSearchTitle.Text.Trim)                           '見積件名
        Result.KOSTL = ddlKOSTL.SelectedValue                                                      '班 
        Result.SearchMemo = Server.HtmlEncode(txtSearchMemo.Text.Trim)                             'メモ書き
        Result.ConclusionStatus = Server.HtmlEncode(ddlConclusionStatus.Text.Trim)                 '成約状況
        Result.ProductCode = Server.HtmlEncode(txtProductCode.Text.Trim)                           '品番
        Result.Quantity = Util.getHankaku(Server.HtmlEncode(txtQuantity.Text.Trim))                '数量
        Result.QuantityMark = Server.HtmlEncode(ddlQuantityMark.SelectedItem.Text.Trim)            '数量マーク Selectedvalue
        Result.ContinuationFlag = Server.HtmlEncode(ddlContinuationFlag.SelectedItem.Text.Trim)    '継続案件フラグ
        Result.EndUserPref = Server.HtmlEncode(ddlEndUserPref.SelectedItem.Text.Trim)              'エンドユーザ都道府県
        Result.ProjectFlag = Server.HtmlEncode(ddlProjectFlag.SelectedItem.Text.Trim)              '案件管理
        Result.EndUserName = Server.HtmlEncode(txtEndUserName.Text.Trim)                           '最終ユーザ名
        Result.GroupNo = Util.getHankaku(Server.HtmlEncode(txtGroupNo.Text.Trim))                  'グループNo
        Result.GroupName = Server.HtmlEncode(txtGroupName.Text.Trim)                               'グループ名
        Result.RicohNum = Util.getHankaku(Server.HtmlEncode(txtRicohNum.Text.Trim))                '案件番号(RICOH)
        Result.RCode = Util.getHankaku(Server.HtmlEncode(txtRCode.Text.Trim))                      '品種コード(RICOH)
        Result.FixCheck = chbFixCheck.Checked                                                      '仮登録のみ

        Return Result
    End Function

    '入力された検索条件をチェック
    Private Function Require_Check(ByVal Require As Requirement) As String
        Dim Message As String = String.Empty
        Dim Result As String = String.Empty

        'TODO:複数件のエラーの場合の処理必要↓

        '見積書番号
        If Message = "" Then
            If Require.CheckNum <> "" Then
                If Util.IsHankaku(Require.CheckNum) = True Then
                    If Require.CheckNum.Length > 12 Then
                        Message = "見積書番号は12文字までの半角英数字を入力してください。"
                    End If
                Else
                    Message = "見積書番号に全角文字が含まれています。12文字までの半角英数字を入力してください。"
                End If
            End If
        End If

        '得意先CD
        If Message = "" Then
            If Require.CustomerCode <> "" Then
                If Util.IsHankaku(Require.CustomerCode) = True Then
                    If IsNumeric(Require.CustomerCode) = False OrElse Require.CustomerCode.Length > 10 Then
                        Message = "得意先CDは10文字までの半角数字を入力してください。"
                    End If
                Else
                    Message = "得意先CDに全角文字が含まれています。10文字までの半角数字を入力してください。"
                End If
            End If
        End If

        '数量
        If Message = "" Then
            If Require.Quantity <> "" Then
                If Util.IsHankaku(Require.Quantity) = True Then
                    If IsNumeric(Require.Quantity) = False OrElse Require.Quantity.Length > 10 Then
                        Message = "数量は10文字までの半角数字を入力してください。"
                    End If
                Else
                    Message = "数量に全角文字が含まれています。10文字までの半角数字を入力してください。"
                End If
            End If
        End If

        'グループNo
        If Message = "" Then
            If Require.GroupNo <> "" Then
                If Util.IsHankaku(Require.GroupNo) = True Then
                    If Require.GroupNo.Length > 11 Then
                        Message = "グループNoは11文字までの半角英数字を入力してください。"
                    End If
                Else
                    Message = "グループNoに全角文字が含まれています。11文字までの半角英数字を入力してください。"
                End If
            End If
        End If

        '案件番号(RICOH)
        If Message = "" Then
            If Require.RicohNum <> "" Then
                If Util.IsHankaku(Require.RicohNum) = True Then
                    If Require.RicohNum.Length > 13 Then
                        Message = "案件番号(RICOH)は13文字までの半角英数字を入力してください。"
                    End If
                Else
                    Message = "案件番号(RICOH)に全角文字が含まれています。13文字までの半角英数字を入力してください。"
                End If
            End If
        End If

        '品種コード(RICOH)
        If Message = "" Then
            If Require.RCode <> "" Then
                If Util.IsHankaku(Require.RCode) = True Then
                    If Require.RCode.Length > 6 Then
                        Message = "品種コード(RICOH)は6文字までの半角英数字を入力してください。"
                    End If
                Else
                    Message = "品種コード(RICOH)に全角文字が含まれています。13文字までの半角英数字を入力してください。"
                End If
            End If
        End If

        Return Result
    End Function

#Region "CSVダウンロード処理"
    Private Function DownloadCSV_index(ByRef Response As HttpResponse, ByVal strHMode As String) As Boolean
        Dim CSV_Common As New CSV_Common
        Dim Search_Class As New index_Class
        Dim Require As New Requirement
        Dim CsvText As String = String.Empty
        Dim Message As String = String.Empty
        Dim Result As New Boolean

        '検索条件セット・チェック
        Require = Require_Set()
        Message = Require_Check(Require)

        If Message <> "" Then
            '検索条件チェックエラーの場合
            Return False
        End If

        CsvText = Search_Class.Create_CSV_index(Require, strHMode)

        '書き込み処理
        Result = CSV_Common.Download_CSV(Response, CsvText, "", "")

        Return Result

    End Function
#End Region
    '↑20200311

#Region "'都道府県をセット"
    Private Sub SetListEndUserPref()

        Dim li As ListItem = New ListItem("未指定", "")
        ddlEndUserPref.Items.Add(li)

        Dim PrefList As New List(Of String)(New String() {"北海道", "青森県", "岩手県", "宮城県", "秋田県", "山形県", "福島県", "茨城県", "栃木県", "群馬県", "埼玉県", "千葉県", "東京都", "神奈川県", "新潟県", "富山県", "石川県", "福井県", "山梨県", "長野県", "岐阜県", "静岡県", "愛知県", "三重県", "滋賀県", "京都府", "大阪府", "兵庫県", "奈良県", "和歌山県", "鳥取県", "島根県", "岡山県", "広島県", "山口県", "徳島県", "香川県", "愛媛県", "高知県", "福岡県", "佐賀県", "長崎県", "熊本県", "大分県", "宮崎県", "鹿児島県", "沖縄県"})
        For Each Pref In PrefList
            li = New ListItem(Pref, Pref)
            ddlEndUserPref.Items.Add(li)
        Next

        ddlEndUserPref.SelectedIndex = 0

    End Sub
#End Region

    '20200206
#Region "'班リストをセット"
    Private Sub SetListKOSTL()

        ddlKOSTL.Items.Clear()
        CreateKOSTLList()

        'Set the default selected item, if desired.
        ddlKOSTL.SelectedIndex = 0

    End Sub
#End Region

    '20200206
#Region "'班リスト作成"
    Private Sub CreateKOSTLList()

        'クラスのListをBind
        Dim kList = New List(Of KOSTL)
        kList.Add(New KOSTL("", "すべて"))

        '↓20200206
        '班リスト取得
        Dim Search_Query As New index_Query
        'TODO:20200210↓
        Dim KOSTL_DataTable As DataTable

        'DBから班情報を取得
        KOSTL_DataTable = Search_Query.get_uCSKT("uCSKT")

        'バインド用リスト生成
        For Each row As DataRow In KOSTL_DataTable.Rows
            kList.Add(New KOSTL(row("CSKT_KOSTL").ToString, row("CSKT_KTEXT").ToString))
        Next
        '↑20200206

        'kList.Add(New KOSTL("B10040", "岡山営業 柆生班"))
        'kList.Add(New KOSTL("B10050", "岡山営業 和田班"))
        'kList.Add(New KOSTL("B10060", "岡山営業 丸本班"))
        'TODO:20200210↑

        ddlKOSTL.DataSource = kList
        ddlKOSTL.DataValueField = "value"
        ddlKOSTL.DataTextField = "name"
        ddlKOSTL.DataBind()

    End Sub
#End Region

#End Region

End Class

Public Class KOSTL
    Public Property value As String
    Public Property name As String

    Public Sub New(ByVal str1 As String, ByVal str2 As String)
        value = str1
        name = str2
    End Sub

End Class