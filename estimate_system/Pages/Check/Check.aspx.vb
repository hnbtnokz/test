Imports System.IO
Imports System.Collections.Generic
Imports Newtonsoft.Json
Imports System.Text
Imports estimate_system.Common
Public Class Check
    Inherits System.Web.UI.Page

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

        If IsNothing(Request.QueryString("cno")) OrElse Request.QueryString("cno").Equals(String.Empty) Then
            '20200325 EDIT
            'Exit Sub
            Response.Redirect("Index.aspx", False)
        End If

    End Sub

    Private Sub Detail_LoadComplete(sender As Object, e As EventArgs) Handles Me.LoadComplete
        '20200325 DELETE
        'Dim uri As Uri = Request.Url
        'Response.Cookies("AutoLogoutPage").Value = uri.AbsoluteUri
        'Response.Cookies("AutoLogoutPage").Expires = DateTime.Now.AddDays(31) ' Cookie 有効期間（31日）

    End Sub

    '#Region "BtnSave_Click時"
    '    Protected Sub BtnSave_Click(sender As Object, e As EventArgs) Handles BtnSave.Click

    '        Dim strHMailSendFlag = MailSendFlag.Value.Trim()

    '        '保 存 (メール送信)
    '        If strHMailSendFlag.Equals("submit") Then
    '            'TODO:

    '        Else    '保 存
    '            'TODO:

    '        End If

    '    End Sub
    '#End Region

#End Region

#Region "Methods"

    '↓20200309
    ''' <summary>
    ''' 見積案件データを取得する
    ''' </summary>
    ''' <returns></returns>
    Public Shared Function GetEstimateData(CheckNum As String, mode As String) As DataSet

        Dim LockComment As String = String.Empty
        Dim sql As New StringBuilder

        sql.Append("SELECT EP.*, CONVERT(VARCHAR, CreateTime, 111) As CreateTime, ")
        sql.Append("MM1.ExtensionNumber AS SalesEx, MM2.ExtensionNumber AS AssistantEx ")
        sql.Append("FROM tEstimateParent EP ")
        sql.Append("LEFT JOIN mMember MM1 ")
        sql.Append("ON Right(EP.SalesPersonCode,6) = MM1.MemberCode ")
        sql.Append("LEFT JOIN mMember MM2 ")
        sql.Append("ON Right(EP.AssistantCode,6) = MM2.MemberCode ")
        sql.AppendFormat("WHERE EP.CheckNum = '{0}' ", CheckNum)
        sql.Append("And EP.DeleteFlag = 0")

        Dim ds = New DataSet
        Dim dtEst As New DataTable
        Dim dt1 As New DataTable
        Dim dt2 As New DataTable

        Try
            dt1 = SQL_Common.SelectSql(sql.ToString, Util.DB_SERVER)

            If dt1.Rows.Count = 0 Then
                'TODO：検索一覧ページへページ遷移する
            ElseIf dt1.Rows.Count > 0 Then
                sql.Clear()

                sql.Append("SELECT * ")
                sql.Append("FROM tEstimateParent ")
                sql.AppendFormat("WHERE CheckNum = '{0}'", CheckNum)

                dtEst = SQL_Common.SelectSql(sql.ToString, Util.DB_SERVER)

                If dtEst.Rows.Count > 0 Then
                    'ロック制御
                    If dtEst.Rows(0)("LockDate") IsNot DBNull.Value AndAlso dtEst.Rows(0)("LockDate").ToString <> "" Then
                        If dtEst.Rows(0)("LockDate") = DateTime.Now Then
                            If dtEst.Rows(0)("LockUserCode") <> HttpContext.Current.Session("EstPersonCode") Then
                                If HttpContext.Current.Session("SessionComment") = "" Then
                                    LockComment = " onload=""estimateSystemCheckLockAlert('" + dtEst.Rows(0)("LockUserName") + "','" + dtEst.Rows(0)("LockDate") + "');"""
                                End If
                            End If
                        End If
                    End If

                    sql.Clear()
                    sql.Append("UPDATE tEstimateParent ")
                    sql.AppendFormat("SET LockUserCode = '{0}', ", HttpContext.Current.Session("EstPersonCode"))
                    sql.AppendFormat("LockUserName = '{0}', ", HttpContext.Current.Session("EstPersonName"))
                    sql.Append("LockDate = GETDATE() ")
                    sql.AppendFormat("WHERE CheckNum = '{0}'", CheckNum)

                    SQL_Common.ExecSql(sql.ToString, Util.DB_SERVER)
                End If

                'データ読込
                sql.Clear()
                sql.Append("SELECT * FROM tEstimateDetail ")
                sql.AppendFormat("WHERE CheckNum = '{0}' ", CheckNum)
                sql.Append("AND DeleteFlag = 0 ")
                sql.Append("ORDER BY Columns")

                dt2 = SQL_Common.SelectSql(sql.ToString, Util.DB_SERVER)

                dt2.TableName = "estDT"
                ds.Tables.Add(dt2)

                dt2 = Nothing
            End If
        Catch ex As Exception
            '20200326 EDIT
            'Dim msg As String = ex.Message
            Throw
        Finally
            dt1 = Nothing
            dtEst = Nothing

        End Try

        Return ds

    End Function
    '↑20200309

    '20200325 ADD
    ''' <summary>
    ''' 回答データを保存する
    ''' </summary>
    ''' <returns></returns>
    Public Shared Function SetEstimateCheckData(pdata As Object, checkNum As String, mailSendFlag As String) As DataSet

        'TODO:

        Dim sql As New StringBuilder

        Dim ds = New DataSet
        Dim dtEst As New DataTable
        Dim dt1 As New DataTable
        Dim dt2 As New DataTable

        Try

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

    'Private Shared Function ExtensionNoCall(supPerson As String) As String
    '    Return supPerson
    'End Function

#End Region

#Region "WebMethods"

    ''' <summary>
    ''' 見積案件データを取得する
    ''' </summary>
    ''' <returns></returns>
    <System.Web.Services.WebMethod>
    Public Shared Function GetJsonEstimateData(cno As String, mode As String) As String

        Dim ds As DataSet

        Try
            ds = GetEstimateData(cno, mode)
        Catch ex As Exception
            Return "エラー：" & ex.Message
        End Try

        Return JsonConvert.SerializeObject(ds)

    End Function

    '20200325 ADD
    ''' <summary>
    ''' 回答データを保存する
    ''' </summary>
    ''' <returns></returns>
    <System.Web.Services.WebMethod>
    Public Shared Function SetJsonEstimateCheckData(pdata As Object, checkNum As String, mailSendFlag As String) As String

        Dim ds As DataSet
        Try
            ds = SetEstimateCheckData(pdata, checkNum, mailSendFlag)
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