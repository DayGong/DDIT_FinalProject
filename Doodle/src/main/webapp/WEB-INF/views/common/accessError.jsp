<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
	#frm{
		width:500px;
		backdrop-filter: blur(6px); 
		background-color: rgba(255, 255, 255, 0.8); 
		border-radius: 20px; 
		box-shadow: 35px 35px 68px 0px rgba(145, 192, 255, 0.5), inset -9px -9px 16px 0px rgba(145, 192, 255, 0.6), inset 0px 11px 28px 0px rgb(255, 255, 255);
		padding:50px 20px;
		height: 650px;
		margin:auto;
		margin-top: 80px;
		margin-bottom: 60px;
		animation: fadein 1s;
		-moz-animation: fadein 1s; /* Firefox */
		-webkit-animation: fadein 1s; /* Safari and Chrome */
		-o-animation: fadein 1s; /* Opera */
		
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
	
	#loginFormContainer #frm h2{
		font-size:2.2rem;
		text-align:center;
		display:block;
	}
	
	#loginFormContainer	#frm .login-box{
		width:50%;
		margin:auto;
	}
	#loginFormContainer	#frm .login-box li{
		margin-top:35px;
	}
	#loginFormContainer	#frm .login-box li span{
		font-size:1.2rem;
		margin-right:20px;
		margin-bottom:10px;
	}
	#loginFormContainer	#frm .login-box li:first-child {
		margin-top:40px;
	}
	#loginFormContainer	#frm .login-box li:first-child span{
		margin-right:35px;
	}
	#loginFormContainer	#frm .login-box li input[type=text],
	#loginFormContainer	#frm .login-box li input[type=password]{
		height:45px;
		border-radius: 5px;
		border:1px solid #ddd;
		padding:10px 20px;
	}
	
	#loginFormContainer	#frm .login-box li small{
		font-size:1rem;
		text-align: center;
		display:block;
		cursor: pointer;
		font-weight:500;
	}
	#loginFormContainer	#frm .login-box li small:hover{
		color:#006DF0;
	}
	#loginFormContainer	#frm .login-box #loginBtn{
		display:block;
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
		
	/* 로그인 버튼 css */
	#loginFormContainer #frm .login-box button {
		margin: 20px;
	}
	#loginFormContainer #frm .login-box .custom-btn {
		width: 190px;
		height: 40px;
		color: #fff;
		border-radius: 5px;
		padding: 10px 25px;
		font-family: "Pretendard";
		font-weight: 600;
		background: #006DF0;
		cursor: pointer;
		transition: all 0.3s ease;
		position: relative;
		display: inline-block;
		box-shadow:inset 2px 2px 2px 0px rgba(145, 192, 255, 0.5), 7px 7px 20px 0px rgba(145, 192, 255, 0.5), 4px 4px 5px 0px rgba(145, 192, 255, 0.5);
		outline: none;
	}
	#loginFormContainer #frm .login-box .btn-16 {
		border: none;
		color: #fff;
		height: 50px;
		font-size: 1rem;
	}
	#loginFormContainer #frm .login-box .btn-16:after {
		position: absolute;
		content: "";
		width: 0;
		height: 100%;
		top: 0;
		left: 0;
		direction: rtl;
		z-index: -1;
		box-shadow:
		 -7px -7px 20px 0px #fff9,
		 -4px -4px 5px 0px #fff9,
		 7px 7px 20px 0px rgba(145, 192, 255, 0.5),
		 4px 4px 5px 0px rgba(145, 192, 255, 0.5);
		transition: all 0.3s ease;
	}
	#loginFormContainer #frm .login-box .btn-16:hover {
		color: #fff;
		text-decoration: underline;

		text-underline-position : under;
	}
	#loginFormContainer #frm .login-box .btn-16:hover:after {
		left: auto;
		right: 0;
		width: 100%;
	}
	#loginFormContainer #frm .login-box .btn-16:active {
		top: 5px;
	}
</style>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script type="text/javascript">
$(function(){
	$("#loginBtn").on("click",function(){
			let mberId = $("#mberId").val();
			let password = $("#password").val();
			let data = {"mberId" : mberId,
						 "password" : password};
			$.ajax({
			url:"/login",
			contentType:"application/json;charset=utf-8",
			data:JSON.stringify(data),
			type:"post",
			dataType:"text",
			beforeSend:function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			},
			success:function(result){
				alert("성공");
			}
		});
	});
});
</script>
<div id="loginFormContainer">
	<form id="frm" action="/login" method="post">
		<h2>로그인</h2>
		<ul class="login-box">
			<li>
				<span>아이디</span>
				<input type="text" name="username" id="mberId">
			</li>
			<li>
				<span>비밀번호</span>
				<input type="password" name="password" id="password">
			</li>
			<li>
				<small>아이디/비밀번호찾기</small>
			</li>
			<li>
				<button type="submit" class="custom-btn btn-16">로그인</button>
			</li>
		</ul>
		<sec:csrfInput />
	</form>
</div>