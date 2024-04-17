<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html class="con">
<head>
<meta charset="utf-=8">
<title>DoodleChat Rooms</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta http-equiv="X-UA-Compatible" content="IE-edge">
<meta name="description" content="Kakao Talk Clone Chat Main Page">
<meta name="keywords" content="KakaoTalk, Clone, Chat">
<meta name="robotos" content="noindex, nofollow">
<link rel="stylesheet" href="/resources/chat/CSS/main-layout.css">
<link rel="stylesheet" href="/resources/chat/CSS/chatting.css">
<link rel="stylesheet" href="/resources/chat/CSS/general.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap"
	rel="stylesheet">
<link rel="stylesheet" href="/resources/css/sweetalert2.min.css">
<script src="/resources/css/sweetalert2.min.js"></script>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<!-- sockJS -->
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>

<script type="text/javascript">
const clasCode = '${param.clasCode}';
const mberId = '${USER_INFO.mberId}';
const mberNm = '${USER_INFO.mberNm}';

$(function(){
	
	//나의 채팅방 목록
	var data = {
		"clasCode":clasCode,
		"mberId":mberId
	};
	
	$.ajax({
		   url:"/chat/clasFamRooms",
		   type:"post",
		   data:JSON.stringify(data),
		   contentType:"application/json;charset=utf-8",
		   dataType:"json",
		   beforeSend:function(xhr){
		      xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		   },
		   success:function(result){
		      /* result : List<ChttRoomVO> */
		      
		      let str = "";
		      
		      $.each(result,function(idx,chttRoomVO){
		    	  let crtrImage = chttRoomVO.crtrVO.mberImage;
		    	  let prtcpntImage = chttRoomVO.prtcpntVO.mberImage;
			      
		    	  str += "<li class='room-li'>";
		    	  str += "<a href='/chat/chtt?chttRoomCode=" + chttRoomVO.chttRoomCode + "'> ";
		    	  // if문으로 chttRoomVO.crtrId 일때와 chttRoomVO.prtcpntId 일때 구분 필요
		    	  if(mberNm === chttRoomVO.crtrId){
		    		  if(prtcpntImage==null||prtcpntImage==''){
		              	str += "<img src='/resources/images/teacher/루피1.png' class='profile-img' alt=''>";
					  }else{
						str += "<img src='/upload/profile/" + prtcpntImage + "' class='profile-img' alt=''>";
					  }
			    	  str += "<div class='talk'>";
		    		  str += "<p class='friend-name'>"+chttRoomVO.prtcpntId+"</p>";
		    	  }else{
		    		  str += "<img src='/upload/profile/" + crtrImage + "' class='profile-img' alt=''>";
			    	  str += "<div class='talk'>";
		    		  str += "<p class='friend-name'>"+chttRoomVO.crtrId+"</p>";
		    	  }
		    	  str += "</div>";
		    	  str += "<div class='chat-status'>";
		    	  str += "</div>";
		    	  str += "</a>";
		    	  str += "</li>";
		      });
		   	  $("#chatRoomBody").html(str);
			}
	});
})
</script>
<script>
// 전역변수 설정
var socket  = null;

$(document).ready(function(){
    // 웹소켓 연결
    sock = new SockJS("<c:url value="/echo"/>");
    socket = sock;
	
    sock.onopen = function () {
        
    };
    
 	// 데이터를 전달 받았을때 
    sock.onmessage = onMessage; // toast 생성
    
});

// toast생성 및 추가
function onMessage(evt){
    var data = evt.data;
    

    var Toast = Swal.mixin({
		toast: true,
		position: 'top-end',
		showConfirmButton: true,
		timer: 5000
	});
	Toast.fire({
		icon:'info',
		title: data
	});
    
};	
</script>
</head>
<body  class="sidebar-mini sidebar-closed sidebar-collapse">
	<div id="content">
		<!-- 설정바(최소화, 닫기 버튼 등) -->
		<div class="setting_bar">
		</div>
		<!-- 헤더: 제목, 친구 찾기 버튼, 친구 추가 버튼 -->
		<header>
			<div style="display: flex; justify-content: space-between;">
			<div>
				<h1>채팅</h1>
				<i class="fa-solid fa-caret-down"></i>
			</div>
			<div>
			</div>
			</div>
		</header>
       
		<!-- 메인: 채팅 리스트 화면 -->
		<main>
			<div class="myChatrooms">
				<h4>반 채팅방</h4>
			</div>
			
			<div id="chatRoomBodys">
				<ul id="chatRoomBody">

				</ul>
			</div>
		</main>
		<aside>
           <div class="main-menu" style="display: flex; justify-content: space-evenly;">
               <a href="/chat/clasFam?clasCode=${param.clasCode}">
                   <i class="fa-solid fa-user" alt="친구메뉴" title="친구"></i>
               </a>
               <a href="/chat/clasFamRooms?clasCode=${param.clasCode}&mberId=${USER_INFO.mberId}">
                   <i class="fa-solid fa-comment" alt="채팅메뉴" title="채팅"></i>
               </a>
           </div>
       </aside>
	</div>
</body>
</html>