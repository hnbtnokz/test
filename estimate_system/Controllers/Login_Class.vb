'********************************************************
' ログイン処理
'********************************************************
Imports estimate_system.Common

Public Class Login_Class
    'ADD 20200127
    Public Property IsLoginValid() As Boolean = False
    Public Property MMember As MMember
    Public Property ErrMsg As String = String.Empty

    'ログインボタン処理
    Public Sub check_login(ByVal loginID As String, ByVal loginPW As String)
        Dim Login_Query As New Login_Query
        Dim TableName As String = "mMember"
        Dim mMember_Table As DataTable
        Dim rows As DataRow

        'ADD 20200127
        Dim member As MMember = New MMember
        'ADD 20200131
        MMember = member

        member.IsLoginValid = False

        If loginID = "" Then
            'MsgBox("ログインIDが入力されていません", MsgBoxStyle.OkOnly, "IDチェック")
            ErrMsg = "ログインIDが入力されていません"
        ElseIf loginPW = "" Then
            'MsgBox("パスワードが入力されていません", MsgBoxStyle.OkOnly, "パスワードチェック")
            ErrMsg = "パスワードが入力されていません"
        ElseIf loginID.Length > 30 Then
            'MsgBox("ログインIDの文字数がオーバーしています(30文字以内)", MsgBoxStyle.OkOnly, "IDチェック")
            ErrMsg = "ログインIDの文字数がオーバーしています(30文字以内)"
        ElseIf loginPW.Length > 20 Then
            'MsgBox("パスワードの文字数がオーバーしています(20文字以内)", MsgBoxStyle.OkOnly, "パスワードチェック")
            ErrMsg = "パスワードの文字数がオーバーしています(20文字以内)"
        ElseIf Util.IsHankaku(loginID) = False Then
            'MsgBox("ログインIDに全角文字が入力されています", MsgBoxStyle.OkOnly, "IDチェック")
            ErrMsg = "ログインIDに全角文字が入力されています"
        ElseIf Util.IsHankaku(loginPW) = False Then
            'MsgBox("パスワードに全角文字が入力されています", MsgBoxStyle.OkOnly, "パスワードチェック")
            ErrMsg = "パスワードに全角文字が入力されています"
        Else
            mMember_Table = Login_Query.get_login(loginID, loginPW)

            '20200311 mMember_TableがNothingの場合は処理を行わないよう修正
            If mMember_Table IsNot Nothing Then
                If mMember_Table.Rows.Count = 1 Then
                    '↓要変更
                    rows = mMember_Table.Rows(0)

                    'ADD 20200127
                    member.IsLoginValid = True
                    member.KGLoginName = rows("KGLoginName")
                    member.MemberCode = rows("MemberCode")
                    member.FullName = rows("FullName")
                    member.DutyStationDivision = rows("DutyStationDivision")

                    '↓20200206
                    If rows("PersonClass2").ToString = "0002" OrElse rows("KGAuthority") >= 20 Then
                        member.AdminFlag = "1"
                    Else
                        member.AdminFlag = "0"
                    End If

                    'TODO:DBのMemberCodeの最後に、半角SPが付いている
                    If rows("DivisionName").ToString.IndexOf("仕入") >= 0 OrElse rows("MemberCode").ToString = "10754" & " " Then
                        member.SupplierFlag = "1"
                    Else
                        member.SupplierFlag = "0"
                    End If
                    '↑20200206

                    member.PersonClass2 = rows("PersonClass2")
                    member.KGAuthority = rows("KGAuthority")
                    member.DivisionName = rows("DivisionName")

                    'DELETE 20200131
                    'MMember = member

                ElseIf mMember_Table.Rows.Count > 1 Then
                    ErrMsg = "複数の同一IDが検知されました。"
                Else
                    ErrMsg = "ID又はパスワードに誤りがあります。"
                End If
            End If
        End If
    End Sub

End Class
