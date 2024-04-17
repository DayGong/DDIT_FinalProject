<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
h3{
	font-size: 2.2rem;
	text-align: center;
	margin-top: 60px;
	backdrop-filter: blur(4px);
	background-color: rgba(255, 255, 255, 1);
	border-radius: 50px;
	box-shadow: 35px 35px 68px 0px rgba(145, 192, 255, 0.5), inset -8px -8px 16px 0px rgba(145, 192, 255, 0.6), inset 0px 11px 28px 0px rgb(255, 255, 255);
	width: 370px;
	padding-top: 35px;
	padding-bottom: 35px;
	margin: auto;
	margin-top: 50px;
	margin-bottom: 40px;
}

.pagination {
display: inline-flex;
padding-left: 0;
margin: 20px 0;
border-radius: 4px;
}
</style>
<script>
	const header = "${_csrf.headerName}";
	const token = "${_csrf.token}";
	//const : 상수형 변수(재선언 불가, 데이터 변경 불가)
	var clasCode = "${clasCode}";
	const schulCode = "${schulCode}";
	var currentPage = "${param.currentPage}";
	var size = 10;
	console.log("clasCode",clasCode);
	console.log("schulCode",schulCode);

	window.onload = function() {
		if(currentPage == "") currentPage = "1"; 
		
		const classStdntListAjax = function(currentPage){
		//기본조회
		let data = {
			"clasCode":clasCode,
			"schulCode":schulCode,
			"currentPage":currentPage,
			"size":size
		}
		$.ajax({
				url: "/class/classStdntListAjax",
				contentType:"application/json;charset=utf-8",
				data:JSON.stringify(data),
				type : "post",
				dataType:"json",
				beforeSend:function(xhr){
						xhr.setRequestHeader(header,token);
					},
				success:function(result){	
					console.log("result~~",result);			
					const classStudListBody = document.querySelector("#classStudListBody");
					let html = "";	//목록 초기화
					$.each(result.content, function(idx, clasStdntVO){
						html += `<tr> 
								<td>\${clasStdntVO.rnum}</td>
								<td>\${clasStdntVO.mberNm}</td>
								<td>\${clasStdntVO.clasInNo}</td>
								<td>\${clasStdntVO.moblphonNo}</td>
								<td>\${clasStdntVO.birthDate}</td>
								</tr>`;
					}); //반복문 끝 
					classStudListBody.innerHTML = html;
					//$("#divPaging").html(result.pagingArea);
					document.getElementById("divPaging").innerHTML = result.pagingArea;
				}
			}); //ajax끝
		}
		classStdntListAjax(currentPage);	
	}//window.onload끝
</script>


<div class="sparkline8-list">
	<div class="sparkline8-hd">
		<div class="main-sparkline8-hd">
			<h3>
				<img src="/resources/images/classRoom/stdent1.png" style="width:50px; display:inline-block; vertical-align:middel;">
					학생 목록
				<img src="/resources/images/classRoom/stdent2.png" style="width:50px; display:inline-block; vertical-align:middel;">
			</h3>
			
		</div>
	</div>
	<div class="sparkline8-graph">
		<div class="static-table-list">
			<table class="table">
				<thead>
					<tr>
						<th>순번</th>
						<th>이름</th>
						<th>반번호</th>
						<th>전화번호</th>
						<th>생일</th>
					</tr>
				</thead>
				<tbody id="classStudListBody">
			</table>
		</div>
	</div>
	<div class="pagination text-center" style="width:100%;" id="divPaging"></div>

</div>