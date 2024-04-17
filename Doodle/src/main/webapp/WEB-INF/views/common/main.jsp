<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>  
<script type="text/javascript" src="/resources/js/commonFunction.js"></script>

<style>
/* #wrapperMain{ */
/* 	box-sizing: border-box; */
/* 	min-width: 800px; */
/* } */

/* .box { */
/* 	background-color: rgb(250, 250, 250); */
/* 	border-radius: 20px; */
/* 	border:rgb(230, 230, 230) solid 1px; */
/* } */

/* #myClsDiv{ */
/* 	width:100%; */
/* 	height:300px; */
/* } */

/* .cl { */
/* 	display : inline-block; */
/* } */

/* .headComment { */
/* 	margin : 5px; */
/* } */

/* #myContentDiv { */
/* 	width:100%; */
/* 	height:250px; */
/* 	display:flex; */
/* } */

/* #myNews { */
/* 	width:50%; */
/* 	margin-right : 10px; */
/* } */
/* #myMeals { */
/* 	width:50%; */
/* } */
/* #acad { */
/* 	height:250px; */
/* } */

</style>

<script>
window.onload = function(){
	// 최초 로그인시 비밀번호 변경 요구
	passwordChange();

	// 급식 정보
	getMeals();
	// 가입한 학교 목록
	getClassList();
}

// 최초 로그인시 비밀번호 변경 요구
const passwordChange = function(){
    console.log("${USER_INFO}");
    var password = "${USER_INFO.password}";
    
    var defaultPw = "$2a$10$z77PP1RfeUMJJFWY0p47Re2/wajq56UYywuzqGapxbRGMFDMeGZWG";
    var updatePwMsg = "최초 1회 비밀번호 변경이 필요합니다. \n비밀번호를 변경하시겠습니까?";
    
    // 아이디에서 권한 추출하기
    var authStr = "${memberVO.mberId}";
    console.log("authStr: " + authStr);
    var auth = authStr.charAt(7);
    console.log("auth: " + auth);

	var cmmnDetailCode = "";

	if(auth == "0" && password == defaultPw){ // 학생인 경우
		if(confirm(updatePwMsg)){
			location.href = "/student/mypage";
		}
	}
	
	if(auth == "1" && password == defaultPw){ // 선생님인 경우
	    if(confirm(updatePwMsg)){
			location.href = "/teacher/mypage";
		}
	}
}

// 급식 정보
const getMeals = function(){
	$.ajax({
		url:"/mainPageMeals",
		method:"post",
		dataType:"json",
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success:function(res){
			let str = "";
			res.forEach(function(item, index){
				str += 	`
						<div><b>[\${dateFormat(item.dietDe)}] \${item.schulVO.schulNm}</b></div>
						<div>\${item.dietMenu}</div>
						`;	
			});
			if(str != ""){
				document.querySelector("#mealsContainer").innerHTML = str;
			};
		}
	})
}

// 가입한 학교 목록
const getClassList = function(){
	$.ajax({
		url:"/myClassList",
		method:"post",
		dataType:"json",
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success:function(res){
			let str = "";

			res.forEach(function(item, index){
				str += 	`
						<div class ="cl">
						<button onclick ="enterClass('\${item.clasCode}')"><img src ="/resources/images/member/signUp2.png" alt =""></button>
						`;
				
				// 학부모일 경우 자녀의 이름까지 출력
				<sec:authorize access="hasRole('A01003')">
				console.log("학부모임");
				</sec:authorize>
				
				if(isParent()){
					str += `<p>[\${item.memberVO.mberId}] \${item.memberVO.mberNm} 자녀의</p>
							`;
				}
				
				str +=	`
						<p>\${item.schulVO.schulNm} \${item.cmmnDetailCodeVO.cmmnDetailCodeNm}학년 \${item.clasNm}반</p>
						<p>반코드 : \${item.clasCode}</p>
						</div>
						`		
			});
			document.querySelector("#clsContainer").innerHTML = str;
		},
		error:function(request, status, error){
			console.log("code: " + request.status)
	        console.log("message: " + request.responseText)
	        console.log("error: " + error);
		}
	})
}

// 클릭한 학급클래스 입장
const enterClass = function(clasCode){
	document.querySelector("#inputClasCode").value=clasCode;
	document.querySelector("#form1").submit();
}
</script>

Mobile Menu end
<div class="breadcome-area">
	<div class="container-fluid">
		<div class="row">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="breadcome-list">
					<div class="row">
						<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
							<div class="breadcome-heading">
								<form role="search" class="sr-input-func">
									<input type="text" placeholder="Search..." class="search-int form-control">
									<a href="#"><i class="fa fa-search"></i></a>
								</form>
							</div>
						</div>
						<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
							<ul class="breadcome-menu">
								<li><a href="#">Home</a> <span class="bread-slash">/</span>
								</li>
								<li><span class="bread-blod">Dashboard V.1</span>
								</li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>	
</div>

<form id ="form1" action ="class/classMain" method = "post">
<input type="text" id ="inputClasCode" name="clasCode" style ="display:none;">
<sec:csrfInput />
</form>

<div id = "wrapperMain">
	나의 학교/클래스 div	
	<div id = "myClsDiv" class ="box">
		<div class = "headComment">나의 학교/클래스</div>
		<div id = "clsContainer">
			가입된 학급클래스가 없습니다..
		</div>
	</div>
	<br>
	
	내 콘텐츠 div	
	<div id = "myContentDiv">
		좌 컨텐츠
		<div id = "myNews"  class ="box">
			<div class = "headComment">내 소식</div>
			<div id ="newsContainer">
				<div>[공지사항] 공지사항1공지사항1공지사항1</div>
				<div>[공지사항] 공지사항1공지사항1공지사항1</div>
				<div>[공지사항] 공지사항1공지사항1공지사항1</div>
				<div>[공지사항] 공지사항1공지사항1공지사항1</div>
				<div>[공지사항] 공지사항1공지사항1공지사항1</div>
			</div>
		</div>
		우 컨텐츠
		<div id = "myMeals"  class ="box">
			<div class = "headComment">급식</div>
			<div id = "mealsContainer">
				<div>등록된 급식 정보가 없습니다... </div>
			</div>
		</div>
	</div>
	<br>
	
	교육부 소식
	<div class = "box">
		<div class = "headComment">교육부 소식</div>
		<div id = "">
			<div>[2024-03-09] 교육부 소식1 교육부 소식1 교육부 소식1 교육부 소식1</div>
			<div>[2024-03-09] 교육부 소식1 교육부 소식1 교육부 소식1 교육부 소식1</div>
			<div>[2024-03-09] 교육부 소식1 교육부 소식1 교육부 소식1 교육부 소식1</div>
			<div>[2024-03-09] 교육부 소식1 교육부 소식1 교육부 소식1 교육부 소식1</div>
			<div>[2024-03-09] 교육부 소식1 교육부 소식1 교육부 소식1 교육부 소식1</div>
			<div>[2024-03-09] 교육부 소식1 교육부 소식1 교육부 소식1 교육부 소식1</div>
			<div>[2024-03-09] 교육부 소식1 교육부 소식1 교육부 소식1 교육부 소식1</div>
		</div>
	</div>
	<br>
	
	
	주변 학원
	<div id = "acad" class = "box">
		<div class = "headComment">주변 학원</div>
	</div>
</div>


