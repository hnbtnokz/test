'********************************************************
' 検索一覧一覧クエリ処理
'********************************************************
Imports estimate_system.Common

Public Class index_Query
    Public Function get_uCSKT(ByVal TableName As String) As DataTable
        Try
            Dim sql As New StringBuilder
            Dim Result_DataTable As DataTable

            With sql
                .Append("SELECT CSKT_KOSTL, CSKT_KTEXT ")
                .AppendFormat("FROM {0} ", TableName)
                .AppendFormat("WHERE CSKT_MANDT = '{0}' ", Util.MANDT)
                .Append("AND CSKT_KTEXT like '%班' ")
                .Append("AND CSKT_KTEXT not like '%旧%' ")
                .Append("ORDER BY CSKT_KOSTL")
            End With

            Result_DataTable = SQL_Common.SelectSql(sql.ToString, Util.DW_SERVER)

            Return Result_DataTable
        Catch ex As Exception
            MsgBox("班リストの取得に失敗しました。(" + TableName + ")" + Environment.NewLine + ex.Message)

            Return Nothing
        End Try
    End Function

    Public Function get_uKNVP(ByVal Require As Requirement) As DataTable
        Try
            Dim sql As New StringBuilder
            Dim Result_DataTable As DataTable

            With sql
                .Append("SELECT KNVP_KUNNR ")
                .Append("FROM uKNVP ")
                .Append("WHERE KNVP_MANDT = '900' ")
                .Append("AND KNVP_PARVW In ('AC','AE') ")
                .AppendFormat("AND (ZKNVP_ID like '%{0}%' ", Require.SalesPerson)
                .AppendFormat("OR ZKNVP_NAME like '%{0}%') ", Require.SalesPerson)
                .Append("GROUP BY KNVP_KUNNR")
            End With

            Result_DataTable = SQL_Common.SelectSql(sql.ToString, Util.DW_SERVER)

            Return Result_DataTable
        Catch ex As Exception
            MsgBox("検索結果の取得に失敗しました。(uKNVP)" + Environment.NewLine + ex.Message)

            Return Nothing
        End Try
    End Function

    Public Function get_mMember(ByVal Require As Requirement) As DataTable
        Try
            Dim sql As New StringBuilder
            Dim Result_DataTable As DataTable

            With sql
                .Append("SELECT MemberCode ")
                .Append("FROM mMember ")
                .AppendFormat("WHERE KOSTL = '{0}' ", Require.KOSTL)
                .Append("AND DeleteFlag = 0")
            End With

            Result_DataTable = SQL_Common.SelectSql(sql.ToString, Util.DB_SERVER)

            Return Result_DataTable
        Catch ex As Exception
            MsgBox("検索結果の取得に失敗しました。(mMember)" + Environment.NewLine + ex.Message)

            Return Nothing
        End Try
    End Function

    Public Function get_tEstimateParent(ByVal Require As Requirement, ByVal uKNVP_Table As DataTable, ByVal mMember_Table As DataTable) As DataTable
        Try
            Dim SQL_Command As String = String.Empty
            Dim Result_DataTable As DataTable
            Dim SelectCommand As String = String.Empty
            Dim FromCommand As String = String.Empty
            Dim WhereCommand As String = String.Empty
            Dim SortCommand As String = String.Empty
            Dim SalesQuery As String = String.Empty
            Dim GroupQuery As String = String.Empty
            Dim ProductCodeQuery As String = String.Empty
            Dim ContinuationQuery As String = String.Empty

            '条件文生成
            If uKNVP_Table IsNot Nothing Then
                If uKNVP_Table.Rows.Count > 0 Then
                    For Each row In uKNVP_Table.Rows
                        If SalesQuery <> "" Then
                            SalesQuery += ", "
                        End If

                        SalesQuery += "'" + row("KNVP_KUNNR") + "' "
                    Next

                    SalesQuery = "AND CustomerCode In (" + SalesQuery + ") "
                Else
                    ' 対象なしの場合は現在データであらう
                    '20200311 修正
                    SalesQuery = "AND (TEP.SalesPersonName LIKE '%" + Require.SalesPerson + "%' "
                    SalesQuery += "OR TEP.SalesPersonCode LIKE '%" + Require.SalesPerson + "%' "
                    SalesQuery += "OR TEP.AssistantName LIKE '%" + Require.SalesPerson + "%' "
                    SalesQuery += "OR TEP.AssistantCode LIKE '%" + Require.SalesPerson + "%') "
                End If
            End If

            If mMember_Table IsNot Nothing Then
                If mMember_Table.Rows.Count > 0 Then
                    For Each row In mMember_Table.Rows
                        If GroupQuery <> "" Then
                            GroupQuery += ", "
                        End If

                        GroupQuery += "'00" + row("MemberCode") + "' "
                    Next
                End If
            End If

            If Require.PageMode = "1" Then
                '明細表示
                'SELECT句生成
                SelectCommand = "SELECT (RTrim(TEP.CheckNum) + '-' + LTrim(Cast(TED.Columns AS varchar))) AS CheckNum, TEP.RicohNum, TEP.CustomerCode, TEP.CustomerName, "
                SelectCommand += "TEP.CustomerPersonName, "
                SelectCommand += "TEP.Title, TEP.SalesPersonName, TEP.AssistantName, "
                SelectCommand += "TEP.CreatePersonName, TEP.UpdateTime, TEP.Division, "
                SelectCommand += "TEP.SalesPersonCode, TEP.AssistantCode, TEP.CreatePersonCode, "
                SelectCommand += "TEP.Contents, TEP.FixFlag, TEP.SanwaChDispFlag, TEP.ParentCheckNum, TEP.ConclusionStatus, TEP.EndUserName, "
                SelectCommand += "TED.ProductCode, TED.Quantity, TED.UnitPrice AS SubTotalPrice, TED.RCode, "
                SelectCommand += "TEP.ContinuationFlag, TEP.ContinuationCycle, TEG.GroupNo, TEG.GroupName, TEP.ProjectMailSubmitFlag, TEP.ConclusionMailSubmitFlag, TEP.ProjectFlag "

                '条件文生成
                ProductCodeQuery = "AND TED.ProductCode IS Not Null "
                ProductCodeQuery += "AND TED.ProductCode <> '' "

                '得意先CDでソートチェックの場合、CustomerCode降順ソート追加
                If Require.CustomerSort = False Then
                    SortCommand = "ORDER BY TEP.UpdateTime DESC, TED.Columns"
                Else
                    SortCommand = "ORDER BY TEP.CustomerCode, TEP.UpdateTime DESC, TED.Columns"
                End If
            Else
                '明細非表示
                'SELECT句生成
                SelectCommand = "SELECT TEP.CheckNum, Max(TEP.RicohNum) AS RicohNum, Max(TEP.CustomerCode) AS CustomerCode, Max(TEP.CustomerName) AS CustomerName, "
                SelectCommand += "Max(TEP.CustomerPersonName) AS CustomerPersonName, "
                SelectCommand += "Max(TEP.Title) AS Title, Max(TEP.SalesPersonName) AS SalesPersonName, Max(TEP.AssistantName) AS AssistantName, "
                SelectCommand += "Max(TEP.CreatePersonName) AS CreatePersonName, Max(TEP.UpdateTime) AS UpdateTime, Max(TEP.Division) AS Division, "
                SelectCommand += "Max(TEP.SalesPersonCode) AS SalesPersonCode, Max(TEP.AssistantCode) AS AssistantCode, Max(TEP.CreatePersonCode) AS CreatePersonCode, "
                SelectCommand += "Max(TEP.Contents) AS Contents, Max(TEP.FixFlag) AS FixFlag, Max(TEP.SanwaChDispFlag) AS SanwaChDispFlag, Max(TEP.ParentCheckNum) AS ParentCheckNum, "
                SelectCommand += "Max(TEP.ConclusionStatus) AS ConclusionStatus, Max(TEP.EndUserName) AS EndUserName, "
                SelectCommand += "Min(TED.ProductCode) AS ProductCode, Sum(Quantity) AS Quantity, Sum(SubTotalPrice) AS SubTotalPrice, Max(TED.RCode) AS RCode, "
                SelectCommand += "Max(TEP.ContinuationFlag) AS ContinuationFlag, Max(TEP.ContinuationCycle) AS ContinuationCycle, Max(TEG.GroupNo) AS GroupNo, Max(TEG.GroupName) AS GroupName, "
                SelectCommand += "Max(TEP.ProjectMailSubmitFlag) AS ProjectMailSubmitFlag, Max(TEP.ConclusionMailSubmitFlag) AS ConclusionMailSubmitFlag, Max(TEP.ProjectFlag) AS ProjectFlag "

                '継続案件が空白以外の場合、ContinuationFlag条件クエリ生成
                If Require.ContinuationFlag <> "" Then
                    If Require.ContinuationFlag <> "未指定" Then
                        If Require.ContinuationFlag = "継続案件すべて" Then
                            ContinuationQuery = "AND TEP.ContinuationFlag Is Not Null AND TEP.ContinuationFlag <> '' "
                        ElseIf Require.ContinuationFlag = "継続案件以外" Then
                            ContinuationQuery = "AND (TEP.ContinuationFlag Is Null OR TEP.ContinuationFlag = '') "
                        Else
                            ContinuationQuery = "AND TEP.ContinuationFlag = '" & Require.ContinuationFlag & "' "
                        End If
                    End If
                End If

                '得意先CDでソートチェックの場合、CustomerCode降順ソート追加
                If Require.CustomerSort = False Then
                    SortCommand = "GROUP BY TEP.CheckNum " + "ORDER BY Max(TEP.UpdateTime) DESC"
                Else
                    SortCommand = "GROUP BY TEP.CheckNum " + "ORDER BY Max(TEP.CustomerCode), Max(TEP.UpdateTime) DESC"
                End If
            End If

            'FROM句生成
            FromCommand = "FROM tEstimateParent TEP "
            FromCommand += "INNER JOIN tEstimateDetail TED "
            FromCommand += "ON TEP.CheckNum = TED.CheckNum "
            FromCommand += "LEFT JOIN tEstimateGroupBody TGB "
            FromCommand += "ON TEP.CheckNum = TGB.CheckNum "
            FromCommand += "LEFT JOIN tEstimateGroup TEG "
            FromCommand += "ON TEG.GroupNo = TGB.GroupNo "

            'WHERE句生成
            WhereCommand = "WHERE TEP.DeleteFlag = 0 "
            WhereCommand += ProductCodeQuery

            '見積書番号と案件番号(RICOH)が空白の場合、CreateTime条件追加
            If Require.CheckNum = "" AndAlso Require.RicohNum = "" Then
                '20200219 期間入力チェック追加
                If Require.StartDate IsNot Nothing AndAlso Require.EndDate IsNot Nothing Then
                    WhereCommand += "AND TEP.CreateTime >= '" + Replace(Mid(Require.StartDate, 3, 8), " / ", "") + "' "
                    WhereCommand += "AND TEP.CreateTime <= '" + Replace(Mid(Require.EndDate, 3, 8), " / ", "") + "' "
                End If
            End If

            '見積書番号が空白以外の場合、CheckNum条件追加
            If Require.CheckNum <> "" Then
                WhereCommand += "AND TEP.CheckNum like '" + Require.CheckNum + "%' "
            End If

            '案件番号(RICOH)が空白以外の場合、RicohNum条件追加
            If Require.RicohNum <> "" Then
                WhereCommand += "AND TEP.RicohNum like '%" + Require.RicohNum + "%' "
            End If

            'サンワ担当者名・コードが空白以外の場合、SalesPersonName,SalesPerson条件追加(SalesQuery)
            If Require.SalesPerson <> "" Then
                WhereCommand += SalesQuery
            End If

            '開発・仕入が空白以外の場合、DevPersonCode,DevSupPerson条件追加
            If Require.DevSupPerson <> "" Then
                WhereCommand += "AND (TED.DevPersonCode LIKE '%" + Require.DevSupPerson + "%' "
                WhereCommand += "OR TED.DevPersonName LIKE '%" + Require.DevSupPerson + "%' "
                WhereCommand += "OR TED.SupPersonCode LIKE '%" + Require.DevSupPerson + "%' "
                WhereCommand += "OR TED.SupPersonName LIKE '%" + Require.DevSupPerson + "%') "
            End If

            '作成者名・コードが空白以外の場合、CreatePersonName,CreatePerson条件追加
            If Require.CreatePerson <> "" Then
                WhereCommand += "AND (TEP.CreatePersonName LIKE '%" + Require.CreatePerson + "%' "
                WhereCommand += "OR TEP.CreatePersonCode LIKE '%" + Require.CreatePerson + "%') "
            End If

            '販売店CDが空白以外の場合、CustomerCode条件追加
            If Require.CustomerCode <> "" Then
                If IsNumeric(Require.CustomerCode) Then
                    WhereCommand += "AND TEP.CustomerCode = '" + Right("0000000000" & Require.CustomerCode, 10) + "' "
                Else
                    WhereCommand += "AND TEP.CustomerCode = '" & Require.CustomerCode & "' "
                End If
            End If

            '販売店・部署・担当者名が空白以外の場合、CustomerName,SearchName条件追加
            If Require.SearchName <> "" Then
                WhereCommand += "AND (TEP.CustomerName LIKE '%" + Require.SearchName + "%' "
                WhereCommand += "OR TEP.CustomerDivision LIKE '%" + Require.SearchName + "%' "
                WhereCommand += "OR TEP.CustomerPersonName LIKE '%" + Require.SearchName + "%') "
            End If

            '品番が空白以外の場合、ProductCode条件追加
            If Require.ProductCode <> "" Then
                WhereCommand += "AND TED.ProductCode LIKE '%" + Require.ProductCode + "%' "
            End If

            '品種コードが空白以外の場合、RCode条件追加
            If Require.RCode <> "" Then
                WhereCommand += "AND TED.RCode LIKE '%" + Require.RCode + "%' "
            End If

            '成約状況が空白以外の場合、ConclusionStatus条件追加
            If Require.ConclusionStatus <> "すべて" Then
                If Require.ConclusionStatus = "成約" Then
                    WhereCommand += "AND TEP.ConclusionStatus IN ('成約','一部成約') "
                ElseIf Require.ConclusionStatus <> "" Then
                    '20200220 未設定の場合は処理しない
                    WhereCommand += "AND TEP.ConclusionStatus = '" + Require.ConclusionStatus + "' "
                End If
            End If

            '都道府県が空白以外の場合、EndUserPref条件追加
            If Require.EndUserPref <> "" Then
                If Require.EndUserPref <> "未指定" Then
                    WhereCommand += "AND TEP.EndUserPref = '" + Require.EndUserPref + "' "
                End If
            End If

            '数量が空白以外の場合、Quantity条件追加
            If Require.Quantity <> "" Then
                If Require.QuantityMark = "以上" Then
                    WhereCommand += "AND TED.Quantity >= " + Require.Quantity + " "
                ElseIf Require.QuantityMark = "以下" Then
                    WhereCommand += "AND TED.Quantity <= " + Require.Quantity + " "
                Else
                    WhereCommand += "AND TED.Quantity = " + Require.Quantity + " "
                End If
            End If

            '継続案件が空白以外の場合、ContinuationFlag条件追加
            If Require.ContinuationFlag <> "" Then
                If Require.ContinuationFlag <> "未指定" Then
                    WhereCommand += ContinuationQuery
                End If
            End If

            'グループ・グループ名が空白以外の場合、GroupNo,GroupName条件追加
            If Require.GroupNo <> "" Then
                WhereCommand += "AND TEG.GroupNo = '" + Require.GroupNo + "' "
            End If

            If Require.GroupName <> "" Then
                WhereCommand += "AND TEG.GroupName like '%" + Require.GroupName + "%' "
            End If

            '班が空白以外の場合、SalesPersonCode条件追加
            If Require.KOSTL <> "" Then
                WhereCommand += "AND TEP.SalesPersonCode in (" + GroupQuery + ") "
            End If

            '仮登録チェックの場合、FixFlag条件追加
            If Require.FixCheck = True Then
                WhereCommand += "AND TEP.FixFlag = '0' "
            End If

            '案件管理、ProjectFlag条件追加
            If Require.ProjectFlag = "しない" Then
                WhereCommand += "AND (TEP.ProjectFlag = 0 OR TEP.ProjectFlag Is Null) "
            ElseIf Require.ProjectFlag = "する" Then
                WhereCommand += "AND TEP.ProjectFlag = 1 "
                WhereCommand += "AND TEP.ProjectFlag Is Not Null "
            End If

            '最終ユーザ名が空白以外の場合、EndUserName条件追加
            If Require.EndUserName <> "" Then
                WhereCommand += "AND TEP.EndUserName like '%" + Require.EndUserName + "%' "
            End If

            '見積件名が空白以外の場合、Title条件追加
            If Require.SearchTitle <> "" Then
                WhereCommand += "AND TEP.Title like '%" + Require.SearchTitle + "%' "
            End If

            '所属が2以外の場合、Division条件追加
            If Require.AreaCode <> "2" Then
                If Require.AreaCode = "0" Then
                    WhereCommand += "AND TEP.Division = '0' "
                Else
                    WhereCommand += "AND TEP.Division = '5' "
                End If
            End If

            'メモ書きが空白以外の場合、Contents条件追加
            If Require.SearchMemo <> "" Then
                WhereCommand += "AND TEP.Contents like '%" + Require.SearchMemo + "%' "
            End If

            '20200219 見積書番号が入力された場合、他の条件は無視
            '見積書番号が空白以外の場合、CheckNum条件追加
            If Require.CheckNum <> "" Then
                WhereCommand = "WHERE TEP.DeleteFlag = 0 "
                WhereCommand += "AND TEP.CheckNum like '" + Require.CheckNum + "%' "
            End If

            SQL_Command = SelectCommand + FromCommand + WhereCommand + SortCommand

            Result_DataTable = SQL_Common.SelectSql(SQL_Command, Util.DB_SERVER)

            Return Result_DataTable
        Catch ex As Exception
            MsgBox("検索結果の取得に失敗しました。(tEstimentParent)" + Environment.NewLine + ex.Message)

            Return Nothing
        End Try
    End Function

    '↓20200219
    '削除ボタン押下
    Public Sub update_tEstimateParent_DeleteFlag(ByVal CheckNum As String)
        Try
            Dim sql As New StringBuilder
            Dim result As Integer = 0

            With sql
                .Append("UPDATE tEstimateParent ")
                .Append("SET DeleteFlag = 1 ")
                .AppendFormat("WHERE CheckNum = '{0}'", Trim(CheckNum))
            End With

            result = SQL_Common.ExecSql(sql.ToString, Util.DB_SERVER)
        Catch ex As Exception
            MsgBox("削除に失敗しました。(tEstimateParent)" + Environment.NewLine + ex.Message)
        End Try
    End Sub

    'サンワChボタン押下
    Public Sub update_tEstimateParent_SanwaChDispFlag(ByVal CheckNum As String, ByVal DispMode As String)
        Try
            Dim sql As New StringBuilder
            Dim result As Integer = 0

            With sql
                .Append("UPDATE tEstimateParent ")

                If DispMode = "on" Then
                    .Append("SET SanwaChDispFlag = 1 ")
                Else
                    .Append("SET SanwaChDispFlag = 0 ")
                End If

                .AppendFormat("WHERE CheckNum = '{0}'", Trim(CheckNum))
            End With

            result = SQL_Common.ExecSql(sql.ToString, Util.DB_SERVER)
        Catch ex As Exception
            MsgBox("サンワchの切り替えに失敗しました。(tEstimateParent)" + Environment.NewLine + ex.Message)
        End Try
    End Sub

    '成約状況更新処理(tEstimateParent)
    Public Sub update_tEstimateParent_ConclusionStatus(ByVal CheckNum As String, ByVal ConclusionStatus As String)
        Try
            Dim sql As New StringBuilder
            Dim result As Integer = 0

            With sql
                .Append("UPDATE tEstimateParent ")

                If ConclusionStatus = "0" Then
                    .Append("SET ConclusionStatus = '成約' ")
                ElseIf ConclusionStatus = "1" Then
                    .Append("SET ConclusionStatus = '一部成約' ")
                ElseIf ConclusionStatus = "2" Then
                    .Append("SET ConclusionStatus = '不成約' ")
                Else
                    .Append("SET ConclusionStatus = '継続中' ")
                End If

                .AppendFormat("WHERE CheckNum = '{0}'", Trim(CheckNum))
            End With

            result = SQL_Common.ExecSql(sql.ToString, Util.DB_SERVER)
        Catch ex As Exception
            MsgBox("成約状況の更新に失敗しました。(tEstimateParent)" + Environment.NewLine + ex.Message)
        End Try
    End Sub

    '成約状況更新処理(tEstimateDetail)
    Public Sub update_tEstimateDetail_ConclusionStatus(ByVal CheckNum As String, ByVal ConclusionStatus As String)
        Try
            Dim sql As New StringBuilder
            Dim result As Integer = 0

            With sql
                .Append("UPDATE tEstimateDetail ")

                If ConclusionStatus = "0" Then
                    .Append("SET ConclusionStatusDetail = '成約' ")
                ElseIf ConclusionStatus = "2" Then
                    .Append("SET ConclusionStatusDetail = '不成約' ")
                ElseIf ConclusionStatus = "3" Then
                    .Append("SET ConclusionStatusDetail = '継続中' ")
                End If

                .AppendFormat("WHERE CheckNum = '{0}'", Trim(CheckNum))
            End With

            result = SQL_Common.ExecSql(sql.ToString, Util.DB_SERVER)
        Catch ex As Exception
            MsgBox("成約状況の更新に失敗しました。(tEstimateDetail)" + Environment.NewLine + ex.Message)
        End Try
    End Sub
    '↑20200219

    '↓20200311
    Public Function get_tEstimateParent_csvDownload(ByVal Require As Requirement, ByVal uKNVP_Table As DataTable, ByVal mMember_Table As DataTable) As DataTable
        Try
            Dim SQL_Command As String = String.Empty
            Dim Result_DataTable As DataTable
            Dim SelectCommand As String = String.Empty
            Dim FromCommand As String = String.Empty
            Dim WhereCommand As String = String.Empty
            Dim SortCommand As String = String.Empty
            Dim SalesQuery As String = String.Empty
            Dim GroupQuery As String = String.Empty

            '条件文生成
            If uKNVP_Table IsNot Nothing Then
                If uKNVP_Table.Rows.Count > 0 Then
                    For Each row In uKNVP_Table.Rows
                        If SalesQuery <> "" Then
                            SalesQuery += ", "
                        End If

                        SalesQuery += "'" + row("KNVP_KUNNR") + "' "
                    Next

                    SalesQuery = "AND CustomerCode In (" + SalesQuery + ") "
                Else
                    ' 対象なしの場合は現在データであらう
                    SalesQuery = "AND (TEP.SalesPersonName LIKE '%" + Require.SalesPerson + "%' "
                    SalesQuery += "OR TEP.SalesPersonCode LIKE '%" + Require.SalesPerson + "%' "
                    SalesQuery += "OR TEP.AssistantName LIKE '%" + Require.SalesPerson + "%' "
                    SalesQuery += "OR TEP.AssistantCode LIKE '%" + Require.SalesPerson + "%') "
                End If
            End If

            If mMember_Table IsNot Nothing Then
                If mMember_Table.Rows.Count > 0 Then
                    For Each row In mMember_Table.Rows
                        If GroupQuery <> "" Then
                            GroupQuery += ", "
                        End If

                        GroupQuery += "'00" + row("MemberCode") + "' "
                    Next
                End If
            End If

            'SELECT句生成
            SelectCommand = "SELECT TEP.CheckNum, TEP.RicohNum, TED.Columns, TEP.CustomerCode, "
            SelectCommand += "TEP.CustomerName, TEP.CustomerDivision, TEP.CustomerPersonName, "
            SelectCommand += "TEP.ConclusionDate, TEP.Title, TEP.SalesPersonName, TEP.AssistantName, "
            SelectCommand += "TEP.CreatePersonName, TEP.UpdateTime, TEP.Division, TEP.SalesPersonCode, "
            SelectCommand += "TEP.AssistantCode, TEP.CreatePersonCode, TEP.Contents, TEP.FixFlag, "
            SelectCommand += "TEP.SanwaChDispFlag, TEP.ParentCheckNum, TEP.ConclusionStatus, TEP.EndUserName, "
            SelectCommand += "TEP.ProfessionClass1, TEP.ProfessionClass2, TEP.EndUserPref, TEP.EndUserAddress, "
            SelectCommand += "TEP.DeliveryLimitDate, TED.ProductCode, TED.RCode, TED.ProductName, "
            SelectCommand += "TED.Quantity, TED.UnitPrice, TED.SubTotalPrice, TEP.ContinuationFlag, "
            SelectCommand += "TEP.ContinuationCycle, TEG.GroupNo, TEG.GroupName "

            'FROM句生成
            FromCommand = "FROM tEstimateParent TEP "
            FromCommand += "INNER JOIN tEstimateDetail TED "
            FromCommand += "ON TEP.CheckNum = TED.CheckNum "
            FromCommand += "LEFT JOIN tEstimateGroupBody TGB "
            FromCommand += "ON TEP.CheckNum = TGB.CheckNum "
            FromCommand += "LEFT JOIN tEstimateGroup TEG "
            FromCommand += "ON TEG.GroupNo = TGB.GroupNo "

            'WHERE句生成
            WhereCommand = "WHERE TEP.DeleteFlag = 0 "
            WhereCommand += "AND TED.DeleteFlag = 0 "
            WhereCommand += "AND TED.ProductCode IS Not Null "
            WhereCommand += "AND TED.ProductCode <> '' "


            '見積書番号と案件番号(RICOH)が空白の場合、CreateTime条件追加
            If Require.CheckNum = "" AndAlso Require.RicohNum = "" Then
                '20200219 期間入力チェック追加
                If Require.StartDate IsNot Nothing AndAlso Require.EndDate IsNot Nothing Then
                    WhereCommand += "AND TEP.CreateTime >= '" + Replace(Mid(Require.StartDate, 3, 8), " / ", "") + "' "
                    WhereCommand += "AND TEP.CreateTime <= '" + Replace(Mid(Require.EndDate, 3, 8), " / ", "") + "' "
                End If
            End If

            '見積書番号が空白以外の場合、CheckNum条件追加
            If Require.CheckNum <> "" Then
                WhereCommand += "AND TEP.CheckNum like '" + Require.CheckNum + "%' "
            End If

            '案件番号(RICOH)が空白以外の場合、RicohNum条件追加
            If Require.RicohNum <> "" Then
                WhereCommand += "AND TEP.RicohNum like '%" + Require.RicohNum + "%' "
            End If

            'サンワ担当者名・コードが空白以外の場合、SalesPersonName,SalesPerson条件追加(SalesQuery)
            If Require.SalesPerson <> "" Then
                WhereCommand += SalesQuery
            End If

            '開発・仕入が空白以外の場合、DevPersonCode,DevSupPerson条件追加
            If Require.DevSupPerson <> "" Then
                WhereCommand += "AND (TED.DevPersonCode LIKE '%" + Require.DevSupPerson + "%' "
                WhereCommand += "OR TED.DevPersonName LIKE '%" + Require.DevSupPerson + "%' "
                WhereCommand += "OR TED.SupPersonCode LIKE '%" + Require.DevSupPerson + "%' "
                WhereCommand += "OR TED.SupPersonName LIKE '%" + Require.DevSupPerson + "%') "
            End If

            '作成者名・コードが空白以外の場合、CreatePersonName,CreatePerson条件追加
            If Require.CreatePerson <> "" Then
                WhereCommand += "AND (TEP.CreatePersonName LIKE '%" + Require.CreatePerson + "%' "
                WhereCommand += "OR TEP.CreatePersonCode LIKE '%" + Require.CreatePerson + "%') "
            End If

            '販売店CDが空白以外の場合、CustomerCode条件追加
            If Require.CustomerCode <> "" Then
                If IsNumeric(Require.CustomerCode) Then
                    WhereCommand += "AND TEP.CustomerCode = '" + Right("0000000000" & Require.CustomerCode, 10) + "' "
                Else
                    WhereCommand += "AND TEP.CustomerCode = '" + Require.CustomerCode + "' "
                End If
            End If

            '販売店・部署・担当者名が空白以外の場合、CustomerName,SearchName条件追加
            If Require.SearchName <> "" Then
                WhereCommand += "AND (TEP.CustomerName LIKE '%" + Require.SearchName + "%' "
                WhereCommand += "OR TEP.CustomerDivision LIKE '%" + Require.SearchName + "%' "
                WhereCommand += "OR TEP.CustomerPersonName LIKE '%" + Require.SearchName + "%') "
            End If

            '品番が空白以外の場合、ProductCode条件追加
            If Require.ProductCode <> "" Then
                WhereCommand += "AND TED.ProductCode LIKE '%" + Require.ProductCode + "%' "
            End If

            '成約状況が空白以外の場合、ConclusionStatus条件追加
            If Require.ConclusionStatus <> "" Then
                WhereCommand += "AND TEP.ConclusionStatus = '" + Require.ConclusionStatus + "' "
            End If

            '都道府県が空白・未指定以外の場合、EndUserPref条件追加
            If Require.EndUserPref <> "" Then
                If Require.EndUserPref <> "未指定" Then
                    WhereCommand += "AND TEP.EndUserPref = '" + Require.EndUserPref + "' "
                End If
            End If

            '数量が空白以外の場合、Quantity条件追加
            If Require.Quantity <> "" Then
                If Require.QuantityMark = "以上" Then
                    WhereCommand += "AND TED.Quantity >= " + Require.Quantity + " "
                ElseIf Require.QuantityMark = "以下" Then
                    WhereCommand += "AND TED.Quantity <= " + Require.Quantity + " "
                Else
                    WhereCommand += "AND TED.Quantity = " + Require.Quantity + " "
                End If
            End If

            'グループ・グループ名が空白以外の場合、GroupNo,GroupName条件追加
            If Require.GroupNo <> "" Then
                WhereCommand += "AND TEG.GroupNo = '" + Require.GroupNo + "' "
            End If

            If Require.GroupName <> "" Then
                WhereCommand += "AND TEG.GroupName like '%" + Require.GroupName + "%' "
            End If

            '班が空白以外の場合、SalesPersonCode条件追加
            If Require.KOSTL <> "" Then
                WhereCommand += "AND TEP.SalesPersonCode in (" + GroupQuery + ") "
            End If

            '仮登録チェックの場合、FixFlag条件追加
            If Require.FixCheck = True Then
                WhereCommand += "AND TEP.FixFlag = '0' "
            End If

            '案件管理、ProjectFlag条件追加
            If Require.ProjectFlag = "しない" Then
                WhereCommand += "AND (TEP.ProjectFlag = 0 OR TEP.ProjectFlag Is Null) "
            ElseIf Require.ProjectFlag = "する" Then
                WhereCommand += "AND TEP.ProjectFlag = 1 "
                WhereCommand += "AND TEP.ProjectFlag Is Not Null "
            End If

            '最終ユーザ名が空白以外の場合、EndUserName条件追加
            If Require.EndUserName <> "" Then
                WhereCommand += "AND TEP.EndUserName like '%" + Require.EndUserName + "%' "
            End If

            '見積件名が空白以外の場合、Title条件追加
            If Require.SearchTitle <> "" Then
                WhereCommand += "AND TEP.Title like '%" + Require.SearchTitle + "%' "
            End If

            '所属が2以外の場合、Division条件追加
            If Require.AreaCode <> "2" Then
                If Require.AreaCode = "0" Then
                    WhereCommand += "AND TEP.Division = '0' "
                Else
                    WhereCommand += "AND TEP.Division = '5' "
                End If
            End If

            'メモ書きが空白以外の場合、Contents条件追加
            If Require.SearchMemo <> "" Then
                WhereCommand += "AND TEP.Contents like '%" + Require.SearchMemo + "%' "
            End If

            '見積書番号が入力された場合、他の条件は無視
            If Require.CheckNum <> "" Then
                WhereCommand = "WHERE TEP.DeleteFlag = 0 "
                WhereCommand += "AND TEP.CheckNum like '" + Require.CheckNum + "%' "
            End If

            '得意先CDのソートチェック
            If Require.CustomerSort = False Then
                SortCommand = "ORDER BY TEP.UpdateTime DESC, TED.Columns"
            Else
                SortCommand = "ORDER BY TEP.CustomerCode, TEP.UpdateTime DESC, TED.Columns"
            End If

            SQL_Command = SelectCommand + FromCommand + WhereCommand + SortCommand

            Result_DataTable = SQL_Common.SelectSql(SQL_Command, Util.DB_SERVER)

            Return Result_DataTable
        Catch ex As Exception
            MsgBox("ダウンロードデータの取得に失敗しました。(tEstimentParent)" + Environment.NewLine + ex.Message)

            Return Nothing
        End Try
    End Function
    '↑20200311
End Class
