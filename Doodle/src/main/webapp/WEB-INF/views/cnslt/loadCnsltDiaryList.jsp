<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script type="text/javascript" src="/resources/js/commonFunction.js"></script>
<style>
	#CnsltDiaryContainer h3 {
		font-size: 2.2rem;
		text-align: center;
		margin-top: 60px;
		backdrop-filter: blur(4px);
		background-color: rgba(255, 255, 255, 1);
		border-radius: 50px;
		box-shadow: 35px 35px 68px 0px rgba(145, 192, 255, 0.5), inset -8px -8px 16px 0px rgba(145, 192, 255, 0.6), inset 0px 11px 28px 0px rgb(255, 255, 255);
		width: 370px;
		padding-top: 25px;
		padding-bottom: 35px;
		margin: auto;
		margin-top: 10px;
		margin-bottom: 25px;
	}

	#CnsltDiaryContainer {
		min-height: 824px;
	}
	
	#CnsltDiaryContainer .custom-pagination {
		max-width:302px;
		margin: auto;
	}
	
	#CnsltDiaryContainer .custom-pagination .pagination {
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
		border-radius: 5px;
		padding-left: 10px;
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
</style>
<script>
	function fn_search(currentPage) {
		const today = new Date().toISOString().substring(0, 10);
		
		var currentPage = currentPage;
		var keyword = "";
		var size = 10;
		
		if (currentPage == null || currentPage == '') { currentPage = 1; }
		
		let formData = new FormData();
		
		// 1. 기간
		let cnsltDeRB = $("input[name='cnsltDeRB']:checked").val();
		formData.append("cnsltDeRB",cnsltDeRB);
		
		if (cnsltDeRB == "beforeCustom") {
			if (startDate == null || startDate == '') {
				alertError('시작일을 선택해주세요.', ' ');
				$("#startDate").focus();
				return;
			}
			if (endDate == null || endDate == '') {
				alertError('종료일을 선택해주세요.', ' ');
				$("#endDate").focus();
				return;
			}
		}
		
		// 2. 상담 시간 -> String[] cnsltTimeCB;
		$("input:checkbox[name='cnsltTimeCB']:checked").each(function(){
			let checkedVal = $(this).val();
			
			formData.append("cnsltTimeCB",checkedVal);
		});
		
		// 3. 상태 -> String[] cnsltSttusCB;
		$("input:checkbox[name='cnsltSttusCB']:checked").each(function(){
			let checkedVal = $(this).val();
			
			formData.append("cnsltSttusCB",checkedVal);
		});
		
		// 4. 기간 선택 시작일
		let startDate = $("#startDate").val();
		formData.append("startDate", startDate);
		
		// 5. 기간 선택 종료일
		let endDate = $("#endDate").val();
		formData.append("endDate", endDate);
		
		if (cnsltDeRB == "beforeCustom") {
			if (startDate == null || startDate == '') {
				alertError('시작일을 선택해주세요.', ' ');
				$("#startDate").focus();
				return;
			}
			if (endDate == null || endDate == '') {
				alertError('종료일을 선택해주세요.', ' ');
				$("#endDate").focus();
				return;
			}
		}
		
		// 6. 검색 조건
		let searchCondition = $("#searchCondition").val();
		formData.append("searchCondition", searchCondition);
		
		// 7. 검색어
		keyword = $("#keyword").val();
		formData.append("keyword", keyword);
		
		// 현재 페이지
		formData.append("currentPage", currentPage);
		
		// 출력될 목록 수
		formData.append("size", size);
		
		// 상담 일지 목록 불러오기(예약 거부 A09003, 상담 완료 A09004)
		$.ajax({
			url: "/cnslt/loadCnsltDiaryList",
			processData: false,
			contentType: false,
			type: "post",
			data: formData,
			dataType: "json",
			beforeSend:function(xhr){
    			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
    		},
    		success: function(res) {
				let html;
				$.each(res.content, function(idx, cnsltVO) {
					let title = `\${cnsltVO.cnsltRequstCn}`;
					title = title.replace(/\n/gi, " ");						// 제목 줄바꿈 문자를 띄어쓰기로 변경
					let cnsltCn = `\${cnsltVO.cnsltCn}`;					// 상담 내용		
					let rowNum = Number(formData.get("currentPage")) - 1;	// 행의 첫 번호
					
					html += `<tr><td>`;
					
					html += rowNum > 0 ? `\${rowNum + "" + (idx + 1)}` : `\${(idx + 1)}`;
					
					html += `</td>
							<td><div id="cnsltTitle" class="singleline-ellipsis" data-cnslt-code="\${cnsltVO.cnsltCode}" data-cnslt-target-id="\${cnsltVO.cnsltTrgetId}">\${title}</div></td>
							<td>\${dateFormat(cnsltVO.cnsltDe)}</td>
							<td>\${cnsltVO.cmmnCnsltTime}</td>
							<td>\${cnsltVO.cnsltTrgetIdNm}</td>
							<td>\${cnsltVO.cnsltTcherIdNm}</td>`;
					if (`\${cnsltVO.cmmnCnsltSttus}` == 'A09003') {
						html +=	`<td><div class="d-btn d-div-red">\${cnsltVO.cmmnCnsltSttusNm}</div></td>`;
					} else {		// A09004인 경우
						if (cnsltCn === 'null' || cnsltCn === "") {
							html += `<td><div class="d-btn d-div-yellow">일지 미작성</div></td>`;
						} else {	// 일지가 작성된 경우 상담 완료
							html += `<td><div class="d-btn d-div-gray">\${cnsltVO.cmmnCnsltSttusNm}</div></td>`;
						}
					}
					
					html += `</tr>`;
				});
				
				// 상담이 존재하지 않을 경우
				if (html == null || html == '') { html = `<tr><td colspan='7' style="text-align: center;">상담 일지가 존재하지 않습니다.</td></tr>`; }
				
				$("#cnsltTbody").html(html);
				$(".custom-pagination").html(res.pagingArea);
			} // end success
		});	// end ajax
	}

	window.onload = function() {
		
		fn_search(1);
		
		// 제목 클릭
		$(document).on("click", "#cnsltTitle", function() {
			let cnsltCode = $(this).data("cnsltCode");
			$("input[name='cnsltCode']").val(cnsltCode);
			
			$("#frmCnslt").submit();
		}); // end click cnsltTitle
		
		/* 검색 시작 */
		// 검색조건 중 사용자 정의 기한 선택
		$("#datepicker").hide();
		
		// 기간 중 기간 선택을 클릭하면 날짜를 입력하는 폼이 나오는 함수
		$("input[name='cnsltDeRB']").on("input", function() {
			let checkedCnsltDe = $("input[name='cnsltDeRB']:checked").val();
			let startDate = $("#startDate").val();
			
			$("#startDate").attr("value", today);
			$("#endDate").attr("min", startDate);
			
			if (checkedCnsltDe === "beforeCustom") {
				$("#datepicker").show();
			} else{
				$("#datepicker").hide();
			}
		});
		
		// 시작 날짜를 클릭하면 종료 날짜의 최소 시작 날짜가 시작 날짜로 설정되는 함수
		$("#startDate").on("input", function(){
			let startDate = $("#startDate").val();
			$("#endDate").attr("min", startDate);
		});
		
		// 체크박스 전체 선택 설정 시작
		$("#timeAll").on("click", function() {
			if( $("#timeAll").is(":checked") ) {
				$("input:checkbox[class='cnsltTimeCB']").attr("checked", false);
			}
		});
		
		$("input:checkbox[class='cnsltTimeCB']").on("click", function() {
			let cnsltTimeCBTotal = $("input:checkbox[class='cnsltTimeCB']").length;
			let cnsltTimeCBChecked = $("input:checkbox[class='cnsltTimeCB']:checked").length;

			$("#timeAll").prop("checked", false);
			
			if (cnsltTimeCBTotal != cnsltTimeCBChecked) {
				$("#timeAll").prop("checked", false);
			} else {
				$("input:checkbox[class='cnsltTimeCB']").attr("checked", false);
				$("#timeAll").prop("checked", true);
			}
		});
		// 체크박스 전체 선택 설정 끝
		
		// 상태로 검색하는 체크 박스 전체 선택 설정 시작
		$("#sttusAll").on("click", function() {
			if( $("#sttusAll").is(":checked") ) {
				$("input[type='checkbox'].cnsltSttusCB").attr("checked", false);
			}
		});
		
		// 나머지가 전체 선택되면 전체 체크박스가 클릭되고 나머지는 풀리는 함수
		$("input:checkbox[class='cnsltSttusCB']").on("click", function() {
			let cnsltSttusCBTotal = $("input:checkbox[class='cnsltSttusCB']").length;
			let cnsltSttusCBChecked = $("input:checkbox[class='cnsltSttusCB']:checked").length;

			$("#sttusAll").prop("checked", false);
			
			if (cnsltSttusCBTotal != cnsltSttusCBChecked) {
				$("#sttusAll").prop("checked", false);
			} else {
				$("input:checkbox[class='cnsltSttusCB']").attr("checked", false);
				$("#sttusAll").prop("checked", true);
			}
		});
		// 상태로 검색하는 체크 박스 전체 선택 설정 끝

		//input태그에서 엔터시 검색버튼누르기
		$("#keyword").on("keypress", function(event) {
			if (event.key === "Enter") {
				event.preventDefault();
				$("#searchBtn").click();
			}
		});
		
		$("#searchBtn").on("click", function() {
			fn_search(1);
		});
	}
</script>

<!-- forwarding으로 데이터를 보내기위한 form -->
<form id="frmCnslt" method="post" action="/cnslt/viewCnsltCnDetail">
	<input type="hidden" name="cnsltCode" />
	<sec:csrfInput/>
</form>

<div id="CnsltDiaryContainer">
	<div class="sparkline13-list">
		<h3>
			<img src="/resources/images/consultation/cnsltTitleImg.png" style="width:50px; display:inline-block; vertical-align:middel;">
			상담 일지 게시판
			<img src="/resources/images/consultation/cnsltTitleImg2.png" style="width:50px; display:inline-block; vertical-align:middel;">		
		</h3>
		<div class="sparkline13-graph">
			<div class="datatable-dashv1-list custom-datatable-overright">
				<div class="bootstrap-table">
					<div class="fixed-table-toolbar">
						<!-- 검색 조건 시작 -->
						<table style="width: 100%;">
							<tr>
								<th>기간</th>
								<td>
									<input type="radio" id="beforeAll" name="cnsltDeRB" value="beforeAll" checked />
									<label for="beforeAll">전체</label>
									<input type="radio" id="before7" name="cnsltDeRB" value="before7" />
									<label for="before7">일주일 전</label>
									<input type="radio" id="before30" name="cnsltDeRB" value="before30" />
									<label for="before30">한달 전</label>
									<input type="radio" id="beforeCustom" name="cnsltDeRB" value="beforeCustom" />
									<label for="beforeCustom">기간 선택</label>
								</td>
								<td class="input-daterange input-group" id="datepicker">
									<input type="date" class="form-control" id="startDate" name="startDate"/>
									<span class="input-group-addon">to</span>
									<input type="date" class="form-control" id="endDate" name="endDate"/>
								</td>
								<th rowspan='3' style="text-align: right;">검색 조건
									<select name="searchCondition" id="searchCondition" name="searchCondition">
										<option value="searchAll" selected>전체</option>
										<option value="cnsltRequstCn">상담 요청 내용</option>
										<option value="cnsltTrgetId">대상자</option>
										<option value="cnsltTcherId">상담자</option>
									</select>
									<input class="searchForm" type="text" id="keyword" name="keyword" >
									<button type="button" id="searchBtn">검색</button>
								</th>
							</tr>
							<tr>
								<th>상담 시간</th>
								<td>
									<input type="checkbox" id="timeAll" name="cnsltTimeCB" value="timeAll" checked/>
									<label for="timeAll">전체</label>
									<input type="checkbox" id="time13"  name="cnsltTimeCB" value="13:00" class="cnsltTimeCB"/>
									<label for="time13">13:00</label>
									<input type="checkbox" id="time14"  name="cnsltTimeCB" value="14:00" class="cnsltTimeCB"/>
									<label for="time14">14:00</label>
									<input type="checkbox" id="time15"  name="cnsltTimeCB" value="15:00" class="cnsltTimeCB"/>
									<label for="time15">15:00</label>
									<input type="checkbox" id="time16"  name="cnsltTimeCB" value="16:00" class="cnsltTimeCB"/>
									<label for="time16">16:00</label>
									<input type="checkbox" id="time17"  name="cnsltTimeCB" value="17:00" class="cnsltTimeCB"/>
									<label for="time17">17:00</label>
									<input type="checkbox" id="time18"  name="cnsltTimeCB" value="18:00" class="cnsltTimeCB"/>
									<label for="time18">18:00</label>
								</td>
							</tr>
							<tr>
								<th>상태</th>
								<td>
									<input type="checkbox" id="sttusAll" name="cnsltSttusCB" value="sttusAll" checked/>
									<label for="sttusAll">전체</label>
									<input type="checkbox" id="sttusSuccess"  name="cnsltSttusCB" value="sttusSuccess" class="cnsltSttusCB" />
									<label for="sttusSuccess">상담 완료</label>
									<input type="checkbox" id="sttusNoCn"  name="cnsltSttusCB" value="sttusNoCn" class="cnsltSttusCB" />
									<label for="sttusNoCn">일지 미작성</label>
									<input type="checkbox" id="sttusDeny"  name="cnsltSttusCB" value="sttusDeny" class="cnsltSttusCB" />
									<label for="sttusDeny">예약 거부</label>								
								</td>
							</tr>
						</table>													
						<!-- 검색 조건 끝 -->
					</div>
					<div class="fixed-table-container" style="padding-bottom: 0px;">
						<div class="fixed-table-body">
							<table id="table" data-toggle="table" data-pagination="true"
								data-search="true" data-show-columns="true"
								data-show-pagination-switch="true" data-show-refresh="true"
								data-key-events="true" data-show-toggle="true"
								data-resizable="true" data-cookie="true"
								data-cookie-id-table="saveId" data-show-export="true"
								data-click-to-select="true" data-toolbar="#toolbar"
								class="table table-hover JColResizer">
								<thead>
									<tr style="font-size:1rem;">
										<th style="width: 10%;">
											<div class="th-inner ">번호</div>
											<div class="fht-cell"></div>
										</th>
										<th style="width: 40%;">
											<div class="th-inner ">상담 요청 내용</div>
											<div class="fht-cell" ></div>
										</th>
										<th style="width: 10%;">
											<div class="th-inner ">상담일</div>
											<div class="fht-cell"></div>
										</th>
										<th style="width: 10%;">
											<div class="th-inner ">상담 시간</div>
											<div class="fht-cell"></div>
										</th>
										<th style="width: 10%;">
											<div class="th-inner ">대상자</div>
											<div class="fht-cell"></div>
										</th>
										<th style="width: 10%;">
											<div class="th-inner ">상담자</div>
											<div class="fht-cell"></div>
										</th>
										<th style="width: 10%;">
											<div class="th-inner ">상태</div>
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