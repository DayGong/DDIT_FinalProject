<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script type="text/javascript" src="/resources/js/commonFunction.js"></script>

<!-- 네이버 스마트 에디터 JS -->
<script type="text/javascript" src="/resources/se2/js/HuskyEZCreator.js" charset="UTF-8"></script>

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
.CnsltCnAll {
	width: 1400px;
	margin: auto;
	backdrop-filter: blur(10px);
	background-color: rgba(255, 255, 255, 1);
	border-radius: 50px;
	box-shadow: 0px 35px 68px 0px rgba(145, 192, 255, 0.5), inset 0px -6px 16px 0px rgba(145, 192, 255, 0.6), inset 0px 11px 28px 0px rgb(255, 255, 255);
	padding: 50px 80px;
}
.CnsltCnAll .cnslt-cont {
	border: 1px solid #ddd;
	border-radius: 10px;
	padding: 10px 20px;
	min-height: 83px;
	margin-top: 50px;
}
.CnsltCnAll .ConsltTit {
	display: flex;
	justify-content: space-between;
	position:relative;
}
.CnsltCnAll .title {
	font-size: 1.8rem;
	font-weight: 700;
	margin-top: 6px;
}

.btn-zone {
	margin: auto;
	text-align: center;
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
#modBtn, #insertBtn  {
	background: #666;
	color:#fff;
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

.autoBtn {
	background: #333;
	height: 40px;
	border: none;
	padding: 10px 15px;
	border-radius: 10px;
	font-family: 'Pretendard' !important;
	font-weight: 600;
	color: #fff;
}
</style>
<script>
// 네이버 스마트 에디터 API 시작
let oEditors = [];	// 네이버 스마트 에디터 API 변수
let cnsltSmartEditor = function(cnsltCn) {
	nhn.husky.EZCreator.createInIFrame({
		oAppRef : oEditors,
		elPlaceHolder : "cnsltCn",
		// SmartEditor2Skin.html 파일이 존재하는 경로
		sSkinURI : '<c:url value="/resources/se2/SmartEditor2Skin.html"/>',
		htParams : {
			bUseToolbar : false,				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseVerticalResizer : false,		// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseModeChanger : false,			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
			bSkipXssFilter : true,				// client-side xss filter 무시 여부 (true:사용하지 않음 / 그외:사용)
			SE2M_FontName: {
				// 초기 글꼴 설정
				htMainFont: {'id': '나눔고딕','name': '나눔고딕','size': '18','url': '','cssUrl': ''} // 기본 글꼴 설정
			},
		}, //boolean
		fOnAppLoad : function(){
			var editor = oEditors.getById["cnsltCn"];
			
			// 내용이 있는 경우 내용 불러오기
			if ( !(cnsltCn == null || cnsltCn == '') ) { 
				editor.exec("PASTE_HTML", [cnsltCn]); 
			}
		},
		fCreator: "createSEditor2"
	}); 
};
// 네이버 스마트 에디터 API 끝
window.onload = function() {
	<!------------------------- 자동 완성 버튼 시작 --------------------------->
	$(document).on("click", "#cnsltAutoBtn", function() {
		let txt = "지은이는 의욕 넘치고 머리가 비상해서 노력이 빛을 발할 거에요!<br>방과후학교라는 새로운 경험으로 학업에대한 압박감을 줄여주는 것을 추천 드립니다.";
		oEditors.getById["cnsltCn"].exec("SET_IR", [""]);		//내용초기화
		oEditors.getById["cnsltCn"].exec("PASTE_HTML", [txt]);
	});
	<!------------------------- 자동 완성 버튼 끝 ----------------------------->
	
	let title = `${cnsltVO.cnsltRequstCn}`;
	title = title.replace(/\n/gi, " ");			// 제목 줄바꿈 문자를 띄어쓰기로 변경
	
	let stdntId = `${cnsltVO.stdntId}`;
	let stdntIdNm = `${cnsltVO.stdntIdNm}`;
	
	$("#cnsltRequstCn").val(title);				// 띄어쓰기로 변경된 제목 출력
	
	let cnsltCn = `${cnsltVO.cnsltCn}`;
	
	cnsltSmartEditor(cnsltCn);	// 네이버 스마트 에디터
	
	// 등록 버튼
	$("#insertBtn").on("click", function(){
		let cnsltCode = ${cnsltVO.cnsltCode};
		let cnsltCn = oEditors.getById["cnsltCn"].getIR();
		
		if (cnsltCn == null || cnsltCn == '') {
			alertError('상담 내용을 입력해주세요.', ' ');
			return;
		}
		
		// 게시글 등록
		oEditors.getById["cnsltCn"].exec("UPDATE_CONTENTS_FIELD",[]);
		let frm = new FormData($("#frm")[0]);
		
		$.ajax({
			url: "/cnslt/insertCnsltCnAct",
			processData:false,
			contentType:false,
			data: frm,
			type: "post",
			beforeSend:function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			},
			success: function(result) {
				let res = "성공";
				let icon = "success";
				
				if (result != 1) { res = "실패"; icon = "error"; }
				
				Swal.fire({
			      title: "상담 일지 등록을 " + res + '하였습니다.',
			      text: ' ',
			      icon: icon
				}).then(result => { 
					$("#viewCnsltCode").val(cnsltCode);
					$("#viewFrm").submit(); 
				});
			}
		}); // end /cnslt/insertCnsltCn ajax
	}); // end 등록
	
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
	});
	
}
</script>
<!-- 상담 일지 보기로 이동하는 form -->
<form id="viewFrm" method="post" action="/cnslt/viewCnsltCnDetail">
	<input type="hidden" id="viewCnsltCode" name="cnsltCode"/>
	<sec:csrfInput/>
</form>
<div id="CnsltDetailContainer">
	<h3>
		<img src="/resources/images/consultation/cnsltTitleImg.png" style="width:50px; display:inline-block; vertical-align:middel;">
		상담 일지
		<img src="/resources/images/consultation/cnsltTitleImg2.png" style="width:50px; display:inline-block; vertical-align:middel;">		
	</h3>
	<div class="CnsltCnAll" style="width: 1400px; margin: auto; margin-bottom:43px; min-height:530px;">
		<!------------------------- 자동 완성 버튼 시작 --------------------------->
		<tr>
			<td><i class="fa fa-pencil-square-o autoBtn" id="cnsltAutoBtn" aria-hidden="true" style="cursor: pointer; height: 15px; width: 15px;"></i></td>
		</tr>
		<!------------------------- 자동 완성 버튼 끝 ----------------------------->
		<div class="ConsltTit">
			<input type="text"  class="form-control input-sm" style="width: 95%; border: none; background: none; font-size: 1.4rem; display: inline-block; vertical-align: middle; margin-bottom:6px;" 
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
					<th>상담 자녀 아이디</th><td id="stdntId">${cnsltVO.stdntId}</td>
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
				<form id="frm">
					<input type="hidden" name="cnsltCode" value="${cnsltVO.cnsltCode}">
					<textarea id="cnsltCn" name="cnsltCn" style="width: 100%; height: 90px; resize: none; border: none;"></textarea>
				</form>
			</div>			
		</div>
		<div class="btn-zone">
			​​​​​​​​<input type="button" value="목록" id="goToCnsltDiaryList" onclick="javascript:location.href='/cnslt/goToCnsltDiaryList'"/>
			<input type="button" value="등록" id="insertBtn"/>
			​​​​​​​​<input type="button" value="삭제" id="delBtn"/>
		</div>
	</div>
</div>