<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
	$(function(){
		$("#insertBtn").on("click", function(){
			
			var frm = new FormData($("#frm")[0]);
			
			$.ajax({
				url : "",
				processData:false,
				contentType:false,
				data:frm,
				dataType:"text",
				type:"post",
				beforeSend:function(xhr){
					xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
				},
				success:function(result){
					console.log("result : ", result);
					if(result==1){
						alert("등록성공");
						location.href="";
					}else{
						alert("등록실패");
					}
				}
			})
			
		});
	});
</script>
<style>
#signUpContainer{
	color:#333;
	font-family: 'Pretendard';
	padding:60px 80px;
	background-color: rgba(255, 255, 255, 0.6);
	border-radius: 26px;
	backdrop-filter: blur(6px);
	box-shadow: 0px 35px 68px 0px rgba(145, 192, 255, 0.5), inset 0px -8px 16px 0px rgba(145, 192, 255, 0.6), inset 0px 11px 28px 0px rgb(255, 255, 255);
}
#signUpContainer h2{
	text-align:center;
	font-size:2rem;
	
}
#signUpContainer input{
	height:40px;
	border:1px solid #ddd;
	border-radius:5px;
}
#signUpContainer span{
	font-size:1.2rem;
	font-weight:600;
	
}
</style>

<!-- 회원가입 폼 전체 -->
<div id="signUpContainer">
	<h2 style="font-weight:600;">
		회원가입 
		<img src="..\resources\images\member\signUp1.png" style="width:50px;">
	</h2>
	<form id="frm">
		<ul>
			<li>
				<span>회원 성함</span>
				<input type="text" name="title">
			</li>
			<li>
				<span>아이디</span>
				<input type="text" name="description">
			</li>
			<li>
				<span>비밀번호</span>
				<input type="text" name="category">
			</li>
			<li>
				<span>비밀번호 확인</span>
				<input type="text" name="category">
			</li>
			<li>
				<span>썸네일</span>
				<input type="file" multiple="multiple" name="upload">
			</li>
		</ul>
		<p>
			<button type="button" id="insertBtn">
				회원가입하기
			</button>
			<button type="button" id="goList" onclick="javascript:location.href=''">
				목록
			</button>
		</p>
	</form>
</div>