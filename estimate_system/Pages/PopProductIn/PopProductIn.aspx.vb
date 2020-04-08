Imports System.IO
Imports System.Collections.Generic
Imports Newtonsoft.Json
Imports System.Text
Imports estimate_system.Common

Public Class PopProductIn
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

End Class