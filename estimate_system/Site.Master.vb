Public Class SiteMaster
    Inherits MasterPage

    '20200311 ロック解除フラグ
    Friend LockLeave_Flag As Integer = 0    'ロック解除処理（未処理：0／処理済：1）

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load

        'ページロード時
        If Not Page.IsPostBack Then

            '画面タイトル
            lblHeadTitle.Text = CType(Application("head_title"), String)
            'ログイン名を表示
            If Not IsNothing(Session("EstPersonName")) Then
                lblLoginName.Text = CType(Session("EstPersonName"), String)
                'MstLoginName = Session("EstPersonName")
                Label1.Visible = True
                lblLoginName.Visible = True
                BtnLogout.Visible = True
            Else
                Label1.Visible = False
                lblLoginName.Visible = False
                BtnLogout.Visible = False
            End If

        Else    'postbackの時

        End If

    End Sub

    Protected Sub BtnLogout_Click(sender As Object, e As EventArgs) Handles BtnLogout.Click

        '20200201 TODO:
        Dim strCheckNum = Request.Form("ctl00$body$CheckNum")   'OK
        If Not String.IsNullOrEmpty(strCheckNum) Then
            'TODO:ロック解除処理必要
            'tEstimateParentテーブル検索
            'CheckNumとSession("EstPersonCode") が一致する場合、更新（データクリア）
            '↓20200311 ロック解除処理
            Dim Logout_Class As New Logout_Class
            Dim strEstPersonCode As String = Session("EstPersonCode")

            Logout_Class.LockLeave(strCheckNum, strEstPersonCode)
            '↑20200311
        End If

        '20200311 ロック解除処理フラグ（処理済：1）
        LockLeave_Flag = 1

        ' セッション情報を初期化
        Session.Abandon()

        '遷移先で空になっている->NG
        'flgMasterLogout = True
        admin_header_mode.Value = "logout"

        ' ログインページへ
        'Response.Redirect("Login.aspx")
        Server.Transfer("Login.aspx")

    End Sub

    'Public Property flgMasterLogout As Boolean = False

    'Public WriteOnly Property Logout() As String
    '    Set(ByVal value As String)
    '        lblLoginName.Text = value
    '    End Set
    'End Property

End Class