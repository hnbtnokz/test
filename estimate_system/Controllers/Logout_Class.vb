'********************************************************
' ログアウト時　ロック開放処理
'********************************************************
Imports estimate_system.Common

Public Class Logout_Class
    Public Property ErrMsg As String = String.Empty

    'ロック開放処理
    Public Sub LockLeave(ByVal CheckNum As String, ByVal EstPersonCode As String)
        Dim Logout_Query As New Logout_Query

        Logout_Query.update_tEstimateParent_LockUser(CheckNum, EstPersonCode)
    End Sub

End Class
