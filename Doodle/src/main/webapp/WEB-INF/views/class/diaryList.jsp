<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script type="text/javascript" src="/resources/js/commonFunction.js"></script>
<script type="text/javascript" src="/resources/js/diary/diaryCommon.js"></script>
<style>
	#DiaryContainer h3 {
		font-size: 2.2rem;
		text-align: center;
		backdrop-filter: blur(4px);
		background-color: rgba(255, 255, 255, 1);
		border-radius: 50px;
		box-shadow: 35px 35px 68px 0px rgba(145, 192, 255, 0.5), inset -8px -8px 16px 0px rgba(145, 192, 255, 0.6), inset 0px 11px 28px 0px rgb(255, 255, 255);
		width: 370px;
		padding-top: 35px;
		padding-bottom: 35px;
		margin: auto;
		margin-bottom: 40px;
	}
	#DiaryContainer {
		min-height: 790px;
	}
	#DiaryContainer .custom-pagination {
		max-width:302px;
		margin: auto;
	}
	#DiaryContainer .custom-pagination .pagination {
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
	#modBtn, #delBtn {
		display:inline-block;
		text-align: center;
		background: #006DF0;
		padding: 10px 10px;
		font-size: 1rem;
		border: none;
		color: #fff;
		font-weight: 700;
		border-radius: 5px;
		margin-right:15px;
	}
	#modBtn {
		background: #666;
		color:#fff;
	}
	#delBtn {
		background: #111;
		color:#fff;
	}
	#modBtn:hover, #delBtn:hover {
		background: #ffd77a;
		transition: all 1s ease;
		color:#333;
		font-weight:600;
	}
	.custom-datatable-overright table tbody tr.none-tr td:hover {
		background: #fff!imporant;
	}
	.singleline-ellipsis {
		width: 200px;
		overflow:hidden; 
		text-overflow:ellipsis; 
 		white-space:nowrap; 
 		cursor: pointer;
	}
	.emotionImg {
		width: 40px;
		height: 40px;
	}
</style>
<script>
	function fn_search(currentPage) {
		console.log("curr ==> " + currentPage);
		var currentPage = currentPage;
		var keyword = $("input[name='keyword']").val();
		var size = 10;
		let formData = new FormData();
		let startDate = $("#startDate").val();
		let endDate = $("#endDate").val();
		let searchCondition = $("#searchCondition").val();
		
		if (currentPage == null || currentPage == '') { currentPage = 1; }
		if (keyword == null || keyword == '') { keyword=""; }
		
		formData.append("mberId", `${mberVO.mberId}`);			// 작성자 아이디
		formData.append("startDate", startDate);				// 시작일
		formData.append("endDate", endDate);					// 종료일
		formData.append("searchCondition", searchCondition);	// 검색 조건
		formData.append("keyword", keyword);					// 검색어
		formData.append("currentPage", currentPage);			// 현재 페이지
		formData.append("size", size);							// 출력될 목록 수
		
		// 일기장 목록 불러오기
		$.ajax({
			type: "post",
			url: "/diary/getDiaryList",
			processData: false,
			contentType: false,
			data: formData,
			dataType: "json",
			beforeSend:function(xhr){
    			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
    		},
			success: function(result) {
				let html = "";
				
				if (result.content == 0 || result.content == null) {
					html += `<tr data-index="0" class="none-tr">
								<td style="text-align: center;" colspan="6" >작성된 일기가 없습니다.</td>
							</tr>`;
				} else {
					for( let i = 0; i < result.content.length; i++ ) {
						let res = result.content[i];
						let resLeng = res.answerVOList.length;
						
						html += `<tr data-index="0" data-code="code" class="detailGo">
									<td style="">\${res.rnum}</td>
									<td style="">
										<div id="diaryTitle" data-ntt-code="\${res.nttCode}" style="cursor: pointer;">`;
						html += 			fn_emotionImg(res.nttAtchFileCode);
						html += 			` \${res.nttNm}
										</div>
									</td>
									<td style="">` + dateFormat(new Date(res.nttWritngDt)) + `</td>
									<td style="">\${res.wethr}</td>
									<td style="">\${res.mberNm}</td>`;
									
								if (resLeng > 0) {
									html += `<td class="singleline-ellipsis">\${res.answerVOList[resLeng-1].answerCn}</td>`;
								} else {
									html += `<td>-</td>`;								
								}
									
								html += `</tr>`;
					} // end for
				} // end else

				$("#diaryListDiv").html(html);
				$(".custom-pagination").html(result.pagingArea);	// 페이징 처리
			} // end success
		});
	}
	
	$(function(){
		
		fn_search(1);
		
		// 제목 클릭
		$(document).on("click", "#diaryTitle", function() {
			let nttCode = $(this).data("nttCode");
			location.href = "/diary/diaryViewDetail?nttCode=" + nttCode;
		});
		
		// 시작 날짜를 클릭하면 종료 날짜의 최소 시작 날짜가 시작 날짜로 설정되는 함수
		$("#startDate").on("input", function(){
			let startDate = $("#startDate").val();
			$("#endDate").attr("min", startDate);
		});
		
		//input태그에서 엔터시 검색버튼누르기
		$("#keyword").on("keypress", function(event) {
			if (event.key === "Enter") {
				event.preventDefault();
				$("#searchBtn").click();
			}
		});
		
		// 일기 쓰기
		$("#insertBtn").on("click", function() { location.href = "/diary/addDiary"; });
		
		// 검색 버튼
		$("#searchBtn").on("click", function() { fn_search(1); });
	});
</script>

<!-- 수정/삭제 이동 form -->
<form id="frm" method="post">
	<input type="hidden" name="nttCode"/>
	<sec:csrfInput/>
</form>

<div id="DiaryContainer">
	<div class="sparkline13-list">
		<h3>
			<img src="/resources/images/classRoom/diary/titleImg1.png" style="width:50px; display:inline-block; vertical-align:middel;">
			일기장
			<img src="/resources/images/classRoom/diary/titleImg2.png" style="width:50px; display:inline-block; vertical-align:middel;">		
		</h3>
		<div class="sparkline13-graph">
			<div class="datatable-dashv1-list custom-datatable-overright">
				<div class="bootstrap-table">
					<div class="fixed-table-toolbar">
						<sec:authorize access="hasRole('ROLE_A01001')">
							<div class="pull-left button">
								<button type="button" id="insertBtn">일기 쓰기</button>
							</div>
						</sec:authorize>
						<!-- 검색어 시작 -->
						<table class="pull-right" >
							<tr>
								<td class="input-daterange input-group" id="datepicker">
									<input type="date" class="form-control" id="startDate" name="startDate"/>
									<span class="input-group-addon">to</span>
									<input type="date" class="form-control" id="endDate" name="endDate"/>
								</td>
								<td>
									<select name="searchCondition" id="searchCondition" name="searchCondition">
										<option value="searchAll" selected>전체</option>
										<option value="searchTitle">제목</option>
										<option value="searchWrter">작성자</option>
									</select>
									<input class="searchForm" type="text" placeholder="" name="keyword" value="${keyword}">
									<button type="submit" id="searchBtn">검색</button>
								</td>
							</tr>
						</table>
						<!-- 검색어 끝 -->
					</div>
					<div class="fixed-table-container" style="padding-bottom: 0px;">
						<div class="fixed-table-body">
							<table id="table" data-toggle="table"
								data-search="true" data-show-columns="true"
								data-show-pagination-switch="true" data-show-refresh="true"
								data-key-events="true" data-show-toggle="true"
								data-resizable="true" data-cookie="true"
								data-cookie-id-table="saveId" data-show-export="true"
								data-click-to-select="true" data-toolbar="#toolbar"
								class="table table-hover JColResizer">
								<thead>
									<tr style="font-size:1rem;">
										<th style="width: 10%;" tabindex="0">
											<div class="th-inner ">번호</div>
											<div class="fht-cell"></div>
										</th>
										<th style="width: 40%;" tabindex="0">
											<div class="th-inner ">제목</div>
											<div class="fht-cell"></div>
										</th>
										<th style="width: 10%;" tabindex="0">
											<div class="th-inner ">작성 일자</div>
											<div class="fht-cell"></div>
										</th>
										<th style="width: 10%;" tabindex="0">
											<div class="th-inner ">날씨</div>
											<div class="fht-cell"></div>
										</th>
										<th style="width: 10%;" tabindex="0">
											<div class="th-inner ">작성자</div>
											<div class="fht-cell"></div>
										</th>
										<th style="width: 10%;" tabindex="0">
											<div class="th-inner ">선생님 말씀</div>
											<div class="fht-cell"></div>
										</th>
									</tr>
								</thead>
								<tbody id="diaryListDiv">
								</tbody>
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