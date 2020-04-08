Imports Newtonsoft.Json

Public Class PopCustomerSearch
    Inherits System.Web.UI.Page

#Region "Events"

    ''' <summary>
    ''' Page_Load
    ''' </summary>
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

        'ページロード時
        'If Not IsPostBack Then

        'Else    'Postbackの時

        'End If

    End Sub

    ''' <summary>
    ''' PopCustomerSearch_LoadComplete
    ''' </summary>
    Private Sub PopCustomerSearch_LoadComplete(sender As Object, e As EventArgs) Handles Me.LoadComplete

        'Dim uri As Uri = Request.Url
        'Response.Cookies("AutoLogoutPage").Value = uri.AbsoluteUri
        'Response.Cookies("AutoLogoutPage").Expires = DateTime.Now.AddDays(31) ' Cookie 有効期間（31日）

    End Sub

#End Region

#Region "Methods"
    ''' <summary>
    ''' 得意先検索データを取得する
    ''' </summary>
    ''' <returns></returns>
    Public Shared Function GetCustomerData(ByVal Code As String,
                                           ByVal Name As String,
                                           ByVal Index As String,
                                           ByVal Tel As String) As DataSet

        Dim ds As DataSet = Nothing

        Try
            'TODO:testデータ

            ds = New DataSet

            Dim dt As DataTable = New DataTable
            dt.Columns.Add(New DataColumn With {.ColumnName = "KNA1_KUNNR", .DefaultValue = String.Empty, .DataType = Type.GetType("System.String")})
            dt.Columns.Add(New DataColumn With {.ColumnName = "ADRC_NAME1", .DefaultValue = String.Empty, .DataType = Type.GetType("System.String")})
            dt.Columns.Add(New DataColumn With {.ColumnName = "EName", .DefaultValue = String.Empty, .DataType = Type.GetType("System.String")})
            dt.Columns.Add(New DataColumn With {.ColumnName = "AName", .DefaultValue = String.Empty, .DataType = Type.GetType("System.String")})
            dt.Columns.Add(New DataColumn With {.ColumnName = "ADRC_TEL_NUMBER", .DefaultValue = String.Empty, .DataType = Type.GetType("System.String")})
            Dim dr As DataRow = dt.NewRow

            dr("KNA1_KUNNR") = "test1"
            dr("ADRC_NAME1") = "test2"
            dr("EName") = "test3"
            dr("AName") = "test4"
            dr("ADRC_TEL_NUMBER") = "test5"

            dt.Rows.Add(dr)
            dt.TableName = "result_tbl"    'TODO:仮テーブル名
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

    '20200326 ADD
    ''' <summary>
    ''' 得意先検索データ　Jsonデータを取得する
    ''' </summary>
    ''' <returns></returns>
    <System.Web.Services.WebMethod>
    Public Shared Function GetJsonCustomerData(ByVal Code As String,
                                               ByVal Name As String,
                                               ByVal Index As String,
                                               ByVal Tel As String) As String

        Dim ds As DataSet

        Try
            ds = GetCustomerData(Code, Name, Index, Tel)
        Catch ex As Exception
            Return "エラー：" & ex.Message
        End Try

        Return JsonConvert.SerializeObject(ds)

    End Function

    ''' <summary>
    ''' テストデータ　Jsonデータを取得する
    ''' </summary>
    ''' <returns></returns>
    <System.Web.Services.WebMethod>
    Public Shared Function GetJsonTestData(ByVal test As String) As String

        Dim ds As DataSet = GetTestData(test)

        Return JsonConvert.SerializeObject(ds)

    End Function

#End Region

End Class