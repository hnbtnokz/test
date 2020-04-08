Imports estimate_system.Common

Public Class Login
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        'ページロード時
        If Not Page.IsPostBack Then

            'ログアウト確認
            Dim flgLogout As Boolean = False
            If Not IsNothing(Page.PreviousPage) Then
                Dim param1 As HiddenField = CType(Page.PreviousPage.FindControl("ctl00$admin_header_mode"), HiddenField)
                If Not IsNothing(param1) AndAlso Not IsNothing(param1.Value) AndAlso param1.Value.Equals("logout") Then
                    flgLogout = True
                End If
            End If
            '遷移先で空になっている->NG
            'Dim flg1 = Master.flgMasterLogout
            'Dim param2 = Request.Form("ctl00$admin_header_mode") 'NG
            'Dim param3 = CType(Page.Master.FindControl("ctl00$admin_header_mode"), HiddenField)  'NG

            'クッキー確認
            Dim flgCookie As Boolean = False
            Dim strKGLoginName As String = Nothing
            Dim strKGPassword As String = Nothing
            Dim cookie As HttpCookie = Request.Cookies("estimate_system")
            If Not IsNothing(cookie) Then
                strKGLoginName = Server.HtmlEncode(cookie.Values("UID").Trim())
                strKGPassword = Server.HtmlEncode(cookie.Values("Pass").Trim())
                If Not IsNothing(strKGLoginName) Then
                    flgCookie = True
                    txtKGLoginName.Text = strKGLoginName
                End If
                If Not IsNothing(strKGPassword) Then
                    txtKGPassword.Text = strKGPassword
                End If
            End If

            'ログアウト or Cookieなしの場合
            If flgLogout OrElse flgCookie = False Then

                '画面メッセージ
                lblMsg.Text = "ログインID と パスワードを入力してください"
                lblErrMsg.Text = String.Empty

            Else    'ログアウト以外 and Cookieありの場合

                'If strKGPassword.Equals(txtKGPassword) Then    '不要らしい
                'Else
                '    Dim LoginErrPass = 1    '不要らしい
                'End If

                'ログイン認証
                Dim LoginClass As New Login_Class
                LoginClass.check_login(strKGLoginName, strKGPassword)

                'ログイン認証結果
                Dim member = LoginClass.MMember

                'ログイン成功時
                If member.IsLoginValid Then

                    ' セッションのタイムアウト時間設定
                    'Session.Timeout = 30

                    'セッションにセット
                    Session("EstPersonCode") = Right("00000000" & member.MemberCode, 8)
                    Session("EstPersonName") = member.FullName
                    Session("PersonDivision") = member.DutyStationDivision

                    'ADD 20200212
                    HttpContext.Current.Session("SESSIONID") = Session.SessionID

                    'TODO:20200212
                    HttpContext.Current.Session("DIRECTFLG") = "1"

                    '営業部リーダ
                    '権限（回答返信権限）
                    If member.PersonClass2.Equals("0002") Or member.KGAuthority >= 20 Then
                        Session("AdminFlag") = member.AdminFlag
                    End If

                    '仕入れ部門：回答、仕入れ用項目あり画面
                    If member.DivisionName.Contains("仕入") Or member.MemberCode.Equals("10754" & " ") Then
                        Session("SupplierFlag") = member.SupplierFlag
                    End If

                    'クッキーにユーザ名をセット
                    Dim cookie2 = New HttpCookie("estimate_system")
                    cookie2.Values("UID") = strKGLoginName
                    cookie2.Values("Pass") = strKGPassword
                    cookie2.Expires = DateTime.Now.AddDays(31)  ' Cookie1ヶ月有効

                    'TODO:release時、検討必要
                    'cookie2.Path = "/Application1"
                    'cookie2.Domain = "abc.com"
                    'cookie2.Secure = True
                    cookie2.HttpOnly = True
                    Response.Cookies.Add(cookie2)

                    '次画面へ遷移
                    Response.Redirect("Index.aspx")

                Else    'ログイン失敗時

                    '画面メッセージ
                    lblMsg.Text = "正しいユーザーID、パスワードを入力してください"
                    'エラーメッセージ
                    lblErrMsg.Text = LoginClass.ErrMsg

                End If
            End If

        Else    'Postbackの時

        End If

#Region "本来あるべき姿"
        ''ページロード時
        'If Not Page.IsPostBack Then

        '    'クッキーを確認
        '    Dim cookie As HttpCookie = Request.Cookies("estimate_system")
        '    ''Cookieありの場合
        '    If Not IsNothing(cookie) Then
        '        If Not IsNothing(cookie.Values("UID")) Then
        '            txtKGLoginName.Text = Server.HtmlEncode(cookie.Values("UID"))
        '        End If
        '        If Not IsNothing(cookie.Values("Pass")) Then
        '            txtKGPassword.Text = Server.HtmlEncode(cookie.Values("Pass"))
        '        End If
        '    End If
        '    'If Not Request.Cookies("estimate_system") Is Nothing Then
        '    '    Dim UserInfoCookieCollection As System.Collections.Specialized.NameValueCollection
        '    '    UserInfoCookieCollection = Request.Cookies("estimate_system").Values
        '    '    txtKGLoginName.Text = Server.HtmlEncode(UserInfoCookieCollection("UID"))
        '    '    txtKGPassword.Text = Server.HtmlEncode(UserInfoCookieCollection("Pass"))
        '    'End If
        '    'If Not Request.Cookies("estimate_system") Is Nothing Then
        '    '    txtKGLoginName.Text = Server.HtmlEncode(Request.Cookies("estimate_system")("UID"))
        '    '    txtKGPassword.Text = Server.HtmlEncode(Request.Cookies("estimate_system")("Pass"))
        '    'End If

        '    'セッションを確認
        '    If IsNothing(Session("EstPersonCode")) OrElse IsNothing(Session("EstPersonName")) Then

        '    End If

        '    '画面メッセージ
        '    lblMsg.Text = "ログインID と パスワードを入力してください"
        '    lblErrMsg.Text = String.Empty

        'Else    'Postbackの時

        'End If
#End Region

    End Sub

    Protected Sub BtnLogin_Click(sender As Object, e As EventArgs) Handles BtnLogin.Click

        Dim strKGLoginName As String = Server.HtmlEncode(txtKGLoginName.Text.Trim())
        Dim strKGPassword As String = Server.HtmlEncode(txtKGPassword.Text.Trim())

        'ログイン認証
        Dim LoginClass As New Login_Class
        LoginClass.check_login(strKGLoginName, strKGPassword)

        'ログイン認証結果
        Dim member = LoginClass.MMember
        Dim flgLoginValid As Boolean = member.IsLoginValid

        'ログイン成功時
        If flgLoginValid Then
            'If strKGPassword.Equals(txtKGPassword) Then    '不要らしい

            'セッションにセット
            Session("EstPersonCode") = Right("00000000" & member.MemberCode, 8)
            Session("EstPersonName") = member.FullName
            Session("PersonDivision") = member.DutyStationDivision

            'ADD 20200212
            HttpContext.Current.Session("SESSIONID") = Session.SessionID

            'TODO:20200212
            HttpContext.Current.Session("DIRECTFLG") = "1"

            '営業部リーダ
            '権限（回答返信権限）
            If member.PersonClass2.Equals("0002") Or member.KGAuthority >= 20 Then
                Session("AdminFlag") = member.AdminFlag
            End If

            '仕入れ部門：回答、仕入れ用項目あり画面
            'TODO:DBデータMemberCodeの最後に、半角SPが１個付いている
            If member.DivisionName.Contains("仕入") Or member.MemberCode.Equals("10754" & " ") Then
                Session("SupplierFlag") = member.SupplierFlag
            End If

            'クッキーにユーザ名をセット
            Dim cookie = New HttpCookie("estimate_system")
            cookie.Values("UID") = strKGLoginName
            cookie.Values("Pass") = strKGPassword
            cookie.Expires = DateTime.Now.AddDays(31)  ' Cookie1ヶ月有効

            'TODO:release時、検討必要
            'cookie.Path = "/Application1"
            'cookie.Domain = "abc.com"
            'cookie.Secure = True
            cookie.HttpOnly = True
            Response.Cookies.Add(cookie)

            'Visual Studio 2019 16.4.2　クッキー有効期間の更新が出来ない
            'Developer Community(https: //developercommunity.visualstudio.com/) で 「DateTime.Now = Cannot provide the value: host value Not found」と検索すると幾つかのトピックスが見付かります。
            'Visual Studio 2019の不具合のようで、回避方法はない。

            '画面メッセージ
            lblMsg.Text = String.Empty
            lblErrMsg.Text = String.Empty

            '次画面へ遷移
            Response.Redirect("Index.aspx")

            'Else
            '    Dim LoginErrPass = 1    '不要らしい
            'End If

        Else    'ログイン失敗時

            '画面メッセージ
            lblMsg.Text = "正しいユーザーID、パスワードを入力してください"
            'エラーメッセージ
            lblErrMsg.Text = LoginClass.ErrMsg
        End If

    End Sub

End Class