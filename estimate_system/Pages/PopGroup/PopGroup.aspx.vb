Imports System.IO
Imports System.Collections.Generic
Imports Newtonsoft.Json
Imports System.Text
Imports estimate_system.Common

Public Class PopGroup
    Inherits System.Web.UI.Page

#Region "Events"

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        'If HttpContext.Current.Session("SESSIONTIMEOUTFLG") Is Nothing Then
        '    ' セッション切れ処理終了
        '    Exit Sub
        'End If

        ' セッション切れ処理終了
        'HttpContext.Current.Sessionは、使用可能なセッションがない場合、単にnullを返します
        If HttpContext.Current.Session("SESSIONID") <> Session.SessionID Then
            Response.Redirect("Login.aspx", False)
            Exit Sub
        End If

        '20200313 ADD
        'ページロード時
        'If Not IsPostBack Then

        '20200323 DELETE
        'Dim strGroupNo = Nothing
        'Dim strCheckNum = Nothing
        'Dim strMode = Nothing
        'Dim strSubmitMode = Nothing
        'Dim strNewAddChk = Nothing
        'Dim strCheckNumList = Nothing
        'Dim strLeaderCheckNum = Nothing

        '一覧画面からの遷移
        'If Not IsNothing(Request.QueryString("gno")) AndAlso Not Request.QueryString("gno").Trim().Equals(String.Empty) Then
        '    strGroupNo = Request.QueryString("gno").Trim()
        'End If

        'xx画面からの遷移
        'If Not IsNothing(Request.QueryString("cno")) AndAlso Not Request.QueryString("cno").Trim().Equals(String.Empty) Then
        '    strCheckNum = Request.QueryString("cno").Trim()
        'End If
        'If Not IsNothing(Request.QueryString("mode")) AndAlso Not Request.QueryString("mode").Trim().Equals(String.Empty) Then
        '    strMode = Request.QueryString("mode").Trim()
        'End If


        'xx画面からの遷移

        'test 20200323 ADD
        'PopGroup_SessionSet(Request)


        'If Not String.IsNullOrEmpty(NewAddChk.value) AndAlso Not NewAddChk.Value.Trim().Equals(String.Empty) Then
        '    strNewAddChk = NewAddChk.value
        'End If
        'If Not String.IsNullOrEmpty(CheckNumList.value) AndAlso Not CheckNumList.Value.Trim().Equals(String.Empty) Then
        '    strCheckNumList = CheckNumList.value
        'End If
        'If Not String.IsNullOrEmpty(LeaderCheckNum.value) AndAlso Not LeaderCheckNum.Value.Trim().Equals(String.Empty) Then
        '    strLeaderCheckNum = LeaderCheckNum.value
        'End If
        'Else    'Postbackの時

        ''    Dim xxx = "ABC"

        ''End If

    End Sub

    'Private Sub PopGroup_SessionSet(request As HttpRequest)
    '    Dim fCheck As Boolean = False

    '    If Not String.IsNullOrEmpty(request.Form("SubmitMode")) AndAlso Not request.Form("SubmitMode").Trim().Equals(String.Empty) Then
    '        Session("SubmitMode") = request.Form("SubmitMode")
    '    Else
    '        Session("SubmitMode") = String.Empty
    '    End If

    '    If Session("SubmitMode").Equals("group_search") Then
    '        If Not String.IsNullOrEmpty(request.Form("Mode")) AndAlso Not request.Form("Mode").Trim().Equals(String.Empty) Then
    '            Session("Mode") = request.Form("Mode")
    '        Else
    '            Session("Mode") = String.Empty
    '        End If

    '        If Not String.IsNullOrEmpty(request.Form("sGroupNo")) AndAlso Not request.Form("sGroupNo").Trim().Equals(String.Empty) Then
    '            Session("sGroupNo") = request.Form("sGroupNo")
    '        Else
    '            Session("sGroupNo") = String.Empty
    '        End If

    '        If Not String.IsNullOrEmpty(request.Form("sGroupName")) AndAlso Not request.Form("sGroupName").Trim().Equals(String.Empty) Then
    '            Session("sGroupName") = request.Form("sGroupName")
    '        Else
    '            Session("sGroupName") = String.Empty
    '        End If

    '        If Not String.IsNullOrEmpty(request.Form("sProductCode")) AndAlso Not request.Form("sProductCode").Trim().Equals(String.Empty) Then
    '            Session("sProductCode") = request.Form("sProductCode")
    '        Else
    '            Session("sProductCode") = String.Empty
    '        End If

    '        If Not String.IsNullOrEmpty(request.Form("sSalesPerson")) AndAlso Not request.Form("sSalesPerson").Trim().Equals(String.Empty) Then
    '            Session("sSalesPerson") = request.Form("sSalesPerson")
    '        Else
    '            Session("sSalesPerson") = String.Empty
    '        End If
    '    ElseIf Session("SubmitMode").Equals("group_back") Then
    '        If Not String.IsNullOrEmpty(request.Form("Mode")) AndAlso Not request.Form("Mode").Trim().Equals(String.Empty) Then
    '            Session("Mode") = request.Form("Mode")
    '        Else
    '            Session("Mode") = String.Empty
    '        End If

    '        'If Not String.IsNullOrEmpty(Session("sGroupNo")) AndAlso Not Session("sGroupNo").Trim().Equals(String.Empty) Then
    '        '    Session("sGroupNo")
    '        'End If

    '        'If Not String.IsNullOrEmpty(Session("sGroupName")) AndAlso Not Session("sGroupName").Trim().Equals(String.Empty) Then
    '        '    Session("sGroupName")
    '        'End If

    '        'If Not String.IsNullOrEmpty(Session("sProductCode")) AndAlso Not Session("sProductCode").Trim().Equals(String.Empty) Then
    '        '    Session("sProductCode")
    '        'End If

    '        'If Not String.IsNullOrEmpty(Session("sSalesPerson")) AndAlso Not Session("sSalesPerson").Trim().Equals(String.Empty) Then
    '        '    Session("sSalesPerson")
    '        'End If
    '    ElseIf Session("SubmitMode").Equals("detail") Then    '詳細ボタンなどの場合

    '    Else    '初期の場合
    '        Session("Mode") = String.Empty
    '        Session("sGroupNo") = String.Empty
    '        Session("sGroupName") = String.Empty
    '        Session("sProductCode") = String.Empty
    '        Session("sSalesPerson") = String.Empty
    '    End If

    'End Sub

    'Private Sub PopGroup_LoadComplete(sender As Object, e As EventArgs) Handles Me.LoadComplete

    '    '20200325 DELETE
    '    'Dim uri As Uri = Request.Url
    '    'Response.Cookies("AutoLogoutPage").Value = uri.AbsoluteUri
    '    'Response.Cookies("AutoLogoutPage").Expires = DateTime.Now.AddDays(31) ' Cookie 有効期間（31日）

    'End Sub

#End Region

#Region "Methods"

    '20200324 ADD
    ''' <summary>
    ''' グループ管理(リスト)検索を取得する
    ''' </summary>
    ''' <returns></returns>
    Public Shared Function GetGroupData(sGroupNo As String,
                                        sGroupName As String,
                                        sProductCode As String,
                                        sSalesPerson As String) As DataSet

        Dim ds As DataSet = Nothing

        Try
            'TODO:testデータ

            ds = New DataSet

            Dim dt As DataTable = New DataTable
            dt.Columns.Add(New DataColumn With {.ColumnName = "GroupNo", .DefaultValue = String.Empty, .DataType = Type.GetType("System.String")})
            dt.Columns.Add(New DataColumn With {.ColumnName = "rGroupName", .DefaultValue = String.Empty, .DataType = Type.GetType("System.String")})
            dt.Columns.Add(New DataColumn With {.ColumnName = "SalesPersonName", .DefaultValue = String.Empty, .DataType = Type.GetType("System.String")})
            Dim dr As DataRow = dt.NewRow

            dr("GroupNo") = "GROUP001000"
            dr("rGroupName") = "GroupTitle1000000000ああああああああああいいいいいいいいいいううううううううううええええええええええおおおおおおおおおおああああああああああいいいいいいいいいいうううううううううう"
            dr("SalesPersonName") = "リーダ名１00000"

            dt.Rows.Add(dr)
            dt.TableName = "group_result_table"
            ds.Tables.Add(dt)

        Catch ex As Exception
            Throw
        Finally

        End Try

        Return ds

    End Function

    ''' <summary>
    ''' グループ管理(詳細)を取得する
    ''' </summary>
    ''' <returns></returns>
    Public Shared Function GetGroupDetailData(GroupNo As String, CheckNum As String) As DataSet
        'Public Shared Function GetGroupDetailData(GroupNo As String, mode As String) As DataSet    '''' '20200324 EDIT

        Dim ds As DataSet = Nothing

        Try
            'TODO:testデータ

            ds = New DataSet

            Dim dt As DataTable = New DataTable
            dt.Columns.Add(New DataColumn With {.ColumnName = "GroupNo", .DefaultValue = String.Empty, .DataType = Type.GetType("System.String")})
            dt.Columns.Add(New DataColumn With {.ColumnName = "rGroupName", .DefaultValue = String.Empty, .DataType = Type.GetType("System.String")})
            dt.Columns.Add(New DataColumn With {.ColumnName = "LeaderName", .DefaultValue = String.Empty, .DataType = Type.GetType("System.String")})
            dt.Columns.Add(New DataColumn With {.ColumnName = "rGroupCycle", .DefaultValue = String.Empty, .DataType = Type.GetType("System.String")})
            Dim dr As DataRow = dt.NewRow
            dr("GroupNo") = "GROUP001000"
            dr("rGroupName") = "GroupTitle1000000000ああああああああああいいいいいいいいいいううううううううううええええええええええおおおおおおおおおおああああああああああいいいいいいいいいいうううううううううう"
            dr("LeaderName") = "リーダ名１00000"
            dr("rGroupCycle") = "12"
            dt.Rows.Add(dr)
            dt.TableName = "group_table1"
            ds.Tables.Add(dt)

            Dim dt2 As DataTable = New DataTable
            dt2.Columns.Add(New DataColumn With {.ColumnName = "CheckNum", .DefaultValue = String.Empty, .DataType = Type.GetType("System.String")})
            dt2.Columns.Add(New DataColumn With {.ColumnName = "SalesPersonName", .DefaultValue = String.Empty, .DataType = Type.GetType("System.String")})
            dt2.Columns.Add(New DataColumn With {.ColumnName = "LeaderFlag", .DefaultValue = String.Empty, .DataType = Type.GetType("System.String")})
            dt2.Columns.Add(New DataColumn With {.ColumnName = "Title", .DefaultValue = String.Empty, .DataType = Type.GetType("System.String")})
            dt2.Columns.Add(New DataColumn With {.ColumnName = "CustomerCode", .DefaultValue = String.Empty, .DataType = Type.GetType("System.String")})
            dt2.Columns.Add(New DataColumn With {.ColumnName = "CustomerName", .DefaultValue = String.Empty, .DataType = Type.GetType("System.String")})
            dt2.Columns.Add(New DataColumn With {.ColumnName = "EditFlag", .DefaultValue = String.Empty, .DataType = Type.GetType("System.String")})
            dt2.Columns.Add(New DataColumn With {.ColumnName = "NewCheckNumFlag", .DefaultValue = String.Empty, .DataType = Type.GetType("System.String")})

            Dim dr2 As DataRow = dt2.NewRow

            '新規作成でない
            dr2("CheckNum") = "X19060100001"
            dr2("SalesPersonName") = "リーダ名１00000"
            dr2("LeaderFlag") = "1"             'ﾘｰﾀﾞｰ
            dr2("Title") = "てすと４ああああああああああいいいいいいいいいいううううううううううええええええええええおおおおおおおおおおああああああああああいいいいいいいいいいううううううううううええええええええええおおおおおお"
            dr2("CustomerCode") = "てすと５"
            dr2("CustomerName") = "てすと６ああああああああああいいいいいいいいいいううううううううううええええええええええおおおおおおおおおおああああああああああいいいいいいいいいいううううううううううええええええええええおおおおおお"
            dr2("EditFlag") = "0"               '新規作成でない
            dr2("NewCheckNumFlag") = "0"        '見積番号なし
            dt2.Rows.Add(dr2)

            dr2 = dt2.NewRow
            dr2("CheckNum") = "X19060100002"
            dr2("SalesPersonName") = "テスト２"
            dr2("LeaderFlag") = "0"
            dr2("Title") = "テスト４"
            dr2("CustomerCode") = "テスト５"
            dr2("CustomerName") = "テスト６"
            dr2("EditFlag") = "0"               '新規作成でない
            dr2("NewCheckNumFlag") = "0"        '見積番号なし
            dt2.Rows.Add(dr2)

            '新規作成
            'dr2 = dt2.NewRow
            'dr2("CheckNum") = "X19060100004"
            'dr2("SalesPersonName") = "テスト２000000"
            'dr2("LeaderFlag") = "0"
            'dr2("Title") = "テスト４"
            'dr2("CustomerCode") = "テスト５"
            'dr2("CustomerName") = "テスト６"
            'dr2("EditFlag") = "1"               '新規作成
            'dr2("NewCheckNumFlag") = "1"        '見積番号あり
            'dt2.Rows.Add(dr2)

            'dr2 = dt2.NewRow
            'dr2("CheckNum") = "X19060100005"
            'dr2("SalesPersonName") = "テスト２"
            'dr2("LeaderFlag") = "0"
            'dr2("Title") = "不明データ"
            'dr2("CustomerCode") = "テスト５"
            'dr2("CustomerName") = "テスト６"
            'dr2("EditFlag") = "1"               '新規作成
            'dr2("NewCheckNumFlag") = "0"        '見積番号なし
            'dt2.Rows.Add(dr2)

            dt2.TableName = "group_table2"
            ds.Tables.Add(dt2)

        Catch ex As Exception
            Throw
        Finally

        End Try

        Return ds

    End Function

    '20200317 ADD
    ''' <summary>
    ''' グループ管理(詳細)見積追加データを取得する
    ''' </summary>
    ''' <returns></returns>
    Public Shared Function GetGroupDetailNew(CheckNum As String) As DataSet

        Dim ds As DataSet = Nothing

        Try
            'TODO:

        Catch ex As Exception
            Throw
        Finally

        End Try

        Return ds

    End Function

    '20200325 ADD
    ''' <summary>
    ''' グループ管理(詳細)保存を取得する
    ''' </summary>
    ''' <returns></returns>
    Public Shared Function SetGroupData(GroupNo As String,
                                        GroupName As String,
                                        GroupCycle As String,
                                        LeaderCheckNum As String,
                                        CheckNumList As String) As DataSet

        Dim ds As DataSet = Nothing

        Try
            'TODO:
            ds = New DataSet

            'メッセージを返却
            Dim dt As DataTable = New DataTable
            dt.Columns.Add(New DataColumn With {.ColumnName = "message", .DefaultValue = String.Empty, .DataType = Type.GetType("System.String")})
            Dim dr As DataRow = dt.NewRow

            '成功の場合、メッセージ
            dr("message") = Util.MSG_SAVE_SUCCESS
            '失敗の場合、メッセージを返却
            dr("message") = Util.MSG_SAVE_FAILURE

            dt.Rows.Add(dr)
            dt.TableName = "aaa"    'TODO:仮テーブル名
            ds.Tables.Add(dt)

        Catch ex As Exception
            Throw
        Finally

        End Try

        Return ds

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

#End Region

#Region "WebMethods"

    '20200324 ADD
    ''' <summary>
    ''' グループ管理(リスト)検索　Jsonデータを取得する
    ''' </summary>
    ''' <returns></returns>
    <System.Web.Services.WebMethod>
    Public Shared Function GetJsonGroupData(sGroupNo As String,
                                            sGroupName As String,
                                            sProductCode As String,
                                            sSalesPerson As String) As String

        Dim ds As DataSet

        Try
            ds = GetGroupData(sGroupNo, sGroupName, sProductCode, sSalesPerson)
        Catch ex As Exception
            Return "エラー：" & ex.Message
        End Try

        Return JsonConvert.SerializeObject(ds)

    End Function

    ''' <summary>
    ''' グループ管理(詳細)　Jsonデータを取得する
    ''' </summary>
    ''' <returns></returns>
    <System.Web.Services.WebMethod>
    Public Shared Function GetJsonGroupDetailData(GroupNo As String, CheckNum As String) As String

        Dim ds As DataSet

        Try
            ds = GetGroupDetailData(GroupNo, CheckNum)
        Catch ex As Exception
            Return "エラー：" & ex.Message
        End Try

        Return JsonConvert.SerializeObject(ds)

    End Function

    '20200317 ADD
    ''' <summary>
    ''' グループ管理(詳細)見積追加　Jsonデータを取得する
    ''' </summary>
    ''' <returns></returns>
    <System.Web.Services.WebMethod>
    Public Shared Function GetJsonGroupDetailNew(cno As String) As String

        Dim ds As DataSet

        Try
            ds = GetGroupDetailNew(cno)
        Catch ex As Exception
            Return "エラー：" & ex.Message
        End Try

        Return JsonConvert.SerializeObject(ds)

    End Function

    '20200324 ADD
    ''' <summary>
    ''' グループ管理(詳細)保存　Jsonデータを取得する
    ''' </summary>
    ''' <returns></returns>
    <System.Web.Services.WebMethod>
    Public Shared Function SaveJsonGroupData(GroupNo As String,
                                             GroupName As String,
                                             GroupCycle As String,
                                             LeaderCheckNum As String,
                                             CheckNumList As String) As String

        Dim ds As DataSet

        Try
            ds = SetGroupData(GroupNo, GroupName, GroupCycle, LeaderCheckNum, CheckNumList)
        Catch ex As Exception
            Return "エラー：" & ex.Message
        End Try

        Return JsonConvert.SerializeObject(ds)

    End Function

    ''' <summary>
    ''' テストデータを取得する
    ''' </summary>
    ''' <returns></returns>
    <System.Web.Services.WebMethod>
    Public Shared Function GetJsonTestData(ByVal test As String) As String

        Dim ds As DataSet = GetTestData(test)

        Return JsonConvert.SerializeObject(ds)

    End Function

#End Region

End Class