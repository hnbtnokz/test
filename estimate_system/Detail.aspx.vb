Imports System.IO
Imports System.Collections.Generic
Imports Newtonsoft.Json
Imports System.Text
Imports estimate_system.Common

Public Class Detail
    Inherits System.Web.UI.Page

    Public Shared cookiemembercd As String = ""

#Region "Events"
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        'If HttpContext.Current.Session("SESSIONTIMEOUTFLG") Is Nothing Then
        '    ' セッション切れ処理終了
        '    Exit Sub
        'End If

        ' セッション切れ処理終了
        If HttpContext.Current.Session("SESSIONID") <> Session.SessionID Then
            Response.Redirect("Login.aspx", False)
            Exit Sub
        End If

        'Dim strHCheckNum As String = Nothing
        'If Not IsNothing(Page.PreviousPage) Then
        '    Dim param1 As HiddenField = CType(Page.PreviousPage.FindControl("ctl00$body$CheckNum"), HiddenField)
        '    If Not IsNothing(param1) AndAlso Not IsNothing(param1.Value) Then
        '        strHCheckNum = param1.Value.Trim()
        '    Else
        '        Exit Sub
        '    End If
        'End If

        '20200309 MOVE
        If IsNothing(Request.QueryString("cno")) OrElse Request.QueryString("cno").Trim().Equals(String.Empty) Then
            Exit Sub
        End If

        '2020039 ADD
        'If Not String.IsNullOrEmpty("SubmitMode") AndAlso SubmitMode.Value.Equals("save") Then
        '20200313 EDIT SubmitMode.Value
        If Not String.IsNullOrEmpty(SubmitMode.Value) AndAlso SubmitMode.Value.Trim().Equals("save") Then
            'TODO:javescriptからの呼び出しを他の処理と同様に統一すべき

        Else
            '20200309 MOVE
            If IsNothing(Request.QueryString("cno")) OrElse Request.QueryString("cno").Trim().Equals(String.Empty) Then
                Exit Sub
            End If
        End If

        '20200309 ADD
        Dim strMode = Nothing
        Dim strCheckNum = Nothing
        If Not IsNothing(Request.QueryString("mode")) AndAlso Not Request.QueryString("mode").Trim().Equals(String.Empty) Then
            strMode = Request.QueryString("mode").Trim()
            strCheckNum = Request.QueryString("cno").Trim()

            Select Case strMode
                Case "CSV"
                    'TODO:詳細　CSVダウンロード
                    '共通クラス・メソッド使いにする
                    Dim strAreaCode = 2
                    Dim strRicohNum = Nothing

                    '↓20200311
                    Dim Result As New Boolean

                    strRicohNum = Get_RicohNum(strCheckNum)
                    Result = DownloadCSV_detail(Response, strCheckNum, strRicohNum)
                    '↑20200311

                    'If strRicohNum <> "" Then
                    '    Response.AddHeader("Content-Disposition", "attachment;filename=" & strRicohNum & ".csv")
                    'Else
                    '    Response.AddHeader("Content-Disposition", "attachment;filename=" & strCheckNum & ".csv")
                    'End If

                Case "bill", "issue"
                    'TODO:詳細　請求書・見積書発行
                    Dim strIssueRicohNum = Nothing
                    Dim strTitle = Nothing

                    '20200311 IssueRicohNum取得処理
                    strIssueRicohNum = EstimateDetailIssue(strCheckNum)

                    ' PDFの発行
                    ' Dim PDF_URL = "https://cust.sanwa.co.jp/php/pdf/admin_estimate_system_pdf.php"
                    'Dim PDF_URL = "https://www.sanwa.co.jp/sanwa_ch/pdf/estimate_download.php"
                    'TODO:テスト必要
                    Dim PDF_URL = ""
                    If Not String.IsNullOrEmpty(strIssueRicohNum) Then
                        PDF_URL = PDF_URL & "?cno=" & strCheckNum & "&pname=" & strIssueRicohNum
                    Else
                        If Not String.IsNullOrEmpty(strTitle) Then
                            PDF_URL = PDF_URL & "?cno=" & strCheckNum & "&pname=" & strTitle
                        Else
                            PDF_URL = PDF_URL & "?cno=" & strCheckNum & "&pname=" & strCheckNum
                        End If
                    End If

                    If strMode.Equals("bill") Then
                        PDF_URL = PDF_URL & "&mode=bill"
                    End If

            End Select

        End If


    End Sub

    Private Sub Detail_LoadComplete(sender As Object, e As EventArgs) Handles Me.LoadComplete

        Dim uri As Uri = Request.Url
        Response.Cookies("AutoLogoutPage").Value = uri.AbsoluteUri
        Response.Cookies("AutoLogoutPage").Expires = DateTime.Now.AddDays(31) ' Cookie 有効期間（31日）

    End Sub

#End Region

#Region "Methods"
    ''' <summary>
    ''' 見積案件データを取得する
    ''' </summary>
    ''' <returns></returns>
    Public Shared Function GetEstimateData(CheckNum As String, mode As String) As DataSet

        Dim SQL_Common As New SQL_Common
        Dim sql As New StringBuilder
        sql.Append("Select TEP.CheckNum, TEP.RicohNum, TEP.CreatePersonName, TEP.UpdateTime, TEP.SanwaChDispFlag, TEP.SanwaChOrderBreakFlag, " &
             "TEP.CustomerCode, TEP.CustomerName, TEP.CustomerDivision, TEP.CustomerPersonName, " &
             "TEP.SalesPersonCode, TEP.SalesPersonName, TEP.AssistantCode, TEP.AssistantName, TEP.Tel, TEP.Fax, " &
             "TEP.Title, TEP.PackingFare, TEP.DeliveryLimit, TEP.DeliverySchedule, TEP.DeliveryPlace, " &
             "TEP.EstimateLimit, TEP.EstimateLimitDisp, TEP.ConclusionDate, TEP.DisplayDate, TEP.EndUserName, TEP.Other, TEP.Contents, TEP.SalesMemo, " &
             "TEP.TaxDispFlag, TEP.TaxPercent, TEP.OpenPriceDisp, TEP.TotalPrice, TEP.MarginPriceSum, TEP.MarginRateSum, TEP.MarginRankSum, " &
             "TEP.TotalDispFlag, TEP.ReplyDate, TEP.SanwaChRequestNumber, TEP.FixFlag, TEP.ParentCheckNum, TEP.ChildCheckNum, TEP.SanwaChLoginID, TEP.FixMailBody, " &
             "TEP.ConclusionStatus, TEP.ProfessionClass1, TEP.ProfessionClass2, TEP.EndUserPref, TEP.EndUserAddress, " &
             "TEP.ContinuationFlag, TEP.ContinuationCycle, TEP.ProjectMailSubmitFlag, TEP.ConclusionMailSubmitFlag, " &
             "TEP.ProjectFlag, TEP.DeliveryLimitDate, TEP.AlertDate, " &
             "TEP.DeliveryMethod, TEP.DeliveryMethodPeriod, TEP.DeliveryMethodTimes, TEP.NoPriceDisp, " &
             "TED.Columns, TED.ProductCode, TED.ProductName, TED.OpenPrice, TED.RegularPrice, TED.Quantity, " &
             "TED.UnitRate, TED.UnitPrice, TED.SubTotalPrice, TED.DeliveryTime, TED.Memo, " &
             "TED.EigyouGenka, TED.MarginRank, TED.MarginPrice, TED.MarginRate, TED.DeleteFlag, TED.OutletFlag, TED.RCode, " &
             "TED.RivalMaker, TED.RivalSku, TED.RivalPrice, TED.RivalOther, TED.ConclusionStatusDetail, TED.PurchaseComment, TED.DevLeaderComment, " &
             "TED.NotCompletedReason1, TED.NotCompletedReason2, TED.NotCompletedReason3, TED.NotCompletedReason4, TED.NotCompletedReason5,  " &
             "TED.NotCompletedReason6, TED.NotCompletedReason7, TED.NotCompletedReason9, " &
             "TED.LeaderPrice, TED.LeaderRate, TED.CorrectionPrice, TED.CorrectionRate, TED.AutoAnswerFlag, TED.ImportantFlag, " &
             "TEG.GroupNo, TEG.GroupName, TEG.SalesPersonName " &
             "FROM tEstimateParent TEP " &
             "INNER JOIN tEstimateDetail TED " &
             "On (TEP.CheckNum = TED.CheckNum) " &
             "LEFT JOIN ( " &
             "  Select TOP(1) EB.CheckNum, EG.GroupNo, EG.GroupName, EP.SalesPersonName " &
             "  FROM tEstimateGroup EG " &
             "  INNER JOIN tEstimateGroupBody EB " &
             "  On EG.GroupNo = EB.GroupNo " &
             "  INNER Join tEstimateParent EP " &
             "  On EB.CheckNum = EP.CheckNum " &
             "  WHERE  EP.CheckNum = '" & CheckNum & "' " &
             ") TEG " &
             "ON (TEP.CheckNum = TEG.CheckNum) " &
             "WHERE TEP.CheckNum = '" & CheckNum & "' " &
             "ORDER BY TED.Columns")

        Dim ds = New DataSet
        Dim dtEst As DataTable
        Dim dtCmt As DataTable = New DataTable
        Dim dt As DataTable
        Dim StrSQL As String

        Try
            dtEst = SQL_Common.SelectSql(sql.ToString, Util.DB_SERVER)

            If dtEst.Rows.Count > 0 Then
                ' 列名/初期値/データ型を追加
                dtEst.Columns.Add(New DataColumn With {.ColumnName = "Status", .DefaultValue = String.Empty, .DataType = Type.GetType("System.String")}) 'Status

                ' ■ コピーモード判定
                If mode = "copy" Then
                    dtEst(0)("CheckNum") = ""
                    dtEst(0)("UpdateTime") = ""
                    dtEst(0)("Status") = "コピー"
                    dtEst(0)("SanwaChRequestNumber") = ""
                    dtEst(0)("ParentCheckNum") = ""
                    dtEst(0)("ChildCheckNum") = ""

                    dtEst(0)("RicohNum") = ""

                    StrSQL = "select K1.*, MM.Tel, MM.Fax " &
                             "from (" &
                                "select Right(KNVP_AE_NR,6) AS KNVP_AE_NR, KNVP_AE_NM, Right(KNVP_AC_NR,6) AS KNVP_AC_NR, KNVP_AC_NM " &
                                "from mKNA1 " &
                                "where KNA1_MANDT = '900' " &
                                "and KNA1_KUNNR = '" & dtEst(0)("CustomerCode") & "' " &
                             ") K1 " &
                             "inner join mMember MM " &
                             "on K1.KNVP_AE_NR = MM.MemberCode"
                    ' レコードを開く
                    dt = SQL_Common.SelectSql(StrSQL, Util.DW_SERVER)
                    'ObjDW.Open StrSQL, DWConn, 3, 1
                    If dt.Rows.Count > 0 Then
                        dtEst(0)("SalesPersonCode") = Right("00" & Trim(dt(0)("KNVP_AE_NR")), 8)
                        dtEst(0)("SalesPersonName") = Trim(dt(0)("KNVP_AE_NM"))
                        dtEst(0)("AssistantCode") = Right("00" & Trim(dt(0)("KNVP_AC_NR")), 8)
                        dtEst(0)("AssistantName") = Trim(dt(0)("KNVP_AC_NM"))
                        dtEst(0)("Tel") = Trim(dt(0)("Tel"))
                        dtEst(0)("Fax") = Trim(dt(0)("Fax"))
                    End If
                Else
                    ' レコードが見つかった場合のみ処理
                    If dtEst(0)("FixFlag") = "1" OrElse IsNothing(dtEst(0)("FixFlag")) Then
                        dtEst(0)("Status") = "本登録"
                        dtEst(0)("FixFlag") = 1
                    Else
                        dtEst(0)("Status") = "仮登録"
                        dtEst(0)("FixFlag") = 0
                    End If
                End If

                ' サンワCh取込
                ' 列名/初期値/データ型を追加
                dtEst.Columns.Add(New DataColumn With {.ColumnName = "rRequestDate", .DefaultValue = String.Empty, .DataType = Type.GetType("System.String")})  'rRequestDate
                dtEst.Columns.Add(New DataColumn With {.ColumnName = "rTitle", .DefaultValue = String.Empty, .DataType = Type.GetType("System.String")})        'rTitle
                dtEst.Columns.Add(New DataColumn With {.ColumnName = "rReplyDate", .DefaultValue = String.Empty, .DataType = Type.GetType("System.String")})    'rReplyDate
                dtEst.Columns.Add(New DataColumn With {.ColumnName = "rEndUserName", .DefaultValue = String.Empty, .DataType = Type.GetType("System.String")})  'rEndUserName
                dtEst.Columns.Add(New DataColumn With {.ColumnName = "rDeliveryDate", .DefaultValue = String.Empty, .DataType = Type.GetType("System.String")})  'rDeliverDate
                dtEst.Columns.Add(New DataColumn With {.ColumnName = "rMemo", .DefaultValue = String.Empty, .DataType = Type.GetType("System.String")})         'rMemo
                dtEst.Columns.Add(New DataColumn With {.ColumnName = "rCompanyName", .DefaultValue = String.Empty, .DataType = Type.GetType("System.String")})  'rCompanyName
                dtEst.Columns.Add(New DataColumn With {.ColumnName = "rCustomerName", .DefaultValue = String.Empty, .DataType = Type.GetType("System.String")}) 'rCustomerName
                dtEst.Columns.Add(New DataColumn With {.ColumnName = "rMailAddress", .DefaultValue = String.Empty, .DataType = Type.GetType("System.String")})  'rMailAddress

                If dtEst(0)("SanwaChRequestNumber") <> "" Then
                    StrSQL = "SELECT * " &
                             "FROM tSCPricePetitionHead " &
                             "WHERE RequestNumber = '" & dtEst(0)("SanwaChRequestNumber") & "'"
                    dt = SQL_Common.SelectSql(StrSQL, Util.WB_SERVER)
                    'ObjWB.Open StrSQL, WBConn, 3, 1
                    If dt.Rows.Count > 0 Then
                        dtEst(0)("rRequestDate") = dt(0)("RequestDate")
                        dtEst(0)("rTitle") = Trim(dt(0)("Title"))
                        dtEst(0)("rReplyDate") = Trim(dt(0)("ReplyDate"))
                        dtEst(0)("rEndUserName") = Trim(dt(0)("EndUserName"))
                        dtEst(0)("rDeliveryDate") = Trim(dt(0)("DeliveryDate"))
                        dtEst(0)("rMemo") = Trim(dt(0)("Memo"))
                        dtEst(0)("rCompanyName") = Trim(dt(0)("CompanyName"))
                        dtEst(0)("rCustomerName") = Trim(dt(0)("CustomerName"))
                        dtEst(0)("rMailAddress") = Trim(dt(0)("MailAddress"))
                    End If
                End If

                'System.Double
                ' 列名/初期値/データ型を追加
                dtEst.Columns.Add(New DataColumn With {.ColumnName = "NormalPrice", .DefaultValue = 0, .DataType = Type.GetType("System.Decimal")})          'NormalPrice
                dtEst.Columns.Add(New DataColumn With {.ColumnName = "NormalRate", .DefaultValue = 0, .DataType = Type.GetType("System.Double")})            'NormalRate
                dtEst.Columns.Add(New DataColumn With {.ColumnName = "CustGroup", .DefaultValue = String.Empty, .DataType = Type.GetType("System.String")})  'CustGroup
                dtEst.Columns.Add(New DataColumn With {.ColumnName = "LimitPrice", .DefaultValue = 0, .DataType = Type.GetType("System.Double")})            'LimitPrice
                dtEst.Columns.Add(New DataColumn With {.ColumnName = "MarginPriceSub", .DefaultValue = 0, .DataType = Type.GetType("System.Double")})        'MarginPriceSub

                dtEst.Columns.Add(New DataColumn With {.ColumnName = "FeeFlag", .DefaultValue = 0, .DataType = Type.GetType("System.Int16")})                'FeeFlag
                dtEst.Columns.Add(New DataColumn With {.ColumnName = "SuperBigFlag", .DefaultValue = 0, .DataType = Type.GetType("System.Int16")})           'SuperBigFlag
                dtEst.Columns.Add(New DataColumn With {.ColumnName = "Inventory", .DefaultValue = String.Empty, .DataType = Type.GetType("System.String")})  'Inventory
                dtEst.Columns.Add(New DataColumn With {.ColumnName = "Inventory2", .DefaultValue = String.Empty, .DataType = Type.GetType("System.String")}) 'Inventory2
                dtEst.Columns.Add(New DataColumn With {.ColumnName = "Haishi", .DefaultValue = String.Empty, .DataType = Type.GetType("System.String")})     'Haishi


                ' 商品コメント用 列名/初期値/データ型を追加
                dtCmt.Columns.Add(New DataColumn With {.ColumnName = "CmtProduct", .DefaultValue = String.Empty, .DataType = Type.GetType("System.String")})  'rRequestDate
                dtCmt.Columns.Add(New DataColumn With {.ColumnName = "Cmt", .DefaultValue = String.Empty, .DataType = Type.GetType("System.String")})        'rTitle

                dt = New DataTable

                Dim cnt As Integer = 1
                'Dim ObjSAP As Object = CreateObject("SAPCON.Info")
                For Each drEst As DataRow In dtEst.Rows
                    If IsNothing(drEst("ProductCode")) = False OrElse String.IsNullOrEmpty(drEst("ProductCode")) = False Then
                        'Try
                        '    drEst("NormalPrice") = ObjSAP.tankadw(CStr(Trim(drEst("CustomerCode"))), CStr(Trim(drEst("ProductCode"))))
                        '    If drEst("NormalPrice") > 0 Then
                        '        drEst("NormalRate") = FormatNumber(drEst("NormalPrice") / drEst("RegularPrice") * 100, 1, -1, 0, 0)
                        '        'drEst("NormalRate") = (drEst("NormalPrice") / drEst("RegularPrice") * 100).ToString("0.0")
                        '    Else
                        '        drEst("NormalPrice") = 0
                        '        drEst("NormalRate") = 0
                        '    End If
                        'Catch
                        '    drEst("NormalPrice") = 0
                        '    drEst("NormalRate") = 0
                        'End Try
                        drEst("NormalPrice") = 100
                        drEst("NormalRate") = 0.3

                        Dim todayD As Date = CDate(Year(Now) & "/" & Month(Now) & "/" & Day(Now))

                        StrSQL = "SELECT KNVV_KDGRP " &
                             "FROM uKNA1 " &
                             "WHERE KNA1_MANDT = '900' " &
                             "AND KNA1_KUNNR = '" & Trim(drEst("CustomerCode")) & "'"
                        dt = SQL_Common.SelectSql(StrSQL, Util.DW_SERVER)
                        'ObjDW.Open StrSQL, DWConn, 3, 1
                        If dt.Rows.Count > 0 Then
                            drEst("CustGroup") = Trim(dt(0)("KNVV_KDGRP"))
                        End If

                        If drEst("OutletFlag") = "0" Then
                            StrSQL = "SELECT KBETR " &
                                 "FROM uZPZ0 " &
                                 "WHERE MANDT = '900' " &
                                 "AND MATNR = '" & drEst("ProductCode") & "' " &
                                 "AND LOEVM_KO is null " &
                                 "AND (KDGRP = 'ZZ' OR KDGRP = '" & drEst("CustGroup") & "') " &
                                 "AND CONVERT(DATETIME, DATAB) <= '" & todayD & "' AND CONVERT(DATETIME, DATBI) >= '" & todayD & "' " &
                                 "ORDER BY KNUMH DESC"
                            dt = SQL_Common.SelectSql(StrSQL, Util.DW_SERVER)
                            'ObjDW.Open StrSQL, DWConn, 3, 1
                            If dt.Rows.Count > 0 Then
                                drEst("LimitPrice") = CDec(dt(0)("KBETR")) * 100
                            End If
                        End If
                    End If

                    ' コピーの場合は営業原価を再提案
                    If mode = "copy" Then
                        If drEst("ProductCode") <> "" Then
                            drEst("EigyouGenka") = AdminEstimateSystemEigyouGenka(drEst("ProductCode"))
                        End If
                    Else
                        If drEst("EigyouGenka").ToString <> "" Then
                            'drEst("EigyouGenka") = drEst("EigyouGenka")
                        ElseIf drEst("ProductCode") <> "" Then
                            drEst("EigyouGenka") = 0
                        End If
                    End If

                    If drEst("MarginPrice") <> 0 Then
                        'drEst("MarginPrice") = drEst("MarginPrice")
                    ElseIf drEst("ProductCode") <> "" Then
                        drEst("MarginPrice") = drEst("UnitPrice") - drEst("EigyouGenka")
                    End If

                    If drEst("MarginRate") <> 0 Then
                        'drEst("MarginRate") = drEst("MMarginRate")
                    ElseIf drEst("ProductCode") <> "" Then
                        drEst("MarginRate") = FormatNumber((drEst("UnitPrice") - drEst("EigyouGenka")) / drEst("UnitPrice") * 100, 1, -1, 0, 0)
                    End If

                    If IsNothing(drEst("ProductCode")) = False OrElse drEst("ProductCode") <> "" Then
                        drEst("MarginPriceSub") = drEst("MarginPrice") * drEst("Quantity")
                    End If

                    drEst("FeeFlag") = AdminEstimateSystemBigFeeCheck(drEst("ProductCode"))
                    drEst("SuperBigFlag") = AdminEstimateSystemSuperBigCheck(drEst("ProductCode"))

                    Dim Inventory As String = String.Empty
                    Dim Inventory2 As String = String.Empty
                    Dim Haishi As String = String.Empty

                    Dim ret As Boolean = AdminEstimateSystemInventoryCall(drEst("ProductCode"), cnt, Inventory, Inventory2, Haishi)
                    drEst("Inventory") = Inventory
                    drEst("Inventory2") = Inventory2
                    drEst("Haishi") = Haishi

                    ' ■ 商品コメントがある場合はコメント一覧を取得
                    Dim OutputDate As String = Left(Now, 10)

                    If Trim(drEst("ProductCode")) <> "" Then
                        StrSQL = "SELECT * " &
                                 "FROM mKnowProductComment " &
                                 "WHERE ProductCode = '" & Trim(drEst("ProductCode")) & "' " &
                                 "AND DeleteFlag = 0 " &
                                 "AND StartDate <= '" & OutputDate & "' " &
                                 "AND EndDate >= '" & OutputDate & "' " &
                                 "ORDER BY ProductCode, SeqNo"
                        dt = SQL_Common.SelectSql(StrSQL, Util.KG_SERVER)
                        'ObjKG.Open StrSQL, KGConn, 3, 1
                        If dt.Rows.Count > 0 Then
                            Dim drCmt As DataRow = dtCmt.NewRow
                            drCmt("CmtProduct") = cnt & "行目：" & dt(0)("ProductCode")

                            For Each dr As DataRow In dt.Rows
                                If drCmt("Cmt") <> "" Then
                                    drCmt("Cmt") &= "<br />"
                                End If

                                drCmt("Cmt") &= Replace(Replace(dr("Comment"), vbCrLf, "<br />"), "\", "&yen;")
                            Next

                            dtCmt.Rows.Add(drCmt)
                        End If
                    End If

                    cnt += 1
                Next


                dtEst.TableName = "estDT"
                dtCmt.TableName = "cmtDT"
                ds.Tables.Add(dtEst)
                ds.Tables.Add(dtCmt)

                dtCmt = Nothing
            End If

        Catch ex As Exception
            Dim msg As String = ex.Message

        Finally
            dtEst = Nothing

        End Try

        Return ds

    End Function

    ''' <summary>
    ''' 大物送料フラグチェック
    ''' </summary>
    ''' <param name="ProductCode"></param>
    ''' <returns></returns>
    Private Shared Function AdminEstimateSystemBigFeeCheck(ProductCode) As Byte
        Dim SQL_Common As New SQL_Common
        Dim RetVal As Byte = 0

        ' オープン価格チェック
        Dim StrSQL As String =
             "SELECT [大物送料フラグ] " &
             "FROM mKnowProductMaster " &
             "WHERE [品番] = '" & ProductCode & "'"

        Dim dt As DataTable = SQL_Common.SelectSql(StrSQL, Util.KG_SERVER)
        If dt.Rows.Count > 0 Then
            RetVal = dt(0)("大物送料フラグ")
        End If

        Return RetVal

    End Function

    ''' <summary>
    ''' 営業原価の提案
    ''' </summary>
    ''' <param name="sProductCode"></param>
    ''' <returns></returns>
    Private Shared Function AdminEstimateSystemEigyouGenka(sProductCode As String) As Double
        Dim SQL_Common As New SQL_Common
        Dim todayD = CDate(Year(Now) & "/" & Month(Now) & "/" & Day(Now))
        Dim StrSQL As String
        Dim dt As DataTable
        Dim ret As Double = 0

        StrSQL = "SELECT KBETR " &
                 "FROM uZP02 " &
                 "WHERE MANDT = '900' " &
                 "AND MATNR = '" & sProductCode & "' " &
                 "AND WERKS <> '9' " &
                 "AND CONVERT(DATETIME, DATAB) <= '" & todayD & "' AND CONVERT(DATETIME, DATBI) >= '" & todayD & "' " &
                 "AND LOEVM_KO Is Null " &
                 "ORDER BY KNUMH DESC"

        dt = SQL_Common.SelectSql(StrSQL, Util.DW_SERVER)

        If dt.Rows.Count > 0 Then
            ret = CDbl(dt(0)("KBETR")) * 100
        End If

        Return ret

    End Function

    ''' <summary>
    ''' 超大物フラグチェック
    ''' </summary>
    ''' <param name="ProductCode"></param>
    ''' <returns></returns>
    Private Shared Function AdminEstimateSystemSuperBigCheck(ProductCode) As Byte
        Dim SQL_Common As New SQL_Common
        Dim RetVal As Byte = 0

        Dim StrSQL As String =
             "SELECT [車上渡し商品フラグ] " &
             "FROM mKnowProductMaster " &
             "WHERE [品番] = '" & ProductCode & "' " &
             "AND [車上渡し商品フラグ] = 1"
        Dim dt As DataTable = SQL_Common.SelectSql(StrSQL, Util.KG_SERVER)
        If dt.Rows.Count > 0 Then
            RetVal = 1
        End If

        Return RetVal

    End Function

    ''' <summary>
    ''' 在庫データを取得する
    ''' </summary>
    ''' <returns></returns>
    Public Shared Function AdminEstimateSystemInventoryCall(ByVal ProductCode As String, ByVal LineNumber As Integer,
                                                            ByRef Inventory As String, ByRef Inventory2 As String, ByRef Haishi As String) As Boolean
        Dim SQL_Common As New SQL_Common
        Dim NyukaCnt As Integer
        Dim DataInvE As String = String.Empty
        Dim DataInvW As String = String.Empty
        Dim supPerson As String = String.Empty
        Dim devPerson As String = String.Empty
        Dim Inventory3 As String
        Dim StrSQL As String

        Dim dt As DataTable
        Dim Hiki As Integer
        Dim Mihi As Integer

        If ProductCode <> "" Then
            Try
                ' 担当チェック
                StrSQL = "SELECT MA.MARA_ZZSM_DVLP_NM, T0.T024_EKNAM, MVKE_VMSTA " &
                 "FROM uMARC MA " &
                 "LEFT JOIN uT024 T0 " &
                 "ON MA.MARC_EKGRP = T0.T024_EKGRP " &
                 "WHERE MA.MARA_MANDT = '900' " &
                 "AND (T0.T024_MANDT = '900' OR T0.T024_MANDT Is Null) " &
                 "AND MA.MARA_MATNR = '" & ProductCode & "' " &
                 "ORDER BY MA.MARC_WERKS"
                ' レコードを開く
                dt = SQL_Common.SelectSql(StrSQL, Util.DW_SERVER)
                If dt.Rows.Count > 0 Then
                    devPerson = Trim(dt(0)("MARA_ZZSM_DVLP_NM"))
                    supPerson = Trim(dt(0)("T024_EKNAM"))

                    If dt(0)("MVKE_VMSTA") = "2" Or dt(0)("MVKE_VMSTA") = "3" Or dt(0)("MVKE_VMSTA") = "4" Or dt(0)("MVKE_VMSTA") = "5" Then
                        Haishi = 1
                    End If
                End If

                ' 在庫
                StrSQL = "SELECT MARD_WERKS, MARD_LGORT, MARD_FREE, MARD_HI_JU, MARD_HI_MI, MARD_HI_ZA, MARD_MI_JU, MARD_MI_MI, MARD_MI_ZA, " &
                 "EKES_EINDT_1, EKES_MENGE_1, EKES_EINDT_2, EKES_MENGE_2, EKES_EINDT_3, EKES_MENGE_3, " &
                 "EKKO_BSART_1, EKKO_BSART_2, EKKO_BSART_3 " &
                 "FROM uMARD " &
                 "WHERE MARD_MATNR = '" & ProductCode & "' " &
                 "AND MARD_MANDT = '900' " &
                 "AND (MARD_WERKS = '1' OR MARD_WERKS = '2') " &
                 "AND (MARD_LGORT = '1' OR MARD_LGORT = '2' OR MARD_LGORT = '3' OR MARD_LGORT = '4' OR MARD_LGORT = '5') " &
                 "ORDER BY MARD_WERKS, MARD_LGORT"
                dt = SQL_Common.SelectSql(StrSQL, Util.DW_SERVER)

                If dt.Rows.Count > 0 Then
                    Inventory = "在庫：<a href=""javascript: estimateSystemInventoryLayer(" & LineNumber & ");"">"
                    Inventory2 = "<p style=""font-weight: bold;"">品番：" & ProductCode & "</p>"
                    Inventory2 &= "<p>開発：" & devPerson & "(" & ExtensionNoCall(devPerson) & ")　　仕入：" & supPerson & "(" & ExtensionNoCall(supPerson) & ")</p>"
                    Inventory2 &= "<p class=""layer_ttl"">■ 在庫</p><table class=""layer_tbl1""><tr><th>倉庫</th><th>フリー</th><th>未引当</th><th>引当済</th></tr>"

                    NyukaCnt = 0
                    Inventory3 = "<p class=""layer_ttl"">■ 次回入荷</p><table class=""layer_tbl2""><tr><th>No</th><th>予定日</th><th>エリア</th><th>予定数量</th></tr>"
                    For Each ObjDW As DataRow In dt.Rows
                        Hiki = CDbl(ObjDW("MARD_HI_JU")) + CDbl(ObjDW("MARD_HI_MI")) + CDbl(ObjDW("MARD_HI_ZA"))
                        Mihi = CDbl(ObjDW("MARD_MI_JU")) + CDbl(ObjDW("MARD_MI_MI")) + CDbl(ObjDW("MARD_MI_ZA"))

                        Select Case ObjDW("MARD_WERKS") & ObjDW("MARD_LGORT")
                            Case "11"
                                Inventory &= "　岡2F/" & CDbl(ObjDW("MARD_FREE"))
                                Inventory2 &= "<tr><td>11：岡2F</td><td>" & CDbl(ObjDW("MARD_FREE")) & "</td><td>" & Mihi & "</td><td>" & Hiki & "</td></tr>"

                                If ObjDW("EKES_MENGE_1") > 0 Then
                                    NyukaCnt += 1
                                    Inventory3 &= "<tr><td>" & NyukaCnt & "</td><td>" & FuncDateOut(ObjDW("EKES_EINDT_1").ToString) & "</td><td>岡2F</td><td>" & CDbl(ObjDW("EKES_MENGE_1")) & "</td></tr>"

                                    If ObjDW("EKES_MENGE_2") > 0 Then
                                        NyukaCnt += 1
                                        Inventory3 &= "<tr><td>" & NyukaCnt & "</td><td>" & FuncDateOut(ObjDW("EKES_EINDT_2")) & "</td><td>岡2F</td><td>" & CDbl(ObjDW("EKES_MENGE_2")) & "</td></tr>"

                                        If ObjDW("EKES_MENGE_3") > 0 Then
                                            NyukaCnt += 1
                                            Inventory3 &= "<tr><td>" & NyukaCnt & "</td><td>" & FuncDateOut(ObjDW("EKES_EINDT_3")) & "</td><td>岡2F</td><td>" & CDbl(ObjDW("EKES_MENGE_3")) & "</td></tr>"
                                        End If
                                    End If
                                End If
                            Case "12"
                                Inventory &= "　岡1F/" & CDbl(ObjDW("MARD_FREE"))
                                Inventory2 &= "<tr><td>12：岡1F</td><td>" & CDbl(ObjDW("MARD_FREE")) & "</td><td>" & Mihi & "</td><td>" & Hiki & "</td></tr>"

                                If ObjDW("EKES_MENGE_1") > 0 Then
                                    NyukaCnt += 1
                                    Inventory3 &= "<tr><td>" & NyukaCnt & "</td><td>" & FuncDateOut(ObjDW("EKES_EINDT_1")) & "</td><td>岡1F</td><td>" & CDbl(ObjDW("EKES_MENGE_1")) & "</td></tr>"

                                    If ObjDW("EKES_MENGE_2") > 0 Then
                                        NyukaCnt += 1
                                        Inventory3 &= "<tr><td>" & NyukaCnt & "</td><td>" & FuncDateOut(ObjDW("EKES_EINDT_2")) & "</td><td>岡1F</td><td>" & CDbl(ObjDW("EKES_MENGE_2")) & "</td></tr>"

                                        If ObjDW("EKES_MENGE_3") > 0 Then
                                            NyukaCnt += 1
                                            Inventory3 &= "<tr><td>" & NyukaCnt & "</td><td>" & FuncDateOut(ObjDW("EKES_EINDT_3")) & "</td><td>岡1F</td><td>" & CDbl(ObjDW("EKES_MENGE_3")) & "</td></tr>"
                                        End If
                                    End If
                                End If
                            Case "13"
                                Inventory &= "　岡受/" & CDbl(ObjDW("MARD_FREE"))
                                Inventory2 &= "<tr><td>13：岡受</td><td>" & CDbl(ObjDW("MARD_FREE")) & "</td><td>" & Mihi & "</td><td>" & Hiki & "</td></tr>"

                                If ObjDW("EKES_MENGE_1") > 0 Then
                                    NyukaCnt += 1
                                    Inventory3 &= "<tr><td>" & NyukaCnt & "</td><td>" & FuncDateOut(ObjDW("EKES_EINDT_1")) & "</td><td>岡受</td><td>" & CDbl(ObjDW("EKES_MENGE_1")) & "</td></tr>"

                                    If ObjDW("EKES_MENGE_2") > 0 Then
                                        NyukaCnt += 1
                                        Inventory3 &= "<tr><td>" & NyukaCnt & "</td><td>" & FuncDateOut(ObjDW("EKES_EINDT_2")) & "</td><td>岡受</td><td>" & CDbl(ObjDW("EKES_MENGE_2")) & "</td></tr>"

                                        If ObjDW("EKES_MENGE_3") > 0 Then
                                            NyukaCnt += 1
                                            Inventory3 &= "<tr><td>" & NyukaCnt & "</td><td>" & FuncDateOut(ObjDW("EKES_EINDT_3")) & "</td><td>岡受</td><td>" & CDbl(ObjDW("EKES_MENGE_3")) & "</td></tr>"
                                        End If
                                    End If
                                End If
                            Case "14"
                                Inventory &= "　ﾌﾟﾚｽ/" & CDbl(ObjDW("MARD_FREE"))
                                Inventory2 &= "<tr><td>14：ﾌﾟﾚｽ</td><td>" & CDbl(ObjDW("MARD_FREE")) & "</td><td>" & Mihi & "</td><td>" & Hiki & "</td></tr>"
                            Case "15"
                                Inventory &= "　竹/" & CDbl(ObjDW("MARD_FREE"))
                                Inventory2 &= "<tr><td>15：竹</td><td>" & CDbl(ObjDW("MARD_FREE")) & "</td><td>" & Mihi & "</td><td>" & Hiki & "</td></tr>"
                            Case "21"
                                Inventory &= "　東2F/" & CDbl(ObjDW("MARD_FREE"))
                                Inventory2 &= "<tr><td>21：東2F</td><td>" & CDbl(ObjDW("MARD_FREE")) & "</td><td>" & Mihi & "</td><td>" & Hiki & "</td></tr>"

                                If ObjDW("EKES_MENGE_1") > 0 Then
                                    NyukaCnt += 1
                                    Inventory3 &= "<tr><td>" & NyukaCnt & "</td><td>" & FuncDateOut(ObjDW("EKES_EINDT_1")) & "</td><td>東2F</td><td>" & CDbl(ObjDW("EKES_MENGE_1")) & "</td></tr>"

                                    If ObjDW("EKES_MENGE_2") > 0 Then
                                        NyukaCnt += 1
                                        Inventory3 &= "<tr><td>" & NyukaCnt & "</td><td>" & FuncDateOut(ObjDW("EKES_EINDT_2")) & "</td><td>東2F</td><td>" & CDbl(ObjDW("EKES_MENGE_2")) & "</td></tr>"

                                        If ObjDW("EKES_MENGE_3") > 0 Then
                                            NyukaCnt += 1
                                            Inventory3 &= "<tr><td>" & NyukaCnt & "</td><td>" & FuncDateOut(ObjDW("EKES_EINDT_3")) & "</td><td>東2F</td><td>" & CDbl(ObjDW("EKES_MENGE_3")) & "</td></tr>"
                                        End If
                                    End If
                                End If
                            Case "22"
                                Inventory &= "　東1F/" & CDbl(ObjDW("MARD_FREE"))
                                Inventory2 &= "<tr><td>22：東1F</td><td>" & CDbl(ObjDW("MARD_FREE")) & "</td><td>" & Mihi & "</td><td>" & Hiki & "</td></tr>"

                                If ObjDW("EKES_MENGE_1") > 0 Then
                                    NyukaCnt += 1
                                    Inventory3 &= "<tr><td>" & NyukaCnt & "</td><td>" & FuncDateOut(ObjDW("EKES_EINDT_1")) & "</td><td>東1F</td><td>" & CDbl(ObjDW("EKES_MENGE_1")) & "</td></tr>"

                                    If ObjDW("EKES_MENGE_2") > 0 Then
                                        NyukaCnt += 1
                                        Inventory3 &= "<tr><td>" & NyukaCnt & "</td><td>" & FuncDateOut(ObjDW("EKES_EINDT_2")) & "</td><td>東1F</td><td>" & CDbl(ObjDW("EKES_MENGE_2")) & "</td></tr>"

                                        If ObjDW("EKES_MENGE_3") > 0 Then
                                            NyukaCnt += 1
                                            Inventory3 &= "<tr><td>" & NyukaCnt & "</td><td>" & FuncDateOut(ObjDW("EKES_EINDT_3")) & "</td><td>東1F</td><td>" & CDbl(ObjDW("EKES_MENGE_3")) & "</td></tr>"
                                        End If
                                    End If
                                End If
                            Case "23"
                                Inventory &= "　東受/" & CDbl(ObjDW("MARD_FREE"))
                                Inventory2 &= "<tr><td>23：東受</td><td>" & CDbl(ObjDW("MARD_FREE")) & "</td><td>" & Mihi & "</td><td>" & Hiki & "</td></tr>"

                                If ObjDW("EKES_MENGE_1") > 0 Then
                                    NyukaCnt += 1
                                    Inventory3 &= "<tr><td>" & NyukaCnt & "</td><td>" & FuncDateOut(ObjDW("EKES_EINDT_1")) & "</td><td>東受</td><td>" & CDbl(ObjDW("EKES_MENGE_1")) & "</td></tr>"

                                    If ObjDW("EKES_MENGE_2") > 0 Then
                                        NyukaCnt += 1
                                        Inventory3 &= "<tr><td>" & NyukaCnt & "</td><td>" & FuncDateOut(ObjDW("EKES_EINDT_2")) & "</td><td>東受</td><td>" & CDbl(ObjDW("EKES_MENGE_2")) & "</td></tr>"

                                        If ObjDW("EKES_MENGE_3") > 0 Then
                                            NyukaCnt += 1
                                            Inventory3 &= "<tr><td>" & NyukaCnt & "</td><td>" & FuncDateOut(ObjDW("EKES_EINDT_3")) & "</td><td>東受</td><td>" & CDbl(ObjDW("EKES_MENGE_3")) & "</td></tr>"
                                        End If
                                    End If
                                End If
                        End Select
                    Next
                    Inventory &= "</a>"
                    Inventory2 &= "</table>"

                    If NyukaCnt <> 0 Then
                        Inventory2 &= Inventory3 & "</table>"
                    End If
                End If

                If AdminEstimateSystemBigFeeCheck(ProductCode) = "1" Then
                    Inventory2 &= "<p class=""big_charge"">★送料が別途掛かる大物商品です。</p>"
                End If

                If Inventory2 <> "" Then
                    Inventory2 &= "<p class=""close_btn""><a href=""javascript: estimateSystemInventoryLayerClose(" & LineNumber & ");"">× 閉じる</a></p>"
                End If

                StrSQL = "SELECT MARD_WERKS AS WERKS, Sum(Convert(Float,MARD_FREE)) AS FREE " &
                         "FROM uMARD " &
                         "WHERE MARD_MANDT = '900' " &
                         "AND MARD_MATNR = '" & ProductCode & "' " &
                         "AND MARD_WERKS IN ('1','2') " &
                         "AND MARD_LGORT IN ('1','2','3','4','5') " &
                         "GROUP BY MARD_WERKS"
                dt = SQL_Common.SelectSql(StrSQL, Util.DW_SERVER)
                For Each ObjDW As DataRow In dt.Rows
                    Select Case ObjDW("WERKS")
                        Case "1"
                            DataInvW = ObjDW("FREE")
                        Case "2"
                            DataInvE = ObjDW("FREE")
                    End Select
                Next

                Inventory &= "<input type=""hidden"" id=""InvW_" & LineNumber & """ value=""" & DataInvW & """ />" &
                             "<input type=""hidden"" id=""InvE_" & LineNumber & """ value=""" & DataInvE & """ />"

            Catch ex As Exception

                Inventory = ex.Message
                Return False

            End Try

        End If

        Return True

    End Function

    ''' <summary>
    ''' 開発/仕入担当者の内線番号取得
    ''' </summary>
    ''' <param name="UserName"></param>
    ''' <returns></returns>
    Private Shared Function ExtensionNoCall(ByVal UserName As String) As String
        Dim SQL_Common As New SQL_Common
        Dim ExtensionNo As String = String.Empty
        Dim StrSQL As String

        If Trim(UserName) <> "" Then
            StrSQL = "SELECT ExtensionNumber " &
                     "FROM mMember " &
                     "WHERE replace(FullName,' ','') = '" & Replace(Replace(Trim(UserName), "　", " "), " ", "") & "'"
            Dim dt As DataTable = SQL_Common.SelectSql(StrSQL, Util.KG_SERVER)
            'ObjKG.Open StrSQL, KGConn, 3, 1
            If dt.Rows.Count > 0 Then
                ExtensionNo = dt(0)("ExtensionNumber")
            End If
        End If

        Return ExtensionNo

    End Function

    ''' <summary>
    ''' 日付書式変更用
    ''' </summary>
    ''' <param name="_InDate"></param>
    ''' <returns></returns>
    Private Shared Function FuncDateOut(ByVal _InDate As String)
        Dim OutDate As String = ""
        Dim InDate As String = Trim(_InDate)

        If InDate <> "00000000" Then
            If Left(InDate, 1) = "2" Then
                OutDate = Left(Trim(InDate), 4) & "/" & Mid(InDate, 5, 2) & "/" & Right(InDate, 2)
            ElseIf InDate = "19991230" Then
                OutDate = "確認中"
            ElseIf InDate = "19991231" Then
                OutDate = "未定"
            Else
                Select Case Right(InDate, 2)
                    Case "10" : OutDate = "20" & Mid(InDate, 3, 2) & "/" & Mid(InDate, 5, 2) & "/" & "上"
                    Case "15" : OutDate = "20" & Mid(InDate, 3, 2) & "/" & Mid(InDate, 5, 2) & "/" & "中"
                    Case "20" : OutDate = "20" & Mid(InDate, 3, 2) & "/" & Mid(InDate, 5, 2) & "/" & "下"
                    Case "25" : OutDate = "20" & Mid(InDate, 3, 2) & "/" & Mid(InDate, 5, 2) & "/" & "末"
                    Case "28" : OutDate = "20" & Mid(InDate, 3, 2) & "/" & Mid(InDate, 5, 2) & "/" & "以降"
                End Select
            End If
        End If

        Return OutDate

    End Function


    Public Shared Function GetTestData(ByVal test As String) As DataSet

        Dim sql As New StringBuilder
        'Dim xlApp As Object = Nothing
        'Dim xlBooks As Object = Nothing
        'Dim xlBook As Object = Nothing
        'Dim xlSheet As Object = Nothing
        'Dim xlCells As Object = Nothing
        'Dim xlRange As Object = Nothing
        'Dim xlCellStart As Object = Nothing
        'Dim xlCellEnd As Object = Nothing

        Dim ds = New DataSet

        Dim dtEst = New DataTable
        Dim dtWst = New DataTable

        ' 列名/初期値/データ型を追加
        dtEst.Columns.Add(New DataColumn With {.ColumnName = "A", .DefaultValue = String.Empty, .DataType = Type.GetType("System.String")})
        dtEst.Columns.Add(New DataColumn With {.ColumnName = "B", .DefaultValue = String.Empty, .DataType = Type.GetType("System.String")})
        dtEst.Columns.Add(New DataColumn With {.ColumnName = "C", .DefaultValue = String.Empty, .DataType = Type.GetType("System.String")})
        dtWst.Columns.Add(New DataColumn With {.ColumnName = "A", .DefaultValue = String.Empty, .DataType = Type.GetType("System.String")})

        Try
            'xlApp = CreateObject("Excel.Application")
            'xlBooks = xlApp.Workbooks
            'xlBook = xlApp.Workbooks.Add
            'ファイルを開く
            'xlBook = xlApp.Workbooks.Open(FileName:="C:\Users\hara\Desktop\table.xlsx")
            'xlBook = xlApp.Workbooks.Open(FileName:="C:\Users\yasushi.hara\Desktop\table.xlsx")
            'xlApp.Visible = False
            'xlSheet = xlBook.WorkSheets(1)

            Dim row1 As DataRow = dtEst.NewRow '追加行を宣言

            '値をセット
            'row(0) = xlSheet.Cells(1, 1).value
            'row(1) = xlSheet.Cells(2, 1).value
            'row(2) = xlSheet.Cells(3, 1).value
            row1(0) = "Data1"
            row1(1) = "Data2"
            row1(2) = "Data3"

            'テーブルの末尾に追加
            dtEst.Rows.Add(row1)

            'With sql
            '    .Append("SELECT CheckNum,SalesPersonName,AssistantName FROM tEstimateParent")
            'End With

            Dim row2 As DataRow = dtWst.NewRow '追加行を宣言

            '値をセット
            row2(0) = test

            'テーブルの末尾に追加
            dtWst.Rows.Add(row2)

            dtEst.TableName = "DT1"
            dtWst.TableName = "DT2"
            ds.Tables.Add(dtEst)
            ds.Tables.Add(dtWst)

            'ファイルを閉じる
            'xlApp.ActiveWorkbook.Close(SaveChanges:=False)
            'Excelを閉じる
            'xlApp.Quit()
        Catch
            'xlApp.ActiveWorkbook
            'xlApp.DisplayAlerts = False
            'xlApp.Quit()
            Throw
        Finally
            'If xlCellStart IsNot Nothing Then System.Runtime.InteropServices.Marshal.ReleaseComObject(xlCellStart)
            'If xlCellEnd IsNot Nothing Then System.Runtime.InteropServices.Marshal.ReleaseComObject(xlCellEnd)
            'If xlRange IsNot Nothing Then System.Runtime.InteropServices.Marshal.ReleaseComObject(xlRange)
            'If xlCells IsNot Nothing Then System.Runtime.InteropServices.Marshal.ReleaseComObject(xlCells)
            'If xlSheet IsNot Nothing Then System.Runtime.InteropServices.Marshal.ReleaseComObject(xlSheet)
            'If xlBooks IsNot Nothing Then System.Runtime.InteropServices.Marshal.ReleaseComObject(xlBooks)
            'If xlBook IsNot Nothing Then System.Runtime.InteropServices.Marshal.ReleaseComObject(xlBook)
            'If xlApp IsNot Nothing Then System.Runtime.InteropServices.Marshal.ReleaseComObject(xlApp)

            'GC.Collect()
        End Try

        Return ds

    End Function

    '↓20200311
    Private Shared Function Get_RicohNum(ByVal CheckNum As String) As String
        Dim SQL_Common As New SQL_Common
        Dim Result As String = String.Empty
        Dim StrSQL As String = String.Empty
        Dim dt As New DataTable

        StrSQL = String.Empty
        StrSQL = "SELECT RicohNum "
        StrSQL += "FROM tEstimateParent "
        StrSQL += "WHERE CheckNum = '" + CheckNum + "'"

        dt = SQL_Common.SelectSql(StrSQL, Util.DB_SERVER)

        If dt.Rows.Count > 0 Then
            If dt.Rows(0)("RicohNum") IsNot DBNull.Value Then
                Result = dt.Rows(0)("RicohNum")
            Else
                Result = ""
            End If
        End If

        Return Result
    End Function

    '見積書発行ボタン処理
    Private Shared Function EstimateDetailIssue(ByVal CheckNum As String) As String
        Dim SQL_Common As New SQL_Common
        Dim Result As String = String.Empty
        Dim StrSQL As String = String.Empty
        Dim dt As New DataTable

        'データ更新
        StrSQL = "UPDATE tEstimateParent "
        StrSQL += "SET IssueTime = GETDATE() "
        StrSQL += "WHERE CheckNum = '" + CheckNum + "'"

        SQL_Common.ExecSql(StrSQL, Util.DB_SERVER)

        'RicohNum取得
        Result = Get_RicohNum(CheckNum)

        Return Result

    End Function

    'CSVダウンロード処理
    Private Function DownloadCSV_detail(ByRef Response As HttpResponse, ByVal CheckNum As String, ByVal RicohNum As String) As Boolean
        Dim CSV_Common As New CSV_Common
        Dim CsvText As String = String.Empty
        Dim Result As New Boolean

        CsvText = Create_CSV_detail(CheckNum, RicohNum)

        '書き込み処理
        Result = CSV_Common.Download_CSV(Response, CsvText, CheckNum, RicohNum)

        Return Result

    End Function

    'ダウンロードCSV作成処理
    Public Function Create_CSV_detail(ByVal CheckNum As String, ByVal RicohNum As String) As String
        Dim CSV_Common As New CSV_Common
        Dim index_Query As New index_Query
        Dim CsvText As String = String.Empty
        Dim tEstimateParent_Table As DataTable = Nothing
        Dim trCnt As Integer = 0
        Dim dCustomerName As String = String.Empty
        Dim dTitle As String = String.Empty
        Dim Status As String = String.Empty
        Dim Status2 As String = String.Empty
        Dim StrSQL As String = String.Empty
        Dim StartDate As New Date
        Dim EndDate As New Date

        StartDate = Left(DateAdd("ww", -1, Now), 10)
        EndDate = Left(Now, 10)

        StrSQL = "SELECT TEP.CheckNum, TEP.RicohNum, TED.Columns, TEP.CustomerCode, TEP.CustomerName, "
        StrSQL += "TEP.CustomerDivision, TEP.CustomerPersonName, TEP.ConclusionDate, TEP.Title, "
        StrSQL += "TEP.SalesPersonName, TEP.AssistantName, TEP.CreatePersonName, TEP.UpdateTime, TEP.Division, "
        StrSQL += "TEP.SalesPersonCode, TEP.AssistantCode, TEP.CreatePersonCode, TEP.Contents, TEP.FixFlag, "
        StrSQL += "TEP.SanwaChDispFlag, TEP.ParentCheckNum, TEP.ConclusionStatus, TEP.EndUserName, "
        StrSQL += "TEP.ProfessionClass1, TEP.ProfessionClass2, TEP.EndUserPref, TEP.EndUserAddress, "
        StrSQL += "TEP.DeliveryLimitDate, TED.ProductCode, TED.RCode, TED.ProductName, TED.Quantity, "
        StrSQL += "TED.UnitPrice, TED.SubTotalPrice, TEP.ContinuationFlag, TEP.ContinuationCycle, TEG.GroupNo, "
        StrSQL += "TEG.GroupName "
        StrSQL += "FROM tEstimateParent TEP "
        StrSQL += "INNER JOIN tEstimateDetail TED "
        StrSQL += "ON TEP.CheckNum = TED.CheckNum "
        StrSQL += "LEFT JOIN tEstimateGroupBody TGB "
        StrSQL += "ON TEP.CheckNum = TGB.CheckNum "
        StrSQL += "LEFT JOIN tEstimateGroup TEG "
        StrSQL += "ON TEG.GroupNo = TGB.GroupNo "
        StrSQL += "WHERE TEP.DeleteFlag = 0 "
        StrSQL += "And TED.DeleteFlag = 0 "
        StrSQL += "And TED.ProductCode Is Not Null "
        StrSQL += "And TED.ProductCode <> '' "

        If CheckNum = "" And RicohNum = "" Then
            StrSQL += "AND TEP.CreateTime >= '" + Replace(Mid(StartDate, 3, 8), "/", "") + "' "
            StrSQL += "AND TEP.CreateTime <= '" + Replace(Mid(EndDate, 3, 8), "/", "") + "' "
        End If

        If CheckNum <> "" Then
            StrSQL += "AND TEP.CheckNum like '" + CheckNum + "%' "
        End If

        If RicohNum <> "" Then
            StrSQL += "AND TEP.RicohNum like '%" + RicohNum + "%' "
        End If

        tEstimateParent_Table = SQL_Common.SelectSql(StrSQL, Util.DB_SERVER)

        If tEstimateParent_Table.Rows.Count > 0 Then
            If Left(tEstimateParent_Table.Rows(0)("CustomerCode"), 5) = "00018" Then
                CsvText = CSV_Common.Create_CSV_Detail(tEstimateParent_Table, CsvText)
            Else
                CsvText = CSV_Common.Create_CSV_List(tEstimateParent_Table, CsvText)
            End If
        End If

        Return CsvText
    End Function
    '↑20200311
#End Region

#Region "WebMethods"

    ''' <summary>
    ''' 見積案件データを取得する
    ''' </summary>
    ''' <returns></returns>
    <System.Web.Services.WebMethod>
    Public Shared Function GetJsonEstimateData(cno As String, mode As String) As String
        ''↓20200220 見積詳細データ取得処理
        'Dim Detail_Class As New Detail_Class
        'Dim ds As New DataSet

        'Try
        '    ds = Detail_Class.Page_Load(cno, mode)
        'Catch ex As Exception
        '    Return JsonConvert.SerializeObject("エラー：" & ex.Message)
        'End Try

        'Return JsonConvert.SerializeObject(ds)
        ''↑20200220

        Dim ds As DataSet

        Try
            ds = GetEstimateData(cno, mode)
        Catch ex As Exception
            Return JsonConvert.SerializeObject("エラー：" & ex.Message)
        End Try

        Return JsonConvert.SerializeObject(ds)

    End Function

    ''' <summary>
    ''' 見積在庫データを取得する
    ''' </summary>
    ''' <param name="test"></param>
    ''' <returns></returns>
    <System.Web.Services.WebMethod>
    Public Shared Function GetJsonInventoryData(ByVal test As String) As String

        ''Dim ret() As String = GetInventoryData(test)
        'Dim ret(0) As String
        'ret(0) = test

        'Return JsonConvert.SerializeObject(ret)
        Return Nothing

    End Function

    ''' <summary>
    ''' 商品データを取得する
    ''' </summary>
    ''' <returns></returns>
    <System.Web.Services.WebMethod>
    Public Shared Function GetJsonProductDataAll(pdata As Object) As String

        'Dim ret() As String = GetProductDataAll(pdata)

        'Return JsonConvert.SerializeObject(ret)
        Return Nothing

    End Function

    ''' <summary>
    ''' テストデータを取得する
    ''' </summary>
    ''' <returns></returns>
    <System.Web.Services.WebMethod>
    Public Shared Function GetJsonTestData(ByVal test As String) As String

        Dim ds As DataSet = GetTestData(test)

        Return JsonConvert.SerializeObject(ds)

        'TODO:
        'Console.WriteLine(JsonConvert.SerializeObject(ds))

    End Function

    'Protected Sub BtnTest_Click(sender As Object, e As EventArgs) Handles btnTest.Click

    '    Dim uri As Uri = Request.Url
    '    Request.Cookies("estimate_system")("AutoLogoutPage") = uri.AbsoluteUri

    'End Sub

#End Region

End Class