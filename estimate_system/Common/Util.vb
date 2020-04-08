Imports System.Globalization
Imports System.IO

Namespace Common

    Public Class Util

#Region "定数"
        ' データベースタイプ
        Public Const DB_SERVER As String = "DbConString"
        Public Const DW_SERVER As String = "DwConString"
        Public Const KG_SERVER As String = "KgConString"
        Public Const WB_SERVER As String = "WbConString"

        ' ×－－－－－－－－－－－－－－ 固定変数 －－－－－－－－－－－－－－－×
        Public Const MANDT As String = "900"                                ' 環境区分

        '20200331 ADD
        Public Const MSG_SAVE_SUCCESS As String = "保存しました。"
        Public Const MSG_SAVE_FAILURE As String = "保存できませんでした。"
        Public Const MSG_NO_FOUND_ESTIMATE As String = "該当データが見つかりませんでした。"

#End Region

#Region "半角チェック"
        Public Shared Function IsHankaku(ByVal strText As String) As Boolean
            If String.IsNullOrEmpty(strText) Then
                Return False
            End If

            Return Regex.IsMatch(strText, "^[a-zA-Z0-9!-/:-@¥[-`{-~]+$")
        End Function
#End Region

#Region "半角取得"
        Public Shared Function getHankaku(ByVal strText As String) As String
            Dim val1 = Nothing

            If String.IsNullOrEmpty(strText) Then
                Return Nothing
            Else
                val1 = strText.Trim()
            End If
            If Regex.IsMatch(val1, "^[a-zA-Z0-9!-/:-@¥[-`{-~]+$") Then
                Return val1
            Else
                Return Nothing
            End If
        End Function
#End Region

        '20200212 ADD
#Region "　LenB メソッド　"
        ''' -----------------------------------------------------------------------------------------
        ''' <summary>
        '''     半角 1 バイト、全角 2 バイトとして、指定された文字列のバイト数を返します。</summary>
        ''' <param name="stTarget">
        '''     バイト数取得の対象となる文字列。</param>
        ''' <returns>
        '''     半角 1 バイト、全角 2 バイトでカウントされたバイト数。</returns>
        ''' -----------------------------------------------------------------------------------------
        Public Shared Function LenB(ByVal stTarget As String) As Integer
            Return System.Text.Encoding.GetEncoding("Shift_JIS").GetByteCount(stTarget)
        End Function
#End Region

#Region "日付 IsRange"
        Public Shared Function IsRange(ByVal fromValue As DateTime, ByVal toValue As DateTime) As Boolean
            If fromValue.CompareTo(toValue) <= 0 Then
                Return True
            Else
                Return False
            End If
        End Function
#End Region
        
#Region "日付 IsValidatedDate"
        Public Shared Function IsValidatedDate(ByVal val1 As String, ByVal format As String, ByRef result As Date) As Boolean

            '文字列をカレンダーに存在する日付であるかチェック
            If Not DateTime.TryParse(val1, result) Then
                result = Nothing    '20200228 ADD
                Return False
            End If

            '文字列を指定形式で、DataTime形式で格納する
            If Not DateTime.TryParseExact(val1, format, Nothing, DateTimeStyles.AssumeLocal, result) Then
                result = Nothing   '20200228 ADD
                Return False
            End If

            Return True
        End Function
#End Region

#Region "GetCashClearstr"
        Public Shared Function GetCashClearstr() As String

            ' 現在の日付を取得する
            Return DateTime.Now.ToString("yyyyMMddHHmmss")

        End Function
#End Region

    End Class
End Namespace