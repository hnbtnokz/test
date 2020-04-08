// ************************
//   見積システム用JSファイル
// ************************
var MaxDispLine = 100;

// 検索画面のCSVダウンロード
function estimateSystemSearchCSVDown() {
	//document.ESListForm.action = "./csv_download.asp";
	//document.ESListForm.submit();
    document.getElementById("ESListForm").action = "http://localhost/csv_download.asp";
    document.getElementById("ESListForm").submit();
}

// 検索画面のページ送り
function estimateSystemSearchAssist(pnum) {
	document.getElementById("page").value = pnum;
	document.getElementById("IssueNo").value = "";
	document.getElementById("DeleteNo").value = "";
	document.getElementById("DispNo").value = "";
	document.getElementById("DispMode").value = "";
	document.ESListForm.action = "./index.asp";
	document.ESListForm.target = "_self";
	document.ESListForm.submit();
}

// 検索画面の検索ボタン
function estimateSystemSearchButton() {
	document.getElementById("page").value = 1;
	document.getElementById("IssueNo").value = "";
	document.getElementById("DeleteNo").value = "";
	document.getElementById("DispNo").value = "";
	document.getElementById("DispMode").value = "";
	document.ESListForm.action = "./index.asp";
	document.ESListForm.target = "_self";
	document.ESListForm.submit();
}

// 検索画面の削除ボタン
function estimateSystemSearchDelete(CNo) {
	if(confirm("見積番号 "+CNo+" を削除します。\nよろしいですか？")) {
		document.getElementById("DeleteNo").value = CNo;
		document.getElementById("IssueNo").value = "";
		document.getElementById("DispNo").value = "";
		document.getElementById("DispMode").value = "";
		document.ESListForm.action = "./index.asp";
	document.ESListForm.target = "_self";
		document.ESListForm.submit();
	}
}

// 検索画面の詳細ボタン
function estimateSystemSearchAdvance(CNo) {
	//location.href = "./detail.asp?cno=" + CNo;
    location.href = "./Pages/Detail/Detail.aspx?cno=" + CNo;
}

// 検索画面の発行ボタン
function estimateSystemSearchIssue(CNo) {
	document.getElementById("IssueNo").value = CNo;
	document.getElementById("DeleteNo").value = "";
	document.getElementById("DispNo").value = "";
	document.getElementById("DispMode").value = "";
	document.ESListForm.action = "./index.asp";
	document.ESListForm.target = "_blank";
	document.ESListForm.submit();
}

// 検索画面の回答ボタン
function estimateSystemSearchCheck(CNo) {
	location.href = "./Pages/Check/Check.aspx?cno=" + CNo;
}

// 検索画面の物件ボタン
function estimateSystemSearchBukken(CNo) {
	window.open("http://iw/bukken/main/index_est.asp?EstNum=" + CNo,"bukken","");
}

// 検索画面からのサンワCh On Off
function estimateSystemDispChange(mode, cno) {
	compFlag = 0;

	if (mode == "on") {
		if (confirm(cno+"をサンワChで表示にします。\nよろしいですか？")) {
			compFlag = 1;
		}
	} else {
		if (confirm(cno+"をサンワChで非表示にします。\nよろしいですか？")) {
			compFlag = 1;
		}
	}

	if (compFlag == 1) {
		document.getElementById("IssueNo").value = "";
		document.getElementById("DeleteNo").value = "";
		document.getElementById("DispNo").value = cno;
		document.getElementById("DispMode").value = mode;
		document.ESListForm.action = "./index.asp";
		document.ESListForm.target = "_self";
		document.ESListForm.submit();
	}
}

// 入力フォームでエンターを押した操作
function estimateSystemEnterExe(key) {
    if (key == 13) {
        $("#btnSearch").trigger("click");

		//estimateSystemSearchButton();
	}
}

// 詳細画面の顧客情報検索ajax
function estimateSystemCustomerSearch() {
	CCode = document.getElementById("CustomerCode").value;

	if (CCode.length != 10 && isNaN(CCode) == false) {
		while (CCode.length != 10) {
			CCode = "0" + CCode;
		}
		document.getElementById("CustomerCode").value = CCode;
	}

	if (!Process_flg && http) {
		var url = "ES_CustomerSearch.asp?CC=" + CCode;
		http.open("GET", url, true);
		http.onreadystatechange = handleHttpResponseAdminESCustSearch;
		Process_flg = true;
		http.send(null);
	}
}

// 結果代入用
function handleHttpResponseAdminESCustSearch() {
	if (http.readyState == 4) {
		if (http.status == 200) {
			if (http.responseText.indexOf('invalid') == -1) {
				results = http.responseText.split("@");

				if (results[0] == "T") {
					// データが見つかった場合値を挿入
					document.getElementById("CustomerName").value = results[1];
					document.getElementById("CustomerDivision").value = results[2];
					document.getElementById("CustomerPersonName").value = results[3];
					document.getElementById("Tel").value = results[4];
					document.getElementById("Fax").value = results[5];
					document.getElementById("SalesPersonCode").value = results[6];
					document.getElementById("SalesPersonName").value = results[7];
					document.getElementById("AssistantCode").value = results[8];
					document.getElementById("AssistantName").value = results[9];

					Process_flg = false;

					if (document.getElementById("CustomerCode").value.substring(0, 5) == "00018" && document.getElementById("RICOHFlag").value == "0") {
						document.getElementById("RICOHFlag").value = "1";
						document.getElementById("RicohNumTtl").style.display = "block";
						document.getElementById("RicohNum").style.display = "block";
						for (cnt = 1; cnt <= MaxDispLine; cnt++) {
							document.getElementById("RCodeLine" + cnt).style.display = "block";

							if (document.getElementById("ProductCode" + cnt).value != "") {
								estimateSystemRicohCodeSearch(cnt);
							}
						}
						// alert("リコーモードに切り替えます。");
					} else if (document.getElementById("CustomerCode").value.substring(0, 5) != "00018" && document.getElementById("RICOHFlag").value == "1") {
						document.getElementById("RICOHFlag").value = "0";
						document.getElementById("RicohNumTtl").style.display = "none";
						document.getElementById("RicohNum").style.display = "none";
						for (cnt = 1; cnt <= MaxDispLine; cnt++) {
							document.getElementById("RCode" + cnt).value = "";
							document.getElementById("RCodeLine" + cnt).style.display = "none";
						}
					}

					if (document.getElementById("FirstCustomerErrorFlag").value == "1") {
						for (cnt = 1; cnt <= MaxDispLine; cnt++) {
							if (document.getElementById("ProductCode"+cnt).value != "") {
								estimateSystemProductSearch(cnt);
							}
						}

						document.getElementById("FirstCustomerErrorFlag").value = "0";
					}

				} else {
					alert("顧客情報が見つかりません。");

					Process_flg = false;
				}
			}
		}
	}
}

// 詳細画面の担当者検索ajax
function estimateSystemSalesSearch(mode) {
	if (mode == "S") {
		SC = right("00000000" + document.getElementById("SalesPersonCode").value, 8);
		document.getElementById("SalesPersonCode").value = SC;
	} else {
		SC = right("00000000" + document.getElementById("AssistantCode").value, 8);
		document.getElementById("AssistantCode").value = SC;
	}

	if (SC.length == 8) {
		if (!Process_flg && http) {
			var url = "ES_SalesSearch.asp?SC=" + SC + "&SM=" + mode;
			http.open("GET", url, true);
			http.onreadystatechange = handleHttpResponseAdminESSalesSearch;
			Process_flg = true;
			http.send(null);
		}
	} else {
		alert("担当者コードを正しく入力してください。");
	}
}

// 結果代入用
function handleHttpResponseAdminESSalesSearch() {
	if (http.readyState == 4) {
		if (http.status == 200) {
			if (http.responseText.indexOf('invalid') == -1) {
				results = http.responseText.split("@");

				if (results[0] == "T") {
					// データが見つかった場合値を挿入
					if (results[2] == "S") {
						document.getElementById("SalesPersonName").value = results[1];
						document.getElementById("Tel").value = results[3];
						document.getElementById("Fax").value = results[4];
					} else {
						document.getElementById("AssistantName").value = results[1];
					}
				} else {
					alert("担当者情報が見つかりません。");
					if (results[2] == "S") {
						document.getElementById("SalesPersonName").value = "";
						document.getElementById("Tel").value = "";
						document.getElementById("Fax").value = "";
						document.getElementById("SalesPersonCode").focus();
					} else {
						document.getElementById("AssistantName").value = "";
						document.getElementById("AssistantCode").focus();
					}
				}
				Process_flg = false;
			}
		}
	}
}

// 詳細画面の商品情報検索ajax
function estimateSystemProductSearch(cnt) {
	PC = document.getElementById("ProductCode"+cnt).value.toUpperCase();
	PC = estimateSystemAlphaChange(PC);
	PC = trim(PC);
	AC = document.getElementById("CustomerCode").value;
	RF = document.getElementById("RICOHFlag").value;
	document.getElementById("ProductCode"+cnt).value  = PC;
	if (document.getElementById("OutletCheck"+cnt).checked) {
		OF = 1;
		alert("アウトレット品として見積します。");
	} else {
		OF = 0;
	}

	if (AC != "") {
		if (!Process_flg && http) {
			var url = "ES_ProductSearch.asp?PC=" + PC + "&LN=" + cnt + "&AC=" + AC + "&OF=" + OF + "&RF=" + RF;
			http.open("GET", url, false);
			http.onreadystatechange = handleHttpResponseAdminESProductSearch;
			Process_flg = true;
			http.send(null);
		}
	} else {
		alert("先に得意先コードを入力してください。");
		document.getElementById("FirstCustomerErrorFlag").value = "1";
	}
}

function estimateSystemProductSearchRICOH(cnt) {
	RC = document.getElementById("RCode"+cnt).value.toUpperCase();
	RC = estimateSystemAlphaChange(RC);
	RC = trim(RC);
	AC = document.getElementById("CustomerCode").value;
	RF = document.getElementById("RICOHFlag").value;
	document.getElementById("RCode"+cnt).value  = RC;

	// 既に品番が入っている場合は動作させない
	if (document.getElementById("ProductCode"+cnt).value == "") {
		if (document.getElementById("OutletCheck"+cnt).checked) {
			OF = 1;
			alert("アウトレット品として見積します。");
		} else {
			OF = 0;
		}

		if (AC != "") {
			if (!Process_flg && http) {
				var url = "ES_ProductSearch.asp?PC=" + RC + "&LN=" + cnt + "&AC=" + AC + "&OF=" + OF + "&RF=" + RF;
				http.open("GET", url, false);
				http.onreadystatechange = handleHttpResponseAdminESProductSearch;
				Process_flg = true;
				http.send(null);
			}
		} else {
			alert("先に得意先コードを入力してください。");
			document.getElementById("FirstCustomerErrorFlag").value = "1";
		}
	}
}

// リコーコードを検索
function estimateSystemRicohCodeSearch(cnt) {
	PC = document.getElementById("ProductCode"+cnt).value.toUpperCase();
	PC = estimateSystemAlphaChange(PC);
	PC = trim(PC);
	AC = document.getElementById("CustomerCode").value;
	RF = 1;
	OF = 0;

	if (AC != "") {
		if (!Process_flg && http) {
			var url = "ES_ProductSearch.asp?PC=" + PC + "&LN=" + cnt + "&AC=" + AC + "&OF=" + OF + "&RF=" + RF;
			http.open("GET", url, false);
			http.onreadystatechange = handleHttpResponseAdminESRicohCodeSearch;
			Process_flg = true;
			http.send(null);
		}
	} else {
		alert("先に得意先コードを入力してください。");
		document.getElementById("FirstCustomerErrorFlag").value = "1";
	}
}

// 結果代入用
function handleHttpResponseAdminESRicohCodeSearch() {
	if (http.readyState == 4) {
		if (http.status == 200) {
			if (http.responseText.indexOf('invalid') == -1) {
				results = http.responseText.split("@");

				if (results[0] == "T") {
					// データが見つかった場合値を挿入
					if (results[12] != "") {
						document.getElementById("RCode"+results[1]).value = results[12];
					} else {
						document.getElementById("RCode"+results[1]).value = "";
						alert("リコー品種コードが登録されていません。");
					}
				} else {
					document.getElementById("RCode"+results[1]).value = "";
				}
				Process_flg = false;
			}
		}
	}
}


// 2バイト文字変換
function estimateSystemAlphaChange(str) {
	var reStr = "";
	for (var i = 0; i < str.length; i++) {
		switch (str.substring(i,i+1)) {
			case "ー": reStr += "-"; break;
			case "－": reStr += "-"; break;
			case "―": reStr += "-"; break;
			case "ａ": reStr += "A"; break;
			case "ｂ": reStr += "B"; break;
			case "ｃ": reStr += "C"; break;
			case "ｄ": reStr += "D"; break;
			case "ｅ": reStr += "E"; break;
			case "ｆ": reStr += "F"; break;
			case "ｇ": reStr += "G"; break;
			case "ｈ": reStr += "H"; break;
			case "ｉ": reStr += "I"; break;
			case "ｊ": reStr += "J"; break;
			case "ｋ": reStr += "K"; break;
			case "ｌ": reStr += "L"; break;
			case "ｍ": reStr += "M"; break;
			case "ｎ": reStr += "N"; break;
			case "ｏ": reStr += "O"; break;
			case "ｐ": reStr += "P"; break;
			case "ｑ": reStr += "Q"; break;
			case "ｒ": reStr += "R"; break;
			case "ｓ": reStr += "S"; break;
			case "ｔ": reStr += "T"; break;
			case "ｕ": reStr += "U"; break;
			case "ｖ": reStr += "V"; break;
			case "ｗ": reStr += "W"; break;
			case "ｘ": reStr += "X"; break;
			case "ｙ": reStr += "Y"; break;
			case "ｚ": reStr += "Z"; break;
			case "Ａ": reStr += "A"; break;
			case "Ｂ": reStr += "B"; break;
			case "Ｃ": reStr += "C"; break;
			case "Ｄ": reStr += "D"; break;
			case "Ｅ": reStr += "E"; break;
			case "Ｆ": reStr += "F"; break;
			case "Ｇ": reStr += "G"; break;
			case "Ｈ": reStr += "H"; break;
			case "Ｉ": reStr += "I"; break;
			case "Ｊ": reStr += "J"; break;
			case "Ｋ": reStr += "K"; break;
			case "Ｌ": reStr += "L"; break;
			case "Ｍ": reStr += "M"; break;
			case "Ｎ": reStr += "N"; break;
			case "Ｏ": reStr += "O"; break;
			case "Ｐ": reStr += "P"; break;
			case "Ｑ": reStr += "Q"; break;
			case "Ｒ": reStr += "R"; break;
			case "Ｓ": reStr += "S"; break;
			case "Ｔ": reStr += "T"; break;
			case "Ｕ": reStr += "U"; break;
			case "Ｖ": reStr += "V"; break;
			case "Ｗ": reStr += "W"; break;
			case "Ｘ": reStr += "X"; break;
			case "Ｙ": reStr += "Y"; break;
			case "Ｚ": reStr += "Z"; break;
			case "０": reStr += "0"; break;
			case "１": reStr += "1"; break;
			case "２": reStr += "2"; break;
			case "３": reStr += "3"; break;
			case "４": reStr += "4"; break;
			case "５": reStr += "5"; break;
			case "６": reStr += "6"; break;
			case "７": reStr += "7"; break;
			case "８": reStr += "8"; break;
			case "９": reStr += "9"; break;
			default: reStr += str.substring(i,i+1); break;
		}
	}
	return reStr;
}

// 結果代入用
function handleHttpResponseAdminESProductSearch() {
	if (http.readyState == 4) {
		if (http.status == 200) {
			if (http.responseText.indexOf('invalid') == -1) {
				results = http.responseText.split("@");

				if (results[0] == "T") {
					// データが見つかった場合値を挿入
					document.getElementById("ProductName"+results[1]).value = results[2];
					document.getElementById("RegularPrice"+results[1]).value = results[3];
					document.getElementById("EigyouGenka"+results[1]).value = results[4];
					document.getElementById("NormalPrice"+results[1]).value = results[5];
					if (results[5] != 0) {
						document.getElementById("NormalRate"+results[1]).value = (results[5] / results[3] * 100).toFixed(1);
					} else {
						document.getElementById("NormalRate"+results[1]).value = 0;
					}
					if (results[6] == "1") {
						document.getElementById("OpenCheck"+results[1]).checked = true;
					} else {
						document.getElementById("OpenCheck"+results[1]).checked = false;
					}
					document.getElementById("InventoryArea"+results[1]).innerHTML = results[7];
					document.getElementById("InventoryLayer"+results[1]).innerHTML = results[8];
					document.getElementById("MarginRank"+results[1]).innerHTML = "";
					if (results[9] == "1") {
						document.getElementById("ProductName"+results[1]).style.color = "#F00";
					} else {
						document.getElementById("ProductName"+results[1]).style.color = "#000";
					}
					document.getElementById("Quantity"+results[1]).value = "";
					document.getElementById("UnitRate"+results[1]).value = "";
					document.getElementById("UnitPrice"+results[1]).value = "";
					document.getElementById("SubTotalPrice"+results[1]).value = "";
					document.getElementById("MarginPrice"+results[1]).value = "";
					document.getElementById("MarginTotal"+results[1]).value = "";
					document.getElementById("MarginRate"+results[1]).value = "";

					if (document.getElementById("RICOHFlag").value == "1") {
						if (results[12] != "") {
							document.getElementById("RCode"+results[1]).value = results[12];
						} else {
							document.getElementById("RCode"+results[1]).value = "";
							alert("リコー品種コードが登録されていません。");
						}
						document.getElementById("ProductCode"+results[1]).value = results[13];
					}

					if (results[14] != "") {
						alert("品番：" + results[13] + "\n" + results[14].replace(/↓↓/g,"\n"));
					}

					var NoticeHTML = "";
					var NoticeMemo = document.getElementById("Memo"+results[1]).value;
					if (results[15] != "") {
						alert("品番：" + results[13] + "\n" + results[15].replace(/↓↓/g,"\n"));
						document.getElementById("FeeFlag"+results[1]).value = 1;
						NoticeHTML = "★大物商品";

						if (NoticeMemo == "") {
							NoticeMemo = "大物商品です。";
						}
					} else {
						document.getElementById("FeeFlag"+results[1]).value = 0;
					}

					if (results[16] == "1") {
						alert("品番：" + results[13] + "\n" + "★車上渡し商品です。\n※車上渡しでのお届けの場合は、大物送料のみを見積・請求してください。\n※指定階数までのお届け希望の場合、NPW商品はNPWへ、竹久商品は竹久へ、物流商品は、谷、繁松まで見積もり依頼をして下さい。");
						document.getElementById("SuperBigFlag"+results[1]).value = "1";
						NoticeHTML = NoticeHTML + "★車上渡し商品";

						if (NoticeMemo == "" || NoticeMemo == "大物商品です。") {
							NoticeMemo = NoticeMemo + "車上渡し商品です。";
						}
					} else {
						document.getElementById("SuperBigFlag"+results[1]).value = "0";
					}

					document.getElementById("ProductNotice"+results[1]).innerHTML = NoticeHTML;
					document.getElementById("Memo"+results[1]).value = NoticeMemo;

					if (results[10] == "1") {
						alert("品番：" + results[13] + "\n" + "リミット単価が設定されている商品です。");
					}
					document.getElementById("LimitPrice"+results[1]).value = results[11];
				} else {
					document.getElementById("ProductName"+results[1]).value = "";
					document.getElementById("RegularPrice"+results[1]).value = "";
					document.getElementById("Quantity"+results[1]).value = "";
					document.getElementById("UnitRate"+results[1]).value = "";
					document.getElementById("UnitPrice"+results[1]).value = "";
					document.getElementById("SubTotalPrice"+results[1]).value = "";
					document.getElementById("DeliveryTime"+results[1]).value = "";
					document.getElementById("Memo"+results[1]).value = "";
					document.getElementById("MarginPrice"+results[1]).value = "";
					document.getElementById("MarginTotal"+results[1]).value = "";
					document.getElementById("MarginRate"+results[1]).value = "";
					document.getElementById("EigyouGenka"+results[1]).value = "";
					document.getElementById("NormalPrice"+results[1]).value = "";
					document.getElementById("NormalRate"+results[1]).value = "";
					document.getElementById("OpenCheck"+results[1]).checked = true;
					document.getElementById("InventoryArea"+results[1]).innerHTML = "";
					document.getElementById("InventoryLayer"+results[1]).innerHTML = "";
					document.getElementById("MarginRank"+results[1]).innerHTML = "";
					document.getElementById("ProductName"+results[1]).style.color = "#000";
					document.getElementById("LimitPrice"+results[1]).value = "";

					if (document.getElementById("RICOHFlag").value == "1") {
						document.getElementById("RCode"+results[1]).value = "";
					}

					document.getElementById("FeeFlag"+results[1]).value = 0;
					document.getElementById("SuperBigFlag"+results[1]).value = 0;
					document.getElementById("ProductNotice"+results[1]).innerHTML = "";

					if (document.getElementById("ProductCode"+results[1]).value != "") {
						alert("商品情報が見つかりません。\n品番の無い商品を入力の場合は、必ず定価を入力して下さい。");
					}
				}
				Process_flg = false;
				estimateSystemTotalCalc();
			}
		}
	}
}

// 詳細画面の商品情報リセット
function estimateSystemItemReset() {
	if (confirm("商品情報をクリアします。\nよろしいですか？")) {
		for (i = 1; i <= MaxDispLine; i++) {
			document.getElementById("DeleteCheck"+i).checked = false;
			document.getElementById("ProductCode"+i).value = "";
			document.getElementById("ProductName"+i).value = "";
			document.getElementById("RCode"+i).value = "";
			document.getElementById("RegularPrice"+i).value = "";
			document.getElementById("Quantity"+i).value = "";
			document.getElementById("UnitRate"+i).value = "";
			document.getElementById("UnitPrice"+i).value = "";
			document.getElementById("SubTotalPrice"+i).value = "";
			document.getElementById("DeliveryTime"+i).value = "";
			document.getElementById("Memo"+i).value = "";
			document.getElementById("MarginPrice"+i).value = "";
			document.getElementById("MarginTotal"+i).value = "";
			document.getElementById("MarginRate"+i).value = "";
			document.getElementById("EigyouGenka"+i).value = "";
			document.getElementById("NormalPrice"+i).value = "";
			document.getElementById("NormalRate"+i).value = "";
			document.getElementById("OpenCheck"+i).checked = false;
			document.getElementById("InventoryArea"+i).innerHTML = "";
			document.getElementById("InventoryLayer"+i).innerHTML = "";
			document.getElementById("MarginRank"+i).innerHTML = "";
			document.getElementById("LimitPrice"+i).value = "";
			document.getElementById("FeeFlag"+i).value = 0;
			document.getElementById("SuperBigFlag"+i).value = 0;
			document.getElementById("ProductNotice"+i).innerHTML = "";

			document.getElementById("RivalMaker"+i).value = "";
			document.getElementById("RivalSku"+i).value = "";
			document.getElementById("RivalPrice"+i).value = "";
			document.getElementById("RivalOther"+i).value = "";
			// document.getElementById("ConclusionStatusDetail"+i).value = "";
			document.getElementById("PurchaseComment"+i).value = "";
			document.getElementById("DevLeaderComment"+i).value = "";

			document.getElementById("LeaderPrice"+i).value = "";
			document.getElementById("LeaderRate"+i).value = "";
			document.getElementById("CorrectionPrice"+i).value = "";
			document.getElementById("CorrectionRate"+i).value = "";
			document.getElementById("AutoAnswerFlag"+i).value = "";
			document.getElementById("ImportantFlag"+i).value = "";
		}
		estimateSystemTotalCalc();
	}
}

// 仕切再提案
function estimateSystemItemReCalc(mode) {
	if (mode == "normal") {
		alert("現在の得意先CDで通常仕切を再提案します。");
		CCode = document.getElementById("CustomerCode").value;
		QueryText = "";

		if (CCode == "") {
			alert("得意先コードが入力されていません。");
		} else {
			for (i=1; i <= MaxDispLine; i++) {
				if (document.getElementById("ProductCode"+i).value != "") {
					QueryText += "@-@" + i + "@*@" + document.getElementById("ProductCode"+i).value;
				}
			}
			if (QueryText != "") {
				QueryText = CCode + QueryText;

				if (!Process_flg && http) {
					var url = "ES_ProductSearchAll.asp?QT=" + QueryText;
					http.open("GET", url, false);
					http.onreadystatechange = handleHttpResponseAdminESProductSearchAll;
					Process_flg = true;
					http.send(null);
				}
			}
		}
	} else if(mode == "genka") {
		alert("現在の営業原価を再提案します。");
		QueryText = "";

		for (i=1; i <= MaxDispLine; i++) {
			if (document.getElementById("ProductCode"+i).value != "") {
				QueryText += "@-@" + document.getElementById("ProductCode"+i).value + "@*@" + i + "@\\@" + document.getElementById("OutletCheck"+i).checked;
			}
		}
		if (QueryText != "") {
			if (!Process_flg && http) {
				var url = "ES_ProductSearchEGanka.asp?QT=" + QueryText;
				http.open("GET", url, false);
				http.onreadystatechange = handleHttpResponseAdminESProductSearchEGenka;
				Process_flg = true;
				http.send(null);
			}
		}
	}
}

// 仕切一括投入
function estimateSystemItemRateAllIn() {
	rate = window.prompt("一括で指定する仕切率を入力してください。", "");

	// 数字を入れた場合のみ処理
	if (isNaN(rate) == false) {
		if (rate > 0 && rate <= 100) {
			for (ccnt=1; ccnt <= MaxDispLine; ccnt++) {
				if (document.getElementById("ProductCode"+ccnt).value != "" && document.getElementById("RegularPrice"+ccnt).value != "") {
					document.getElementById("UnitRate"+ccnt).value = rate;
					estimateSystemUnitPercent(ccnt, '率');
				}
			}
		} else {
		alert("1～100以内で入力してください。");
		}
	} else {
		alert("半角数字で入力してください。");
	}
}

// 仕切数量投入
function estimateSystemItemAmountAllIn() {
	amount = window.prompt("一括で指定する数量を入力してください。", "");

	// 数字を入れた場合のみ処理
	if (isNaN(amount) == false) {
		if (amount > 0) {
			for (ccnt=1; ccnt <= MaxDispLine; ccnt++) {
				if (document.getElementById("ProductCode"+ccnt).value != "") {
					document.getElementById("Quantity"+ccnt).value = amount;
					estimateSystemSubCalc(ccnt);
				}
			}
		} else {
			alert("1～で入力してください。");
		}
	} else {
		alert("半角数字で入力してください。");
	}
}

// 通常仕切りコピー
function estimateSystemItemPriceCopy() {
	for (ncnt=1; ncnt <= MaxDispLine; ncnt++) {
		if (document.getElementById("NormalPrice"+ncnt).value != "" && document.getElementById("ProductCode"+ncnt).value != "") {
			document.getElementById("UnitPrice"+ncnt).value = document.getElementById("NormalPrice"+ncnt).value;
			estimateSystemUnitPercent(ncnt, '価格');
		}
	}
}

// 通常仕切率計算
function estimateSystemItemRateCalc() {
	CalcPer = window.prompt("加減する仕切率を半角数字で入力してください。%は不要です。", "");

	if (CalcPer != "" && CalcPer != null && isNaN(CalcPer) == false) {

		for (ncnt=1; ncnt <= MaxDispLine; ncnt++) {
			if (document.getElementById("UnitRate"+ncnt).value != "" && document.getElementById("ProductCode"+ncnt).value != "") {
				document.getElementById("UnitRate"+ncnt).value = parseFloat(document.getElementById("UnitRate"+ncnt).value) + parseFloat(CalcPer);
				estimateSystemUnitPercent(ncnt, '率');
			}
		}
	}
}

// 品番一括投入
function estimateSystemItemAllIn() {
    //window.open("./product_in.asp", "product_in", "width=420, height=400, menubar=no, toolbar=no, scrollbars=yes");
    var url = "../PopProductIn/PopProductIn.aspx";
    $.showModalDialog(url, 420, 450, "商品一括入力画面");
}

// 品番一括投入・・・入力ボタン
function estimateSystemItemAllInBtn() {
	inValue = document.getElementById("ProductList").value.split(/\r\n|\r|\n/);
	inCnt = 0;

	for(i = 0; i < inValue.length; i++) {
		// if(inValue[i].replace(/(^[\s　]+)|([\s　]+$)/g, "") != "") {
		if (trim(inValue[i]) != "") {
			if (inCnt <= MaxDispLine) {
				inCnt++;
				amtVal = "";

				// 数量をタブ区切りで入力していた場合のみ処理
				if (inValue[i].indexOf("\t") != -1) {
					inArrVal = inValue[i].split("\t");

					if (inArrVal[1] != "" && !isNaN(inArrVal[1])) {
						inValue[i] = inArrVal[0];

						// 数量を挿入
						amtVal = inArrVal[1];
					} else {
						inValue[i] = inArrVal[0];
					}
				}

				window.opener.document.getElementById("ProductCode" + inCnt).value = inValue[i];
				window.opener.estimateSystemProductSearch(inCnt);

				if (amtVal != "") {
					window.opener.document.getElementById("Quantity" + inCnt).value = amtVal;
				}
			}
		}
	}

	var NowDispMax = window.opener.document.getElementById("NowDispMax").value;
	if (inCnt * 1 > 0 && inCnt * 1 > NowDispMax * 1) {
		window.opener.document.getElementById("NowDispMax").value = inCnt;
		for (cnt = NowDispMax * 1 + 1; cnt <= inCnt; cnt++) {
			window.opener.document.getElementById("Column_" + cnt).setAttribute('class', '');
		}
	}

	if (inCnt != 0) {
		window.close();
	}
}

// 結果代入用 ・・・ 仕切り再提案
function handleHttpResponseAdminESProductSearchAll() {
	if (http.readyState == 4) {
		if (http.status == 200) {
			if (http.responseText.indexOf('invalid') == -1) {
				results = http.responseText.split("@");

				if (results[0] == "T") {
					for (i=1; i<results.length-2; i+=3) {
						// SubPrice = document.getElementById("RegularPrice"+results[i]).value;

						// データが見つかった場合値を挿入
						document.getElementById("NormalPrice"+results[i]).value = results[i+1];
						document.getElementById("RegularPrice"+results[i]).value = results[i+2];
						SubPrice = results[i+2];
						if (results[i+1] != 0) {
							document.getElementById("NormalRate"+results[i]).value = (results[i+1] / SubPrice * 100).toFixed(1);
						} else {
							document.getElementById("NormalRate"+results[i]).value = 0;
						}
					}

					alert("通常仕切が再提案されました。");
				} else {
					alert("不正なデータがある為、再提案できません。");
				}

				Process_flg = false;
			}
		}
	}
}

// 結果代入用 ・・・ 営業原価再提案
function handleHttpResponseAdminESProductSearchEGenka() {
	if (http.readyState == 4) {
		if (http.status == 200) {
			if (http.responseText.indexOf('invalid') == -1) {
				results = http.responseText.split("@");

				if (results[0] == "T") {
					for (i=1; i<results.length; i+=2) {
						// データが見つかった場合値を挿入
						document.getElementById("EigyouGenka"+results[i]).value = results[i+1];
						estimateSystemSubCalc2(results[i]);
					}

					estimateSystemTotalCalc();

					alert("営業原価が再提案されました。");
				} else {
					alert("不正なデータがある為、再提案できません。");
				}

				Process_flg = false;
			}
		}
	}
}

// 在庫情報表示
function estimateSystemInventoryLayer(LN) {
	document.getElementById("InventoryLayer"+LN).style.display = "block";
}

// 在庫情報非表示
function estimateSystemInventoryLayerClose(LN) {
	document.getElementById("InventoryLayer"+LN).style.display = "none";
}

// 仕切率計算
function estimateSystemUnitPercent(LN, mode) {
	if (mode == "率") {
		if (document.getElementById("RegularPrice"+LN).value != "") {
			UR = document.getElementById("UnitRate"+LN).value;
			RP = document.getElementById("RegularPrice"+LN).value;
			document.getElementById("UnitPrice"+LN).value = (UR * RP / 100).toFixed(0);
			estimateSystemSubCalc(LN);
		} else {
			alert("商品を選択してください。");
			document.getElementById("UnitRate"+LN).value = "";
		}
	} else {
		if (document.getElementById("RegularPrice"+LN).value != "") {
			UP = document.getElementById("UnitPrice"+LN).value;
			RP = document.getElementById("RegularPrice"+LN).value;
			document.getElementById("UnitRate"+LN).value = (UP / RP * 100).toFixed(1);
			estimateSystemSubCalc(LN);
		} else {
			alert("商品を選択してください。");
			document.getElementById("UnitPrice"+LN).value = "";
		}
	}
}

// 行クリア
function estimateSystemLineDelete(LN) {
	document.getElementById("DeleteCheck"+LN).checked = false;
	document.getElementById("ProductCode"+LN).value = "";
	document.getElementById("ProductName"+LN).value = "";
	document.getElementById("RegularPrice"+LN).value = "";
	document.getElementById("Quantity"+LN).value = "";
	document.getElementById("UnitRate"+LN).value = "";
	document.getElementById("UnitPrice"+LN).value = "";
	document.getElementById("SubTotalPrice"+LN).value = "";
	document.getElementById("DeliveryTime"+LN).value = "";
	document.getElementById("Memo"+LN).value = "";
	document.getElementById("MarginPrice"+LN).value = "";
	document.getElementById("MarginTotal"+LN).value = "";
	document.getElementById("MarginRate"+LN).value = "";
	document.getElementById("EigyouGenka"+LN).value = "";
	document.getElementById("NormalPrice"+LN).value = "";
	document.getElementById("NormalRate"+LN).value = "";
	document.getElementById("OpenCheck"+LN).checked = false;
	document.getElementById("InventoryArea"+LN).innerHTML = "";
	document.getElementById("InventoryLayer"+LN).innerHTML = "";
	document.getElementById("MarginRank"+LN).innerHTML = "";
	document.getElementById("LimitPrice"+LN).value = "";
	document.getElementById("FeeFlag"+LN).value = 0;
	document.getElementById("SuperBigFlag"+LN).value = 0;
	document.getElementById("ProductNotice"+LN).innerHTML = "";

	document.getElementById("RivalMaker"+LN).value = "";
	document.getElementById("RivalSku"+LN).value = "";
	document.getElementById("RivalPrice"+LN).value = "";
	document.getElementById("RivalOther"+LN).value = "";
	// document.getElementById("ConclusionStatusDetail"+LN).value = "";
	document.getElementById("PurchaseComment"+LN).value = "";
	document.getElementById("DevLeaderComment"+LN).value = "";

	document.getElementById("LeaderPrice"+LN).value = "";
	document.getElementById("LeaderRate"+LN).value = "";
	document.getElementById("CorrectionPrice"+LN).value = "";
	document.getElementById("CorrectionRate"+LN).value = "";
	document.getElementById("AutoAnswerFlag"+LN).value = "";
	document.getElementById("ImportantFlag"+LN).value = "";

	document.getElementById("RCode"+LN).value = "";

	estimateSystemTotalCalc();
}

// 行削除チェック
function estimateSystemLineDeleteChk(LN) {
	if (document.getElementById("DeleteCheck" + LN).checked) {
		document.getElementById("Column_" + LN).classList.add("tr_delete");
	} else {
		document.getElementById("Column_" + LN).classList.remove("tr_delete");
	}
}

// 価格計算
function estimateSystemSubCalc(LN) {
	QT = document.getElementById("Quantity"+LN).value;
	UP = document.getElementById("UnitPrice"+LN).value;
	if (document.getElementById("EigyouGenka"+LN).value != "") {
		EG = document.getElementById("EigyouGenka"+LN).value;
	} else {
		document.getElementById("EigyouGenka"+LN).value = 0;
		EG = 0;
	}

	if (QT != "" && UP != "" && EG != "") {
		document.getElementById("SubTotalPrice"+LN).value = parseInt(QT * UP);
		document.getElementById("MarginPrice"+LN).value = parseInt(UP - EG);
		document.getElementById("MarginTotal"+LN).value = parseInt(QT * (UP - EG));

		if (UP != 0) {
			MR = (UP - EG) / UP * 100;
		} else {
			MR = 0;
		}
		document.getElementById("MarginRate"+LN).value = MR.toFixed(1);

		if (MR >= 31) {
			document.getElementById("MarginRank"+LN).innerHTML = "A";
		} else if (MR >= 25) {
			document.getElementById("MarginRank"+LN).innerHTML = "B";
		} else if (MR >= 18) {
			document.getElementById("MarginRank"+LN).innerHTML = "C";
		} else {
			document.getElementById("MarginRank"+LN).innerHTML = "X";
		}
		estimateSystemTotalCalc();
	}

	if (parseInt(UP) < parseInt(EG)) {
		alert("営業原価以下の仕切価格です。");
		document.getElementById("ProductCode"+LN).style.color = "#F00";
	} else {
		document.getElementById("ProductCode"+LN).style.color = "#000";
	}
}

// 価格計算 (数量変更用)
function estimateSystemSubCalcQt(LN) {
	QT = document.getElementById("Quantity"+LN).value;
	UP = document.getElementById("UnitPrice"+LN).value;
	if (document.getElementById("EigyouGenka"+LN).value != "") {
		EG = document.getElementById("EigyouGenka"+LN).value;
	} else {
		document.getElementById("EigyouGenka"+LN).value = 0;
		EG = 0;
	}

	if (QT != "" && UP != "" && EG != "") {
		document.getElementById("SubTotalPrice"+LN).value = parseInt(QT * UP);
		document.getElementById("MarginPrice"+LN).value = parseInt(UP - EG);
		document.getElementById("MarginTotal"+LN).value = parseInt(QT * (UP - EG));

		if (UP != 0) {
			MR = (UP - EG) / UP * 100;
		} else {
			MR = 0;
		}
		document.getElementById("MarginRate"+LN).value = MR.toFixed(1);

		if (MR >= 31) {
			document.getElementById("MarginRank"+LN).innerHTML = "A";
		} else if (MR >= 25) {
			document.getElementById("MarginRank"+LN).innerHTML = "B";
		} else if (MR >= 18) {
			document.getElementById("MarginRank"+LN).innerHTML = "C";
		} else {
			document.getElementById("MarginRank"+LN).innerHTML = "X";
		}
		estimateSystemTotalCalc();
	}
}

// トータル処理なしの個別のみ価格処理(営業原価再提案用)
function estimateSystemSubCalc2(LN) {
	QT = document.getElementById("Quantity"+LN).value;
	UP = document.getElementById("UnitPrice"+LN).value;
	if (document.getElementById("EigyouGenka"+LN).value != "") {
		EG = document.getElementById("EigyouGenka"+LN).value;
	} else {
		document.getElementById("EigyouGenka"+LN).value = 0;
		EG = 0;
	}

	if (QT != "" && UP != "" && EG != "") {
		document.getElementById("SubTotalPrice"+LN).value = parseInt(QT * UP);
		document.getElementById("MarginPrice"+LN).value = parseInt(UP - EG);
		document.getElementById("MarginTotal"+LN).value = parseInt(QT * (UP - EG));

		if (UP != 0) {
			MR = (UP - EG) / UP * 100;
		} else {
			MR = 0;
		}
		document.getElementById("MarginRate"+LN).value = MR.toFixed(1);

		if (MR >= 31) {
			document.getElementById("MarginRank"+LN).innerHTML = "A";
		} else if (MR >= 25) {
			document.getElementById("MarginRank"+LN).innerHTML = "B";
		} else if (MR >= 18) {
			document.getElementById("MarginRank"+LN).innerHTML = "C";
		} else {
			document.getElementById("MarginRank"+LN).innerHTML = "X";
		}
	}

	if (parseInt(UP) < parseInt(EG)) {
		alert("営業原価以下の仕切価格です。");
		document.getElementById("ProductCode"+LN).style.color = "#F00";
	} else {
		document.getElementById("ProductCode"+LN).style.color = "#000";
	}
}

// 価格総計算
function estimateSystemTotalCalc() {
	TP = 0;
	TM = 0;
	TR = 0;
	TQ = 0;
	TF = 0;
	for (i=1; i<=MaxDispLine; i++) {
		if (document.getElementById("SubTotalPrice"+i).value > 0) {
			if (!document.getElementById("DeleteCheck"+i).checked) {
				TP += parseInt(document.getElementById("SubTotalPrice"+i).value);
				TM += parseInt(document.getElementById("MarginTotal"+i).value);
				TR += parseFloat(document.getElementById("MarginRate"+i).value);
				TQ += parseFloat(document.getElementById("Quantity"+i).value);

				if (document.getElementById("FeeFlag"+i).value == "1") {
					TF += parseFloat(document.getElementById("Quantity"+i).value);
				}
			}
		}
	}
	if (TP != 0) {
		TR = (TM / TP * 100).toFixed(1);
	}

	document.getElementById("TotalPrice").value = TP;
	document.getElementById("UnderTotalPrice").value = TP;
	document.getElementById("MarginTotalTotal").value = TM;
	document.getElementById("MarginRateTotal").value = TR;
	document.getElementById("TotalQuantity").value = TQ;
	document.getElementById("TotalFee").value = TF;

	if (TR >= 31) {
		document.getElementById("MarginRankTotal").innerHTML = "A";
	} else if (TR >= 25) {
		document.getElementById("MarginRankTotal").innerHTML = "B";
	} else if (TR >= 18) {
		document.getElementById("MarginRankTotal").innerHTML = "C";
	} else {
		document.getElementById("MarginRankTotal").innerHTML = "X";
	}
}

// 日付クリア
function estimateSystemDispDateClear(cnum) {
	document.getElementById("DatePickBox"+cnum).value = "";
}

// 詳細発行ボタン
function estimateSystemDetailIssue(mode) {
	if (mode == "bill") {
		document.getElementById("SubmitMode").value = "bill";
	} else {
		document.getElementById("SubmitMode").value = "issue";
	}
	document.ESDetailForm.target = "_blank";
	document.ESDetailForm.submit();
}

// コピー
function estimateSystemDetailCopy(CNo) {
	if (document.getElementById("ProjectFlag").checked) {
		alert("仕入からの回答もコピーされます。\n再回答が必要な場合は下記手順を実行してください。\n1:コピーしたものを一度仮登録\n2:再回答依頼にチェックを入れた上で再度保存\n※2を実行する際に案件メールを送信するのチェック漏れに気をつけてください");
	}

	location.href = "./detail.asp?mode=copy&cno=" + CNo;
}

// CSVダウンロードボタン
function estimateSystemDetailCSVDL() {
	CN = document.getElementById("CheckNum").value;
	window.open("./csv_download.asp?mode=detail&cn=" + CN,"","");
}

// 詳細保存ボタン
function estimateSystemDetailSave(contin, fixflag, chk3ch) {
	retValue = false;

	// エラー判定
	if (estimateSystemDetailErrChk() == true) {
		// 案件管理中の納期必須
		if (document.getElementById("ProjectFlag").checked) {
			DL = document.getElementById("DatePickBox3").value;

			if (DL == "") {
				alert("案件管理する場合は納期が必須です。\n未定の場合はある程度の納期を入力の上\nその旨をメモに記載してください。");
				return false;
			}

			var nowDate = new Date();
			var nowYYYY = nowDate.getFullYear();
			var nowMM = right("00" + (nowDate.getMonth() + 1), 2);
			var nowDD = right("00" + nowDate.getDate(), 2);
			var Now = nowYYYY + "/" + nowMM + "/" + nowDD;

			if (DL <= Now) {
				alert("納期は明日以降を指定してください。");
				return false;
			}
		}

		// 商品の大物送料をチェックする
		alertFlg = 0;
		for (i = 1; i <= MaxDispLine; i++) {
			if (document.getElementById("FeeFlag" + i).value == "1") {
				alertFlg = 1;
			}
		}

		if (alertFlg == 1) {
			if (!confirm("送料が別途かかる大物商品が含まれています。\n送料の配送費の確認は行いましたか？")) {
				return false;
			}
		}

		if (fixflag == "本" && chk3ch == "1") {
			if (document.getElementById("DispFlag0").checked) {
				if (!confirm("サンワCh非表示ですがよろしいですか？")) {
					return false;
				}
			}
		}

		if (contin == "継") {
			// 本登録からの継続
			if (confirm("本登録見積の為、\n内容を引き継いで別見積番号を発行して保存します。\nよろしいですか？")) {
				retValue = true;
				if (fixflag == "本") {
					if (confirm("本登録の為修正できませんが\nよろしいですか？")) {
						document.getElementById("SubmitFixFlag").value = 1;
					} else {
						retValue = false;
					}
				} else {
					document.getElementById("SubmitFixFlag").value = 0;
				}
			}
		} else {
			// 仮登録or新規
			retValue = true;
			if (fixflag == "本") {
				if (confirm("本登録の為修正できませんが\nよろしいですか？")) {
					document.getElementById("SubmitFixFlag").value = 1;
				} else {
					retValue = false;
				}
			} else {
				document.getElementById("SubmitFixFlag").value = 0;
			}
		}

		if (retValue == true) {
			if (document.getElementById("ProjectFlag").checked == false) {
				if (document.getElementById("ConclusionMailFlag")) {
					if (document.getElementById("ConclusionMailFlag").checked) {
						if (confirm("案件管理していないのでメールは送信されません。\nこのまま保存しますか？") == false) {
							return false;
						}
					}
				}

				if (document.getElementById("ProjectMailFlag")) {
					if (document.getElementById("ProjectMailFlag").checked) {
						if (confirm("案件管理していないのでメールは送信されません。\nこのまま保存しますか？") == false) {
							return false;
						}
					}
				}
			}

			document.getElementById("SubmitMode").value = "save";
			document.ESDetailForm.target = "_self";
			document.ESDetailForm.submit();
		}
	}
}

// エラーチェック
function estimateSystemDetailErrChk() {
	errFlag = 0;

	// フォームの値を取得
	CC = document.getElementById("CustomerCode").value;
	CN = document.getElementById("CustomerName").value;
	CD = document.getElementById("CustomerDivision").value;
	CPN = document.getElementById("CustomerPersonName").value;
	SC = document.getElementById("SalesPersonCode").value;
	SN = document.getElementById("SalesPersonName").value;
	AC = document.getElementById("AssistantCode").value;
	AN = document.getElementById("AssistantName").value;
	TP = document.getElementById("TotalPrice").value;
	TQ = document.getElementById("TotalQuantity").value;

	// まず必須項目のチェック
	if (CC == "") {
		alert("得意先コードを入力してください。");
		errFlag = 1;
		return false;
	}

	if (CN == "") {
		alert("得意先名を入力してください。");
		errFlag = 1;
		return false;
	}

	if (SC == "" || SN == "" || AC == "" || AN == "") {
		alert("得意先を選択してください。");
		errFlag = 1;
		return false;
	}

	if (TP == "" || TP == 0) {
		alert("0円での見積はできません。");
		errFlag = 1;
		return false;
	}

	if (TQ == "" || TQ == 0) {
		alert("数量が不正です。");
		errFlag = 1;
		return false;
	}

	if (errFlag == 0) {
		return true;
	}
}

// 詳細のテストモード切替
function estimateSystemDetailTestDisp() {
	document.getElementById("SubmitMode").value = "test";
	document.ESDetailForm.target = "_self";
	document.ESDetailForm.submit();
}

// 依頼一覧削除ボタン
function estimateSystemRListDelete(rno) {
	if (confirm("「"+rno+"」を削除します。\nよろしいですか？")) {
		document.getElementById("SubmitMode").value = "delete";
		document.getElementById("SubmitValue").value = rno;
		document.ESRListForm.submit();
	}
}

// 依頼一覧取込ボタン
function estimateSystemRListLoad(rno) {
	location.href = "./detail.asp?RN=" + rno;
}

// 担当者→件名へ移動
function estimateSystemCursorPersonNext(e) {
	if (e == 9) {
		document.getElementById("Fax").focus();
	}
}

// 詳細のカーソル移動
function estimateSystemCursorAdvance(mode ,LineNo) {
	if (mode == "sub") {
		document.getElementById("DeliveryTime"+LineNo).focus();
	} else if(mode == "normal") {
		document.getElementById("UnitRate"+LineNo).focus();
	} else if(mode == "quantity") {
		document.getElementById("Quantity"+LineNo).focus();
	} else {
		if (LineNo != MaxDispLine) {
			LineNo++;
		} else {
			LineNo = 1;
		}
		document.getElementById("ProductCode"+LineNo).focus();
	}
}

// 詳細のカーソル移動(色つき)
function estimateSystemCursorColorActive(id) {
	document.getElementById(id).style.background = "#CEF";
}

function estimateSystemCursorColorDisable(id) {
	document.getElementById(id).style.background = "#FFF";
}

// 詳細の税込チェック
function estimateSystemTaxCheck(type) {
	if (type == "all") {
		if (document.getElementById("TaxDispFlag").checked) {
			document.getElementById("TaxDispFlag2").checked = false;
			alert("出荷予定日を確認して税率に注意してください。");
		}
	} else {
		if (document.getElementById("TaxDispFlag2").checked) {
			document.getElementById("TaxDispFlag").checked = false;
			alert("出荷予定日を確認して税率に注意してください。");
		}
	}
}

// 詳細の得意先検索ボタン
function estimateSystemCustomerListOpen() {
	//window.open("./customer_search.asp","customer_search","width=820, height=800, menubar=no, toolbar=no, scrollbars=yes");
    var url = "../PopCustomerSearch/PopCustomerSearch.aspx";
    $.showModalDialog(url, 820, 800, "得意先検索画面");

}

// 得意先検索からの選択ボタン
function estimateSystemCustomerChoice(ccode) {
	window.opener.document.getElementById("CustomerCode").value = ccode;
	window.opener.estimateSystemCustomerSearch();
	window.close();
}

// アウトレットフラグのチェック
function estimateSystemOutletChack(line) {
	// 品番が入っている場合のみ処理
	if (document.getElementById("ProductCode" + line).value != "") {
		estimateSystemProductSearch(line);
	}
}

// 詳細画面の成約状況ボタン
function estimateSystemDetailConclusionSave(status) {
	if (confirm("成約状況を 「" + status + "」 にします。\n成約状況のみ保存されます。\nよろしいですか？")) {
		document.getElementById("SubmitMode").value = "conclusion";
		document.getElementById("ConclusionStatus").value = status;
		document.ESDetailForm.target = "_self";
		document.ESDetailForm.submit();
	}
}

// 詳細画面のメモ保存ボタン
function estimateSystemDetailMemoSave() {
	document.getElementById("SubmitMode").value = "memo";
	document.ESDetailForm.target = "_self";
	document.ESDetailForm.submit();
}

// 詳細画面の継続案件保存ボタン
function estimateSystemDetailContSave() {
	document.getElementById("SubmitMode").value = "continuation";
	document.ESDetailForm.target = "_self";
	document.ESDetailForm.submit();
}

// 詳細画面のグループ管理ボタン
function estimateSystemGroupWindow() {
	CNO = document.getElementById("CheckNum").value;
	GNO = document.getElementById("GroupNo").value;
	window.open ("./group_window.asp?mode=detail&cno="+CNO+"&gno="+GNO,"group_window","width=780, height=700, menubar=no, toolbar=no, scrollbars=yes");
}

// 一覧画面のグループ管理ボタン
function estimateSystemListGroupWindow(gno) {
    //window.open("./group_window.asp?mode=list&gno=" + gno, "group_window", "width=780, height=700, menubar=no, toolbar=no, scrollbars=yes");
    var url = "./Pages/PopGroup/PopGroup.aspx?gno=gno";
    $.showModalDialog(url, 780, 700, "グループ管理画面");
}

// 詳細画面の納期一括コピーボタン
function estimateSystemDetailNoukiCopy() {
	copyMemo = document.getElementById("DeliveryTime1").value;
	if (copyMemo != "") {
		for(i = 2; i <= MaxDispLine; i++) {
			if (document.getElementById("ProductCode" + i).value != "") {
				document.getElementById("DeliveryTime" + i).value = copyMemo;
			}
		}
	} else {
		alert("1行目の納期を入力してください。");
	}
}

// 詳細画面の不成約理由コピーボタン
function estimateSystemDetailNotCompletedReasonCopy() {
	var chkReason1 = 0;
	var chkReason2 = 0;
	var chkReason3 = 0;
	var chkReason4 = 0;
	var chkReason5 = 0;
	var chkReason6 = 0;
	var chkReason7 = 0;
	var chkReason9 = 0;

	if (document.getElementById("NotCompletedReason1_1").checked) chkReason1 = 1;
	if (document.getElementById("NotCompletedReason2_1").checked) chkReason2 = 1;
	if (document.getElementById("NotCompletedReason3_1").checked) chkReason3 = 1;
	if (document.getElementById("NotCompletedReason4_1").checked) chkReason4 = 1;
	if (document.getElementById("NotCompletedReason5_1").checked) chkReason5 = 1;
	if (document.getElementById("NotCompletedReason6_1").checked) chkReason6 = 1;
	if (document.getElementById("NotCompletedReason7_1").checked) chkReason7 = 1;
	if (document.getElementById("NotCompletedReason9_1").checked) chkReason9 = 1;

	if (chkReason1 + chkReason2 + chkReason3 + chkReason4 + chkReason5 + chkReason6 + chkReason9 == 0) {
		alert("1行目の不成約理由を入力してください。");
	} else {
		for(i = 2; i <= MaxDispLine; i++) {
			if (document.getElementById("ProductCode" + i).value != "") {
				if (chkReason1 == 0) {document.getElementById("NotCompletedReason1_" + i).checked = false;} else {document.getElementById("NotCompletedReason1_" + i).checked = true;}
				if (chkReason2 == 0) {document.getElementById("NotCompletedReason2_" + i).checked = false;} else {document.getElementById("NotCompletedReason2_" + i).checked = true;}
				if (chkReason3 == 0) {document.getElementById("NotCompletedReason3_" + i).checked = false;} else {document.getElementById("NotCompletedReason3_" + i).checked = true;}
				if (chkReason4 == 0) {document.getElementById("NotCompletedReason4_" + i).checked = false;} else {document.getElementById("NotCompletedReason4_" + i).checked = true;}
				if (chkReason5 == 0) {document.getElementById("NotCompletedReason5_" + i).checked = false;} else {document.getElementById("NotCompletedReason5_" + i).checked = true;}
				if (chkReason6 == 0) {document.getElementById("NotCompletedReason6_" + i).checked = false;} else {document.getElementById("NotCompletedReason6_" + i).checked = true;}
				if (chkReason7 == 0) {document.getElementById("NotCompletedReason7_" + i).checked = false;} else {document.getElementById("NotCompletedReason7_" + i).checked = true;}
				if (chkReason9 == 0) {document.getElementById("NotCompletedReason9_" + i).checked = false;} else {document.getElementById("NotCompletedReason9_" + i).checked = true;}
			}
		}
	}
}

// 詳細画面の再回答依頼チェック
function estimateSystemDetailReAnswerCheck() {
	if (document.getElementById("ReAnswerFlag").checked) {
		alert("仕入からの納期回答をクリアします。\n自動回答もクリアされます。\n※保存するまでクリアされません。");
	}
}

// 詳細画面の消費税以前移動のエラー
function estimateSystemDetailTaxChange(defaultTax) {
	if (parseInt(document.getElementById("TaxPercent").value) < parseInt(defaultTax)) {
		alert("以前の税率は選択できません。");
		document.getElementById("TaxPercent").value = defaultTax;
	}
}

// 配送費の定型文設定
function estimateSystemDetailPackingFareForm(mode) {
	if (mode == 1) {
		document.getElementById("PackingFare").value = "弊社負担(時間指定・離島は除く)";
	} else {
		document.getElementById("PackingFare").value = "一括一箇所納品の場合のみ弊社負担";
	}
}

// 3chログインID連携のウィンドウ
function estimateSystemDetail3chIDSearch() {
	CCode = document.getElementById("CustomerCode").value;
	if (CCode == "") {
		alert("得意先コードが入力されていません。");
	} else {
		SCID = document.getElementById("SanwaChLoginID").value;
        //window.open("./sanwach_search.asp?AC=" + CCode + "&LI=" + SCID, "sanwach_search", "width=630, height=500, menubar=no, toolbar=no, scrollbars=yes");
        var url = "../PopSanwachSearch/PopSanwachSearch.aspx";
        $.showModalDialog(url, 630, 550, "ログインID選択画面");
	}
}

// 3chログインID連携のウィンドウ:解除
function estimateSystemDetail3chIDClear() {
	window.opener.document.getElementById("SanwaChLoginID").value = "";
	window.opener.document.getElementById("SCID").innerHTML = "連携なし";
	window.close();
}

// 3chログインID連携のウィンドウ:選択
function estimateSystemDetail3chIDSelect(LoginId) {
	window.opener.document.getElementById("SanwaChLoginID").value = LoginId;
	window.opener.document.getElementById("SCID").innerHTML = LoginId;
	window.close();
}

// 詳細の連番判定
function estimateSystemDetailColumnNoChk(line) {
	lineVal = document.getElementById("ColumnNo" + line).value;

	if (lineVal == "" || isNaN(lineVal)) {
		alert("未入力または数値ではありません。");
		ESDCNCTime = setTimeout("estimateSystemDetailColumnNoChkFcs('ColumnNo" + line + "')",10);	// firefox対応でフォーカスを別処理に
	} else {
		for (i=1; i<=MaxDispLine; i++) {
			// 現在の行以外をチェック
			if (i != line) {
				if (lineVal == document.getElementById("ColumnNo" + i).value) {
					alert("他の行と重複しています。");
					ESDCNCTime = setTimeout("estimateSystemDetailColumnNoChkFcs('ColumnNo" + line + "')",10);	// firefox対応でフォーカスを別処理に
					return false;
				}
			}
		}
	}
}

// 詳細の連番判定のフォーカスあて
function estimateSystemDetailColumnNoChkFcs(id) {
	clearTimeout(ESDCNCTime);
	document.getElementById(id).focus();
}

// 検索ページの本日ボタン
function estimateSystemListTodayBtn() {
    var now = new Date();
    var m = '0' + String(now.getMonth() + 1);
    var d = '0' + String(now.getDate());
    now = now.getFullYear() + '/' + m.slice(-2) + '/' + d.slice(-2);

	document.getElementById("DatePickBox1").value = now;
    document.getElementById("DatePickBox2").value = now;
}

// コメントテンプレートの保存ボタン
function estimateSystemTemplateCommentSave(seq) {
	document.getElementById("SaveNo").value = seq;
	document.comment_template.submit();
}

// コメントテンプレートの反映ボタン
function estimateSystemTemplateCommentRef(seq) {
	window.opener.document.getElementById("Other").value += document.getElementById("template" + seq).value;
	window.close();
}

// コメントテンプレートを開く
function estimateSystemTemplateCommentOpen() {
    //window.open("./comment_template.asp", "comment_temp", "width=630, height=700, menubar=no, toolbar=no, scrollbars=yes");
    var url = "../PopCommentTemplate/PopCommentTemplate.aspx";
    $.showModalDialog(url, 630, 700, "テンプレートコメント画面");
}

// 詳細でコメントを表示
function estimateSystemDetailCommentBtn(e) {
	if (document.getElementById("SaveProductCommentArea").style.display == "block") {
		document.getElementById("SaveProductCommentBtn").innerHTML = "商品コメントを見る";
		document.getElementById("SaveProductCommentArea").style.display = "none";
	} else {
		document.getElementById("SaveProductCommentBtn").innerHTML = "商品コメントを閉じる";
		document.getElementById("SaveProductCommentArea").style.top = window.pageYOffset + "px";
		document.getElementById("SaveProductCommentArea").style.display = "block";
	}
}

// テキストエリアのタブ入力
function estimateSystemTabInput(object, e) {
	var kC = e.keyCode ? e.keyCode : e.charCode ? e.charCode : e.which;

	if (kC == 9 && !e.shiftKey && !e.ctrlKey && !e.altKey) {
		var objectScroll = object.scrollTop;
		if (object.setSelectionRange) {
			var sS = object.selectionStart;
			var sE = object.selectionEnd;
			object.value = object.value.substring(0, sS) + "\t" + object.value.substr(sE);
			object.setSelectionRange(sS + 1, sS + 1);
			object.focus();
		} else if (object.createTextRange) {
			document.selection.createRange().text = "\t";
			e.returnValue = false;
		}

		object.scrollTop = objectScroll;

		if (e.preventDefault) {
			e.preventDefault();
		}

		return false;
	}
	return true;
}

// 商品データコピー
function estimateSystemItemDataCopy() {
	//window.open("./product_out.asp","product_out","width=420, height=400, menubar=no, toolbar=no, scrollbars=yes");
    var url = "../PopProductOut/PopProductOut.aspx";
    $.showModalDialog(url, 420, 430, "商品データ出力画面");
}

function estimateSystemItemDataCopyCall() {
	OutputData = "";

	for (i = 1; i <= MaxDispLine; i++) {
		if (window.opener.document.getElementById("ProductCode" + i).value != "") {
			OutputData += i + "\t";
			OutputData += window.opener.document.getElementById("ProductCode" + i).value + "\t";
			OutputData += window.opener.document.getElementById("RegularPrice" + i).value + "\t";
			OutputData += window.opener.document.getElementById("UnitPrice" + i).value + "\t";
			OutputData += window.opener.document.getElementById("Quantity" + i).value + "\t";
			OutputData += window.opener.document.getElementById("EigyouGenka" + i).value + "\t";
			OutputData += window.opener.document.getElementById("InvW_" + i).value + "\t";
			OutputData += window.opener.document.getElementById("InvE_" + i).value + "\n";
		}
	}

	if (OutputData != "") {
		document.getElementById("ProductList").value = "行目\t品番\t定価\t見積金額\t数量\t営業原価\t岡山在庫\t東京在庫\n";
		document.getElementById("ProductList").value += OutputData;
		document.getElementById("ProductList").focus();
	} else {
		alert("出力できるデータがありません。");
		window.close();
	}
}

// 商品データ在庫照会
function estimateSystemItemInventOpen() {
	window.open("./product_zaiko.asp","product_zaiko","width=420, height=400, menubar=no, toolbar=no, scrollbars=yes, resizable=yes");
}

function estimateSystemItemInventOpenCall() {
	OutputData = "";

	for (i = 1; i <= MaxDispLine; i++) {
		if (window.opener.document.getElementById("ProductCode" + i).value != "") {
			OutputData += window.opener.document.getElementById("ProductCode" + i).value + "\n";
		}
	}

	if (OutputData != "") {
		document.getElementById("ProductList").value = OutputData;
	} else {
		alert("出力できるデータがありません。");
		window.close();
	}
}

function estimateSystemItemInventOpenSubmit() {
	document.product_zaiko.submit();
	resizeTo(1200,1000);
}

// グループ管理・グループ検索
function estimateSystemGroupWindowSubmit(mode) {
	document.getElementById("SubmitMode").value = mode;
	document.ESGroupWindow.submit();
}

// グループ管理・グループ詳細
function estimateSystemGroupWindowDetail(GNo) {
	document.getElementById("GroupNo").value = GNo;
	document.ESGroupWindow.submit();
}

// グループ管理・グループ詳細・追加ボタン
function estimateSystemGroupWindowDetailAdd(CNo) {
	// 保存用に見積番号の受け渡し
	document.getElementById("NewAddChk").value = CNo;
	document.getElementById("new_add_btn").style.display = "none";

	if (document.getElementById("CheckNumList").value != "") {
		document.getElementById("CheckNumList").value = document.getElementById("CheckNumList").value + "," + CNo;
	} else {
		document.getElementById("CheckNumList").value = CNo;
	}
}

// グループ管理・グループ詳細・保存ボタン
function estimateSystemGroupWindowDetailSave() {
	if (document.getElementById("CheckNumList").value == "") {
		if (!confirm("紐付いた見積が無い為、削除されます。\nよろしいですか？")) {
			return false;
		}
	}

	if (document.getElementById("rGroupName").value == "") {
		alert("グループ名を設定してください。");
		return false;
	}

	document.getElementById("SubmitMode").value = "save";
	document.ESGroupWindow.submit();
}

// グループ管理・グループ詳細・リーダー選択
function estimateSystemGroupWindowDetailLeader(cno) {
	now_cno = document.getElementById("LeaderCheckNum").value;

	if (document.getElementById("LF_" + now_cno)) {
		document.getElementById("LF_" + now_cno).style.display = "none";
		document.getElementById("BN_" + now_cno).disabled = false;

		if (document.getElementById("LN_" + now_cno).className == "tr_leader") {
			document.getElementById("LN_" + now_cno).className = "";
		}
	}

	document.getElementById("LF_" + cno).style.display = "inline";
	document.getElementById("BN_" + cno).disabled = true;
	document.getElementById("LN_" + cno).className = "tr_leader";
	document.getElementById("LeaderCheckNum").value = cno;
}

// グループ管理・グループ詳細・削除
function estimateSystemGroupWindowDetailDelete(cno) {
	document.getElementById("LN_" + cno).className = "tr_delete";
	document.getElementById("DL_" + cno).innerHTML = "削除";

	if (document.getElementById("LeaderCheckNum").value == cno) {
		document.getElementById("LeaderCheckNum").value = "";
		document.getElementById("LF_" + cno).style.display = "none";
	}

	CList = document.getElementById("CheckNumList").value;
	if (CList.indexOf("," + cno) !== -1) {
		document.getElementById("CheckNumList").value = CList.replace("," + cno,"");
	} else if (CList.indexOf(cno + ",") !== -1) {
		document.getElementById("CheckNumList").value = CList.replace(cno + ",","");
	} else if (CList.indexOf(cno) !== -1) {
		document.getElementById("CheckNumList").value = CList.replace(cno,"");
	}
}

// グループ管理・グループ詳細・見積追加
function estimateSystemGroupWindowDetailNew() {
	cno = window.prompt("追加する見積番号を入力してください。", "");

	if (cno != "" && cno != null) {
		CList = document.getElementById("CheckNumList").value;
		if (CList.indexOf(cno) !== -1) {
			alert("すでに追加されている見積番号です。");
		} else {
			// 見積番号の内容を取得する
			var url = "ES_GroupEstimate.asp?CNO=" + cno;
			http.open("GET", url, false);
			http.onreadystatechange = hhrAdminGroupWindowDetailNew;
			Process_flg = true;
			http.send(null);
		}
	}
}

// 結果代入用 ・・・ 見積追加
function hhrAdminGroupWindowDetailNew() {
	if (http.readyState == 4) {
		if (http.status == 200) {
			if (http.responseText.indexOf('invalid') == -1) {
				results = http.responseText.split("@");

				if (results[0] == "T") {
					// DOM操作
					group_table = document.getElementById("group_table");
					group_table_th = document.getElementById("group_table_th");

					// 結合を増やす
					document.getElementById("group_table_th").rowSpan = group_table_th.rowSpan + 1;

					// 行を増やす
					rows = group_table.insertRow(-1);
					cell1 = rows.insertCell(-1);
					cell2 = rows.insertCell(-1);
					cell3 = rows.insertCell(-1);

					rows.setAttribute('id', 'LN_' + results[1]);

					cell1.innerHTML = results[1] + '<br /><span class="leader_flag no_disp" id="LF_' + results[1] + '">L </span>' + results[2];
					cell2.innerHTML = results[3] + '<br />' + results[4] + '：' + results[5];

					cell3.setAttribute('id', 'DL_' + results[1]);
					cell3.innerHTML = '<input type="button" class="btn3" id="BN_' + results[1] + '" value="ﾘｰﾀﾞｰ" onclick="estimateSystemGroupWindowDetailLeader(\'' + results[1] + '\');" /> <input type="button" class="btn3" value="削 除" onclick="estimateSystemGroupWindowDetailDelete(\'' + results[1] + '\');" />';

					// 結果の値に追加
					if (document.getElementById("CheckNumList").value != "") {
						document.getElementById("CheckNumList").value = document.getElementById("CheckNumList").value + "," + results[1];
					} else {
						document.getElementById("CheckNumList").value = results[1];
					}

					// グループ名が空の場合は件名を自動挿入
					if (document.getElementById("rGroupName").value == "") {
						document.getElementById("rGroupName").value = results[3];
					}
				} else {
					alert("該当の見積が見つかりません。");
				}

				Process_flg = false;
			}
		}
	}
}

// 検索結果からの成約状況更新用ajax
function estimateSystemIndexConclusionChange(CheckNo) {
	modeCode = "0";
	mode = document.getElementById("CSBtn_" + CheckNo).innerHTML;

	switch (mode) {
		case "【継続中】":
			modeCode = "0";
			break;
		case "【成約】":
			modeCode = "1";
			break;
		case "【一部成約】":
			modeCode = "2";
			break;
		case "【不成約】":
			modeCode = "3";
			break;


	}

	if (!Process_flg && http) {
		var url = "ES_ConclusionStatusChange.asp?CN=" + CheckNo + "&CS=" + modeCode;
		http.open("GET", url, false);
		http.onreadystatechange = hdlHtpResIdxConclusionChg;
		Process_flg = true;
		http.send(null);
	}
}

// 結果代入用
function hdlHtpResIdxConclusionChg() {
	if (http.readyState == 4) {
		if (http.status == 200) {
			if (http.responseText.indexOf('invalid') == -1) {
				results = http.responseText.split("@");

				switch (results[1]) {
					case "0":
						modeTxt = "【継続中】";
						modeColor = "#999";
						break;
					case "1":
						modeTxt = "【成約】";
						modeColor = "#00F";
						break;
					case "2":
						modeTxt = "【一部成約】";
						modeColor = "#00F";
						break;
					case "3":
						modeTxt = "【不成約】";
						modeColor = "#F00";
						break;
				}

				document.getElementById("CSBtn_" + results[0]).innerHTML = modeTxt;
				document.getElementById("CSBtn_" + results[0]).style.color = modeColor;

				// alert(modeTxt + "にしました。");
				Process_flg = false;
			}
		}
	}
}

// 詳細の状況ボタン
function estimateSystemDetailConclusionChange(trCnt) {
	nowVal = document.getElementById("ConclusionStatusDetail" + trCnt).value;

	switch (nowVal) {
		case "継続中":
			retVal = "成約";
			break;
		case "成約":
			retVal = "不成約";
			break;
		case "不成約":
			retVal = "継続中";
			break;
	}

	document.getElementById("ConclusionStatusDetail" + trCnt).value = retVal;
	document.getElementById("ConclusionStatusDetailBtn" + trCnt).value = retVal;
}


// 詳細画面の案件管理するチェックでメール送信チェック連動
function estimateSystemDetailProjectCheck() {
	if (document.getElementById("ProjectFlag").checked) {
		document.getElementById("ProjectMailFlag").checked = true;

		if (document.getElementById("ConclusionMailFlag")) {
			document.getElementById("ConclusionMailFlag").checked = false;
		}
	}
}

// 詳細画面の案件系メールトグル化
function estimateSystemDetailProjectMailToggle(mode) {
	if (mode == "Project") {
		if (document.getElementById("ProjectMailFlag").checked) {
			if (document.getElementById("ConclusionMailFlag")) {
				document.getElementById("ConclusionMailFlag").checked = false;
			}
		}
	} else if (mode == "Conclusion") {
		if (document.getElementById("ConclusionMailFlag").checked) {
			document.getElementById("ProjectMailFlag").checked = false;
		}
	}
}

// 詳細画面の案件保存ボタン
function estimateSystemDetailProjectSave() {
	if (document.getElementById("ProjectFlag").checked == false) {
		if (document.getElementById("ConclusionMailFlag")) {
			if (document.getElementById("ConclusionMailFlag").checked) {
				if (confirm("案件管理していないのでメールは送信されません。\nこのまま保存しますか？") == false) {
					return false;
				}
			}
		}

		if (document.getElementById("ProjectMailFlag")) {
			if (document.getElementById("ProjectMailFlag").checked) {
				if (confirm("案件管理していないのでメールは送信されません。\nこのまま保存しますか？") == false) {
					return false;
				}
			}
		}
	}

	document.getElementById("SubmitMode").value = "project";
	document.ESDetailForm.target = "_self";
	document.ESDetailForm.submit();
}

// 開発・仕入・リーダー用確認の保存
function estimateSystemCheckSave(mode) {
	document.getElementById("MailSendFlag").value = mode;
	document.ESCheckForm.target="_self";
	document.ESCheckForm.action = "./check.asp";
	document.ESCheckForm.submit();
}

// 開発・仕入・リーダー用確認の率計算
function estimateSystemCheckPriceCalc(line, type) {
	var RPrice = document.getElementById("RegularPrice" + line).value;

	switch (type) {
		case "LeaderPrice":
			var LPrice = document.getElementById("LeaderPrice" + line).value;
			if (RPrice != "" && LPrice != "") {
				var LRate = Math.round(parseInt(LPrice) / parseInt(RPrice) * 100,0);
			} else {
				var LRate = 0;
			}

			document.getElementById("LeaderRate" + line).value = LRate;
			break;

		case "LeaderRate":
			var LRate = document.getElementById("LeaderRate" + line).value;
			if (RPrice != "" && LRate != "") {
				var LPrice = Math.round(parseInt(RPrice) * parseFloat(LRate) / 100,0);
			} else {
				var LPrice = 0;
			}

			document.getElementById("LeaderPrice" + line).value = LPrice;
			break;

		case "CorrectionPrice":
			var CPrice = document.getElementById("CorrectionPrice" + line).value;
			if (RPrice != "" && CPrice != "") {
				var CRate = Math.round(parseInt(CPrice) / parseInt(RPrice) * 100,0);
			} else {
				var CRate = 0;
			}

			document.getElementById("CorrectionRate" + line).value = CRate;
			break;

		case "CorrectionRate":
			var CRate = document.getElementById("CorrectionRate" + line).value;
			if (RPrice != "" && CRate != "") {
				var CPrice = Math.round(parseInt(RPrice) * parseFloat(CRate) / 100,0);
			} else {
				var CPrice = 0;
			}

			document.getElementById("CorrectionPrice" + line).value = CPrice;
			break;
	}

	// 粗利表示ありの場合は粗利再計算
	if (document.getElementById("LeaderMargin" + line)) {
		if (document.getElementById("LeaderPrice" + line).value != "" && document.getElementById("LeaderPrice" + line).value != "0") {
			var LPrice = document.getElementById("LeaderPrice" + line).value;
		} else {
			var LPrice = document.getElementById("UnitPrice" + line).value;
		}

		if (document.getElementById("CorrectionPrice" + line).value != "" && document.getElementById("CorrectionPrice" + line).value != "0") {
			var CPrice = document.getElementById("CorrectionPrice" + line).value;
		} else {
			var CPrice = document.getElementById("EigyouGenka" + line).value;
		}

		var MPrice = LPrice - CPrice;
		var MRate = Math.round(parseInt(MPrice) / parseInt(LPrice) * 100,0);

		document.getElementById("LeaderMargin" + line).value = MPrice;
		document.getElementById("LeaderMarginRate" + line).value = MRate;
	}
}

// 開発・仕入・リーダー用確認の在庫ボタン
function estimateSystemCheckInvOpen() {
	// 在庫照会
	document.ESCheckForm.target="check_zaiko";
	document.ESCheckForm.action = "http://ss.sanwa.local/sap/zaiko/index.asp";
	document.ESCheckForm.submit();
}

// 件名→最終ユーザー名コピー
function estimateSystemDetailUserNameCopy() {
	var ttl = document.getElementById("Title").value;
	document.getElementById("EndUserName").value = ttl;
}

// 開発・仕入・リーダー用確認のシミュレーションボタン
function estimateSystemCheckSimuOpen(sku) {
	window.open("http://ss.sanwa.local/sap/purchase/?sku=" + sku, "simuration", "width=1920, height=1000, menubar=yes, toolbar=yes, scrollbars=yes, resizable=yes");
}

// 開発・仕入・リーダー用確認のロックアラート
function estimateSystemCheckLockAlert(LockUser, LockDate) {
	if (confirm(LockUser + "さんが開いています。(" + LockDate + ")\nこのまま強制的に開きますか？")) {
		alert("念のため" + LockUser + "さんに確認してください。");
	} else {
		location.href = "./index.asp";
	}
}

// 詳細画面の明細行追加
function estimateSystemDetailAddLine() {
	var NowDispMax = document.getElementById("NowDispMax").value;
	NowDispMax++;
	document.getElementById("NowDispMax").value = NowDispMax;
	document.getElementById("Column_" + NowDispMax).setAttribute('class', '');

	if (NowDispMax == DispMaxLine) {
		document.getElementById("DetailAddBtn").style.display = "none";
	}
}

