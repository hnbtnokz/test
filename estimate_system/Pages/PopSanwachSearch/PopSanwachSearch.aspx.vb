Imports System.IO
Imports System.Collections.Generic
Imports Newtonsoft.Json
Imports System.Text
Imports estimate_system.Common

Public Class PopSanwachSearch
    Inherits System.Web.UI.Page

#Region "Events"
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        ' セッション切れ処理終了
        'HttpContext.Current.Sessionは、使用可能なセッションがない場合、単にnullを返します
        If HttpContext.Current.Session("SESSIONID") <> Session.SessionID Then
            Response.Redirect("Login.aspx", False)
            Exit Sub
        End If

    End Sub
#End Region

#Region "Methods"

    ''' <summary>
    ''' ログインID選択　検索を取得する
    ''' </summary>
    ''' <returns></returns>
    Public Shared Function GetSanwaChData(AccountCode As String, LoginId As String) As DataSet

        Dim ds As DataSet = Nothing

        Try
            ''TODO:testデータ

            'ds = New DataSet

            'Dim dt As DataTable = New DataTable
            'dt.Columns.Add(New DataColumn With {.ColumnName = "LoginId", .DefaultValue = String.Empty, .DataType = Type.GetType("System.String")})
            'dt.Columns.Add(New DataColumn With {.ColumnName = "UserName", .DefaultValue = String.Empty, .DataType = Type.GetType("System.String")})
            'dt.Columns.Add(New DataColumn With {.ColumnName = "EmailAddress", .DefaultValue = String.Empty, .DataType = Type.GetType("System.String")})

            'Dim dr As DataRow = dt.NewRow
            'dr("LoginId") = "ああああああああああ"
            'dr("UserName") = "いいいいいいいいいい"
            'dr("EmailAddress") = "aaaaaaaaaaaaaaaaaaaa@bbbbb.jp"
            'dt.Rows.Add(dr)

            'dr = dt.NewRow
            'dr("LoginId") = "SanwaChLoginID1"
            'dr("UserName") = "test2"
            'dr("EmailAddress") = "test3"
            'dt.Rows.Add(dr)

            'dr = dt.NewRow
            'dr("LoginId") = "テスト１"
            'dr("UserName") = "テスト２"
            'dr("EmailAddress") = "テスト３"
            'dt.Rows.Add(dr)

            'dr = dt.NewRow
            'dr("LoginId") = "かかかかかかかかかか"
            'dr("UserName") = "きききききききききき"
            'dr("EmailAddress") = "xxxx@yyy.ppp.jp"
            'dt.Rows.Add(dr)

            'dt.TableName = "result_area"
            'ds.Tables.Add(dt)

        Catch ex As Exception
            Throw
        Finally

        End Try

        Return ds

    End Function

#End Region

#Region "WebMethods"

    ''' <summary>
    ''' ログインID選択　検索　Jsonデータを取得する
    ''' </summary>
    ''' <returns></returns>
    <System.Web.Services.WebMethod>
    Public Shared Function GetJsonSanwaChData(AccountCode As String, LoginId As String) As String

        Dim ds As DataSet

        Try
            ds = GetSanwaChData(AccountCode, LoginId)
        Catch ex As Exception
            Return "エラー：" & ex.Message
        End Try

        Return JsonConvert.SerializeObject(ds)

    End Function

#End Region

End Class