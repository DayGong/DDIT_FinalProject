<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
#TaskContainer h3{
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
#TaskContainer{
	min-height: 790px;
}
#TaskContainer .custom-pagination{
	max-width:302px;
	margin: auto;
}
#TaskContainer .custom-pagination .pagination {
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

.add-product {
    display: flex;
    align-items: center;
    justify-content: space-between;
}

.taskBtn {
    text-align: right;
}

.taskBtn button {
    margin: 10px;
}

.taskStatus{
	padding: 2px 7px;
	text-align: center;
/* 	background-color: #f9e09a; */
	background: rgb(31, 129, 255);
    color: rgb(255, 255, 255);
	width: 60px;
	display: inline-block;
    border-radius: 10px;
}
</style>
<script type="text/javascript" src="/resources/js/commonFunction.js"></script>
<script type="text/javascript" src="/resources/js/jquery.min.js" ></script>
<script type="text/javascript">
// 전역 변수
var currentPage = "${param.currentPage}";
var keyword = "";
var clasCode = "${CLASS_INFO.clasCode}";

function fn_search(currentPage) {
	var keyword = $("#keyword").val();
    
//     if(currentPage == "") currentPage = "1";
    
    var data = {
		"keyword": keyword,
		"currentPage": currentPage,
		"clasCode": clasCode
    };
    
    // 과제 리스트 불러오기
    $.ajax({
		url:"/task/taskListAjax",
		contentType:"application/json;charset=utf-8",
		data:JSON.stringify(data),
		type:"post",
		dataType:"json",
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success: function(res){
	        var str = "";
	        var total = res.total;
	        var currentPage = res.currentPage;
			console.log("res", res);
			console.log("pagingArea", res.pagingArea);
			
			// 과제 리스트가 있는 경우
			if(res.content.length > 0){
				$("#noTaskDiv").html("");
				$("#divPaging").html("");
				
				$.each(res.content, function(idx, taskVO){
			        var taskCode = taskVO.taskCode;
			        str += "<tr>";
			        str += "<td>" + (total - ((currentPage - 1) * 10 + idx)) + "</td>";
			        str += "<td><a href='/task/taskDetail?taskCode=" + taskCode + "&clasCode=" + clasCode + "'>"+taskVO.taskSj + "</a></td>";
			        str += "<td>" + dateFormat(taskVO.taskBeginDt) + "</td>";
			        str += "<td>" + dateFormat(taskVO.taskEndDt) + "</td>";
			        str += "<td>" + taskVO.hrtchrVO.memberVO.mberNm + "</td>";
			        str += "<td>"
			        if(prevToday(dateFormat(taskVO.taskEndDt))){
			        	str += "<span class='taskStatus'>진행 중</span>";
			        }else{
			        	str += "<span class='taskStatus' style='background-color: #666'>마감</span>";
			        }
			        str += "</td>";
			        str += "<td>" + taskVO.taskCnt + "</td>";
			        str += "<td>";
		             
		            if(taskVO.atchFileCode == null){
						str += "";
		            }else{
						str += "<i class='fa fa-paperclip'></i>";
		            }
		            
		            str += "</td>";
		            str += "</tr>";
				});
				
		        $('#taskBody').html(str);
		        $("#divPaging").html(res.pagingArea);
		        
			// 과제 리스트가 없는 경우
			}else{
		        $('#taskBody').html("");
		        
				str += "<div id='noTaskDiv'>";
				
				// 검색 키워드 유무에 따라 출력 메시지 변경
				if(keyword == ""){
					str += "<p style='text-align: center; font-size: 15px;'>등록된 과제가 없습니다.</p></div>";
				}else{
					str += "<p style='text-align: center; font-size: 15px;'>검색 결과가 없습니다.</p></div>";
				}
				
				$("#noTaskDiv").html(str);
				$("#divPaging").html("");
			}
		}
	});
}

$(function(){
   // 과제 리스트 불러오기
   fn_search(1);
   
    // 과제 게시판 검색
   $("#search").on("click", function(){
      fn_search(1);
   });
    
    // 과제 등록하기
   $("#insertBtn").on("click", function(){
      location.href = "/task/taskInsertForm?clasCode=" + clasCode;
   });
});
</script>

<div id="TaskContainer">
	<div class="sparkline13-list">
		<h3>
		   <img src="/resources/images/classRoom/task/taskCheck.png" style="width:50px; display:inline-block; vertical-align:middel;">
			과제 게시판
		   <img src="/resources/images/classRoom/task/pencil.png" style="width:50px; display:inline-block; vertical-align:middel;">      
		</h3>
		<div class="sparkline13-graph">
			<div class="datatable-dashv1-list custom-datatable-overright">
				<div class="bootstrap-table">
					<div class="fixed-table-toolbar">
						<div class="pull-left button">
						 <c:if test="${USER_INFO.vwMemberAuthVOList[0].cmmnDetailCode == 'ROLE_A14002'}">
		                     <input type="button" id="insertBtn" value="과제 등록">
						 </c:if>
						</div>
						<div class="pull-right search" style="margin-bottom: 20px;">
							<input class="searchForm" type="text" placeholder="" id="keyword" name="keyword" value="${keyword}">
							<button type="button" id="searchBtn" onclick="fn_search(1)">검색</button>
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
										<th style="width: 7%;" data-field="id" tabindex="0">
											<div class="th-inner ">번호</div>
											<div class="fht-cell"></div>
										</th>
										<th style="width: 30%;" data-field="name" tabindex="0">
											<div class="th-inner ">제목</div>
											<div class="fht-cell"></div>
										</th>
										<th style="width: 12%;" data-field="email" tabindex="0">
											<div class="th-inner ">등록일</div>
											<div class="fht-cell"></div>
										</th>
										<th style="width: 12%;" data-field="phone" tabindex="0">
											<div class="th-inner ">마감일</div>
											<div class="fht-cell"></div>
										</th>
										<th style="width: 13%;" data-field="phone" tabindex="0">
											<div class="th-inner ">작성자</div>
											<div class="fht-cell"></div>
										</th>
										<th style="width: 10%;" data-field="id" tabindex="0">
											<div class="th-inner ">상태</div>
											<div class="fht-cell"></div>
										</th>
										<th style="width: 7%;" data-field="action" tabindex="0">
											<div class="th-inner ">조회수</div>
											<div class="fht-cell"></div>
										</th>
										<th style="width: 10%;" data-field="action" tabindex="0">
											<div class="th-inner ">첨부파일</div>
											<div class="fht-cell"></div>
										</th>
									</tr>
								</thead>
								<tbody id="taskBody">
							
								</tbody>
							</table>
						</div>
						<div id="noTaskDiv">
						
						</div>
						<div class="custom-pagination" id="divPaging">
               
               			</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>