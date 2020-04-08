'********************************************************
' ログインSQLクエリ処理
'********************************************************
Imports estimate_system.Common

Public Class Login_Query

    'ログインデータ取得
    '20200219 TryCatch処理追加
    Public Function get_login(ByVal loginID As String, ByVal loginPW As String) As DataTable
        Try
            Dim sql As New StringBuilder
            Dim Result_DataTable As DataTable

            With sql
                .Append("SELECT MemberCode, FullName, KGLoginName, KGPassword, DutyStationDivision, PersonClass2, ")
                .Append("KGAuthority, DivisionName ")
                .Append("FROM mMember ")
                .AppendFormat("WHERE KGLoginName = '{0}' ", loginID)
                .AppendFormat("AND KGPassword = '{0}' ", loginPW)
                .Append("AND (DeleteFlag = 0 or DeleteFlag is Null)")
            End With

            Result_DataTable = SQL_Common.SelectSql(sql.ToString, Util.DB_SERVER)

            Return Result_DataTable
        Catch ex As Exception
            MsgBox("ログインに失敗しました。" + Environment.NewLine + ex.Message)

            Return Nothing
        End Try
    End Function
End Class
