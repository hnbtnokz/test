'********************************************************
' CSVダウンロード共通処理
'********************************************************
Public Class CSV_Common
    Public Function Create_CSV_List(ByVal tEstimateParent_Table As DataTable, ByVal CsvText As String) As String
        Dim trCnt As Integer = 0
        Dim dCustomerName As String = String.Empty
        Dim dTitle As String = String.Empty
        Dim Status As String = String.Empty
        Dim Status2 As String = String.Empty

        If tEstimateParent_Table.Rows.Count > 0 Then
            trCnt = 1

            '見出し作成
            CsvText = "No,"
            CsvText += "見積番号,"
            CsvText += "見積連番,"
            CsvText += "得意先コード,"
            CsvText += "得意先名,"
            CsvText += "支店名,"
            CsvText += "担当者,"
            CsvText += "見積件名,"
            CsvText += "エンドユーザー業種1,"
            CsvText += "エンドユーザー業種2,"
            CsvText += "最終ユーザ名,"
            CsvText += "都道府県名,"
            CsvText += "市区町村,"
            CsvText += "品番,"
            CsvText += "品名,"
            CsvText += "仕切単価,"
            CsvText += "数量,"
            CsvText += "小計,"
            CsvText += "営業担当コード,"
            CsvText += "営業担当,"
            CsvText += "アシスタントコード,"
            CsvText += "アシスタント,"
            CsvText += "見積作成者,"
            CsvText += "最終更新日,"
            CsvText += "状態,"
            CsvText += "状態2,"
            CsvText += "メモ書き,"
            CsvText += "継続案件フラグ,"
            CsvText += "案件サイクル,"
            CsvText += "グループ番号,"
            CsvText += "グループ名,"
            CsvText += "成約状況,"
            CsvText += "入札予定日,"
            CsvText += "納期" + vbCrLf

            For Each row As DataRow In tEstimateParent_Table.Rows
                ' 出力文字制限：得意先名30バイト、件名32バイト
                If row("CustomerName") IsNot DBNull.Value Then
                    dCustomerName = Trim(row("CustomerName"))
                End If

                If row("Title") IsNot DBNull.Value Then
                    dTitle = Trim(row("Title"))
                End If

                If row("ParentCheckNum") IsNot DBNull.Value Then
                    Status = "継続:" + Trim(row("ParentCheckNum"))
                    Status2 = "ｻﾝﾜCh非表示"
                ElseIf row("FixFlag").ToString = "1" OrElse row("FixFlag") Is DBNull.Value Then
                    Status = "本登録"
                    If row("SanwaChDispFlag").ToString = "1" Then
                        Status2 = "ｻﾝﾜCh表示"
                    Else
                        Status2 = "ｻﾝﾜCh非表示"
                    End If
                Else
                    Status = "仮登録"
                    Status2 = "ｻﾝﾜCh非表示"
                End If

                '書き出し
                CsvText += """" + trCnt.ToString + """"
                CsvText += ",""" + Trim(row("CheckNum")) + """"
                CsvText += ",""" + Trim(row("Columns")) + """"
                CsvText += ",""" + row("CustomerCode") + """"
                CsvText += ",""" + dCustomerName + """"
                CsvText += ",""" + Trim(row("CustomerDivision")) + """"
                CsvText += ",""" + Trim(row("CustomerPersonName")) + """"
                CsvText += ",""" + dTitle + """"

                CsvText += ",""" + Trim(row("ProfessionClass1")) + """"
                CsvText += ",""" + Trim(row("ProfessionClass2")) + """"
                CsvText += ",""" + Trim(row("EndUserName")) + """"
                CsvText += ",""" + Trim(row("EndUserPref")) + """"
                CsvText += ",""" + Trim(row("EndUserAddress")) + """"

                CsvText += ",""" + Trim(row("ProductCode")) + """"
                CsvText += ",""" + Trim(row("ProductName")) + """"

                If row("Quantity") IsNot DBNull.Value AndAlso row("SubTotalPrice") IsNot DBNull.Value Then
                    CsvText += ",""\" + FormatNumber(row("UnitPrice"), 0, -1, 0, -1) + """"
                    CsvText += ",""" + row("Quantity").ToString + """"
                    CsvText += ",""\" + FormatNumber(row("SubTotalPrice"), 0, -1, 0, -1) + """"
                Else
                    CsvText += ","""""
                    CsvText += ","""""
                    CsvText += ","""""
                End If

                CsvText += ",""" + Trim(row("SalesPersonCode")) + """"
                CsvText += ",""" + Trim(row("SalesPersonName")) + """"
                CsvText += ",""" + Trim(row("AssistantCode")) + """"
                CsvText += ",""" + Trim(row("AssistantName")) + """"
                CsvText += ",""" + Trim(row("CreatePersonName")) + """"
                CsvText += ",""" + row("UpdateTime") + """"
                CsvText += ",""" + Status + """"
                CsvText += ",""" + Status2 + """"
                CsvText += ",""" + Replace(Trim(row("Contents")), """", "'") + """"

                CsvText += ",""" + row("ContinuationFlag") + """"
                CsvText += ",""" + row("ContinuationCycle").ToString + """"
                CsvText += ",""" + row("GroupNo") + """"
                CsvText += ",""" + row("GroupName") + """"

                CsvText += ",""" + row("ConclusionStatus") + """"
                CsvText += ",""" + row("ConclusionDate") + """"

                CsvText += ",""" + row("DeliveryLimitDate") + """" + vbCrLf

                trCnt = trCnt + 1
            Next
        End If

        Return CsvText
    End Function

    Public Function Create_CSV_Detail(ByVal tEstimateParent_Table As DataTable, ByVal CsvText As String) As String
        Dim trCnt As Integer = 0
        Dim dCustomerName As String = String.Empty
        Dim dTitle As String = String.Empty
        Dim Status As String = String.Empty
        Dim Status2 As String = String.Empty
        Dim ObjSAP As Object = Nothing
        Dim NormalPrice As Long = 0

        If tEstimateParent_Table.Rows.Count > 0 Then
            trCnt = 1

            CsvText = "リコー品種CD,"
            CsvText += "数量,"
            CsvText += "単価,"
            CsvText += "原価,"
            CsvText += "RJ記載項目,"
            CsvText += "ベンダー案件No,"
            CsvText += "適用(印字用),"
            CsvText += "商品名" + vbCrLf

            '元ソースと同処理(CsvTextクリア？)
            CsvText = ""

            For Each row As DataRow In tEstimateParent_Table.Rows
                ' 出力文字制限：得意先名30バイト、件名32バイト
                dCustomerName = Trim(row("CustomerName"))
                dTitle = Trim(row("Title"))

                If row("ParentCheckNum").ToString <> "" Then
                    Status = "継続:" & Trim(row("ParentCheckNum"))
                    Status2 = "ｻﾝﾜCh非表示"
                ElseIf row("FixFlag").ToString = "1" OrElse row("FixFlag") Is DBNull.Value Then
                    Status = "本登録"
                    If row("SanwaChDispFlag") = "1" Then
                        Status2 = "ｻﾝﾜCh表示"
                    Else
                        Status2 = "ｻﾝﾜCh非表示"
                    End If
                Else
                    Status = "仮登録"
                    Status2 = "ｻﾝﾜCh非表示"
                End If

                CsvText += Trim(row("RCode"))
                CsvText += ","
                CsvText += ","

                If row("Quantity") IsNot DBNull.Value AndAlso row("SubTotalPrice") IsNot DBNull.Value Then
                    CsvText += "," + row("Quantity").ToString

                    '↓20200311 TODO:要確認
                    '本番用？(ローカル実行時エラー)
                    'ObjSAP = CreateObject("SAPCON.Info")
                    'NormalPrice = ObjSAP.tankadw(CStr(row("CustomerCode")), CStr(row("ProductCode")))

                    'テスト用
                    NormalPrice = 100
                    '↑20200311

                    If NormalPrice.ToString <> "" Then
                        If NormalPrice >= 0 Then
                            NormalPrice = Math.Round(NormalPrice + 0.1)
                        Else
                            NormalPrice = 0
                        End If
                    Else
                        NormalPrice = 0
                    End If

                    ObjSAP = Nothing

                    CsvText += "," + NormalPrice.ToString
                    CsvText += "," + row("UnitPrice").ToString
                Else
                    CsvText += ","
                    CsvText += ","
                    CsvText += ","
                End If

                CsvText += ","

                CsvText += "," & row("RicohNum")

                CsvText += ","
                CsvText += "," + vbCrLf

                trCnt = trCnt + 1
            Next
        End If

        Return CsvText
    End Function

    Public Function Download_CSV(ByRef Response As HttpResponse, ByVal CsvText As String, ByVal CheckNum As String, ByVal RicohNum As String) As Boolean
        Try
            'Contentをクリア
            Response.ClearContent()

            'Contentを設定
            Response.ContentEncoding = Encoding.GetEncoding("shift-jis")
            Response.ContentType = "application/octet-stream"

            'AddHeaderを設定
            Response.AddHeader("Content-Type", "text/html; Charset=shift_jis")

            'ファイル名を設定
            If CheckNum = "" AndAlso RicohNum = "" Then
                '検索結果一覧
                Response.AddHeader("Content-Disposition", "attachment;filename=" & "EstimateList.csv")
            ElseIf RicohNum <> "" Then
                '詳細(リコー番号有)
                Response.AddHeader("Content-Disposition", "attachment;filename=" & RicohNum & ".csv")
            Else
                '詳細(リコー番号無)
                Response.AddHeader("Content-Disposition", "attachment;filename=" & CheckNum & ".csv")
            End If

            'CSVデータを書き込み
            Response.Write(CsvText)

            'ダウンロード実行
            Response.Flush()
        Catch ex As Exception
            Return False
        Finally
            Response.End()
        End Try

        Return True
    End Function
End Class
