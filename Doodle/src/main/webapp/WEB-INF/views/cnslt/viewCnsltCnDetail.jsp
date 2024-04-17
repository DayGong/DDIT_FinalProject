<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script type="text/javascript" src="/resources/js/commonFunction.js"></script>
<style>
#CnsltDetailContainer h3 {
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

.CnsltDiaryAll {
	width: 1400px;
	margin: auto;
	backdrop-filter: blur(10px);
	background-color: rgba(255, 255, 255, 1);
	border-radius: 50px;
	box-shadow: 0px 35px 68px 0px rgba(145, 192, 255, 0.5), inset 0px -6px 16px 0px rgba(145, 192, 255, 0.6), inset 0px 11px 28px 0px rgb(255, 255, 255);
	padding: 50px 80px;
}

.CnsltDiaryAll .cnslt-cont {
	border: 1px solid #ddd;
	border-radius: 10px;
	padding: 10px 20px;
	min-height: 83px;
	margin-top: 50px;
}

.CnsltDiaryAll .ConsltTit {
	display: flex;
	justify-content: space-between;
	position:relative;
}


.CnsltDiaryAll .title {
	font-size: 1.8rem;
	font-weight: 700;
	margin-top: 6px;
}

#goToCnsltDiaryList, #delBtn, #modBtn, #insertBtn {
	display:inline-block;
	text-align: center;
	background: #006DF0;
	padding: 15px 30px;
	font-size: 1rem;
	border: none;
	color: #fff;
	font-weight: 700;
	border-radius: 5px;
	margin-top: 30px;
	margin-bottom: 40px;
	margin-right:15px;
}

#delBtn {
	background: #111;
	color:#fff;
}

#modBtn {
	background: #666;
	color:#fff;
}

#insertBtn {
	background: #ffd77a;
	color:#333;
}

#goToCnsltDiaryList:hover,#modBtn:hover,#delBtn:hover, #insertBtn:hover {
	background: #ffd77a;
	transition: all 1s ease;
	color:#333;
}

.uploadList {
	background: rgb(178 202 255 / 25%);
	backdrop-filter: blur(4px);
	-webkit-backdrop-filter: blur(4px);
	border-radius: 10px;
	border: 1px solid rgba(255, 255, 255, 0.18);
	padding: 15px 20px;
	padding-bottom: 0px;
}

.uploadList ul {
	display: block;
}

.uploadList ul li {
	display: block;
	margin-bottom:5px;
}

.uploadList ul li.fileList {
	cursor: pointer;
}

.uploadList ul li.fileList:hover {
	text-decoration: underline;
}

.btn-zone {
	margin: auto;
	text-align: center;
}

table {
	padding-top: 10px;
	margin-bottom: 15px;
}

table tr {
	width: 30%;
}

table td {
	width: 40%;
	padding-left: 50px;
}

</style>
<script>
window.onload = function() {
	let title = `${cnsltVO.cnsltRequstCn}`;
	let stdntId = `${cnsltVO.stdntId}`;
	let stdntIdNm = `${cnsltVO.stdntIdNm}`;
	let cnsltCn = `${cnsltVO.cnsltCn}`;

	title = title.replace(/\n/gi, " ");			// 제목 줄바꿈 문자를 띄어쓰기로 변경
	$("#cnsltRequstCn").val(title);				// 띄어쓰기로 변경된 제목 출력
	$("input[name='cnsltCode']").val(`${cnsltVO.cnsltCode}`);	// 등록/수정용 form에 현재 cnsltCode 값 넣기
	
	if (cnsltCn == null || cnsltCn == '') {
		let html = `<input type="button" value="등록" id="insertBtn"/>`;
		
		$("#cnsltCn").html("상담 일지가 작성되지 않은 상담입니다. 상담 일지를 작성해주세요.");
		$("#mod-btn").html(html);
	} else {
		let html = `​​​​​​​​<input type="button" value="수정" id="modBtn"/>`;

		$("#cnsltCn").html(cnsltCn);				
		$("#mod-btn").html(html);
		$("input[name='cnsltCn']").val(cnsltCn);	// cnsltCn이 있으면 등록/수정용 form에 현재 cnsltCn 값 넣기
	}
	
	// 등록 버튼
	$("#insertBtn").on("click", function(){
		$("#frm").attr("action", "/cnslt/insertCnsltCn");
		$("#frm").submit();
	}); // end insertBtn click
	
	// 수정 버튼
	$("#modBtn").on("click", function() {
		$("#frm").attr("action", "/cnslt/insertCnsltCn");
		$("#frm").submit();
	}); // end modBtn click
	
	// 삭제 버튼
	$("#delBtn").on("click", function() {
		Swal.fire({
  	      title: `정말로 상담 일지를 삭제하시겠습니까?`,
  	      text: ' ',
  	      icon: 'warning',
  	      showCancelButton: true,
  	      confirmButtonColor: '#ff0000',
  	      cancelButtonColor: '#e0e0e0',
  	      confirmButtonText: '삭제하기',
  	      cancelButtonText: '닫기',
  	      reverseButtons: false, // 버튼 순서 거꾸로
		}).then((result) => {
			if (result.isConfirmed) {
				let cnsltCode = `${cnsltVO.cnsltCode}`;
				
				let formData = new FormData();
				formData.append("cnsltCode", cnsltCode);
				
				$.ajax({
					url: "/cnslt/delCnsltCn",
					processData: false,
					contentType: false,
					data: formData,
					type: "post",
					beforeSend: function(xhr) {
						xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
					},
					success: function(result) {
						let res = "성공";
						let icon = "success";
						
						if (result != 1) { res = "실패"; icon = "error"; }
						
						Swal.fire({
					      title: "상담 일지 삭제를 " + res + '하였습니다.',
					      text: ' ',
					      icon: icon
						}).then(result => { 
							location.href = "/cnslt/goToCnsltDiaryList";
						});
					}
				});
			}
		}) // end then
	}); // end delBtn click
	
	// 자녀 정보 보기 버튼
	$("#viewChildInfo").on("click", function() {
		let url="/cnslt/viewChildInfo?mberId=" + stdntId;
		let features = "scrollbars=yes, width=1000, height=1000, location=no, resizable=yes";
		let windowName = "자녀 정보";
		
		window.open(url, windowName, features);
	});
	
}
</script>
<!-- 등록/수정/삭제 이동 form -->
<form id="frm" method="post">
	<input type="hidden" name="cnsltCode"/>
	<sec:csrfInput/>
</form>

<!-- 본문 시작 -->
<div id="CnsltDetailContainer">
	<h3>
		<img src="/resources/images/consultation/cnsltTitleImg.png" style="width:50px; display:inline-block; vertical-align:middel;">
		상담 일지
		<img src="/resources/images/consultation/cnsltTitleImg2.png" style="width:50px; display:inline-block; vertical-align:middel;">		
	</h3>
	<div class="CnsltDiaryAll" style="width: 1400px; margin: auto; margin-bottom:43px; min-height:530px;">
		<div class="ConsltTit">
			<input type="text"  class="form-control input-sm" style="width: 95%; border: none; background: none; height: 50px; font-size: 1.4rem; display: inline-block; vertical-align: middle; margin-bottom:6px;" 
				   name="cnsltRequstCn" id="cnsltRequstCn" readonly="readonly">
			<img src="/resources/images/classRoom/freeBrd/line.png" style="position: absolute; left: 0px; top: 10px; z-index: -1;">
		</div>
		<div>
			<table style="width: 1200px; margin: auto; height: 50px; font-size: 1.2rem; display: inline-block; vertical-align: middle;">
				<tr>
					<th>상담 대상 아이디</th><td>${cnsltVO.cnsltTrgetId}</td>
					<th>상담 대상 이름</th><td>${cnsltVO.cnsltTrgetIdNm}</td>
				<tr>
				<tr>
					<th>상담 자녀 아이디</th>
					<td id="stdntId">
						${cnsltVO.stdntId}
						<img id="viewChildInfo" src="/resources/images/consultation/newWindow.png" style="width:20px; height:20px; display:inline-block; vertical-align:middel; cursor: pointer;"/>
					</td>
					<th>상담 자녀 이름</th><td id="stdntIdNm">${cnsltVO.stdntIdNm}</td>
				<tr>
				<tr>
					<th>상담 일자</th><td><fmt:formatDate value="${cnsltVO.cnsltDe}" pattern="yyyy-MM-dd"/></td>
					<th>상담 시간</th><td>${cnsltVO.cmmnCnsltTime}</td>
				<tr>
			</table>
		</div>
		<div class="cnslt-cont">
			<div id="smarteditor">
				<div id="cnsltCn" style="width: 100%; height: 90px;"></div>
			</div>			
		</div>
		<div class="btn-zone">
			​​​​​​​​<input type="button" value="목록" id="goToCnsltDiaryList" onclick="location='/cnslt/goToCnsltDiaryList'"/>
			<span id="mod-btn"></span>
			​​​​​​​​<input type="button" value="삭제" id="delBtn"/>
		</div>
	</div>
</div>