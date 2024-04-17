<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<style>
	#CnsltDiaryContainer h3 {
		font-size: 2.2rem;
		text-align: center;
		margin-top: 60px;
		backdrop-filter: blur(4px);
		background-color: rgba(255, 255, 255, 1);
		border-radius: 50px;
		box-shadow: 35px 35px 68px 0px rgba(145, 192, 255, 0.5), inset -8px -8px 16px 0px rgba(145, 192, 255, 0.6), inset 0px 11px 28px 0px rgb(255, 255, 255);
		width: 470px;
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
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script>
//오늘 날짜를 구하는 함수
const today = new Date().toISOString().substring(0, 10);

//학부모-리스트 불러오기
function fn_search(page){
	// 체험학습 문서 목록 데이터 불러오기
	var currentPage = page;
	var keyword = "";
	var size = 10;
	
	if (currentPage == null || currentPage == '') { currentPage = 1; }
	
	let formData = new FormData();
	
	//1. 문서 종류
	let cmmnDocKnd = $("input[name='cmmnDocKnd']:checked").val();
	formData.append("cmmnDocKnd",cmmnDocKnd);
	
	//2. 체험학습시작일
	let exprnLrnBgndeRb = $("input[name='exprnLrnBgndeRb']:checked").val();
	formData.append("exprnLrnBgndeRb",exprnLrnBgndeRb);
	
	//3. 체험학습종료일
	let exprnLrnEnddeRb = $("input[name='exprnLrnEnddeRb']:checked").val();
	formData.append("exprnLrnEnddeRb",exprnLrnEnddeRb);
	
	//4. 신청일
	let rqstDeRb = $("input[name='rqstDeRb']:checked").val();
	formData.append("rqstDeRb",rqstDeRb);
	
	//5. 상태 String[] cmmnProcessSttusCB;
	$("input:checkbox[name='cmmnProcessSttusCB']:checked").each(function(){
		let checkedVal = $(this).val();

		formData.append("cmmnProcessSttusCB",checkedVal);
	});
	
	//6. 체험학습시작일 선택 시작일
	let bgndeStartDate = $("#bgndeStartDate").val();
	formData.append("bgndeStartDate", bgndeStartDate);
	
	//7. 체험학습시작일 선택 종료일
	let bgndeEndDate = $("#bgndeEndDate").val();
	formData.append("bgndeEndDate", bgndeEndDate);
	
	//8. 체험학습종료일 선택 시작일
	let enddeStartDate = $("#enddeStartDate").val();
	formData.append("enddeStartDate", enddeStartDate);
	
	//9. 체험학습종료일 선택 종료일
	let enddeEndDate = $("#enddeEndDate").val();
	formData.append("enddeEndDate", enddeEndDate);
	
	//10. 신청일 선택 시작일
	let rqstDeStartDate = $("#rqstDeStartDate").val();
	formData.append("rqstDeStartDate", rqstDeStartDate);
	
	//11. 신청일 선택 종료일
	let rqstDeEndDate = $("#rqstDeEndDate").val();
	formData.append("rqstDeEndDate", rqstDeEndDate);
	
	//12. 검색 조건
	let searchCondition = $("#searchCondition").val();
	formData.append("searchCondition", searchCondition);
	
	//13. 검색어
	keyword = $("#keyword").val();
	formData.append("keyword", keyword);
	
	//14. 현재 페이지
	formData.append("currentPage", page);
	
	//15. 목록 개수
	formData.append("size", size);
	
	//16. 반학생코드 - 학부모
	<sec:authorize access="hasRole('A01003')">
		let clasStdntCode = '${CLASS_STD_INFO.clasStdntCode}';
		formData.append("clasStdntCode", clasStdntCode);
	</sec:authorize>
	
	//17. 반코드 - 담임
	<sec:authorize access="hasRole('A14002')">
		let clasCode = '${CLASS_INFO.clasCode}';
		formData.append("clasCode", clasCode);
	</sec:authorize>
	
	//18. 학교코드 - 교감
	<sec:authorize access="hasRole('A14005')">
		let schulCode = '${SCHOOL_INFO.schulCode}';
		formData.append("schulCode", schulCode);
	</sec:authorize>
	
 	if (exprnLrnBgndeRb == "bgndeBeforeCustom") {
		if (bgndeStartDate == null || bgndeStartDate == '') {
			alertError('시작일을 선택해주세요.', ' ');
			$("#bgndeStartDate").focus();
			return;
		}
		if (bgndeEndDate == null || bgndeEndDate == '') {
			alertError('종료일을 선택해주세요.', ' ');
			$("#bgndeEndDate").focus();
			return;
		}
	}
	
	if (exprnLrnEnddeRb == "enddeBeforeCustom") {
		if (enddeStartDate == null || enddeStartDate == '') {
			alertError('시작일을 선택해주세요.', ' ');
			$("#enddeStartDate").focus();
			return;
		}
		if (enddeEndDate == null || enddeEndDate == '') {
			alertError('종료일을 선택해주세요.', ' ');
			$("#enddeEndDate").focus();
			return;
		}
	}
	
	if (rqstDeRb == "rqstDeBeforeCustom") {
		if (rqstDeStartDate == null || rqstDeStartDate == '') {
			alertError('시작일을 선택해주세요.', ' ');
			$("#rqstDeStartDate").focus();
			return;
		}
		if (rqstDeEndDate == null || rqstDeEndDate == '') {
			alertError('종료일을 선택해주세요.', ' ');
			$("#rqstDeEndDate").focus();
			return;
		}
	}
	
	$.ajax({
		url: "/approval/loadSanctnDocList",
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
			$.each(res.content, function(idx, sanctnDocVO) {
				let title = `\${sanctnDocVO.purps}`;
				title = title.replace(/\n/gi, " ");						// 제목 줄바꿈 문자를 띄어쓰기로 변경
				let docCode = `\${sanctnDocVO.docCode}`;				// 문서 코드
				
				html += `<tr onclick="location.href='/approval/approvalDetail?docCode=\${docCode}'" style="cursor: pointer;">`;
				
				
					html += `<td>\${sanctnDocVO.rnum}</td>
							<td>\${sanctnDocVO.cmmnDocKnd}</td>
							<td>\${title}</td>
							<td>\${sanctnDocVO.dstn}</td>
							<td>\${dateFormat(sanctnDocVO.exprnLrnBgnde)}</td>
							<td>\${dateFormat(sanctnDocVO.exprnLrnEndde)}</td>
							<td>\${dateFormat(sanctnDocVO.rqstDe)}</td>`;
					if (`\${sanctnDocVO.cmmnProcessSttus}` == '처리 대기') {
	 					html +=	`<td><div class="d-btn d-div-blue">\${sanctnDocVO.cmmnProcessSttus}</div></td>`;
	 				} else if(`\${sanctnDocVO.cmmnProcessSttus}` == '처리 완료') {
	 					html +=	`<td><div class="d-btn d-div-gray">\${sanctnDocVO.cmmnProcessSttus}</div></td>`;
	 				} else if(`\${sanctnDocVO.cmmnProcessSttus}` == '보완 요청') {
	 					html +=	`<td><div class="d-btn d-div-yellow">\${sanctnDocVO.cmmnProcessSttus}</div></td>`;
	 				} else if(`\${sanctnDocVO.cmmnProcessSttus}` == '거부') {
	 					html +=	`<td><div class="d-btn d-div-red">\${sanctnDocVO.cmmnProcessSttus}</div></td>`;
	 				} else{
	 					html +=	`<td><div class="d-btn d-div-green">\${sanctnDocVO.cmmnProcessSttus}</div></td>`;
	 				}
				html += `</tr>`;
			});
			
			// 검색 결과가 존재하지 않을 경우
			if (html == null || html == '') { html = `<tr><td colspan='8' style="text-align: center; font-size: 2.0rem;">검색 결과가 없습니다.</td></tr>`; }
			
			$("#sanctnDocBody").html(html);
			$(".custom-pagination").html(res.pagingArea);
		} // end success
	});	// end ajax
}

window.onload = function(){
	
	//학부모-리스트 불러오기
	fn_search(1);
	
	//input태그에서 엔터시 검색버튼누르기
	var input = $("#keyword");

	  input.on("keypress", function(event) {
	      if (event.key === "Enter") {
	          event.preventDefault();
	          $("#searchBtn").click();
	      }
	  });

	
	/* 검색 시작 */
	// 검색조건 중 사용자 정의 기한 선택
	$("#bgndeDatepicker").hide();
	$("#enddeDatepicker").hide();
	$("#rqstDeDatepicker").hide();
	
	
	
	// 체험학습시작일 중 기간 선택을 클릭하면 날짜를 입력하는 폼이 나오는 함수
	$("input[name='exprnLrnBgndeRb']").on("input", function() {
			let checkedExprnLrnBgndeRb = $("input[name='exprnLrnBgndeRb']:checked").val();
			let bgndeStartDate = $("#bgndeStartDate").val();
			
			$("#bgndeStartDate").attr("value", today);
			$("#bgndeEndDate").attr("min", bgndeStartDate);
			
			if (checkedExprnLrnBgndeRb === "bgndeBeforeCustom") {
				$("#bgndeDatepicker").show();
				
				$("input[name='exprnLrnEnddeRb'][value='enddeBeforeAll']").prop("checked", true);
				$("#enddeDatepicker").hide();
				
				$("input[name='rqstDeRb'][value='rqstDeBeforeAll']").prop("checked", true);
				$("#rqstDeDatepicker").hide();
			} else{
				$("#bgndeDatepicker").hide();
			}
		});
	
	// 체험학습시작일 시작 날짜를 클릭하면 종료 날짜의 최소 시작 날짜가 시작 날짜로 설정되는 함수
	$("#bgndeStartDate").on("input", function(){
		let bgndeStartDate = $("#bgndeStartDate").val();
		$("#bgndeEndDate").attr("min", bgndeStartDate);
	});
	
	// 체험학습종료일 중 기간 선택을 클릭하면 날짜를 입력하는 폼이 나오는 함수
	$("input[name='exprnLrnEnddeRb']").on("input", function() {
			let checkedExprnLrnEnddeRb = $("input[name='exprnLrnEnddeRb']:checked").val();
			let enddeStartDate = $("#enddeStartDate").val();
			
			$("#enddeStartDate").attr("value", today);
			$("#enddeEndDate").attr("min", enddeStartDate);
			
			if (checkedExprnLrnEnddeRb === "enddeBeforeCustom") {
				$("#enddeDatepicker").show();
				
				$("input[name='exprnLrnBgndeRb'][value='bgndeBeforeAll']").prop("checked", true);
				$("#bgndeDatepicker").hide();
				
				$("input[name='rqstDeRb'][value='rqstDeBeforeAll']").prop("checked", true);
				$("#rqstDeDatepicker").hide();
				
			} else{
				$("#enddeDatepicker").hide();
			}
		});
	
	// 체험학습종료일 시작 날짜를 클릭하면 종료 날짜의 최소 시작 날짜가 시작 날짜로 설정되는 함수
	$("#enddeStartDate").on("input", function(){
		let enddeStartDate = $("#enddeStartDate").val();
		$("#enddeEndDate").attr("min", enddeStartDate);
	});
	
	// 신청일 중 기간 선택을 클릭하면 날짜를 입력하는 폼이 나오는 함수
	$("input[name='rqstDeRb']").on("input", function() {
			let checkedRqstDeRb = $("input[name='rqstDeRb']:checked").val();
			let rqstDeStartDate = $("#rqstDeStartDate").val();
			
			$("#rqstDeStartDate").attr("value", today);
			$("#rqstDeEndDate").attr("min", rqstDeStartDate);
			
			if (checkedRqstDeRb === "rqstDeBeforeCustom") {
				$("#rqstDeDatepicker").show();
				
				$("input[name='exprnLrnBgndeRb'][value='bgndeBeforeAll']").prop("checked", true);
				$("#bgndeDatepicker").hide();
				
				$("input[name='exprnLrnEnddeRb'][value='enddeBeforeAll']").prop("checked", true);
				$("#enddeDatepicker").hide();
				
			} else{
				$("#rqstDeDatepicker").hide();
			}
		});
	
	// 신청일 시작 날짜를 클릭하면 종료 날짜의 최소 시작 날짜가 시작 날짜로 설정
	$("#rqstDeStartDate").on("input", function(){
		let rqstDeStartDate = $("#rqstDeStartDate").val();
		$("#rqstDeEndDate").attr("min", rqstDeStartDate);
	});
	
	// 상태로 검색하는 체크 박스 전체 선택 설정 시작
	$("#sttusAll").on("click", function() {
		if( $("#sttusAll").is(":checked") ) {
			$("input[type='checkbox'].cmmnProcessSttusCB").attr("checked", false);
		}
	});
	
	// 나머지가 전체 선택되면 전체 체크박스가 클릭되고 나머지는 풀림
	$("input:checkbox[class='cmmnProcessSttusCB']").on("click", function() {
		let cmmnProcessSttusCBTotal = $("input:checkbox[class='cmmnProcessSttusCB']").length;
		let cmmnProcessSttusCBChecked = $("input:checkbox[class='cmmnProcessSttusCB']:checked").length;

		$("#sttusAll").prop("checked", false);
		
		if (cmmnProcessSttusCBTotal != cmmnProcessSttusCBChecked) {
			$("#sttusAll").prop("checked", false);
		} else {
			$("input:checkbox[class='cmmnProcessSttusCB']").attr("checked", false);
			$("#sttusAll").prop("checked", true);
		}
	});
	// 상태로 검색하는 체크 박스 전체 선택 설정 끝
	
	// 검색 조건 클릭 시 값 저장
	$("#searchCondition").on("input", function(){
		searchCondition = $("#searchCondition").val();
	});
	
	$("#searchBtn").on("click", function() {
		//학부모-리스트 불러오기
		fn_search(1);
		
	});
	
	$("#createBtn").on("click",function(){
		location.href="/approval/fieldStudyApply?clasCode=${CLASS_INFO.clasCode}";
	});
	$("#reportBtn").on("click",function(){
		location.href="/approval/fieldStudyReport?clasCode=${CLASS_INFO.clasCode}";
	});
}
</script>

<div id="CnsltDiaryContainer">
	<div class="sparkline13-list">
		<h3>
			<img src="/resources/images/school/dataRoom1.png" style="width:50px; display:inline-block; vertical-align:middel;">
				체험학습 신청 목록
			<img src="/resources/images/school/dataRoom2.png" style="width:50px; display:inline-block; vertical-align:middel;">		
		</h3>
		<div class="sparkline13-graph">
			<div class="datatable-dashv1-list custom-datatable-overright">
				<div class="bootstrap-table" style="position:relative;">
				<!-- 등록 버튼 시작 -->
				<sec:authorize access = "hasRole('A01003')" >
					<div class="col-md-10 text-right pull-right">
						<!-- text-right를 사용하여 오른쪽 정렬 -->
						<button type="button" id="createBtn" class="btn btn-custon-rounded-two btn-primary">체험 학습 신청서 작성</button>
						<button type="button" id="reportBtn" class="btn btn-custon-rounded-two btn-primary">체험 학습 보고서 작성</button>
					</div>
				</sec:authorize>
				<!-- 등록 버튼 끝 -->
				<!-- 검색 조건 시작 -->
					<div class="fixed-table-toolbar" style="margin-bottom: 70px;">
						<div style="text-align: right; position:absolute; right: 0; top:50px;">검색 조건
							<select name="searchCondition" id="searchCondition" name="searchCondition">
								<option value="searchAll" selected>전체</option>
								<option value="purps">목적</option>
								<option value="dstn">목적지</option>
							</select>
							<input class="searchForm" type="text" id="keyword" name="keyword" >
							<button type="button" id="searchBtn">검색</button>
						</div>
						<div class="condition-content" style="position: absolute; top:185px; left:0; width: 50%;">
							<div class="input-daterange input-group" id="bgndeDatepicker">
								<input type="date" class="form-control" id="bgndeStartDate" name="bgndeStartDate"/>
								<span class="input-group-addon">to</span>
								<input type="date" class="form-control" id="bgndeEndDate" name="bgndeEndDate"/>
							</div>
							<div class="input-daterange input-group" id="enddeDatepicker">
								<input type="date" class="form-control" id="enddeStartDate" name="enddeStartDate"/>
								<span class="input-group-addon">to</span>
								<input type="date" class="form-control" id="enddeEndDate" name="enddeEndDate"/>
							</div>
							<div class="input-daterange input-group" id="rqstDeDatepicker">
								<input type="date" class="form-control" id="rqstDeStartDate" name="rqstDeStartDate"/>
								<span class="input-group-addon">to</span>
								<input type="date" class="form-control" id="rqstDeEndDate" name="rqstDeEndDate"/>
							</div>
						</div>
						
						<table style="width: 40%; position: relative;">
							<tbody>
							<tr>
								<th>종류</th>
								<td>
									<input type="radio" id="cmmnDocKndAll" name="cmmnDocKnd" checked />
									<label for="cmmnDocKndAll">전체</label>
									<input type="radio" id="apply" name="cmmnDocKnd" value="A25001" />
									<label for="apply">체험학습신청서</label>
									<input type="radio" id="report" name="cmmnDocKnd" value="A25002" />
									<label for="report">체험학습보고서</label>
								</td>
							</tr>
							<tr>
								<th>체험학습시작일</th>
								<td>
									<input type="radio" id="bgndeBeforeAll" name="exprnLrnBgndeRb" value="bgndeBeforeAll" checked />
									<label for="bgndeBeforeAll">전체</label>
									<input type="radio" id="bgndeBefore7" name="exprnLrnBgndeRb" value="bgndeBefore7" />
									<label for="bgndeBefore7">일주일 전</label>
									<input type="radio" id="bgndeBefore30" name="exprnLrnBgndeRb" value="bgndeBefore30" />
									<label for="bgndeBefore30">한달 전</label>
									<input type="radio" id="bgndeBeforeCustom" name="exprnLrnBgndeRb" value="bgndeBeforeCustom" />
									<label for="bgndeBeforeCustom">기간 선택</label>
								</td>
								
								
							</tr>
							<tr>
								<th>체험학습종료일</th>
								<td>
									<input type="radio" id="enddeBeforeAll" name="exprnLrnEnddeRb" value="enddeBeforeAll" checked />
									<label for="enddeBeforeAll">전체</label>
									<input type="radio" id="enddeBefore7" name="exprnLrnEnddeRb" value="enddeBefore7" />
									<label for="enddeBefore7">일주일 전</label>
									<input type="radio" id="enddeBefore30" name="exprnLrnEnddeRb" value="enddeBefore30" />
									<label for="enddeBefore30">한달 전</label>
									<input type="radio" id="enddeBeforeCustom" name="exprnLrnEnddeRb" value="enddeBeforeCustom" />
									<label for="enddeBeforeCustom">기간 선택</label>
								</td>
								
							</tr>
							<tr>
								<th>신청일</th>
								<td>
									<input type="radio" id="rqstDeBeforeAll" name="rqstDeRb" value="rqstDeBeforeAll" checked />
									<label for="rqstDeBeforeAll">전체</label>
									<input type="radio" id="rqstDeBefore7" name="rqstDeRb" value="rqstDeBefore7" />
									<label for="rqstDeBefore7">일주일 전</label>
									<input type="radio" id="rqstDeBefore30" name="rqstDeRb" value="rqstDeBefore30" />
									<label for="rqstDeBefore30">한달 전</label>
									<input type="radio" id="rqstDeBeforeCustom" name="rqstDeRb" value="rqstDeBeforeCustom" />
									<label for="rqstDeBeforeCustom">기간 선택</label>
								</td>
								
							</tr>
							<tr>
								<th>상태</th>
								<td id="statusTd">
									<input type="checkbox" id="sttusAll" name="cmmnProcessSttusCB" value="sttusAll" checked/>
									<label for="sttusAll">전체</label>
									<input type="checkbox" id="sttusWait"  name="cmmnProcessSttusCB" value="sttusWait" class="cmmnProcessSttusCB" />
									<label for="sttusWait">처리 대기</label>
									<input type="checkbox" id="sttusIng"  name="cmmnProcessSttusCB" value="sttusIng" class="cmmnProcessSttusCB" />
									<label for="sttusIng">처리 중</label>
									<input type="checkbox" id="sttusCompensate"  name="cmmnProcessSttusCB" value="sttusCompensate" class="cmmnProcessSttusCB" />
									<label for="sttusCompensate">보완 요청</label>								
									<input type="checkbox" id="sttusSuccess"  name="cmmnProcessSttusCB" value="sttusSuccess" class="cmmnProcessSttusCB" />
									<label for="sttusSuccess">처리 완료</label>								
									<input type="checkbox" id="sttusDeny"  name="cmmnProcessSttusCB" value="sttusDeny" class="cmmnProcessSttusCB" />
									<label for="sttusDeny">거부</label>								
								</td>
							</tr>
							</tbody>
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
										<th style="width: 10%;">
											<div class="th-inner ">종류</div>
											<div class="fht-cell"></div>
										</th>
										<th style="width: 20%;">
											<div class="th-inner ">목적</div>
											<div class="fht-cell" ></div>
										</th>
										<th style="width: 20%;">
											<div class="th-inner ">목적지</div>
											<div class="fht-cell"></div>
										</th>
										<th style="width: 10%;">
											<div class="th-inner ">체험학습시작일</div>
											<div class="fht-cell"></div>
										</th>
										<th style="width: 10%;">
											<div class="th-inner ">체험학습종료일</div>
											<div class="fht-cell"></div>
										</th>
										<th style="width: 10%;">
											<div class="th-inner ">신청일</div>
											<div class="fht-cell"></div>
										</th>
										<th style="width: 10%;">
											<div class="th-inner ">처리상태</div>
											<div class="fht-cell"></div>
										</th>
									</tr>
								</thead>
								<tbody id="sanctnDocBody" style="vertical-align: middle;">
								
								</tbody>
							</table>
						</div>
						<!-- 페이징 -->
						<div class="custom-pagination" id="divPaging"></div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>