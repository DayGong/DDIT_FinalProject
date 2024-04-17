<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
<!--회원가입 등록버튼 이벤트-->
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<!--회원가입 등록버튼 이벤트-->
<script type="text/javascript">

$(function() {
	//자동입력 이벤트(비밀번호, 주소, 상세주소, 프로필사진 제외 자녀추가 및 자녀아이디확인, 회원 아이디 중복체크 필수)
	$("#autoValueBtn").on("click",function(){
		$("#mberNm").val("김미영");
		$("#mberNm").focus();
		$("#mberChild1").val("test12");
		$("#mberId").val("mj1007");
		$("#passwordJoin").val("java");
		$("#passwordJoin").focus();
		$("#password2").val("java");
		$("#password2").focus();
		$("#ihidnum").val("860720-2401111");
		$("#ihidnum").focus();
		$("#moblphonNo").val("010-7537-8555");
		$("#moblphonNo").focus();
		$("#mberEmail").val("mj1007@naver.com");
		$("#mberEmail").focus();
		$("#mberAdres2").val("105동 1501호");
		$("#mberAdres2").focus();
	});
	
	//썸네일
	$("#inputImgs").on("change",handleImg);
	
	//e : onchange 이벤트 객체
	function handleImg(e){
		console.log("개똥이");
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
				alertError('이미지 확장자만 가능합니다');
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
	
	
	
	
	
	//학부모 권한 체크 auth=1 학생/ auth=2 학부모 / auth=3 선생님
	var auth = '${auth}'||'';
	
	///////////////권한 공통 정규식 체크///////////////
	//이름 정규식 (1~20자 한글만)
	var nmChk = /^[가-힣]{1,20}$/;
	//아이디 정규식 (20자 영문/숫자만)
	var idChk = /^[a-zA-Z0-9]{1,20}$/;
	//주민번호 정규식 (-포함)
	var idNumChk = /^\d{6}-\d{7}$/;
	//핸드폰 번호 정규식 (-포함)
	var phoneChk = /^\d{3}-\d{4}-\d{4}$/;
	//이메일 정규식(@,.포함)
	var mailChk = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
		
	//회원 이름 정규식 확인 focusOut이벤트
	$("#mberNm").on("focusout", function(event) {
		var mberNm = $("#mberNm").val();
		// focusout 이벤트가 발생했을 때 실행되는 코드
		// mberNm 값을 가져와서 정규 표현식으로 유효성 검사
		var chk = nmChk.test(mberNm);
		if (chk) {
			$(this).css("border-color", "#006df0");
			$('small[data-chk="mberNm"]').text("올바르게 입력하셨습니다.").css("color","#006df0");
			$(this).attr("data-valid", "true");
			//$(this).data("valid", "true");
		}else{
			$(this).css("border-color", "red");
			$('small[data-chk="mberNm"]').text("형식이 맞지 않습니다. (20자 이내의 한글)").css("color","red");
			$(this).attr("data-valid", "false");
		}
	});
	
	//회원 아이디 정규식 확인 focusOut이벤트
	$("#mberId").on("focusout", function(event) {
		var mberId = $("#mberId").val();
		// focusout 이벤트가 발생했을 때 실행되는 코드
		// mberNm 값을 가져와서 정규 표현식으로 유효성 검사
		var chk = idChk.test(mberId);
		if (!chk) {
			$(this).css("border-color", "red");
			$('small[data-chk="mberIdChk"]').text("형식이 맞지 않습니다. (20자 영문/숫자)").css("color","red");
		}
	});
	
	//회원 가족관계 선택확인 focusOut이벤트
	$("#familyChoice").on("focusout", function(event) {
		var familyChoice = $("#familyChoice").val();
		// focusout 이벤트가 발생했을 때 실행되는 코드
		// mberNm 값을 가져와서 정규 표현식으로 유효성 검사
		if (familyChoice == null ||familyChoice == '') {
			$(this).css("border-color", "red");
			$('small[data-chk="familyChoice"]').text("필수 입력값입니다.").css("color","red");
			$(this).attr("data-valid", "false");
		}else{
			$(this).css("border-color", "#006df0");
			$('small[data-chk="familyChoice"]').text("");
			$(this).attr("data-valid", "true");
			
		}
	});
	

	//회원 비밀번호 동일한지 체크 focusOut이벤트
	$("#password2").on("focusout", function(event) {
		var passwordFirst = $("#passwordJoin").val();
		console.log("passwordJoin->", passwordFirst);

		var passwordScondes = $("#password2").val();
		console.log("password2->", passwordScondes);
		// focusout 이벤트가 발생했을 때 실행되는 코드
		// mberNm 값을 가져와서 정규 표현식으로 유효성 검사
		if(passwordFirst==null || passwordScondes==null && passwordFirst=='' || passwordScondes ==''){
			$("#passwordJoin").css("border-color", "red");
			$("#password2").css("border-color", "red");
			$('small[data-chk="password1"]').text("필수 입력값입니다. 비밀번호를 입력해주세요.").css("color","red");
			$('small[data-chk="password2"]').text("필수 입력값입니다. 비밀번호를 입력해주세요.").css("color","red");
			$("#passwordJoin").attr("data-valid", "false");
			$("#password2").attr("data-valid", "false");
		}else{
			if (passwordFirst != passwordScondes) {
				$("#passwordJoin").css("border-color", "red");
				$("#password2").css("border-color", "red");
				$('small[data-chk="password1"]').text("비밀번호가 동일하지않습니다.").css("color","red");
				$('small[data-chk="password2"]').text("비밀번호가 동일하지않습니다.").css("color","red");
				$("#passwordJoin").attr("data-valid", "false");
				$("#password2").attr("data-valid", "false");
			}else{
				$("#passwordJoin").css("border-color", "#006df0");
				$("#password2").css("border-color", "#006df0");
				$('small[data-chk="password1"').text("비밀번호가 동일합니다.").css("color","#006df0");
				$('small[data-chk="password2"').text("비밀번호가 동일합니다.").css("color","#006df0");
				$("#passwordJoin").attr("data-valid", "true");
				$("#password2").attr("data-valid", "true");
			}
		}
	
	});
	//회원 주민번호 정규식 확인 focusOut이벤트
	$("#ihidnum").on("focusout", function(event) {
		var ihidnum = $("#ihidnum").val();
		// focusout 이벤트가 발생했을 때 실행되는 코드
		// mberNm 값을 가져와서 정규 표현식으로 유효성 검사
		var chk = idNumChk.test(ihidnum);
		if (chk) {
			$(this).css("border-color", "#006df0");
			$('small[data-chk="ihidnum"]').text("올바르게 입력하셨습니다.").css("color","#006df0");
			$(this).attr("data-valid", "true");
		}else{
			$(this).css("border-color", "red");
			$('small[data-chk="ihidnum"]').text("형식이 맞지 않습니다. ('-'포함 14자리 숫자)").css("color","red");
			$(this).attr("data-valid", "false");
		}
	});
	
	//회원 핸드폰번호 정규식 확인 focusOut이벤트
	$("#moblphonNo").on("focusout", function(event) {
		var moblphonNo = $("#moblphonNo").val();
		// focusout 이벤트가 발생했을 때 실행되는 코드
		// mberNm 값을 가져와서 정규 표현식으로 유효성 검사
		var chk = phoneChk.test(moblphonNo);
		if (chk) {
			$(this).css("border-color", "#006df0");
			$('small[data-chk="moblphonNo"]').text("올바르게 입력하셨습니다.").css("color","#006df0");
			$(this).attr("data-valid", "true");
		}else{
			$(this).css("border-color", "red");
			$('small[data-chk="moblphonNo"]').text("형식이 맞지 않습니다. ('-'포함 15자리 숫자)").css("color","red");
			$(this).attr("data-valid", "false");
		}
	});

	//회원 이메일 정규식 확인 focusOut이벤트
	$("#mberEmail").on("focusout", function(event) {
		var mberEmail = $("#mberEmail").val();
		// focusout 이벤트가 발생했을 때 실행되는 코드
		// mberNm 값을 가져와서 정규 표현식으로 유효성 검사
		var chk = mailChk.test(mberEmail);
		
		if (mberEmail!=null) {
			$("#mberEmail").css("border-color", "#006df0");
			$('small[data-chk="mberEmail"]').text('').css("color","#006df0");
		}
		
		if (chk) {
			$(this).css("border-color", "#006df0");
			$('small[data-chk="mberEmail"]').text("올바르게 입력하셨습니다.").css("color","#006df0");
			$(this).attr("data-valid", "true");
		}else{
			$(this).css("border-color", "red");
			$('small[data-chk="mberEmail"]').text("이메일 형식이 맞지 않습니다.").css("color","red");
			$(this).attr("data-valid", "false");
		}
	});
	
	
	//상세주소 null체크
	$("#mberAdres2").on("focusout", function(event) {
		if ($('#mberAdres2').val() != null && $('#mberAdres2').val() != '') {
			$(this).css("border-color", "#006df0");
			$('small[data-chk="mberAdres2"]').text('').css("color","#006df0");
			$(this).attr("data-valid", "true");
		}else {
			$(this).css("border-color", "red");
			$('small[data-chk="mberAdres2"]').text("필수 입력값입니다.").css("color","red");
			$(this).attr("data-valid", "false");
		}
	});
	
	//회원 자녀 아이디 정규식 확인 focusOut이벤트
	$(document).on("focusout", "input[name='mberChild']", function() {
		var mberChild = $(this).val();
		// focusout 이벤트가 발생했을 때 실행되는 코드
		// mberNm 값을 가져와서 정규 표현식으로 유효성 검사
		if (mberChild == null || mberChild == '') {
			$(this).css("border-color", "red");
			$(this).next().text("필수 입력값입니다.").css("color","red");
			$("#mberChild").attr("data-valid", "false");
		}
	});
	
	//자녀아이디 확인 처리 받고 갑자기 자녀아이드를 수정하는 경우도 포함 
	//(근데 추가버튼 눌러서 생긴 자녀아이디 폼은 이미 페이지가 로드되고나서 생긴거라 읽히지 않았었음 그래서 doument를 꼭 써줘야함)
	//회원 자녀 아이디 정규식 확인 focusOut이벤트
	$(document).on("change", "input[name='mberChild']", function() {
		$(this).css("border-color", "red");
		$(this).next().text("자녀확인을 다시 해주세요.").css("color","red");
		$("#mberChild").attr("data-valid", "false");//자녀아이디 확인받고 수정하게되면 다시 확인 해야 ture로 변환됩니다.
	});
	
	//자녀 아이디 체크
	$("#childChk").on("click", function(){
		//로그인 버튼 클릭 시 값을 정상적으로 작성했는지 확인할 boolean변수 선언 
		var validChk = true;
		//자녀 아이디의 input값을 전부 가져와서 반복문 돌리기
		$("[name='mberChild']").each(function(i, item) {
			//만약 자녀아이디가 1개라도 null이거나 화이트스페이스라면 로그인이 넘어가지않게 체크변수를 false로  변환
			if($(item).val() == null || $(item).val() == '') {
				$(item).css("border-color", "red");
				$('small[data-chk="mberChild'+(i+1)+'"]').text("필수 입력값입니다.").css("color","red");
				validChk = false;
			}else {
				//값을 정상적으로 입력했다면 체크변수는 true
				$(item).css("border-color", "#006df0");
				$('small[data-chk="mberChild'+(i+1)+'"]').text('').css("color","#006df0");
			}
		});
		
		//자녀아이디가 중복되는 것을 막아야함
		if(validChk) {
			//중복을 확인할 boolean변수 선언 
			var validChk3 = true;
			//자녀아이디를 담을 배열 선언
			var array = new Array();
			//모든 자녀아이디 값을 가져와서 반복문 돌림
			$("[name='mberChild']").each(function(i, item) {
				//return값이 -1이면 겹치는게 단 한개도 없다는 뜻이므로 중복 피하기 성공
				if(array.indexOf($(item).val()) == -1) {
					array.push($(item).val());
					//생성한 배열에 값을 넣는다
				}else {
					//그 외의 중복되는 값이 존재할때 (아마 중복되는 아이디만큼 숫자로 나오는 것으로 알고 있음)
					alertError('자녀아이디는 중복될 수 없습니다.');
					//중복확인 변수 false로 돌리고 함수 종료
					validChk3 = false;
					return false;
				}
			});
		}
		
		//위의 검사가 모두 정상적으로 true가 되었을 때 회원가입이 실행 되어야함
		if(validChk && validChk3) {
			//아이디를 담을 변수 선언
			var idList = "";
			//자녀 아이디 값 모두 가져와서 반복문 돌림
			$("[name='mberChild']").each(function(i, item) {
				//변수에 불러온 자녀아이디를 모두 담음 예) (ruby, auqa) 이런식으로 ','로 저장된다.
				idList += $(item).val() + ",";
			});
			idList = idList.substring(0, idList.lastIndexOf(","));
			console.log("idList값은 뭘까용->" + idList);
			//자녀 아이디 존재 유무 체크
			$.ajax({
				url:"/childChk",
				data: {"idList" : idList},
				type:"post",
				dataType:"json",
				beforeSend:function(xhr){
					xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
				},
				success:function(result){
					console.log("result : ", result);
					var validChk2 = true;//확인변수값 선언
					for (var i = 0; i < result.length; i++) {//자녀 아이디 '하나씩' 중복체크 컨트롤러로 갔다옴
						if(result[i] == 1) {
							//자녀아이디 확인 되면 result값 1
							$('[data-chk="mberChild'+(i+1)+'"]').text("자녀 아이디가 확인되었습니다.").css("color","#006df0");
							$("#mberChild"+(i+1)).css("border-color","#006df0");
						}else {
							$('[data-chk="mberChild'+(i+1)+'"]').text("자녀 아이디가 확인되지 않습니다. 다시 입력해주세요.").css("color","red");
							$($("[name='mberChild']")[i]).css("border-color","red");
							validChk2 = false;//확인 변수값 false;
						}
						
						
						if(validChk2) {
							//회원가입 실행 되도록 체크 값을 true으로 전환
							$("#mberChild").attr("data-valid", "true");
						}else {
							//하나라도 false면 확인변수  false으로 전환
							$("#mberChild").attr("data-valid", "false");
						}
					}
				}
	 		});
		}
	});
	
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
			console.log("result : ", result);
			var chk = idChk.test(mberId);
				if(result == 0){
					if (!chk) {
						$('small[data-chk="mberIdChk"]').text("형식이 맞지 않습니다. (20자 영문/숫자)").css("color","red");
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
	////////////////////// 정규식 체크 및 아이디 중복확인, 자녀확인 끝 //////////////////////
	///////////////////////////////// NULL체크시작 /////////////////////////////////

	//회원가입 실행버튼 클릭 시
	$("#insertBtn").on("click", function(){
		//정규식 검사할 개수
		var targetCnt = $("[data-valid]").length;
		//정규식 통과한 개수
		var successCnt = $("[data-valid='true']").length;
		
		if(targetCnt == successCnt) {
			//주소 + 상세주소를 하나로 합치는 스크립트 (DB에 주소 컬럼이 1개이므로 합쳐서 저장)
			var mberAdres = $("#mberAdres1").val() + ' ' + $("#mberAdres2").val();
			$("#mberAdres").val(mberAdres);
			var frm = new FormData($("#frm")[0]);
			$.ajax({
				url : "/signUpMember",
				processData:false,
				contentType:false,
				data:frm,
				dataType:"text",
				type:"post",
				beforeSend:function(xhr){
					xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
				},
				success:function(result){
					//학부모 가입과 가족관계 인서트가 성공했을 때 1을 던짐
 					console.log("result : ", result);
					if(result==1){
						resultAlert2(result, '회원가입을 ', '초기화면으로 이동합니다.', '/');
						//location.href="/";
					}else{
						alertError('회원가입 실패!');
					}
				}
			})
		}else {
			alertError('필수 값을 입력해주세요.');
		}
	});
	
	//자녀추가
	$("#childAddBtn").on("click",function(){

		var len = $('[name="mberChild"]').length;
		if(len == 3) {
			alertError('최대 3명의 자녀만 등록 가능합니다.');
			return;
		}else {
			$("#childIdTit1").html("<u style='text-decoration: none; color: #ff3131;'>*</u>자녀 아이디1");
		}
		
		let str = "<div class='containerDiv'> <span style='display: flex; justify-content: space-between; margin-right:0px;'> <span id='childIdTit"+(len+1)+"'> <u style='text-decoration: none; color: #ff3131;'>*</u>자녀 아이디"+(len+1)+"</span>"
		str+="<span style='margin-right:0px;'></span></span><p id='childArea'><input type='text' name='mberChild' id='mberChild"+(len+1)+"' style='width:100%; display:inline-block; border-color:red;'><small data-chk='mberChild"+(len+1)+"'>자녀분의 아이디를 입력해주세요</small></p></div>"
		
		$("#mberChildAdd").append(str);
		
		$("#mberChild").attr("data-valid", "false");
	});
	
	//자녀삭제
	$("#childDelBtn").on("click",function(){
		$("#mberChildAdd").children().last().remove();
		if($("#mberChildAdd").children().length == 0) {
			$("#childIdTit1").html("<u style='text-decoration: none; color: #ff3131;'>*</u>자녀 아이디");
		}
		
		$("[name='mberChild']").each(function(i, item) {
			$(item).css("border-color", "red");
			$('[data-chk="mberChild'+(i+1)+'"]').text("자녀확인을 다시 해주세요.").css("color","red");
		});
		
		$("#mberChild").attr("data-valid", "false");
	});
	

	//우편번호 API
	$("#btnPostNum").on("click", function(){
 		new daum.Postcode({
				//다음 창에서 검색이 완료되면
				oncomplete : function(data) {
					$("#zip").val(data.zonecode);//우편번호
					$("#mberAdres1").val(data.address);//주소
					$("#zip").css("border-color", "#006df0");
					$('small[data-chk="zip"]').text('');
					$("#mberAdres1").css("border-color", "#006df0");
					$("#zip").attr("data-valid", "true");
					$("#mberAdres1").attr("data-valid", "true");
				}
			}).open();
		});
});


</script>
<!-- 우편번호 API 끝-->
<style>
body{
background : #5285ee!important

}
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
	position: relative;
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
	margin:auto;
	border-radius: 10px;
	background: #006DF0;
	color: #fff;
	font-size: 1.2rem;
	
}

#insertBtn:hover, #gologin:hover, #frm #btnPostNum:hover, #frm #idChk:hover{
	background: #ffd77a;
	color:#333;
	transition:all 1s;
}
#gologin{
	vertical-align:middle;
	display:inline-block;
	border:none;
	height: 50px;
	text-align: center;
	font-weight:700;
	width:200px;
	margin:auto;
	border-radius: 10px;
	background: #333;
	color: #fff;
	font-size: 1.2rem;
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

#frm #childAddBtn, #frm #childDelBtn, #frm #childChk, #autoValueBtn{
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

#autoValueBtn{
	position: absolute;
	top: 90px;
	right: 72px;
	display: block;
}
</style>

<!-- 회원가입 폼 전체 -->
<div id="signUpContainer">
	<button type="button" id="autoValueBtn">자동입력</button>
	<h2>
		회원가입 
		<img src="..\resources\images\member\signUp1.png" style="width:40px;">
	</h2>
		<form id="frm">
			<ul class="signUpinputAll">
				<li>
					<span><u style="text-decoration: none; color: #ff3131;">*</u> 회원 성함</span>
					<input type="text" name="mberNm" id="mberNm" style="display:block;" data-valid="false">
					<small data-chk="mberNm">20자내의 한글로만 입력해주세요</small>
				</li>
				<c:if test="${auth==2}">
					<li>
						<input type="hidden" id="mberChild" data-valid="false">
						<div class="containerDiv">
							<span style="display: flex; justify-content: space-between; margin-right:0px;">
								<span id="childIdTit1">
									<u style="text-decoration: none; color: #ff3131;">*</u>자녀 아이디<small class="num"></small>
								</span>
								<span style="margin-right:0px;">
									<button type="button" id="childAddBtn">
										추가 <i style="font-size:0.8rem;" class="fa-solid fa-user-plus"></i>
									</button>
									<button type="button" id="childDelBtn">
										삭제<i style="font-size:0.8rem; margin-left:3px;"class="fa-solid fa-user-minus"></i>
									</button>
									<button type="button" id="childChk">
										자녀확인<i style="font-size:1rem; margin-left:2px;" class="fa-solid fa-person-circle-check"></i>
									</button>
								</span>
							</span>
							<p id="childArea">
								<input type="text" name="mberChild" id="mberChild1" style="width:100%; display:inline-block;">
								<small data-chk="mberChild1">자녀분의 아이디를 입력해주세요</small>
							</p>
						</div>
					</li>
					<li id="mberChildAdd">
					<li>
				</c:if>
				<li>
					<span style="display:block;"><u style="text-decoration: none; color: #ff3131;">*</u> 아이디</span>
					<input type="text" name="mberId" id="mberId" style="width:88%; display:inline-block;" data-valid="false">
					<button type="button" id="idChk" style="display:inline-block;">중복확인</button>
					<small data-chk="mberIdChk">20자내의 영문/숫자로 입력해주세요</small>
				</li>
				<li>
					<span><u style="text-decoration: none; color: #ff3131;">*</u> 비밀번호</span>
					<input type="password" name="password" id="passwordJoin" data-valid="false">
					<small data-chk="password1">특수기호/영문가능</small>
				</li>
				<li>
					<span><u style="text-decoration: none; color: #ff3131;">*</u> 비밀번호 확인</span>
					<input type="password" name="password2" id="password2" data-valid="false">
					<small data-chk="password2">동일한 비밀번호를 입력해주세요</small>
				</li>
				<li>
					<span><u style="text-decoration: none; color: #ff3131;">*</u> 주민등록번호</span>
					<input type="text" name="ihidnum" id="ihidnum" data-valid="false">
					<small data-chk="ihidnum">'-'포함 14자로 입력해주세요 000101-1234567</small>
				</li>
				<li>
					<span><u style="text-decoration: none; color: #ff3131;">*</u> 핸드폰번호</span>
					<input type="text" name="moblphonNo" id="moblphonNo" data-valid="false">
					<small data-chk="moblphonNo">'-'포함 15자로 입력해주세요 010-1234-5678</small>
				</li>
				<li>
					<span><u style="text-decoration: none; color: #ff3131;">*</u> 이메일</span>
					<input type="text" name="mberEmail" id="mberEmail" data-valid="false">
					<small data-chk="mberEmail"></small>
				</li>
				<li>
					<span style="display:block;"><u style="text-decoration: none; color: #ff3131;">*</u> 우편번호</span>
					<input type="text" name="zip" id="zip" style="width:82%; display:inline-block;" readonly="readonly" data-valid="false">
					<button type="button" id="btnPostNum" style="display:inline-block;">우편번호검색</button>
					<small data-chk="zip"></small>
				</li>
				<li>
					<span><u style="text-decoration: none; color: #ff3131;">*</u> 주소</span>
					<input type="text"  id="mberAdres1" readonly="readonly" data-valid="false">
					<small data-chk="mberAdres1"></small>
				</li>
				<li>
					<span><u style="text-decoration: none; color: #ff3131;">*</u> 상세주소</span>
					<input type="text" id="mberAdres2" data-valid="false">
					<small data-chk="mberAdres2"></small>
					<input type="hidden" name="mberAdres" id="mberAdres">
				</li>
				<li>
					<span><u style="text-decoration: none; color: #ff3131;">*</u> 가족관계</span>
					<select style="height:50px; border:1px solid #ddd; border-radius: 5px; padding:10px; width:100%; margin-top:10px;" name="familyChoice" data-valid="false" id="familyChoice">
						<option value="">선택</option>
						<c:forEach items="${familyChoiceList}" var="item">
							<option value="${item.cmmnDetailCode}">${item.cmmnDetailCodeNm}</option>
						</c:forEach>
					</select>
					<small data-chk="familyChoice"></small>
				</li>
				<li>
					<div id="thum" style="margin:auto; background:#eeeef5; width:200px; height:200px; border-radius:300px; overflow:hidden; margin-top:40px;"  ></div>
				</li>
				<li>
					<span >프로필 사진</span>
					<input style="margin-top:10px;" type="file" name="upload" id="inputImgs">
				</li>
				
			</ul>
			<p class="btnZone">
				<button type="button" id="insertBtn">
					회원가입하기
				</button>
				<button type="button" id="gologin" onclick="javascript:location.href='/'">
					로그인 화면으로
				</button>
			</p>
		</form>
	</div>