<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
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
</style>
<script>
	const header = "${_csrf.headerName}";
	const token = "${_csrf.token}"; 
	var currentPage = "${param.currentPage}";
	var clasCode = "${clasCode}";
	var schulCode = "${schulCode}";
	var size = 10;
window.onload = function() {
	if(currentPage == "") currentPage = "1"; 

	//기본조회 
	fn_search(1);
}

function fn_search(page) {
		//가입신청 대기목록 불러오는 ajax 시작//
		let data = {
			"schulCode":schulCode,
			"clasCode":clasCode,
			"currentPage" : currentPage,
			"size":size
		}
		console.log("data",data);
		
		$.ajax({
			url: "/class/classJoinReqListAjax",
			contentType:"application/json;charset=utf-8",
			data:JSON.stringify(data),
			type : "post",
			dataType:"json",
			beforeSend:function(xhr){
					xhr.setRequestHeader(header,token);
				},
			success:function(result){				
				console.log("result!!: ", result);
				//참고 -> location.href = `/school/dataRoomDetail?schulCode=\${schulCode}&nttCode=\${result}`;
				const classJoinReqListBody = document.querySelector("#classJoinReqListBody");
				var str = "";
				$.each(result.content, function(idx, clasStdntVO){
					str += `<tr> 
							<td>\${clasStdntVO.rnum}</td>
							<td>\${clasStdntVO.schulNm}</td>
							<td>\${clasStdntVO.grade}</td>
							<td>\${clasStdntVO.clasInNo}</td>
							<td>\${clasStdntVO.mberNm}</td>
							<td>
								<i class="fa fa-check edu-checked-pro" aria-hidden="true" id="accept" onclick="classJoinChk('accept', '\${clasStdntVO.mberId}')"></i>
								&nbsp;&nbsp;
								<i class="fa fa-times edu-danger-error" aria-hidden="true" id="reject" onclick="classJoinChk('reject', '\${clasStdntVO.mberId}')"></i>
							</td>
							</tr>`;
				}); //반복문 끝
				classJoinReqListBody.innerHTML = str;
				document.getElementById("divPaging").innerHTML = result.pagingArea;
			}
		});
	}
//가입 신청 처리
function classJoinChk(action, mberId) {
	
	var cmmnClasPsitnSttus; //공통 반 소속 상태(A03) 
	var clasStdntJoinDate; // 가입일
	
	if(action === "accept"){ //수락시
		Swal.fire({
			icon : "success",
			title: "가입 수락되었습니다"
		});
		cmmnClasPsitnSttus = "A03101"; //성공
		clasStdntJoinDate = new Date().toLocaleDateString('en-GB').split('/').reverse().join('-'); //yy-MM-dd형식의 문자열 , 가입일 등록
		// console.log("수락")
	}else if(action === "reject"){
		Swal.fire({
			icon : "success",
			title: "가입 거절되었습니다"
		});
		cmmnClasPsitnSttus = "A03103"; //거절
		// console.log("거절")
	}
	console.log("cmmnClasPsitnSttus",cmmnClasPsitnSttus);
	console.log("mberId",mberId);

	let data = {
		"cmmnClasPsitnSttus":cmmnClasPsitnSttus,
		"mberId":mberId,
		"schulCode":schulCode,
		"clasCode":clasCode,
		"clasStdntJoinDate":clasStdntJoinDate
	}
	console.log("data",data);

	$.ajax({
        url: "/class/classJoinAjax",
		contentType:"application/json;charset=utf-8",
		type: "POST",
        data: JSON.stringify(data),
		dataType: "json", // 반환되는 데이터의 타입을 명시
		beforeSend:function(xhr){
				xhr.setRequestHeader(header,token);
			},
        success: function(result) {
            console.log("AJAX 호출 성공");
			fn_search(1);
        }

	});//ajax끝
}
//가입 신청 끝
</script>
<div class="sparkline8-list">
	<div class="sparkline8-hd">
		<div class="main-sparkline8-hd">
			<h3>
			<img src="/resources/images/classRoom/wait1.png" style="width:50px; display:inline-block; vertical-align:middel;">
				가입 대기
			<img src="/resources/images/classRoom/wait2.png" style="width:50px; display:inline-block; vertical-align:middel;">		
		</h3>
		</div>
	</div>
	<div class="row">
	</div>
	<div class="sparkline8-graph">
		<div class="static-table-list modal-area-button ">
			<table class="table">
				<thead>
					<tr>
						<th>순번</th>
						<th>학교</th>
						<th>학년</th>
						<th>번호</th>
						<th>이름</th>
						<th>가입</th>
					</tr>
				</thead>
				<tbody id="classJoinReqListBody">
					
				</tbody>
			</table>
		</div>
	</div>
	<div class="pagination text-center" style="width:100%;" id="divPaging"></div>
</div>