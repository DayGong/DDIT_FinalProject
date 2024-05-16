<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<script type="text/javascript" src="/resources/js/commonFunction.js"></script>
<style>
	#ComplaintContainer h3 {
		font-size: 2.2rem;
		text-align: center;
		backdrop-filter: blur(4px);
		background-color: rgba(255, 255, 255, 1);
		border-radius: 50px;
		box-shadow: 35px 35px 68px 0px rgba(145, 192, 255, 0.5), inset -8px -8px 16px 0px rgba(145, 192, 255, 0.6), inset 0px 11px 28px 0px rgb(255, 255, 255);
		width: 370px;
		padding-top: 25px;
		padding-bottom: 25px;
		margin: auto;
		margin-top: 10px;
		margin-bottom: 10px;
	}

	#ComplaintContainer {
		min-height: 800px;
	}
	
	#ComplaintContainer .custom-pagination {
		max-width:302px;
		margin: auto;
	}
	
	#ComplaintContainer .custom-pagination .pagination {
		 width: max-content;
	}
	
	.searchForm {
		height: 40px;
		border: 1px solid #ddd;
		border-radius: 5px;
		padding: 15px 20px;
	}
	
	#searchBtn,#insertBtn {
		background: #333;
		height: 40px;
		border: none;
		padding: 10px 15px;
		border-radius: 10px;
		font-family: 'Pretendard' !important;
		font-weight: 600;
		color: #fff;
	}
	
	#searchBtn:hover, #insertBtn:hover {
		background: #ffd77a;
		color:#333;
		transition:all 1s;
		font-weight: 700;
	}
	
	#insertBtn {
		background: #006DF0;
	}
	
	#searchCondition {
		height: 40px;
		border: 1px solid #ddd;
		padding-left: 10px;
		padding-right: 10px;
	}
	
	.custom-datatable-overright table tbody tr.none-tr td:hover {
		background: #fff!imporant;
	}

	.singleline-ellipsis {
		width: 423.86px;
		overflow:hidden; 
		text-overflow:ellipsis; 
 		white-space:nowrap; 
 		cursor: pointer;
	}
	
	#searchTb > tr > th {
		width: 10%;
	} 
	
</style>
<script>
/** 신고 목록을 불러오는 함수 */
function fn_search(currentPage) {
	var currentPage = currentPage;
	var keyword = "";
	var size = 10;
	
	if (currentPage == null || currentPage == '') { currentPage = 1; }

	let formData = new FormData();
	
	// 1. 접수 일자
	let rceptDtRd = $("input[name='rceptDtRd']:checked").val();
	formData.append("rceptDtRd", rceptDtRd);
	
	// 2. 접수 일자 시작일, 종료일
	let recptStDt = $("#rceptStartDate").val();
	let rceptEdDt = $("#rceptEndDate").val();
	formData.append("rceptStDt", recptStDt);
	formData.append("rceptEdDt", rceptEdDt);
	
	if (rceptDtRd == "rceptCustom") {
		if (recptStDt == null || recptStDt == '') {
			alertError('접수 일자 시작일을 선택해주세요.', ' ');
			$("#rceptStartDate").focus();
			return;
		}
		if (rceptEdDt == null || rceptEdDt == '') {
			alertError('접수 일자 종료일을 선택해주세요.', ' ');
			$("#rceptEndDate").focus();
			return;
		}
	}
	
	// 3. 처리 일자 선택
	let processDtRd = $("input[name='processDtRd']:checked").val();	
	formData.append("processDtRd", processDtRd);
	
	// 4. 처리 일자 시작일, 종료일
	let processStDt = $("#processStartDate").val();
	let processEdDt = $("#processEndDate").val();
	formData.append("processStDt", processStDt);
	formData.append("processEdDt", processEdDt);
	
	if (processDtRd == "processCustom") {
		if (processStDt == null || processStDt == '') {
			alertError('처리 일자 시작일을 선택해주세요.', ' ');
			$("#processStartDate").focus();
			return;
		}
		if (processEdDt == null || processEdDt == '') {
			alertError('처리 일자 종료일을 선택해주세요.', ' ');
			$("#processEndDate").focus();
			return;
		}
	}
	
	// 5. 상태
	$("input[name='sttemntSttusCB']:checked").each(function() {
		let checkedVal = $(this).val();
		
		formData.append("sttemntSttusCB", checkedVal);
	});

	// 6. 검색 조건
	let searchCondition = $("#searchCondition").val();
	formData.append("searchCondition", searchCondition);
	
	// 7. 검색어
	keyword = $("#keyword").val();
	formData.append("keyword", keyword);
	
	// 8. 현재 페이지
	formData.append("currentPage", currentPage);
	
	// 9. 출력될 목록 수 
	formData.append("size", size);
	
	$.ajax({
		url: "/admin/loadSttemntList",
		processData: false,
		contentType: false,
		type: "post",
		data: formData,
		dataType: "json",
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success: function(res) {
			let html = "";
			
			if (res.content == null || res.content == '') {
				html += `<tr><td colspan='9' style="text-align: center;">신고 내용이 없습니다.</td></tr>`;
			} else {
				$.each(res.content, function(idx, cnsltVO) {
					let rowNum = Number(formData.get("currentPage")) - 1;		// 행의 첫 번호
					
					html += `<tr>
								<td>`;
					html += rowNum > 0 ? `\${rowNum + "" + (idx + 1)}` : `\${(idx + 1)}`;
					html += 	`</td>`;
					html += `	<td>
								\${cnsltVO.nttCode}
								<img class="nttCodeTitle" data-ntt-code="\${cnsltVO.nttCode}" src="/resources/images/consultation/newWindow.png" style="width:20px; height:20px; display:inline-block; vertical-align:middel; cursor: pointer;"/>
							</td>
							<td>\${cnsltVO.cmmnSttemntCnNm}</td>
							<td>\${cnsltVO.wrterId}</td>
							<td>\${cnsltVO.sttemntId}</td>
							<td>\${cnsltVO.nttSttemntAccmlt}</td>
							<td>\${cnsltVO.rceptDt}</td>`;
					
					// 처리 일자
					if (`\${cnsltVO.processDt}` === "null" || `\${cnsltVO.processDt}` === "") {
						html +=	`<td>미확인</td>`;
					} else {
						html +=	`<td>\${cnsltVO.processDt}</td>`;
					}

					// 처리상태
					html += `<td>\${cnsltVO.cmmnSttemntProcessSttusNm}</div></td>`;
					
					if (`\${cnsltVO.cmmnSttemntProcessSttusNm}` === "미확인") {
						html += `<td>
								<button class="noProblemBtn d-btn-blue" data-ntt-code="\${cnsltVO.nttCode}">이상없음</button>
								<button class="stopBtn d-btn-red" data-ntt-code="\${cnsltVO.nttCode}">정지</button>
							</td>
						</tr>`;
					} else {
						html += `<td></td>`;
					}
				}); // end each

			} // end else
			
			document.querySelector("#cnsltTbody").innerHTML = html;
			document.querySelector(".custom-pagination").innerHTML = res.pagingArea;
		}
	});
}

// 상태를 이상 없음으로 변경
function fn_updateSttus(nttCode, sttus) {
	let data = {
		"nttCode" : nttCode,
		"cmmnSttemntProcessSttus" : sttus
	}
	
	$.ajax({
		url: "/admin/updateProcessSttus",
		type: "post",
		data: JSON.stringify(data),
		contentType: "application/json; charset=utf-8",
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success: function(result) {
			let res = "성공";
			let icon = "success";
			
			if (result < 1) { res = "실패"; icon = "error"; }
			
			Swal.fire({
				title: "신고 상태 변경을 " + res + '하였습니다.',
				text: result + "개의 신고 게시물이 변경되었습니다.",
				icon: icon
			}).then(result => { location.reload(); });
		}
	});
}

window.onload = function() {

	fn_search(1);
	
	// 이상없음 버튼
	$(document).on("click", ".noProblemBtn", function() {
		let nttCode = $(this).data("nttCode");
		
		fn_updateSttus(nttCode, "A21002");
	});
	
	// 정지 버튼
	$(document).on("click", ".stopBtn", function() {
		let nttCode = $(this).data("nttCode");
		
		fn_updateSttus(nttCode, "A21003");
	});
	
	// 제목을 클릭하면 게시물 상세보기가 나타나기
	$(document).on("click", ".nttCodeTitle", function(event) {
		let nttCode = $(this).data("nttCode");
	    let url = "/gallery/galleryDetail?atchFileCode=" + nttCode + "&complaint=mod";
		let features = "scrollbars=yes, width=1000, height=1000, location=no, resizable=yes";
		let windowName = "신고된 게시물";
		
		window.open(url, windowName, features);
	});
    
	// 상태 전체 선택 설정 시작
	$("#sttusAll").on("click", function() {
		if ( $("#sttusAll").is(":checked") ) {
			$("input:checkbox[class='sttemntSttusCB']").attr("checked", false);
		}
	});

	let sttus = document.querySelectorAll("input[type='checkbox'].sttemntSttusCB");
	sttus.forEach(function(sttusClass) {
		sttusClass.addEventListener("click", function() {
			let sttusChecked = document.querySelectorAll("input[type='checkbox'].sttemntSttusCB:checked");
			let sttusTotal = sttus.length;
			let sttusCheckedTotal = sttusChecked.length;

			if ( sttusTotal == sttusCheckedTotal ) {
				sttusAll.checked = true;
				sttus.forEach(function(check) { check.checked = false; })
			} else {
				sttusAll.checked = false;
			}
		})
	});
	// 상태 전체 선택 설정 끝

	// 접수 일자의 연도-월-일을 클릭하면 기간 선택으로 자동 선택되는 함수
	document.querySelectorAll(".rceptDate").forEach(function(recptDt) {
		recptDt.addEventListener("click", function(e) {
			let rcept = document.querySelector("input[name='rceptDtRd'][value='rceptCustom']");
			
			rcept.checked = "true";
		});
	});
	
	// 처리 일자의 연도-월-일을 클릭하면 기간 선택으로 자동 선택되는 함수
	document.querySelectorAll(".processDate").forEach(function(processDt) {
		processDt.addEventListener("click", function(e) {
			let process = document.querySelector("input[name='processDtRd'][value='processCustom']");
			
			process.checked = "true";
		});
	});

	// 시작 날짜를 클릭하면 종료 날짜의 최소 시작 날짜가 시작 날짜로 설정되는 함수
	$("#rceptStartDate").on("input", function(){
		let startDt = $("#rceptStartDate").val();
		
		$("#rceptEndDate").attr("min", startDt);
	});

	// 시작 날짜를 클릭하면 종료 날짜의 최소 시작 날짜가 시작 날짜로 설정되는 함수
	$("#processStartDate").on("input", function() {
		let startDt = $("#processStartDate").val();
		
		$("#processEndDate").attr("min", startDt);
	});
	
	// 검색 버튼 클릭 시 값 보내서 목록 가져오기
	$(document).on("click", "#searchBtn", function() {
		fn_search(1);
	});
}
</script>
<div id="ComplaintContainer">
	<div class="sparkline13-list">
		<h3>
			<img src="/resources/images/admin/complaint2.png" style="width:50px; display:inline-block; vertical-align:middel;">		
			신고 게시판
			<img src="/resources/images/admin/complaint.png" style="width:50px; display:inline-block; vertical-align:middel;">
		</h3>
		<div class="sparkline13-graph">
			<div class="datatable-dashv1-list custom-datatable-overright">
				<div class="bootstrap-table">
					<div class="fixed-table-toolbar">
						<!-- 검색 조건 시작 -->
							<table id="searchTb" style="width: 100%;">
								<tr>
									<th>접수 일자</th>
									<td>
										<input type="radio" id="rceptAll" name="rceptDtRd" value="rceptAll" checked />
										<label for="rceptAll">전체</label>
										<input type="radio" id="rcept7" name="rceptDtRd" value="rcept7" />
										<label for="rcept7">일주일 전</label>
										<input type="radio" id="rcept30" name="rceptDtRd" value="rcept30" />
										<label for="rcept30">한달 전</label>
										<input type="radio" id="rceptToday" name="rceptDtRd" value="rceptToday" />
										<label for="rceptToday">오늘</label>
										<input type="radio" id="rceptCustom" name="rceptDtRd" value="rceptCustom" />
										<label for="rceptCustom">기간 선택</label>
									</td>
									<td class="input-daterange input-group" id="datepicker" style="text-align: left;">
										<input type="date" class="form-control rceptDate" id="rceptStartDate" name="rceptStartDate"/>
										<span class="input-group-addon">to</span>
										<input type="date" class="form-control rceptDate" id="rceptEndDate" name="rceptEndDate"/>
									</td>
									<td width="7%"></td>
									<th>처리 일자</th>
									<td>
										<input type="radio" id="processAll" name="processDtRd" value="processAll" checked />
										<label for="processAll">전체</label>
										<input type="radio" id="process7" name="processDtRd" value="process7" />
										<label for="process7">일주일 전</label>
										<input type="radio" id="process30" name="processDtRd" value="process30" />
										<label for="process30">한달 전</label>
										<input type="radio" id="processToday" name="processDtRd" value="processToday" />
										<label for="processToday">오늘</label>
										<input type="radio" id="processCustom" name="processDtRd" value="processCustom" />
										<label for="processCustom">기간 선택</label>
									</td>
									<td class="input-daterange input-group" id="datepicker">
										<input type="date" class="form-control processDate" id="processStartDate" name="processStartDate"/>
										<span class="input-group-addon">to</span>
										<input type="date" class="form-control processDate" id="processEndDate" name="processEndDate"/>
									</td>
									<td width="7%"></td>
								</tr>
								<tr></tr>
								<tr>
									<th>상태</th>
									<td colspan="3">
										<input type="checkbox" id="sttusAll" name="sttemntSttusCB" value="sttusAll" checked/>
										<label for="sttusAll">전체</label>
										<input type="checkbox" id="sttusUncnfrm"  name="sttemntSttusCB" value="A21001" class="sttemntSttusCB" />
										<label for="sttusUncnfrm">미확인</label>
										<input type="checkbox" id="sttusAbnrml"  name="sttemntSttusCB" value="A21002" class="sttemntSttusCB" />
										<label for="sttusAbnrml">이상 없음</label>
										<input type="checkbox" id="sttusStop"  name="sttemntSttusCB" value="A21003" class="sttemntSttusCB" />
										<label for="sttusStop">정지</label>								
									</td>
									<th colspan="4" style="text-align: right;">
										<select name="searchCondition" id="searchCondition" name="searchCondition">
											<option value="searchAll" selected>전체</option>
											<option value="nttCode">게시판 번호</option>
											<option value="cmmnSttemntCnNm">신고 내용</option>
											<option value="writerId">작성자</option>
											<option value="sttemntId">신고자</option>
										</select>
										<input class="searchForm" type="text" id="keyword" name="keyword">
										<button type="button" id="searchBtn">검색</button>
									</th>
								</tr>
							</table>
						<!-- 검색 조건 끝 -->
					</div>
					<div class="fixed-table-container" style="padding-bottom: 0px;">
						<div class="fixed-table-body">
							<table id="table" class="table table-hover">
								<thead>
									<tr style="font-size:1rem;">
										<th style="width: 5%;">
											<div class="th-inner ">번호</div>
											<div class="fht-cell"></div>
										</th>
										<th style="width: 15%;">
											<div class="th-inner ">게시판 번호</div>
											<div class="fht-cell" ></div>
										</th>
										<th style="width: 15%;">
											<div class="th-inner ">신고 내용</div>
											<div class="fht-cell"></div>
										</th>
										<th style="width: 10%;">
											<div class="th-inner ">작성자</div>
											<div class="fht-cell"></div>
										</th>
										<th style="width: 10%;">
											<div class="th-inner ">신고자</div>
											<div class="fht-cell"></div>
										</th>
										<th style="width: 5%;">
											<div class="th-inner ">누적</div>
											<div class="fht-cell"></div>
										</th>
										<th style="width: 10%;">
											<div class="th-inner ">접수 일자</div>
											<div class="fht-cell"></div>
										</th>
										<th style="width: 10%;">
											<div class="th-inner ">처리 일자</div>
											<div class="fht-cell"></div>
										</th>
										<th style="width: 10%;">
											<div class="th-inner ">처리 상태</div>
											<div class="fht-cell"></div>
										</th>
										<th style="width: 15%;">
											<div class="th-inner ">변경</div>
											<div class="fht-cell"></div>
										</th>
									</tr>
								</thead>
								<tbody id="cnsltTbody" style="vertical-align: middle;"></tbody>
							</table>
						</div>
						<!-- 페이징 -->
						<div class="custom-pagination"></div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
