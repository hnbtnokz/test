'********************************************************
' SQL共通処理
'********************************************************
Imports System.Data.Common
Imports estimate_system.Common
Imports System.Data.SqlClient

Public Class SQL_Common

    'Public Shared Conn As SqlConnection
    'Public Shared Tran As SqlTransaction
    Public Shared Conn As DbConnection
    Public Shared Fact As DbProviderFactory
    Public Shared Tran As DbTransaction

    ''' <summary>
    ''' コネクションオープン
    ''' </summary>
    Public Shared Sub DbConnect(dbtype As String)
        Dim connClsStr As String = String.Empty
        'Dim connStr As String = ConfigurationManager.ConnectionStrings(dbtype).ConnectionString

        '↓テスト用
        Dim connStr As String = String.Empty

        If dbtype = Util.DB_SERVER Then
            connStr = ConfigurationManager.AppSettings("webdb_ConnectString")
        ElseIf dbtype = Util.DW_SERVER Then
            connStr = ConfigurationManager.AppSettings("dw_ConnectString")
        ElseIf dbtype = Util.KG_SERVER Then
            connStr = ConfigurationManager.AppSettings("kg_ConnectString")
        Else
            connStr = ConfigurationManager.ConnectionStrings(dbtype).ConnectionString
        End If
        '↑テスト用

        Select Case dbtype
            Case Util.DB_SERVER, Util.DW_SERVER, Util.KG_SERVER
                connClsStr = "System.Data.SqlClient"
                Exit Select
            Case Util.WB_SERVER
                'connClsStr = "Npgsql"
                connClsStr = "System.Data.SqlClient"
                Exit Select
        End Select

        Fact = DbProviderFactories.GetFactory(connClsStr)
        Conn = Fact.CreateConnection()
        Conn.ConnectionString = connStr
        Conn.Open()

    End Sub

    ''' <summary>
    ''' コネクションクローズ
    ''' </summary>
    Public Shared Sub DbDisConnect()
        If Conn.State = ConnectionState.Open Then
            Conn.Close()
        End If
        If Not IsNothing(Conn) Then
            Conn = Nothing
        End If
    End Sub

    ''' <summary>
    ''' SEL実行（SELECT）
    ''' </summary>
    ''' <param name="sql"></param>
    ''' <returns></returns>
    Public Shared Function SelectSql(ByVal sql As String, dbtype As String) As DataTable

        Dim result As New DataTable

        If IsNothing(Conn) Then
            DbConnect(dbtype)
        End If

        Using dbCmd = Conn.CreateCommand
            dbCmd.CommandType = CommandType.Text
            dbCmd.CommandText = sql

            Using dbDtAdp As DbDataAdapter = Fact.CreateDataAdapter()
                dbDtAdp.SelectCommand = dbCmd
                dbDtAdp.Fill(result)
            End Using
        End Using
        DbDisConnect()

        Return result

    End Function

    ''' <summary>
    ''' SEL実行（INSERT, UPDATE, DELETE）
    ''' </summary>
    ''' <param name="sql"></param>
    ''' <returns></returns>
    Public Shared Function ExecSql(ByVal sql As String, dbtype As String) As Integer

        Dim result As Integer = 0

        If IsNothing(Conn) Then
            DbConnect(dbtype)
        End If

        Using dbCmd = Conn.CreateCommand
            dbCmd.CommandText = sql
            result = dbCmd.ExecuteNonQuery
        End Using
        DbDisConnect()

        Return result

    End Function
End Class
