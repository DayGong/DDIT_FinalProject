<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<style>
#FreeBoardContainer h3 {
	font-size: 2.2rem;
	text-align: center;
	backdrop-filter: blur(4px);
	background-color: rgba(255, 255, 255, 1);
	border-radius: 50px;
	box-shadow: 35px 35px 68px 0px rgba(145, 192, 255, 0.5), inset -8px -8px
		16px 0px rgba(145, 192, 255, 0.6), inset 0px 11px 28px 0px
		rgb(255, 255, 255);
	width: 370px;
	padding-top: 35px;
	padding-bottom: 35px;
	margin: auto;
	margin-bottom: 40px;
}

#FreeBoardContainer {
	min-height: 790px;
	margin-bottom: 65px;
}

#FreeBoardContainer .custom-pagination {
	max-width: 302px;
	margin: auto;
}

#FreeBoardContainer .custom-pagination .pagination {
	width: max-content;
}

.searchForm {
	height: 40px;
	border: 1px solid #ddd;
	border-radius: 5px;
	padding: 15px 20px;
}

#searchBtn, #insertBtn, #surveyFormDownBtn {
	background: #333;
	height: 40px;
	border: none;
	padding: 10px 15px;
	border-radius: 10px;
	font-family: 'Pretendard' !important;
	font-weight: 600;
	color: #fff;
}

#searchBtn:hover, #insertBtn:hover,#surveyFormDownBtn:hover {
	background: #ffd77a;
	color: #333;
	transition: all 1s;
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
	background: #fff!important;
}
.stat2{
	border-radius: 30px;
	cursor: default;
	display: inline-block;
	min-width: 59px;
	text-align: center;
	padding: 5px 10px;
	margin-left: 15px;
}
</style>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script>

var qustnrSttus ='';
function dateFormat(date){
	   var selectDate = new Date(date);
	   var d = selectDate.getDate();
	   var m = selectDate.getMonth() + 1;
	   var y = selectDate.getFullYear();
	   
	   if(m < 10) m = "0" + m;
	   if(d < 10) d = "0" + d;
	   
	   return y + "-" + m + "-" + d; 
}

$(document).ready(function(){
	fn_getSurveyPage(1);
});

function fn_getSurveyPage(currentPage) {

	
	var data = {
		"clasCode" : "${clasCode}",
		"schulCode" : "${schulCode}",
		"cmmnDetailCode" : "${cmmnDetailCode}",
		"keyword" : $("#keyword").val(),
		"searchCondition" : $("#searchCondition").val(),
		"currentPage" : currentPage
	};
	
	$.ajax({
		url:"/freeBoard/surveyListAjax",
		contentType:"application/json;charset=utf-8",
		data:JSON.stringify(data),
		type:"post",
		dataType:"json",
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success: function(res){
			
			$("#surveyFormDownBtn").on("click",function(){
				location.href="/freeBoard/surveyFormDownload";
			});
			

			var str ="";
			var total = res.total;
			var currentPage = res.currentPage;
			
			console.log("res.content -> ", res.content);	
			
			if(res.content == 0){
				str +=	"<tr style='text-align:center;'><td colspan='7' class='none' style='text-align:center!important;'><span>조회된 내용이 없습니다.</span></td></tr>"
				$("#surveyTbody").html(str);
				$("#divPaging").html(res.pagingArea);
			}else{
				$.each(res.content,function(idx,voteNdQustnrVO){
					var startDt = new Date(voteNdQustnrVO.voteQustnrBeginDt);
					var endDt = new Date(voteNdQustnrVO.voteQustnrEndDt);
					var todayDt = new Date();
					if(startDt > todayDt) {
						qustnrSttus = '예정';
					}else if(startDt <= todayDt && todayDt <= endDt) {
						qustnrSttus = '진행중';
					}else {
						qustnrSttus = '마감';
					}
					
					str +=	"<tr data-index='0' class='surbeyList'>";
					str +=		"<td style=''>"+ (total - ((currentPage - 1) * 10 + idx)) +"</td>";
					str += 		"<td style='' data-target='target'>";
					str +=			"<a href='javascript:void(0)' class='editable editable-click'>";
					str +=				voteNdQustnrVO.voteQustnrNm;
					str +=			"</a>";
					str +=			"<input type='hidden' class='voteQustnrCode' value='"+voteNdQustnrVO.voteQustnrCode+"'>"
					str +=		"</td>";
					str +=		"<td style=''>";
					str +=			"<a href='javascript:void(0)' class='editable editable-click'>";
					str +=				dateFormat(voteNdQustnrVO.voteQustnrBeginDt);
					str +=			"</a>";
					str +=		"</td>";
					str +=		"<td style=''>";
					str +=			"<a href='javascript:void(0)'class='editable editable-click'>";
					str +=				dateFormat(voteNdQustnrVO.voteQustnrEndDt);
					str +=			"</a>";
					str +=		"</td>";
					str +=		"<td style='' class='stat'>";
					str +=			"<a href='javascript:void(0)'class='editable editable-click stat2'>";
					str +=				qustnrSttus;
					str +=			"</a>";
					str +=		"</td>";
					str +=		"<td style=''>";
					str +=			"<a href='javascript:void(0)'class='editable editable-click'>";
					str +=				voteNdQustnrVO.mberId;
					str +=			"</a>";
					str +=		"</td>";
					str +=		"<td style=''>";
					str +=			"<a href='javascript:void(0)'class='editable editable-click'>";
					str +=				dateFormat(voteNdQustnrVO.writngDt);
					str +=			"</a>";
					str +=		"</td>";
					str +=	"</tr>";
					
					
					
					$("#surveyTbody").html(str);
					$("#divPaging").html(res.pagingArea);
					
				});
				
				
				$(".surbeyList").each(function(idx, item){
					var stat = $(item).find("a.stat2").text();
					var astat = $(item).find("a.stat2");
					if(stat=='마감'){
						astat.css("background","#666");
						astat.css("color","#fff");
					}
					if(stat=='예정'){
						astat.css("background","#ffd77a");
						astat.css("color","#444");
						astat.css("font-weight","700");
						
					}
					if(stat=='진행중'){
						astat.css("background","#1f81ff");
						astat.css("color","#fff");
					}
				});
				
			}
			
		
			
			$("#surveyTbody").on("click","[data-target='target']",function(){
				var voteQustnrCode = $(this).find('input').val();
				$("#voteQustnrCode").val(voteQustnrCode);
				var stat = $(this).closest("tr").find("td.stat").find("a.stat2");
				
				
				if(${USER_INFO.vwMemberAuthVOList[0].cmmnDetailCode == "ROLE_A14002" ||  USER_INFO.vwMemberAuthVOList[1].cmmnDetailCode == "ROLE_A14002"}){
				//action="/freeBoard/surveyDetailView"
				$("#surveyfrm").attr("action","/freeBoard/surveyUpdate").submit();	
				}else{
					if(stat.text()=='마감'){
						alertError("이미 마감된 설문입니다.");
						return;
					}else if(stat.text()=='예정'){
						alertError("아직 예정중인 설문입니다.");
						return;
					}
					$.ajax({
						url:"/freeBoard/survayChk",
						contentType:"application/json;charset=utf-8",
						data: voteQustnrCode,
						type:"post",
						dataType:"json",
						beforeSend:function(xhr){
							xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
						},
						success: function(res){
							if(res > 0){
								alertError("이미 응답한 설문입니다.");
							}else {
								$("#surveyfrm").submit();
							}
						}
					});
				}	
			});
		}
	});	
}

function fn_surveyPaging(item, currentPage) {
	if($(item).parent().hasClass("active")) {
		return;
	}
	fn_getSurveyPage(currentPage);
}
</script>

<div id="FreeBoardContainer">
	<form id="surveyfrm" method="post" action="/freeBoard/surveyDetailView">
		<input type="hidden" value="" id="voteQustnrCode" name="voteQustnrCode">
		<sec:csrfInput />
	</form>
	<div class="sparkline13-list">
		<h3>
			<img src="/resources/images/classRoom/freeBrd/survey.png"
				style="width: 50px; display: inline-block; vertical-align: middel;">
			설문 게시판 <img src="/resources/images/classRoom/freeBrd/vote.png" style="width: 50px; display: inline-block; vertical-align: middel;">
		</h3>
		<div class="sparkline13-graph">
			<div class="datatable-dashv1-list custom-datatable-overright">
				<div class="bootstrap-table">
					<div class="fixed-table-toolbar">
						<div class="pull-left button">
							<c:if test="${USER_INFO.vwMemberAuthVOList[0].cmmnDetailCode == 'ROLE_A14002' ||  USER_INFO.vwMemberAuthVOList[1].cmmnDetailCode == 'ROLE_A14002'}">
								<button type="button" class="surveyInsert" id="insertBtn" onclick="location.href='/freeBoard/surveyCreate'">
									설문 등록
								</button>
								<button type="button" id="surveyFormDownBtn">
									설문조사 양식 다운로드
								</button>
							</c:if>
							
						</div>
						<div class="pull-right search" style="margin-bottom: 20px;">
							<!-- 검색 조건 시작-->
							<select id="searchCondition">
								<option value="">전체</option>
								<option value="titl">제목</option>
								<option value="cntn">내용</option>
								<option value="titlCntn">제목 + 내용</option>
								<option value="writ">작성자</option>
							</select>
							<!-- 검색 조건 끝-->
							<!-- 검색어 시작 -->
							<input class="searchForm" type="text" placeholder="" id="keyword" value="">
							<button type="button" id="searchBtn" onclick="fn_getSurveyPage(1);">검색</button>
							<!-- 검색어 끝 -->
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
									<tr style="font-size: 1rem;">
										<th style="width: 10%;" data-field="id" tabindex="0">
											<div class="th-inner ">번호</div>
											<div class="fht-cell"></div>
										</th>
										<th style="width: 40%;" data-field="name" tabindex="0">
											<div class="th-inner ">제목</div>
											<div class="fht-cell"></div>
										</th>
										<th style="width: 10%;" data-field="email" tabindex="0">
											<div class="th-inner ">설문 시작일</div>
											<div class="fht-cell"></div>
										</th>
										<th style="width: 10%;" data-field="action" tabindex="0">
											<div class="th-inner ">설문 마감일</div>
											<div class="fht-cell"></div>
										</th>
										<th style="width: 10%;" data-field="action" tabindex="0">
											<div class="th-inner ">설문 진행 상태</div>
											<div class="fht-cell"></div>
										</th>
										<th style="width: 10%;" data-field="phone" tabindex="0">
											<div class="th-inner ">작성자</div>
											<div class="fht-cell"></div>
										</th>
										<th style="width: 10%;" data-field="phone" tabindex="0">
											<div class="th-inner ">작성일시</div>
											<div class="fht-cell"></div>
										</th>
									</tr>
								</thead>
								<tbody id="surveyTbody">
	
								</tbody>
							</table>
						</div>
						<div class="custom-pagination" id="divPaging"></div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>