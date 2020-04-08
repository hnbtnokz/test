<%@ Page Title="見積案件システム　詳細" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Detail.aspx.vb" Inherits="estimate_system.Detail" %>

<%@ MasterType VirtualPath="~/Site.Master" %>

<asp:Content ID="Header" ContentPlaceHolderID="head" runat="server" ClientIDMode="Static">
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="body" runat="server" ClientIDMode="Static">

    <%--20200309 MOVE FROM MASTER--%>
    <script src="Scripts/Common.js?ver=<%= estimate_system.Common.Util.GetCashClearstr() %>"></script>

    <script src="Scripts/Detail.js?ver=<%= estimate_system.Common.Util.GetCashClearstr() %>"></script>
    <script src="Scripts/estimate_system.js"></script>

<!-- ▼ メインコンテンツここから ▼ -->
<div id="admin_main_contents" class="clfx">
<%--<div class="admin_main_contents"><!-- width: 1880px;-->--%>

<!-- 見積システム 見積詳細 -->
<%--<form name="ESDetailForm" runat="server" method="post" action="#">--%>

<%--    20200323 DELETE ダブリ--%>
<%--<asp:HiddenField ID="CheckNum" runat="server" value="" />--%>

<asp:HiddenField ID="SubmitMode" runat="server" value="" />
<asp:HiddenField ID="RequestNumber" runat="server" value="aaa" />
<asp:HiddenField ID="FixFlag" runat="server" value="bbb" />
<asp:HiddenField ID="SubmitFixFlag" runat="server" value="" />
<asp:HiddenField ID="FirstCustomerErrorFlag" runat="server" value="0" />
<asp:HiddenField ID="RICOHFlag" runat="server" value="ccc" />
<asp:HiddenField ID="ConclusionStatus" runat="server" value="" />
<input type="hidden" id="EstPersonName" value="<%= Session("EstPersonName") %>" />

    <div id="estimate_system_detail">
<%--<div class="estimate_system_detail"><!--width: 1880px;-->--%>
<%--
    <p class="admin_page_ttl">見積案件システム 見積詳細</p>
    <hr>
    <div class="text-success text-left">
        <asp:Label ID="lblMsg" runat="Server" Text="検索条件を選択・入力してください" />
    </div>
    <div class="text-danger text-left">
        <asp:Label ID="lblErrMsg" runat="Server" Text="" />
    </div>
--%>

        <!-- ***************************** コメント表示部 ************************************** -->
        <div id="CommentArea"></div>

        <%--20200306--%>
<%--        <p id="admin_page_ttl">見積案件システム 見積詳細</p>--%>
        <p class="admin_page_ttl" id="admin_page_ttl">見積案件システム 見積詳細</p>

        <!-- **************************** 見積詳細情報表示部 *********************************** -->
        <div id="estimate_detail_main">
        
            <%--@@@--%>
	        <p class="section_ttl">顧客情報</p>
	        <div class="customer_data">
	        <table class="customer_data_table">
	          <tr>
	            <th width="70">得意先CD</th>
	            <td width="380">
<%--                <input type="text" name="CustomerCode" id="CustomerCode" value="" maxlength="10" /> --%>

<%--20200401 test data--%>
                    <input type="text" name="CustomerCode" id="CustomerCode" value="123456789" maxlength="10" /> 

	              <a href="javascript: estimateSystemCustomerSearch();">
	              <img src="Img/search.png" width="16" height="17" class="search_icon" align="absmiddle" /></a >
	              <a href="javascript: estimateSystemCustomerListOpen();">検索</a>
	            </td>
	          </tr>
	        </table>
	        </div>
            <%--◆◆◆ 見積情報 ◆◆◆--%>        
	        <p class="section_ttl">見積情報</p>
	        <div class="head_data">	        
	           <table class="head_data_table">
	                 <tbody>
	                 <tr>
	                   <th width="80">見積件名</th>
	                   <td width="365"><input type="text" name="Title" id="Title" value="テスト-リコー番号なし" maxlength="80"/>
	                   </td>
	                 </tr>
	                 <tr>
	                   <th style="vertical-align: top;">備考 <input type="button" value="参照" onclick="estimateSystemTemplateCommentOpen();"/></th>
	                   <td colspan="3"><textarea name="Other" id="Other"></textarea>
	                   </td>
	                 </tr>
	                 <tr>
	                   <th style="vertical-align: top;">メール文書</th>        
	                   <td colspan="3"><textarea name="FixMailBody" id="FixMailBody">null</textarea><br>※ メール文書はサンワChからの依頼取込、またはアカウント連携後のサンワCh表示本登録時に送信されるメールへの差込文章になります。
	                   </td>      
	                 </tr>
	                 <tr class="tr_sep">
	                   <th>最終ユーザ名</th>
	                   <td colspan="3"><input type="text" name="EndUserName" id="EndUserName" value="テスト エンドユーザー" maxlength="50"/>
	                   <input type="button" value="件名をコピー" onclick="estimateSystemDetailUserNameCopy();">
	                   </td>      
	                 </tr>      
	                 <tr>
	                   <th>エンドユーザー業種</th>
	                   <td><input type="text" name="EndUserAddress" id="EndUserAddress" placeholder="市区町村" value="" maxlength="50"/>
	                   </td>      
	                 </tr>
	                 <tr>        
	                 <th style="vertical-align: top;">営業メモ<br>(非公開)</th>        
	                   <td colspan="3"><textarea name="SalesMemo" id="SalesMemo" placeholder="共有されない営業用のメモです。"></textarea>
	                   </td>      
	                 </tr>      
	                 <tr>        
	                   <td colspan="4" class="btn_area"><input type="button" value="最終ユーザ名・エンドユーザー業種・住所区分・メモ 保存" onclick="estimateSystemDetailMemoSave();"/>
	                   </td>
	                 </tr>    
	                 </tbody>
	           </table>	           
	        </div>
            <%--■ 申請内容--%>
            <p class="section_ttl">サンワCh アカウント連携</p>
            <div class="head_data">
                <table class="head_data_table2">
                    <tr>
                        <th width="80">ログインID</th>
<%--                        <td>【 <a href="javascript: estimateSystemDetail3chIDSearch();" id="SCID">' + SanwaChLoginID + '</a> 】<input type="hidden" name="SanwaChLoginID" id="SanwaChLoginID" value="' + SanwaChLoginID + '" /></td>--%>
                        <td>
<%--20200402 test data--%>
                            【 <a href="javascript: estimateSystemDetail3chIDSearch();" id="SCID">SanwaChLoginID1</a> 】<input type="hidden" name="SanwaChLoginID" id="SanwaChLoginID" value="SanwaChLoginID1" />
                        </td>
                    </tr>
<%--20200402 test data--%>
<%--                    <tr>
                        <td>
                            【 <a href="javascript: estimateSystemDetail3chIDSearch();" id="SCID">連携なし</a> 】<input type="hidden" name="SanwaChLoginID" id="SanwaChLoginID" value="" />
                        </td>
                    </tr>--%>
                </table>
            </div>
            <%--■ 継続案件・商品情報--%>
            <%--◆◆◆ 継続案件 ◆◆◆--%>
            <!-- ◆◆◆ グループ設定 ◆◆◆ -->
            <p class="section_ttl">グループ設定</p>
            <div class="head_data">
                <table class="head_data_table2">
                    <tr>
                        <th width="80">グループ番号</th>
                            <td><input type="text" name="GroupNo" id="GroupNo" value="GROUP001" readonly /></td>

<%--        if (CheckNum != "") {--%>
                            <td rowspan="3" class="td_group_btn"><input type="button" value="グループ管理" onclick="estimateSystemGroupWindow();" />
                            <input type="hidden" name="CheckNum" id="CheckNum" value="X19060100001" /><%--20200406 ADD for test--%>
                            </td>
<%--        } else {
                            <td rowspan="3" class="td_group_btn">※見積番号を発行後にグループ管理ができます<br />※先に仮登録、または本登録を行ってください</td>
        }--%>

                    </tr>
                    <tr>
                        <th>グループ名</th>
                        <td><input type="text" name="GroupTitle" id="GroupTitle" value="GroupTitle1" readonly /></td>
                    </tr>
                    <tr>
                        <th>案件リーダー</th>
                        <td><input type="text" name="GroupLeader" id="GroupLeader" value="GroupLeader1" readonly /></td>
                    </tr>
                </table>
            </div>


            <!-- ◆◆◆ 案件情報 ◆◆◆ -->
            <!-- ◆◆◆ 得意先コメント ◆◆◆ -->
        </div>

        <!-- ****************************  商品情報表示部  ************************************* -->
        <div id="estimate_detail_product">
  <!-- ◆◆◆ 商品情報 ◆◆◆ -->
  <p class="section_ttl">商品情報
    <input type="button" value="リセット" onclick="estimateSystemItemReset();">
    <input type="button" value="再提案" onclick="estimateSystemItemReCalc('normal');">
    <input type="button" value="営業原価再提案" onclick="estimateSystemItemReCalc('genka');">
    <input type="button" value="一括仕切設定" onclick="estimateSystemItemRateAllIn();" />
    <input type="button" value="一括数量設定" onclick="estimateSystemItemAmountAllIn();" />
    <input type="button" value="一括品番入力" onclick="estimateSystemItemAllIn();" />
    <input type="button" value="通常仕切ｺﾋﾟｰ" onclick="estimateSystemItemPriceCopy();" />
    <input type="button" value="一括仕切率計算" onclick="estimateSystemItemRateCalc();" />
    <input type="button" value="データコピー" onclick="estimateSystemItemDataCopy();" />
    <input type="button" value="在庫照会" onclick="estimateSystemItemInventOpen();" /></p>
  <div class="body_data">
    <p style="margin: 5px 0 0 0;"><b>合計金額 ： </b><input type="text" name="TotalPrice" id="TotalPrice" value="426844" readonly /></p>
    <table class="body_data_table1">
      <tr>
        <td width="120"><label for="TotalDispFlag"><input type="checkbox" name="TotalDispFlag" id="TotalDispFlag" value="1" checked /> 合計金額表示</label></td>
        <td width="100"><label for="TaxDispFlag"><input type="checkbox" name="TaxDispFlag" id="TaxDispFlag" value="1" onclick="estimateSystemTaxCheck('all');" /> 税込表示</label></td>
        <td width="170"><label for="TaxDispFlag2"><input type="checkbox" name="TaxDispFlag" id="TaxDispFlag2" value="2" onclick="estimateSystemTaxCheck('total');" /> 税込表示(合計金額のみ)</label></td>
        <td width="140">税率：<select name="TaxPercent" id="TaxPercent" onchange="estimateSystemDetailTaxChange('10');">
                                <option value="5">5%</option>
                                <option value="8">8%</option>
                                <option value="10" selected>10%</option>
                              </select></td>
        <td width="400"><b>オープンプライス ： </b><label for="OpenPrice0"><input type="radio" name="OpenPrice" id="OpenPrice0" value="0" checked /> オープンと表示</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<label for="OpenPrice1"><input type="radio" name="OpenPrice" id="OpenPrice1" value="1" /> 参考定価を表示</label></td>
        <td><b>定価・仕切率 ： </b><label for="NoPriceDisp"><input type="checkbox" name="NoPriceDisp" id="NoPriceDisp" value="1" /> 表示しない</label></td>
      </tr>
    </table>

    <table class="body_data_table2">
      <tr>
        <th width="35">削除</th>
        <th width="170">型番<br />品名<br />在庫状況</th>
        <th width="25">Op<br />en</th>
        <th width="75">定価<br />通常仕切<br />通常仕切率</th>
        <th width="75">仕切率<br />仕切価格</th>
        <th width="60">数量</th>
        <th width="75">小計</th>
        <th>納期 <input type="button" value="一括コピー" onclick="estimateSystemDetailNoukiCopy();" /><br />メモ</th>
        <th width="75">営業原価<br />粗利<br />リミット単価</th>
        <th width="75">粗利計<br />粗利率</th>
        <th width="25">判<br />定</th>
        <th width="265" class="th_project">納期(仕入)<br />メッセージ(開発・リーダー)</th>
        <th width="70" class="th_project">成否<br /><input type="button" id="all_seiyaku" value="成約" />&nbsp;<input type="button" id="all_fuseiyaku" value="不成約" /></th>
        <th width="165" class="th_project">その他情報</th>
        <th width="160" class="th_project">競合状況</th>
        <th width="75" class="th_project">リーダー<br />回答仕切<br />回答仕切率</th>
        <th width="75" class="th_project">原価訂正</th>
        <th width="200" class="th_project">不成約理由<br /><input type="button" value="一括コピー" onclick="estimateSystemDetailNotCompletedReasonCopy();" /></th>
      </tr>

      <tr id="Column_1">
        <td><input type="text" class="ColumnNo" name="ColumnNo1" id="ColumnNo1" value="1" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(1);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck1" id="DeleteCheck1" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('1');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(1);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode1" id="ProductCode1" value="MR-FAPRNN" maxlength="20" onchange="estimateSystemProductSearch(1);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck1" id="OutletCheck1" value="1" onclick="estimateSystemOutletChack(1);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag1" id="FeeFlag1" value="1" /><input type="hidden" name="SuperBigFlag1" id="SuperBigFlag1" value="1" /></p>
          <p><input type="text" class="ProductName" style="color: #F00;" name="ProductName1" id="ProductName1" value="防塵プリンターボックス（W750×D648mm）" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine1">Rコード <input type="text" class="ProductCode3" name="RCode1" id="RCode1" value="CHH201" maxlength="6" onchange="estimateSystemProductSearchRICOH(1);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea1">在庫：<a href="javascript: estimateSystemInventoryLayer(1);">　ﾌﾟﾚｽ/3</a><input type="hidden" id="InvW_1" value="3" /><input type="hidden" id="InvE_1" value="0" /><div class="InventoryLayer" id="InventoryLayer1"><p style="font-weight: bold;">品番：MR-FAPRNN</p><p>開発：西村俊昭(7008)　　仕入：難波プレス担当()</p><p class="layer_ttl">■ 在庫</p><table class="layer_tbl1"><tr><th>倉庫</th><th>フリー</th><th>未引当</th><th>引当済</th></tr><tr><td>14：ﾌﾟﾚｽ</td><td>3</td><td>0</td><td>2</td></tr></table><p class="big_charge">★送料が別途掛かる大物商品です。</p><p class="close_btn"><a href="javascript: estimateSystemInventoryLayerClose(1);">× 閉じる</a></p></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck1" id="OpenCheck1" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice1" id="RegularPrice1" value="229000" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice1" id="NormalPrice1" value="126950" readonly onfocus="estimateSystemCursorAdvance('normal',1);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate1" id="NormalRate1" value="55.4" readonly onfocus="estimateSystemCursorAdvance('normal',1);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate1" id="UnitRate1" value="54" maxlength="5" onchange="estimateSystemUnitPercent(1, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice1" id="UnitPrice1" value="123660" maxlength="10" onchange="estimateSystemUnitPercent(1, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity1" id="Quantity1" value="2" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(1); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice1" id="SubTotalPrice1" value="247320" readonly onfocus="estimateSystemCursorAdvance('sub',1);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime1" id="DeliveryTime1" value="在庫限り　在庫あり" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo1" id="Memo1" value="車上渡しの場合は送料込みです。" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice1">★大物商品★車上渡し商品</p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka1" id="EigyouGenka1" value="89818" readonly onfocus="estimateSystemCursorAdvance('next',1);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice1" id="MarginPrice1" value="33842" readonly onfocus="estimateSystemCursorAdvance('next',1);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice1" id="LimitPrice1" value="0" readonly onfocus="estimateSystemCursorAdvance('next',1);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal1" id="MarginTotal1" value="67684" readonly onfocus="estimateSystemCursorAdvance('next',1);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate1" id="MarginRate1" value="27.4" readonly onfocus="estimateSystemCursorAdvance('next',1);" />%</p>
        </td>
        <td id="MarginRank1">B </td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment1" id="PurchaseComment1" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment1" id="DevLeaderComment1" readonly></textarea><input type="hidden" name="AutoAnswerFlag1" id="AutoAnswerFlag1" value="0" /><input type="hidden" name="ImportantFlag1" id="ImportantFlag1" value="0" /></p>
        </td>
        <td class="td_project"><input type="button" class="con_btn" id="ConclusionStatusDetailBtn1" value="継続中" onclick="estimateSystemDetailConclusionChange('1');" data-conclusion /><input type="hidden" name="ConclusionStatusDetail1" id="ConclusionStatusDetail1" value="継続中" data-conclusion /></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther1" id="RivalOther1" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker1" id="RivalMaker1" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku1" id="RivalSku1" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice1" id="RivalPrice1" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice1" id="LeaderPrice1" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',1);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate1" id="LeaderRate1" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',1);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice1" id="CorrectionPrice1" value="" readonly onfocus="estimateSystemCursorAdvance('next',1);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate1" id="CorrectionRate1" value="" readonly onfocus="estimateSystemCursorAdvance('next',1);" />%</p>
        </td>
        <td class="td_project">

          <ul class="not_completed_reason">
            <li><label for="NotCompletedReason1_1"><input type="checkbox" name="NotCompletedReason1_1" id="NotCompletedReason1_1" value="1" /> 価格</label></li>
            <li><label for="NotCompletedReason2_1"><input type="checkbox" name="NotCompletedReason2_1" id="NotCompletedReason2_1" value="1" /> 納期</label></li>
            <li><label for="NotCompletedReason3_1"><input type="checkbox" name="NotCompletedReason3_1" id="NotCompletedReason3_1" value="1" /> 本体ありき</label></li>
            <li><label for="NotCompletedReason4_1"><input type="checkbox" name="NotCompletedReason4_1" id="NotCompletedReason4_1" value="1" /> 仕様あわず</label></li>
            <li><label for="NotCompletedReason5_1"><input type="checkbox" name="NotCompletedReason5_1" id="NotCompletedReason5_1" value="1" /> 販社辞退</label></li>
            <li><label for="NotCompletedReason6_1"><input type="checkbox" name="NotCompletedReason6_1" id="NotCompletedReason6_1" value="1" /> 社内競合</label></li>
            <li><label for="NotCompletedReason7_1"><input type="checkbox" name="NotCompletedReason7_1" id="NotCompletedReason7_1" value="1" /> 型番数量違い</label></li>
            <li><label for="NotCompletedReason9_1"><input type="checkbox" name="NotCompletedReason9_1" id="NotCompletedReason9_1" value="1" /> その他</label></li>
          </ul>

        </td>
      </tr>

      <tr id="Column_2">
        <td><input type="text" class="ColumnNo" name="ColumnNo2" id="ColumnNo2" value="2" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(2);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck2" id="DeleteCheck2" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('2');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(2);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode2" id="ProductCode2" value="MR-FA17CMKN" maxlength="20" onchange="estimateSystemProductSearch(2);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck2" id="OutletCheck2" value="1" onclick="estimateSystemOutletChack(2);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag2" id="FeeFlag2" value="1" /><input type="hidden" name="SuperBigFlag2" id="SuperBigFlag2" value="0" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName2" id="ProductName2" value="簡易防塵ラック（簡易防塵タイプ・W750×D650mm）" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine2">Rコード <input type="text" class="ProductCode3" name="RCode2" id="RCode2" value="CHH202" maxlength="6" onchange="estimateSystemProductSearchRICOH(2);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea2">在庫：<a href="javascript: estimateSystemInventoryLayer(2);">　ﾌﾟﾚｽ/0</a><input type="hidden" id="InvW_2" value="0" /><input type="hidden" id="InvE_2" value="0" /><div class="InventoryLayer" id="InventoryLayer2"><p style="font-weight: bold;">品番：MR-FA17CMKN</p><p>開発：西村俊昭(7008)　　仕入：難波プレス担当()</p><p class="layer_ttl">■ 在庫</p><table class="layer_tbl1"><tr><th>倉庫</th><th>フリー</th><th>未引当</th><th>引当済</th></tr><tr><td>14：ﾌﾟﾚｽ</td><td>0</td><td>0</td><td>1</td></tr></table><p class="big_charge">★送料が別途掛かる大物商品です。</p><p class="close_btn"><a href="javascript: estimateSystemInventoryLayerClose(2);">× 閉じる</a></p></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck2" id="OpenCheck2" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice2" id="RegularPrice2" value="100000" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice2" id="NormalPrice2" value="57500" readonly onfocus="estimateSystemCursorAdvance('normal',2);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate2" id="NormalRate2" value="57.5" readonly onfocus="estimateSystemCursorAdvance('normal',2);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate2" id="UnitRate2" value="57" maxlength="5" onchange="estimateSystemUnitPercent(2, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice2" id="UnitPrice2" value="57000" maxlength="10" onchange="estimateSystemUnitPercent(2, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity2" id="Quantity2" value="2" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(2); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice2" id="SubTotalPrice2" value="114000" readonly onfocus="estimateSystemCursorAdvance('sub',2);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime2" id="DeliveryTime2" value="4月上旬入荷予定" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo2" id="Memo2" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice2">★大物商品</p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka2" id="EigyouGenka2" value="40579" readonly onfocus="estimateSystemCursorAdvance('next',2);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice2" id="MarginPrice2" value="16421" readonly onfocus="estimateSystemCursorAdvance('next',2);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice2" id="LimitPrice2" value="0" readonly onfocus="estimateSystemCursorAdvance('next',2);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal2" id="MarginTotal2" value="32842" readonly onfocus="estimateSystemCursorAdvance('next',2);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate2" id="MarginRate2" value="28.8" readonly onfocus="estimateSystemCursorAdvance('next',2);" />%</p>
        </td>
        <td id="MarginRank2">B </td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment2" id="PurchaseComment2" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment2" id="DevLeaderComment2" readonly></textarea><input type="hidden" name="AutoAnswerFlag2" id="AutoAnswerFlag2" value="0" /><input type="hidden" name="ImportantFlag2" id="ImportantFlag2" value="0" /></p>
        </td>
        <td class="td_project"><input type="button" class="con_btn" id="ConclusionStatusDetailBtn2" value="継続中" onclick="estimateSystemDetailConclusionChange('2');" data-conclusion /><input type="hidden" name="ConclusionStatusDetail2" id="ConclusionStatusDetail2" value="継続中" data-conclusion /></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther2" id="RivalOther2" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker2" id="RivalMaker2" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku2" id="RivalSku2" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice2" id="RivalPrice2" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice2" id="LeaderPrice2" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',2);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate2" id="LeaderRate2" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',2);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice2" id="CorrectionPrice2" value="" readonly onfocus="estimateSystemCursorAdvance('next',2);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate2" id="CorrectionRate2" value="" readonly onfocus="estimateSystemCursorAdvance('next',2);" />%</p>
        </td>
        <td class="td_project">

          <ul class="not_completed_reason">
            <li><label for="NotCompletedReason1_2"><input type="checkbox" name="NotCompletedReason1_2" id="NotCompletedReason1_2" value="1" /> 価格</label></li>
            <li><label for="NotCompletedReason2_2"><input type="checkbox" name="NotCompletedReason2_2" id="NotCompletedReason2_2" value="1" /> 納期</label></li>
            <li><label for="NotCompletedReason3_2"><input type="checkbox" name="NotCompletedReason3_2" id="NotCompletedReason3_2" value="1" /> 本体ありき</label></li>
            <li><label for="NotCompletedReason4_2"><input type="checkbox" name="NotCompletedReason4_2" id="NotCompletedReason4_2" value="1" /> 仕様あわず</label></li>
            <li><label for="NotCompletedReason5_2"><input type="checkbox" name="NotCompletedReason5_2" id="NotCompletedReason5_2" value="1" /> 販社辞退</label></li>
            <li><label for="NotCompletedReason6_2"><input type="checkbox" name="NotCompletedReason6_2" id="NotCompletedReason6_2" value="1" /> 社内競合</label></li>
            <li><label for="NotCompletedReason7_2"><input type="checkbox" name="NotCompletedReason7_2" id="NotCompletedReason7_2" value="1" /> 型番数量違い</label></li>
            <li><label for="NotCompletedReason9_2"><input type="checkbox" name="NotCompletedReason9_2" id="NotCompletedReason9_2" value="1" /> その他</label></li>
          </ul>

        </td>
      </tr>

      <tr id="Column_3">
        <td><input type="text" class="ColumnNo" name="ColumnNo3" id="ColumnNo3" value="3" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(3);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck3" id="DeleteCheck3" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('3');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(3);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode3" id="ProductCode3" value="MR-FA75KBN" maxlength="20" onchange="estimateSystemProductSearch(3);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck3" id="OutletCheck3" value="1" onclick="estimateSystemOutletChack(3);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag3" id="FeeFlag3" value="1" /><input type="hidden" name="SuperBigFlag3" id="SuperBigFlag3" value="0" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName3" id="ProductName3" value="キーボード収納台（W750×D650mm）" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine3">Rコード <input type="text" class="ProductCode3" name="RCode3" id="RCode3" value="CHH207" maxlength="6" onchange="estimateSystemProductSearchRICOH(3);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea3">在庫：<a href="javascript: estimateSystemInventoryLayer(3);">　ﾌﾟﾚｽ/23</a><input type="hidden" id="InvW_3" value="23" /><input type="hidden" id="InvE_3" value="0" /><div class="InventoryLayer" id="InventoryLayer3"><p style="font-weight: bold;">品番：MR-FA75KBN</p><p>開発：西村俊昭(7008)　　仕入：難波プレス担当()</p><p class="layer_ttl">■ 在庫</p><table class="layer_tbl1"><tr><th>倉庫</th><th>フリー</th><th>未引当</th><th>引当済</th></tr><tr><td>14：ﾌﾟﾚｽ</td><td>23</td><td>0</td><td>0</td></tr></table><p class="big_charge">★送料が別途掛かる大物商品です。</p><p class="close_btn"><a href="javascript: estimateSystemInventoryLayerClose(3);">× 閉じる</a></p></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck3" id="OpenCheck3" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice3" id="RegularPrice3" value="46300" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice3" id="NormalPrice3" value="27965" readonly onfocus="estimateSystemCursorAdvance('normal',3);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate3" id="NormalRate3" value="60.4" readonly onfocus="estimateSystemCursorAdvance('normal',3);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate3" id="UnitRate3" value="60" maxlength="5" onchange="estimateSystemUnitPercent(3, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice3" id="UnitPrice3" value="27780" maxlength="10" onchange="estimateSystemUnitPercent(3, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity3" id="Quantity3" value="2" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(3); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice3" id="SubTotalPrice3" value="55560" readonly onfocus="estimateSystemCursorAdvance('sub',3);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime3" id="DeliveryTime3" value="在庫あり" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo3" id="Memo3" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice3">★大物商品</p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka3" id="EigyouGenka3" value="17781" readonly onfocus="estimateSystemCursorAdvance('next',3);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice3" id="MarginPrice3" value="9999" readonly onfocus="estimateSystemCursorAdvance('next',3);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice3" id="LimitPrice3" value="0" readonly onfocus="estimateSystemCursorAdvance('next',3);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal3" id="MarginTotal3" value="19998" readonly onfocus="estimateSystemCursorAdvance('next',3);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate3" id="MarginRate3" value="36" readonly onfocus="estimateSystemCursorAdvance('next',3);" />%</p>
        </td>
        <td id="MarginRank3">A </td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment3" id="PurchaseComment3" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment3" id="DevLeaderComment3" readonly></textarea><input type="hidden" name="AutoAnswerFlag3" id="AutoAnswerFlag3" value="0" /><input type="hidden" name="ImportantFlag3" id="ImportantFlag3" value="0" /></p>
        </td>
        <td class="td_project"><input type="button" class="con_btn" id="ConclusionStatusDetailBtn3" value="継続中" onclick="estimateSystemDetailConclusionChange('3');" data-conclusion /><input type="hidden" name="ConclusionStatusDetail3" id="ConclusionStatusDetail3" value="継続中" data-conclusion /></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther3" id="RivalOther3" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker3" id="RivalMaker3" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku3" id="RivalSku3" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice3" id="RivalPrice3" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice3" id="LeaderPrice3" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',3);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate3" id="LeaderRate3" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',3);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice3" id="CorrectionPrice3" value="" readonly onfocus="estimateSystemCursorAdvance('next',3);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate3" id="CorrectionRate3" value="" readonly onfocus="estimateSystemCursorAdvance('next',3);" />%</p>
        </td>
        <td class="td_project">

          <ul class="not_completed_reason">
            <li><label for="NotCompletedReason1_3"><input type="checkbox" name="NotCompletedReason1_3" id="NotCompletedReason1_3" value="1" /> 価格</label></li>
            <li><label for="NotCompletedReason2_3"><input type="checkbox" name="NotCompletedReason2_3" id="NotCompletedReason2_3" value="1" /> 納期</label></li>
            <li><label for="NotCompletedReason3_3"><input type="checkbox" name="NotCompletedReason3_3" id="NotCompletedReason3_3" value="1" /> 本体ありき</label></li>
            <li><label for="NotCompletedReason4_3"><input type="checkbox" name="NotCompletedReason4_3" id="NotCompletedReason4_3" value="1" /> 仕様あわず</label></li>
            <li><label for="NotCompletedReason5_3"><input type="checkbox" name="NotCompletedReason5_3" id="NotCompletedReason5_3" value="1" /> 販社辞退</label></li>
            <li><label for="NotCompletedReason6_3"><input type="checkbox" name="NotCompletedReason6_3" id="NotCompletedReason6_3" value="1" /> 社内競合</label></li>
            <li><label for="NotCompletedReason7_3"><input type="checkbox" name="NotCompletedReason7_3" id="NotCompletedReason7_3" value="1" /> 型番数量違い</label></li>
            <li><label for="NotCompletedReason9_3"><input type="checkbox" name="NotCompletedReason9_3" id="NotCompletedReason9_3" value="1" /> その他</label></li>
          </ul>

        </td>
      </tr>

      <tr id="Column_4">
        <td><input type="text" class="ColumnNo" name="ColumnNo4" id="ColumnNo4" value="4" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(4);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck4" id="DeleteCheck4" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('4');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(4);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode4" id="ProductCode4" value="MR-FA75NTN" maxlength="20" onchange="estimateSystemProductSearch(4);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck4" id="OutletCheck4" value="1" onclick="estimateSystemOutletChack(4);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag4" id="FeeFlag4" value="0" /><input type="hidden" name="SuperBigFlag4" id="SuperBigFlag4" value="0" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName4" id="ProductName4" value="中棚（W717×450mm）" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine4">Rコード <input type="text" class="ProductCode3" name="RCode4" id="RCode4" value="CHH208" maxlength="6" onchange="estimateSystemProductSearchRICOH(4);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea4">在庫：<a href="javascript: estimateSystemInventoryLayer(4);">　ﾌﾟﾚｽ/4</a><input type="hidden" id="InvW_4" value="4" /><input type="hidden" id="InvE_4" value="0" /><div class="InventoryLayer" id="InventoryLayer4"><p style="font-weight: bold;">品番：MR-FA75NTN</p><p>開発：西村俊昭(7008)　　仕入：難波プレス担当()</p><p class="layer_ttl">■ 在庫</p><table class="layer_tbl1"><tr><th>倉庫</th><th>フリー</th><th>未引当</th><th>引当済</th></tr><tr><td>14：ﾌﾟﾚｽ</td><td>4</td><td>0</td><td>0</td></tr></table><p class="close_btn"><a href="javascript: estimateSystemInventoryLayerClose(4);">× 閉じる</a></p></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck4" id="OpenCheck4" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice4" id="RegularPrice4" value="9400" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice4" id="NormalPrice4" value="5170" readonly onfocus="estimateSystemCursorAdvance('normal',4);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate4" id="NormalRate4" value="55.0" readonly onfocus="estimateSystemCursorAdvance('normal',4);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate4" id="UnitRate4" value="53" maxlength="5" onchange="estimateSystemUnitPercent(4, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice4" id="UnitPrice4" value="4982" maxlength="10" onchange="estimateSystemUnitPercent(4, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity4" id="Quantity4" value="2" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(4); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice4" id="SubTotalPrice4" value="9964" readonly onfocus="estimateSystemCursorAdvance('sub',4);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime4" id="DeliveryTime4" value="在庫あり" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo4" id="Memo4" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice4"></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka4" id="EigyouGenka4" value="3754" readonly onfocus="estimateSystemCursorAdvance('next',4);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice4" id="MarginPrice4" value="1228" readonly onfocus="estimateSystemCursorAdvance('next',4);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice4" id="LimitPrice4" value="0" readonly onfocus="estimateSystemCursorAdvance('next',4);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal4" id="MarginTotal4" value="2456" readonly onfocus="estimateSystemCursorAdvance('next',4);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate4" id="MarginRate4" value="24.6" readonly onfocus="estimateSystemCursorAdvance('next',4);" />%</p>
        </td>
        <td id="MarginRank4">C </td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment4" id="PurchaseComment4" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment4" id="DevLeaderComment4" readonly></textarea><input type="hidden" name="AutoAnswerFlag4" id="AutoAnswerFlag4" value="0" /><input type="hidden" name="ImportantFlag4" id="ImportantFlag4" value="0" /></p>
        </td>
        <td class="td_project"><input type="button" class="con_btn" id="ConclusionStatusDetailBtn4" value="継続中" onclick="estimateSystemDetailConclusionChange('4');" data-conclusion /><input type="hidden" name="ConclusionStatusDetail4" id="ConclusionStatusDetail4" value="継続中" data-conclusion /></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther4" id="RivalOther4" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker4" id="RivalMaker4" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku4" id="RivalSku4" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice4" id="RivalPrice4" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice4" id="LeaderPrice4" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',4);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate4" id="LeaderRate4" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',4);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice4" id="CorrectionPrice4" value="" readonly onfocus="estimateSystemCursorAdvance('next',4);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate4" id="CorrectionRate4" value="" readonly onfocus="estimateSystemCursorAdvance('next',4);" />%</p>
        </td>
        <td class="td_project">

          <ul class="not_completed_reason">
            <li><label for="NotCompletedReason1_4"><input type="checkbox" name="NotCompletedReason1_4" id="NotCompletedReason1_4" value="1" /> 価格</label></li>
            <li><label for="NotCompletedReason2_4"><input type="checkbox" name="NotCompletedReason2_4" id="NotCompletedReason2_4" value="1" /> 納期</label></li>
            <li><label for="NotCompletedReason3_4"><input type="checkbox" name="NotCompletedReason3_4" id="NotCompletedReason3_4" value="1" /> 本体ありき</label></li>
            <li><label for="NotCompletedReason4_4"><input type="checkbox" name="NotCompletedReason4_4" id="NotCompletedReason4_4" value="1" /> 仕様あわず</label></li>
            <li><label for="NotCompletedReason5_4"><input type="checkbox" name="NotCompletedReason5_4" id="NotCompletedReason5_4" value="1" /> 販社辞退</label></li>
            <li><label for="NotCompletedReason6_4"><input type="checkbox" name="NotCompletedReason6_4" id="NotCompletedReason6_4" value="1" /> 社内競合</label></li>
            <li><label for="NotCompletedReason7_4"><input type="checkbox" name="NotCompletedReason7_4" id="NotCompletedReason7_4" value="1" /> 型番数量違い</label></li>
            <li><label for="NotCompletedReason9_4"><input type="checkbox" name="NotCompletedReason9_4" id="NotCompletedReason9_4" value="1" /> その他</label></li>
          </ul>

        </td>
      </tr>

      <tr id="Column_5">
        <td><input type="text" class="ColumnNo" name="ColumnNo5" id="ColumnNo5" value="5" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(5);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck5" id="DeleteCheck5" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('5');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(5);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode5" id="ProductCode5" value="" maxlength="20" onchange="estimateSystemProductSearch(5);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck5" id="OutletCheck5" value="1" onclick="estimateSystemOutletChack(5);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag5" id="FeeFlag5" value="" /><input type="hidden" name="SuperBigFlag5" id="SuperBigFlag5" value="" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName5" id="ProductName5" value="" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine5">Rコード <input type="text" class="ProductCode3" name="RCode5" id="RCode5" value="" maxlength="6" onchange="estimateSystemProductSearchRICOH(5);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea5"><div class="InventoryLayer" id="InventoryLayer5"></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck5" id="OpenCheck5" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice5" id="RegularPrice5" value="" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice5" id="NormalPrice5" value="" readonly onfocus="estimateSystemCursorAdvance('normal',5);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate5" id="NormalRate5" value="" readonly onfocus="estimateSystemCursorAdvance('normal',5);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate5" id="UnitRate5" value="" maxlength="5" onchange="estimateSystemUnitPercent(5, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice5" id="UnitPrice5" value="" maxlength="10" onchange="estimateSystemUnitPercent(5, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity5" id="Quantity5" value="" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(5); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice5" id="SubTotalPrice5" value="" readonly onfocus="estimateSystemCursorAdvance('sub',5);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime5" id="DeliveryTime5" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo5" id="Memo5" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice5"></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka5" id="EigyouGenka5" value="" readonly onfocus="estimateSystemCursorAdvance('next',5);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice5" id="MarginPrice5" value="" readonly onfocus="estimateSystemCursorAdvance('next',5);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice5" id="LimitPrice5" value="" readonly onfocus="estimateSystemCursorAdvance('next',5);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal5" id="MarginTotal5" value="" readonly onfocus="estimateSystemCursorAdvance('next',5);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate5" id="MarginRate5" value="" readonly onfocus="estimateSystemCursorAdvance('next',5);" />%</p>
        </td>
        <td id="MarginRank5"></td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment5" id="PurchaseComment5" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment5" id="DevLeaderComment5" readonly></textarea><input type="hidden" name="AutoAnswerFlag5" id="AutoAnswerFlag5" value="" /><input type="hidden" name="ImportantFlag5" id="ImportantFlag5" value="" /></p>
        </td>
        <td class="td_project"></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther5" id="RivalOther5" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker5" id="RivalMaker5" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku5" id="RivalSku5" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice5" id="RivalPrice5" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice5" id="LeaderPrice5" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',5);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate5" id="LeaderRate5" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',5);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice5" id="CorrectionPrice5" value="" readonly onfocus="estimateSystemCursorAdvance('next',5);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate5" id="CorrectionRate5" value="" readonly onfocus="estimateSystemCursorAdvance('next',5);" />%</p>
        </td>
        <td class="td_project">

        </td>
      </tr>

      <tr id="Column_6">
        <td><input type="text" class="ColumnNo" name="ColumnNo6" id="ColumnNo6" value="6" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(6);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck6" id="DeleteCheck6" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('6');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(6);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode6" id="ProductCode6" value="" maxlength="20" onchange="estimateSystemProductSearch(6);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck6" id="OutletCheck6" value="1" onclick="estimateSystemOutletChack(6);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag6" id="FeeFlag6" value="" /><input type="hidden" name="SuperBigFlag6" id="SuperBigFlag6" value="" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName6" id="ProductName6" value="" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine6">Rコード <input type="text" class="ProductCode3" name="RCode6" id="RCode6" value="" maxlength="6" onchange="estimateSystemProductSearchRICOH(6);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea6"><div class="InventoryLayer" id="InventoryLayer6"></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck6" id="OpenCheck6" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice6" id="RegularPrice6" value="" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice6" id="NormalPrice6" value="" readonly onfocus="estimateSystemCursorAdvance('normal',6);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate6" id="NormalRate6" value="" readonly onfocus="estimateSystemCursorAdvance('normal',6);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate6" id="UnitRate6" value="" maxlength="5" onchange="estimateSystemUnitPercent(6, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice6" id="UnitPrice6" value="" maxlength="10" onchange="estimateSystemUnitPercent(6, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity6" id="Quantity6" value="" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(6); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice6" id="SubTotalPrice6" value="" readonly onfocus="estimateSystemCursorAdvance('sub',6);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime6" id="DeliveryTime6" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo6" id="Memo6" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice6"></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka6" id="EigyouGenka6" value="" readonly onfocus="estimateSystemCursorAdvance('next',6);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice6" id="MarginPrice6" value="" readonly onfocus="estimateSystemCursorAdvance('next',6);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice6" id="LimitPrice6" value="" readonly onfocus="estimateSystemCursorAdvance('next',6);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal6" id="MarginTotal6" value="" readonly onfocus="estimateSystemCursorAdvance('next',6);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate6" id="MarginRate6" value="" readonly onfocus="estimateSystemCursorAdvance('next',6);" />%</p>
        </td>
        <td id="MarginRank6"></td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment6" id="PurchaseComment6" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment6" id="DevLeaderComment6" readonly></textarea><input type="hidden" name="AutoAnswerFlag6" id="AutoAnswerFlag6" value="" /><input type="hidden" name="ImportantFlag6" id="ImportantFlag6" value="" /></p>
        </td>
        <td class="td_project"></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther6" id="RivalOther6" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker6" id="RivalMaker6" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku6" id="RivalSku6" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice6" id="RivalPrice6" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice6" id="LeaderPrice6" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',6);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate6" id="LeaderRate6" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',6);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice6" id="CorrectionPrice6" value="" readonly onfocus="estimateSystemCursorAdvance('next',6);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate6" id="CorrectionRate6" value="" readonly onfocus="estimateSystemCursorAdvance('next',6);" />%</p>
        </td>
        <td class="td_project">

        </td>
      </tr>

      <tr id="Column_7">
        <td><input type="text" class="ColumnNo" name="ColumnNo7" id="ColumnNo7" value="7" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(7);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck7" id="DeleteCheck7" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('7');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(7);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode7" id="ProductCode7" value="" maxlength="20" onchange="estimateSystemProductSearch(7);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck7" id="OutletCheck7" value="1" onclick="estimateSystemOutletChack(7);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag7" id="FeeFlag7" value="" /><input type="hidden" name="SuperBigFlag7" id="SuperBigFlag7" value="" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName7" id="ProductName7" value="" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine7">Rコード <input type="text" class="ProductCode3" name="RCode7" id="RCode7" value="" maxlength="6" onchange="estimateSystemProductSearchRICOH(7);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea7"><div class="InventoryLayer" id="InventoryLayer7"></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck7" id="OpenCheck7" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice7" id="RegularPrice7" value="" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice7" id="NormalPrice7" value="" readonly onfocus="estimateSystemCursorAdvance('normal',7);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate7" id="NormalRate7" value="" readonly onfocus="estimateSystemCursorAdvance('normal',7);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate7" id="UnitRate7" value="" maxlength="5" onchange="estimateSystemUnitPercent(7, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice7" id="UnitPrice7" value="" maxlength="10" onchange="estimateSystemUnitPercent(7, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity7" id="Quantity7" value="" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(7); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice7" id="SubTotalPrice7" value="" readonly onfocus="estimateSystemCursorAdvance('sub',7);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime7" id="DeliveryTime7" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo7" id="Memo7" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice7"></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka7" id="EigyouGenka7" value="" readonly onfocus="estimateSystemCursorAdvance('next',7);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice7" id="MarginPrice7" value="" readonly onfocus="estimateSystemCursorAdvance('next',7);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice7" id="LimitPrice7" value="" readonly onfocus="estimateSystemCursorAdvance('next',7);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal7" id="MarginTotal7" value="" readonly onfocus="estimateSystemCursorAdvance('next',7);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate7" id="MarginRate7" value="" readonly onfocus="estimateSystemCursorAdvance('next',7);" />%</p>
        </td>
        <td id="MarginRank7"></td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment7" id="PurchaseComment7" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment7" id="DevLeaderComment7" readonly></textarea><input type="hidden" name="AutoAnswerFlag7" id="AutoAnswerFlag7" value="" /><input type="hidden" name="ImportantFlag7" id="ImportantFlag7" value="" /></p>
        </td>
        <td class="td_project"></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther7" id="RivalOther7" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker7" id="RivalMaker7" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku7" id="RivalSku7" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice7" id="RivalPrice7" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice7" id="LeaderPrice7" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',7);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate7" id="LeaderRate7" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',7);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice7" id="CorrectionPrice7" value="" readonly onfocus="estimateSystemCursorAdvance('next',7);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate7" id="CorrectionRate7" value="" readonly onfocus="estimateSystemCursorAdvance('next',7);" />%</p>
        </td>
        <td class="td_project">

        </td>
      </tr>

      <tr id="Column_8">
        <td><input type="text" class="ColumnNo" name="ColumnNo8" id="ColumnNo8" value="8" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(8);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck8" id="DeleteCheck8" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('8');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(8);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode8" id="ProductCode8" value="" maxlength="20" onchange="estimateSystemProductSearch(8);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck8" id="OutletCheck8" value="1" onclick="estimateSystemOutletChack(8);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag8" id="FeeFlag8" value="" /><input type="hidden" name="SuperBigFlag8" id="SuperBigFlag8" value="" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName8" id="ProductName8" value="" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine8">Rコード <input type="text" class="ProductCode3" name="RCode8" id="RCode8" value="" maxlength="6" onchange="estimateSystemProductSearchRICOH(8);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea8"><div class="InventoryLayer" id="InventoryLayer8"></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck8" id="OpenCheck8" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice8" id="RegularPrice8" value="" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice8" id="NormalPrice8" value="" readonly onfocus="estimateSystemCursorAdvance('normal',8);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate8" id="NormalRate8" value="" readonly onfocus="estimateSystemCursorAdvance('normal',8);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate8" id="UnitRate8" value="" maxlength="5" onchange="estimateSystemUnitPercent(8, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice8" id="UnitPrice8" value="" maxlength="10" onchange="estimateSystemUnitPercent(8, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity8" id="Quantity8" value="" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(8); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice8" id="SubTotalPrice8" value="" readonly onfocus="estimateSystemCursorAdvance('sub',8);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime8" id="DeliveryTime8" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo8" id="Memo8" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice8"></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka8" id="EigyouGenka8" value="" readonly onfocus="estimateSystemCursorAdvance('next',8);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice8" id="MarginPrice8" value="" readonly onfocus="estimateSystemCursorAdvance('next',8);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice8" id="LimitPrice8" value="" readonly onfocus="estimateSystemCursorAdvance('next',8);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal8" id="MarginTotal8" value="" readonly onfocus="estimateSystemCursorAdvance('next',8);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate8" id="MarginRate8" value="" readonly onfocus="estimateSystemCursorAdvance('next',8);" />%</p>
        </td>
        <td id="MarginRank8"></td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment8" id="PurchaseComment8" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment8" id="DevLeaderComment8" readonly></textarea><input type="hidden" name="AutoAnswerFlag8" id="AutoAnswerFlag8" value="" /><input type="hidden" name="ImportantFlag8" id="ImportantFlag8" value="" /></p>
        </td>
        <td class="td_project"></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther8" id="RivalOther8" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker8" id="RivalMaker8" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku8" id="RivalSku8" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice8" id="RivalPrice8" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice8" id="LeaderPrice8" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',8);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate8" id="LeaderRate8" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',8);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice8" id="CorrectionPrice8" value="" readonly onfocus="estimateSystemCursorAdvance('next',8);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate8" id="CorrectionRate8" value="" readonly onfocus="estimateSystemCursorAdvance('next',8);" />%</p>
        </td>
        <td class="td_project">

        </td>
      </tr>

      <tr id="Column_9">
        <td><input type="text" class="ColumnNo" name="ColumnNo9" id="ColumnNo9" value="9" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(9);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck9" id="DeleteCheck9" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('9');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(9);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode9" id="ProductCode9" value="" maxlength="20" onchange="estimateSystemProductSearch(9);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck9" id="OutletCheck9" value="1" onclick="estimateSystemOutletChack(9);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag9" id="FeeFlag9" value="" /><input type="hidden" name="SuperBigFlag9" id="SuperBigFlag9" value="" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName9" id="ProductName9" value="" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine9">Rコード <input type="text" class="ProductCode3" name="RCode9" id="RCode9" value="" maxlength="6" onchange="estimateSystemProductSearchRICOH(9);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea9"><div class="InventoryLayer" id="InventoryLayer9"></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck9" id="OpenCheck9" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice9" id="RegularPrice9" value="" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice9" id="NormalPrice9" value="" readonly onfocus="estimateSystemCursorAdvance('normal',9);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate9" id="NormalRate9" value="" readonly onfocus="estimateSystemCursorAdvance('normal',9);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate9" id="UnitRate9" value="" maxlength="5" onchange="estimateSystemUnitPercent(9, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice9" id="UnitPrice9" value="" maxlength="10" onchange="estimateSystemUnitPercent(9, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity9" id="Quantity9" value="" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(9); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice9" id="SubTotalPrice9" value="" readonly onfocus="estimateSystemCursorAdvance('sub',9);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime9" id="DeliveryTime9" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo9" id="Memo9" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice9"></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka9" id="EigyouGenka9" value="" readonly onfocus="estimateSystemCursorAdvance('next',9);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice9" id="MarginPrice9" value="" readonly onfocus="estimateSystemCursorAdvance('next',9);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice9" id="LimitPrice9" value="" readonly onfocus="estimateSystemCursorAdvance('next',9);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal9" id="MarginTotal9" value="" readonly onfocus="estimateSystemCursorAdvance('next',9);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate9" id="MarginRate9" value="" readonly onfocus="estimateSystemCursorAdvance('next',9);" />%</p>
        </td>
        <td id="MarginRank9"></td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment9" id="PurchaseComment9" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment9" id="DevLeaderComment9" readonly></textarea><input type="hidden" name="AutoAnswerFlag9" id="AutoAnswerFlag9" value="" /><input type="hidden" name="ImportantFlag9" id="ImportantFlag9" value="" /></p>
        </td>
        <td class="td_project"></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther9" id="RivalOther9" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker9" id="RivalMaker9" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku9" id="RivalSku9" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice9" id="RivalPrice9" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice9" id="LeaderPrice9" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',9);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate9" id="LeaderRate9" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',9);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice9" id="CorrectionPrice9" value="" readonly onfocus="estimateSystemCursorAdvance('next',9);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate9" id="CorrectionRate9" value="" readonly onfocus="estimateSystemCursorAdvance('next',9);" />%</p>
        </td>
        <td class="td_project">

        </td>
      </tr>

      <tr id="Column_10">
        <td><input type="text" class="ColumnNo" name="ColumnNo10" id="ColumnNo10" value="10" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(10);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck10" id="DeleteCheck10" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('10');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(10);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode10" id="ProductCode10" value="" maxlength="20" onchange="estimateSystemProductSearch(10);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck10" id="OutletCheck10" value="1" onclick="estimateSystemOutletChack(10);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag10" id="FeeFlag10" value="" /><input type="hidden" name="SuperBigFlag10" id="SuperBigFlag10" value="" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName10" id="ProductName10" value="" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine10">Rコード <input type="text" class="ProductCode3" name="RCode10" id="RCode10" value="" maxlength="6" onchange="estimateSystemProductSearchRICOH(10);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea10"><div class="InventoryLayer" id="InventoryLayer10"></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck10" id="OpenCheck10" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice10" id="RegularPrice10" value="" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice10" id="NormalPrice10" value="" readonly onfocus="estimateSystemCursorAdvance('normal',10);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate10" id="NormalRate10" value="" readonly onfocus="estimateSystemCursorAdvance('normal',10);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate10" id="UnitRate10" value="" maxlength="5" onchange="estimateSystemUnitPercent(10, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice10" id="UnitPrice10" value="" maxlength="10" onchange="estimateSystemUnitPercent(10, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity10" id="Quantity10" value="" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(10); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice10" id="SubTotalPrice10" value="" readonly onfocus="estimateSystemCursorAdvance('sub',10);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime10" id="DeliveryTime10" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo10" id="Memo10" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice10"></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka10" id="EigyouGenka10" value="" readonly onfocus="estimateSystemCursorAdvance('next',10);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice10" id="MarginPrice10" value="" readonly onfocus="estimateSystemCursorAdvance('next',10);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice10" id="LimitPrice10" value="" readonly onfocus="estimateSystemCursorAdvance('next',10);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal10" id="MarginTotal10" value="" readonly onfocus="estimateSystemCursorAdvance('next',10);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate10" id="MarginRate10" value="" readonly onfocus="estimateSystemCursorAdvance('next',10);" />%</p>
        </td>
        <td id="MarginRank10"></td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment10" id="PurchaseComment10" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment10" id="DevLeaderComment10" readonly></textarea><input type="hidden" name="AutoAnswerFlag10" id="AutoAnswerFlag10" value="" /><input type="hidden" name="ImportantFlag10" id="ImportantFlag10" value="" /></p>
        </td>
        <td class="td_project"></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther10" id="RivalOther10" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker10" id="RivalMaker10" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku10" id="RivalSku10" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice10" id="RivalPrice10" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice10" id="LeaderPrice10" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',10);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate10" id="LeaderRate10" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',10);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice10" id="CorrectionPrice10" value="" readonly onfocus="estimateSystemCursorAdvance('next',10);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate10" id="CorrectionRate10" value="" readonly onfocus="estimateSystemCursorAdvance('next',10);" />%</p>
        </td>
        <td class="td_project">

        </td>
      </tr>

      <tr id="Column_11">
        <td><input type="text" class="ColumnNo" name="ColumnNo11" id="ColumnNo11" value="11" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(11);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck11" id="DeleteCheck11" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('11');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(11);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode11" id="ProductCode11" value="" maxlength="20" onchange="estimateSystemProductSearch(11);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck11" id="OutletCheck11" value="1" onclick="estimateSystemOutletChack(11);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag11" id="FeeFlag11" value="" /><input type="hidden" name="SuperBigFlag11" id="SuperBigFlag11" value="" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName11" id="ProductName11" value="" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine11">Rコード <input type="text" class="ProductCode3" name="RCode11" id="RCode11" value="" maxlength="6" onchange="estimateSystemProductSearchRICOH(11);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea11"><div class="InventoryLayer" id="InventoryLayer11"></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck11" id="OpenCheck11" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice11" id="RegularPrice11" value="" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice11" id="NormalPrice11" value="" readonly onfocus="estimateSystemCursorAdvance('normal',11);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate11" id="NormalRate11" value="" readonly onfocus="estimateSystemCursorAdvance('normal',11);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate11" id="UnitRate11" value="" maxlength="5" onchange="estimateSystemUnitPercent(11, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice11" id="UnitPrice11" value="" maxlength="10" onchange="estimateSystemUnitPercent(11, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity11" id="Quantity11" value="" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(11); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice11" id="SubTotalPrice11" value="" readonly onfocus="estimateSystemCursorAdvance('sub',11);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime11" id="DeliveryTime11" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo11" id="Memo11" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice11"></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka11" id="EigyouGenka11" value="" readonly onfocus="estimateSystemCursorAdvance('next',11);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice11" id="MarginPrice11" value="" readonly onfocus="estimateSystemCursorAdvance('next',11);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice11" id="LimitPrice11" value="" readonly onfocus="estimateSystemCursorAdvance('next',11);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal11" id="MarginTotal11" value="" readonly onfocus="estimateSystemCursorAdvance('next',11);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate11" id="MarginRate11" value="" readonly onfocus="estimateSystemCursorAdvance('next',11);" />%</p>
        </td>
        <td id="MarginRank11"></td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment11" id="PurchaseComment11" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment11" id="DevLeaderComment11" readonly></textarea><input type="hidden" name="AutoAnswerFlag11" id="AutoAnswerFlag11" value="" /><input type="hidden" name="ImportantFlag11" id="ImportantFlag11" value="" /></p>
        </td>
        <td class="td_project"></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther11" id="RivalOther11" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker11" id="RivalMaker11" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku11" id="RivalSku11" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice11" id="RivalPrice11" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice11" id="LeaderPrice11" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',11);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate11" id="LeaderRate11" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',11);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice11" id="CorrectionPrice11" value="" readonly onfocus="estimateSystemCursorAdvance('next',11);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate11" id="CorrectionRate11" value="" readonly onfocus="estimateSystemCursorAdvance('next',11);" />%</p>
        </td>
        <td class="td_project">

        </td>
      </tr>

      <tr id="Column_12">
        <td><input type="text" class="ColumnNo" name="ColumnNo12" id="ColumnNo12" value="12" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(12);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck12" id="DeleteCheck12" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('12');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(12);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode12" id="ProductCode12" value="" maxlength="20" onchange="estimateSystemProductSearch(12);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck12" id="OutletCheck12" value="1" onclick="estimateSystemOutletChack(12);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag12" id="FeeFlag12" value="" /><input type="hidden" name="SuperBigFlag12" id="SuperBigFlag12" value="" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName12" id="ProductName12" value="" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine12">Rコード <input type="text" class="ProductCode3" name="RCode12" id="RCode12" value="" maxlength="6" onchange="estimateSystemProductSearchRICOH(12);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea12"><div class="InventoryLayer" id="InventoryLayer12"></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck12" id="OpenCheck12" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice12" id="RegularPrice12" value="" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice12" id="NormalPrice12" value="" readonly onfocus="estimateSystemCursorAdvance('normal',12);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate12" id="NormalRate12" value="" readonly onfocus="estimateSystemCursorAdvance('normal',12);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate12" id="UnitRate12" value="" maxlength="5" onchange="estimateSystemUnitPercent(12, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice12" id="UnitPrice12" value="" maxlength="10" onchange="estimateSystemUnitPercent(12, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity12" id="Quantity12" value="" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(12); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice12" id="SubTotalPrice12" value="" readonly onfocus="estimateSystemCursorAdvance('sub',12);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime12" id="DeliveryTime12" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo12" id="Memo12" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice12"></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka12" id="EigyouGenka12" value="" readonly onfocus="estimateSystemCursorAdvance('next',12);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice12" id="MarginPrice12" value="" readonly onfocus="estimateSystemCursorAdvance('next',12);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice12" id="LimitPrice12" value="" readonly onfocus="estimateSystemCursorAdvance('next',12);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal12" id="MarginTotal12" value="" readonly onfocus="estimateSystemCursorAdvance('next',12);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate12" id="MarginRate12" value="" readonly onfocus="estimateSystemCursorAdvance('next',12);" />%</p>
        </td>
        <td id="MarginRank12"></td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment12" id="PurchaseComment12" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment12" id="DevLeaderComment12" readonly></textarea><input type="hidden" name="AutoAnswerFlag12" id="AutoAnswerFlag12" value="" /><input type="hidden" name="ImportantFlag12" id="ImportantFlag12" value="" /></p>
        </td>
        <td class="td_project"></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther12" id="RivalOther12" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker12" id="RivalMaker12" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku12" id="RivalSku12" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice12" id="RivalPrice12" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice12" id="LeaderPrice12" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',12);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate12" id="LeaderRate12" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',12);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice12" id="CorrectionPrice12" value="" readonly onfocus="estimateSystemCursorAdvance('next',12);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate12" id="CorrectionRate12" value="" readonly onfocus="estimateSystemCursorAdvance('next',12);" />%</p>
        </td>
        <td class="td_project">

        </td>
      </tr>

      <tr id="Column_13">
        <td><input type="text" class="ColumnNo" name="ColumnNo13" id="ColumnNo13" value="13" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(13);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck13" id="DeleteCheck13" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('13');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(13);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode13" id="ProductCode13" value="" maxlength="20" onchange="estimateSystemProductSearch(13);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck13" id="OutletCheck13" value="1" onclick="estimateSystemOutletChack(13);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag13" id="FeeFlag13" value="" /><input type="hidden" name="SuperBigFlag13" id="SuperBigFlag13" value="" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName13" id="ProductName13" value="" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine13">Rコード <input type="text" class="ProductCode3" name="RCode13" id="RCode13" value="" maxlength="6" onchange="estimateSystemProductSearchRICOH(13);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea13"><div class="InventoryLayer" id="InventoryLayer13"></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck13" id="OpenCheck13" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice13" id="RegularPrice13" value="" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice13" id="NormalPrice13" value="" readonly onfocus="estimateSystemCursorAdvance('normal',13);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate13" id="NormalRate13" value="" readonly onfocus="estimateSystemCursorAdvance('normal',13);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate13" id="UnitRate13" value="" maxlength="5" onchange="estimateSystemUnitPercent(13, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice13" id="UnitPrice13" value="" maxlength="10" onchange="estimateSystemUnitPercent(13, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity13" id="Quantity13" value="" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(13); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice13" id="SubTotalPrice13" value="" readonly onfocus="estimateSystemCursorAdvance('sub',13);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime13" id="DeliveryTime13" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo13" id="Memo13" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice13"></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka13" id="EigyouGenka13" value="" readonly onfocus="estimateSystemCursorAdvance('next',13);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice13" id="MarginPrice13" value="" readonly onfocus="estimateSystemCursorAdvance('next',13);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice13" id="LimitPrice13" value="" readonly onfocus="estimateSystemCursorAdvance('next',13);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal13" id="MarginTotal13" value="" readonly onfocus="estimateSystemCursorAdvance('next',13);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate13" id="MarginRate13" value="" readonly onfocus="estimateSystemCursorAdvance('next',13);" />%</p>
        </td>
        <td id="MarginRank13"></td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment13" id="PurchaseComment13" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment13" id="DevLeaderComment13" readonly></textarea><input type="hidden" name="AutoAnswerFlag13" id="AutoAnswerFlag13" value="" /><input type="hidden" name="ImportantFlag13" id="ImportantFlag13" value="" /></p>
        </td>
        <td class="td_project"></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther13" id="RivalOther13" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker13" id="RivalMaker13" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku13" id="RivalSku13" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice13" id="RivalPrice13" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice13" id="LeaderPrice13" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',13);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate13" id="LeaderRate13" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',13);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice13" id="CorrectionPrice13" value="" readonly onfocus="estimateSystemCursorAdvance('next',13);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate13" id="CorrectionRate13" value="" readonly onfocus="estimateSystemCursorAdvance('next',13);" />%</p>
        </td>
        <td class="td_project">

        </td>
      </tr>

      <tr id="Column_14">
        <td><input type="text" class="ColumnNo" name="ColumnNo14" id="ColumnNo14" value="14" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(14);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck14" id="DeleteCheck14" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('14');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(14);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode14" id="ProductCode14" value="" maxlength="20" onchange="estimateSystemProductSearch(14);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck14" id="OutletCheck14" value="1" onclick="estimateSystemOutletChack(14);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag14" id="FeeFlag14" value="" /><input type="hidden" name="SuperBigFlag14" id="SuperBigFlag14" value="" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName14" id="ProductName14" value="" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine14">Rコード <input type="text" class="ProductCode3" name="RCode14" id="RCode14" value="" maxlength="6" onchange="estimateSystemProductSearchRICOH(14);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea14"><div class="InventoryLayer" id="InventoryLayer14"></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck14" id="OpenCheck14" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice14" id="RegularPrice14" value="" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice14" id="NormalPrice14" value="" readonly onfocus="estimateSystemCursorAdvance('normal',14);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate14" id="NormalRate14" value="" readonly onfocus="estimateSystemCursorAdvance('normal',14);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate14" id="UnitRate14" value="" maxlength="5" onchange="estimateSystemUnitPercent(14, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice14" id="UnitPrice14" value="" maxlength="10" onchange="estimateSystemUnitPercent(14, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity14" id="Quantity14" value="" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(14); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice14" id="SubTotalPrice14" value="" readonly onfocus="estimateSystemCursorAdvance('sub',14);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime14" id="DeliveryTime14" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo14" id="Memo14" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice14"></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka14" id="EigyouGenka14" value="" readonly onfocus="estimateSystemCursorAdvance('next',14);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice14" id="MarginPrice14" value="" readonly onfocus="estimateSystemCursorAdvance('next',14);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice14" id="LimitPrice14" value="" readonly onfocus="estimateSystemCursorAdvance('next',14);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal14" id="MarginTotal14" value="" readonly onfocus="estimateSystemCursorAdvance('next',14);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate14" id="MarginRate14" value="" readonly onfocus="estimateSystemCursorAdvance('next',14);" />%</p>
        </td>
        <td id="MarginRank14"></td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment14" id="PurchaseComment14" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment14" id="DevLeaderComment14" readonly></textarea><input type="hidden" name="AutoAnswerFlag14" id="AutoAnswerFlag14" value="" /><input type="hidden" name="ImportantFlag14" id="ImportantFlag14" value="" /></p>
        </td>
        <td class="td_project"></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther14" id="RivalOther14" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker14" id="RivalMaker14" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku14" id="RivalSku14" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice14" id="RivalPrice14" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice14" id="LeaderPrice14" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',14);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate14" id="LeaderRate14" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',14);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice14" id="CorrectionPrice14" value="" readonly onfocus="estimateSystemCursorAdvance('next',14);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate14" id="CorrectionRate14" value="" readonly onfocus="estimateSystemCursorAdvance('next',14);" />%</p>
        </td>
        <td class="td_project">

        </td>
      </tr>

      <tr id="Column_15">
        <td><input type="text" class="ColumnNo" name="ColumnNo15" id="ColumnNo15" value="15" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(15);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck15" id="DeleteCheck15" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('15');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(15);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode15" id="ProductCode15" value="" maxlength="20" onchange="estimateSystemProductSearch(15);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck15" id="OutletCheck15" value="1" onclick="estimateSystemOutletChack(15);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag15" id="FeeFlag15" value="" /><input type="hidden" name="SuperBigFlag15" id="SuperBigFlag15" value="" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName15" id="ProductName15" value="" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine15">Rコード <input type="text" class="ProductCode3" name="RCode15" id="RCode15" value="" maxlength="6" onchange="estimateSystemProductSearchRICOH(15);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea15"><div class="InventoryLayer" id="InventoryLayer15"></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck15" id="OpenCheck15" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice15" id="RegularPrice15" value="" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice15" id="NormalPrice15" value="" readonly onfocus="estimateSystemCursorAdvance('normal',15);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate15" id="NormalRate15" value="" readonly onfocus="estimateSystemCursorAdvance('normal',15);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate15" id="UnitRate15" value="" maxlength="5" onchange="estimateSystemUnitPercent(15, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice15" id="UnitPrice15" value="" maxlength="10" onchange="estimateSystemUnitPercent(15, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity15" id="Quantity15" value="" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(15); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice15" id="SubTotalPrice15" value="" readonly onfocus="estimateSystemCursorAdvance('sub',15);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime15" id="DeliveryTime15" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo15" id="Memo15" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice15"></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka15" id="EigyouGenka15" value="" readonly onfocus="estimateSystemCursorAdvance('next',15);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice15" id="MarginPrice15" value="" readonly onfocus="estimateSystemCursorAdvance('next',15);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice15" id="LimitPrice15" value="" readonly onfocus="estimateSystemCursorAdvance('next',15);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal15" id="MarginTotal15" value="" readonly onfocus="estimateSystemCursorAdvance('next',15);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate15" id="MarginRate15" value="" readonly onfocus="estimateSystemCursorAdvance('next',15);" />%</p>
        </td>
        <td id="MarginRank15"></td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment15" id="PurchaseComment15" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment15" id="DevLeaderComment15" readonly></textarea><input type="hidden" name="AutoAnswerFlag15" id="AutoAnswerFlag15" value="" /><input type="hidden" name="ImportantFlag15" id="ImportantFlag15" value="" /></p>
        </td>
        <td class="td_project"></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther15" id="RivalOther15" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker15" id="RivalMaker15" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku15" id="RivalSku15" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice15" id="RivalPrice15" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice15" id="LeaderPrice15" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',15);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate15" id="LeaderRate15" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',15);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice15" id="CorrectionPrice15" value="" readonly onfocus="estimateSystemCursorAdvance('next',15);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate15" id="CorrectionRate15" value="" readonly onfocus="estimateSystemCursorAdvance('next',15);" />%</p>
        </td>
        <td class="td_project">

        </td>
      </tr>

      <tr id="Column_16">
        <td><input type="text" class="ColumnNo" name="ColumnNo16" id="ColumnNo16" value="16" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(16);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck16" id="DeleteCheck16" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('16');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(16);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode16" id="ProductCode16" value="" maxlength="20" onchange="estimateSystemProductSearch(16);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck16" id="OutletCheck16" value="1" onclick="estimateSystemOutletChack(16);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag16" id="FeeFlag16" value="" /><input type="hidden" name="SuperBigFlag16" id="SuperBigFlag16" value="" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName16" id="ProductName16" value="" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine16">Rコード <input type="text" class="ProductCode3" name="RCode16" id="RCode16" value="" maxlength="6" onchange="estimateSystemProductSearchRICOH(16);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea16"><div class="InventoryLayer" id="InventoryLayer16"></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck16" id="OpenCheck16" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice16" id="RegularPrice16" value="" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice16" id="NormalPrice16" value="" readonly onfocus="estimateSystemCursorAdvance('normal',16);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate16" id="NormalRate16" value="" readonly onfocus="estimateSystemCursorAdvance('normal',16);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate16" id="UnitRate16" value="" maxlength="5" onchange="estimateSystemUnitPercent(16, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice16" id="UnitPrice16" value="" maxlength="10" onchange="estimateSystemUnitPercent(16, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity16" id="Quantity16" value="" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(16); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice16" id="SubTotalPrice16" value="" readonly onfocus="estimateSystemCursorAdvance('sub',16);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime16" id="DeliveryTime16" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo16" id="Memo16" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice16"></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka16" id="EigyouGenka16" value="" readonly onfocus="estimateSystemCursorAdvance('next',16);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice16" id="MarginPrice16" value="" readonly onfocus="estimateSystemCursorAdvance('next',16);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice16" id="LimitPrice16" value="" readonly onfocus="estimateSystemCursorAdvance('next',16);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal16" id="MarginTotal16" value="" readonly onfocus="estimateSystemCursorAdvance('next',16);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate16" id="MarginRate16" value="" readonly onfocus="estimateSystemCursorAdvance('next',16);" />%</p>
        </td>
        <td id="MarginRank16"></td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment16" id="PurchaseComment16" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment16" id="DevLeaderComment16" readonly></textarea><input type="hidden" name="AutoAnswerFlag16" id="AutoAnswerFlag16" value="" /><input type="hidden" name="ImportantFlag16" id="ImportantFlag16" value="" /></p>
        </td>
        <td class="td_project"></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther16" id="RivalOther16" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker16" id="RivalMaker16" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku16" id="RivalSku16" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice16" id="RivalPrice16" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice16" id="LeaderPrice16" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',16);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate16" id="LeaderRate16" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',16);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice16" id="CorrectionPrice16" value="" readonly onfocus="estimateSystemCursorAdvance('next',16);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate16" id="CorrectionRate16" value="" readonly onfocus="estimateSystemCursorAdvance('next',16);" />%</p>
        </td>
        <td class="td_project">

        </td>
      </tr>

      <tr id="Column_17">
        <td><input type="text" class="ColumnNo" name="ColumnNo17" id="ColumnNo17" value="17" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(17);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck17" id="DeleteCheck17" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('17');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(17);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode17" id="ProductCode17" value="" maxlength="20" onchange="estimateSystemProductSearch(17);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck17" id="OutletCheck17" value="1" onclick="estimateSystemOutletChack(17);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag17" id="FeeFlag17" value="" /><input type="hidden" name="SuperBigFlag17" id="SuperBigFlag17" value="" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName17" id="ProductName17" value="" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine17">Rコード <input type="text" class="ProductCode3" name="RCode17" id="RCode17" value="" maxlength="6" onchange="estimateSystemProductSearchRICOH(17);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea17"><div class="InventoryLayer" id="InventoryLayer17"></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck17" id="OpenCheck17" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice17" id="RegularPrice17" value="" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice17" id="NormalPrice17" value="" readonly onfocus="estimateSystemCursorAdvance('normal',17);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate17" id="NormalRate17" value="" readonly onfocus="estimateSystemCursorAdvance('normal',17);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate17" id="UnitRate17" value="" maxlength="5" onchange="estimateSystemUnitPercent(17, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice17" id="UnitPrice17" value="" maxlength="10" onchange="estimateSystemUnitPercent(17, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity17" id="Quantity17" value="" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(17); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice17" id="SubTotalPrice17" value="" readonly onfocus="estimateSystemCursorAdvance('sub',17);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime17" id="DeliveryTime17" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo17" id="Memo17" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice17"></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka17" id="EigyouGenka17" value="" readonly onfocus="estimateSystemCursorAdvance('next',17);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice17" id="MarginPrice17" value="" readonly onfocus="estimateSystemCursorAdvance('next',17);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice17" id="LimitPrice17" value="" readonly onfocus="estimateSystemCursorAdvance('next',17);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal17" id="MarginTotal17" value="" readonly onfocus="estimateSystemCursorAdvance('next',17);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate17" id="MarginRate17" value="" readonly onfocus="estimateSystemCursorAdvance('next',17);" />%</p>
        </td>
        <td id="MarginRank17"></td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment17" id="PurchaseComment17" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment17" id="DevLeaderComment17" readonly></textarea><input type="hidden" name="AutoAnswerFlag17" id="AutoAnswerFlag17" value="" /><input type="hidden" name="ImportantFlag17" id="ImportantFlag17" value="" /></p>
        </td>
        <td class="td_project"></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther17" id="RivalOther17" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker17" id="RivalMaker17" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku17" id="RivalSku17" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice17" id="RivalPrice17" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice17" id="LeaderPrice17" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',17);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate17" id="LeaderRate17" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',17);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice17" id="CorrectionPrice17" value="" readonly onfocus="estimateSystemCursorAdvance('next',17);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate17" id="CorrectionRate17" value="" readonly onfocus="estimateSystemCursorAdvance('next',17);" />%</p>
        </td>
        <td class="td_project">

        </td>
      </tr>

      <tr id="Column_18">
        <td><input type="text" class="ColumnNo" name="ColumnNo18" id="ColumnNo18" value="18" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(18);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck18" id="DeleteCheck18" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('18');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(18);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode18" id="ProductCode18" value="" maxlength="20" onchange="estimateSystemProductSearch(18);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck18" id="OutletCheck18" value="1" onclick="estimateSystemOutletChack(18);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag18" id="FeeFlag18" value="" /><input type="hidden" name="SuperBigFlag18" id="SuperBigFlag18" value="" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName18" id="ProductName18" value="" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine18">Rコード <input type="text" class="ProductCode3" name="RCode18" id="RCode18" value="" maxlength="6" onchange="estimateSystemProductSearchRICOH(18);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea18"><div class="InventoryLayer" id="InventoryLayer18"></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck18" id="OpenCheck18" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice18" id="RegularPrice18" value="" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice18" id="NormalPrice18" value="" readonly onfocus="estimateSystemCursorAdvance('normal',18);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate18" id="NormalRate18" value="" readonly onfocus="estimateSystemCursorAdvance('normal',18);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate18" id="UnitRate18" value="" maxlength="5" onchange="estimateSystemUnitPercent(18, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice18" id="UnitPrice18" value="" maxlength="10" onchange="estimateSystemUnitPercent(18, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity18" id="Quantity18" value="" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(18); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice18" id="SubTotalPrice18" value="" readonly onfocus="estimateSystemCursorAdvance('sub',18);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime18" id="DeliveryTime18" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo18" id="Memo18" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice18"></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka18" id="EigyouGenka18" value="" readonly onfocus="estimateSystemCursorAdvance('next',18);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice18" id="MarginPrice18" value="" readonly onfocus="estimateSystemCursorAdvance('next',18);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice18" id="LimitPrice18" value="" readonly onfocus="estimateSystemCursorAdvance('next',18);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal18" id="MarginTotal18" value="" readonly onfocus="estimateSystemCursorAdvance('next',18);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate18" id="MarginRate18" value="" readonly onfocus="estimateSystemCursorAdvance('next',18);" />%</p>
        </td>
        <td id="MarginRank18"></td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment18" id="PurchaseComment18" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment18" id="DevLeaderComment18" readonly></textarea><input type="hidden" name="AutoAnswerFlag18" id="AutoAnswerFlag18" value="" /><input type="hidden" name="ImportantFlag18" id="ImportantFlag18" value="" /></p>
        </td>
        <td class="td_project"></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther18" id="RivalOther18" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker18" id="RivalMaker18" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku18" id="RivalSku18" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice18" id="RivalPrice18" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice18" id="LeaderPrice18" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',18);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate18" id="LeaderRate18" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',18);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice18" id="CorrectionPrice18" value="" readonly onfocus="estimateSystemCursorAdvance('next',18);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate18" id="CorrectionRate18" value="" readonly onfocus="estimateSystemCursorAdvance('next',18);" />%</p>
        </td>
        <td class="td_project">

        </td>
      </tr>

      <tr id="Column_19">
        <td><input type="text" class="ColumnNo" name="ColumnNo19" id="ColumnNo19" value="19" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(19);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck19" id="DeleteCheck19" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('19');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(19);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode19" id="ProductCode19" value="" maxlength="20" onchange="estimateSystemProductSearch(19);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck19" id="OutletCheck19" value="1" onclick="estimateSystemOutletChack(19);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag19" id="FeeFlag19" value="" /><input type="hidden" name="SuperBigFlag19" id="SuperBigFlag19" value="" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName19" id="ProductName19" value="" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine19">Rコード <input type="text" class="ProductCode3" name="RCode19" id="RCode19" value="" maxlength="6" onchange="estimateSystemProductSearchRICOH(19);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea19"><div class="InventoryLayer" id="InventoryLayer19"></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck19" id="OpenCheck19" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice19" id="RegularPrice19" value="" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice19" id="NormalPrice19" value="" readonly onfocus="estimateSystemCursorAdvance('normal',19);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate19" id="NormalRate19" value="" readonly onfocus="estimateSystemCursorAdvance('normal',19);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate19" id="UnitRate19" value="" maxlength="5" onchange="estimateSystemUnitPercent(19, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice19" id="UnitPrice19" value="" maxlength="10" onchange="estimateSystemUnitPercent(19, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity19" id="Quantity19" value="" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(19); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice19" id="SubTotalPrice19" value="" readonly onfocus="estimateSystemCursorAdvance('sub',19);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime19" id="DeliveryTime19" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo19" id="Memo19" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice19"></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka19" id="EigyouGenka19" value="" readonly onfocus="estimateSystemCursorAdvance('next',19);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice19" id="MarginPrice19" value="" readonly onfocus="estimateSystemCursorAdvance('next',19);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice19" id="LimitPrice19" value="" readonly onfocus="estimateSystemCursorAdvance('next',19);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal19" id="MarginTotal19" value="" readonly onfocus="estimateSystemCursorAdvance('next',19);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate19" id="MarginRate19" value="" readonly onfocus="estimateSystemCursorAdvance('next',19);" />%</p>
        </td>
        <td id="MarginRank19"></td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment19" id="PurchaseComment19" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment19" id="DevLeaderComment19" readonly></textarea><input type="hidden" name="AutoAnswerFlag19" id="AutoAnswerFlag19" value="" /><input type="hidden" name="ImportantFlag19" id="ImportantFlag19" value="" /></p>
        </td>
        <td class="td_project"></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther19" id="RivalOther19" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker19" id="RivalMaker19" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku19" id="RivalSku19" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice19" id="RivalPrice19" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice19" id="LeaderPrice19" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',19);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate19" id="LeaderRate19" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',19);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice19" id="CorrectionPrice19" value="" readonly onfocus="estimateSystemCursorAdvance('next',19);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate19" id="CorrectionRate19" value="" readonly onfocus="estimateSystemCursorAdvance('next',19);" />%</p>
        </td>
        <td class="td_project">

        </td>
      </tr>

      <tr id="Column_20">
        <td><input type="text" class="ColumnNo" name="ColumnNo20" id="ColumnNo20" value="20" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(20);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck20" id="DeleteCheck20" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('20');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(20);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode20" id="ProductCode20" value="" maxlength="20" onchange="estimateSystemProductSearch(20);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck20" id="OutletCheck20" value="1" onclick="estimateSystemOutletChack(20);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag20" id="FeeFlag20" value="" /><input type="hidden" name="SuperBigFlag20" id="SuperBigFlag20" value="" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName20" id="ProductName20" value="" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine20">Rコード <input type="text" class="ProductCode3" name="RCode20" id="RCode20" value="" maxlength="6" onchange="estimateSystemProductSearchRICOH(20);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea20"><div class="InventoryLayer" id="InventoryLayer20"></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck20" id="OpenCheck20" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice20" id="RegularPrice20" value="" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice20" id="NormalPrice20" value="" readonly onfocus="estimateSystemCursorAdvance('normal',20);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate20" id="NormalRate20" value="" readonly onfocus="estimateSystemCursorAdvance('normal',20);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate20" id="UnitRate20" value="" maxlength="5" onchange="estimateSystemUnitPercent(20, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice20" id="UnitPrice20" value="" maxlength="10" onchange="estimateSystemUnitPercent(20, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity20" id="Quantity20" value="" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(20); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice20" id="SubTotalPrice20" value="" readonly onfocus="estimateSystemCursorAdvance('sub',20);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime20" id="DeliveryTime20" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo20" id="Memo20" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice20"></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka20" id="EigyouGenka20" value="" readonly onfocus="estimateSystemCursorAdvance('next',20);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice20" id="MarginPrice20" value="" readonly onfocus="estimateSystemCursorAdvance('next',20);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice20" id="LimitPrice20" value="" readonly onfocus="estimateSystemCursorAdvance('next',20);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal20" id="MarginTotal20" value="" readonly onfocus="estimateSystemCursorAdvance('next',20);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate20" id="MarginRate20" value="" readonly onfocus="estimateSystemCursorAdvance('next',20);" />%</p>
        </td>
        <td id="MarginRank20"></td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment20" id="PurchaseComment20" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment20" id="DevLeaderComment20" readonly></textarea><input type="hidden" name="AutoAnswerFlag20" id="AutoAnswerFlag20" value="" /><input type="hidden" name="ImportantFlag20" id="ImportantFlag20" value="" /></p>
        </td>
        <td class="td_project"></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther20" id="RivalOther20" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker20" id="RivalMaker20" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku20" id="RivalSku20" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice20" id="RivalPrice20" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice20" id="LeaderPrice20" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',20);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate20" id="LeaderRate20" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',20);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice20" id="CorrectionPrice20" value="" readonly onfocus="estimateSystemCursorAdvance('next',20);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate20" id="CorrectionRate20" value="" readonly onfocus="estimateSystemCursorAdvance('next',20);" />%</p>
        </td>
        <td class="td_project">

        </td>
      </tr>

      <tr id="Column_21" class="tr_no_disp">
        <td><input type="text" class="ColumnNo" name="ColumnNo21" id="ColumnNo21" value="21" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(21);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck21" id="DeleteCheck21" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('21');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(21);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode21" id="ProductCode21" value="" maxlength="20" onchange="estimateSystemProductSearch(21);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck21" id="OutletCheck21" value="1" onclick="estimateSystemOutletChack(21);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag21" id="FeeFlag21" value="" /><input type="hidden" name="SuperBigFlag21" id="SuperBigFlag21" value="" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName21" id="ProductName21" value="" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine21">Rコード <input type="text" class="ProductCode3" name="RCode21" id="RCode21" value="" maxlength="6" onchange="estimateSystemProductSearchRICOH(21);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea21"><div class="InventoryLayer" id="InventoryLayer21"></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck21" id="OpenCheck21" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice21" id="RegularPrice21" value="" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice21" id="NormalPrice21" value="" readonly onfocus="estimateSystemCursorAdvance('normal',21);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate21" id="NormalRate21" value="" readonly onfocus="estimateSystemCursorAdvance('normal',21);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate21" id="UnitRate21" value="" maxlength="5" onchange="estimateSystemUnitPercent(21, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice21" id="UnitPrice21" value="" maxlength="10" onchange="estimateSystemUnitPercent(21, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity21" id="Quantity21" value="" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(21); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice21" id="SubTotalPrice21" value="" readonly onfocus="estimateSystemCursorAdvance('sub',21);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime21" id="DeliveryTime21" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo21" id="Memo21" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice21"></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka21" id="EigyouGenka21" value="" readonly onfocus="estimateSystemCursorAdvance('next',21);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice21" id="MarginPrice21" value="" readonly onfocus="estimateSystemCursorAdvance('next',21);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice21" id="LimitPrice21" value="" readonly onfocus="estimateSystemCursorAdvance('next',21);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal21" id="MarginTotal21" value="" readonly onfocus="estimateSystemCursorAdvance('next',21);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate21" id="MarginRate21" value="" readonly onfocus="estimateSystemCursorAdvance('next',21);" />%</p>
        </td>
        <td id="MarginRank21"></td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment21" id="PurchaseComment21" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment21" id="DevLeaderComment21" readonly></textarea><input type="hidden" name="AutoAnswerFlag21" id="AutoAnswerFlag21" value="" /><input type="hidden" name="ImportantFlag21" id="ImportantFlag21" value="" /></p>
        </td>
        <td class="td_project"></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther21" id="RivalOther21" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker21" id="RivalMaker21" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku21" id="RivalSku21" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice21" id="RivalPrice21" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice21" id="LeaderPrice21" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',21);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate21" id="LeaderRate21" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',21);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice21" id="CorrectionPrice21" value="" readonly onfocus="estimateSystemCursorAdvance('next',21);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate21" id="CorrectionRate21" value="" readonly onfocus="estimateSystemCursorAdvance('next',21);" />%</p>
        </td>
        <td class="td_project">

        </td>
      </tr>

      <tr id="Column_22" class="tr_no_disp">
        <td><input type="text" class="ColumnNo" name="ColumnNo22" id="ColumnNo22" value="22" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(22);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck22" id="DeleteCheck22" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('22');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(22);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode22" id="ProductCode22" value="" maxlength="20" onchange="estimateSystemProductSearch(22);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck22" id="OutletCheck22" value="1" onclick="estimateSystemOutletChack(22);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag22" id="FeeFlag22" value="" /><input type="hidden" name="SuperBigFlag22" id="SuperBigFlag22" value="" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName22" id="ProductName22" value="" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine22">Rコード <input type="text" class="ProductCode3" name="RCode22" id="RCode22" value="" maxlength="6" onchange="estimateSystemProductSearchRICOH(22);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea22"><div class="InventoryLayer" id="InventoryLayer22"></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck22" id="OpenCheck22" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice22" id="RegularPrice22" value="" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice22" id="NormalPrice22" value="" readonly onfocus="estimateSystemCursorAdvance('normal',22);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate22" id="NormalRate22" value="" readonly onfocus="estimateSystemCursorAdvance('normal',22);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate22" id="UnitRate22" value="" maxlength="5" onchange="estimateSystemUnitPercent(22, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice22" id="UnitPrice22" value="" maxlength="10" onchange="estimateSystemUnitPercent(22, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity22" id="Quantity22" value="" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(22); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice22" id="SubTotalPrice22" value="" readonly onfocus="estimateSystemCursorAdvance('sub',22);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime22" id="DeliveryTime22" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo22" id="Memo22" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice22"></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka22" id="EigyouGenka22" value="" readonly onfocus="estimateSystemCursorAdvance('next',22);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice22" id="MarginPrice22" value="" readonly onfocus="estimateSystemCursorAdvance('next',22);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice22" id="LimitPrice22" value="" readonly onfocus="estimateSystemCursorAdvance('next',22);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal22" id="MarginTotal22" value="" readonly onfocus="estimateSystemCursorAdvance('next',22);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate22" id="MarginRate22" value="" readonly onfocus="estimateSystemCursorAdvance('next',22);" />%</p>
        </td>
        <td id="MarginRank22"></td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment22" id="PurchaseComment22" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment22" id="DevLeaderComment22" readonly></textarea><input type="hidden" name="AutoAnswerFlag22" id="AutoAnswerFlag22" value="" /><input type="hidden" name="ImportantFlag22" id="ImportantFlag22" value="" /></p>
        </td>
        <td class="td_project"></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther22" id="RivalOther22" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker22" id="RivalMaker22" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku22" id="RivalSku22" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice22" id="RivalPrice22" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice22" id="LeaderPrice22" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',22);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate22" id="LeaderRate22" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',22);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice22" id="CorrectionPrice22" value="" readonly onfocus="estimateSystemCursorAdvance('next',22);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate22" id="CorrectionRate22" value="" readonly onfocus="estimateSystemCursorAdvance('next',22);" />%</p>
        </td>
        <td class="td_project">

        </td>
      </tr>

      <tr id="Column_23" class="tr_no_disp">
        <td><input type="text" class="ColumnNo" name="ColumnNo23" id="ColumnNo23" value="23" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(23);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck23" id="DeleteCheck23" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('23');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(23);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode23" id="ProductCode23" value="" maxlength="20" onchange="estimateSystemProductSearch(23);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck23" id="OutletCheck23" value="1" onclick="estimateSystemOutletChack(23);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag23" id="FeeFlag23" value="" /><input type="hidden" name="SuperBigFlag23" id="SuperBigFlag23" value="" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName23" id="ProductName23" value="" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine23">Rコード <input type="text" class="ProductCode3" name="RCode23" id="RCode23" value="" maxlength="6" onchange="estimateSystemProductSearchRICOH(23);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea23"><div class="InventoryLayer" id="InventoryLayer23"></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck23" id="OpenCheck23" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice23" id="RegularPrice23" value="" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice23" id="NormalPrice23" value="" readonly onfocus="estimateSystemCursorAdvance('normal',23);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate23" id="NormalRate23" value="" readonly onfocus="estimateSystemCursorAdvance('normal',23);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate23" id="UnitRate23" value="" maxlength="5" onchange="estimateSystemUnitPercent(23, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice23" id="UnitPrice23" value="" maxlength="10" onchange="estimateSystemUnitPercent(23, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity23" id="Quantity23" value="" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(23); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice23" id="SubTotalPrice23" value="" readonly onfocus="estimateSystemCursorAdvance('sub',23);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime23" id="DeliveryTime23" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo23" id="Memo23" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice23"></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka23" id="EigyouGenka23" value="" readonly onfocus="estimateSystemCursorAdvance('next',23);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice23" id="MarginPrice23" value="" readonly onfocus="estimateSystemCursorAdvance('next',23);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice23" id="LimitPrice23" value="" readonly onfocus="estimateSystemCursorAdvance('next',23);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal23" id="MarginTotal23" value="" readonly onfocus="estimateSystemCursorAdvance('next',23);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate23" id="MarginRate23" value="" readonly onfocus="estimateSystemCursorAdvance('next',23);" />%</p>
        </td>
        <td id="MarginRank23"></td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment23" id="PurchaseComment23" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment23" id="DevLeaderComment23" readonly></textarea><input type="hidden" name="AutoAnswerFlag23" id="AutoAnswerFlag23" value="" /><input type="hidden" name="ImportantFlag23" id="ImportantFlag23" value="" /></p>
        </td>
        <td class="td_project"></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther23" id="RivalOther23" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker23" id="RivalMaker23" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku23" id="RivalSku23" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice23" id="RivalPrice23" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice23" id="LeaderPrice23" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',23);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate23" id="LeaderRate23" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',23);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice23" id="CorrectionPrice23" value="" readonly onfocus="estimateSystemCursorAdvance('next',23);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate23" id="CorrectionRate23" value="" readonly onfocus="estimateSystemCursorAdvance('next',23);" />%</p>
        </td>
        <td class="td_project">

        </td>
      </tr>

      <tr id="Column_24" class="tr_no_disp">
        <td><input type="text" class="ColumnNo" name="ColumnNo24" id="ColumnNo24" value="24" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(24);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck24" id="DeleteCheck24" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('24');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(24);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode24" id="ProductCode24" value="" maxlength="20" onchange="estimateSystemProductSearch(24);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck24" id="OutletCheck24" value="1" onclick="estimateSystemOutletChack(24);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag24" id="FeeFlag24" value="" /><input type="hidden" name="SuperBigFlag24" id="SuperBigFlag24" value="" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName24" id="ProductName24" value="" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine24">Rコード <input type="text" class="ProductCode3" name="RCode24" id="RCode24" value="" maxlength="6" onchange="estimateSystemProductSearchRICOH(24);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea24"><div class="InventoryLayer" id="InventoryLayer24"></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck24" id="OpenCheck24" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice24" id="RegularPrice24" value="" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice24" id="NormalPrice24" value="" readonly onfocus="estimateSystemCursorAdvance('normal',24);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate24" id="NormalRate24" value="" readonly onfocus="estimateSystemCursorAdvance('normal',24);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate24" id="UnitRate24" value="" maxlength="5" onchange="estimateSystemUnitPercent(24, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice24" id="UnitPrice24" value="" maxlength="10" onchange="estimateSystemUnitPercent(24, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity24" id="Quantity24" value="" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(24); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice24" id="SubTotalPrice24" value="" readonly onfocus="estimateSystemCursorAdvance('sub',24);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime24" id="DeliveryTime24" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo24" id="Memo24" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice24"></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka24" id="EigyouGenka24" value="" readonly onfocus="estimateSystemCursorAdvance('next',24);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice24" id="MarginPrice24" value="" readonly onfocus="estimateSystemCursorAdvance('next',24);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice24" id="LimitPrice24" value="" readonly onfocus="estimateSystemCursorAdvance('next',24);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal24" id="MarginTotal24" value="" readonly onfocus="estimateSystemCursorAdvance('next',24);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate24" id="MarginRate24" value="" readonly onfocus="estimateSystemCursorAdvance('next',24);" />%</p>
        </td>
        <td id="MarginRank24"></td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment24" id="PurchaseComment24" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment24" id="DevLeaderComment24" readonly></textarea><input type="hidden" name="AutoAnswerFlag24" id="AutoAnswerFlag24" value="" /><input type="hidden" name="ImportantFlag24" id="ImportantFlag24" value="" /></p>
        </td>
        <td class="td_project"></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther24" id="RivalOther24" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker24" id="RivalMaker24" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku24" id="RivalSku24" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice24" id="RivalPrice24" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice24" id="LeaderPrice24" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',24);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate24" id="LeaderRate24" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',24);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice24" id="CorrectionPrice24" value="" readonly onfocus="estimateSystemCursorAdvance('next',24);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate24" id="CorrectionRate24" value="" readonly onfocus="estimateSystemCursorAdvance('next',24);" />%</p>
        </td>
        <td class="td_project">

        </td>
      </tr>

      <tr id="Column_25" class="tr_no_disp">
        <td><input type="text" class="ColumnNo" name="ColumnNo25" id="ColumnNo25" value="25" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(25);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck25" id="DeleteCheck25" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('25');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(25);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode25" id="ProductCode25" value="" maxlength="20" onchange="estimateSystemProductSearch(25);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck25" id="OutletCheck25" value="1" onclick="estimateSystemOutletChack(25);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag25" id="FeeFlag25" value="" /><input type="hidden" name="SuperBigFlag25" id="SuperBigFlag25" value="" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName25" id="ProductName25" value="" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine25">Rコード <input type="text" class="ProductCode3" name="RCode25" id="RCode25" value="" maxlength="6" onchange="estimateSystemProductSearchRICOH(25);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea25"><div class="InventoryLayer" id="InventoryLayer25"></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck25" id="OpenCheck25" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice25" id="RegularPrice25" value="" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice25" id="NormalPrice25" value="" readonly onfocus="estimateSystemCursorAdvance('normal',25);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate25" id="NormalRate25" value="" readonly onfocus="estimateSystemCursorAdvance('normal',25);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate25" id="UnitRate25" value="" maxlength="5" onchange="estimateSystemUnitPercent(25, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice25" id="UnitPrice25" value="" maxlength="10" onchange="estimateSystemUnitPercent(25, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity25" id="Quantity25" value="" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(25); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice25" id="SubTotalPrice25" value="" readonly onfocus="estimateSystemCursorAdvance('sub',25);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime25" id="DeliveryTime25" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo25" id="Memo25" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice25"></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka25" id="EigyouGenka25" value="" readonly onfocus="estimateSystemCursorAdvance('next',25);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice25" id="MarginPrice25" value="" readonly onfocus="estimateSystemCursorAdvance('next',25);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice25" id="LimitPrice25" value="" readonly onfocus="estimateSystemCursorAdvance('next',25);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal25" id="MarginTotal25" value="" readonly onfocus="estimateSystemCursorAdvance('next',25);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate25" id="MarginRate25" value="" readonly onfocus="estimateSystemCursorAdvance('next',25);" />%</p>
        </td>
        <td id="MarginRank25"></td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment25" id="PurchaseComment25" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment25" id="DevLeaderComment25" readonly></textarea><input type="hidden" name="AutoAnswerFlag25" id="AutoAnswerFlag25" value="" /><input type="hidden" name="ImportantFlag25" id="ImportantFlag25" value="" /></p>
        </td>
        <td class="td_project"></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther25" id="RivalOther25" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker25" id="RivalMaker25" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku25" id="RivalSku25" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice25" id="RivalPrice25" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice25" id="LeaderPrice25" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',25);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate25" id="LeaderRate25" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',25);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice25" id="CorrectionPrice25" value="" readonly onfocus="estimateSystemCursorAdvance('next',25);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate25" id="CorrectionRate25" value="" readonly onfocus="estimateSystemCursorAdvance('next',25);" />%</p>
        </td>
        <td class="td_project">

        </td>
      </tr>

      <tr id="Column_26" class="tr_no_disp">
        <td><input type="text" class="ColumnNo" name="ColumnNo26" id="ColumnNo26" value="26" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(26);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck26" id="DeleteCheck26" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('26');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(26);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode26" id="ProductCode26" value="" maxlength="20" onchange="estimateSystemProductSearch(26);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck26" id="OutletCheck26" value="1" onclick="estimateSystemOutletChack(26);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag26" id="FeeFlag26" value="" /><input type="hidden" name="SuperBigFlag26" id="SuperBigFlag26" value="" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName26" id="ProductName26" value="" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine26">Rコード <input type="text" class="ProductCode3" name="RCode26" id="RCode26" value="" maxlength="6" onchange="estimateSystemProductSearchRICOH(26);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea26"><div class="InventoryLayer" id="InventoryLayer26"></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck26" id="OpenCheck26" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice26" id="RegularPrice26" value="" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice26" id="NormalPrice26" value="" readonly onfocus="estimateSystemCursorAdvance('normal',26);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate26" id="NormalRate26" value="" readonly onfocus="estimateSystemCursorAdvance('normal',26);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate26" id="UnitRate26" value="" maxlength="5" onchange="estimateSystemUnitPercent(26, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice26" id="UnitPrice26" value="" maxlength="10" onchange="estimateSystemUnitPercent(26, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity26" id="Quantity26" value="" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(26); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice26" id="SubTotalPrice26" value="" readonly onfocus="estimateSystemCursorAdvance('sub',26);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime26" id="DeliveryTime26" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo26" id="Memo26" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice26"></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka26" id="EigyouGenka26" value="" readonly onfocus="estimateSystemCursorAdvance('next',26);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice26" id="MarginPrice26" value="" readonly onfocus="estimateSystemCursorAdvance('next',26);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice26" id="LimitPrice26" value="" readonly onfocus="estimateSystemCursorAdvance('next',26);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal26" id="MarginTotal26" value="" readonly onfocus="estimateSystemCursorAdvance('next',26);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate26" id="MarginRate26" value="" readonly onfocus="estimateSystemCursorAdvance('next',26);" />%</p>
        </td>
        <td id="MarginRank26"></td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment26" id="PurchaseComment26" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment26" id="DevLeaderComment26" readonly></textarea><input type="hidden" name="AutoAnswerFlag26" id="AutoAnswerFlag26" value="" /><input type="hidden" name="ImportantFlag26" id="ImportantFlag26" value="" /></p>
        </td>
        <td class="td_project"></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther26" id="RivalOther26" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker26" id="RivalMaker26" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku26" id="RivalSku26" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice26" id="RivalPrice26" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice26" id="LeaderPrice26" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',26);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate26" id="LeaderRate26" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',26);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice26" id="CorrectionPrice26" value="" readonly onfocus="estimateSystemCursorAdvance('next',26);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate26" id="CorrectionRate26" value="" readonly onfocus="estimateSystemCursorAdvance('next',26);" />%</p>
        </td>
        <td class="td_project">

        </td>
      </tr>

      <tr id="Column_27" class="tr_no_disp">
        <td><input type="text" class="ColumnNo" name="ColumnNo27" id="ColumnNo27" value="27" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(27);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck27" id="DeleteCheck27" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('27');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(27);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode27" id="ProductCode27" value="" maxlength="20" onchange="estimateSystemProductSearch(27);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck27" id="OutletCheck27" value="1" onclick="estimateSystemOutletChack(27);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag27" id="FeeFlag27" value="" /><input type="hidden" name="SuperBigFlag27" id="SuperBigFlag27" value="" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName27" id="ProductName27" value="" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine27">Rコード <input type="text" class="ProductCode3" name="RCode27" id="RCode27" value="" maxlength="6" onchange="estimateSystemProductSearchRICOH(27);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea27"><div class="InventoryLayer" id="InventoryLayer27"></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck27" id="OpenCheck27" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice27" id="RegularPrice27" value="" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice27" id="NormalPrice27" value="" readonly onfocus="estimateSystemCursorAdvance('normal',27);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate27" id="NormalRate27" value="" readonly onfocus="estimateSystemCursorAdvance('normal',27);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate27" id="UnitRate27" value="" maxlength="5" onchange="estimateSystemUnitPercent(27, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice27" id="UnitPrice27" value="" maxlength="10" onchange="estimateSystemUnitPercent(27, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity27" id="Quantity27" value="" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(27); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice27" id="SubTotalPrice27" value="" readonly onfocus="estimateSystemCursorAdvance('sub',27);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime27" id="DeliveryTime27" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo27" id="Memo27" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice27"></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka27" id="EigyouGenka27" value="" readonly onfocus="estimateSystemCursorAdvance('next',27);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice27" id="MarginPrice27" value="" readonly onfocus="estimateSystemCursorAdvance('next',27);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice27" id="LimitPrice27" value="" readonly onfocus="estimateSystemCursorAdvance('next',27);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal27" id="MarginTotal27" value="" readonly onfocus="estimateSystemCursorAdvance('next',27);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate27" id="MarginRate27" value="" readonly onfocus="estimateSystemCursorAdvance('next',27);" />%</p>
        </td>
        <td id="MarginRank27"></td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment27" id="PurchaseComment27" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment27" id="DevLeaderComment27" readonly></textarea><input type="hidden" name="AutoAnswerFlag27" id="AutoAnswerFlag27" value="" /><input type="hidden" name="ImportantFlag27" id="ImportantFlag27" value="" /></p>
        </td>
        <td class="td_project"></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther27" id="RivalOther27" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker27" id="RivalMaker27" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku27" id="RivalSku27" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice27" id="RivalPrice27" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice27" id="LeaderPrice27" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',27);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate27" id="LeaderRate27" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',27);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice27" id="CorrectionPrice27" value="" readonly onfocus="estimateSystemCursorAdvance('next',27);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate27" id="CorrectionRate27" value="" readonly onfocus="estimateSystemCursorAdvance('next',27);" />%</p>
        </td>
        <td class="td_project">

        </td>
      </tr>

      <tr id="Column_28" class="tr_no_disp">
        <td><input type="text" class="ColumnNo" name="ColumnNo28" id="ColumnNo28" value="28" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(28);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck28" id="DeleteCheck28" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('28');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(28);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode28" id="ProductCode28" value="" maxlength="20" onchange="estimateSystemProductSearch(28);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck28" id="OutletCheck28" value="1" onclick="estimateSystemOutletChack(28);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag28" id="FeeFlag28" value="" /><input type="hidden" name="SuperBigFlag28" id="SuperBigFlag28" value="" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName28" id="ProductName28" value="" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine28">Rコード <input type="text" class="ProductCode3" name="RCode28" id="RCode28" value="" maxlength="6" onchange="estimateSystemProductSearchRICOH(28);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea28"><div class="InventoryLayer" id="InventoryLayer28"></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck28" id="OpenCheck28" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice28" id="RegularPrice28" value="" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice28" id="NormalPrice28" value="" readonly onfocus="estimateSystemCursorAdvance('normal',28);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate28" id="NormalRate28" value="" readonly onfocus="estimateSystemCursorAdvance('normal',28);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate28" id="UnitRate28" value="" maxlength="5" onchange="estimateSystemUnitPercent(28, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice28" id="UnitPrice28" value="" maxlength="10" onchange="estimateSystemUnitPercent(28, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity28" id="Quantity28" value="" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(28); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice28" id="SubTotalPrice28" value="" readonly onfocus="estimateSystemCursorAdvance('sub',28);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime28" id="DeliveryTime28" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo28" id="Memo28" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice28"></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka28" id="EigyouGenka28" value="" readonly onfocus="estimateSystemCursorAdvance('next',28);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice28" id="MarginPrice28" value="" readonly onfocus="estimateSystemCursorAdvance('next',28);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice28" id="LimitPrice28" value="" readonly onfocus="estimateSystemCursorAdvance('next',28);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal28" id="MarginTotal28" value="" readonly onfocus="estimateSystemCursorAdvance('next',28);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate28" id="MarginRate28" value="" readonly onfocus="estimateSystemCursorAdvance('next',28);" />%</p>
        </td>
        <td id="MarginRank28"></td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment28" id="PurchaseComment28" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment28" id="DevLeaderComment28" readonly></textarea><input type="hidden" name="AutoAnswerFlag28" id="AutoAnswerFlag28" value="" /><input type="hidden" name="ImportantFlag28" id="ImportantFlag28" value="" /></p>
        </td>
        <td class="td_project"></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther28" id="RivalOther28" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker28" id="RivalMaker28" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku28" id="RivalSku28" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice28" id="RivalPrice28" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice28" id="LeaderPrice28" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',28);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate28" id="LeaderRate28" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',28);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice28" id="CorrectionPrice28" value="" readonly onfocus="estimateSystemCursorAdvance('next',28);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate28" id="CorrectionRate28" value="" readonly onfocus="estimateSystemCursorAdvance('next',28);" />%</p>
        </td>
        <td class="td_project">

        </td>
      </tr>

      <tr id="Column_29" class="tr_no_disp">
        <td><input type="text" class="ColumnNo" name="ColumnNo29" id="ColumnNo29" value="29" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(29);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck29" id="DeleteCheck29" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('29');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(29);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode29" id="ProductCode29" value="" maxlength="20" onchange="estimateSystemProductSearch(29);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck29" id="OutletCheck29" value="1" onclick="estimateSystemOutletChack(29);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag29" id="FeeFlag29" value="" /><input type="hidden" name="SuperBigFlag29" id="SuperBigFlag29" value="" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName29" id="ProductName29" value="" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine29">Rコード <input type="text" class="ProductCode3" name="RCode29" id="RCode29" value="" maxlength="6" onchange="estimateSystemProductSearchRICOH(29);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea29"><div class="InventoryLayer" id="InventoryLayer29"></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck29" id="OpenCheck29" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice29" id="RegularPrice29" value="" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice29" id="NormalPrice29" value="" readonly onfocus="estimateSystemCursorAdvance('normal',29);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate29" id="NormalRate29" value="" readonly onfocus="estimateSystemCursorAdvance('normal',29);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate29" id="UnitRate29" value="" maxlength="5" onchange="estimateSystemUnitPercent(29, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice29" id="UnitPrice29" value="" maxlength="10" onchange="estimateSystemUnitPercent(29, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity29" id="Quantity29" value="" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(29); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice29" id="SubTotalPrice29" value="" readonly onfocus="estimateSystemCursorAdvance('sub',29);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime29" id="DeliveryTime29" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo29" id="Memo29" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice29"></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka29" id="EigyouGenka29" value="" readonly onfocus="estimateSystemCursorAdvance('next',29);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice29" id="MarginPrice29" value="" readonly onfocus="estimateSystemCursorAdvance('next',29);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice29" id="LimitPrice29" value="" readonly onfocus="estimateSystemCursorAdvance('next',29);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal29" id="MarginTotal29" value="" readonly onfocus="estimateSystemCursorAdvance('next',29);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate29" id="MarginRate29" value="" readonly onfocus="estimateSystemCursorAdvance('next',29);" />%</p>
        </td>
        <td id="MarginRank29"></td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment29" id="PurchaseComment29" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment29" id="DevLeaderComment29" readonly></textarea><input type="hidden" name="AutoAnswerFlag29" id="AutoAnswerFlag29" value="" /><input type="hidden" name="ImportantFlag29" id="ImportantFlag29" value="" /></p>
        </td>
        <td class="td_project"></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther29" id="RivalOther29" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker29" id="RivalMaker29" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku29" id="RivalSku29" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice29" id="RivalPrice29" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice29" id="LeaderPrice29" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',29);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate29" id="LeaderRate29" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',29);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice29" id="CorrectionPrice29" value="" readonly onfocus="estimateSystemCursorAdvance('next',29);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate29" id="CorrectionRate29" value="" readonly onfocus="estimateSystemCursorAdvance('next',29);" />%</p>
        </td>
        <td class="td_project">

        </td>
      </tr>

      <tr id="Column_30" class="tr_no_disp">
        <td><input type="text" class="ColumnNo" name="ColumnNo30" id="ColumnNo30" value="30" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(30);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck30" id="DeleteCheck30" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('30');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(30);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode30" id="ProductCode30" value="" maxlength="20" onchange="estimateSystemProductSearch(30);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck30" id="OutletCheck30" value="1" onclick="estimateSystemOutletChack(30);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag30" id="FeeFlag30" value="" /><input type="hidden" name="SuperBigFlag30" id="SuperBigFlag30" value="" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName30" id="ProductName30" value="" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine30">Rコード <input type="text" class="ProductCode3" name="RCode30" id="RCode30" value="" maxlength="6" onchange="estimateSystemProductSearchRICOH(30);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea30"><div class="InventoryLayer" id="InventoryLayer30"></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck30" id="OpenCheck30" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice30" id="RegularPrice30" value="" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice30" id="NormalPrice30" value="" readonly onfocus="estimateSystemCursorAdvance('normal',30);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate30" id="NormalRate30" value="" readonly onfocus="estimateSystemCursorAdvance('normal',30);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate30" id="UnitRate30" value="" maxlength="5" onchange="estimateSystemUnitPercent(30, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice30" id="UnitPrice30" value="" maxlength="10" onchange="estimateSystemUnitPercent(30, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity30" id="Quantity30" value="" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(30); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice30" id="SubTotalPrice30" value="" readonly onfocus="estimateSystemCursorAdvance('sub',30);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime30" id="DeliveryTime30" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo30" id="Memo30" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice30"></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka30" id="EigyouGenka30" value="" readonly onfocus="estimateSystemCursorAdvance('next',30);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice30" id="MarginPrice30" value="" readonly onfocus="estimateSystemCursorAdvance('next',30);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice30" id="LimitPrice30" value="" readonly onfocus="estimateSystemCursorAdvance('next',30);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal30" id="MarginTotal30" value="" readonly onfocus="estimateSystemCursorAdvance('next',30);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate30" id="MarginRate30" value="" readonly onfocus="estimateSystemCursorAdvance('next',30);" />%</p>
        </td>
        <td id="MarginRank30"></td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment30" id="PurchaseComment30" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment30" id="DevLeaderComment30" readonly></textarea><input type="hidden" name="AutoAnswerFlag30" id="AutoAnswerFlag30" value="" /><input type="hidden" name="ImportantFlag30" id="ImportantFlag30" value="" /></p>
        </td>
        <td class="td_project"></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther30" id="RivalOther30" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker30" id="RivalMaker30" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku30" id="RivalSku30" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice30" id="RivalPrice30" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice30" id="LeaderPrice30" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',30);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate30" id="LeaderRate30" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',30);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice30" id="CorrectionPrice30" value="" readonly onfocus="estimateSystemCursorAdvance('next',30);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate30" id="CorrectionRate30" value="" readonly onfocus="estimateSystemCursorAdvance('next',30);" />%</p>
        </td>
        <td class="td_project">

        </td>
      </tr>

      <tr id="Column_31" class="tr_no_disp">
        <td><input type="text" class="ColumnNo" name="ColumnNo31" id="ColumnNo31" value="31" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(31);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck31" id="DeleteCheck31" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('31');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(31);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode31" id="ProductCode31" value="" maxlength="20" onchange="estimateSystemProductSearch(31);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck31" id="OutletCheck31" value="1" onclick="estimateSystemOutletChack(31);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag31" id="FeeFlag31" value="" /><input type="hidden" name="SuperBigFlag31" id="SuperBigFlag31" value="" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName31" id="ProductName31" value="" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine31">Rコード <input type="text" class="ProductCode3" name="RCode31" id="RCode31" value="" maxlength="6" onchange="estimateSystemProductSearchRICOH(31);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea31"><div class="InventoryLayer" id="InventoryLayer31"></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck31" id="OpenCheck31" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice31" id="RegularPrice31" value="" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice31" id="NormalPrice31" value="" readonly onfocus="estimateSystemCursorAdvance('normal',31);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate31" id="NormalRate31" value="" readonly onfocus="estimateSystemCursorAdvance('normal',31);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate31" id="UnitRate31" value="" maxlength="5" onchange="estimateSystemUnitPercent(31, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice31" id="UnitPrice31" value="" maxlength="10" onchange="estimateSystemUnitPercent(31, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity31" id="Quantity31" value="" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(31); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice31" id="SubTotalPrice31" value="" readonly onfocus="estimateSystemCursorAdvance('sub',31);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime31" id="DeliveryTime31" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo31" id="Memo31" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice31"></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka31" id="EigyouGenka31" value="" readonly onfocus="estimateSystemCursorAdvance('next',31);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice31" id="MarginPrice31" value="" readonly onfocus="estimateSystemCursorAdvance('next',31);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice31" id="LimitPrice31" value="" readonly onfocus="estimateSystemCursorAdvance('next',31);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal31" id="MarginTotal31" value="" readonly onfocus="estimateSystemCursorAdvance('next',31);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate31" id="MarginRate31" value="" readonly onfocus="estimateSystemCursorAdvance('next',31);" />%</p>
        </td>
        <td id="MarginRank31"></td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment31" id="PurchaseComment31" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment31" id="DevLeaderComment31" readonly></textarea><input type="hidden" name="AutoAnswerFlag31" id="AutoAnswerFlag31" value="" /><input type="hidden" name="ImportantFlag31" id="ImportantFlag31" value="" /></p>
        </td>
        <td class="td_project"></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther31" id="RivalOther31" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker31" id="RivalMaker31" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku31" id="RivalSku31" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice31" id="RivalPrice31" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice31" id="LeaderPrice31" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',31);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate31" id="LeaderRate31" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',31);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice31" id="CorrectionPrice31" value="" readonly onfocus="estimateSystemCursorAdvance('next',31);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate31" id="CorrectionRate31" value="" readonly onfocus="estimateSystemCursorAdvance('next',31);" />%</p>
        </td>
        <td class="td_project">

        </td>
      </tr>

      <tr id="Column_32" class="tr_no_disp">
        <td><input type="text" class="ColumnNo" name="ColumnNo32" id="ColumnNo32" value="32" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(32);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck32" id="DeleteCheck32" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('32');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(32);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode32" id="ProductCode32" value="" maxlength="20" onchange="estimateSystemProductSearch(32);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck32" id="OutletCheck32" value="1" onclick="estimateSystemOutletChack(32);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag32" id="FeeFlag32" value="" /><input type="hidden" name="SuperBigFlag32" id="SuperBigFlag32" value="" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName32" id="ProductName32" value="" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine32">Rコード <input type="text" class="ProductCode3" name="RCode32" id="RCode32" value="" maxlength="6" onchange="estimateSystemProductSearchRICOH(32);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea32"><div class="InventoryLayer" id="InventoryLayer32"></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck32" id="OpenCheck32" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice32" id="RegularPrice32" value="" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice32" id="NormalPrice32" value="" readonly onfocus="estimateSystemCursorAdvance('normal',32);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate32" id="NormalRate32" value="" readonly onfocus="estimateSystemCursorAdvance('normal',32);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate32" id="UnitRate32" value="" maxlength="5" onchange="estimateSystemUnitPercent(32, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice32" id="UnitPrice32" value="" maxlength="10" onchange="estimateSystemUnitPercent(32, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity32" id="Quantity32" value="" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(32); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice32" id="SubTotalPrice32" value="" readonly onfocus="estimateSystemCursorAdvance('sub',32);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime32" id="DeliveryTime32" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo32" id="Memo32" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice32"></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka32" id="EigyouGenka32" value="" readonly onfocus="estimateSystemCursorAdvance('next',32);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice32" id="MarginPrice32" value="" readonly onfocus="estimateSystemCursorAdvance('next',32);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice32" id="LimitPrice32" value="" readonly onfocus="estimateSystemCursorAdvance('next',32);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal32" id="MarginTotal32" value="" readonly onfocus="estimateSystemCursorAdvance('next',32);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate32" id="MarginRate32" value="" readonly onfocus="estimateSystemCursorAdvance('next',32);" />%</p>
        </td>
        <td id="MarginRank32"></td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment32" id="PurchaseComment32" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment32" id="DevLeaderComment32" readonly></textarea><input type="hidden" name="AutoAnswerFlag32" id="AutoAnswerFlag32" value="" /><input type="hidden" name="ImportantFlag32" id="ImportantFlag32" value="" /></p>
        </td>
        <td class="td_project"></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther32" id="RivalOther32" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker32" id="RivalMaker32" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku32" id="RivalSku32" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice32" id="RivalPrice32" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice32" id="LeaderPrice32" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',32);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate32" id="LeaderRate32" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',32);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice32" id="CorrectionPrice32" value="" readonly onfocus="estimateSystemCursorAdvance('next',32);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate32" id="CorrectionRate32" value="" readonly onfocus="estimateSystemCursorAdvance('next',32);" />%</p>
        </td>
        <td class="td_project">

        </td>
      </tr>

      <tr id="Column_33" class="tr_no_disp">
        <td><input type="text" class="ColumnNo" name="ColumnNo33" id="ColumnNo33" value="33" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(33);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck33" id="DeleteCheck33" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('33');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(33);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode33" id="ProductCode33" value="" maxlength="20" onchange="estimateSystemProductSearch(33);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck33" id="OutletCheck33" value="1" onclick="estimateSystemOutletChack(33);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag33" id="FeeFlag33" value="" /><input type="hidden" name="SuperBigFlag33" id="SuperBigFlag33" value="" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName33" id="ProductName33" value="" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine33">Rコード <input type="text" class="ProductCode3" name="RCode33" id="RCode33" value="" maxlength="6" onchange="estimateSystemProductSearchRICOH(33);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea33"><div class="InventoryLayer" id="InventoryLayer33"></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck33" id="OpenCheck33" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice33" id="RegularPrice33" value="" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice33" id="NormalPrice33" value="" readonly onfocus="estimateSystemCursorAdvance('normal',33);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate33" id="NormalRate33" value="" readonly onfocus="estimateSystemCursorAdvance('normal',33);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate33" id="UnitRate33" value="" maxlength="5" onchange="estimateSystemUnitPercent(33, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice33" id="UnitPrice33" value="" maxlength="10" onchange="estimateSystemUnitPercent(33, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity33" id="Quantity33" value="" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(33); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice33" id="SubTotalPrice33" value="" readonly onfocus="estimateSystemCursorAdvance('sub',33);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime33" id="DeliveryTime33" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo33" id="Memo33" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice33"></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka33" id="EigyouGenka33" value="" readonly onfocus="estimateSystemCursorAdvance('next',33);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice33" id="MarginPrice33" value="" readonly onfocus="estimateSystemCursorAdvance('next',33);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice33" id="LimitPrice33" value="" readonly onfocus="estimateSystemCursorAdvance('next',33);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal33" id="MarginTotal33" value="" readonly onfocus="estimateSystemCursorAdvance('next',33);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate33" id="MarginRate33" value="" readonly onfocus="estimateSystemCursorAdvance('next',33);" />%</p>
        </td>
        <td id="MarginRank33"></td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment33" id="PurchaseComment33" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment33" id="DevLeaderComment33" readonly></textarea><input type="hidden" name="AutoAnswerFlag33" id="AutoAnswerFlag33" value="" /><input type="hidden" name="ImportantFlag33" id="ImportantFlag33" value="" /></p>
        </td>
        <td class="td_project"></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther33" id="RivalOther33" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker33" id="RivalMaker33" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku33" id="RivalSku33" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice33" id="RivalPrice33" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice33" id="LeaderPrice33" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',33);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate33" id="LeaderRate33" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',33);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice33" id="CorrectionPrice33" value="" readonly onfocus="estimateSystemCursorAdvance('next',33);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate33" id="CorrectionRate33" value="" readonly onfocus="estimateSystemCursorAdvance('next',33);" />%</p>
        </td>
        <td class="td_project">

        </td>
      </tr>

      <tr id="Column_34" class="tr_no_disp">
        <td><input type="text" class="ColumnNo" name="ColumnNo34" id="ColumnNo34" value="34" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(34);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck34" id="DeleteCheck34" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('34');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(34);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode34" id="ProductCode34" value="" maxlength="20" onchange="estimateSystemProductSearch(34);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck34" id="OutletCheck34" value="1" onclick="estimateSystemOutletChack(34);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag34" id="FeeFlag34" value="" /><input type="hidden" name="SuperBigFlag34" id="SuperBigFlag34" value="" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName34" id="ProductName34" value="" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine34">Rコード <input type="text" class="ProductCode3" name="RCode34" id="RCode34" value="" maxlength="6" onchange="estimateSystemProductSearchRICOH(34);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea34"><div class="InventoryLayer" id="InventoryLayer34"></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck34" id="OpenCheck34" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice34" id="RegularPrice34" value="" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice34" id="NormalPrice34" value="" readonly onfocus="estimateSystemCursorAdvance('normal',34);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate34" id="NormalRate34" value="" readonly onfocus="estimateSystemCursorAdvance('normal',34);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate34" id="UnitRate34" value="" maxlength="5" onchange="estimateSystemUnitPercent(34, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice34" id="UnitPrice34" value="" maxlength="10" onchange="estimateSystemUnitPercent(34, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity34" id="Quantity34" value="" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(34); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice34" id="SubTotalPrice34" value="" readonly onfocus="estimateSystemCursorAdvance('sub',34);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime34" id="DeliveryTime34" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo34" id="Memo34" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice34"></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka34" id="EigyouGenka34" value="" readonly onfocus="estimateSystemCursorAdvance('next',34);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice34" id="MarginPrice34" value="" readonly onfocus="estimateSystemCursorAdvance('next',34);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice34" id="LimitPrice34" value="" readonly onfocus="estimateSystemCursorAdvance('next',34);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal34" id="MarginTotal34" value="" readonly onfocus="estimateSystemCursorAdvance('next',34);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate34" id="MarginRate34" value="" readonly onfocus="estimateSystemCursorAdvance('next',34);" />%</p>
        </td>
        <td id="MarginRank34"></td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment34" id="PurchaseComment34" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment34" id="DevLeaderComment34" readonly></textarea><input type="hidden" name="AutoAnswerFlag34" id="AutoAnswerFlag34" value="" /><input type="hidden" name="ImportantFlag34" id="ImportantFlag34" value="" /></p>
        </td>
        <td class="td_project"></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther34" id="RivalOther34" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker34" id="RivalMaker34" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku34" id="RivalSku34" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice34" id="RivalPrice34" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice34" id="LeaderPrice34" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',34);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate34" id="LeaderRate34" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',34);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice34" id="CorrectionPrice34" value="" readonly onfocus="estimateSystemCursorAdvance('next',34);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate34" id="CorrectionRate34" value="" readonly onfocus="estimateSystemCursorAdvance('next',34);" />%</p>
        </td>
        <td class="td_project">

        </td>
      </tr>

      <tr id="Column_35" class="tr_no_disp">
        <td><input type="text" class="ColumnNo" name="ColumnNo35" id="ColumnNo35" value="35" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(35);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck35" id="DeleteCheck35" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('35');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(35);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode35" id="ProductCode35" value="" maxlength="20" onchange="estimateSystemProductSearch(35);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck35" id="OutletCheck35" value="1" onclick="estimateSystemOutletChack(35);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag35" id="FeeFlag35" value="" /><input type="hidden" name="SuperBigFlag35" id="SuperBigFlag35" value="" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName35" id="ProductName35" value="" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine35">Rコード <input type="text" class="ProductCode3" name="RCode35" id="RCode35" value="" maxlength="6" onchange="estimateSystemProductSearchRICOH(35);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea35"><div class="InventoryLayer" id="InventoryLayer35"></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck35" id="OpenCheck35" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice35" id="RegularPrice35" value="" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice35" id="NormalPrice35" value="" readonly onfocus="estimateSystemCursorAdvance('normal',35);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate35" id="NormalRate35" value="" readonly onfocus="estimateSystemCursorAdvance('normal',35);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate35" id="UnitRate35" value="" maxlength="5" onchange="estimateSystemUnitPercent(35, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice35" id="UnitPrice35" value="" maxlength="10" onchange="estimateSystemUnitPercent(35, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity35" id="Quantity35" value="" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(35); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice35" id="SubTotalPrice35" value="" readonly onfocus="estimateSystemCursorAdvance('sub',35);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime35" id="DeliveryTime35" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo35" id="Memo35" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice35"></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka35" id="EigyouGenka35" value="" readonly onfocus="estimateSystemCursorAdvance('next',35);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice35" id="MarginPrice35" value="" readonly onfocus="estimateSystemCursorAdvance('next',35);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice35" id="LimitPrice35" value="" readonly onfocus="estimateSystemCursorAdvance('next',35);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal35" id="MarginTotal35" value="" readonly onfocus="estimateSystemCursorAdvance('next',35);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate35" id="MarginRate35" value="" readonly onfocus="estimateSystemCursorAdvance('next',35);" />%</p>
        </td>
        <td id="MarginRank35"></td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment35" id="PurchaseComment35" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment35" id="DevLeaderComment35" readonly></textarea><input type="hidden" name="AutoAnswerFlag35" id="AutoAnswerFlag35" value="" /><input type="hidden" name="ImportantFlag35" id="ImportantFlag35" value="" /></p>
        </td>
        <td class="td_project"></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther35" id="RivalOther35" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker35" id="RivalMaker35" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku35" id="RivalSku35" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice35" id="RivalPrice35" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice35" id="LeaderPrice35" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',35);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate35" id="LeaderRate35" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',35);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice35" id="CorrectionPrice35" value="" readonly onfocus="estimateSystemCursorAdvance('next',35);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate35" id="CorrectionRate35" value="" readonly onfocus="estimateSystemCursorAdvance('next',35);" />%</p>
        </td>
        <td class="td_project">

        </td>
      </tr>

      <tr id="Column_36" class="tr_no_disp">
        <td><input type="text" class="ColumnNo" name="ColumnNo36" id="ColumnNo36" value="36" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(36);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck36" id="DeleteCheck36" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('36');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(36);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode36" id="ProductCode36" value="" maxlength="20" onchange="estimateSystemProductSearch(36);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck36" id="OutletCheck36" value="1" onclick="estimateSystemOutletChack(36);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag36" id="FeeFlag36" value="" /><input type="hidden" name="SuperBigFlag36" id="SuperBigFlag36" value="" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName36" id="ProductName36" value="" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine36">Rコード <input type="text" class="ProductCode3" name="RCode36" id="RCode36" value="" maxlength="6" onchange="estimateSystemProductSearchRICOH(36);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea36"><div class="InventoryLayer" id="InventoryLayer36"></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck36" id="OpenCheck36" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice36" id="RegularPrice36" value="" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice36" id="NormalPrice36" value="" readonly onfocus="estimateSystemCursorAdvance('normal',36);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate36" id="NormalRate36" value="" readonly onfocus="estimateSystemCursorAdvance('normal',36);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate36" id="UnitRate36" value="" maxlength="5" onchange="estimateSystemUnitPercent(36, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice36" id="UnitPrice36" value="" maxlength="10" onchange="estimateSystemUnitPercent(36, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity36" id="Quantity36" value="" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(36); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice36" id="SubTotalPrice36" value="" readonly onfocus="estimateSystemCursorAdvance('sub',36);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime36" id="DeliveryTime36" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo36" id="Memo36" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice36"></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka36" id="EigyouGenka36" value="" readonly onfocus="estimateSystemCursorAdvance('next',36);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice36" id="MarginPrice36" value="" readonly onfocus="estimateSystemCursorAdvance('next',36);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice36" id="LimitPrice36" value="" readonly onfocus="estimateSystemCursorAdvance('next',36);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal36" id="MarginTotal36" value="" readonly onfocus="estimateSystemCursorAdvance('next',36);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate36" id="MarginRate36" value="" readonly onfocus="estimateSystemCursorAdvance('next',36);" />%</p>
        </td>
        <td id="MarginRank36"></td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment36" id="PurchaseComment36" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment36" id="DevLeaderComment36" readonly></textarea><input type="hidden" name="AutoAnswerFlag36" id="AutoAnswerFlag36" value="" /><input type="hidden" name="ImportantFlag36" id="ImportantFlag36" value="" /></p>
        </td>
        <td class="td_project"></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther36" id="RivalOther36" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker36" id="RivalMaker36" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku36" id="RivalSku36" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice36" id="RivalPrice36" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice36" id="LeaderPrice36" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',36);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate36" id="LeaderRate36" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',36);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice36" id="CorrectionPrice36" value="" readonly onfocus="estimateSystemCursorAdvance('next',36);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate36" id="CorrectionRate36" value="" readonly onfocus="estimateSystemCursorAdvance('next',36);" />%</p>
        </td>
        <td class="td_project">

        </td>
      </tr>

      <tr id="Column_37" class="tr_no_disp">
        <td><input type="text" class="ColumnNo" name="ColumnNo37" id="ColumnNo37" value="37" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(37);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck37" id="DeleteCheck37" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('37');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(37);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode37" id="ProductCode37" value="" maxlength="20" onchange="estimateSystemProductSearch(37);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck37" id="OutletCheck37" value="1" onclick="estimateSystemOutletChack(37);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag37" id="FeeFlag37" value="" /><input type="hidden" name="SuperBigFlag37" id="SuperBigFlag37" value="" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName37" id="ProductName37" value="" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine37">Rコード <input type="text" class="ProductCode3" name="RCode37" id="RCode37" value="" maxlength="6" onchange="estimateSystemProductSearchRICOH(37);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea37"><div class="InventoryLayer" id="InventoryLayer37"></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck37" id="OpenCheck37" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice37" id="RegularPrice37" value="" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice37" id="NormalPrice37" value="" readonly onfocus="estimateSystemCursorAdvance('normal',37);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate37" id="NormalRate37" value="" readonly onfocus="estimateSystemCursorAdvance('normal',37);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate37" id="UnitRate37" value="" maxlength="5" onchange="estimateSystemUnitPercent(37, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice37" id="UnitPrice37" value="" maxlength="10" onchange="estimateSystemUnitPercent(37, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity37" id="Quantity37" value="" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(37); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice37" id="SubTotalPrice37" value="" readonly onfocus="estimateSystemCursorAdvance('sub',37);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime37" id="DeliveryTime37" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo37" id="Memo37" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice37"></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka37" id="EigyouGenka37" value="" readonly onfocus="estimateSystemCursorAdvance('next',37);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice37" id="MarginPrice37" value="" readonly onfocus="estimateSystemCursorAdvance('next',37);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice37" id="LimitPrice37" value="" readonly onfocus="estimateSystemCursorAdvance('next',37);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal37" id="MarginTotal37" value="" readonly onfocus="estimateSystemCursorAdvance('next',37);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate37" id="MarginRate37" value="" readonly onfocus="estimateSystemCursorAdvance('next',37);" />%</p>
        </td>
        <td id="MarginRank37"></td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment37" id="PurchaseComment37" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment37" id="DevLeaderComment37" readonly></textarea><input type="hidden" name="AutoAnswerFlag37" id="AutoAnswerFlag37" value="" /><input type="hidden" name="ImportantFlag37" id="ImportantFlag37" value="" /></p>
        </td>
        <td class="td_project"></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther37" id="RivalOther37" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker37" id="RivalMaker37" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku37" id="RivalSku37" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice37" id="RivalPrice37" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice37" id="LeaderPrice37" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',37);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate37" id="LeaderRate37" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',37);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice37" id="CorrectionPrice37" value="" readonly onfocus="estimateSystemCursorAdvance('next',37);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate37" id="CorrectionRate37" value="" readonly onfocus="estimateSystemCursorAdvance('next',37);" />%</p>
        </td>
        <td class="td_project">

        </td>
      </tr>

      <tr id="Column_38" class="tr_no_disp">
        <td><input type="text" class="ColumnNo" name="ColumnNo38" id="ColumnNo38" value="38" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(38);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck38" id="DeleteCheck38" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('38');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(38);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode38" id="ProductCode38" value="" maxlength="20" onchange="estimateSystemProductSearch(38);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck38" id="OutletCheck38" value="1" onclick="estimateSystemOutletChack(38);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag38" id="FeeFlag38" value="" /><input type="hidden" name="SuperBigFlag38" id="SuperBigFlag38" value="" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName38" id="ProductName38" value="" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine38">Rコード <input type="text" class="ProductCode3" name="RCode38" id="RCode38" value="" maxlength="6" onchange="estimateSystemProductSearchRICOH(38);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea38"><div class="InventoryLayer" id="InventoryLayer38"></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck38" id="OpenCheck38" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice38" id="RegularPrice38" value="" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice38" id="NormalPrice38" value="" readonly onfocus="estimateSystemCursorAdvance('normal',38);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate38" id="NormalRate38" value="" readonly onfocus="estimateSystemCursorAdvance('normal',38);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate38" id="UnitRate38" value="" maxlength="5" onchange="estimateSystemUnitPercent(38, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice38" id="UnitPrice38" value="" maxlength="10" onchange="estimateSystemUnitPercent(38, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity38" id="Quantity38" value="" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(38); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice38" id="SubTotalPrice38" value="" readonly onfocus="estimateSystemCursorAdvance('sub',38);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime38" id="DeliveryTime38" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo38" id="Memo38" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice38"></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka38" id="EigyouGenka38" value="" readonly onfocus="estimateSystemCursorAdvance('next',38);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice38" id="MarginPrice38" value="" readonly onfocus="estimateSystemCursorAdvance('next',38);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice38" id="LimitPrice38" value="" readonly onfocus="estimateSystemCursorAdvance('next',38);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal38" id="MarginTotal38" value="" readonly onfocus="estimateSystemCursorAdvance('next',38);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate38" id="MarginRate38" value="" readonly onfocus="estimateSystemCursorAdvance('next',38);" />%</p>
        </td>
        <td id="MarginRank38"></td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment38" id="PurchaseComment38" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment38" id="DevLeaderComment38" readonly></textarea><input type="hidden" name="AutoAnswerFlag38" id="AutoAnswerFlag38" value="" /><input type="hidden" name="ImportantFlag38" id="ImportantFlag38" value="" /></p>
        </td>
        <td class="td_project"></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther38" id="RivalOther38" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker38" id="RivalMaker38" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku38" id="RivalSku38" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice38" id="RivalPrice38" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice38" id="LeaderPrice38" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',38);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate38" id="LeaderRate38" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',38);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice38" id="CorrectionPrice38" value="" readonly onfocus="estimateSystemCursorAdvance('next',38);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate38" id="CorrectionRate38" value="" readonly onfocus="estimateSystemCursorAdvance('next',38);" />%</p>
        </td>
        <td class="td_project">

        </td>
      </tr>

      <tr id="Column_39" class="tr_no_disp">
        <td><input type="text" class="ColumnNo" name="ColumnNo39" id="ColumnNo39" value="39" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(39);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck39" id="DeleteCheck39" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('39');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(39);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode39" id="ProductCode39" value="" maxlength="20" onchange="estimateSystemProductSearch(39);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck39" id="OutletCheck39" value="1" onclick="estimateSystemOutletChack(39);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag39" id="FeeFlag39" value="" /><input type="hidden" name="SuperBigFlag39" id="SuperBigFlag39" value="" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName39" id="ProductName39" value="" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine39">Rコード <input type="text" class="ProductCode3" name="RCode39" id="RCode39" value="" maxlength="6" onchange="estimateSystemProductSearchRICOH(39);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea39"><div class="InventoryLayer" id="InventoryLayer39"></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck39" id="OpenCheck39" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice39" id="RegularPrice39" value="" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice39" id="NormalPrice39" value="" readonly onfocus="estimateSystemCursorAdvance('normal',39);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate39" id="NormalRate39" value="" readonly onfocus="estimateSystemCursorAdvance('normal',39);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate39" id="UnitRate39" value="" maxlength="5" onchange="estimateSystemUnitPercent(39, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice39" id="UnitPrice39" value="" maxlength="10" onchange="estimateSystemUnitPercent(39, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity39" id="Quantity39" value="" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(39); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice39" id="SubTotalPrice39" value="" readonly onfocus="estimateSystemCursorAdvance('sub',39);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime39" id="DeliveryTime39" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo39" id="Memo39" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice39"></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka39" id="EigyouGenka39" value="" readonly onfocus="estimateSystemCursorAdvance('next',39);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice39" id="MarginPrice39" value="" readonly onfocus="estimateSystemCursorAdvance('next',39);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice39" id="LimitPrice39" value="" readonly onfocus="estimateSystemCursorAdvance('next',39);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal39" id="MarginTotal39" value="" readonly onfocus="estimateSystemCursorAdvance('next',39);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate39" id="MarginRate39" value="" readonly onfocus="estimateSystemCursorAdvance('next',39);" />%</p>
        </td>
        <td id="MarginRank39"></td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment39" id="PurchaseComment39" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment39" id="DevLeaderComment39" readonly></textarea><input type="hidden" name="AutoAnswerFlag39" id="AutoAnswerFlag39" value="" /><input type="hidden" name="ImportantFlag39" id="ImportantFlag39" value="" /></p>
        </td>
        <td class="td_project"></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther39" id="RivalOther39" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker39" id="RivalMaker39" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku39" id="RivalSku39" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice39" id="RivalPrice39" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice39" id="LeaderPrice39" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',39);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate39" id="LeaderRate39" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',39);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice39" id="CorrectionPrice39" value="" readonly onfocus="estimateSystemCursorAdvance('next',39);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate39" id="CorrectionRate39" value="" readonly onfocus="estimateSystemCursorAdvance('next',39);" />%</p>
        </td>
        <td class="td_project">

        </td>
      </tr>

      <tr id="Column_40" class="tr_no_disp">
        <td><input type="text" class="ColumnNo" name="ColumnNo40" id="ColumnNo40" value="40" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(40);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck40" id="DeleteCheck40" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('40');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(40);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode40" id="ProductCode40" value="" maxlength="20" onchange="estimateSystemProductSearch(40);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck40" id="OutletCheck40" value="1" onclick="estimateSystemOutletChack(40);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag40" id="FeeFlag40" value="" /><input type="hidden" name="SuperBigFlag40" id="SuperBigFlag40" value="" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName40" id="ProductName40" value="" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine40">Rコード <input type="text" class="ProductCode3" name="RCode40" id="RCode40" value="" maxlength="6" onchange="estimateSystemProductSearchRICOH(40);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea40"><div class="InventoryLayer" id="InventoryLayer40"></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck40" id="OpenCheck40" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice40" id="RegularPrice40" value="" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice40" id="NormalPrice40" value="" readonly onfocus="estimateSystemCursorAdvance('normal',40);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate40" id="NormalRate40" value="" readonly onfocus="estimateSystemCursorAdvance('normal',40);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate40" id="UnitRate40" value="" maxlength="5" onchange="estimateSystemUnitPercent(40, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice40" id="UnitPrice40" value="" maxlength="10" onchange="estimateSystemUnitPercent(40, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity40" id="Quantity40" value="" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(40); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice40" id="SubTotalPrice40" value="" readonly onfocus="estimateSystemCursorAdvance('sub',40);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime40" id="DeliveryTime40" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo40" id="Memo40" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice40"></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka40" id="EigyouGenka40" value="" readonly onfocus="estimateSystemCursorAdvance('next',40);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice40" id="MarginPrice40" value="" readonly onfocus="estimateSystemCursorAdvance('next',40);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice40" id="LimitPrice40" value="" readonly onfocus="estimateSystemCursorAdvance('next',40);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal40" id="MarginTotal40" value="" readonly onfocus="estimateSystemCursorAdvance('next',40);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate40" id="MarginRate40" value="" readonly onfocus="estimateSystemCursorAdvance('next',40);" />%</p>
        </td>
        <td id="MarginRank40"></td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment40" id="PurchaseComment40" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment40" id="DevLeaderComment40" readonly></textarea><input type="hidden" name="AutoAnswerFlag40" id="AutoAnswerFlag40" value="" /><input type="hidden" name="ImportantFlag40" id="ImportantFlag40" value="" /></p>
        </td>
        <td class="td_project"></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther40" id="RivalOther40" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker40" id="RivalMaker40" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku40" id="RivalSku40" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice40" id="RivalPrice40" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice40" id="LeaderPrice40" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',40);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate40" id="LeaderRate40" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',40);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice40" id="CorrectionPrice40" value="" readonly onfocus="estimateSystemCursorAdvance('next',40);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate40" id="CorrectionRate40" value="" readonly onfocus="estimateSystemCursorAdvance('next',40);" />%</p>
        </td>
        <td class="td_project">

        </td>
      </tr>

      <tr id="Column_41" class="tr_no_disp">
        <td><input type="text" class="ColumnNo" name="ColumnNo41" id="ColumnNo41" value="41" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(41);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck41" id="DeleteCheck41" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('41');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(41);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode41" id="ProductCode41" value="" maxlength="20" onchange="estimateSystemProductSearch(41);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck41" id="OutletCheck41" value="1" onclick="estimateSystemOutletChack(41);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag41" id="FeeFlag41" value="" /><input type="hidden" name="SuperBigFlag41" id="SuperBigFlag41" value="" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName41" id="ProductName41" value="" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine41">Rコード <input type="text" class="ProductCode3" name="RCode41" id="RCode41" value="" maxlength="6" onchange="estimateSystemProductSearchRICOH(41);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea41"><div class="InventoryLayer" id="InventoryLayer41"></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck41" id="OpenCheck41" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice41" id="RegularPrice41" value="" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice41" id="NormalPrice41" value="" readonly onfocus="estimateSystemCursorAdvance('normal',41);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate41" id="NormalRate41" value="" readonly onfocus="estimateSystemCursorAdvance('normal',41);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate41" id="UnitRate41" value="" maxlength="5" onchange="estimateSystemUnitPercent(41, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice41" id="UnitPrice41" value="" maxlength="10" onchange="estimateSystemUnitPercent(41, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity41" id="Quantity41" value="" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(41); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice41" id="SubTotalPrice41" value="" readonly onfocus="estimateSystemCursorAdvance('sub',41);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime41" id="DeliveryTime41" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo41" id="Memo41" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice41"></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka41" id="EigyouGenka41" value="" readonly onfocus="estimateSystemCursorAdvance('next',41);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice41" id="MarginPrice41" value="" readonly onfocus="estimateSystemCursorAdvance('next',41);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice41" id="LimitPrice41" value="" readonly onfocus="estimateSystemCursorAdvance('next',41);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal41" id="MarginTotal41" value="" readonly onfocus="estimateSystemCursorAdvance('next',41);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate41" id="MarginRate41" value="" readonly onfocus="estimateSystemCursorAdvance('next',41);" />%</p>
        </td>
        <td id="MarginRank41"></td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment41" id="PurchaseComment41" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment41" id="DevLeaderComment41" readonly></textarea><input type="hidden" name="AutoAnswerFlag41" id="AutoAnswerFlag41" value="" /><input type="hidden" name="ImportantFlag41" id="ImportantFlag41" value="" /></p>
        </td>
        <td class="td_project"></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther41" id="RivalOther41" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker41" id="RivalMaker41" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku41" id="RivalSku41" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice41" id="RivalPrice41" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice41" id="LeaderPrice41" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',41);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate41" id="LeaderRate41" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',41);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice41" id="CorrectionPrice41" value="" readonly onfocus="estimateSystemCursorAdvance('next',41);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate41" id="CorrectionRate41" value="" readonly onfocus="estimateSystemCursorAdvance('next',41);" />%</p>
        </td>
        <td class="td_project">

        </td>
      </tr>

      <tr id="Column_42" class="tr_no_disp">
        <td><input type="text" class="ColumnNo" name="ColumnNo42" id="ColumnNo42" value="42" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(42);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck42" id="DeleteCheck42" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('42');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(42);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode42" id="ProductCode42" value="" maxlength="20" onchange="estimateSystemProductSearch(42);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck42" id="OutletCheck42" value="1" onclick="estimateSystemOutletChack(42);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag42" id="FeeFlag42" value="" /><input type="hidden" name="SuperBigFlag42" id="SuperBigFlag42" value="" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName42" id="ProductName42" value="" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine42">Rコード <input type="text" class="ProductCode3" name="RCode42" id="RCode42" value="" maxlength="6" onchange="estimateSystemProductSearchRICOH(42);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea42"><div class="InventoryLayer" id="InventoryLayer42"></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck42" id="OpenCheck42" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice42" id="RegularPrice42" value="" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice42" id="NormalPrice42" value="" readonly onfocus="estimateSystemCursorAdvance('normal',42);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate42" id="NormalRate42" value="" readonly onfocus="estimateSystemCursorAdvance('normal',42);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate42" id="UnitRate42" value="" maxlength="5" onchange="estimateSystemUnitPercent(42, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice42" id="UnitPrice42" value="" maxlength="10" onchange="estimateSystemUnitPercent(42, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity42" id="Quantity42" value="" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(42); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice42" id="SubTotalPrice42" value="" readonly onfocus="estimateSystemCursorAdvance('sub',42);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime42" id="DeliveryTime42" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo42" id="Memo42" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice42"></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka42" id="EigyouGenka42" value="" readonly onfocus="estimateSystemCursorAdvance('next',42);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice42" id="MarginPrice42" value="" readonly onfocus="estimateSystemCursorAdvance('next',42);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice42" id="LimitPrice42" value="" readonly onfocus="estimateSystemCursorAdvance('next',42);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal42" id="MarginTotal42" value="" readonly onfocus="estimateSystemCursorAdvance('next',42);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate42" id="MarginRate42" value="" readonly onfocus="estimateSystemCursorAdvance('next',42);" />%</p>
        </td>
        <td id="MarginRank42"></td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment42" id="PurchaseComment42" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment42" id="DevLeaderComment42" readonly></textarea><input type="hidden" name="AutoAnswerFlag42" id="AutoAnswerFlag42" value="" /><input type="hidden" name="ImportantFlag42" id="ImportantFlag42" value="" /></p>
        </td>
        <td class="td_project"></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther42" id="RivalOther42" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker42" id="RivalMaker42" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku42" id="RivalSku42" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice42" id="RivalPrice42" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice42" id="LeaderPrice42" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',42);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate42" id="LeaderRate42" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',42);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice42" id="CorrectionPrice42" value="" readonly onfocus="estimateSystemCursorAdvance('next',42);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate42" id="CorrectionRate42" value="" readonly onfocus="estimateSystemCursorAdvance('next',42);" />%</p>
        </td>
        <td class="td_project">

        </td>
      </tr>

      <tr id="Column_43" class="tr_no_disp">
        <td><input type="text" class="ColumnNo" name="ColumnNo43" id="ColumnNo43" value="43" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(43);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck43" id="DeleteCheck43" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('43');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(43);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode43" id="ProductCode43" value="" maxlength="20" onchange="estimateSystemProductSearch(43);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck43" id="OutletCheck43" value="1" onclick="estimateSystemOutletChack(43);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag43" id="FeeFlag43" value="" /><input type="hidden" name="SuperBigFlag43" id="SuperBigFlag43" value="" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName43" id="ProductName43" value="" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine43">Rコード <input type="text" class="ProductCode3" name="RCode43" id="RCode43" value="" maxlength="6" onchange="estimateSystemProductSearchRICOH(43);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea43"><div class="InventoryLayer" id="InventoryLayer43"></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck43" id="OpenCheck43" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice43" id="RegularPrice43" value="" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice43" id="NormalPrice43" value="" readonly onfocus="estimateSystemCursorAdvance('normal',43);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate43" id="NormalRate43" value="" readonly onfocus="estimateSystemCursorAdvance('normal',43);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate43" id="UnitRate43" value="" maxlength="5" onchange="estimateSystemUnitPercent(43, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice43" id="UnitPrice43" value="" maxlength="10" onchange="estimateSystemUnitPercent(43, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity43" id="Quantity43" value="" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(43); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice43" id="SubTotalPrice43" value="" readonly onfocus="estimateSystemCursorAdvance('sub',43);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime43" id="DeliveryTime43" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo43" id="Memo43" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice43"></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka43" id="EigyouGenka43" value="" readonly onfocus="estimateSystemCursorAdvance('next',43);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice43" id="MarginPrice43" value="" readonly onfocus="estimateSystemCursorAdvance('next',43);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice43" id="LimitPrice43" value="" readonly onfocus="estimateSystemCursorAdvance('next',43);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal43" id="MarginTotal43" value="" readonly onfocus="estimateSystemCursorAdvance('next',43);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate43" id="MarginRate43" value="" readonly onfocus="estimateSystemCursorAdvance('next',43);" />%</p>
        </td>
        <td id="MarginRank43"></td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment43" id="PurchaseComment43" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment43" id="DevLeaderComment43" readonly></textarea><input type="hidden" name="AutoAnswerFlag43" id="AutoAnswerFlag43" value="" /><input type="hidden" name="ImportantFlag43" id="ImportantFlag43" value="" /></p>
        </td>
        <td class="td_project"></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther43" id="RivalOther43" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker43" id="RivalMaker43" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku43" id="RivalSku43" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice43" id="RivalPrice43" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice43" id="LeaderPrice43" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',43);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate43" id="LeaderRate43" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',43);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice43" id="CorrectionPrice43" value="" readonly onfocus="estimateSystemCursorAdvance('next',43);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate43" id="CorrectionRate43" value="" readonly onfocus="estimateSystemCursorAdvance('next',43);" />%</p>
        </td>
        <td class="td_project">

        </td>
      </tr>

      <tr id="Column_44" class="tr_no_disp">
        <td><input type="text" class="ColumnNo" name="ColumnNo44" id="ColumnNo44" value="44" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(44);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck44" id="DeleteCheck44" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('44');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(44);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode44" id="ProductCode44" value="" maxlength="20" onchange="estimateSystemProductSearch(44);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck44" id="OutletCheck44" value="1" onclick="estimateSystemOutletChack(44);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag44" id="FeeFlag44" value="" /><input type="hidden" name="SuperBigFlag44" id="SuperBigFlag44" value="" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName44" id="ProductName44" value="" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine44">Rコード <input type="text" class="ProductCode3" name="RCode44" id="RCode44" value="" maxlength="6" onchange="estimateSystemProductSearchRICOH(44);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea44"><div class="InventoryLayer" id="InventoryLayer44"></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck44" id="OpenCheck44" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice44" id="RegularPrice44" value="" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice44" id="NormalPrice44" value="" readonly onfocus="estimateSystemCursorAdvance('normal',44);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate44" id="NormalRate44" value="" readonly onfocus="estimateSystemCursorAdvance('normal',44);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate44" id="UnitRate44" value="" maxlength="5" onchange="estimateSystemUnitPercent(44, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice44" id="UnitPrice44" value="" maxlength="10" onchange="estimateSystemUnitPercent(44, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity44" id="Quantity44" value="" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(44); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice44" id="SubTotalPrice44" value="" readonly onfocus="estimateSystemCursorAdvance('sub',44);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime44" id="DeliveryTime44" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo44" id="Memo44" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice44"></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka44" id="EigyouGenka44" value="" readonly onfocus="estimateSystemCursorAdvance('next',44);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice44" id="MarginPrice44" value="" readonly onfocus="estimateSystemCursorAdvance('next',44);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice44" id="LimitPrice44" value="" readonly onfocus="estimateSystemCursorAdvance('next',44);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal44" id="MarginTotal44" value="" readonly onfocus="estimateSystemCursorAdvance('next',44);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate44" id="MarginRate44" value="" readonly onfocus="estimateSystemCursorAdvance('next',44);" />%</p>
        </td>
        <td id="MarginRank44"></td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment44" id="PurchaseComment44" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment44" id="DevLeaderComment44" readonly></textarea><input type="hidden" name="AutoAnswerFlag44" id="AutoAnswerFlag44" value="" /><input type="hidden" name="ImportantFlag44" id="ImportantFlag44" value="" /></p>
        </td>
        <td class="td_project"></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther44" id="RivalOther44" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker44" id="RivalMaker44" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku44" id="RivalSku44" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice44" id="RivalPrice44" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice44" id="LeaderPrice44" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',44);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate44" id="LeaderRate44" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',44);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice44" id="CorrectionPrice44" value="" readonly onfocus="estimateSystemCursorAdvance('next',44);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate44" id="CorrectionRate44" value="" readonly onfocus="estimateSystemCursorAdvance('next',44);" />%</p>
        </td>
        <td class="td_project">

        </td>
      </tr>

      <tr id="Column_45" class="tr_no_disp">
        <td><input type="text" class="ColumnNo" name="ColumnNo45" id="ColumnNo45" value="45" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(45);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck45" id="DeleteCheck45" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('45');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(45);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode45" id="ProductCode45" value="" maxlength="20" onchange="estimateSystemProductSearch(45);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck45" id="OutletCheck45" value="1" onclick="estimateSystemOutletChack(45);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag45" id="FeeFlag45" value="" /><input type="hidden" name="SuperBigFlag45" id="SuperBigFlag45" value="" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName45" id="ProductName45" value="" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine45">Rコード <input type="text" class="ProductCode3" name="RCode45" id="RCode45" value="" maxlength="6" onchange="estimateSystemProductSearchRICOH(45);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea45"><div class="InventoryLayer" id="InventoryLayer45"></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck45" id="OpenCheck45" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice45" id="RegularPrice45" value="" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice45" id="NormalPrice45" value="" readonly onfocus="estimateSystemCursorAdvance('normal',45);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate45" id="NormalRate45" value="" readonly onfocus="estimateSystemCursorAdvance('normal',45);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate45" id="UnitRate45" value="" maxlength="5" onchange="estimateSystemUnitPercent(45, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice45" id="UnitPrice45" value="" maxlength="10" onchange="estimateSystemUnitPercent(45, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity45" id="Quantity45" value="" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(45); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice45" id="SubTotalPrice45" value="" readonly onfocus="estimateSystemCursorAdvance('sub',45);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime45" id="DeliveryTime45" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo45" id="Memo45" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice45"></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka45" id="EigyouGenka45" value="" readonly onfocus="estimateSystemCursorAdvance('next',45);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice45" id="MarginPrice45" value="" readonly onfocus="estimateSystemCursorAdvance('next',45);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice45" id="LimitPrice45" value="" readonly onfocus="estimateSystemCursorAdvance('next',45);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal45" id="MarginTotal45" value="" readonly onfocus="estimateSystemCursorAdvance('next',45);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate45" id="MarginRate45" value="" readonly onfocus="estimateSystemCursorAdvance('next',45);" />%</p>
        </td>
        <td id="MarginRank45"></td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment45" id="PurchaseComment45" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment45" id="DevLeaderComment45" readonly></textarea><input type="hidden" name="AutoAnswerFlag45" id="AutoAnswerFlag45" value="" /><input type="hidden" name="ImportantFlag45" id="ImportantFlag45" value="" /></p>
        </td>
        <td class="td_project"></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther45" id="RivalOther45" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker45" id="RivalMaker45" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku45" id="RivalSku45" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice45" id="RivalPrice45" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice45" id="LeaderPrice45" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',45);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate45" id="LeaderRate45" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',45);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice45" id="CorrectionPrice45" value="" readonly onfocus="estimateSystemCursorAdvance('next',45);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate45" id="CorrectionRate45" value="" readonly onfocus="estimateSystemCursorAdvance('next',45);" />%</p>
        </td>
        <td class="td_project">

        </td>
      </tr>

      <tr id="Column_46" class="tr_no_disp">
        <td><input type="text" class="ColumnNo" name="ColumnNo46" id="ColumnNo46" value="46" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(46);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck46" id="DeleteCheck46" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('46');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(46);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode46" id="ProductCode46" value="" maxlength="20" onchange="estimateSystemProductSearch(46);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck46" id="OutletCheck46" value="1" onclick="estimateSystemOutletChack(46);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag46" id="FeeFlag46" value="" /><input type="hidden" name="SuperBigFlag46" id="SuperBigFlag46" value="" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName46" id="ProductName46" value="" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine46">Rコード <input type="text" class="ProductCode3" name="RCode46" id="RCode46" value="" maxlength="6" onchange="estimateSystemProductSearchRICOH(46);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea46"><div class="InventoryLayer" id="InventoryLayer46"></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck46" id="OpenCheck46" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice46" id="RegularPrice46" value="" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice46" id="NormalPrice46" value="" readonly onfocus="estimateSystemCursorAdvance('normal',46);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate46" id="NormalRate46" value="" readonly onfocus="estimateSystemCursorAdvance('normal',46);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate46" id="UnitRate46" value="" maxlength="5" onchange="estimateSystemUnitPercent(46, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice46" id="UnitPrice46" value="" maxlength="10" onchange="estimateSystemUnitPercent(46, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity46" id="Quantity46" value="" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(46); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice46" id="SubTotalPrice46" value="" readonly onfocus="estimateSystemCursorAdvance('sub',46);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime46" id="DeliveryTime46" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo46" id="Memo46" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice46"></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka46" id="EigyouGenka46" value="" readonly onfocus="estimateSystemCursorAdvance('next',46);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice46" id="MarginPrice46" value="" readonly onfocus="estimateSystemCursorAdvance('next',46);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice46" id="LimitPrice46" value="" readonly onfocus="estimateSystemCursorAdvance('next',46);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal46" id="MarginTotal46" value="" readonly onfocus="estimateSystemCursorAdvance('next',46);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate46" id="MarginRate46" value="" readonly onfocus="estimateSystemCursorAdvance('next',46);" />%</p>
        </td>
        <td id="MarginRank46"></td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment46" id="PurchaseComment46" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment46" id="DevLeaderComment46" readonly></textarea><input type="hidden" name="AutoAnswerFlag46" id="AutoAnswerFlag46" value="" /><input type="hidden" name="ImportantFlag46" id="ImportantFlag46" value="" /></p>
        </td>
        <td class="td_project"></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther46" id="RivalOther46" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker46" id="RivalMaker46" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku46" id="RivalSku46" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice46" id="RivalPrice46" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice46" id="LeaderPrice46" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',46);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate46" id="LeaderRate46" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',46);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice46" id="CorrectionPrice46" value="" readonly onfocus="estimateSystemCursorAdvance('next',46);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate46" id="CorrectionRate46" value="" readonly onfocus="estimateSystemCursorAdvance('next',46);" />%</p>
        </td>
        <td class="td_project">

        </td>
      </tr>

      <tr id="Column_47" class="tr_no_disp">
        <td><input type="text" class="ColumnNo" name="ColumnNo47" id="ColumnNo47" value="47" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(47);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck47" id="DeleteCheck47" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('47');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(47);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode47" id="ProductCode47" value="" maxlength="20" onchange="estimateSystemProductSearch(47);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck47" id="OutletCheck47" value="1" onclick="estimateSystemOutletChack(47);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag47" id="FeeFlag47" value="" /><input type="hidden" name="SuperBigFlag47" id="SuperBigFlag47" value="" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName47" id="ProductName47" value="" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine47">Rコード <input type="text" class="ProductCode3" name="RCode47" id="RCode47" value="" maxlength="6" onchange="estimateSystemProductSearchRICOH(47);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea47"><div class="InventoryLayer" id="InventoryLayer47"></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck47" id="OpenCheck47" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice47" id="RegularPrice47" value="" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice47" id="NormalPrice47" value="" readonly onfocus="estimateSystemCursorAdvance('normal',47);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate47" id="NormalRate47" value="" readonly onfocus="estimateSystemCursorAdvance('normal',47);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate47" id="UnitRate47" value="" maxlength="5" onchange="estimateSystemUnitPercent(47, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice47" id="UnitPrice47" value="" maxlength="10" onchange="estimateSystemUnitPercent(47, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity47" id="Quantity47" value="" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(47); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice47" id="SubTotalPrice47" value="" readonly onfocus="estimateSystemCursorAdvance('sub',47);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime47" id="DeliveryTime47" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo47" id="Memo47" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice47"></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka47" id="EigyouGenka47" value="" readonly onfocus="estimateSystemCursorAdvance('next',47);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice47" id="MarginPrice47" value="" readonly onfocus="estimateSystemCursorAdvance('next',47);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice47" id="LimitPrice47" value="" readonly onfocus="estimateSystemCursorAdvance('next',47);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal47" id="MarginTotal47" value="" readonly onfocus="estimateSystemCursorAdvance('next',47);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate47" id="MarginRate47" value="" readonly onfocus="estimateSystemCursorAdvance('next',47);" />%</p>
        </td>
        <td id="MarginRank47"></td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment47" id="PurchaseComment47" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment47" id="DevLeaderComment47" readonly></textarea><input type="hidden" name="AutoAnswerFlag47" id="AutoAnswerFlag47" value="" /><input type="hidden" name="ImportantFlag47" id="ImportantFlag47" value="" /></p>
        </td>
        <td class="td_project"></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther47" id="RivalOther47" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker47" id="RivalMaker47" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku47" id="RivalSku47" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice47" id="RivalPrice47" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice47" id="LeaderPrice47" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',47);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate47" id="LeaderRate47" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',47);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice47" id="CorrectionPrice47" value="" readonly onfocus="estimateSystemCursorAdvance('next',47);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate47" id="CorrectionRate47" value="" readonly onfocus="estimateSystemCursorAdvance('next',47);" />%</p>
        </td>
        <td class="td_project">

        </td>
      </tr>

      <tr id="Column_48" class="tr_no_disp">
        <td><input type="text" class="ColumnNo" name="ColumnNo48" id="ColumnNo48" value="48" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(48);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck48" id="DeleteCheck48" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('48');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(48);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode48" id="ProductCode48" value="" maxlength="20" onchange="estimateSystemProductSearch(48);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck48" id="OutletCheck48" value="1" onclick="estimateSystemOutletChack(48);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag48" id="FeeFlag48" value="" /><input type="hidden" name="SuperBigFlag48" id="SuperBigFlag48" value="" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName48" id="ProductName48" value="" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine48">Rコード <input type="text" class="ProductCode3" name="RCode48" id="RCode48" value="" maxlength="6" onchange="estimateSystemProductSearchRICOH(48);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea48"><div class="InventoryLayer" id="InventoryLayer48"></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck48" id="OpenCheck48" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice48" id="RegularPrice48" value="" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice48" id="NormalPrice48" value="" readonly onfocus="estimateSystemCursorAdvance('normal',48);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate48" id="NormalRate48" value="" readonly onfocus="estimateSystemCursorAdvance('normal',48);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate48" id="UnitRate48" value="" maxlength="5" onchange="estimateSystemUnitPercent(48, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice48" id="UnitPrice48" value="" maxlength="10" onchange="estimateSystemUnitPercent(48, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity48" id="Quantity48" value="" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(48); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice48" id="SubTotalPrice48" value="" readonly onfocus="estimateSystemCursorAdvance('sub',48);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime48" id="DeliveryTime48" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo48" id="Memo48" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice48"></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka48" id="EigyouGenka48" value="" readonly onfocus="estimateSystemCursorAdvance('next',48);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice48" id="MarginPrice48" value="" readonly onfocus="estimateSystemCursorAdvance('next',48);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice48" id="LimitPrice48" value="" readonly onfocus="estimateSystemCursorAdvance('next',48);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal48" id="MarginTotal48" value="" readonly onfocus="estimateSystemCursorAdvance('next',48);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate48" id="MarginRate48" value="" readonly onfocus="estimateSystemCursorAdvance('next',48);" />%</p>
        </td>
        <td id="MarginRank48"></td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment48" id="PurchaseComment48" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment48" id="DevLeaderComment48" readonly></textarea><input type="hidden" name="AutoAnswerFlag48" id="AutoAnswerFlag48" value="" /><input type="hidden" name="ImportantFlag48" id="ImportantFlag48" value="" /></p>
        </td>
        <td class="td_project"></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther48" id="RivalOther48" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker48" id="RivalMaker48" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku48" id="RivalSku48" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice48" id="RivalPrice48" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice48" id="LeaderPrice48" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',48);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate48" id="LeaderRate48" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',48);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice48" id="CorrectionPrice48" value="" readonly onfocus="estimateSystemCursorAdvance('next',48);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate48" id="CorrectionRate48" value="" readonly onfocus="estimateSystemCursorAdvance('next',48);" />%</p>
        </td>
        <td class="td_project">

        </td>
      </tr>

      <tr id="Column_49" class="tr_no_disp">
        <td><input type="text" class="ColumnNo" name="ColumnNo49" id="ColumnNo49" value="49" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(49);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck49" id="DeleteCheck49" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('49');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(49);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode49" id="ProductCode49" value="" maxlength="20" onchange="estimateSystemProductSearch(49);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck49" id="OutletCheck49" value="1" onclick="estimateSystemOutletChack(49);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag49" id="FeeFlag49" value="" /><input type="hidden" name="SuperBigFlag49" id="SuperBigFlag49" value="" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName49" id="ProductName49" value="" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine49">Rコード <input type="text" class="ProductCode3" name="RCode49" id="RCode49" value="" maxlength="6" onchange="estimateSystemProductSearchRICOH(49);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea49"><div class="InventoryLayer" id="InventoryLayer49"></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck49" id="OpenCheck49" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice49" id="RegularPrice49" value="" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice49" id="NormalPrice49" value="" readonly onfocus="estimateSystemCursorAdvance('normal',49);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate49" id="NormalRate49" value="" readonly onfocus="estimateSystemCursorAdvance('normal',49);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate49" id="UnitRate49" value="" maxlength="5" onchange="estimateSystemUnitPercent(49, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice49" id="UnitPrice49" value="" maxlength="10" onchange="estimateSystemUnitPercent(49, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity49" id="Quantity49" value="" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(49); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice49" id="SubTotalPrice49" value="" readonly onfocus="estimateSystemCursorAdvance('sub',49);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime49" id="DeliveryTime49" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo49" id="Memo49" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice49"></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka49" id="EigyouGenka49" value="" readonly onfocus="estimateSystemCursorAdvance('next',49);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice49" id="MarginPrice49" value="" readonly onfocus="estimateSystemCursorAdvance('next',49);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice49" id="LimitPrice49" value="" readonly onfocus="estimateSystemCursorAdvance('next',49);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal49" id="MarginTotal49" value="" readonly onfocus="estimateSystemCursorAdvance('next',49);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate49" id="MarginRate49" value="" readonly onfocus="estimateSystemCursorAdvance('next',49);" />%</p>
        </td>
        <td id="MarginRank49"></td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment49" id="PurchaseComment49" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment49" id="DevLeaderComment49" readonly></textarea><input type="hidden" name="AutoAnswerFlag49" id="AutoAnswerFlag49" value="" /><input type="hidden" name="ImportantFlag49" id="ImportantFlag49" value="" /></p>
        </td>
        <td class="td_project"></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther49" id="RivalOther49" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker49" id="RivalMaker49" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku49" id="RivalSku49" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice49" id="RivalPrice49" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice49" id="LeaderPrice49" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',49);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate49" id="LeaderRate49" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',49);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice49" id="CorrectionPrice49" value="" readonly onfocus="estimateSystemCursorAdvance('next',49);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate49" id="CorrectionRate49" value="" readonly onfocus="estimateSystemCursorAdvance('next',49);" />%</p>
        </td>
        <td class="td_project">

        </td>
      </tr>

      <tr id="Column_50" class="tr_no_disp">
        <td><input type="text" class="ColumnNo" name="ColumnNo50" id="ColumnNo50" value="50" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(50);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck50" id="DeleteCheck50" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('50');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(50);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode50" id="ProductCode50" value="" maxlength="20" onchange="estimateSystemProductSearch(50);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck50" id="OutletCheck50" value="1" onclick="estimateSystemOutletChack(50);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag50" id="FeeFlag50" value="" /><input type="hidden" name="SuperBigFlag50" id="SuperBigFlag50" value="" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName50" id="ProductName50" value="" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine50">Rコード <input type="text" class="ProductCode3" name="RCode50" id="RCode50" value="" maxlength="6" onchange="estimateSystemProductSearchRICOH(50);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea50"><div class="InventoryLayer" id="InventoryLayer50"></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck50" id="OpenCheck50" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice50" id="RegularPrice50" value="" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice50" id="NormalPrice50" value="" readonly onfocus="estimateSystemCursorAdvance('normal',50);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate50" id="NormalRate50" value="" readonly onfocus="estimateSystemCursorAdvance('normal',50);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate50" id="UnitRate50" value="" maxlength="5" onchange="estimateSystemUnitPercent(50, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice50" id="UnitPrice50" value="" maxlength="10" onchange="estimateSystemUnitPercent(50, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity50" id="Quantity50" value="" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(50); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice50" id="SubTotalPrice50" value="" readonly onfocus="estimateSystemCursorAdvance('sub',50);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime50" id="DeliveryTime50" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo50" id="Memo50" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice50"></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka50" id="EigyouGenka50" value="" readonly onfocus="estimateSystemCursorAdvance('next',50);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice50" id="MarginPrice50" value="" readonly onfocus="estimateSystemCursorAdvance('next',50);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice50" id="LimitPrice50" value="" readonly onfocus="estimateSystemCursorAdvance('next',50);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal50" id="MarginTotal50" value="" readonly onfocus="estimateSystemCursorAdvance('next',50);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate50" id="MarginRate50" value="" readonly onfocus="estimateSystemCursorAdvance('next',50);" />%</p>
        </td>
        <td id="MarginRank50"></td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment50" id="PurchaseComment50" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment50" id="DevLeaderComment50" readonly></textarea><input type="hidden" name="AutoAnswerFlag50" id="AutoAnswerFlag50" value="" /><input type="hidden" name="ImportantFlag50" id="ImportantFlag50" value="" /></p>
        </td>
        <td class="td_project"></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther50" id="RivalOther50" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker50" id="RivalMaker50" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku50" id="RivalSku50" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice50" id="RivalPrice50" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice50" id="LeaderPrice50" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',50);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate50" id="LeaderRate50" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',50);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice50" id="CorrectionPrice50" value="" readonly onfocus="estimateSystemCursorAdvance('next',50);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate50" id="CorrectionRate50" value="" readonly onfocus="estimateSystemCursorAdvance('next',50);" />%</p>
        </td>
        <td class="td_project">

        </td>
      </tr>

      <tr id="Column_51" class="tr_no_disp">
        <td><input type="text" class="ColumnNo" name="ColumnNo51" id="ColumnNo51" value="51" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(51);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck51" id="DeleteCheck51" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('51');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(51);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode51" id="ProductCode51" value="" maxlength="20" onchange="estimateSystemProductSearch(51);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck51" id="OutletCheck51" value="1" onclick="estimateSystemOutletChack(51);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag51" id="FeeFlag51" value="" /><input type="hidden" name="SuperBigFlag51" id="SuperBigFlag51" value="" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName51" id="ProductName51" value="" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine51">Rコード <input type="text" class="ProductCode3" name="RCode51" id="RCode51" value="" maxlength="6" onchange="estimateSystemProductSearchRICOH(51);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea51"><div class="InventoryLayer" id="InventoryLayer51"></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck51" id="OpenCheck51" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice51" id="RegularPrice51" value="" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice51" id="NormalPrice51" value="" readonly onfocus="estimateSystemCursorAdvance('normal',51);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate51" id="NormalRate51" value="" readonly onfocus="estimateSystemCursorAdvance('normal',51);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate51" id="UnitRate51" value="" maxlength="5" onchange="estimateSystemUnitPercent(51, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice51" id="UnitPrice51" value="" maxlength="10" onchange="estimateSystemUnitPercent(51, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity51" id="Quantity51" value="" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(51); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice51" id="SubTotalPrice51" value="" readonly onfocus="estimateSystemCursorAdvance('sub',51);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime51" id="DeliveryTime51" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo51" id="Memo51" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice51"></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka51" id="EigyouGenka51" value="" readonly onfocus="estimateSystemCursorAdvance('next',51);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice51" id="MarginPrice51" value="" readonly onfocus="estimateSystemCursorAdvance('next',51);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice51" id="LimitPrice51" value="" readonly onfocus="estimateSystemCursorAdvance('next',51);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal51" id="MarginTotal51" value="" readonly onfocus="estimateSystemCursorAdvance('next',51);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate51" id="MarginRate51" value="" readonly onfocus="estimateSystemCursorAdvance('next',51);" />%</p>
        </td>
        <td id="MarginRank51"></td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment51" id="PurchaseComment51" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment51" id="DevLeaderComment51" readonly></textarea><input type="hidden" name="AutoAnswerFlag51" id="AutoAnswerFlag51" value="" /><input type="hidden" name="ImportantFlag51" id="ImportantFlag51" value="" /></p>
        </td>
        <td class="td_project"></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther51" id="RivalOther51" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker51" id="RivalMaker51" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku51" id="RivalSku51" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice51" id="RivalPrice51" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice51" id="LeaderPrice51" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',51);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate51" id="LeaderRate51" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',51);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice51" id="CorrectionPrice51" value="" readonly onfocus="estimateSystemCursorAdvance('next',51);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate51" id="CorrectionRate51" value="" readonly onfocus="estimateSystemCursorAdvance('next',51);" />%</p>
        </td>
        <td class="td_project">

        </td>
      </tr>

      <tr id="Column_52" class="tr_no_disp">
        <td><input type="text" class="ColumnNo" name="ColumnNo52" id="ColumnNo52" value="52" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(52);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck52" id="DeleteCheck52" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('52');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(52);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode52" id="ProductCode52" value="" maxlength="20" onchange="estimateSystemProductSearch(52);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck52" id="OutletCheck52" value="1" onclick="estimateSystemOutletChack(52);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag52" id="FeeFlag52" value="" /><input type="hidden" name="SuperBigFlag52" id="SuperBigFlag52" value="" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName52" id="ProductName52" value="" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine52">Rコード <input type="text" class="ProductCode3" name="RCode52" id="RCode52" value="" maxlength="6" onchange="estimateSystemProductSearchRICOH(52);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea52"><div class="InventoryLayer" id="InventoryLayer52"></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck52" id="OpenCheck52" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice52" id="RegularPrice52" value="" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice52" id="NormalPrice52" value="" readonly onfocus="estimateSystemCursorAdvance('normal',52);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate52" id="NormalRate52" value="" readonly onfocus="estimateSystemCursorAdvance('normal',52);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate52" id="UnitRate52" value="" maxlength="5" onchange="estimateSystemUnitPercent(52, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice52" id="UnitPrice52" value="" maxlength="10" onchange="estimateSystemUnitPercent(52, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity52" id="Quantity52" value="" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(52); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice52" id="SubTotalPrice52" value="" readonly onfocus="estimateSystemCursorAdvance('sub',52);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime52" id="DeliveryTime52" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo52" id="Memo52" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice52"></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka52" id="EigyouGenka52" value="" readonly onfocus="estimateSystemCursorAdvance('next',52);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice52" id="MarginPrice52" value="" readonly onfocus="estimateSystemCursorAdvance('next',52);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice52" id="LimitPrice52" value="" readonly onfocus="estimateSystemCursorAdvance('next',52);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal52" id="MarginTotal52" value="" readonly onfocus="estimateSystemCursorAdvance('next',52);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate52" id="MarginRate52" value="" readonly onfocus="estimateSystemCursorAdvance('next',52);" />%</p>
        </td>
        <td id="MarginRank52"></td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment52" id="PurchaseComment52" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment52" id="DevLeaderComment52" readonly></textarea><input type="hidden" name="AutoAnswerFlag52" id="AutoAnswerFlag52" value="" /><input type="hidden" name="ImportantFlag52" id="ImportantFlag52" value="" /></p>
        </td>
        <td class="td_project"></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther52" id="RivalOther52" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker52" id="RivalMaker52" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku52" id="RivalSku52" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice52" id="RivalPrice52" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice52" id="LeaderPrice52" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',52);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate52" id="LeaderRate52" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',52);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice52" id="CorrectionPrice52" value="" readonly onfocus="estimateSystemCursorAdvance('next',52);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate52" id="CorrectionRate52" value="" readonly onfocus="estimateSystemCursorAdvance('next',52);" />%</p>
        </td>
        <td class="td_project">

        </td>
      </tr>

      <tr id="Column_53" class="tr_no_disp">
        <td><input type="text" class="ColumnNo" name="ColumnNo53" id="ColumnNo53" value="53" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(53);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck53" id="DeleteCheck53" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('53');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(53);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode53" id="ProductCode53" value="" maxlength="20" onchange="estimateSystemProductSearch(53);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck53" id="OutletCheck53" value="1" onclick="estimateSystemOutletChack(53);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag53" id="FeeFlag53" value="" /><input type="hidden" name="SuperBigFlag53" id="SuperBigFlag53" value="" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName53" id="ProductName53" value="" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine53">Rコード <input type="text" class="ProductCode3" name="RCode53" id="RCode53" value="" maxlength="6" onchange="estimateSystemProductSearchRICOH(53);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea53"><div class="InventoryLayer" id="InventoryLayer53"></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck53" id="OpenCheck53" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice53" id="RegularPrice53" value="" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice53" id="NormalPrice53" value="" readonly onfocus="estimateSystemCursorAdvance('normal',53);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate53" id="NormalRate53" value="" readonly onfocus="estimateSystemCursorAdvance('normal',53);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate53" id="UnitRate53" value="" maxlength="5" onchange="estimateSystemUnitPercent(53, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice53" id="UnitPrice53" value="" maxlength="10" onchange="estimateSystemUnitPercent(53, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity53" id="Quantity53" value="" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(53); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice53" id="SubTotalPrice53" value="" readonly onfocus="estimateSystemCursorAdvance('sub',53);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime53" id="DeliveryTime53" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo53" id="Memo53" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice53"></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka53" id="EigyouGenka53" value="" readonly onfocus="estimateSystemCursorAdvance('next',53);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice53" id="MarginPrice53" value="" readonly onfocus="estimateSystemCursorAdvance('next',53);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice53" id="LimitPrice53" value="" readonly onfocus="estimateSystemCursorAdvance('next',53);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal53" id="MarginTotal53" value="" readonly onfocus="estimateSystemCursorAdvance('next',53);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate53" id="MarginRate53" value="" readonly onfocus="estimateSystemCursorAdvance('next',53);" />%</p>
        </td>
        <td id="MarginRank53"></td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment53" id="PurchaseComment53" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment53" id="DevLeaderComment53" readonly></textarea><input type="hidden" name="AutoAnswerFlag53" id="AutoAnswerFlag53" value="" /><input type="hidden" name="ImportantFlag53" id="ImportantFlag53" value="" /></p>
        </td>
        <td class="td_project"></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther53" id="RivalOther53" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker53" id="RivalMaker53" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku53" id="RivalSku53" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice53" id="RivalPrice53" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice53" id="LeaderPrice53" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',53);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate53" id="LeaderRate53" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',53);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice53" id="CorrectionPrice53" value="" readonly onfocus="estimateSystemCursorAdvance('next',53);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate53" id="CorrectionRate53" value="" readonly onfocus="estimateSystemCursorAdvance('next',53);" />%</p>
        </td>
        <td class="td_project">

        </td>
      </tr>

      <tr id="Column_54" class="tr_no_disp">
        <td><input type="text" class="ColumnNo" name="ColumnNo54" id="ColumnNo54" value="54" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(54);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck54" id="DeleteCheck54" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('54');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(54);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode54" id="ProductCode54" value="" maxlength="20" onchange="estimateSystemProductSearch(54);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck54" id="OutletCheck54" value="1" onclick="estimateSystemOutletChack(54);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag54" id="FeeFlag54" value="" /><input type="hidden" name="SuperBigFlag54" id="SuperBigFlag54" value="" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName54" id="ProductName54" value="" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine54">Rコード <input type="text" class="ProductCode3" name="RCode54" id="RCode54" value="" maxlength="6" onchange="estimateSystemProductSearchRICOH(54);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea54"><div class="InventoryLayer" id="InventoryLayer54"></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck54" id="OpenCheck54" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice54" id="RegularPrice54" value="" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice54" id="NormalPrice54" value="" readonly onfocus="estimateSystemCursorAdvance('normal',54);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate54" id="NormalRate54" value="" readonly onfocus="estimateSystemCursorAdvance('normal',54);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate54" id="UnitRate54" value="" maxlength="5" onchange="estimateSystemUnitPercent(54, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice54" id="UnitPrice54" value="" maxlength="10" onchange="estimateSystemUnitPercent(54, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity54" id="Quantity54" value="" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(54); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice54" id="SubTotalPrice54" value="" readonly onfocus="estimateSystemCursorAdvance('sub',54);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime54" id="DeliveryTime54" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo54" id="Memo54" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice54"></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka54" id="EigyouGenka54" value="" readonly onfocus="estimateSystemCursorAdvance('next',54);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice54" id="MarginPrice54" value="" readonly onfocus="estimateSystemCursorAdvance('next',54);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice54" id="LimitPrice54" value="" readonly onfocus="estimateSystemCursorAdvance('next',54);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal54" id="MarginTotal54" value="" readonly onfocus="estimateSystemCursorAdvance('next',54);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate54" id="MarginRate54" value="" readonly onfocus="estimateSystemCursorAdvance('next',54);" />%</p>
        </td>
        <td id="MarginRank54"></td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment54" id="PurchaseComment54" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment54" id="DevLeaderComment54" readonly></textarea><input type="hidden" name="AutoAnswerFlag54" id="AutoAnswerFlag54" value="" /><input type="hidden" name="ImportantFlag54" id="ImportantFlag54" value="" /></p>
        </td>
        <td class="td_project"></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther54" id="RivalOther54" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker54" id="RivalMaker54" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku54" id="RivalSku54" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice54" id="RivalPrice54" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice54" id="LeaderPrice54" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',54);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate54" id="LeaderRate54" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',54);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice54" id="CorrectionPrice54" value="" readonly onfocus="estimateSystemCursorAdvance('next',54);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate54" id="CorrectionRate54" value="" readonly onfocus="estimateSystemCursorAdvance('next',54);" />%</p>
        </td>
        <td class="td_project">

        </td>
      </tr>

      <tr id="Column_55" class="tr_no_disp">
        <td><input type="text" class="ColumnNo" name="ColumnNo55" id="ColumnNo55" value="55" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(55);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck55" id="DeleteCheck55" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('55');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(55);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode55" id="ProductCode55" value="" maxlength="20" onchange="estimateSystemProductSearch(55);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck55" id="OutletCheck55" value="1" onclick="estimateSystemOutletChack(55);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag55" id="FeeFlag55" value="" /><input type="hidden" name="SuperBigFlag55" id="SuperBigFlag55" value="" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName55" id="ProductName55" value="" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine55">Rコード <input type="text" class="ProductCode3" name="RCode55" id="RCode55" value="" maxlength="6" onchange="estimateSystemProductSearchRICOH(55);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea55"><div class="InventoryLayer" id="InventoryLayer55"></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck55" id="OpenCheck55" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice55" id="RegularPrice55" value="" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice55" id="NormalPrice55" value="" readonly onfocus="estimateSystemCursorAdvance('normal',55);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate55" id="NormalRate55" value="" readonly onfocus="estimateSystemCursorAdvance('normal',55);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate55" id="UnitRate55" value="" maxlength="5" onchange="estimateSystemUnitPercent(55, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice55" id="UnitPrice55" value="" maxlength="10" onchange="estimateSystemUnitPercent(55, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity55" id="Quantity55" value="" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(55); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice55" id="SubTotalPrice55" value="" readonly onfocus="estimateSystemCursorAdvance('sub',55);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime55" id="DeliveryTime55" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo55" id="Memo55" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice55"></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka55" id="EigyouGenka55" value="" readonly onfocus="estimateSystemCursorAdvance('next',55);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice55" id="MarginPrice55" value="" readonly onfocus="estimateSystemCursorAdvance('next',55);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice55" id="LimitPrice55" value="" readonly onfocus="estimateSystemCursorAdvance('next',55);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal55" id="MarginTotal55" value="" readonly onfocus="estimateSystemCursorAdvance('next',55);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate55" id="MarginRate55" value="" readonly onfocus="estimateSystemCursorAdvance('next',55);" />%</p>
        </td>
        <td id="MarginRank55"></td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment55" id="PurchaseComment55" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment55" id="DevLeaderComment55" readonly></textarea><input type="hidden" name="AutoAnswerFlag55" id="AutoAnswerFlag55" value="" /><input type="hidden" name="ImportantFlag55" id="ImportantFlag55" value="" /></p>
        </td>
        <td class="td_project"></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther55" id="RivalOther55" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker55" id="RivalMaker55" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku55" id="RivalSku55" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice55" id="RivalPrice55" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice55" id="LeaderPrice55" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',55);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate55" id="LeaderRate55" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',55);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice55" id="CorrectionPrice55" value="" readonly onfocus="estimateSystemCursorAdvance('next',55);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate55" id="CorrectionRate55" value="" readonly onfocus="estimateSystemCursorAdvance('next',55);" />%</p>
        </td>
        <td class="td_project">

        </td>
      </tr>

      <tr id="Column_56" class="tr_no_disp">
        <td><input type="text" class="ColumnNo" name="ColumnNo56" id="ColumnNo56" value="56" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(56);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck56" id="DeleteCheck56" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('56');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(56);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode56" id="ProductCode56" value="" maxlength="20" onchange="estimateSystemProductSearch(56);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck56" id="OutletCheck56" value="1" onclick="estimateSystemOutletChack(56);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag56" id="FeeFlag56" value="" /><input type="hidden" name="SuperBigFlag56" id="SuperBigFlag56" value="" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName56" id="ProductName56" value="" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine56">Rコード <input type="text" class="ProductCode3" name="RCode56" id="RCode56" value="" maxlength="6" onchange="estimateSystemProductSearchRICOH(56);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea56"><div class="InventoryLayer" id="InventoryLayer56"></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck56" id="OpenCheck56" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice56" id="RegularPrice56" value="" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice56" id="NormalPrice56" value="" readonly onfocus="estimateSystemCursorAdvance('normal',56);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate56" id="NormalRate56" value="" readonly onfocus="estimateSystemCursorAdvance('normal',56);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate56" id="UnitRate56" value="" maxlength="5" onchange="estimateSystemUnitPercent(56, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice56" id="UnitPrice56" value="" maxlength="10" onchange="estimateSystemUnitPercent(56, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity56" id="Quantity56" value="" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(56); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice56" id="SubTotalPrice56" value="" readonly onfocus="estimateSystemCursorAdvance('sub',56);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime56" id="DeliveryTime56" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo56" id="Memo56" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice56"></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka56" id="EigyouGenka56" value="" readonly onfocus="estimateSystemCursorAdvance('next',56);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice56" id="MarginPrice56" value="" readonly onfocus="estimateSystemCursorAdvance('next',56);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice56" id="LimitPrice56" value="" readonly onfocus="estimateSystemCursorAdvance('next',56);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal56" id="MarginTotal56" value="" readonly onfocus="estimateSystemCursorAdvance('next',56);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate56" id="MarginRate56" value="" readonly onfocus="estimateSystemCursorAdvance('next',56);" />%</p>
        </td>
        <td id="MarginRank56"></td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment56" id="PurchaseComment56" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment56" id="DevLeaderComment56" readonly></textarea><input type="hidden" name="AutoAnswerFlag56" id="AutoAnswerFlag56" value="" /><input type="hidden" name="ImportantFlag56" id="ImportantFlag56" value="" /></p>
        </td>
        <td class="td_project"></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther56" id="RivalOther56" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker56" id="RivalMaker56" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku56" id="RivalSku56" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice56" id="RivalPrice56" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice56" id="LeaderPrice56" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',56);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate56" id="LeaderRate56" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',56);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice56" id="CorrectionPrice56" value="" readonly onfocus="estimateSystemCursorAdvance('next',56);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate56" id="CorrectionRate56" value="" readonly onfocus="estimateSystemCursorAdvance('next',56);" />%</p>
        </td>
        <td class="td_project">

        </td>
      </tr>

      <tr id="Column_57" class="tr_no_disp">
        <td><input type="text" class="ColumnNo" name="ColumnNo57" id="ColumnNo57" value="57" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(57);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck57" id="DeleteCheck57" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('57');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(57);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode57" id="ProductCode57" value="" maxlength="20" onchange="estimateSystemProductSearch(57);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck57" id="OutletCheck57" value="1" onclick="estimateSystemOutletChack(57);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag57" id="FeeFlag57" value="" /><input type="hidden" name="SuperBigFlag57" id="SuperBigFlag57" value="" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName57" id="ProductName57" value="" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine57">Rコード <input type="text" class="ProductCode3" name="RCode57" id="RCode57" value="" maxlength="6" onchange="estimateSystemProductSearchRICOH(57);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea57"><div class="InventoryLayer" id="InventoryLayer57"></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck57" id="OpenCheck57" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice57" id="RegularPrice57" value="" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice57" id="NormalPrice57" value="" readonly onfocus="estimateSystemCursorAdvance('normal',57);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate57" id="NormalRate57" value="" readonly onfocus="estimateSystemCursorAdvance('normal',57);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate57" id="UnitRate57" value="" maxlength="5" onchange="estimateSystemUnitPercent(57, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice57" id="UnitPrice57" value="" maxlength="10" onchange="estimateSystemUnitPercent(57, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity57" id="Quantity57" value="" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(57); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice57" id="SubTotalPrice57" value="" readonly onfocus="estimateSystemCursorAdvance('sub',57);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime57" id="DeliveryTime57" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo57" id="Memo57" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice57"></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka57" id="EigyouGenka57" value="" readonly onfocus="estimateSystemCursorAdvance('next',57);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice57" id="MarginPrice57" value="" readonly onfocus="estimateSystemCursorAdvance('next',57);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice57" id="LimitPrice57" value="" readonly onfocus="estimateSystemCursorAdvance('next',57);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal57" id="MarginTotal57" value="" readonly onfocus="estimateSystemCursorAdvance('next',57);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate57" id="MarginRate57" value="" readonly onfocus="estimateSystemCursorAdvance('next',57);" />%</p>
        </td>
        <td id="MarginRank57"></td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment57" id="PurchaseComment57" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment57" id="DevLeaderComment57" readonly></textarea><input type="hidden" name="AutoAnswerFlag57" id="AutoAnswerFlag57" value="" /><input type="hidden" name="ImportantFlag57" id="ImportantFlag57" value="" /></p>
        </td>
        <td class="td_project"></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther57" id="RivalOther57" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker57" id="RivalMaker57" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku57" id="RivalSku57" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice57" id="RivalPrice57" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice57" id="LeaderPrice57" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',57);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate57" id="LeaderRate57" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',57);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice57" id="CorrectionPrice57" value="" readonly onfocus="estimateSystemCursorAdvance('next',57);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate57" id="CorrectionRate57" value="" readonly onfocus="estimateSystemCursorAdvance('next',57);" />%</p>
        </td>
        <td class="td_project">

        </td>
      </tr>

      <tr id="Column_58" class="tr_no_disp">
        <td><input type="text" class="ColumnNo" name="ColumnNo58" id="ColumnNo58" value="58" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(58);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck58" id="DeleteCheck58" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('58');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(58);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode58" id="ProductCode58" value="" maxlength="20" onchange="estimateSystemProductSearch(58);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck58" id="OutletCheck58" value="1" onclick="estimateSystemOutletChack(58);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag58" id="FeeFlag58" value="" /><input type="hidden" name="SuperBigFlag58" id="SuperBigFlag58" value="" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName58" id="ProductName58" value="" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine58">Rコード <input type="text" class="ProductCode3" name="RCode58" id="RCode58" value="" maxlength="6" onchange="estimateSystemProductSearchRICOH(58);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea58"><div class="InventoryLayer" id="InventoryLayer58"></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck58" id="OpenCheck58" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice58" id="RegularPrice58" value="" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice58" id="NormalPrice58" value="" readonly onfocus="estimateSystemCursorAdvance('normal',58);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate58" id="NormalRate58" value="" readonly onfocus="estimateSystemCursorAdvance('normal',58);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate58" id="UnitRate58" value="" maxlength="5" onchange="estimateSystemUnitPercent(58, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice58" id="UnitPrice58" value="" maxlength="10" onchange="estimateSystemUnitPercent(58, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity58" id="Quantity58" value="" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(58); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice58" id="SubTotalPrice58" value="" readonly onfocus="estimateSystemCursorAdvance('sub',58);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime58" id="DeliveryTime58" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo58" id="Memo58" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice58"></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka58" id="EigyouGenka58" value="" readonly onfocus="estimateSystemCursorAdvance('next',58);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice58" id="MarginPrice58" value="" readonly onfocus="estimateSystemCursorAdvance('next',58);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice58" id="LimitPrice58" value="" readonly onfocus="estimateSystemCursorAdvance('next',58);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal58" id="MarginTotal58" value="" readonly onfocus="estimateSystemCursorAdvance('next',58);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate58" id="MarginRate58" value="" readonly onfocus="estimateSystemCursorAdvance('next',58);" />%</p>
        </td>
        <td id="MarginRank58"></td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment58" id="PurchaseComment58" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment58" id="DevLeaderComment58" readonly></textarea><input type="hidden" name="AutoAnswerFlag58" id="AutoAnswerFlag58" value="" /><input type="hidden" name="ImportantFlag58" id="ImportantFlag58" value="" /></p>
        </td>
        <td class="td_project"></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther58" id="RivalOther58" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker58" id="RivalMaker58" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku58" id="RivalSku58" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice58" id="RivalPrice58" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice58" id="LeaderPrice58" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',58);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate58" id="LeaderRate58" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',58);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice58" id="CorrectionPrice58" value="" readonly onfocus="estimateSystemCursorAdvance('next',58);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate58" id="CorrectionRate58" value="" readonly onfocus="estimateSystemCursorAdvance('next',58);" />%</p>
        </td>
        <td class="td_project">

        </td>
      </tr>

      <tr id="Column_59" class="tr_no_disp">
        <td><input type="text" class="ColumnNo" name="ColumnNo59" id="ColumnNo59" value="59" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(59);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck59" id="DeleteCheck59" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('59');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(59);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode59" id="ProductCode59" value="" maxlength="20" onchange="estimateSystemProductSearch(59);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck59" id="OutletCheck59" value="1" onclick="estimateSystemOutletChack(59);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag59" id="FeeFlag59" value="" /><input type="hidden" name="SuperBigFlag59" id="SuperBigFlag59" value="" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName59" id="ProductName59" value="" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine59">Rコード <input type="text" class="ProductCode3" name="RCode59" id="RCode59" value="" maxlength="6" onchange="estimateSystemProductSearchRICOH(59);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea59"><div class="InventoryLayer" id="InventoryLayer59"></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck59" id="OpenCheck59" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice59" id="RegularPrice59" value="" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice59" id="NormalPrice59" value="" readonly onfocus="estimateSystemCursorAdvance('normal',59);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate59" id="NormalRate59" value="" readonly onfocus="estimateSystemCursorAdvance('normal',59);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate59" id="UnitRate59" value="" maxlength="5" onchange="estimateSystemUnitPercent(59, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice59" id="UnitPrice59" value="" maxlength="10" onchange="estimateSystemUnitPercent(59, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity59" id="Quantity59" value="" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(59); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice59" id="SubTotalPrice59" value="" readonly onfocus="estimateSystemCursorAdvance('sub',59);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime59" id="DeliveryTime59" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo59" id="Memo59" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice59"></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka59" id="EigyouGenka59" value="" readonly onfocus="estimateSystemCursorAdvance('next',59);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice59" id="MarginPrice59" value="" readonly onfocus="estimateSystemCursorAdvance('next',59);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice59" id="LimitPrice59" value="" readonly onfocus="estimateSystemCursorAdvance('next',59);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal59" id="MarginTotal59" value="" readonly onfocus="estimateSystemCursorAdvance('next',59);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate59" id="MarginRate59" value="" readonly onfocus="estimateSystemCursorAdvance('next',59);" />%</p>
        </td>
        <td id="MarginRank59"></td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment59" id="PurchaseComment59" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment59" id="DevLeaderComment59" readonly></textarea><input type="hidden" name="AutoAnswerFlag59" id="AutoAnswerFlag59" value="" /><input type="hidden" name="ImportantFlag59" id="ImportantFlag59" value="" /></p>
        </td>
        <td class="td_project"></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther59" id="RivalOther59" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker59" id="RivalMaker59" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku59" id="RivalSku59" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice59" id="RivalPrice59" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice59" id="LeaderPrice59" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',59);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate59" id="LeaderRate59" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',59);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice59" id="CorrectionPrice59" value="" readonly onfocus="estimateSystemCursorAdvance('next',59);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate59" id="CorrectionRate59" value="" readonly onfocus="estimateSystemCursorAdvance('next',59);" />%</p>
        </td>
        <td class="td_project">

        </td>
      </tr>

      <tr id="Column_60" class="tr_no_disp">
        <td><input type="text" class="ColumnNo" name="ColumnNo60" id="ColumnNo60" value="60" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(60);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck60" id="DeleteCheck60" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('60');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(60);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode60" id="ProductCode60" value="" maxlength="20" onchange="estimateSystemProductSearch(60);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck60" id="OutletCheck60" value="1" onclick="estimateSystemOutletChack(60);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag60" id="FeeFlag60" value="" /><input type="hidden" name="SuperBigFlag60" id="SuperBigFlag60" value="" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName60" id="ProductName60" value="" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine60">Rコード <input type="text" class="ProductCode3" name="RCode60" id="RCode60" value="" maxlength="6" onchange="estimateSystemProductSearchRICOH(60);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea60"><div class="InventoryLayer" id="InventoryLayer60"></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck60" id="OpenCheck60" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice60" id="RegularPrice60" value="" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice60" id="NormalPrice60" value="" readonly onfocus="estimateSystemCursorAdvance('normal',60);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate60" id="NormalRate60" value="" readonly onfocus="estimateSystemCursorAdvance('normal',60);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate60" id="UnitRate60" value="" maxlength="5" onchange="estimateSystemUnitPercent(60, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice60" id="UnitPrice60" value="" maxlength="10" onchange="estimateSystemUnitPercent(60, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity60" id="Quantity60" value="" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(60); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice60" id="SubTotalPrice60" value="" readonly onfocus="estimateSystemCursorAdvance('sub',60);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime60" id="DeliveryTime60" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo60" id="Memo60" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice60"></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka60" id="EigyouGenka60" value="" readonly onfocus="estimateSystemCursorAdvance('next',60);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice60" id="MarginPrice60" value="" readonly onfocus="estimateSystemCursorAdvance('next',60);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice60" id="LimitPrice60" value="" readonly onfocus="estimateSystemCursorAdvance('next',60);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal60" id="MarginTotal60" value="" readonly onfocus="estimateSystemCursorAdvance('next',60);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate60" id="MarginRate60" value="" readonly onfocus="estimateSystemCursorAdvance('next',60);" />%</p>
        </td>
        <td id="MarginRank60"></td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment60" id="PurchaseComment60" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment60" id="DevLeaderComment60" readonly></textarea><input type="hidden" name="AutoAnswerFlag60" id="AutoAnswerFlag60" value="" /><input type="hidden" name="ImportantFlag60" id="ImportantFlag60" value="" /></p>
        </td>
        <td class="td_project"></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther60" id="RivalOther60" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker60" id="RivalMaker60" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku60" id="RivalSku60" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice60" id="RivalPrice60" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice60" id="LeaderPrice60" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',60);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate60" id="LeaderRate60" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',60);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice60" id="CorrectionPrice60" value="" readonly onfocus="estimateSystemCursorAdvance('next',60);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate60" id="CorrectionRate60" value="" readonly onfocus="estimateSystemCursorAdvance('next',60);" />%</p>
        </td>
        <td class="td_project">

        </td>
      </tr>

      <tr id="Column_61" class="tr_no_disp">
        <td><input type="text" class="ColumnNo" name="ColumnNo61" id="ColumnNo61" value="61" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(61);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck61" id="DeleteCheck61" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('61');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(61);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode61" id="ProductCode61" value="" maxlength="20" onchange="estimateSystemProductSearch(61);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck61" id="OutletCheck61" value="1" onclick="estimateSystemOutletChack(61);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag61" id="FeeFlag61" value="" /><input type="hidden" name="SuperBigFlag61" id="SuperBigFlag61" value="" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName61" id="ProductName61" value="" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine61">Rコード <input type="text" class="ProductCode3" name="RCode61" id="RCode61" value="" maxlength="6" onchange="estimateSystemProductSearchRICOH(61);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea61"><div class="InventoryLayer" id="InventoryLayer61"></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck61" id="OpenCheck61" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice61" id="RegularPrice61" value="" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice61" id="NormalPrice61" value="" readonly onfocus="estimateSystemCursorAdvance('normal',61);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate61" id="NormalRate61" value="" readonly onfocus="estimateSystemCursorAdvance('normal',61);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate61" id="UnitRate61" value="" maxlength="5" onchange="estimateSystemUnitPercent(61, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice61" id="UnitPrice61" value="" maxlength="10" onchange="estimateSystemUnitPercent(61, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity61" id="Quantity61" value="" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(61); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice61" id="SubTotalPrice61" value="" readonly onfocus="estimateSystemCursorAdvance('sub',61);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime61" id="DeliveryTime61" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo61" id="Memo61" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice61"></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka61" id="EigyouGenka61" value="" readonly onfocus="estimateSystemCursorAdvance('next',61);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice61" id="MarginPrice61" value="" readonly onfocus="estimateSystemCursorAdvance('next',61);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice61" id="LimitPrice61" value="" readonly onfocus="estimateSystemCursorAdvance('next',61);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal61" id="MarginTotal61" value="" readonly onfocus="estimateSystemCursorAdvance('next',61);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate61" id="MarginRate61" value="" readonly onfocus="estimateSystemCursorAdvance('next',61);" />%</p>
        </td>
        <td id="MarginRank61"></td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment61" id="PurchaseComment61" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment61" id="DevLeaderComment61" readonly></textarea><input type="hidden" name="AutoAnswerFlag61" id="AutoAnswerFlag61" value="" /><input type="hidden" name="ImportantFlag61" id="ImportantFlag61" value="" /></p>
        </td>
        <td class="td_project"></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther61" id="RivalOther61" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker61" id="RivalMaker61" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku61" id="RivalSku61" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice61" id="RivalPrice61" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice61" id="LeaderPrice61" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',61);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate61" id="LeaderRate61" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',61);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice61" id="CorrectionPrice61" value="" readonly onfocus="estimateSystemCursorAdvance('next',61);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate61" id="CorrectionRate61" value="" readonly onfocus="estimateSystemCursorAdvance('next',61);" />%</p>
        </td>
        <td class="td_project">

        </td>
      </tr>

      <tr id="Column_62" class="tr_no_disp">
        <td><input type="text" class="ColumnNo" name="ColumnNo62" id="ColumnNo62" value="62" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(62);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck62" id="DeleteCheck62" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('62');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(62);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode62" id="ProductCode62" value="" maxlength="20" onchange="estimateSystemProductSearch(62);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck62" id="OutletCheck62" value="1" onclick="estimateSystemOutletChack(62);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag62" id="FeeFlag62" value="" /><input type="hidden" name="SuperBigFlag62" id="SuperBigFlag62" value="" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName62" id="ProductName62" value="" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine62">Rコード <input type="text" class="ProductCode3" name="RCode62" id="RCode62" value="" maxlength="6" onchange="estimateSystemProductSearchRICOH(62);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea62"><div class="InventoryLayer" id="InventoryLayer62"></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck62" id="OpenCheck62" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice62" id="RegularPrice62" value="" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice62" id="NormalPrice62" value="" readonly onfocus="estimateSystemCursorAdvance('normal',62);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate62" id="NormalRate62" value="" readonly onfocus="estimateSystemCursorAdvance('normal',62);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate62" id="UnitRate62" value="" maxlength="5" onchange="estimateSystemUnitPercent(62, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice62" id="UnitPrice62" value="" maxlength="10" onchange="estimateSystemUnitPercent(62, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity62" id="Quantity62" value="" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(62); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice62" id="SubTotalPrice62" value="" readonly onfocus="estimateSystemCursorAdvance('sub',62);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime62" id="DeliveryTime62" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo62" id="Memo62" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice62"></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka62" id="EigyouGenka62" value="" readonly onfocus="estimateSystemCursorAdvance('next',62);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice62" id="MarginPrice62" value="" readonly onfocus="estimateSystemCursorAdvance('next',62);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice62" id="LimitPrice62" value="" readonly onfocus="estimateSystemCursorAdvance('next',62);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal62" id="MarginTotal62" value="" readonly onfocus="estimateSystemCursorAdvance('next',62);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate62" id="MarginRate62" value="" readonly onfocus="estimateSystemCursorAdvance('next',62);" />%</p>
        </td>
        <td id="MarginRank62"></td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment62" id="PurchaseComment62" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment62" id="DevLeaderComment62" readonly></textarea><input type="hidden" name="AutoAnswerFlag62" id="AutoAnswerFlag62" value="" /><input type="hidden" name="ImportantFlag62" id="ImportantFlag62" value="" /></p>
        </td>
        <td class="td_project"></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther62" id="RivalOther62" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker62" id="RivalMaker62" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku62" id="RivalSku62" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice62" id="RivalPrice62" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice62" id="LeaderPrice62" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',62);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate62" id="LeaderRate62" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',62);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice62" id="CorrectionPrice62" value="" readonly onfocus="estimateSystemCursorAdvance('next',62);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate62" id="CorrectionRate62" value="" readonly onfocus="estimateSystemCursorAdvance('next',62);" />%</p>
        </td>
        <td class="td_project">

        </td>
      </tr>

      <tr id="Column_63" class="tr_no_disp">
        <td><input type="text" class="ColumnNo" name="ColumnNo63" id="ColumnNo63" value="63" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(63);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck63" id="DeleteCheck63" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('63');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(63);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode63" id="ProductCode63" value="" maxlength="20" onchange="estimateSystemProductSearch(63);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck63" id="OutletCheck63" value="1" onclick="estimateSystemOutletChack(63);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag63" id="FeeFlag63" value="" /><input type="hidden" name="SuperBigFlag63" id="SuperBigFlag63" value="" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName63" id="ProductName63" value="" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine63">Rコード <input type="text" class="ProductCode3" name="RCode63" id="RCode63" value="" maxlength="6" onchange="estimateSystemProductSearchRICOH(63);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea63"><div class="InventoryLayer" id="InventoryLayer63"></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck63" id="OpenCheck63" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice63" id="RegularPrice63" value="" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice63" id="NormalPrice63" value="" readonly onfocus="estimateSystemCursorAdvance('normal',63);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate63" id="NormalRate63" value="" readonly onfocus="estimateSystemCursorAdvance('normal',63);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate63" id="UnitRate63" value="" maxlength="5" onchange="estimateSystemUnitPercent(63, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice63" id="UnitPrice63" value="" maxlength="10" onchange="estimateSystemUnitPercent(63, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity63" id="Quantity63" value="" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(63); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice63" id="SubTotalPrice63" value="" readonly onfocus="estimateSystemCursorAdvance('sub',63);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime63" id="DeliveryTime63" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo63" id="Memo63" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice63"></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka63" id="EigyouGenka63" value="" readonly onfocus="estimateSystemCursorAdvance('next',63);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice63" id="MarginPrice63" value="" readonly onfocus="estimateSystemCursorAdvance('next',63);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice63" id="LimitPrice63" value="" readonly onfocus="estimateSystemCursorAdvance('next',63);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal63" id="MarginTotal63" value="" readonly onfocus="estimateSystemCursorAdvance('next',63);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate63" id="MarginRate63" value="" readonly onfocus="estimateSystemCursorAdvance('next',63);" />%</p>
        </td>
        <td id="MarginRank63"></td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment63" id="PurchaseComment63" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment63" id="DevLeaderComment63" readonly></textarea><input type="hidden" name="AutoAnswerFlag63" id="AutoAnswerFlag63" value="" /><input type="hidden" name="ImportantFlag63" id="ImportantFlag63" value="" /></p>
        </td>
        <td class="td_project"></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther63" id="RivalOther63" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker63" id="RivalMaker63" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku63" id="RivalSku63" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice63" id="RivalPrice63" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice63" id="LeaderPrice63" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',63);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate63" id="LeaderRate63" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',63);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice63" id="CorrectionPrice63" value="" readonly onfocus="estimateSystemCursorAdvance('next',63);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate63" id="CorrectionRate63" value="" readonly onfocus="estimateSystemCursorAdvance('next',63);" />%</p>
        </td>
        <td class="td_project">

        </td>
      </tr>

      <tr id="Column_64" class="tr_no_disp">
        <td><input type="text" class="ColumnNo" name="ColumnNo64" id="ColumnNo64" value="64" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(64);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck64" id="DeleteCheck64" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('64');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(64);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode64" id="ProductCode64" value="" maxlength="20" onchange="estimateSystemProductSearch(64);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck64" id="OutletCheck64" value="1" onclick="estimateSystemOutletChack(64);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag64" id="FeeFlag64" value="" /><input type="hidden" name="SuperBigFlag64" id="SuperBigFlag64" value="" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName64" id="ProductName64" value="" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine64">Rコード <input type="text" class="ProductCode3" name="RCode64" id="RCode64" value="" maxlength="6" onchange="estimateSystemProductSearchRICOH(64);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea64"><div class="InventoryLayer" id="InventoryLayer64"></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck64" id="OpenCheck64" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice64" id="RegularPrice64" value="" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice64" id="NormalPrice64" value="" readonly onfocus="estimateSystemCursorAdvance('normal',64);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate64" id="NormalRate64" value="" readonly onfocus="estimateSystemCursorAdvance('normal',64);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate64" id="UnitRate64" value="" maxlength="5" onchange="estimateSystemUnitPercent(64, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice64" id="UnitPrice64" value="" maxlength="10" onchange="estimateSystemUnitPercent(64, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity64" id="Quantity64" value="" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(64); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice64" id="SubTotalPrice64" value="" readonly onfocus="estimateSystemCursorAdvance('sub',64);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime64" id="DeliveryTime64" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo64" id="Memo64" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice64"></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka64" id="EigyouGenka64" value="" readonly onfocus="estimateSystemCursorAdvance('next',64);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice64" id="MarginPrice64" value="" readonly onfocus="estimateSystemCursorAdvance('next',64);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice64" id="LimitPrice64" value="" readonly onfocus="estimateSystemCursorAdvance('next',64);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal64" id="MarginTotal64" value="" readonly onfocus="estimateSystemCursorAdvance('next',64);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate64" id="MarginRate64" value="" readonly onfocus="estimateSystemCursorAdvance('next',64);" />%</p>
        </td>
        <td id="MarginRank64"></td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment64" id="PurchaseComment64" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment64" id="DevLeaderComment64" readonly></textarea><input type="hidden" name="AutoAnswerFlag64" id="AutoAnswerFlag64" value="" /><input type="hidden" name="ImportantFlag64" id="ImportantFlag64" value="" /></p>
        </td>
        <td class="td_project"></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther64" id="RivalOther64" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker64" id="RivalMaker64" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku64" id="RivalSku64" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice64" id="RivalPrice64" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice64" id="LeaderPrice64" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',64);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate64" id="LeaderRate64" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',64);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice64" id="CorrectionPrice64" value="" readonly onfocus="estimateSystemCursorAdvance('next',64);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate64" id="CorrectionRate64" value="" readonly onfocus="estimateSystemCursorAdvance('next',64);" />%</p>
        </td>
        <td class="td_project">

        </td>
      </tr>

      <tr id="Column_65" class="tr_no_disp">
        <td><input type="text" class="ColumnNo" name="ColumnNo65" id="ColumnNo65" value="65" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(65);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck65" id="DeleteCheck65" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('65');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(65);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode65" id="ProductCode65" value="" maxlength="20" onchange="estimateSystemProductSearch(65);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck65" id="OutletCheck65" value="1" onclick="estimateSystemOutletChack(65);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag65" id="FeeFlag65" value="" /><input type="hidden" name="SuperBigFlag65" id="SuperBigFlag65" value="" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName65" id="ProductName65" value="" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine65">Rコード <input type="text" class="ProductCode3" name="RCode65" id="RCode65" value="" maxlength="6" onchange="estimateSystemProductSearchRICOH(65);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea65"><div class="InventoryLayer" id="InventoryLayer65"></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck65" id="OpenCheck65" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice65" id="RegularPrice65" value="" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice65" id="NormalPrice65" value="" readonly onfocus="estimateSystemCursorAdvance('normal',65);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate65" id="NormalRate65" value="" readonly onfocus="estimateSystemCursorAdvance('normal',65);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate65" id="UnitRate65" value="" maxlength="5" onchange="estimateSystemUnitPercent(65, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice65" id="UnitPrice65" value="" maxlength="10" onchange="estimateSystemUnitPercent(65, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity65" id="Quantity65" value="" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(65); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice65" id="SubTotalPrice65" value="" readonly onfocus="estimateSystemCursorAdvance('sub',65);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime65" id="DeliveryTime65" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo65" id="Memo65" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice65"></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka65" id="EigyouGenka65" value="" readonly onfocus="estimateSystemCursorAdvance('next',65);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice65" id="MarginPrice65" value="" readonly onfocus="estimateSystemCursorAdvance('next',65);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice65" id="LimitPrice65" value="" readonly onfocus="estimateSystemCursorAdvance('next',65);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal65" id="MarginTotal65" value="" readonly onfocus="estimateSystemCursorAdvance('next',65);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate65" id="MarginRate65" value="" readonly onfocus="estimateSystemCursorAdvance('next',65);" />%</p>
        </td>
        <td id="MarginRank65"></td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment65" id="PurchaseComment65" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment65" id="DevLeaderComment65" readonly></textarea><input type="hidden" name="AutoAnswerFlag65" id="AutoAnswerFlag65" value="" /><input type="hidden" name="ImportantFlag65" id="ImportantFlag65" value="" /></p>
        </td>
        <td class="td_project"></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther65" id="RivalOther65" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker65" id="RivalMaker65" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku65" id="RivalSku65" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice65" id="RivalPrice65" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice65" id="LeaderPrice65" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',65);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate65" id="LeaderRate65" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',65);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice65" id="CorrectionPrice65" value="" readonly onfocus="estimateSystemCursorAdvance('next',65);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate65" id="CorrectionRate65" value="" readonly onfocus="estimateSystemCursorAdvance('next',65);" />%</p>
        </td>
        <td class="td_project">

        </td>
      </tr>

      <tr id="Column_66" class="tr_no_disp">
        <td><input type="text" class="ColumnNo" name="ColumnNo66" id="ColumnNo66" value="66" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(66);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck66" id="DeleteCheck66" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('66');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(66);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode66" id="ProductCode66" value="" maxlength="20" onchange="estimateSystemProductSearch(66);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck66" id="OutletCheck66" value="1" onclick="estimateSystemOutletChack(66);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag66" id="FeeFlag66" value="" /><input type="hidden" name="SuperBigFlag66" id="SuperBigFlag66" value="" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName66" id="ProductName66" value="" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine66">Rコード <input type="text" class="ProductCode3" name="RCode66" id="RCode66" value="" maxlength="6" onchange="estimateSystemProductSearchRICOH(66);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea66"><div class="InventoryLayer" id="InventoryLayer66"></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck66" id="OpenCheck66" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice66" id="RegularPrice66" value="" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice66" id="NormalPrice66" value="" readonly onfocus="estimateSystemCursorAdvance('normal',66);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate66" id="NormalRate66" value="" readonly onfocus="estimateSystemCursorAdvance('normal',66);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate66" id="UnitRate66" value="" maxlength="5" onchange="estimateSystemUnitPercent(66, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice66" id="UnitPrice66" value="" maxlength="10" onchange="estimateSystemUnitPercent(66, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity66" id="Quantity66" value="" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(66); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice66" id="SubTotalPrice66" value="" readonly onfocus="estimateSystemCursorAdvance('sub',66);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime66" id="DeliveryTime66" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo66" id="Memo66" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice66"></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka66" id="EigyouGenka66" value="" readonly onfocus="estimateSystemCursorAdvance('next',66);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice66" id="MarginPrice66" value="" readonly onfocus="estimateSystemCursorAdvance('next',66);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice66" id="LimitPrice66" value="" readonly onfocus="estimateSystemCursorAdvance('next',66);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal66" id="MarginTotal66" value="" readonly onfocus="estimateSystemCursorAdvance('next',66);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate66" id="MarginRate66" value="" readonly onfocus="estimateSystemCursorAdvance('next',66);" />%</p>
        </td>
        <td id="MarginRank66"></td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment66" id="PurchaseComment66" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment66" id="DevLeaderComment66" readonly></textarea><input type="hidden" name="AutoAnswerFlag66" id="AutoAnswerFlag66" value="" /><input type="hidden" name="ImportantFlag66" id="ImportantFlag66" value="" /></p>
        </td>
        <td class="td_project"></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther66" id="RivalOther66" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker66" id="RivalMaker66" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku66" id="RivalSku66" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice66" id="RivalPrice66" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice66" id="LeaderPrice66" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',66);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate66" id="LeaderRate66" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',66);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice66" id="CorrectionPrice66" value="" readonly onfocus="estimateSystemCursorAdvance('next',66);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate66" id="CorrectionRate66" value="" readonly onfocus="estimateSystemCursorAdvance('next',66);" />%</p>
        </td>
        <td class="td_project">

        </td>
      </tr>

      <tr id="Column_67" class="tr_no_disp">
        <td><input type="text" class="ColumnNo" name="ColumnNo67" id="ColumnNo67" value="67" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(67);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck67" id="DeleteCheck67" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('67');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(67);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode67" id="ProductCode67" value="" maxlength="20" onchange="estimateSystemProductSearch(67);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck67" id="OutletCheck67" value="1" onclick="estimateSystemOutletChack(67);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag67" id="FeeFlag67" value="" /><input type="hidden" name="SuperBigFlag67" id="SuperBigFlag67" value="" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName67" id="ProductName67" value="" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine67">Rコード <input type="text" class="ProductCode3" name="RCode67" id="RCode67" value="" maxlength="6" onchange="estimateSystemProductSearchRICOH(67);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea67"><div class="InventoryLayer" id="InventoryLayer67"></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck67" id="OpenCheck67" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice67" id="RegularPrice67" value="" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice67" id="NormalPrice67" value="" readonly onfocus="estimateSystemCursorAdvance('normal',67);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate67" id="NormalRate67" value="" readonly onfocus="estimateSystemCursorAdvance('normal',67);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate67" id="UnitRate67" value="" maxlength="5" onchange="estimateSystemUnitPercent(67, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice67" id="UnitPrice67" value="" maxlength="10" onchange="estimateSystemUnitPercent(67, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity67" id="Quantity67" value="" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(67); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice67" id="SubTotalPrice67" value="" readonly onfocus="estimateSystemCursorAdvance('sub',67);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime67" id="DeliveryTime67" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo67" id="Memo67" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice67"></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka67" id="EigyouGenka67" value="" readonly onfocus="estimateSystemCursorAdvance('next',67);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice67" id="MarginPrice67" value="" readonly onfocus="estimateSystemCursorAdvance('next',67);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice67" id="LimitPrice67" value="" readonly onfocus="estimateSystemCursorAdvance('next',67);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal67" id="MarginTotal67" value="" readonly onfocus="estimateSystemCursorAdvance('next',67);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate67" id="MarginRate67" value="" readonly onfocus="estimateSystemCursorAdvance('next',67);" />%</p>
        </td>
        <td id="MarginRank67"></td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment67" id="PurchaseComment67" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment67" id="DevLeaderComment67" readonly></textarea><input type="hidden" name="AutoAnswerFlag67" id="AutoAnswerFlag67" value="" /><input type="hidden" name="ImportantFlag67" id="ImportantFlag67" value="" /></p>
        </td>
        <td class="td_project"></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther67" id="RivalOther67" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker67" id="RivalMaker67" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku67" id="RivalSku67" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice67" id="RivalPrice67" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice67" id="LeaderPrice67" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',67);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate67" id="LeaderRate67" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',67);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice67" id="CorrectionPrice67" value="" readonly onfocus="estimateSystemCursorAdvance('next',67);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate67" id="CorrectionRate67" value="" readonly onfocus="estimateSystemCursorAdvance('next',67);" />%</p>
        </td>
        <td class="td_project">

        </td>
      </tr>

      <tr id="Column_68" class="tr_no_disp">
        <td><input type="text" class="ColumnNo" name="ColumnNo68" id="ColumnNo68" value="68" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(68);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck68" id="DeleteCheck68" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('68');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(68);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode68" id="ProductCode68" value="" maxlength="20" onchange="estimateSystemProductSearch(68);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck68" id="OutletCheck68" value="1" onclick="estimateSystemOutletChack(68);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag68" id="FeeFlag68" value="" /><input type="hidden" name="SuperBigFlag68" id="SuperBigFlag68" value="" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName68" id="ProductName68" value="" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine68">Rコード <input type="text" class="ProductCode3" name="RCode68" id="RCode68" value="" maxlength="6" onchange="estimateSystemProductSearchRICOH(68);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea68"><div class="InventoryLayer" id="InventoryLayer68"></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck68" id="OpenCheck68" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice68" id="RegularPrice68" value="" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice68" id="NormalPrice68" value="" readonly onfocus="estimateSystemCursorAdvance('normal',68);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate68" id="NormalRate68" value="" readonly onfocus="estimateSystemCursorAdvance('normal',68);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate68" id="UnitRate68" value="" maxlength="5" onchange="estimateSystemUnitPercent(68, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice68" id="UnitPrice68" value="" maxlength="10" onchange="estimateSystemUnitPercent(68, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity68" id="Quantity68" value="" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(68); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice68" id="SubTotalPrice68" value="" readonly onfocus="estimateSystemCursorAdvance('sub',68);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime68" id="DeliveryTime68" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo68" id="Memo68" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice68"></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka68" id="EigyouGenka68" value="" readonly onfocus="estimateSystemCursorAdvance('next',68);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice68" id="MarginPrice68" value="" readonly onfocus="estimateSystemCursorAdvance('next',68);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice68" id="LimitPrice68" value="" readonly onfocus="estimateSystemCursorAdvance('next',68);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal68" id="MarginTotal68" value="" readonly onfocus="estimateSystemCursorAdvance('next',68);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate68" id="MarginRate68" value="" readonly onfocus="estimateSystemCursorAdvance('next',68);" />%</p>
        </td>
        <td id="MarginRank68"></td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment68" id="PurchaseComment68" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment68" id="DevLeaderComment68" readonly></textarea><input type="hidden" name="AutoAnswerFlag68" id="AutoAnswerFlag68" value="" /><input type="hidden" name="ImportantFlag68" id="ImportantFlag68" value="" /></p>
        </td>
        <td class="td_project"></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther68" id="RivalOther68" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker68" id="RivalMaker68" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku68" id="RivalSku68" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice68" id="RivalPrice68" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice68" id="LeaderPrice68" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',68);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate68" id="LeaderRate68" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',68);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice68" id="CorrectionPrice68" value="" readonly onfocus="estimateSystemCursorAdvance('next',68);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate68" id="CorrectionRate68" value="" readonly onfocus="estimateSystemCursorAdvance('next',68);" />%</p>
        </td>
        <td class="td_project">

        </td>
      </tr>

      <tr id="Column_69" class="tr_no_disp">
        <td><input type="text" class="ColumnNo" name="ColumnNo69" id="ColumnNo69" value="69" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(69);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck69" id="DeleteCheck69" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('69');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(69);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode69" id="ProductCode69" value="" maxlength="20" onchange="estimateSystemProductSearch(69);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck69" id="OutletCheck69" value="1" onclick="estimateSystemOutletChack(69);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag69" id="FeeFlag69" value="" /><input type="hidden" name="SuperBigFlag69" id="SuperBigFlag69" value="" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName69" id="ProductName69" value="" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine69">Rコード <input type="text" class="ProductCode3" name="RCode69" id="RCode69" value="" maxlength="6" onchange="estimateSystemProductSearchRICOH(69);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea69"><div class="InventoryLayer" id="InventoryLayer69"></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck69" id="OpenCheck69" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice69" id="RegularPrice69" value="" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice69" id="NormalPrice69" value="" readonly onfocus="estimateSystemCursorAdvance('normal',69);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate69" id="NormalRate69" value="" readonly onfocus="estimateSystemCursorAdvance('normal',69);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate69" id="UnitRate69" value="" maxlength="5" onchange="estimateSystemUnitPercent(69, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice69" id="UnitPrice69" value="" maxlength="10" onchange="estimateSystemUnitPercent(69, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity69" id="Quantity69" value="" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(69); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice69" id="SubTotalPrice69" value="" readonly onfocus="estimateSystemCursorAdvance('sub',69);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime69" id="DeliveryTime69" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo69" id="Memo69" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice69"></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka69" id="EigyouGenka69" value="" readonly onfocus="estimateSystemCursorAdvance('next',69);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice69" id="MarginPrice69" value="" readonly onfocus="estimateSystemCursorAdvance('next',69);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice69" id="LimitPrice69" value="" readonly onfocus="estimateSystemCursorAdvance('next',69);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal69" id="MarginTotal69" value="" readonly onfocus="estimateSystemCursorAdvance('next',69);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate69" id="MarginRate69" value="" readonly onfocus="estimateSystemCursorAdvance('next',69);" />%</p>
        </td>
        <td id="MarginRank69"></td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment69" id="PurchaseComment69" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment69" id="DevLeaderComment69" readonly></textarea><input type="hidden" name="AutoAnswerFlag69" id="AutoAnswerFlag69" value="" /><input type="hidden" name="ImportantFlag69" id="ImportantFlag69" value="" /></p>
        </td>
        <td class="td_project"></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther69" id="RivalOther69" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker69" id="RivalMaker69" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku69" id="RivalSku69" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice69" id="RivalPrice69" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice69" id="LeaderPrice69" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',69);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate69" id="LeaderRate69" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',69);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice69" id="CorrectionPrice69" value="" readonly onfocus="estimateSystemCursorAdvance('next',69);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate69" id="CorrectionRate69" value="" readonly onfocus="estimateSystemCursorAdvance('next',69);" />%</p>
        </td>
        <td class="td_project">

        </td>
      </tr>

      <tr id="Column_70" class="tr_no_disp">
        <td><input type="text" class="ColumnNo" name="ColumnNo70" id="ColumnNo70" value="70" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(70);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck70" id="DeleteCheck70" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('70');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(70);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode70" id="ProductCode70" value="" maxlength="20" onchange="estimateSystemProductSearch(70);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck70" id="OutletCheck70" value="1" onclick="estimateSystemOutletChack(70);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag70" id="FeeFlag70" value="" /><input type="hidden" name="SuperBigFlag70" id="SuperBigFlag70" value="" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName70" id="ProductName70" value="" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine70">Rコード <input type="text" class="ProductCode3" name="RCode70" id="RCode70" value="" maxlength="6" onchange="estimateSystemProductSearchRICOH(70);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea70"><div class="InventoryLayer" id="InventoryLayer70"></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck70" id="OpenCheck70" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice70" id="RegularPrice70" value="" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice70" id="NormalPrice70" value="" readonly onfocus="estimateSystemCursorAdvance('normal',70);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate70" id="NormalRate70" value="" readonly onfocus="estimateSystemCursorAdvance('normal',70);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate70" id="UnitRate70" value="" maxlength="5" onchange="estimateSystemUnitPercent(70, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice70" id="UnitPrice70" value="" maxlength="10" onchange="estimateSystemUnitPercent(70, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity70" id="Quantity70" value="" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(70); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice70" id="SubTotalPrice70" value="" readonly onfocus="estimateSystemCursorAdvance('sub',70);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime70" id="DeliveryTime70" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo70" id="Memo70" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice70"></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka70" id="EigyouGenka70" value="" readonly onfocus="estimateSystemCursorAdvance('next',70);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice70" id="MarginPrice70" value="" readonly onfocus="estimateSystemCursorAdvance('next',70);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice70" id="LimitPrice70" value="" readonly onfocus="estimateSystemCursorAdvance('next',70);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal70" id="MarginTotal70" value="" readonly onfocus="estimateSystemCursorAdvance('next',70);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate70" id="MarginRate70" value="" readonly onfocus="estimateSystemCursorAdvance('next',70);" />%</p>
        </td>
        <td id="MarginRank70"></td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment70" id="PurchaseComment70" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment70" id="DevLeaderComment70" readonly></textarea><input type="hidden" name="AutoAnswerFlag70" id="AutoAnswerFlag70" value="" /><input type="hidden" name="ImportantFlag70" id="ImportantFlag70" value="" /></p>
        </td>
        <td class="td_project"></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther70" id="RivalOther70" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker70" id="RivalMaker70" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku70" id="RivalSku70" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice70" id="RivalPrice70" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice70" id="LeaderPrice70" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',70);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate70" id="LeaderRate70" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',70);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice70" id="CorrectionPrice70" value="" readonly onfocus="estimateSystemCursorAdvance('next',70);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate70" id="CorrectionRate70" value="" readonly onfocus="estimateSystemCursorAdvance('next',70);" />%</p>
        </td>
        <td class="td_project">

        </td>
      </tr>

      <tr id="Column_71" class="tr_no_disp">
        <td><input type="text" class="ColumnNo" name="ColumnNo71" id="ColumnNo71" value="71" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(71);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck71" id="DeleteCheck71" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('71');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(71);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode71" id="ProductCode71" value="" maxlength="20" onchange="estimateSystemProductSearch(71);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck71" id="OutletCheck71" value="1" onclick="estimateSystemOutletChack(71);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag71" id="FeeFlag71" value="" /><input type="hidden" name="SuperBigFlag71" id="SuperBigFlag71" value="" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName71" id="ProductName71" value="" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine71">Rコード <input type="text" class="ProductCode3" name="RCode71" id="RCode71" value="" maxlength="6" onchange="estimateSystemProductSearchRICOH(71);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea71"><div class="InventoryLayer" id="InventoryLayer71"></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck71" id="OpenCheck71" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice71" id="RegularPrice71" value="" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice71" id="NormalPrice71" value="" readonly onfocus="estimateSystemCursorAdvance('normal',71);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate71" id="NormalRate71" value="" readonly onfocus="estimateSystemCursorAdvance('normal',71);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate71" id="UnitRate71" value="" maxlength="5" onchange="estimateSystemUnitPercent(71, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice71" id="UnitPrice71" value="" maxlength="10" onchange="estimateSystemUnitPercent(71, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity71" id="Quantity71" value="" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(71); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice71" id="SubTotalPrice71" value="" readonly onfocus="estimateSystemCursorAdvance('sub',71);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime71" id="DeliveryTime71" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo71" id="Memo71" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice71"></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka71" id="EigyouGenka71" value="" readonly onfocus="estimateSystemCursorAdvance('next',71);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice71" id="MarginPrice71" value="" readonly onfocus="estimateSystemCursorAdvance('next',71);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice71" id="LimitPrice71" value="" readonly onfocus="estimateSystemCursorAdvance('next',71);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal71" id="MarginTotal71" value="" readonly onfocus="estimateSystemCursorAdvance('next',71);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate71" id="MarginRate71" value="" readonly onfocus="estimateSystemCursorAdvance('next',71);" />%</p>
        </td>
        <td id="MarginRank71"></td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment71" id="PurchaseComment71" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment71" id="DevLeaderComment71" readonly></textarea><input type="hidden" name="AutoAnswerFlag71" id="AutoAnswerFlag71" value="" /><input type="hidden" name="ImportantFlag71" id="ImportantFlag71" value="" /></p>
        </td>
        <td class="td_project"></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther71" id="RivalOther71" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker71" id="RivalMaker71" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku71" id="RivalSku71" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice71" id="RivalPrice71" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice71" id="LeaderPrice71" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',71);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate71" id="LeaderRate71" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',71);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice71" id="CorrectionPrice71" value="" readonly onfocus="estimateSystemCursorAdvance('next',71);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate71" id="CorrectionRate71" value="" readonly onfocus="estimateSystemCursorAdvance('next',71);" />%</p>
        </td>
        <td class="td_project">

        </td>
      </tr>

      <tr id="Column_72" class="tr_no_disp">
        <td><input type="text" class="ColumnNo" name="ColumnNo72" id="ColumnNo72" value="72" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(72);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck72" id="DeleteCheck72" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('72');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(72);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode72" id="ProductCode72" value="" maxlength="20" onchange="estimateSystemProductSearch(72);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck72" id="OutletCheck72" value="1" onclick="estimateSystemOutletChack(72);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag72" id="FeeFlag72" value="" /><input type="hidden" name="SuperBigFlag72" id="SuperBigFlag72" value="" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName72" id="ProductName72" value="" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine72">Rコード <input type="text" class="ProductCode3" name="RCode72" id="RCode72" value="" maxlength="6" onchange="estimateSystemProductSearchRICOH(72);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea72"><div class="InventoryLayer" id="InventoryLayer72"></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck72" id="OpenCheck72" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice72" id="RegularPrice72" value="" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice72" id="NormalPrice72" value="" readonly onfocus="estimateSystemCursorAdvance('normal',72);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate72" id="NormalRate72" value="" readonly onfocus="estimateSystemCursorAdvance('normal',72);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate72" id="UnitRate72" value="" maxlength="5" onchange="estimateSystemUnitPercent(72, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice72" id="UnitPrice72" value="" maxlength="10" onchange="estimateSystemUnitPercent(72, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity72" id="Quantity72" value="" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(72); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice72" id="SubTotalPrice72" value="" readonly onfocus="estimateSystemCursorAdvance('sub',72);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime72" id="DeliveryTime72" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo72" id="Memo72" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice72"></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka72" id="EigyouGenka72" value="" readonly onfocus="estimateSystemCursorAdvance('next',72);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice72" id="MarginPrice72" value="" readonly onfocus="estimateSystemCursorAdvance('next',72);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice72" id="LimitPrice72" value="" readonly onfocus="estimateSystemCursorAdvance('next',72);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal72" id="MarginTotal72" value="" readonly onfocus="estimateSystemCursorAdvance('next',72);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate72" id="MarginRate72" value="" readonly onfocus="estimateSystemCursorAdvance('next',72);" />%</p>
        </td>
        <td id="MarginRank72"></td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment72" id="PurchaseComment72" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment72" id="DevLeaderComment72" readonly></textarea><input type="hidden" name="AutoAnswerFlag72" id="AutoAnswerFlag72" value="" /><input type="hidden" name="ImportantFlag72" id="ImportantFlag72" value="" /></p>
        </td>
        <td class="td_project"></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther72" id="RivalOther72" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker72" id="RivalMaker72" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku72" id="RivalSku72" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice72" id="RivalPrice72" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice72" id="LeaderPrice72" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',72);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate72" id="LeaderRate72" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',72);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice72" id="CorrectionPrice72" value="" readonly onfocus="estimateSystemCursorAdvance('next',72);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate72" id="CorrectionRate72" value="" readonly onfocus="estimateSystemCursorAdvance('next',72);" />%</p>
        </td>
        <td class="td_project">

        </td>
      </tr>

      <tr id="Column_73" class="tr_no_disp">
        <td><input type="text" class="ColumnNo" name="ColumnNo73" id="ColumnNo73" value="73" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(73);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck73" id="DeleteCheck73" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('73');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(73);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode73" id="ProductCode73" value="" maxlength="20" onchange="estimateSystemProductSearch(73);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck73" id="OutletCheck73" value="1" onclick="estimateSystemOutletChack(73);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag73" id="FeeFlag73" value="" /><input type="hidden" name="SuperBigFlag73" id="SuperBigFlag73" value="" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName73" id="ProductName73" value="" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine73">Rコード <input type="text" class="ProductCode3" name="RCode73" id="RCode73" value="" maxlength="6" onchange="estimateSystemProductSearchRICOH(73);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea73"><div class="InventoryLayer" id="InventoryLayer73"></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck73" id="OpenCheck73" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice73" id="RegularPrice73" value="" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice73" id="NormalPrice73" value="" readonly onfocus="estimateSystemCursorAdvance('normal',73);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate73" id="NormalRate73" value="" readonly onfocus="estimateSystemCursorAdvance('normal',73);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate73" id="UnitRate73" value="" maxlength="5" onchange="estimateSystemUnitPercent(73, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice73" id="UnitPrice73" value="" maxlength="10" onchange="estimateSystemUnitPercent(73, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity73" id="Quantity73" value="" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(73); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice73" id="SubTotalPrice73" value="" readonly onfocus="estimateSystemCursorAdvance('sub',73);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime73" id="DeliveryTime73" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo73" id="Memo73" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice73"></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka73" id="EigyouGenka73" value="" readonly onfocus="estimateSystemCursorAdvance('next',73);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice73" id="MarginPrice73" value="" readonly onfocus="estimateSystemCursorAdvance('next',73);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice73" id="LimitPrice73" value="" readonly onfocus="estimateSystemCursorAdvance('next',73);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal73" id="MarginTotal73" value="" readonly onfocus="estimateSystemCursorAdvance('next',73);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate73" id="MarginRate73" value="" readonly onfocus="estimateSystemCursorAdvance('next',73);" />%</p>
        </td>
        <td id="MarginRank73"></td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment73" id="PurchaseComment73" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment73" id="DevLeaderComment73" readonly></textarea><input type="hidden" name="AutoAnswerFlag73" id="AutoAnswerFlag73" value="" /><input type="hidden" name="ImportantFlag73" id="ImportantFlag73" value="" /></p>
        </td>
        <td class="td_project"></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther73" id="RivalOther73" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker73" id="RivalMaker73" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku73" id="RivalSku73" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice73" id="RivalPrice73" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice73" id="LeaderPrice73" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',73);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate73" id="LeaderRate73" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',73);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice73" id="CorrectionPrice73" value="" readonly onfocus="estimateSystemCursorAdvance('next',73);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate73" id="CorrectionRate73" value="" readonly onfocus="estimateSystemCursorAdvance('next',73);" />%</p>
        </td>
        <td class="td_project">

        </td>
      </tr>

      <tr id="Column_74" class="tr_no_disp">
        <td><input type="text" class="ColumnNo" name="ColumnNo74" id="ColumnNo74" value="74" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(74);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck74" id="DeleteCheck74" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('74');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(74);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode74" id="ProductCode74" value="" maxlength="20" onchange="estimateSystemProductSearch(74);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck74" id="OutletCheck74" value="1" onclick="estimateSystemOutletChack(74);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag74" id="FeeFlag74" value="" /><input type="hidden" name="SuperBigFlag74" id="SuperBigFlag74" value="" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName74" id="ProductName74" value="" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine74">Rコード <input type="text" class="ProductCode3" name="RCode74" id="RCode74" value="" maxlength="6" onchange="estimateSystemProductSearchRICOH(74);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea74"><div class="InventoryLayer" id="InventoryLayer74"></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck74" id="OpenCheck74" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice74" id="RegularPrice74" value="" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice74" id="NormalPrice74" value="" readonly onfocus="estimateSystemCursorAdvance('normal',74);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate74" id="NormalRate74" value="" readonly onfocus="estimateSystemCursorAdvance('normal',74);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate74" id="UnitRate74" value="" maxlength="5" onchange="estimateSystemUnitPercent(74, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice74" id="UnitPrice74" value="" maxlength="10" onchange="estimateSystemUnitPercent(74, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity74" id="Quantity74" value="" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(74); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice74" id="SubTotalPrice74" value="" readonly onfocus="estimateSystemCursorAdvance('sub',74);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime74" id="DeliveryTime74" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo74" id="Memo74" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice74"></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka74" id="EigyouGenka74" value="" readonly onfocus="estimateSystemCursorAdvance('next',74);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice74" id="MarginPrice74" value="" readonly onfocus="estimateSystemCursorAdvance('next',74);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice74" id="LimitPrice74" value="" readonly onfocus="estimateSystemCursorAdvance('next',74);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal74" id="MarginTotal74" value="" readonly onfocus="estimateSystemCursorAdvance('next',74);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate74" id="MarginRate74" value="" readonly onfocus="estimateSystemCursorAdvance('next',74);" />%</p>
        </td>
        <td id="MarginRank74"></td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment74" id="PurchaseComment74" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment74" id="DevLeaderComment74" readonly></textarea><input type="hidden" name="AutoAnswerFlag74" id="AutoAnswerFlag74" value="" /><input type="hidden" name="ImportantFlag74" id="ImportantFlag74" value="" /></p>
        </td>
        <td class="td_project"></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther74" id="RivalOther74" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker74" id="RivalMaker74" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku74" id="RivalSku74" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice74" id="RivalPrice74" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice74" id="LeaderPrice74" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',74);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate74" id="LeaderRate74" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',74);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice74" id="CorrectionPrice74" value="" readonly onfocus="estimateSystemCursorAdvance('next',74);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate74" id="CorrectionRate74" value="" readonly onfocus="estimateSystemCursorAdvance('next',74);" />%</p>
        </td>
        <td class="td_project">

        </td>
      </tr>

      <tr id="Column_75" class="tr_no_disp">
        <td><input type="text" class="ColumnNo" name="ColumnNo75" id="ColumnNo75" value="75" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(75);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck75" id="DeleteCheck75" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('75');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(75);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode75" id="ProductCode75" value="" maxlength="20" onchange="estimateSystemProductSearch(75);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck75" id="OutletCheck75" value="1" onclick="estimateSystemOutletChack(75);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag75" id="FeeFlag75" value="" /><input type="hidden" name="SuperBigFlag75" id="SuperBigFlag75" value="" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName75" id="ProductName75" value="" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine75">Rコード <input type="text" class="ProductCode3" name="RCode75" id="RCode75" value="" maxlength="6" onchange="estimateSystemProductSearchRICOH(75);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea75"><div class="InventoryLayer" id="InventoryLayer75"></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck75" id="OpenCheck75" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice75" id="RegularPrice75" value="" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice75" id="NormalPrice75" value="" readonly onfocus="estimateSystemCursorAdvance('normal',75);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate75" id="NormalRate75" value="" readonly onfocus="estimateSystemCursorAdvance('normal',75);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate75" id="UnitRate75" value="" maxlength="5" onchange="estimateSystemUnitPercent(75, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice75" id="UnitPrice75" value="" maxlength="10" onchange="estimateSystemUnitPercent(75, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity75" id="Quantity75" value="" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(75); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice75" id="SubTotalPrice75" value="" readonly onfocus="estimateSystemCursorAdvance('sub',75);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime75" id="DeliveryTime75" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo75" id="Memo75" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice75"></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka75" id="EigyouGenka75" value="" readonly onfocus="estimateSystemCursorAdvance('next',75);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice75" id="MarginPrice75" value="" readonly onfocus="estimateSystemCursorAdvance('next',75);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice75" id="LimitPrice75" value="" readonly onfocus="estimateSystemCursorAdvance('next',75);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal75" id="MarginTotal75" value="" readonly onfocus="estimateSystemCursorAdvance('next',75);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate75" id="MarginRate75" value="" readonly onfocus="estimateSystemCursorAdvance('next',75);" />%</p>
        </td>
        <td id="MarginRank75"></td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment75" id="PurchaseComment75" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment75" id="DevLeaderComment75" readonly></textarea><input type="hidden" name="AutoAnswerFlag75" id="AutoAnswerFlag75" value="" /><input type="hidden" name="ImportantFlag75" id="ImportantFlag75" value="" /></p>
        </td>
        <td class="td_project"></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther75" id="RivalOther75" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker75" id="RivalMaker75" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku75" id="RivalSku75" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice75" id="RivalPrice75" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice75" id="LeaderPrice75" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',75);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate75" id="LeaderRate75" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',75);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice75" id="CorrectionPrice75" value="" readonly onfocus="estimateSystemCursorAdvance('next',75);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate75" id="CorrectionRate75" value="" readonly onfocus="estimateSystemCursorAdvance('next',75);" />%</p>
        </td>
        <td class="td_project">

        </td>
      </tr>

      <tr id="Column_76" class="tr_no_disp">
        <td><input type="text" class="ColumnNo" name="ColumnNo76" id="ColumnNo76" value="76" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(76);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck76" id="DeleteCheck76" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('76');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(76);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode76" id="ProductCode76" value="" maxlength="20" onchange="estimateSystemProductSearch(76);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck76" id="OutletCheck76" value="1" onclick="estimateSystemOutletChack(76);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag76" id="FeeFlag76" value="" /><input type="hidden" name="SuperBigFlag76" id="SuperBigFlag76" value="" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName76" id="ProductName76" value="" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine76">Rコード <input type="text" class="ProductCode3" name="RCode76" id="RCode76" value="" maxlength="6" onchange="estimateSystemProductSearchRICOH(76);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea76"><div class="InventoryLayer" id="InventoryLayer76"></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck76" id="OpenCheck76" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice76" id="RegularPrice76" value="" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice76" id="NormalPrice76" value="" readonly onfocus="estimateSystemCursorAdvance('normal',76);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate76" id="NormalRate76" value="" readonly onfocus="estimateSystemCursorAdvance('normal',76);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate76" id="UnitRate76" value="" maxlength="5" onchange="estimateSystemUnitPercent(76, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice76" id="UnitPrice76" value="" maxlength="10" onchange="estimateSystemUnitPercent(76, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity76" id="Quantity76" value="" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(76); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice76" id="SubTotalPrice76" value="" readonly onfocus="estimateSystemCursorAdvance('sub',76);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime76" id="DeliveryTime76" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo76" id="Memo76" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice76"></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka76" id="EigyouGenka76" value="" readonly onfocus="estimateSystemCursorAdvance('next',76);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice76" id="MarginPrice76" value="" readonly onfocus="estimateSystemCursorAdvance('next',76);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice76" id="LimitPrice76" value="" readonly onfocus="estimateSystemCursorAdvance('next',76);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal76" id="MarginTotal76" value="" readonly onfocus="estimateSystemCursorAdvance('next',76);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate76" id="MarginRate76" value="" readonly onfocus="estimateSystemCursorAdvance('next',76);" />%</p>
        </td>
        <td id="MarginRank76"></td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment76" id="PurchaseComment76" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment76" id="DevLeaderComment76" readonly></textarea><input type="hidden" name="AutoAnswerFlag76" id="AutoAnswerFlag76" value="" /><input type="hidden" name="ImportantFlag76" id="ImportantFlag76" value="" /></p>
        </td>
        <td class="td_project"></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther76" id="RivalOther76" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker76" id="RivalMaker76" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku76" id="RivalSku76" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice76" id="RivalPrice76" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice76" id="LeaderPrice76" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',76);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate76" id="LeaderRate76" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',76);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice76" id="CorrectionPrice76" value="" readonly onfocus="estimateSystemCursorAdvance('next',76);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate76" id="CorrectionRate76" value="" readonly onfocus="estimateSystemCursorAdvance('next',76);" />%</p>
        </td>
        <td class="td_project">

        </td>
      </tr>

      <tr id="Column_77" class="tr_no_disp">
        <td><input type="text" class="ColumnNo" name="ColumnNo77" id="ColumnNo77" value="77" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(77);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck77" id="DeleteCheck77" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('77');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(77);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode77" id="ProductCode77" value="" maxlength="20" onchange="estimateSystemProductSearch(77);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck77" id="OutletCheck77" value="1" onclick="estimateSystemOutletChack(77);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag77" id="FeeFlag77" value="" /><input type="hidden" name="SuperBigFlag77" id="SuperBigFlag77" value="" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName77" id="ProductName77" value="" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine77">Rコード <input type="text" class="ProductCode3" name="RCode77" id="RCode77" value="" maxlength="6" onchange="estimateSystemProductSearchRICOH(77);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea77"><div class="InventoryLayer" id="InventoryLayer77"></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck77" id="OpenCheck77" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice77" id="RegularPrice77" value="" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice77" id="NormalPrice77" value="" readonly onfocus="estimateSystemCursorAdvance('normal',77);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate77" id="NormalRate77" value="" readonly onfocus="estimateSystemCursorAdvance('normal',77);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate77" id="UnitRate77" value="" maxlength="5" onchange="estimateSystemUnitPercent(77, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice77" id="UnitPrice77" value="" maxlength="10" onchange="estimateSystemUnitPercent(77, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity77" id="Quantity77" value="" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(77); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice77" id="SubTotalPrice77" value="" readonly onfocus="estimateSystemCursorAdvance('sub',77);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime77" id="DeliveryTime77" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo77" id="Memo77" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice77"></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka77" id="EigyouGenka77" value="" readonly onfocus="estimateSystemCursorAdvance('next',77);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice77" id="MarginPrice77" value="" readonly onfocus="estimateSystemCursorAdvance('next',77);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice77" id="LimitPrice77" value="" readonly onfocus="estimateSystemCursorAdvance('next',77);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal77" id="MarginTotal77" value="" readonly onfocus="estimateSystemCursorAdvance('next',77);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate77" id="MarginRate77" value="" readonly onfocus="estimateSystemCursorAdvance('next',77);" />%</p>
        </td>
        <td id="MarginRank77"></td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment77" id="PurchaseComment77" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment77" id="DevLeaderComment77" readonly></textarea><input type="hidden" name="AutoAnswerFlag77" id="AutoAnswerFlag77" value="" /><input type="hidden" name="ImportantFlag77" id="ImportantFlag77" value="" /></p>
        </td>
        <td class="td_project"></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther77" id="RivalOther77" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker77" id="RivalMaker77" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku77" id="RivalSku77" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice77" id="RivalPrice77" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice77" id="LeaderPrice77" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',77);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate77" id="LeaderRate77" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',77);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice77" id="CorrectionPrice77" value="" readonly onfocus="estimateSystemCursorAdvance('next',77);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate77" id="CorrectionRate77" value="" readonly onfocus="estimateSystemCursorAdvance('next',77);" />%</p>
        </td>
        <td class="td_project">

        </td>
      </tr>

      <tr id="Column_78" class="tr_no_disp">
        <td><input type="text" class="ColumnNo" name="ColumnNo78" id="ColumnNo78" value="78" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(78);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck78" id="DeleteCheck78" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('78');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(78);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode78" id="ProductCode78" value="" maxlength="20" onchange="estimateSystemProductSearch(78);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck78" id="OutletCheck78" value="1" onclick="estimateSystemOutletChack(78);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag78" id="FeeFlag78" value="" /><input type="hidden" name="SuperBigFlag78" id="SuperBigFlag78" value="" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName78" id="ProductName78" value="" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine78">Rコード <input type="text" class="ProductCode3" name="RCode78" id="RCode78" value="" maxlength="6" onchange="estimateSystemProductSearchRICOH(78);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea78"><div class="InventoryLayer" id="InventoryLayer78"></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck78" id="OpenCheck78" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice78" id="RegularPrice78" value="" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice78" id="NormalPrice78" value="" readonly onfocus="estimateSystemCursorAdvance('normal',78);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate78" id="NormalRate78" value="" readonly onfocus="estimateSystemCursorAdvance('normal',78);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate78" id="UnitRate78" value="" maxlength="5" onchange="estimateSystemUnitPercent(78, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice78" id="UnitPrice78" value="" maxlength="10" onchange="estimateSystemUnitPercent(78, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity78" id="Quantity78" value="" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(78); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice78" id="SubTotalPrice78" value="" readonly onfocus="estimateSystemCursorAdvance('sub',78);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime78" id="DeliveryTime78" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo78" id="Memo78" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice78"></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka78" id="EigyouGenka78" value="" readonly onfocus="estimateSystemCursorAdvance('next',78);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice78" id="MarginPrice78" value="" readonly onfocus="estimateSystemCursorAdvance('next',78);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice78" id="LimitPrice78" value="" readonly onfocus="estimateSystemCursorAdvance('next',78);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal78" id="MarginTotal78" value="" readonly onfocus="estimateSystemCursorAdvance('next',78);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate78" id="MarginRate78" value="" readonly onfocus="estimateSystemCursorAdvance('next',78);" />%</p>
        </td>
        <td id="MarginRank78"></td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment78" id="PurchaseComment78" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment78" id="DevLeaderComment78" readonly></textarea><input type="hidden" name="AutoAnswerFlag78" id="AutoAnswerFlag78" value="" /><input type="hidden" name="ImportantFlag78" id="ImportantFlag78" value="" /></p>
        </td>
        <td class="td_project"></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther78" id="RivalOther78" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker78" id="RivalMaker78" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku78" id="RivalSku78" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice78" id="RivalPrice78" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice78" id="LeaderPrice78" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',78);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate78" id="LeaderRate78" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',78);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice78" id="CorrectionPrice78" value="" readonly onfocus="estimateSystemCursorAdvance('next',78);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate78" id="CorrectionRate78" value="" readonly onfocus="estimateSystemCursorAdvance('next',78);" />%</p>
        </td>
        <td class="td_project">

        </td>
      </tr>

      <tr id="Column_79" class="tr_no_disp">
        <td><input type="text" class="ColumnNo" name="ColumnNo79" id="ColumnNo79" value="79" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(79);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck79" id="DeleteCheck79" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('79');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(79);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode79" id="ProductCode79" value="" maxlength="20" onchange="estimateSystemProductSearch(79);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck79" id="OutletCheck79" value="1" onclick="estimateSystemOutletChack(79);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag79" id="FeeFlag79" value="" /><input type="hidden" name="SuperBigFlag79" id="SuperBigFlag79" value="" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName79" id="ProductName79" value="" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine79">Rコード <input type="text" class="ProductCode3" name="RCode79" id="RCode79" value="" maxlength="6" onchange="estimateSystemProductSearchRICOH(79);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea79"><div class="InventoryLayer" id="InventoryLayer79"></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck79" id="OpenCheck79" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice79" id="RegularPrice79" value="" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice79" id="NormalPrice79" value="" readonly onfocus="estimateSystemCursorAdvance('normal',79);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate79" id="NormalRate79" value="" readonly onfocus="estimateSystemCursorAdvance('normal',79);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate79" id="UnitRate79" value="" maxlength="5" onchange="estimateSystemUnitPercent(79, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice79" id="UnitPrice79" value="" maxlength="10" onchange="estimateSystemUnitPercent(79, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity79" id="Quantity79" value="" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(79); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice79" id="SubTotalPrice79" value="" readonly onfocus="estimateSystemCursorAdvance('sub',79);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime79" id="DeliveryTime79" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo79" id="Memo79" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice79"></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka79" id="EigyouGenka79" value="" readonly onfocus="estimateSystemCursorAdvance('next',79);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice79" id="MarginPrice79" value="" readonly onfocus="estimateSystemCursorAdvance('next',79);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice79" id="LimitPrice79" value="" readonly onfocus="estimateSystemCursorAdvance('next',79);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal79" id="MarginTotal79" value="" readonly onfocus="estimateSystemCursorAdvance('next',79);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate79" id="MarginRate79" value="" readonly onfocus="estimateSystemCursorAdvance('next',79);" />%</p>
        </td>
        <td id="MarginRank79"></td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment79" id="PurchaseComment79" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment79" id="DevLeaderComment79" readonly></textarea><input type="hidden" name="AutoAnswerFlag79" id="AutoAnswerFlag79" value="" /><input type="hidden" name="ImportantFlag79" id="ImportantFlag79" value="" /></p>
        </td>
        <td class="td_project"></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther79" id="RivalOther79" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker79" id="RivalMaker79" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku79" id="RivalSku79" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice79" id="RivalPrice79" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice79" id="LeaderPrice79" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',79);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate79" id="LeaderRate79" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',79);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice79" id="CorrectionPrice79" value="" readonly onfocus="estimateSystemCursorAdvance('next',79);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate79" id="CorrectionRate79" value="" readonly onfocus="estimateSystemCursorAdvance('next',79);" />%</p>
        </td>
        <td class="td_project">

        </td>
      </tr>

      <tr id="Column_80" class="tr_no_disp">
        <td><input type="text" class="ColumnNo" name="ColumnNo80" id="ColumnNo80" value="80" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(80);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck80" id="DeleteCheck80" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('80');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(80);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode80" id="ProductCode80" value="" maxlength="20" onchange="estimateSystemProductSearch(80);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck80" id="OutletCheck80" value="1" onclick="estimateSystemOutletChack(80);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag80" id="FeeFlag80" value="" /><input type="hidden" name="SuperBigFlag80" id="SuperBigFlag80" value="" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName80" id="ProductName80" value="" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine80">Rコード <input type="text" class="ProductCode3" name="RCode80" id="RCode80" value="" maxlength="6" onchange="estimateSystemProductSearchRICOH(80);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea80"><div class="InventoryLayer" id="InventoryLayer80"></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck80" id="OpenCheck80" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice80" id="RegularPrice80" value="" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice80" id="NormalPrice80" value="" readonly onfocus="estimateSystemCursorAdvance('normal',80);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate80" id="NormalRate80" value="" readonly onfocus="estimateSystemCursorAdvance('normal',80);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate80" id="UnitRate80" value="" maxlength="5" onchange="estimateSystemUnitPercent(80, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice80" id="UnitPrice80" value="" maxlength="10" onchange="estimateSystemUnitPercent(80, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity80" id="Quantity80" value="" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(80); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice80" id="SubTotalPrice80" value="" readonly onfocus="estimateSystemCursorAdvance('sub',80);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime80" id="DeliveryTime80" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo80" id="Memo80" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice80"></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka80" id="EigyouGenka80" value="" readonly onfocus="estimateSystemCursorAdvance('next',80);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice80" id="MarginPrice80" value="" readonly onfocus="estimateSystemCursorAdvance('next',80);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice80" id="LimitPrice80" value="" readonly onfocus="estimateSystemCursorAdvance('next',80);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal80" id="MarginTotal80" value="" readonly onfocus="estimateSystemCursorAdvance('next',80);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate80" id="MarginRate80" value="" readonly onfocus="estimateSystemCursorAdvance('next',80);" />%</p>
        </td>
        <td id="MarginRank80"></td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment80" id="PurchaseComment80" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment80" id="DevLeaderComment80" readonly></textarea><input type="hidden" name="AutoAnswerFlag80" id="AutoAnswerFlag80" value="" /><input type="hidden" name="ImportantFlag80" id="ImportantFlag80" value="" /></p>
        </td>
        <td class="td_project"></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther80" id="RivalOther80" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker80" id="RivalMaker80" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku80" id="RivalSku80" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice80" id="RivalPrice80" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice80" id="LeaderPrice80" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',80);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate80" id="LeaderRate80" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',80);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice80" id="CorrectionPrice80" value="" readonly onfocus="estimateSystemCursorAdvance('next',80);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate80" id="CorrectionRate80" value="" readonly onfocus="estimateSystemCursorAdvance('next',80);" />%</p>
        </td>
        <td class="td_project">

        </td>
      </tr>

      <tr id="Column_81" class="tr_no_disp">
        <td><input type="text" class="ColumnNo" name="ColumnNo81" id="ColumnNo81" value="81" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(81);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck81" id="DeleteCheck81" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('81');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(81);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode81" id="ProductCode81" value="" maxlength="20" onchange="estimateSystemProductSearch(81);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck81" id="OutletCheck81" value="1" onclick="estimateSystemOutletChack(81);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag81" id="FeeFlag81" value="" /><input type="hidden" name="SuperBigFlag81" id="SuperBigFlag81" value="" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName81" id="ProductName81" value="" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine81">Rコード <input type="text" class="ProductCode3" name="RCode81" id="RCode81" value="" maxlength="6" onchange="estimateSystemProductSearchRICOH(81);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea81"><div class="InventoryLayer" id="InventoryLayer81"></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck81" id="OpenCheck81" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice81" id="RegularPrice81" value="" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice81" id="NormalPrice81" value="" readonly onfocus="estimateSystemCursorAdvance('normal',81);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate81" id="NormalRate81" value="" readonly onfocus="estimateSystemCursorAdvance('normal',81);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate81" id="UnitRate81" value="" maxlength="5" onchange="estimateSystemUnitPercent(81, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice81" id="UnitPrice81" value="" maxlength="10" onchange="estimateSystemUnitPercent(81, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity81" id="Quantity81" value="" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(81); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice81" id="SubTotalPrice81" value="" readonly onfocus="estimateSystemCursorAdvance('sub',81);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime81" id="DeliveryTime81" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo81" id="Memo81" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice81"></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka81" id="EigyouGenka81" value="" readonly onfocus="estimateSystemCursorAdvance('next',81);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice81" id="MarginPrice81" value="" readonly onfocus="estimateSystemCursorAdvance('next',81);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice81" id="LimitPrice81" value="" readonly onfocus="estimateSystemCursorAdvance('next',81);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal81" id="MarginTotal81" value="" readonly onfocus="estimateSystemCursorAdvance('next',81);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate81" id="MarginRate81" value="" readonly onfocus="estimateSystemCursorAdvance('next',81);" />%</p>
        </td>
        <td id="MarginRank81"></td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment81" id="PurchaseComment81" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment81" id="DevLeaderComment81" readonly></textarea><input type="hidden" name="AutoAnswerFlag81" id="AutoAnswerFlag81" value="" /><input type="hidden" name="ImportantFlag81" id="ImportantFlag81" value="" /></p>
        </td>
        <td class="td_project"></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther81" id="RivalOther81" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker81" id="RivalMaker81" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku81" id="RivalSku81" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice81" id="RivalPrice81" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice81" id="LeaderPrice81" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',81);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate81" id="LeaderRate81" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',81);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice81" id="CorrectionPrice81" value="" readonly onfocus="estimateSystemCursorAdvance('next',81);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate81" id="CorrectionRate81" value="" readonly onfocus="estimateSystemCursorAdvance('next',81);" />%</p>
        </td>
        <td class="td_project">

        </td>
      </tr>

      <tr id="Column_82" class="tr_no_disp">
        <td><input type="text" class="ColumnNo" name="ColumnNo82" id="ColumnNo82" value="82" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(82);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck82" id="DeleteCheck82" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('82');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(82);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode82" id="ProductCode82" value="" maxlength="20" onchange="estimateSystemProductSearch(82);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck82" id="OutletCheck82" value="1" onclick="estimateSystemOutletChack(82);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag82" id="FeeFlag82" value="" /><input type="hidden" name="SuperBigFlag82" id="SuperBigFlag82" value="" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName82" id="ProductName82" value="" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine82">Rコード <input type="text" class="ProductCode3" name="RCode82" id="RCode82" value="" maxlength="6" onchange="estimateSystemProductSearchRICOH(82);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea82"><div class="InventoryLayer" id="InventoryLayer82"></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck82" id="OpenCheck82" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice82" id="RegularPrice82" value="" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice82" id="NormalPrice82" value="" readonly onfocus="estimateSystemCursorAdvance('normal',82);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate82" id="NormalRate82" value="" readonly onfocus="estimateSystemCursorAdvance('normal',82);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate82" id="UnitRate82" value="" maxlength="5" onchange="estimateSystemUnitPercent(82, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice82" id="UnitPrice82" value="" maxlength="10" onchange="estimateSystemUnitPercent(82, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity82" id="Quantity82" value="" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(82); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice82" id="SubTotalPrice82" value="" readonly onfocus="estimateSystemCursorAdvance('sub',82);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime82" id="DeliveryTime82" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo82" id="Memo82" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice82"></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka82" id="EigyouGenka82" value="" readonly onfocus="estimateSystemCursorAdvance('next',82);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice82" id="MarginPrice82" value="" readonly onfocus="estimateSystemCursorAdvance('next',82);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice82" id="LimitPrice82" value="" readonly onfocus="estimateSystemCursorAdvance('next',82);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal82" id="MarginTotal82" value="" readonly onfocus="estimateSystemCursorAdvance('next',82);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate82" id="MarginRate82" value="" readonly onfocus="estimateSystemCursorAdvance('next',82);" />%</p>
        </td>
        <td id="MarginRank82"></td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment82" id="PurchaseComment82" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment82" id="DevLeaderComment82" readonly></textarea><input type="hidden" name="AutoAnswerFlag82" id="AutoAnswerFlag82" value="" /><input type="hidden" name="ImportantFlag82" id="ImportantFlag82" value="" /></p>
        </td>
        <td class="td_project"></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther82" id="RivalOther82" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker82" id="RivalMaker82" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku82" id="RivalSku82" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice82" id="RivalPrice82" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice82" id="LeaderPrice82" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',82);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate82" id="LeaderRate82" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',82);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice82" id="CorrectionPrice82" value="" readonly onfocus="estimateSystemCursorAdvance('next',82);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate82" id="CorrectionRate82" value="" readonly onfocus="estimateSystemCursorAdvance('next',82);" />%</p>
        </td>
        <td class="td_project">

        </td>
      </tr>

      <tr id="Column_83" class="tr_no_disp">
        <td><input type="text" class="ColumnNo" name="ColumnNo83" id="ColumnNo83" value="83" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(83);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck83" id="DeleteCheck83" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('83');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(83);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode83" id="ProductCode83" value="" maxlength="20" onchange="estimateSystemProductSearch(83);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck83" id="OutletCheck83" value="1" onclick="estimateSystemOutletChack(83);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag83" id="FeeFlag83" value="" /><input type="hidden" name="SuperBigFlag83" id="SuperBigFlag83" value="" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName83" id="ProductName83" value="" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine83">Rコード <input type="text" class="ProductCode3" name="RCode83" id="RCode83" value="" maxlength="6" onchange="estimateSystemProductSearchRICOH(83);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea83"><div class="InventoryLayer" id="InventoryLayer83"></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck83" id="OpenCheck83" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice83" id="RegularPrice83" value="" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice83" id="NormalPrice83" value="" readonly onfocus="estimateSystemCursorAdvance('normal',83);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate83" id="NormalRate83" value="" readonly onfocus="estimateSystemCursorAdvance('normal',83);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate83" id="UnitRate83" value="" maxlength="5" onchange="estimateSystemUnitPercent(83, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice83" id="UnitPrice83" value="" maxlength="10" onchange="estimateSystemUnitPercent(83, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity83" id="Quantity83" value="" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(83); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice83" id="SubTotalPrice83" value="" readonly onfocus="estimateSystemCursorAdvance('sub',83);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime83" id="DeliveryTime83" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo83" id="Memo83" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice83"></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka83" id="EigyouGenka83" value="" readonly onfocus="estimateSystemCursorAdvance('next',83);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice83" id="MarginPrice83" value="" readonly onfocus="estimateSystemCursorAdvance('next',83);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice83" id="LimitPrice83" value="" readonly onfocus="estimateSystemCursorAdvance('next',83);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal83" id="MarginTotal83" value="" readonly onfocus="estimateSystemCursorAdvance('next',83);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate83" id="MarginRate83" value="" readonly onfocus="estimateSystemCursorAdvance('next',83);" />%</p>
        </td>
        <td id="MarginRank83"></td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment83" id="PurchaseComment83" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment83" id="DevLeaderComment83" readonly></textarea><input type="hidden" name="AutoAnswerFlag83" id="AutoAnswerFlag83" value="" /><input type="hidden" name="ImportantFlag83" id="ImportantFlag83" value="" /></p>
        </td>
        <td class="td_project"></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther83" id="RivalOther83" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker83" id="RivalMaker83" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku83" id="RivalSku83" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice83" id="RivalPrice83" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice83" id="LeaderPrice83" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',83);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate83" id="LeaderRate83" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',83);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice83" id="CorrectionPrice83" value="" readonly onfocus="estimateSystemCursorAdvance('next',83);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate83" id="CorrectionRate83" value="" readonly onfocus="estimateSystemCursorAdvance('next',83);" />%</p>
        </td>
        <td class="td_project">

        </td>
      </tr>

      <tr id="Column_84" class="tr_no_disp">
        <td><input type="text" class="ColumnNo" name="ColumnNo84" id="ColumnNo84" value="84" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(84);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck84" id="DeleteCheck84" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('84');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(84);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode84" id="ProductCode84" value="" maxlength="20" onchange="estimateSystemProductSearch(84);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck84" id="OutletCheck84" value="1" onclick="estimateSystemOutletChack(84);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag84" id="FeeFlag84" value="" /><input type="hidden" name="SuperBigFlag84" id="SuperBigFlag84" value="" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName84" id="ProductName84" value="" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine84">Rコード <input type="text" class="ProductCode3" name="RCode84" id="RCode84" value="" maxlength="6" onchange="estimateSystemProductSearchRICOH(84);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea84"><div class="InventoryLayer" id="InventoryLayer84"></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck84" id="OpenCheck84" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice84" id="RegularPrice84" value="" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice84" id="NormalPrice84" value="" readonly onfocus="estimateSystemCursorAdvance('normal',84);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate84" id="NormalRate84" value="" readonly onfocus="estimateSystemCursorAdvance('normal',84);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate84" id="UnitRate84" value="" maxlength="5" onchange="estimateSystemUnitPercent(84, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice84" id="UnitPrice84" value="" maxlength="10" onchange="estimateSystemUnitPercent(84, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity84" id="Quantity84" value="" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(84); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice84" id="SubTotalPrice84" value="" readonly onfocus="estimateSystemCursorAdvance('sub',84);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime84" id="DeliveryTime84" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo84" id="Memo84" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice84"></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka84" id="EigyouGenka84" value="" readonly onfocus="estimateSystemCursorAdvance('next',84);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice84" id="MarginPrice84" value="" readonly onfocus="estimateSystemCursorAdvance('next',84);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice84" id="LimitPrice84" value="" readonly onfocus="estimateSystemCursorAdvance('next',84);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal84" id="MarginTotal84" value="" readonly onfocus="estimateSystemCursorAdvance('next',84);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate84" id="MarginRate84" value="" readonly onfocus="estimateSystemCursorAdvance('next',84);" />%</p>
        </td>
        <td id="MarginRank84"></td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment84" id="PurchaseComment84" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment84" id="DevLeaderComment84" readonly></textarea><input type="hidden" name="AutoAnswerFlag84" id="AutoAnswerFlag84" value="" /><input type="hidden" name="ImportantFlag84" id="ImportantFlag84" value="" /></p>
        </td>
        <td class="td_project"></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther84" id="RivalOther84" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker84" id="RivalMaker84" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku84" id="RivalSku84" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice84" id="RivalPrice84" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice84" id="LeaderPrice84" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',84);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate84" id="LeaderRate84" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',84);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice84" id="CorrectionPrice84" value="" readonly onfocus="estimateSystemCursorAdvance('next',84);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate84" id="CorrectionRate84" value="" readonly onfocus="estimateSystemCursorAdvance('next',84);" />%</p>
        </td>
        <td class="td_project">

        </td>
      </tr>

      <tr id="Column_85" class="tr_no_disp">
        <td><input type="text" class="ColumnNo" name="ColumnNo85" id="ColumnNo85" value="85" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(85);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck85" id="DeleteCheck85" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('85');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(85);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode85" id="ProductCode85" value="" maxlength="20" onchange="estimateSystemProductSearch(85);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck85" id="OutletCheck85" value="1" onclick="estimateSystemOutletChack(85);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag85" id="FeeFlag85" value="" /><input type="hidden" name="SuperBigFlag85" id="SuperBigFlag85" value="" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName85" id="ProductName85" value="" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine85">Rコード <input type="text" class="ProductCode3" name="RCode85" id="RCode85" value="" maxlength="6" onchange="estimateSystemProductSearchRICOH(85);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea85"><div class="InventoryLayer" id="InventoryLayer85"></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck85" id="OpenCheck85" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice85" id="RegularPrice85" value="" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice85" id="NormalPrice85" value="" readonly onfocus="estimateSystemCursorAdvance('normal',85);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate85" id="NormalRate85" value="" readonly onfocus="estimateSystemCursorAdvance('normal',85);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate85" id="UnitRate85" value="" maxlength="5" onchange="estimateSystemUnitPercent(85, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice85" id="UnitPrice85" value="" maxlength="10" onchange="estimateSystemUnitPercent(85, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity85" id="Quantity85" value="" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(85); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice85" id="SubTotalPrice85" value="" readonly onfocus="estimateSystemCursorAdvance('sub',85);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime85" id="DeliveryTime85" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo85" id="Memo85" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice85"></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka85" id="EigyouGenka85" value="" readonly onfocus="estimateSystemCursorAdvance('next',85);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice85" id="MarginPrice85" value="" readonly onfocus="estimateSystemCursorAdvance('next',85);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice85" id="LimitPrice85" value="" readonly onfocus="estimateSystemCursorAdvance('next',85);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal85" id="MarginTotal85" value="" readonly onfocus="estimateSystemCursorAdvance('next',85);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate85" id="MarginRate85" value="" readonly onfocus="estimateSystemCursorAdvance('next',85);" />%</p>
        </td>
        <td id="MarginRank85"></td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment85" id="PurchaseComment85" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment85" id="DevLeaderComment85" readonly></textarea><input type="hidden" name="AutoAnswerFlag85" id="AutoAnswerFlag85" value="" /><input type="hidden" name="ImportantFlag85" id="ImportantFlag85" value="" /></p>
        </td>
        <td class="td_project"></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther85" id="RivalOther85" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker85" id="RivalMaker85" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku85" id="RivalSku85" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice85" id="RivalPrice85" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice85" id="LeaderPrice85" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',85);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate85" id="LeaderRate85" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',85);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice85" id="CorrectionPrice85" value="" readonly onfocus="estimateSystemCursorAdvance('next',85);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate85" id="CorrectionRate85" value="" readonly onfocus="estimateSystemCursorAdvance('next',85);" />%</p>
        </td>
        <td class="td_project">

        </td>
      </tr>

      <tr id="Column_86" class="tr_no_disp">
        <td><input type="text" class="ColumnNo" name="ColumnNo86" id="ColumnNo86" value="86" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(86);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck86" id="DeleteCheck86" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('86');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(86);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode86" id="ProductCode86" value="" maxlength="20" onchange="estimateSystemProductSearch(86);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck86" id="OutletCheck86" value="1" onclick="estimateSystemOutletChack(86);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag86" id="FeeFlag86" value="" /><input type="hidden" name="SuperBigFlag86" id="SuperBigFlag86" value="" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName86" id="ProductName86" value="" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine86">Rコード <input type="text" class="ProductCode3" name="RCode86" id="RCode86" value="" maxlength="6" onchange="estimateSystemProductSearchRICOH(86);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea86"><div class="InventoryLayer" id="InventoryLayer86"></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck86" id="OpenCheck86" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice86" id="RegularPrice86" value="" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice86" id="NormalPrice86" value="" readonly onfocus="estimateSystemCursorAdvance('normal',86);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate86" id="NormalRate86" value="" readonly onfocus="estimateSystemCursorAdvance('normal',86);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate86" id="UnitRate86" value="" maxlength="5" onchange="estimateSystemUnitPercent(86, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice86" id="UnitPrice86" value="" maxlength="10" onchange="estimateSystemUnitPercent(86, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity86" id="Quantity86" value="" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(86); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice86" id="SubTotalPrice86" value="" readonly onfocus="estimateSystemCursorAdvance('sub',86);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime86" id="DeliveryTime86" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo86" id="Memo86" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice86"></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka86" id="EigyouGenka86" value="" readonly onfocus="estimateSystemCursorAdvance('next',86);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice86" id="MarginPrice86" value="" readonly onfocus="estimateSystemCursorAdvance('next',86);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice86" id="LimitPrice86" value="" readonly onfocus="estimateSystemCursorAdvance('next',86);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal86" id="MarginTotal86" value="" readonly onfocus="estimateSystemCursorAdvance('next',86);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate86" id="MarginRate86" value="" readonly onfocus="estimateSystemCursorAdvance('next',86);" />%</p>
        </td>
        <td id="MarginRank86"></td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment86" id="PurchaseComment86" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment86" id="DevLeaderComment86" readonly></textarea><input type="hidden" name="AutoAnswerFlag86" id="AutoAnswerFlag86" value="" /><input type="hidden" name="ImportantFlag86" id="ImportantFlag86" value="" /></p>
        </td>
        <td class="td_project"></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther86" id="RivalOther86" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker86" id="RivalMaker86" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku86" id="RivalSku86" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice86" id="RivalPrice86" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice86" id="LeaderPrice86" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',86);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate86" id="LeaderRate86" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',86);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice86" id="CorrectionPrice86" value="" readonly onfocus="estimateSystemCursorAdvance('next',86);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate86" id="CorrectionRate86" value="" readonly onfocus="estimateSystemCursorAdvance('next',86);" />%</p>
        </td>
        <td class="td_project">

        </td>
      </tr>

      <tr id="Column_87" class="tr_no_disp">
        <td><input type="text" class="ColumnNo" name="ColumnNo87" id="ColumnNo87" value="87" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(87);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck87" id="DeleteCheck87" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('87');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(87);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode87" id="ProductCode87" value="" maxlength="20" onchange="estimateSystemProductSearch(87);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck87" id="OutletCheck87" value="1" onclick="estimateSystemOutletChack(87);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag87" id="FeeFlag87" value="" /><input type="hidden" name="SuperBigFlag87" id="SuperBigFlag87" value="" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName87" id="ProductName87" value="" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine87">Rコード <input type="text" class="ProductCode3" name="RCode87" id="RCode87" value="" maxlength="6" onchange="estimateSystemProductSearchRICOH(87);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea87"><div class="InventoryLayer" id="InventoryLayer87"></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck87" id="OpenCheck87" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice87" id="RegularPrice87" value="" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice87" id="NormalPrice87" value="" readonly onfocus="estimateSystemCursorAdvance('normal',87);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate87" id="NormalRate87" value="" readonly onfocus="estimateSystemCursorAdvance('normal',87);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate87" id="UnitRate87" value="" maxlength="5" onchange="estimateSystemUnitPercent(87, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice87" id="UnitPrice87" value="" maxlength="10" onchange="estimateSystemUnitPercent(87, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity87" id="Quantity87" value="" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(87); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice87" id="SubTotalPrice87" value="" readonly onfocus="estimateSystemCursorAdvance('sub',87);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime87" id="DeliveryTime87" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo87" id="Memo87" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice87"></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka87" id="EigyouGenka87" value="" readonly onfocus="estimateSystemCursorAdvance('next',87);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice87" id="MarginPrice87" value="" readonly onfocus="estimateSystemCursorAdvance('next',87);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice87" id="LimitPrice87" value="" readonly onfocus="estimateSystemCursorAdvance('next',87);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal87" id="MarginTotal87" value="" readonly onfocus="estimateSystemCursorAdvance('next',87);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate87" id="MarginRate87" value="" readonly onfocus="estimateSystemCursorAdvance('next',87);" />%</p>
        </td>
        <td id="MarginRank87"></td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment87" id="PurchaseComment87" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment87" id="DevLeaderComment87" readonly></textarea><input type="hidden" name="AutoAnswerFlag87" id="AutoAnswerFlag87" value="" /><input type="hidden" name="ImportantFlag87" id="ImportantFlag87" value="" /></p>
        </td>
        <td class="td_project"></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther87" id="RivalOther87" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker87" id="RivalMaker87" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku87" id="RivalSku87" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice87" id="RivalPrice87" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice87" id="LeaderPrice87" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',87);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate87" id="LeaderRate87" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',87);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice87" id="CorrectionPrice87" value="" readonly onfocus="estimateSystemCursorAdvance('next',87);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate87" id="CorrectionRate87" value="" readonly onfocus="estimateSystemCursorAdvance('next',87);" />%</p>
        </td>
        <td class="td_project">

        </td>
      </tr>

      <tr id="Column_88" class="tr_no_disp">
        <td><input type="text" class="ColumnNo" name="ColumnNo88" id="ColumnNo88" value="88" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(88);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck88" id="DeleteCheck88" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('88');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(88);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode88" id="ProductCode88" value="" maxlength="20" onchange="estimateSystemProductSearch(88);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck88" id="OutletCheck88" value="1" onclick="estimateSystemOutletChack(88);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag88" id="FeeFlag88" value="" /><input type="hidden" name="SuperBigFlag88" id="SuperBigFlag88" value="" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName88" id="ProductName88" value="" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine88">Rコード <input type="text" class="ProductCode3" name="RCode88" id="RCode88" value="" maxlength="6" onchange="estimateSystemProductSearchRICOH(88);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea88"><div class="InventoryLayer" id="InventoryLayer88"></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck88" id="OpenCheck88" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice88" id="RegularPrice88" value="" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice88" id="NormalPrice88" value="" readonly onfocus="estimateSystemCursorAdvance('normal',88);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate88" id="NormalRate88" value="" readonly onfocus="estimateSystemCursorAdvance('normal',88);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate88" id="UnitRate88" value="" maxlength="5" onchange="estimateSystemUnitPercent(88, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice88" id="UnitPrice88" value="" maxlength="10" onchange="estimateSystemUnitPercent(88, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity88" id="Quantity88" value="" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(88); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice88" id="SubTotalPrice88" value="" readonly onfocus="estimateSystemCursorAdvance('sub',88);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime88" id="DeliveryTime88" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo88" id="Memo88" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice88"></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka88" id="EigyouGenka88" value="" readonly onfocus="estimateSystemCursorAdvance('next',88);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice88" id="MarginPrice88" value="" readonly onfocus="estimateSystemCursorAdvance('next',88);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice88" id="LimitPrice88" value="" readonly onfocus="estimateSystemCursorAdvance('next',88);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal88" id="MarginTotal88" value="" readonly onfocus="estimateSystemCursorAdvance('next',88);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate88" id="MarginRate88" value="" readonly onfocus="estimateSystemCursorAdvance('next',88);" />%</p>
        </td>
        <td id="MarginRank88"></td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment88" id="PurchaseComment88" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment88" id="DevLeaderComment88" readonly></textarea><input type="hidden" name="AutoAnswerFlag88" id="AutoAnswerFlag88" value="" /><input type="hidden" name="ImportantFlag88" id="ImportantFlag88" value="" /></p>
        </td>
        <td class="td_project"></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther88" id="RivalOther88" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker88" id="RivalMaker88" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku88" id="RivalSku88" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice88" id="RivalPrice88" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice88" id="LeaderPrice88" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',88);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate88" id="LeaderRate88" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',88);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice88" id="CorrectionPrice88" value="" readonly onfocus="estimateSystemCursorAdvance('next',88);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate88" id="CorrectionRate88" value="" readonly onfocus="estimateSystemCursorAdvance('next',88);" />%</p>
        </td>
        <td class="td_project">

        </td>
      </tr>

      <tr id="Column_89" class="tr_no_disp">
        <td><input type="text" class="ColumnNo" name="ColumnNo89" id="ColumnNo89" value="89" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(89);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck89" id="DeleteCheck89" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('89');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(89);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode89" id="ProductCode89" value="" maxlength="20" onchange="estimateSystemProductSearch(89);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck89" id="OutletCheck89" value="1" onclick="estimateSystemOutletChack(89);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag89" id="FeeFlag89" value="" /><input type="hidden" name="SuperBigFlag89" id="SuperBigFlag89" value="" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName89" id="ProductName89" value="" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine89">Rコード <input type="text" class="ProductCode3" name="RCode89" id="RCode89" value="" maxlength="6" onchange="estimateSystemProductSearchRICOH(89);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea89"><div class="InventoryLayer" id="InventoryLayer89"></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck89" id="OpenCheck89" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice89" id="RegularPrice89" value="" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice89" id="NormalPrice89" value="" readonly onfocus="estimateSystemCursorAdvance('normal',89);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate89" id="NormalRate89" value="" readonly onfocus="estimateSystemCursorAdvance('normal',89);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate89" id="UnitRate89" value="" maxlength="5" onchange="estimateSystemUnitPercent(89, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice89" id="UnitPrice89" value="" maxlength="10" onchange="estimateSystemUnitPercent(89, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity89" id="Quantity89" value="" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(89); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice89" id="SubTotalPrice89" value="" readonly onfocus="estimateSystemCursorAdvance('sub',89);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime89" id="DeliveryTime89" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo89" id="Memo89" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice89"></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka89" id="EigyouGenka89" value="" readonly onfocus="estimateSystemCursorAdvance('next',89);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice89" id="MarginPrice89" value="" readonly onfocus="estimateSystemCursorAdvance('next',89);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice89" id="LimitPrice89" value="" readonly onfocus="estimateSystemCursorAdvance('next',89);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal89" id="MarginTotal89" value="" readonly onfocus="estimateSystemCursorAdvance('next',89);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate89" id="MarginRate89" value="" readonly onfocus="estimateSystemCursorAdvance('next',89);" />%</p>
        </td>
        <td id="MarginRank89"></td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment89" id="PurchaseComment89" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment89" id="DevLeaderComment89" readonly></textarea><input type="hidden" name="AutoAnswerFlag89" id="AutoAnswerFlag89" value="" /><input type="hidden" name="ImportantFlag89" id="ImportantFlag89" value="" /></p>
        </td>
        <td class="td_project"></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther89" id="RivalOther89" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker89" id="RivalMaker89" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku89" id="RivalSku89" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice89" id="RivalPrice89" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice89" id="LeaderPrice89" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',89);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate89" id="LeaderRate89" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',89);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice89" id="CorrectionPrice89" value="" readonly onfocus="estimateSystemCursorAdvance('next',89);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate89" id="CorrectionRate89" value="" readonly onfocus="estimateSystemCursorAdvance('next',89);" />%</p>
        </td>
        <td class="td_project">

        </td>
      </tr>

      <tr id="Column_90" class="tr_no_disp">
        <td><input type="text" class="ColumnNo" name="ColumnNo90" id="ColumnNo90" value="90" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(90);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck90" id="DeleteCheck90" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('90');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(90);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode90" id="ProductCode90" value="" maxlength="20" onchange="estimateSystemProductSearch(90);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck90" id="OutletCheck90" value="1" onclick="estimateSystemOutletChack(90);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag90" id="FeeFlag90" value="" /><input type="hidden" name="SuperBigFlag90" id="SuperBigFlag90" value="" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName90" id="ProductName90" value="" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine90">Rコード <input type="text" class="ProductCode3" name="RCode90" id="RCode90" value="" maxlength="6" onchange="estimateSystemProductSearchRICOH(90);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea90"><div class="InventoryLayer" id="InventoryLayer90"></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck90" id="OpenCheck90" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice90" id="RegularPrice90" value="" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice90" id="NormalPrice90" value="" readonly onfocus="estimateSystemCursorAdvance('normal',90);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate90" id="NormalRate90" value="" readonly onfocus="estimateSystemCursorAdvance('normal',90);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate90" id="UnitRate90" value="" maxlength="5" onchange="estimateSystemUnitPercent(90, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice90" id="UnitPrice90" value="" maxlength="10" onchange="estimateSystemUnitPercent(90, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity90" id="Quantity90" value="" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(90); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice90" id="SubTotalPrice90" value="" readonly onfocus="estimateSystemCursorAdvance('sub',90);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime90" id="DeliveryTime90" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo90" id="Memo90" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice90"></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka90" id="EigyouGenka90" value="" readonly onfocus="estimateSystemCursorAdvance('next',90);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice90" id="MarginPrice90" value="" readonly onfocus="estimateSystemCursorAdvance('next',90);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice90" id="LimitPrice90" value="" readonly onfocus="estimateSystemCursorAdvance('next',90);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal90" id="MarginTotal90" value="" readonly onfocus="estimateSystemCursorAdvance('next',90);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate90" id="MarginRate90" value="" readonly onfocus="estimateSystemCursorAdvance('next',90);" />%</p>
        </td>
        <td id="MarginRank90"></td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment90" id="PurchaseComment90" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment90" id="DevLeaderComment90" readonly></textarea><input type="hidden" name="AutoAnswerFlag90" id="AutoAnswerFlag90" value="" /><input type="hidden" name="ImportantFlag90" id="ImportantFlag90" value="" /></p>
        </td>
        <td class="td_project"></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther90" id="RivalOther90" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker90" id="RivalMaker90" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku90" id="RivalSku90" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice90" id="RivalPrice90" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice90" id="LeaderPrice90" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',90);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate90" id="LeaderRate90" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',90);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice90" id="CorrectionPrice90" value="" readonly onfocus="estimateSystemCursorAdvance('next',90);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate90" id="CorrectionRate90" value="" readonly onfocus="estimateSystemCursorAdvance('next',90);" />%</p>
        </td>
        <td class="td_project">

        </td>
      </tr>

      <tr id="Column_91" class="tr_no_disp">
        <td><input type="text" class="ColumnNo" name="ColumnNo91" id="ColumnNo91" value="91" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(91);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck91" id="DeleteCheck91" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('91');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(91);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode91" id="ProductCode91" value="" maxlength="20" onchange="estimateSystemProductSearch(91);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck91" id="OutletCheck91" value="1" onclick="estimateSystemOutletChack(91);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag91" id="FeeFlag91" value="" /><input type="hidden" name="SuperBigFlag91" id="SuperBigFlag91" value="" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName91" id="ProductName91" value="" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine91">Rコード <input type="text" class="ProductCode3" name="RCode91" id="RCode91" value="" maxlength="6" onchange="estimateSystemProductSearchRICOH(91);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea91"><div class="InventoryLayer" id="InventoryLayer91"></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck91" id="OpenCheck91" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice91" id="RegularPrice91" value="" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice91" id="NormalPrice91" value="" readonly onfocus="estimateSystemCursorAdvance('normal',91);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate91" id="NormalRate91" value="" readonly onfocus="estimateSystemCursorAdvance('normal',91);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate91" id="UnitRate91" value="" maxlength="5" onchange="estimateSystemUnitPercent(91, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice91" id="UnitPrice91" value="" maxlength="10" onchange="estimateSystemUnitPercent(91, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity91" id="Quantity91" value="" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(91); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice91" id="SubTotalPrice91" value="" readonly onfocus="estimateSystemCursorAdvance('sub',91);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime91" id="DeliveryTime91" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo91" id="Memo91" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice91"></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka91" id="EigyouGenka91" value="" readonly onfocus="estimateSystemCursorAdvance('next',91);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice91" id="MarginPrice91" value="" readonly onfocus="estimateSystemCursorAdvance('next',91);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice91" id="LimitPrice91" value="" readonly onfocus="estimateSystemCursorAdvance('next',91);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal91" id="MarginTotal91" value="" readonly onfocus="estimateSystemCursorAdvance('next',91);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate91" id="MarginRate91" value="" readonly onfocus="estimateSystemCursorAdvance('next',91);" />%</p>
        </td>
        <td id="MarginRank91"></td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment91" id="PurchaseComment91" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment91" id="DevLeaderComment91" readonly></textarea><input type="hidden" name="AutoAnswerFlag91" id="AutoAnswerFlag91" value="" /><input type="hidden" name="ImportantFlag91" id="ImportantFlag91" value="" /></p>
        </td>
        <td class="td_project"></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther91" id="RivalOther91" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker91" id="RivalMaker91" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku91" id="RivalSku91" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice91" id="RivalPrice91" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice91" id="LeaderPrice91" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',91);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate91" id="LeaderRate91" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',91);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice91" id="CorrectionPrice91" value="" readonly onfocus="estimateSystemCursorAdvance('next',91);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate91" id="CorrectionRate91" value="" readonly onfocus="estimateSystemCursorAdvance('next',91);" />%</p>
        </td>
        <td class="td_project">

        </td>
      </tr>

      <tr id="Column_92" class="tr_no_disp">
        <td><input type="text" class="ColumnNo" name="ColumnNo92" id="ColumnNo92" value="92" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(92);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck92" id="DeleteCheck92" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('92');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(92);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode92" id="ProductCode92" value="" maxlength="20" onchange="estimateSystemProductSearch(92);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck92" id="OutletCheck92" value="1" onclick="estimateSystemOutletChack(92);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag92" id="FeeFlag92" value="" /><input type="hidden" name="SuperBigFlag92" id="SuperBigFlag92" value="" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName92" id="ProductName92" value="" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine92">Rコード <input type="text" class="ProductCode3" name="RCode92" id="RCode92" value="" maxlength="6" onchange="estimateSystemProductSearchRICOH(92);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea92"><div class="InventoryLayer" id="InventoryLayer92"></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck92" id="OpenCheck92" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice92" id="RegularPrice92" value="" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice92" id="NormalPrice92" value="" readonly onfocus="estimateSystemCursorAdvance('normal',92);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate92" id="NormalRate92" value="" readonly onfocus="estimateSystemCursorAdvance('normal',92);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate92" id="UnitRate92" value="" maxlength="5" onchange="estimateSystemUnitPercent(92, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice92" id="UnitPrice92" value="" maxlength="10" onchange="estimateSystemUnitPercent(92, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity92" id="Quantity92" value="" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(92); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice92" id="SubTotalPrice92" value="" readonly onfocus="estimateSystemCursorAdvance('sub',92);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime92" id="DeliveryTime92" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo92" id="Memo92" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice92"></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka92" id="EigyouGenka92" value="" readonly onfocus="estimateSystemCursorAdvance('next',92);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice92" id="MarginPrice92" value="" readonly onfocus="estimateSystemCursorAdvance('next',92);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice92" id="LimitPrice92" value="" readonly onfocus="estimateSystemCursorAdvance('next',92);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal92" id="MarginTotal92" value="" readonly onfocus="estimateSystemCursorAdvance('next',92);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate92" id="MarginRate92" value="" readonly onfocus="estimateSystemCursorAdvance('next',92);" />%</p>
        </td>
        <td id="MarginRank92"></td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment92" id="PurchaseComment92" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment92" id="DevLeaderComment92" readonly></textarea><input type="hidden" name="AutoAnswerFlag92" id="AutoAnswerFlag92" value="" /><input type="hidden" name="ImportantFlag92" id="ImportantFlag92" value="" /></p>
        </td>
        <td class="td_project"></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther92" id="RivalOther92" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker92" id="RivalMaker92" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku92" id="RivalSku92" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice92" id="RivalPrice92" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice92" id="LeaderPrice92" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',92);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate92" id="LeaderRate92" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',92);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice92" id="CorrectionPrice92" value="" readonly onfocus="estimateSystemCursorAdvance('next',92);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate92" id="CorrectionRate92" value="" readonly onfocus="estimateSystemCursorAdvance('next',92);" />%</p>
        </td>
        <td class="td_project">

        </td>
      </tr>

      <tr id="Column_93" class="tr_no_disp">
        <td><input type="text" class="ColumnNo" name="ColumnNo93" id="ColumnNo93" value="93" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(93);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck93" id="DeleteCheck93" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('93');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(93);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode93" id="ProductCode93" value="" maxlength="20" onchange="estimateSystemProductSearch(93);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck93" id="OutletCheck93" value="1" onclick="estimateSystemOutletChack(93);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag93" id="FeeFlag93" value="" /><input type="hidden" name="SuperBigFlag93" id="SuperBigFlag93" value="" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName93" id="ProductName93" value="" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine93">Rコード <input type="text" class="ProductCode3" name="RCode93" id="RCode93" value="" maxlength="6" onchange="estimateSystemProductSearchRICOH(93);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea93"><div class="InventoryLayer" id="InventoryLayer93"></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck93" id="OpenCheck93" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice93" id="RegularPrice93" value="" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice93" id="NormalPrice93" value="" readonly onfocus="estimateSystemCursorAdvance('normal',93);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate93" id="NormalRate93" value="" readonly onfocus="estimateSystemCursorAdvance('normal',93);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate93" id="UnitRate93" value="" maxlength="5" onchange="estimateSystemUnitPercent(93, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice93" id="UnitPrice93" value="" maxlength="10" onchange="estimateSystemUnitPercent(93, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity93" id="Quantity93" value="" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(93); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice93" id="SubTotalPrice93" value="" readonly onfocus="estimateSystemCursorAdvance('sub',93);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime93" id="DeliveryTime93" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo93" id="Memo93" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice93"></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka93" id="EigyouGenka93" value="" readonly onfocus="estimateSystemCursorAdvance('next',93);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice93" id="MarginPrice93" value="" readonly onfocus="estimateSystemCursorAdvance('next',93);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice93" id="LimitPrice93" value="" readonly onfocus="estimateSystemCursorAdvance('next',93);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal93" id="MarginTotal93" value="" readonly onfocus="estimateSystemCursorAdvance('next',93);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate93" id="MarginRate93" value="" readonly onfocus="estimateSystemCursorAdvance('next',93);" />%</p>
        </td>
        <td id="MarginRank93"></td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment93" id="PurchaseComment93" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment93" id="DevLeaderComment93" readonly></textarea><input type="hidden" name="AutoAnswerFlag93" id="AutoAnswerFlag93" value="" /><input type="hidden" name="ImportantFlag93" id="ImportantFlag93" value="" /></p>
        </td>
        <td class="td_project"></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther93" id="RivalOther93" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker93" id="RivalMaker93" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku93" id="RivalSku93" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice93" id="RivalPrice93" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice93" id="LeaderPrice93" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',93);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate93" id="LeaderRate93" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',93);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice93" id="CorrectionPrice93" value="" readonly onfocus="estimateSystemCursorAdvance('next',93);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate93" id="CorrectionRate93" value="" readonly onfocus="estimateSystemCursorAdvance('next',93);" />%</p>
        </td>
        <td class="td_project">

        </td>
      </tr>

      <tr id="Column_94" class="tr_no_disp">
        <td><input type="text" class="ColumnNo" name="ColumnNo94" id="ColumnNo94" value="94" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(94);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck94" id="DeleteCheck94" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('94');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(94);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode94" id="ProductCode94" value="" maxlength="20" onchange="estimateSystemProductSearch(94);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck94" id="OutletCheck94" value="1" onclick="estimateSystemOutletChack(94);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag94" id="FeeFlag94" value="" /><input type="hidden" name="SuperBigFlag94" id="SuperBigFlag94" value="" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName94" id="ProductName94" value="" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine94">Rコード <input type="text" class="ProductCode3" name="RCode94" id="RCode94" value="" maxlength="6" onchange="estimateSystemProductSearchRICOH(94);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea94"><div class="InventoryLayer" id="InventoryLayer94"></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck94" id="OpenCheck94" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice94" id="RegularPrice94" value="" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice94" id="NormalPrice94" value="" readonly onfocus="estimateSystemCursorAdvance('normal',94);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate94" id="NormalRate94" value="" readonly onfocus="estimateSystemCursorAdvance('normal',94);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate94" id="UnitRate94" value="" maxlength="5" onchange="estimateSystemUnitPercent(94, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice94" id="UnitPrice94" value="" maxlength="10" onchange="estimateSystemUnitPercent(94, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity94" id="Quantity94" value="" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(94); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice94" id="SubTotalPrice94" value="" readonly onfocus="estimateSystemCursorAdvance('sub',94);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime94" id="DeliveryTime94" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo94" id="Memo94" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice94"></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka94" id="EigyouGenka94" value="" readonly onfocus="estimateSystemCursorAdvance('next',94);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice94" id="MarginPrice94" value="" readonly onfocus="estimateSystemCursorAdvance('next',94);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice94" id="LimitPrice94" value="" readonly onfocus="estimateSystemCursorAdvance('next',94);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal94" id="MarginTotal94" value="" readonly onfocus="estimateSystemCursorAdvance('next',94);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate94" id="MarginRate94" value="" readonly onfocus="estimateSystemCursorAdvance('next',94);" />%</p>
        </td>
        <td id="MarginRank94"></td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment94" id="PurchaseComment94" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment94" id="DevLeaderComment94" readonly></textarea><input type="hidden" name="AutoAnswerFlag94" id="AutoAnswerFlag94" value="" /><input type="hidden" name="ImportantFlag94" id="ImportantFlag94" value="" /></p>
        </td>
        <td class="td_project"></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther94" id="RivalOther94" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker94" id="RivalMaker94" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku94" id="RivalSku94" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice94" id="RivalPrice94" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice94" id="LeaderPrice94" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',94);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate94" id="LeaderRate94" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',94);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice94" id="CorrectionPrice94" value="" readonly onfocus="estimateSystemCursorAdvance('next',94);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate94" id="CorrectionRate94" value="" readonly onfocus="estimateSystemCursorAdvance('next',94);" />%</p>
        </td>
        <td class="td_project">

        </td>
      </tr>

      <tr id="Column_95" class="tr_no_disp">
        <td><input type="text" class="ColumnNo" name="ColumnNo95" id="ColumnNo95" value="95" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(95);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck95" id="DeleteCheck95" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('95');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(95);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode95" id="ProductCode95" value="" maxlength="20" onchange="estimateSystemProductSearch(95);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck95" id="OutletCheck95" value="1" onclick="estimateSystemOutletChack(95);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag95" id="FeeFlag95" value="" /><input type="hidden" name="SuperBigFlag95" id="SuperBigFlag95" value="" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName95" id="ProductName95" value="" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine95">Rコード <input type="text" class="ProductCode3" name="RCode95" id="RCode95" value="" maxlength="6" onchange="estimateSystemProductSearchRICOH(95);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea95"><div class="InventoryLayer" id="InventoryLayer95"></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck95" id="OpenCheck95" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice95" id="RegularPrice95" value="" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice95" id="NormalPrice95" value="" readonly onfocus="estimateSystemCursorAdvance('normal',95);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate95" id="NormalRate95" value="" readonly onfocus="estimateSystemCursorAdvance('normal',95);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate95" id="UnitRate95" value="" maxlength="5" onchange="estimateSystemUnitPercent(95, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice95" id="UnitPrice95" value="" maxlength="10" onchange="estimateSystemUnitPercent(95, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity95" id="Quantity95" value="" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(95); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice95" id="SubTotalPrice95" value="" readonly onfocus="estimateSystemCursorAdvance('sub',95);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime95" id="DeliveryTime95" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo95" id="Memo95" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice95"></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka95" id="EigyouGenka95" value="" readonly onfocus="estimateSystemCursorAdvance('next',95);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice95" id="MarginPrice95" value="" readonly onfocus="estimateSystemCursorAdvance('next',95);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice95" id="LimitPrice95" value="" readonly onfocus="estimateSystemCursorAdvance('next',95);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal95" id="MarginTotal95" value="" readonly onfocus="estimateSystemCursorAdvance('next',95);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate95" id="MarginRate95" value="" readonly onfocus="estimateSystemCursorAdvance('next',95);" />%</p>
        </td>
        <td id="MarginRank95"></td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment95" id="PurchaseComment95" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment95" id="DevLeaderComment95" readonly></textarea><input type="hidden" name="AutoAnswerFlag95" id="AutoAnswerFlag95" value="" /><input type="hidden" name="ImportantFlag95" id="ImportantFlag95" value="" /></p>
        </td>
        <td class="td_project"></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther95" id="RivalOther95" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker95" id="RivalMaker95" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku95" id="RivalSku95" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice95" id="RivalPrice95" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice95" id="LeaderPrice95" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',95);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate95" id="LeaderRate95" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',95);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice95" id="CorrectionPrice95" value="" readonly onfocus="estimateSystemCursorAdvance('next',95);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate95" id="CorrectionRate95" value="" readonly onfocus="estimateSystemCursorAdvance('next',95);" />%</p>
        </td>
        <td class="td_project">

        </td>
      </tr>

      <tr id="Column_96" class="tr_no_disp">
        <td><input type="text" class="ColumnNo" name="ColumnNo96" id="ColumnNo96" value="96" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(96);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck96" id="DeleteCheck96" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('96');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(96);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode96" id="ProductCode96" value="" maxlength="20" onchange="estimateSystemProductSearch(96);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck96" id="OutletCheck96" value="1" onclick="estimateSystemOutletChack(96);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag96" id="FeeFlag96" value="" /><input type="hidden" name="SuperBigFlag96" id="SuperBigFlag96" value="" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName96" id="ProductName96" value="" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine96">Rコード <input type="text" class="ProductCode3" name="RCode96" id="RCode96" value="" maxlength="6" onchange="estimateSystemProductSearchRICOH(96);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea96"><div class="InventoryLayer" id="InventoryLayer96"></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck96" id="OpenCheck96" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice96" id="RegularPrice96" value="" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice96" id="NormalPrice96" value="" readonly onfocus="estimateSystemCursorAdvance('normal',96);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate96" id="NormalRate96" value="" readonly onfocus="estimateSystemCursorAdvance('normal',96);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate96" id="UnitRate96" value="" maxlength="5" onchange="estimateSystemUnitPercent(96, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice96" id="UnitPrice96" value="" maxlength="10" onchange="estimateSystemUnitPercent(96, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity96" id="Quantity96" value="" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(96); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice96" id="SubTotalPrice96" value="" readonly onfocus="estimateSystemCursorAdvance('sub',96);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime96" id="DeliveryTime96" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo96" id="Memo96" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice96"></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka96" id="EigyouGenka96" value="" readonly onfocus="estimateSystemCursorAdvance('next',96);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice96" id="MarginPrice96" value="" readonly onfocus="estimateSystemCursorAdvance('next',96);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice96" id="LimitPrice96" value="" readonly onfocus="estimateSystemCursorAdvance('next',96);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal96" id="MarginTotal96" value="" readonly onfocus="estimateSystemCursorAdvance('next',96);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate96" id="MarginRate96" value="" readonly onfocus="estimateSystemCursorAdvance('next',96);" />%</p>
        </td>
        <td id="MarginRank96"></td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment96" id="PurchaseComment96" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment96" id="DevLeaderComment96" readonly></textarea><input type="hidden" name="AutoAnswerFlag96" id="AutoAnswerFlag96" value="" /><input type="hidden" name="ImportantFlag96" id="ImportantFlag96" value="" /></p>
        </td>
        <td class="td_project"></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther96" id="RivalOther96" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker96" id="RivalMaker96" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku96" id="RivalSku96" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice96" id="RivalPrice96" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice96" id="LeaderPrice96" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',96);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate96" id="LeaderRate96" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',96);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice96" id="CorrectionPrice96" value="" readonly onfocus="estimateSystemCursorAdvance('next',96);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate96" id="CorrectionRate96" value="" readonly onfocus="estimateSystemCursorAdvance('next',96);" />%</p>
        </td>
        <td class="td_project">

        </td>
      </tr>

      <tr id="Column_97" class="tr_no_disp">
        <td><input type="text" class="ColumnNo" name="ColumnNo97" id="ColumnNo97" value="97" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(97);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck97" id="DeleteCheck97" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('97');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(97);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode97" id="ProductCode97" value="" maxlength="20" onchange="estimateSystemProductSearch(97);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck97" id="OutletCheck97" value="1" onclick="estimateSystemOutletChack(97);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag97" id="FeeFlag97" value="" /><input type="hidden" name="SuperBigFlag97" id="SuperBigFlag97" value="" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName97" id="ProductName97" value="" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine97">Rコード <input type="text" class="ProductCode3" name="RCode97" id="RCode97" value="" maxlength="6" onchange="estimateSystemProductSearchRICOH(97);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea97"><div class="InventoryLayer" id="InventoryLayer97"></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck97" id="OpenCheck97" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice97" id="RegularPrice97" value="" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice97" id="NormalPrice97" value="" readonly onfocus="estimateSystemCursorAdvance('normal',97);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate97" id="NormalRate97" value="" readonly onfocus="estimateSystemCursorAdvance('normal',97);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate97" id="UnitRate97" value="" maxlength="5" onchange="estimateSystemUnitPercent(97, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice97" id="UnitPrice97" value="" maxlength="10" onchange="estimateSystemUnitPercent(97, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity97" id="Quantity97" value="" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(97); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice97" id="SubTotalPrice97" value="" readonly onfocus="estimateSystemCursorAdvance('sub',97);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime97" id="DeliveryTime97" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo97" id="Memo97" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice97"></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka97" id="EigyouGenka97" value="" readonly onfocus="estimateSystemCursorAdvance('next',97);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice97" id="MarginPrice97" value="" readonly onfocus="estimateSystemCursorAdvance('next',97);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice97" id="LimitPrice97" value="" readonly onfocus="estimateSystemCursorAdvance('next',97);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal97" id="MarginTotal97" value="" readonly onfocus="estimateSystemCursorAdvance('next',97);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate97" id="MarginRate97" value="" readonly onfocus="estimateSystemCursorAdvance('next',97);" />%</p>
        </td>
        <td id="MarginRank97"></td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment97" id="PurchaseComment97" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment97" id="DevLeaderComment97" readonly></textarea><input type="hidden" name="AutoAnswerFlag97" id="AutoAnswerFlag97" value="" /><input type="hidden" name="ImportantFlag97" id="ImportantFlag97" value="" /></p>
        </td>
        <td class="td_project"></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther97" id="RivalOther97" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker97" id="RivalMaker97" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku97" id="RivalSku97" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice97" id="RivalPrice97" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice97" id="LeaderPrice97" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',97);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate97" id="LeaderRate97" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',97);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice97" id="CorrectionPrice97" value="" readonly onfocus="estimateSystemCursorAdvance('next',97);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate97" id="CorrectionRate97" value="" readonly onfocus="estimateSystemCursorAdvance('next',97);" />%</p>
        </td>
        <td class="td_project">

        </td>
      </tr>

      <tr id="Column_98" class="tr_no_disp">
        <td><input type="text" class="ColumnNo" name="ColumnNo98" id="ColumnNo98" value="98" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(98);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck98" id="DeleteCheck98" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('98');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(98);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode98" id="ProductCode98" value="" maxlength="20" onchange="estimateSystemProductSearch(98);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck98" id="OutletCheck98" value="1" onclick="estimateSystemOutletChack(98);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag98" id="FeeFlag98" value="" /><input type="hidden" name="SuperBigFlag98" id="SuperBigFlag98" value="" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName98" id="ProductName98" value="" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine98">Rコード <input type="text" class="ProductCode3" name="RCode98" id="RCode98" value="" maxlength="6" onchange="estimateSystemProductSearchRICOH(98);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea98"><div class="InventoryLayer" id="InventoryLayer98"></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck98" id="OpenCheck98" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice98" id="RegularPrice98" value="" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice98" id="NormalPrice98" value="" readonly onfocus="estimateSystemCursorAdvance('normal',98);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate98" id="NormalRate98" value="" readonly onfocus="estimateSystemCursorAdvance('normal',98);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate98" id="UnitRate98" value="" maxlength="5" onchange="estimateSystemUnitPercent(98, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice98" id="UnitPrice98" value="" maxlength="10" onchange="estimateSystemUnitPercent(98, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity98" id="Quantity98" value="" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(98); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice98" id="SubTotalPrice98" value="" readonly onfocus="estimateSystemCursorAdvance('sub',98);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime98" id="DeliveryTime98" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo98" id="Memo98" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice98"></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka98" id="EigyouGenka98" value="" readonly onfocus="estimateSystemCursorAdvance('next',98);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice98" id="MarginPrice98" value="" readonly onfocus="estimateSystemCursorAdvance('next',98);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice98" id="LimitPrice98" value="" readonly onfocus="estimateSystemCursorAdvance('next',98);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal98" id="MarginTotal98" value="" readonly onfocus="estimateSystemCursorAdvance('next',98);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate98" id="MarginRate98" value="" readonly onfocus="estimateSystemCursorAdvance('next',98);" />%</p>
        </td>
        <td id="MarginRank98"></td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment98" id="PurchaseComment98" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment98" id="DevLeaderComment98" readonly></textarea><input type="hidden" name="AutoAnswerFlag98" id="AutoAnswerFlag98" value="" /><input type="hidden" name="ImportantFlag98" id="ImportantFlag98" value="" /></p>
        </td>
        <td class="td_project"></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther98" id="RivalOther98" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker98" id="RivalMaker98" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku98" id="RivalSku98" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice98" id="RivalPrice98" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice98" id="LeaderPrice98" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',98);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate98" id="LeaderRate98" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',98);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice98" id="CorrectionPrice98" value="" readonly onfocus="estimateSystemCursorAdvance('next',98);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate98" id="CorrectionRate98" value="" readonly onfocus="estimateSystemCursorAdvance('next',98);" />%</p>
        </td>
        <td class="td_project">

        </td>
      </tr>

      <tr id="Column_99" class="tr_no_disp">
        <td><input type="text" class="ColumnNo" name="ColumnNo99" id="ColumnNo99" value="99" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(99);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck99" id="DeleteCheck99" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('99');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(99);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode99" id="ProductCode99" value="" maxlength="20" onchange="estimateSystemProductSearch(99);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck99" id="OutletCheck99" value="1" onclick="estimateSystemOutletChack(99);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag99" id="FeeFlag99" value="" /><input type="hidden" name="SuperBigFlag99" id="SuperBigFlag99" value="" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName99" id="ProductName99" value="" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine99">Rコード <input type="text" class="ProductCode3" name="RCode99" id="RCode99" value="" maxlength="6" onchange="estimateSystemProductSearchRICOH(99);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea99"><div class="InventoryLayer" id="InventoryLayer99"></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck99" id="OpenCheck99" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice99" id="RegularPrice99" value="" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice99" id="NormalPrice99" value="" readonly onfocus="estimateSystemCursorAdvance('normal',99);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate99" id="NormalRate99" value="" readonly onfocus="estimateSystemCursorAdvance('normal',99);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate99" id="UnitRate99" value="" maxlength="5" onchange="estimateSystemUnitPercent(99, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice99" id="UnitPrice99" value="" maxlength="10" onchange="estimateSystemUnitPercent(99, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity99" id="Quantity99" value="" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(99); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice99" id="SubTotalPrice99" value="" readonly onfocus="estimateSystemCursorAdvance('sub',99);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime99" id="DeliveryTime99" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo99" id="Memo99" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice99"></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka99" id="EigyouGenka99" value="" readonly onfocus="estimateSystemCursorAdvance('next',99);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice99" id="MarginPrice99" value="" readonly onfocus="estimateSystemCursorAdvance('next',99);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice99" id="LimitPrice99" value="" readonly onfocus="estimateSystemCursorAdvance('next',99);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal99" id="MarginTotal99" value="" readonly onfocus="estimateSystemCursorAdvance('next',99);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate99" id="MarginRate99" value="" readonly onfocus="estimateSystemCursorAdvance('next',99);" />%</p>
        </td>
        <td id="MarginRank99"></td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment99" id="PurchaseComment99" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment99" id="DevLeaderComment99" readonly></textarea><input type="hidden" name="AutoAnswerFlag99" id="AutoAnswerFlag99" value="" /><input type="hidden" name="ImportantFlag99" id="ImportantFlag99" value="" /></p>
        </td>
        <td class="td_project"></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther99" id="RivalOther99" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker99" id="RivalMaker99" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku99" id="RivalSku99" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice99" id="RivalPrice99" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice99" id="LeaderPrice99" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',99);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate99" id="LeaderRate99" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',99);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice99" id="CorrectionPrice99" value="" readonly onfocus="estimateSystemCursorAdvance('next',99);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate99" id="CorrectionRate99" value="" readonly onfocus="estimateSystemCursorAdvance('next',99);" />%</p>
        </td>
        <td class="td_project">

        </td>
      </tr>

      <tr id="Column_100" class="tr_no_disp">
        <td><input type="text" class="ColumnNo" name="ColumnNo100" id="ColumnNo100" value="100" onfocus="this.select();" onblur="estimateSystemDetailColumnNoChk(100);" maxlength="3" /><br />
            <input type="checkbox" name="DeleteCheck100" id="DeleteCheck100" value="1" onclick="estimateSystemTotalCalc(); estimateSystemLineDeleteChk('100');" /><br />
            <input type="button" class="LineClear" value="ｸﾘｱ" onclick="estimateSystemLineDelete(100);" /></td>
        <td>
          <p><input type="text" class="ProductCode2" name="ProductCode100" id="ProductCode100" value="" maxlength="20" onchange="estimateSystemProductSearch(100);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /> <input type="checkbox" name="OutletCheck100" id="OutletCheck100" value="1" onclick="estimateSystemOutletChack(100);" title="アウトレットフラグ" /><input type="hidden" name="FeeFlag100" id="FeeFlag100" value="" /><input type="hidden" name="SuperBigFlag100" id="SuperBigFlag100" value="" /></p>
          <p><input type="text" class="ProductName" style="color: #000;" name="ProductName100" id="ProductName100" value="" maxlength="50" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p id="RCodeLine100">Rコード <input type="text" class="ProductCode3" name="RCode100" id="RCode100" value="" maxlength="6" onchange="estimateSystemProductSearchRICOH(100);" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p class="InventoryArea" id="InventoryArea100"><div class="InventoryLayer" id="InventoryLayer100"></div></p>
        </td>
        <td><input type="checkbox" name="OpenCheck100" id="OpenCheck100" value="1" /></td>
        <td>
          <p><input type="text" class="PriceBox" name="RegularPrice100" id="RegularPrice100" value="" maxlength="10" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
          <p><input type="text" class="PriceBox" name="NormalPrice100" id="NormalPrice100" value="" readonly onfocus="estimateSystemCursorAdvance('normal',100);" /></p>
          <p><input type="text" class="PercentBox" name="NormalRate100" id="NormalRate100" value="" readonly onfocus="estimateSystemCursorAdvance('normal',100);" />%</p>
        </td>
        <td>
          <p><input type="text" class="PercentBox" name="UnitRate100" id="UnitRate100" value="" maxlength="5" onchange="estimateSystemUnitPercent(100, '率');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" />%</p>
          <p><input type="text" class="PriceBox" name="UnitPrice100" id="UnitPrice100" value="" maxlength="10" onchange="estimateSystemUnitPercent(100, '価格');" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" /></p>
        </td>
        <td><input type="text" class="AmountBox" name="Quantity100" id="Quantity100" value="" autocomplete="off" maxlength="6" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemSubCalcQt(100); estimateSystemCursorColorDisable(this.id);" /></td>
        <td><input type="text" class="PriceBox" name="SubTotalPrice100" id="SubTotalPrice100" value="" readonly onfocus="estimateSystemCursorAdvance('sub',100);" /></td>
        <td>
          <p><input type="text" class="CommentBox" name="DeliveryTime100" id="DeliveryTime100" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '30');" title="全角20文字程度" /></p>
          <p><input type="text" class="CommentBox" name="Memo100" id="Memo100" value="" maxlength="255" onfocus="estimateSystemCursorColorActive(this.id);" onblur="estimateSystemCursorColorDisable(this.id);" onchange="estimateSystemByteCheck(this.id, '60');" title="全角40文字程度" /></p>
          <p class="ProductNotice" id="ProductNotice100"></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="EigyouGenka100" id="EigyouGenka100" value="" readonly onfocus="estimateSystemCursorAdvance('next',100);" /></p>
          <p><input type="text" class="PriceBox" name="MarginPrice100" id="MarginPrice100" value="" readonly onfocus="estimateSystemCursorAdvance('next',100);" /></p>
          <p><input type="text" class="LimitBox" name="LimitPrice100" id="LimitPrice100" value="" readonly onfocus="estimateSystemCursorAdvance('next',100);" /></p>
        </td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotal100" id="MarginTotal100" value="" readonly onfocus="estimateSystemCursorAdvance('next',100);" /></p>
          <p><input type="text" class="PercentBox" name="MarginRate100" id="MarginRate100" value="" readonly onfocus="estimateSystemCursorAdvance('next',100);" />%</p>
        </td>
        <td id="MarginRank100"></td>
        <td class="td_project">
          <p><textarea class="TextBox2" name="PurchaseComment100" id="PurchaseComment100" readonly></textarea></p>
          <p><textarea class="TextBox2" name="DevLeaderComment100" id="DevLeaderComment100" readonly></textarea><input type="hidden" name="AutoAnswerFlag100" id="AutoAnswerFlag100" value="" /><input type="hidden" name="ImportantFlag100" id="ImportantFlag100" value="" /></p>
        </td>
        <td class="td_project"></td>
        <td class="td_project"><textarea class="TextBox1" name="RivalOther100" id="RivalOther100" placeholder="仕入へのメッセージなど"></textarea></td>
        <td class="td_project">
          <p><input type="text" class="CommentBox" name="RivalMaker100" id="RivalMaker100" value="" placeholder="メーカー" /></p>
          <p><input type="text" class="CommentBox" name="RivalSku100" id="RivalSku100" value="" placeholder="品番" /></p>
          <p><input type="text" class="CommentBox" name="RivalPrice100" id="RivalPrice100" value="" placeholder="価格" /></p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="LeaderPrice100" id="LeaderPrice100" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',100);" /></p>
          <p><input type="text" class="PercentBox" name="LeaderRate100" id="LeaderRate100" value="" readonly onfocus="estimateSystemCursorAdvance('quantity',100);" />%</p>
        </td>
        <td class="td_project">
          <p><input type="text" class="PriceBox" name="CorrectionPrice100" id="CorrectionPrice100" value="" readonly onfocus="estimateSystemCursorAdvance('next',100);" /></p>
          <p><input type="text" class="PercentBox" name="CorrectionRate100" id="CorrectionRate100" value="" readonly onfocus="estimateSystemCursorAdvance('next',100);" />%</p>
        </td>
        <td class="td_project">

        </td>
      </tr>

      <tr>
        <td colspan="5" class="td_total">合計</td>
        <td><input type="text" class="PercentBox" name="TotalQuantity" id="TotalQuantity" value="8" readonly /></td>
        <td><input type="text" class="PriceBox" name="UnderTotalPrice" id="UnderTotalPrice" value="426844" readonly /></td>
        <td colspan="2">大物送料対象：<input type="text" class="PriceBox" name="TotalFee" id="TotalFee" value="6" readonly /></td>
        <td>
          <p><input type="text" class="PriceBox" name="MarginTotalTotal" id="MarginTotalTotal" value="122980" readonly /></p>
          <p><input type="text" class="PercentBox" name="MarginRateTotal" id="MarginRateTotal" value="28.8" readonly />%</p>
        </td>
        <td id="MarginRankTotal">B</td>
        <td colspan="7"></td>
      </tr>
    </table>

    <p id="DetailAddBtn"><input type="button" value="+ 行追加" onclick="estimateSystemDetailAddLine()" /></p>

    <input type="hidden" name="NowDispMax" id="NowDispMax" value="20" />
  </div>

  <!-- ◆◆◆ 各種ボタン ◆◆◆ -->
  <div class="fix_area">
    <a href="#" class="back_btn">&#8743;</a>

    <div class="detail_btn">

      <p class="button_area"><input type="button" class="bill_btn" value="請求書発行&#13;&#10;(先入金用)" onclick="estimateSystemDetailIssue('bill');" />&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" class="copy_btn" value="コピー" onclick="estimateSystemDetailCopy('T20022500072');" />&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" class="issue_btn" value="発行" onclick="estimateSystemDetailIssue();" />&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" class="issue_btn" value="CSV" onclick="estimateSystemDetailCSVDL();" />&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" class="save_btn" value="引継いで仮登録" onclick="estimateSystemDetailSave('継','仮','0');" />&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" class="save_btn" value="引継いで本登録" onclick="estimateSystemDetailSave('継','本','0');" />&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" class="prj_save_btn" value="案件情報保存" onclick="estimateSystemDetailProjectSave();" title="見積番号は変更されず緑色になっている部分のみが保存されます。" /></p>
      <p class="mail_area"><label for="ProjectMailFlag">案件メールを送信する(開発・仕入・リーダー)
                                                                  
                                                                  <input type="checkbox" name="ProjectMailFlag" id="ProjectMailFlag" value="1" onclick="estimateSystemDetailProjectMailToggle('Project');" /></label></p>

      <p class="mail_area2"><label for="ConclusionMailFlag">成約状況メールを送信する(仕入)
                                                                   
                                                                   <input type="checkbox" name="ConclusionMailFlag" id="ConclusionMailFlag" value="1" onclick="estimateSystemDetailProjectMailToggle('Conclusion');" /></label></p>

      <p class="mail_notice">※メール送信は案件管理している場合のみ有効です。</p>
    </div>
  </div>
</div><%--estimate_system_detail--%>

    </div><%--estimate_system_detail--%>

<%--</form>--%>

</div><%--admin_main_contents--%>
    <!-- ▲ メインコンテンツ閉め ▲ -->

</asp:Content>
