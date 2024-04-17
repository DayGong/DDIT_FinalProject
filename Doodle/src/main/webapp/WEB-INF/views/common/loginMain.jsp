<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
	<html lang="ko">
		<head>
			<meta charset="UTF-8">
			<meta name="viewport" content="width=device-width, initial-scale=1.0">
			<title>두들</title>
		</head>
		<!-- 폰트 -->
		<link rel="stylesheet" href="/resources/css/webfonts.css">
		<!-- 제이쿼리 -->
		<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
		<script type="text/javascript">
		$(function(){
			//시큐리티 권한 체크
			var ec = '${ec}'||'';
			if(ec !== '' && ec === 'E4') {
				alert("잘못된 권한입니다. 로그인 권한을 확인해주세요.");
			}
			
			//button인데 data-login='loginBtn'인 타입의 button
			$("button[data-login='loginBtn']").on("click", function(){
				//클릭한 버튼 객체 (data getter)
				var auth = $(this).data("auth");
				location.href="/login?auth=" + auth; //로그인폼으로 넘어가기위함
			});

			$(".join").on("click",function(){
				location.href="/signUp"; //회원가입폼으로 넘어가기위함
			});
		});
		</script>
		<style>
			body{
				font-family: "Pretendard";
				margin:0px;
			}
			
			#loginContainer{
				position:relative;
				display:flex;
				justify-content: space-between;
				padding:0px 250px;
				padding-top:250px;
				background-color:#5285ee;
				overflow:hidden;
				min-height: 762px;
			}
			#loginContainer .loginbox{
				position:relative;
				text-align:center;
				height: 320px;
				padding: 2rem;
				border-radius: 30px;
				padding:50px 20px;
				backdrop-filter: blur(4px); 
				background-color: rgba(255, 255, 255, 0.8); 
				box-shadow: 35px 35px 68px 0px rgba(145, 192, 255, 0.5), inset -6px -6px 16px 0px rgba(145, 192, 255, 0.6), inset 0px 11px 28px 0px rgb(255, 255, 255);
			}
			#loginContainer h3{
				color:#fff;
				display: block;
				position:absolute;
				top: 3%;
				left: 40%;
				z-index:1;
				font-size:2.3rem;
				
			}
			#loginContainer h3 span{
				margin-top:20px;
				display: block;
				font-size:1.2rem;
				font-weight: 400;
				text-align: center;
				cursor: pointer;
			}
			#loginContainer h3 span u{
				text-decoration: underline;
				text-underline-position: under;
			}
			#loginContainer h3 span:hover{
				font-weight:700;
				transition: all 0.5s;
			}
			#loginContainer .loginbox h4{
				font-weight:700;
				font-size:1.5rem;
				display:block;
			}
			
			/* 로그인 버튼 css */
			#loginContainer .loginbox button {
				margin: 20px;
			}
			#loginContainer .loginbox .custom-btn {
				width: 130px;
				height: 40px;
				color: #fff;
				border-radius: 5px;
				padding: 10px 25px;
				font-family: "Pretendard";
				font-weight: 600;
				background: transparent;
				cursor: pointer;
				transition: all 0.3s ease;
				position: relative;
				display: inline-block;
				 box-shadow:inset 2px 2px 2px 0px rgba(255,255,255,.5),
				 7px 7px 20px 0px rgba(0,0,0,.1),
				 4px 4px 5px 0px rgba(0,0,0,.1);
				outline: none;
			}
			#loginContainer .loginbox .btn-16 {
				border: none;
				color: #000;
			}
			#loginContainer .loginbox .btn-16:after {
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
				 7px 7px 20px 0px #0002,
				 4px 4px 5px 0px #0001;
				transition: all 0.3s ease;
			}
			#loginContainer .loginbox .btn-16:hover {
				color: #000;
			}
			#loginContainer .loginbox .btn-16:hover:after {
				left: auto;
				right: 0;
				width: 100%;
			}
			#loginContainer .loginbox:active {
				top: 5px;
			}
			#loginContainer .loginbox .img-box{
				background: url("/resources/images/member/loginMain.png");
				background-repeat: no-repeat;
				width:250px;
				height: 190px;
				overflow:hidden;
				background-size: 250px auto;
				background-position-y: -415px;
			}
			#loginContainer .parent .img-box{
				background-position-y: -230px;
				overflow:hidden;
			}
			
			
			#loginContainer .teaher .img-box{
				background-position-y: -32px;
				overflow:hidden;
			}
			
			
			
			/*회원가입 버튼 css*/
			
			#loginContainer h3 .joinBtn {
					margin: 1rem;
					background: #333;
					display: block;
					border-radius: 20px;
					text-align: center;
					color: #fff;
					padding: 15px 20px;
					font-family: 'Pretendard';
					box-shadow: none;
					border: none;
					margin: auto;
					margin-top: 13px;
					font-weight: 600;
					cursor: pointer;
					font-size:1rem;
			}
			#loginContainer h3 .join:hover .joinBtn{
				background: #fff;
				color:#333;
				transition:all 1s;
			}
			
			#loginContainer .welcome-greeting{
				position: absolute;
				top:10%;
				left:35%;
				color:#fff;
				font-weight:700;
				font-size:48px;
			}
		
		</style>
		<body>
			<div id="loginContainer">
				<div class="welcome-greeting">
					우리가 만나는 또 다른 교실 두들
				</div>
				<div class="loginbox">
					<h4>학생</h4>
					<button class="custom-btn btn-16" data-login="loginBtn" data-auth="1">로그인</button>
					<div class="img-box"></div>
				</div>
				<div class="loginbox parent">
					<h4>학부모</h4>
					<button class="custom-btn btn-16" data-login="loginBtn" data-auth="2">로그인</button>
					<div class="img-box"></div>
				</div>
				<div class="loginbox teaher">
					<h4>선생님</h4>
					<button class="custom-btn btn-16"	data-login="loginBtn" data-auth="3">로그인</button>
					<div class="img-box"></div>
				</div>
			</div>
		</body>
</html>