<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<script type="text/javascript">
function resultSAlert(result, actTitle, reloadPage) {
	let schulCode = $("#schulCode").val();
	let res = "성공";
	let icon = "success";
	
	if (result != 2) { res = "실패"; icon = "error"; }
	
	Swal.fire({
      title: actTitle + " " + res + '하였습니다.',
      text: reloadPage,
      icon: icon
	}).then(result => { location.href = "/employee/studentList?schulCode="+schulCode; });
}

$(function() {
	//자동 입력
	$("#autoBtn").on("click",function(){
		$("#mberNm").val("이새싹");
		$.ajax({
			url:"/employee/selectMaxId",
			contentType:"application/json;charset=utf-8",
			data:"ROLE_A01001",
			type:"post",
			dataType:"text",
			beforeSend:function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			},
			success:function(result){
				let mberId = String(parseInt(result) + 1);
		 		$("#mberId").val(mberId);
			}
		});
		$("#pass").val("java");
		$("#ihidnum").val("180121-4234759");
		$("#moblphonNo").val("010-0843-1216");
		$("#mberEmail").val("sproutlee0101@google.com");
		$("#zip").val("34667");
		$("#mberAdres1").val("대전 동구 광명길 58");
		$("#mberAdres2").val("56번지");
		$("#cmmnGrade").val("A22001");
		$("#cmmnSchulPsitnSttus").val("A02101");
	});
	
	//아이디 정규식 (12자 숫자만)
	var idChk = /^[0-9]{12}$/;
	
	//회원 아이디 중복체크 이벤트
	$("#idChk").on("click", function(){
		var mberId = $("#mberId").val();
		let data = {"mberId" : mberId};
		
		$.ajax({
			url:"/idDupChk",
			contentType:"application/json;charset=utf-8",
			data:JSON.stringify(data),
			type:"post",
			dataType:"text",
			beforeSend:function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			},
			success:function(result){

				var chk = idChk.test(mberId);
				if(result == 0){
					if (!chk) {
						$('small[data-chk="mberIdChk"]').text("형식이 맞지 않습니다. (12자 숫자)").css("color","red");
						$("#mberId").attr("data-valid", "false");
						return;
					}
					$('[data-chk="mberIdChk"]').text("사용가능한 아이디입니다.").css("color","#006df0");
 					$("#mberId").css("border-color","#006df0");
 					$("#mberId").attr("data-valid", "true");
				}else{
					$('[data-chk="mberIdChk"]').text("이미 사용된 아이디입니다. 다시 입력해주세요.").css("color","red");
 					$("#mberId").css("border-color","red");
 					$("#mberId").attr("data-valid", "false");
				}
			}
		});
	});
	
	//회원가입 실행버튼 클릭 시
	$("#insertBtn").on("click",function(){
		
		//정규식 검사할 개수
		var targetCnt = $("[data-valid]").length;
		//정규식 통과한 개수
		var successCnt = $("[data-valid='true']").length;
		
		if(targetCnt == successCnt) {
		let schulCode = $("#schulCode").val();
		let mberNm = $("#mberNm").val();
		let mberId = $("#mberId").val();
		let password = $("#pass").val();
		let ihidnum= $("#ihidnum").val();
		let moblphonNo = $("#moblphonNo").val();
		let mberEmail = $("#mberEmail").val();
		let zip = $("#zip").val();
		let inputFile = $("#uploadFile").files;
		let cmmnDetailCode= $("#cmmnDetailCode").val();
		let cmmnGrade = $("#cmmnGrade option:selected").val();
		let cmmnSchulPsitnSttus = $("#cmmnSchulPsitnSttus option:selected").val();

		// 가상 폼 <form></form>
		//주소 + 상세주소를 하나로 합치는 스크립트 (DB에 주소 컬럼이 1개이므로 합쳐서 저장)
		var mberAdres = $("#mberAdres1").val() + ' ' + $("#mberAdres2").val();
		$("#mberAdres").val(mberAdres);
		var frm = new FormData($("#frm")[0]);
		
		$.ajax({
			url:"/employee/studentCreateAjax",
			processData:false,
			contentType:false,
			data:frm,
			type:"post",
			dataType:"text",
			beforeSend:function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			},
			success:function(result){
				if(result==2){
							resultSAlert(result,'학생 등록을','학생 목록으로 이동합니다.');
						}else{
							alertError('학생 등록에 실패하였습니다.', ' ');
						}
					}
				});
				}else {
					alertError('필수값을 입력해주세요.', ' ');
				}
				
	});
	
	//썸네일
	$("#inputImgs").on("change",handleImg);
	
	//e : onchange 이벤트 객체
	function handleImg(e){
		//e.target : <input type="file"..
		let files = e.target.files;
		//이미지 오브젝트 배열		
		let fileArr = Array.prototype.slice.call(files);
		//초기화
		$("#thum").html("");
		//fileArr : {"개똥이.jpg객체","홍길동.jpg객체"}
		//f :각각의 이미지 파일
		fileArr.forEach(function(f){
			//f.type : MIME타입
			if(!f.type.match("image.*")){
				alert("이미지 확장자만 가능합니다");
				//함수 종료
				return;
			}
			//이미지를 읽어보자
			let reader = new FileReader();
			
			//e : reader가 이미지를 읽을 때 그 이벤트
			reader.onload = function(e){
				//e.target : 이미지 객체
				let img = "<img src="+e.target.result+" style='width:100%; height:100%; text-align:center; display:block; margin:auto;' />";
				$("#thum").append(img);
			}
			
			reader.readAsDataURL(f);
		});
	}			
	
	/* 학생 목록 */
	$("#goList").on("click",function(){
		window.history.back();
	});
	
	/* 우편 번호 검색 */
	$("#btnPostNum").on("click", function() {
		new daum.Postcode({
			//다음 창에서 검색이 완료되면
			oncomplete : function(data) {
				$("#zip").val(data.zonecode);//우편번호
				$("#mberAdres1").val(data.address);//주소
			}
		}).open();
	});
});
</script>


<style>
/*회원가입 폼 스타일 정의*/
#signUpContainer{
	width:700px;
	backdrop-filter: blur(6px); 
	background-color: rgba(255, 255, 255, 0.8); 
	border-radius: 20px; 
	box-shadow: 35px 35px 68px 0px rgba(145, 192, 255, 0.5), inset -9px -9px 16px 0px rgba(145, 192, 255, 0.6), inset 0px 11px 28px 0px rgb(255, 255, 255);
	padding:50px 20px;
	margin:auto;
	margin-top: 80px;
	margin-bottom: 60px;
	animation: fadein 1s;
	-moz-animation: fadein 1s; /* Firefox */
	-webkit-animation: fadein 1s; /* Safari and Chrome */
	-o-animation: fadein 1s; /* Opera */
	padding-left: 80px;
	padding-right: 80px;
}
@keyframes fadein {
		from {
				opacity: 0;
		}
		to {
				opacity: 1;
		}
	}
	@-moz-keyframes fadein { /* Firefox */
			from {
					opacity: 0;
			}
			to {
					opacity: 1;
			}
	}
	@-webkit-keyframes fadein { /* Safari and Chrome */
			from {
					opacity: 0;
			}
			to {
					opacity: 1;
			}
	}
	@-o-keyframes fadein { /* Opera */
			from {
					opacity: 0;
			}
			to {
					opacity: 1;
			}
	}

#signUpContainer h2{
	text-align:center;
	font-size:2.2rem;
	margin-bottom:10px;
	
}
#signUpContainer input[type='text'], #signUpContainer input[type='password']{
	height:50px;
	border:1px solid #ddd;
	border-radius:5px;
	width:100%;
	margin-top:10px;
	font-size:1rem;
	padding:10px; 15px;
	outline:none;
}
#signUpContainer span{
	font-size:1.2rem;
	margin-right:20px;
	font-weight:600;
	line-height: 1.7;
	
}

.signUpinputAll, .signUpinputAll li{
	display:block;
}

.signUpinputAll li{
	margin-bottom: 20px;
}
#signUpContainer .signUpinputAll li small{
	font-size: 0.85rem;
	color: #333;
	font-weight: 400;
	margin-top: 7px;
	display: block;
}
/*회원가입 폼 스타일 정의 끝*/

/*회원가입 버튼 스타일 정의*/
#insertBtn{
	vertical-align:middle;
	display:inline-block;
	border:none;
	height: 50px;
	text-align: center;
	font-weight:700;
	width:200px;
/* 	margin:auto; */
	border-radius: 10px;
	background: #006DF0;
	color: #fff;
	font-size: 1.2rem;
	margin-left: 10px;
	
}

#autoBtn{
	vertical-align:middle;
	display:inline-block;
	border:none;
	height: 50px;
	text-align: center;
	font-weight:700;
	width:50px;
	margin:auto;
	border-radius: 10px;
	background: rgba(255, 255, 255, 0.8);
	color: #333;
	font-size: 1.2rem;
}

#insertBtn:hover, #goList:hover, #frm #btnPostNum:hover, #frm #idChk:hover, #autoBtn:hover{
	background: #ffd77a;
	color:#333;
	transition:all 1s;
}
#goList{
	vertical-align:middle;
	display:inline-block;
	border:none;
	height: 50px;
	text-align: center;
	font-weight:700;
	width:200px;
/* 	margin:auto; */
	border-radius: 10px;
	background: #333;
	color: #fff;
	font-size: 1.2rem;
	margin-left: 10px;
}


#frm .btnZone{
	display:flex;
	text-align: center;
	margin-top:55px;
}
#frm #btnPostNum, #frm #idChk{
	display: inline-block;
	height: 50px;
	border: none;
	border-radius: 5px;
	background: #333333;
	color: #fff;
	font-weight: 600;
}

#frm #childAddBtn, #frm #childDelBtn, #frm #childChk{
	display:inline-block; 
	background:#006DF0; 
	color:#fff; 
	border-radius:120px; 
	margin-top: 0px; 
	cursor:pointer; 
	margin-bottom:5px; 
	padding: 10px 10px; 
	font-weight:600; 
	font-size:0.9rem; 
	border:none;
}

#frm #childChk{
	background: #ffd77a;
	color:#3e3f41;
	font-weight:700;
}


#frm #childDelBtn{
	background:#666; 
}
#frm #childDelBtn:hover,#frm #childChk:hover, #frm #childAddBtn:hover{
	background: #111;
	color:#fff;
	transition:all 1s;
}
</style>
<!-- 학생 등록 폼 전체 -->
<div id="signUpContainer">
   <h2>
      학생 등록 
      <img src="..\resources\images\member\signUp1.png" style="width:40px;">
      <button type="button" id="autoBtn">
         <i class="fa fa-pencil-square-o" aria-hidden="true"></i>
      </button>
   </h2>
      <form id="frm" action="" method="post" enctype="multipart/form-data">
         <ul class="signUpinputAll">
            <li>
               <span style="display:none;">학교 코드</span>
               <input type="text" name="schulCode" id="schulCode" style="display:none;" value="${param.schulCode}" readonly>
               <input type="text" name="cmmnDetailCode" id="cmmnDetailCode" style="display:none;" value="ROLE_A01001" readonly>
            </li>
            <li>
               <span>학생 이름</span>
               <input type="text" name="mberNm" id="mberNm">
            </li>
            <li>
				<span style="display:block;">학생 아이디</span>
				<input type="text" name="mberId" id="mberId" style="width:88%; display:inline-block;" data-valid="false">
				<button type="button" id="idChk" style="display:inline-block;">중복확인</button>
				<small data-chk="mberIdChk">12자의 숫자로 입력해주세요</small>
			</li>
            <li>
               <span>비밀번호</span>
               <input type="password" name="password" id="pass">
            </li>
            <li>
               <span>주민등록번호</span>
               <input type="text" name="ihidnum" id="ihidnum">
            </li>
            <li>
               <span>핸드폰번호</span>
               <input type="text" name="moblphonNo" id="moblphonNo">
            </li>
            <li>
               <span>이메일</span>
               <input type="text" name="mberEmail" id="mberEmail">
            </li>
            <li>
               <span style="display:block;">우편번호</span>
               <input type="text" name="zip" id="zip" style="width:82%; display:inline-block;" >
               <button type="button" id="btnPostNum" style="display:inline-block;">우편번호검색</button>
            </li>
            <li>
               <span>주소</span>
               <input type="text" name="mberAdres1" id="mberAdres1">
            </li>
            <li>
               <span>상세주소</span>
               <input type="text" name="mberAdres2" id="mberAdres2">
               <input type="hidden" name="mberAdres" id="mberAdres">
            </li>
            <li>
				<div id="thum" style="margin:auto; background:#eeeef5; width:200px; height:200px; border-radius:300px; overflow:hidden; margin-top:40px;"  ></div>
			</li>
            <li>
               <span >증명 사진</span>
               <input style="margin-top:10px;" type="file" name="uploadFile" id="inputImgs">
            </li>
            <li style="display: inline-block; margin-right: 70px;">
               <span>학년 구분</span>
               <select name="cmmnGrade" id="cmmnGrade">
					<option disabled selected>학년을 선택하세요</option>
					<option value="A22001">1</option>
					<option value="A22002">2</option>
					<option value="A22003">3</option>
					<option value="A22004">4</option>
					<option value="A22005">5</option>
					<option value="A22006">6</option>
				</select>
			</li>
            <li style="display: inline-block;">
               <span>상태</span>
               <select name="cmmnSchulPsitnSttus" id="cmmnSchulPsitnSttus">
               		<option disabled selected>상태를 선택하세요</option>
	            	<option value="A02101">재학</option>
	            	<option value="A02102">휴학</option>
	            	<option value="A02103">전학</option>
	            	<option value="A02107">졸업</option>
	            	<option value="A02108">자퇴</option>
	           </select>
            </li>
         </ul>
         <p class="btnZone">
            <button type="button" id="insertBtn">
               학생 등록
            </button>
            <button type="button" id="goList">
               학생 목록
            </button>
         </p>
         <sec:csrfInput />
      </form>
   </div>