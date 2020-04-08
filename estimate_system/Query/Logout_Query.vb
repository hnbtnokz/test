'********************************************************
' ログアウト時　クエリ生成処理
'********************************************************
Imports estimate_system.Common

Public Class Logout_Query
    'ロック開放処理
    Public Sub update_tEstimateParent_LockUser(ByVal CheckNum As String, ByVal EstPersonCode As String)
        Try
            Dim sql As New StringBuilder
            Dim result As Integer = 0

            With sql
                .Append("UPDATE tEstimateParent ")
                .Append("SET LockUserCode = '', LockUserName = '', LockDate = Null ")
                .AppendFormat("WHERE CheckNum = '{0}' ", Trim(CheckNum))
                .AppendFormat("AND LockUserCode = '{0}'", EstPersonCode)
            End With

            result = SQL_Common.ExecSql(sql.ToString, Util.DB_SERVER)
        Catch ex As Exception
            MsgBox("ロックの開放に失敗しました。(tEstimateParent)" + Environment.NewLine + "ユーザーコード：" + EstPersonCode + Environment.NewLine + ex.Message)
        End Try
    End Sub

End Class
