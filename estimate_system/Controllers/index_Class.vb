'検索条件プロパティ
Public Class Requirement
    Private _CheckNum As String
    Private _StartDate As String
    Private _EndDate As String
    Private _CustomerCode As String
    Private _CustomerSort As Boolean
    Private _SearchName As String
    Private _SearchTitle As String
    Private _SearchMemo As String
    Private _ProductCode As String
    Private _ContinuationFlag As String
    Private _ProjectFlag As String
    Private _GroupNo As String
    Private _PageMode As String
    Private _AreaCode As String
    Private _SalesPerson As String
    Private _DevSupPerson As String
    Private _CreatePerson As String
    Private _KOSTL As String
    Private _ConclusionStatus As String
    Private _Quantity As String
    Private _QuantityMark As String
    Private _EndUserPref As String
    Private _EndUserName As String
    Private _GroupName As String
    Private _RicohNum As String
    Private _RCode As String
    Private _FixCheck As Boolean

    Public Property CheckNum() As String
        Get
            Return _CheckNum
        End Get
        Set(ByVal value As String)
            _CheckNum = value
        End Set
    End Property

    Public Property StartDate() As String
        Get
            Return _StartDate
        End Get
        Set(ByVal value As String)
            _StartDate = value
        End Set
    End Property

    Public Property EndDate() As String
        Get
            Return _EndDate
        End Get
        Set(ByVal value As String)
            _EndDate = value
        End Set
    End Property

    Public Property CustomerCode() As String
        Get
            Return _CustomerCode
        End Get
        Set(ByVal value As String)
            _CustomerCode = value
        End Set
    End Property

    Public Property CustomerSort() As Boolean
        Get
            Return _CustomerSort
        End Get
        Set(ByVal value As Boolean)
            _CustomerSort = value
        End Set
    End Property

    Public Property SearchName() As String
        Get
            Return _SearchName
        End Get
        Set(ByVal value As String)
            _SearchName = value
        End Set
    End Property

    Public Property SearchTitle() As String
        Get
            Return _SearchTitle
        End Get
        Set(ByVal value As String)
            _SearchTitle = value
        End Set
    End Property

    Public Property SearchMemo() As String
        Get
            Return _SearchMemo
        End Get
        Set(ByVal value As String)
            _SearchMemo = value
        End Set
    End Property

    Public Property ProductCode() As String
        Get
            Return _ProductCode
        End Get
        Set(ByVal value As String)
            _ProductCode = value
        End Set
    End Property

    Public Property ContinuationFlag() As String
        Get
            Return _ContinuationFlag
        End Get
        Set(ByVal value As String)
            _ContinuationFlag = value
        End Set
    End Property

    Public Property ProjectFlag() As String
        Get
            Return _ProjectFlag
        End Get
        Set(ByVal value As String)
            _ProjectFlag = value
        End Set
    End Property

    Public Property GroupNo() As String
        Get
            Return _GroupNo
        End Get
        Set(ByVal value As String)
            _GroupNo = value
        End Set
    End Property

    Public Property PageMode() As String
        Get
            Return _PageMode
        End Get
        Set(ByVal value As String)
            _PageMode = value
        End Set
    End Property

    Public Property AreaCode() As String
        Get
            Return _AreaCode
        End Get
        Set(ByVal value As String)
            _AreaCode = value
        End Set
    End Property

    Public Property SalesPerson() As String
        Get
            Return _SalesPerson
        End Get
        Set(ByVal value As String)
            _SalesPerson = value
        End Set
    End Property

    Public Property DevSupPerson() As String
        Get
            Return _DevSupPerson
        End Get
        Set(ByVal value As String)
            _DevSupPerson = value
        End Set
    End Property

    Public Property CreatePerson() As String
        Get
            Return _CreatePerson
        End Get
        Set(ByVal value As String)
            _CreatePerson = value
        End Set
    End Property

    Public Property KOSTL() As String
        Get
            Return _KOSTL
        End Get
        Set(ByVal value As String)
            _KOSTL = value
        End Set
    End Property

    Public Property ConclusionStatus() As String
        Get
            Return _ConclusionStatus
        End Get
        Set(ByVal value As String)
            _ConclusionStatus = value
        End Set
    End Property

    Public Property Quantity() As String
        Get
            Return _Quantity
        End Get
        Set(ByVal value As String)
            _Quantity = value
        End Set
    End Property

    Public Property QuantityMark() As String
        Get
            Return _QuantityMark
        End Get
        Set(ByVal value As String)
            _QuantityMark = value
        End Set
    End Property

    Public Property EndUserPref() As String
        Get
            Return _EndUserPref
        End Get
        Set(ByVal value As String)
            _EndUserPref = value
        End Set
    End Property

    Public Property EndUserName() As String
        Get
            Return _EndUserName
        End Get
        Set(ByVal value As String)
            _EndUserName = value
        End Set
    End Property

    Public Property GroupName() As String
        Get
            Return _GroupName
        End Get
        Set(ByVal value As String)
            _GroupName = value
        End Set
    End Property

    Public Property RicohNum() As String
        Get
            Return _RicohNum
        End Get
        Set(ByVal value As String)
            _RicohNum = value
        End Set
    End Property

    Public Property RCode() As String
        Get
            Return _RCode
        End Get
        Set(ByVal value As String)
            _RCode = value
        End Set
    End Property

    Public Property FixCheck() As Boolean
        Get
            Return _FixCheck
        End Get
        Set(ByVal value As Boolean)
            _FixCheck = value
        End Set
    End Property
End Class

Public Class index_Class
    '検索ボタン処理
    Public Function SearchButton_Click_Class(ByVal Require As Requirement) As DataTable
        Dim index_Query As New index_Query
        Dim uKNVP_Table As DataTable = Nothing
        Dim mMember_Table As DataTable = Nothing
        Dim tEstimateParent_Table As DataTable = Nothing
        Dim SearchResult_Table As New DataTable

        If Require.SalesPerson <> "" Then
            uKNVP_Table = index_Query.get_uKNVP(Require)
        End If

        If Require.KOSTL <> "" Then
            mMember_Table = index_Query.get_mMember(Require)
        End If

        tEstimateParent_Table = index_Query.get_tEstimateParent(Require, uKNVP_Table, mMember_Table)

        Return tEstimateParent_Table
    End Function

    '↓20200219
    '削除ボタン押下
    Public Sub DeleteButton_Click_Class(ByVal CheckNum As String)
        Dim index_Query As New index_Query

        index_Query.update_tEstimateParent_DeleteFlag(CheckNum)
    End Sub

    'サンワChボタン押下
    Public Sub SanwaChButton_Click_Class(ByVal CheckNum As String, ByVal DispMode As String)
        Dim index_Query As New index_Query

        index_Query.update_tEstimateParent_SanwaChDispFlag(CheckNum, DispMode)
    End Sub

    '成約状況更新処理
    Public Sub ConclusionStatusChange(ByVal CheckNum As String, ByVal ConclusionStatus As String)
        Dim index_Query As New index_Query

        If CheckNum <> "" AndAlso ConclusionStatus <> "" Then
            If CInt(ConclusionStatus) < 4 Then
                index_Query.update_tEstimateParent_ConclusionStatus(CheckNum, ConclusionStatus)

                If ConclusionStatus <> "1" Then
                    index_Query.update_tEstimateDetail_ConclusionStatus(CheckNum, ConclusionStatus)
                End If
            End If
        End If
    End Sub
    '↑20200219

    '↓20200311
    'ダウンロードCSV作成処理
    Public Function Create_CSV_index(ByVal Require As Requirement, ByVal strHMode As String) As String
        Dim CSV_Common As New CSV_Common
        Dim index_Query As New index_Query
        Dim CsvText As String = String.Empty
        Dim uKNVP_Table As DataTable = Nothing
        Dim mMember_Table As DataTable = Nothing
        Dim tEstimateParent_Table As DataTable = Nothing

        If Require.SalesPerson <> "" Then
            uKNVP_Table = index_Query.get_uKNVP(Require)
        End If

        If Require.KOSTL <> "" Then
            mMember_Table = index_Query.get_mMember(Require)
        End If

        tEstimateParent_Table = index_Query.get_tEstimateParent_csvDownload(Require, uKNVP_Table, mMember_Table)

        If tEstimateParent_Table.Rows.Count > 0 Then
            CsvText = CSV_Common.Create_CSV_List(tEstimateParent_Table, CsvText)
        End If

        Return CsvText
    End Function
    '↑20200311
End Class
