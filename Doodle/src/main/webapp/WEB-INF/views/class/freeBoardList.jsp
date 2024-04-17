<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script>
$(function(){
	$("#studentFreeBoardLi").css("display", "block");
	$("#teacherFreeBoardLi").css("display", "block");
	$("#parentFreeBoardLi").css("display", "block");
	//컨트롤러에서 던진 currentPage 가져오기
	var currentPage = "${param.currentPage}";
	//디폴트 값 1로 설정
	if(currentPage == "") currentPage = "1";
	//키워드 디폴트 값 화이트스페이스로 설정
	var keyword = "";

	$("#insertBtn").on("click", function(){
		location.href="/freeBoard/create"; 
	});
	
	$('#searchCondition').val('${searchCondition}');
	
	$('tr[data-code="code"]').on("click",function(){
		var nttCode  = $(this).data("id");
		$("#nttCode").val(nttCode);
		console.log("inputNttCode->", $("#nttCode").val());
		$("#freefrm").submit();
	});
	
});
</script>
<style>
	#FreeBoardContainer h3{
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
	#FreeBoardContainer{
		min-height: 790px;
	}
	#FreeBoardContainer .custom-pagination{
		max-width:302px;
		margin: auto;
	}
	#FreeBoardContainer .custom-pagination .pagination {
		 width: max-content;
	}
	.searchForm{
		height: 40px;
		border: 1px solid #ddd;
		border-radius: 5px;
		padding: 15px 20px;
	}
	
	#searchBtn,#insertBtn{
		background: #333;
		height: 40px;
		border: none;
		padding: 10px 15px;
		border-radius: 10px;
		font-family: 'Pretendard' !important;
		font-weight: 600;
		color: #fff;
	}
	#searchBtn:hover, #insertBtn:hover{
		background: #ffd77a;
		color:#333;
		transition:all 1s;
		font-weight: 700;
	}
	#insertBtn{
		background: #006DF0;
	}
	
	#searchCondition{
		height: 40px;
		border: 1px solid #ddd;
		border-radius: 5px;
		padding-left: 10px;
	}
	
	.custom-datatable-overright table tbody tr.none-tr td:hover{
		background: #fff!imporant;
	}
</style>
<div id="FreeBoardContainer">
	<form id="freefrm" method="post" action="/freeBoard/freeBoardDetailView">
		<input type="hidden" value="" id="nttCode" name="nttCode">
		<sec:csrfInput />
	</form>
	<div class="sparkline13-list">
		<h3>
			<img src="/resources/images/classRoom/freeBrd/freeBoardTit.png" style="width:50px; display:inline-block; vertical-align:middel;">
				자유게시판
			<img src="/resources/images/classRoom/freeBrd/freeBoardTitChat.png" style="width:50px; display:inline-block; vertical-align:middel;">		
		</h3>
		<div class="sparkline13-graph">
			<div class="datatable-dashv1-list custom-datatable-overright">
				<div class="bootstrap-table">
					<div class="fixed-table-toolbar">
						<div class="pull-left button">
							<button type="button" id="insertBtn">게시글 등록</button>
						</div>
						<div class="pull-right search" style="margin-bottom: 20px;">
							<form action="/freeBoard/freeBoardList" method="get">
								<!-- 검색 조건 시작-->
								<select name="searchCondition" id="searchCondition">
<%-- 								방법1)<option value="" <c:if test="${searchCondition eq ''}">selected="selected"</c:if>>전체</option> --%>
<%-- 									<option value="titl" <c:if test="${searchCondition eq 'titl'}">selected="selected"</c:if>>제목</option> --%>
<%-- 									<option value="cntn" <c:if test="${searchCondition eq 'cntn'}">selected="selected"</c:if>>내용</option> --%>
<%-- 									<option value="titlCntn" <c:if test="${searchCondition eq 'titlCntn'}">selected="selected"</c:if>>제목 + 내용</option> --%>
<%-- 									<option value="writ" <c:if test="${searchCondition eq 'writ'}">selected="selected"</c:if>>작성자</option> --%>
<!-- 								방법2) -->
									<option value="">전체</option>
									<!-- db쿼리단에서 value값으로 if문 쓰기위해  조건마다 value값 입력 -->
									<option value="titl">제목</option>
									<option value="cntn">내용</option>
									<option value="titlCntn">제목 + 내용</option>
									<option value="writ">작성자</option>
								</select>
								<!-- 검색 조건 끝-->
								<!-- 검색어 시작 -->
								<input class="searchForm" type="text" placeholder="" name="keyword" value="${keyword}">
								<button type="submit" id="searchBtn">검색</button>
								<!-- 검색어 끝 -->
							</form>
						</div>
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
										<th style="width: 10%;" data-field="id" tabindex="0"><div
												class="th-inner ">번호</div>
											<div class="fht-cell"></div></th>
										<th style="width: 40%;" data-field="name" tabindex="0"><div
												class="th-inner ">제목</div>
											<div class="fht-cell"></div></th>
										<th style="width: 20%;" data-field="email" tabindex="0"><div
												class="th-inner ">작성일</div>
											<div class="fht-cell"></div></th>
										<th style="width: 20%;" data-field="phone" tabindex="0"><div
												class="th-inner ">작성자</div>
											<div class="fht-cell"></div></th>
										<th style="width: 10%;" data-field="action" tabindex="0">
											<div class="th-inner ">조회수</div>
											<div class="fht-cell"></div>
										</th>
									</tr>
								</thead>
								<tbody>
									<!-- 게시글 목록 처리를 위해 if/elseif/else역할을 하는 c:태그활용 -->
									<c:choose>
										<c:when test="${fn:length(nttVOList) > 0}">
											<c:forEach items="${nttVOList}" var="freeNttVO" varStatus="status">
												<tr data-index="0" data-code="code" data-id="${freeNttVO.nttCode}"class="detailGo">
													<td style="">${total - ((currentPage - 1) * 10 + status.index)}</td>
													<td style="">
														<a href="javascript:void(0)" class="editable editable-click">
															${freeNttVO.nttNm}
														</a>
													</td>
													<td style="">
														<a href="javascript:void(0)" class="editable editable-click " data-date="date">
															<fmt:formatDate value="${freeNttVO.nttWritngDt}" pattern="yyyy-MM-dd" />
														</a>
														<!-- 날짜 문자열이 이상하게 나오기 때문에 변환하기위해서 fmt 사용 끝 -->
													</td>
													<td style="">
														<a href="javascript:void(0)"class="editable editable-click" data-mberId="${freeNttVO.mberId}">
															${freeNttVO.mberId}
														</a>
													</td>
													<td class="datatable-ct" style="">
														<a href="javascript:void(0)"class="editable editable-click" >
															${freeNttVO.nttRdcnt}
														</a>
													</td>
												</tr>
											</c:forEach>
										</c:when>
										
										<c:otherwise>
											<tr data-index="0" class="none-tr">
												<td style="text-align: center;" colspan="5" >조회된 결과가 없습니다.</td>
											</tr>
										</c:otherwise>
									
									</c:choose>
							
								</tbody>
							</table>
						</div>
						<!-- 페이징을 보여줄 html;값 가져오기 -->
						<div class="custom-pagination">
							<c:if test="${fn:length(nttVOList) > 0}">
								${pagingArea}
							</c:if>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>