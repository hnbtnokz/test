<%@ Page Title="見積案件システム　回答" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Check.aspx.vb" Inherits="estimate_system.Check" %>

<%@ MasterType VirtualPath="~/Site.Master" %>

<asp:Content ID="Header" ContentPlaceHolderID="head" runat="server" ClientIDMode="Static">
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="body" runat="server">
    <%--20200305 ADD--%>
<%--    <script src="../../Scripts/js.cookie.js"></script>
    <script src="../../Scripts/jquery.inview.min.js"></script>--%>
<%--<script src="../../Scripts/datepicker-ja.js"></script>--%>
<%--    <script src="../../Scripts/jquery.blockUI.js"></script>--%>
<%--<script src="../../Scripts/jquery.datetimepicker.full.min.js"></script>--%>
    <script type="text/javascript" src="../../Scripts/Common.js?ver=<%= estimate_system.Common.Util.GetCashClearstr() %>"></script>

<%--20200303<script src="Scripts/Check.js?ver=<%= estimate_system.Common.Util.GetCashClearstr() %>"></script>--%>
    <script type="text/javascript" src="Check.js?ver=<%= estimate_system.Common.Util.GetCashClearstr() %>"></script>

    <%--20200303 ADD -> 20200305 EDIT--%>
    <script src="../../Scripts/estimate_system.js"></script>


    <!-- ▼ メインコンテンツここから ▼ -->
    <div class="admin_main_contents clfx"><!-- width: 1880px;-->

        <!-- 見積システム 見積詳細 -->
<%--20200303<form name="ESCheckForm" method="post" action="#">--%>

<%--20200303<input type="hidden" name="MailSendFlag" id="MailSendFlag" value="" />
            <input type="hidden" name="CheckNum" id="CheckNum" value="" />--%>
            <asp:HiddenField ID="MailSendFlag" runat="server" Value="" ClientIDMode="Static" />
            <asp:HiddenField ID="CheckNum" runat="server" Value="" ClientIDMode="Static" />

            <div id="estimate_system_check"><!--width: 1580px;-->
                <p class="admin_page_ttl">見積案件システム 案件確認・回答</p>

                <div class="head_area">
                    <p class="back_btn">
                        <input type="button" value="一覧へ戻る" onclick="location.href = '../../Index.aspx';" />&nbsp;&nbsp;
                        <input type="button" value="在庫/納期" onclick="estimateSystemCheckInvOpen();" />
                    </p>

                    <div class="mail_area">
                        <p class="mail_fix">依頼メール<br /><span class="submit_fix">送信済</span></p>
                        <%--<p>依頼メール</p>--%>
                        <p class="mail_fix">回答メール<br /><span class="submit_fix">送信済</span></p>
                        <%--<p>回答メール</p>--%>
                    </div>
                </div>

                <table class="info_table">
                    <tr>
                        <th colspan="2">依頼番号</th>
                        <td style="width: 387px" class="td_checkno">X20022500254</td>
                        <th colspan="2">営業担当</th>
                        <td style="width: 150px">後田 誠一 (内線：1429)</td>
                        <th style="width: 90px">アシスタント</th>
                        <td style="width: 150px">久山 真知子 (内線：1428)</td>
                        <th style="width: 60px">作成日</th>
                        <td style="width: 90px">2020/02/25</td>
                        <th style="width: 90px">最終更新日時</th>
                        <td>2020/02/25 11:21:09</td>
                    </tr>
                    <tr>
                        <th rowspan="4" style="width: 50px">得意先</th>
                        <th style="width: 70px">得意先CD</th>
                        <td>0000009240</td>
                        <th rowspan="3" style="width: 50px">納入先</th>
                        <th style="width: 70px">納入先区分</th>
                        <td colspan="7"></td>
                    </tr>
                    <tr>
                        <th>得意先名</th>
                        <td>三光機工株式会社</td>
                        <th>納入先名</th>
                        <td colspan="7"></td>
                    </tr>
                    <tr>
                        <th>部署</th>
                        <td>湖南営業所</td>
                        <th>住所</th>
                        <td colspan="7"></td>
                    </tr>
                    <tr>
                        <th>担当者</th>
                        <td>小川</td>
                        <th colspan="2" rowspan="4">メモ</th>
                        <td colspan="7" rowspan="4" class="td_top">
                            <pre></pre>
                        </td>
                    </tr>
                    <tr>
                        <th colspan="2">納入方法</th>
                        <td>一括納入 (期間： 回数：)</td>
                    </tr>
                    <tr>
                        <th colspan="2">納期</th>
                        <td class="td_notice"></td>
                    </tr>
                    <tr>
                        <th colspan="2">入札予定日</th>
                        <td></td>
                    </tr>
                </table>

                <%--20200325 id追加--%>
                <%--<table class="product_table">--%>
                <table class="product_table" id="product_table">
                    <tr>
                        <%-- If Session("SupplierFlag") = "1" Then --%>
                        <th style="width: 40px">#</th>
                        <th style="width: 100px">担当者</th>
                        <th style="width: 50px">要確認</th>
                        <th style="width: 60px">成否</th>
                        <th style="width: 170px">品番</th>
                        <th style="width: 70px">数量</th>
                        <th style="width: 350px">納期/メッセージ</th>
                        <th>その他情報</th>
                        <th style="width: 90px">定価</th>
                        <th style="width: 85px">見積金額</th>
                        <th style="width: 85px">営業原価</th>
                        <th style="width: 230px">競合状況</th>
                        <%--
                    <th style="width:40">#</th>
                      <th style="width:170">品番</th>
                      <th style="width:90">定価</th>
                      <th style="width:70">数量</th>
                      <th style="width:85">見積金額</th>
                      <th style="width:85">営業原価</th>
                      <th style="width:85">粗利</th>
                      <th style="width:265">納期/メッセージ</th>
                      <th style="width:230">競合状況</th>
                      <th>その他情報</th>
                      <th style="width:60">成否</th>
                      <th style="width:50">要確認</th>
                      <th style="width:100">担当者</th>
                        --%>
                    </tr>

                    <%--
                    ' ■ 仕入と以外で配置変更の為分岐 (仕入のみシミュレーションボタン設置)
                    If Session("SupplierFlag") = "1" Then
                    --%>

                    <tr>
                        <td class="td_center" id="Columns1">1</td>
                        <td class="td_left">
                            <p id="SupPersonName1">SupPersonName</p>
                            <p id="DevPersonName1">DevPersonName</p>
                        </td>
                        <td class="td_center">
                            <input type="checkbox" name="ImportantFlag" id="ImportantFlag1" value="1" checked="checked" /></td>
                        <td class="td_center" id="ConclusionStatusDetail1">ConclusionStatusDetail</td>
                        <td class="td_sku">
                            <p id="ProductCode1">ProductCode</p>
                            <p>
                                <input type="button" value="シミュレーション" onclick="estimateSystemCheckSimuOpen('ProductCode');" />
                            </p>
                        </td>
                        <td class="td_quantity" id="Quantity1">100</td>
                        <td class="td_center">
                            <p>
                                <textarea name="PurchaseComment" id="PurchaseComment1"></textarea>
                            </p>
                            <p>
                                <textarea name="DevLeaderComment" id="DevLeaderComment1"></textarea>
                            </p>
                        </td>
                        <td class="td_left">
<%--20200325 EDIT           <pre>RivalOther</pre>--%>
                            <span id="RivalOther1">RivalOther</span>
                        </td>
                        <td>RegularPrice1
                            <input type="hidden" name="RegularPrice" id="RegularPrice1" value="10000" />
                        </td>
                        <td>
                            <p id="UnitPrice1">UnitPrice</p>
                            <p>
                                <input type="text" class="price_box" name="LeaderPrice" id="LeaderPrice1" value="0" onchange="estimateSystemCheckPriceCalc('1', 'LeaderPrice');" />
                            </p>
                            <p id="UnitRate1">UnitRate%</p>
                            <p>
                                <input type="text" class="percent_box" name="LeaderRate" id="LeaderRate1" value="0" onchange="estimateSystemCheckPriceCalc('1', 'LeaderRate');" />%
                            </p>
                        </td>
                        <td>
                            <p id="EigyouGenk1">EigyouGenk</p>
                            <p>
                                <input type="text" class="price_box" name="CorrectionPrice" id="CorrectionPrice1" value="0" onchange="estimateSystemCheckPriceCalc('1', 'CorrectionPrice');" />
                            </p>
                            <p id="EigyouGenkaRate1">EigyouGenkaRate%</p>
                            <p>
                                <input type="text" class="percent_box" name="CorrectionRate" id="CorrectionRate1" value="0" onchange="estimateSystemCheckPriceCalc('1', 'CorrectionRate');" />%
                            </p>
                        </td>
                        <td class="td_left">
                            <p id="RivalMaker1">ﾒｰｶｰ： RivalMaker</p>
                            <p id="RivalSku1">品番： RivalSku</p>
                            <p id="RivalPrice1">価格： RivalPrice</p>
                        </td>
                    </tr>

                    <%-- Else --%>
         
                    <tr>
                      <td class="td_center" id="Columns2">2</td>
                      <td class="td_sku">
                        <p id="ProductCode2">ProductCode2</p>
                      </td>
                      <td>RegularPrice2
                          <input type="hidden" name="RegularPrice" id="RegularPrice2" value="10000" />
                      </td>
                      <td id="Quantity2">Quantity2</td>
                      <td>
                        <p>UnitPrice2<input type="hidden" name="UnitPrice" id="UnitPrice2" value="1000" /></p>
                        <p><input type="text" class="price_box" name="LeaderPrice2" id="LeaderPrice2" value="" onchange="estimateSystemCheckPriceCalc('2', 'LeaderPrice');" /></p>
                        <p>%</p>
                        <p><input type="text" class="percent_box" name="LeaderRate2" id="LeaderRate2" value="" onchange="estimateSystemCheckPriceCalc('2', 'LeaderRate');" />%</p>
                      </td>
                      <td>
                        <p>EigyouGenka2<input type="hidden" name="EigyouGenka2" id="EigyouGenka2" value="500" /></p>
                        <p><input type="text" class="price_box" name="CorrectionPrice2" id="CorrectionPrice2" value="" onchange="estimateSystemCheckPriceCalc('2', 'CorrectionPrice');" /></p>
                        <p id="EigyouGenkaRate2">EigyouGenkaRate%</p>
                        <p><input type="text" class="percent_box" name="CorrectionRate2" id="CorrectionRate2" value="" onchange="estimateSystemCheckPriceCalc('2', 'CorrectionRate');" />%</p>
                      </td>
                      <td>
                        <p id="MarginPrice2">MarginPrice</p>
                        <p><input type="text" class="price_box" name="LeaderMargin2" id="LeaderMargin2" value="" readonly="" /></p>
                        <p id="MarginRate2">MarginRate%</p>
                        <p><input type="text" class="percent_box" name="LeaderMarginRate2" id="LeaderMarginRate2" value="" readonly="" />%</p>
                      </td>
                      <td class="td_center">
                        <p><textarea name="PurchaseComment2" id="PurchaseComment2"></textarea></p>
                        <p><textarea name="DevLeaderComment2" id="DevLeaderComment2"></textarea></p>
                      </td>
                      <td class="td_left">
                            <p id="RivalMaker2">ﾒｰｶｰ： RivalMaker</p>
                            <p id="RivalSku2">品番： RivalSku</p>
                            <p id="RivalPrice2">価格： RivalPrice</p>
                      </td>
                      <td class="td_left">
<%--20200325 EDIT       <pre>RivalOther2</pre>--%>
                          <span id="RivalOther2">RivalOther2</span>
                      </td>
                      <td class="td_center" id="ConclusionStatusDetail2">ConclusionStatusDetail2</td>
                      <td class="td_center"><input type="checkbox" name="ImportantFlag" id="ImportantFlag2" value="1" checked="checked" /></td>
                      <td class="td_left">
                        <p id="DevPersonName2">DevPersonName</p>
                        <p id="SupPersonName2">SupPersonName</p>
                      </td>
                    </tr>
                    
                </table>

                <%--1件以上ある場合、ボタン表示する--%>
                <p class="btn_area">
                    <input type="button" value="保 存" onclick="estimateSystemCheckSave('');" />
                    <input type="button" value="保 存 (メール送信)" onclick="estimateSystemCheckSave('submit');" />
<%--20200304            <asp:Button ID="BtnSave" runat="server" Text="保 存" OnClientClick="estimateSystemCheckSave('')" ClientIDMode="Static" />
                    <asp:Button ID="BtnSave2" runat="server" Text="保 存 (メール送信)" OnClientClick="estimateSystemCheckSave('submit')" ClientIDMode="Static" />--%>
                </p>

            </div>

            <%--<input type="hidden" name="ProductCode" id="ProductCode" value="" />--%>

        <%--</form>--%>

    </div><%--admin_main_contents--%>
    <!-- ▲ メインコンテンツ閉め ▲ -->

</asp:Content>
