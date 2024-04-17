<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>  


<script>
<%--
checkCl() : 
URL중에 clasCode가 파라미터로 존재하는 반페이지에 접근했을 때 접근한 회원이 해당 반에 속하는지 판단.
반에 속하지 않은 회원이 주소창에 URL을 쳐서 접근하는 것을 방지한다.
뿐만 아니라 이 함수를 사용하면 자동으로 반/반학생or담임교사 정보가 session에 저장됨.

사용 방법 :
1. url?clasCode=CL10000001 형태의 주소일 때
<script>
checkCl("${param.clasCode}");
</script>
	
2. 컨트롤러에서 clasCode를 model에 담아 jsp로 넘겼을 때 
<script>
checkCl("${clasCode}"); // VO로 담았으면 ${VO명.clasCode} 등 정확한 구조는 알아서 기입
</script>

--%>
const checkCl = function(clasCode){
	if(clasCode==""){
		return;
	}
	
	$.ajax({
		url:"/check/checkBelongClwithRb",
		type:"post",
		contentType:"application/json",
		data:clasCode,
		dataType:"text",
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success:function(res){
			if(res==0){
				location.href = "/main";
			}
		},
		error:function(request, status, error){
			console.log("request : ",request);
			console.log("status : ",status);
			console.log("error : ",error);
		}
	});
}

<%-- 
학교 체크는 개발중
--%>
</script>