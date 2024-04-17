<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script type="text/javascript" src="/resources/js/commonFunction.js"></script>
<link rel="stylesheet" href="/resources/css/mainPage.css">

<script>
const goSchoolPage=function(clasCode){
	document.querySelector("#schulCodeInput").value = clasCode;
	let form = document.querySelector("#form");
	form.action = "/school/mainParent";
	form.submit();
}

const getSchoolAndChildren = function(){
	// 자녀 리스트
	$.ajax({
		url:"/school/getSchoolAndChildren",
		type:"post",
		dataType: "json",
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success:function(res){
			console.log("getSchoolAndChildren res:",res);
			
			if(res == null || res.length == 0){
				let str =`
						<div style ="text-align: center;">
						<img src ="/resources/images/school/school002.png" style ="width:70%;"/>
						</div>
						<h1>현재 가입된 학교가 없습니다. <a href ="/parents/mypage">마이페이지</a>로 이동해 자녀를 등록하세요.</h1>
						`;
					
				document.querySelector("#schListContainer").innerHTML = str;
				return;
			};

			let str = "";
			
			res.forEach(function(sch){
				str += `
						<div class = "box ver-div sch-box" onclick ="goSchoolPage('\${sch.schulCode}')">
							<h3 style ="height : 60%;">\${sch.schulNm}</h3>
							<div style ="height : 40%">
						`;
				sch.stdList.forEach(function(std){
					str += `
							<div class = "box name-box">
							<p>\${std.mberNm}<p>
							</div>
							`;
				})
				
				str += `</div></div>`;
			})
			
			document.querySelector("#schListContainer").innerHTML = str;
		},
		error : function(request, status, error){
			console.log("code: " + request.status + " message: " + request.responseText + " error: " + error)
		}
	});
};


window.onload = function(){
	getSchoolAndChildren();
}
</script>

<form id ="form" action = "">
<input type="hidden" id = "schulCodeInput" name="schulCode" value="" />
</form>

<style>
#chooseStd {
	width:700px;
	height:800px;
	margin:auto;
	margin-bottom: 60px;
	padding : 20px 40px;
}

.inner-box2 {
	padding : 40px;
}

.sch-box h3 {
	margin : auto 0px;
	margin-bottom : 7px;
	color : white;
	pointer-events: none;
}

.name-box {
	padding:5px; 
	display:inline-block; 
	width:auto;
	padding : 5px 25px;
	margin : 0px;
	margin-right: 5px;
}
.name-box p {
	margin : 0px;
	pointer-events: none;
}

.sch-box {
	background-color: var(--blue-color);
	margin:0px;
	margin-bottom : 20px;
}

.sch-box:hover {
	filter: brightness(95%);
}


</style>

<div id ="chooseStd" class = "box ver-div">
<!-- 	<div class ="inner-box2"> -->
		<div style ="margin-bottom: 20px;">
			<h3>학교 선택</h3>
		</div>

		<div id ="schListContainer" class ="ver-div">
		</div>
<!-- 	</div> -->
</div>