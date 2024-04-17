<%@page import="kr.or.ddit.util.etc.AuthManager"%>
<%@page import="kr.or.ddit.vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>  

<%--
반/학교 페이지에 입장/퇴장했을 때 반/학교 정보를 세션에 저장 및 삭제하는 함수 

사용 방법 :
접근하고 있는 jsp파일의 <script></script> 태그 내부에서 사용
ex) <script>
	addClassInfo("${param.clasCode}");
	</script>

1. url에 반코드/학교코드가 있을 때

	반페이지    : addClassInfo("${param.clasCode}");
	학교페이지 : addClassInfo("${param.schulCode}");
	
	이때 파라미터명이 다르면 다르게 써줘야 한다.
	ex) URL 파라미터가 ?clasCode=CL10000001 이 아니고 clascode=CL10000001 인 경우
	addClassInfo("${param.clascode}");

2. 반코드/학교코드를 컨트롤러에서 model에 담아 jsp로 보냈을 때

	반페이지    : addClassInfo("${param.clasCode}");
	학교페이지 : addSchoolInfo("${param.schulCode}");
	
	이때 model에 VO로 담았으면
	addClassInfo("${clasVO.clasCode}");
	등 구조에 따라 다르게 넣어줘야 함.
	잘 안되면 최재형 문의주세요.

3. 반/학교 페이지에서 퇴장했을 때

	반페이지 : deleteClassInfo();
	학교페이지 : deleteSchoolInfo();

4. 이외 기능이 필요하면 최재형 문의주세요.
--%>

<script>
// 반 페이지 입장 시 반/반학생or담임교사or자녀 정보 세션에 저장
const addClassInfo = function(clasCode){
	$.ajax({
		url:"/session/enterClassPageAjax",
		method:"post",
		data:clasCode, // 반코드/학교코드는 url에서 구하든 model에서 구하든, 구현에 따라 알아서 구해야 함.
		dataType:"text",
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
	    success:function(res){
	    	// res의 결과값은 현재 무조건 0.
	    }
	})
}

//반 페이지 입장 시 학교/학교소속회원 정보 세션에 저장
const addSchoolInfo = function(schulCode){
	$.ajax({
		url:"/session/enterSchoolPageAjax",
		method:"post",
		data:schulCode, // 반코드/학교코드는 url에서 구하든 model에서 구하든, 구현에 따라 알아서 구해야 함.
		dataType:"text",
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
	    success:function(res){
	    	// res의 결과값은 현재 무조건 0.
	    }
	});
}

// 반 페이지 퇴장 시 반/반학생or담임교사or자녀 정보 세션에서 삭제
const deleteClassInfo = function(){
	$.ajax({
		url:"/session/quitSchoolPageAjax",
		method:"post",
		dataType:"text",
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
	    success:function(res){
	    	// res의 결과값은 현재 무조건 0.
	    }
	});
}

//반 페이지 퇴장 시 학교/학교소속회원 정보 세션에서 삭제
const deleteSchoolInfo = function(){
	$.ajax({
		url:"/session/quitSchoolPageAjax",
		method:"post",
		dataType:"text",
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
	    success:function(res){
	    	// res의 결과값은 현재 무조건 0.
	    }
	});
}

<%--
로그인한 회원의 회원 권한을 읽어오는 함수

사용 방법 : 
<script>
let isStdBool = isStudent(); // 꼭 변수에 담아서 사용하세요. ajax요청 서버부하 방지.
if(isStdBool){
	학생일 때 실행시키고 싶은 코드...
}
</script>

--%>
// 1차 권한 학생인지
const isStudent = function(){
	let returnData = null;
	$.ajax({
		url:"/session/isStudent",
		type:"post",
		dataType:"text",
		async:false,
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success:function(res){
			returnData = res;
		},
	});
	return returnData=="true"?true:false;
}

// 1차 권한 교직원인지
const isEmployee = function(){
	let returnData = null;
	$.ajax({
		url:"/session/isEmployee",
		type:"post",
		dataType:"text",
		async:false,
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success:function(res){
			returnData = res;
		},
	});
	return returnData=="true"?true:false;
}

// 1차 권한 학부모인지
const isParent = function(){
	let returnData = null;
	$.ajax({
		url:"/session/isParent",
		type:"post",
		dataType:"text",
		async:false,
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success:function(res){
			returnData = res;
		},
	});
	return returnData=="true"?true:false;
}

<%-- ======== --%>

// 교직원 권한 교사인지
const isPrincipal = function(){
	let returnData = null;
	$.ajax({
		url:"/session/isPrincipal",
		type:"post",
		dataType:"text",
		async:false,
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success:function(res){
			returnData = res;
		},
	});
	return returnData=="true"?true:false;
}

// 교직원 권한 교사인지
const isTeacher = function(){
	let returnData = null;
	$.ajax({
		url:"/session/isTeacher",
		type:"post",
		dataType:"text",
		async:false,
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success:function(res){
			returnData = res;
		},
	});
	return returnData=="true"?true:false;
}

// 교직원 권한 행정인지
const isAdministration = function(){
	let returnData = null;
	$.ajax({
		url:"/session/isAdministration",
		type:"post",
		dataType:"text",
		async:false,
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success:function(res){
			returnData = res;
		},
	});
	return returnData=="true"?true:false;
}

// 교직원 권한 영양사인지
const isDietitian = function(){
	let returnData = null;
	$.ajax({
		url:"/session/isDietitian",
		type:"post",
		dataType:"text",
		async:false,
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success:function(res){
			returnData = res;
		},
	});
	return returnData=="true"?true:false;
}



if("${USER_INFO}" != ''){
	console.log("로그인중인 회원 세션(\${USER_INFO})"					,"${USER_INFO}");
}
if("${SCHOOL_INFO}" != ''){
	console.log("접속중인 학교 세션(\${SCHOOL_INFO})"					,"${SCHOOL_INFO}");
}
if("${CLASS_INFO}" != ''){
	console.log("접속중인 반 세션(\${CLASS_INFO})"					,"${CLASS_INFO}");
}
if("${SCHOOL_USER_INFO}" != ''){
	console.log("접속중인 학교의 학교소속회원 세션(\${SCHOOL_USER_INFO})"	,"${SCHOOL_USER_INFO}");
}
if("${CLASS_STD_INFO}" != ''){
	console.log("접속중인 반의 반학생(자녀) 세션(\${CLASS_STD_INFO})"		,"${CLASS_STD_INFO}");
}
if("${CLASS_TCH_INFO}" != ''){
	console.log("접속중인 반의 담임교사 세션(\${CLASS_TCH_INFO})"			,"${CLASS_TCH_INFO}");
}

</script>