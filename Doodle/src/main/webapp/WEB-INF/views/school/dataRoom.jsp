<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script>
//전역 변수
var currentPage = "${param.currentPage}";
var keyword = "";
var schulCode = "${schulCode}";

//검색
function fn_search(page) {
    var keyword = $("#keyword").val();
    
    var data = {
        "schulCode": schulCode,
        "currentPage": page, // page 매개변수 사용
        "keyword": keyword
    }

    console.log("data:", data);

    $.ajax({
        url: "/school/dataRoomAjax",
        type: "post",
        data: JSON.stringify(data),
        contentType: "application/json;charset=utf-8",
        dataType: "json",
        beforeSend: function(xhr) {
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
        },
        success: function(result) {
            console.log("result.pagingArea", result.pagingArea);

            if (result.total == 0) {
                $("#keyword").val('');

				var	str = `<tr data-index="0" class="none-tr">
								<td style="text-align: center;" colspan="6" >조회된 자료가 없습니다.</td>
							</tr>`;
                
                $("#dataBody").html(str);
            } else {
                var str = ""; // 결과를 누적하기 위해 빈 문자열로 초기화

                $.each(result.content, function(idx, nttVO) {
					console.log("nttVO[" + idx + "] : ", nttVO);
					str += "<tr onclick=\"location.href='/school/dataRoomDetail?schulCode=" +nttVO.schulCode+ "&nttCode=" + nttVO.nttCode + "'\" style=\"cursor: pointer;\">";
					str += "<td>" + nttVO.rnum + "</td>";
					str += "<td>" + nttVO.nttNm + "</td>";
					str += "<td>" + nttVO.mberNm + "</td>";
					str += "<td>" + dateFormat(nttVO.nttWritngDt) + "</td>";
					str += "<td>" + nttVO.nttRdcnt + "</td>";
					str += "</tr>";
				});


                $("#dataBody").html(str);
            }

            $("#divPaging").html(result.pagingArea);
        },
        error: function(xhr, status, error) {
            console.error(status, error);
        }
    });
}


$(function(){
		fn_search(1);
		
		//input태그에서 엔터시 검색버튼누르기
		var input = $("#keyword");

		  input.on("keypress", function(event) {
		      if (event.key === "Enter") {
		          event.preventDefault();
		          $("#btnSearch").click();
		      }
		  });

		currentPage = "1";
		// 자료실 검색
		$("#btnSearch").on("click",function(){
			fn_search(1);
		});
		
		//등록버튼
		$("#createBtn").on("click", function() {
			location.href = "/school/dataRoomCreate"; //GET방식
		});
		
	})
// 날짜 포맷 함수(ex: 2024-03-12)
function dateFormat(date){
   var selectDate = new Date(date);
   var d = selectDate.getDate();
   var m = selectDate.getMonth() + 1;
   var y = selectDate.getFullYear();
   
   if(m < 10) m = "0" + m;
   if(d < 10) d = "0" + d;
   
   return y + "-" + m + "-" + d; 
}
	
	
</script>
<style>
#dataRoomContainer h3{
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
#dataRoomContainer{
		min-height: 790px;
}
#dataRoomContainer .custom-pagination{
	max-width:302px;
	margin: auto;
}
.searchForm{
		height: 40px;
		border: 1px solid #ddd;
		border-radius: 5px;
		padding: 15px 20px;
}
#btnSearch,#createBtn{
		background: #333;
		height: 40px;
		border: none;
		padding: 10px 15px;
		border-radius: 10px;
		font-family: 'Pretendard' !important;
		font-weight: 600;
		color: #fff;
}
#btnSearch:hover, #insertBtn:hover{
	background: #ffd77a;
	color:#333;
	transition:all 1s;
	font-weight: 700;
}
#createBtn{
	background: #006DF0;
}

.fixed-table-body tbody tr.none-tr:hover {
    background: #f5f5f5!important;
}


</style>

<div id="dataRoomContainer">
	<div class="sparkline13-list">
		<h3>
			<img src="/resources/images/school/dataRoom1.png" style="width:50px; display:inline-block; vertical-align:middel;">
				자료실
			<img src="/resources/images/school/dataRoom2.png" style="width:50px; display:inline-block; vertical-align:middel;">		
		</h3>
		<div class="sparkline13-graph">
			<div class="fixed-table-toolbar">
				<div class="pull-left button">
					<c:if test="${USER_INFO.vwMemberAuthVOList[0].cmmnDetailCode == 'ROLE_A14003'}">
						<button type="button" id="createBtn">게시글 등록</button>
					</c:if>
				</div>
				<div class="pull-right search" style="margin-bottom: 20px;">
						<!-- 검색어 시작 -->
						<input class="searchForm" type="text" placeholder="검색어를 입력해 주세요." name="keyword" id="keyword" value="${keyword}">
						<button type="submit" id="btnSearch">검색</button>
						<!-- 검색어 끝 -->
				</div>
			</div>
			<div class="fixed-table-body">
				<table class="table">
					<thead>
						<tr>
							<th>순번</th>
							<th>제목</th>
							<th>작성자</th>
							<th>등록일</th>
							<th>조회수</th>
						</tr>
					</thead>
					<tbody id="dataBody">
						<%-- <c:forEach var="nttVO" items="${nttVOList}" varStatus="stat">
							<tr onclick="location.href='/school/dataRoomDetail?nttCode=${nttVO.nttCode}'"
								style="cursor: pointer;">
								<td>${nttVO.rnum}</td>
								<td>${nttVO.nttNm}</td>
								<td>${nttVO.mberNm}</td>
								<td><fmt:formatDate value="${nttVO.nttWritngDt}"
										pattern="yyyy-MM-dd" /></td>
							</tr>
						</c:forEach> --%>
					</tbody>
				</table>
			</div>
			<!-- 페이징을 보여줄 html;값 가져오기 -->
			<div class="pagination text-center" style="width:100%;" id="divPaging"></div>
		</div>
	</div>
</div>