Imports System.Web.Optimization

Public Class Global_asax
    Inherits HttpApplication

    Dim robots =
    {
        "googlebot", "slurp", "bingbot"
    }
    Function IsRobot() As Boolean
        Dim useragent = Request.UserAgent
        For Each robot In robots
            If useragent.Contains(robot) Then
                Return True
            Else
                Return False
            End If
        Next
        Return False
    End Function

    Sub Application_Start(sender As Object, e As EventArgs)
        ' アプリケーションの起動時に呼び出されます

        '20200214 参考　https://qiita.com/ta-yamaoka/items/ac81bd5223affe4c6944
        'ASP.NET Friendly URLsを使用すると通常の方法でPageMethodsが呼び出せなくなる
        'efault.aspxにあるTestMethodというPageMethodsを呼び出す場合、
        'Default.aspx/TestMethodにアクセスする必要があるが、
        'ASP.NET Friendly URLsを使用していると
        'Default/TestMethodにアクセスされたことになり
        'DefaultのHTMLが返却される
        'RouteConfig.RegisterRoutes(RouteTable.Routes)

        BundleConfig.RegisterBundles(BundleTable.Bundles)

        Application.Add("head_title", "見積案件システム")
    End Sub
    Sub Application_End(sender As Object, e As EventArgs)
        'アプリケーションのシャットダウンで実行するコードです

        '20200311 TODO:要処理確認
        '↓20200311 ロック開放処理
        Dim SiteMaster As New SiteMaster

        If SiteMaster.LockLeave_Flag = 0 Then
            'ログアウト処理内のロック開放処理が行われていない場合（未処理：0）
            Dim strCheckNum = Request.Form("ctl00$body$CheckNum")

            If Not String.IsNullOrEmpty(strCheckNum) Then
                Dim Logout_Class As New Logout_Class
                Dim strEstPersonCode As String = Session("EstPersonCode")

                Logout_Class.LockLeave(strCheckNum, strEstPersonCode)
            End If
        End If
        '↑20200311 ロック開放処理
    End Sub

    'TODO: release時
    'Sub Application_Error(sender As Object, e As EventArgs)
    '    'ハンドルされていないエラーが発生したときに実行するコードです
    '    Dim message As StringBuilder = New StringBuilder()

    '    If (Server IsNot Nothing) Then

    '        ' 例外の内容を取得し、StringBuilder に格納する
    '        Dim ex As Exception = Server.GetLastError()
    '        While ex IsNot Nothing

    '            message.AppendFormat("{0}: {1}{2}", ex.GetType().FullName, ex.Message, ex.StackTrace)

    '            ex = ex.InnerException
    '        End While

    '        ' 例外情報と内部例外情報をログとして出力する処理など
    '        Dim logger = New System.IO.StreamWriter(Server.MapPath("App_Data/access.log"), True)
    '        logger.WriteLine(--Application_Error--)
    '        message = message.Insert(0, "ERR: ")
    '        logger.WriteLine(message)
    '        logger.Close()

    '        ' 例外をクリア（カスタムエラーページを設定している場合はコメントアウトすること）
    '        Server.ClearError()
    '    End If
    'End Sub

    Public Sub Session_OnStart()

    End Sub

    'Abandon メソッドが呼び出されたとき、またはセッションの有効期限が切れたときに、要求の最後に発生します
    Public Sub Session_OnEnd()

        'TODO:20200303 DELETE ログアウト後、ここでエラー発生するため
        'Response.Redirect("Index.aspx")
    End Sub

End Class