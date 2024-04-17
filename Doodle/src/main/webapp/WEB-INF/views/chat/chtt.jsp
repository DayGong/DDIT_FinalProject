<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Doodle Chat</title>
<script src="https://code.jquery.com/jquery-2.2.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sockjs-client/dist/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<script type="text/javascript" src="/resources/js/commonFunction.js"></script>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<link rel="stylesheet" href="/resources/chat/CSS/chat-room.css">
<link rel="stylesheet" href="/resources/chat/CSS/general.css">
<link rel="stylesheet" href="/resources/css/mainPage.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap">
<style type="text/css">

</style>
</head>
<body>
<div id="chat-body" style="position: relative;">
    <!-- 설정바(최소화, 닫기 버튼 등) -->
    <div class="setting_bar">
		<button class="btn-out" type="button" id="button-out" style="color: #fff">뒤로가기</button>
    </div>
    <!-- 알림, 메뉴 기능 -->
    <div class="main-menu">
    </div>
    <!-- 프로필 사진, 프로필명 -->
    <header class="chat-head" style="justify-content: center;">
        <div class="profile-col">
		<c:choose>
			<c:when test="${USER_INFO.mberId eq chttRoomVO.prtcpntId}">
				<c:choose>
				<%-- 프로필이 있는 경우 --%>
	                <c:when test="${chttRoomVO.crtrVO.mberImage != null}">
	                    <img class="profile-img" src="/upload/profile/${chttRoomVO.crtrVO.mberImage}" alt="">
	                </c:when>
	                <%-- 프로필이 없는 경우 --%>
	                <c:otherwise>
	                    <img class="profile-img" src="/resources/images/member/profile/user_l.png" alt="" />
	                </c:otherwise>
                </c:choose>
				<span class="profile-name" style="font-size: 1.8rem;">${chttRoomVO.crtrVO.mberNm}</span>
			</c:when>
			<c:when test="${USER_INFO.mberId eq chttRoomVO.crtrId}">
				<c:choose>
					<%-- 프로필이 있는 경우 --%>
	                <c:when test="${chttRoomVO.prtcpntVO.mberImage != null}">
	                    <img class="profile-img" src="/upload/profile/${chttRoomVO.prtcpntVO.mberImage}" alt="">
	                </c:when>
	                <%-- 프로필이 없는 경우 --%>
	                <c:otherwise>
	                    <img class="profile-img" src="/resources/images/member/profile/user_l.png" alt="" />
	                </c:otherwise>
                </c:choose>
				<span class="profile-name" style="font-size: 1.8rem;">${chttRoomVO.prtcpntVO.mberNm}</span>
			</c:when>	
		</c:choose>
        </div>
    </header>
    <main>
        <!-- 채팅 내용 시작 -->
        <div id="chatBody">
	        <div class="chat-content con" id="chatContent">
	            <!-- 채팅 내용 -->
	            <div id="msgArea" class="col"></div>
	        </div>
	        <!-- 채팅 입력창 -->
	        <div class="insert-content">
	            <form name="chatform" action="#" method="post">
	                <input type="text" id="msg" class="form-control" name="msg" required style="border: 3px solid black; height: 55px; font-size: 1.5rem;"/>
	                <div class="input-group-append">
			        	<button class="btn-send" type="button" id="button-auto">
			        		<i class="fa-solid fa-pen-to-square"></i>
			        	</button>
			        	<button class="btn-send" type="button" id="button-send">전송</button>
			          </div>
	            </form>
	        </div>
        </div>
    </main>
</div>
</body>
<script>
// 전역변수 설정
var socket  = null;
var crtrId = '${chttRoomVO.crtrId}';
var crtrNm = '${chttRoomVO.crtrVO.mberNm}';
var crtrImage = '${chttRoomVO.crtrVO.mberImage}';
var prtcpntId = '${chttRoomVO.prtcpntId}';
var prtcpntNm = '${chttRoomVO.prtcpntVO.mberNm}';
var prtcpntImage = '${chttRoomVO.prtcpntVO.mberImage}';

$(document).ready(function(){
    // 웹소켓 연결
    sock = new SockJS("<c:url value="/echo"/>");
    socket = sock;
	
    sock.onopen = function () {
    	
    };
    
    
});

</script>
<script>
	var date = new Date();
	var year = date.getFullYear();	// 년	
	var month = date.getMonth() + 1;	// 월
	var day = date.getDate();			// 일
	var dayLabel = date.getDay();		// 요일을 나타내는 숫자
	var hours = getHours() 			// 시
	var minutes = date.getMinutes(); 	// 분
	var seconds = date.getSeconds();	// 초
	
	//요일을 나타내는 숫자를 요일로 바꾸기
    function getTodayLabel() {        
    	var week = new Array('일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일');        
    	var today = date.getDay();    
    	var todayLabel = week[today];        
    	return todayLabel;
    }
	
	//시간만들기
	function getHours(){
		let h = date.getHours()%12 == 0 ? 12 : date.getHours()%12;
		if(h < 10) h = "0" + h;
		
		return h;
	}
	
	//오전 오후 구하기
	function getAmPm() {    
		let h = date.getHours() < 12 ? "오전" : "오후";  
		
		return h;
	}

	function dateToAmPmFormat(date){
		var selectDate = new Date(date);
		var d = selectDate.getDate();
		var m = selectDate.getMonth() + 1;
		var y = selectDate.getFullYear();
		var hour = selectDate.getHours()%12 == 0 ? 12 : selectDate.getHours()%12;
		var min = selectDate.getMinutes();
		var amPm = getAmPm();
	   
		if(m < 10)    m    = "0" + m;
		if(d < 10)    d    = "0" + d;
		if(hour < 10) hour = "0" + hour;
		if(min < 10)  min  = "0" + min;
	   
// 		return y + "-" + m + "-" + d + " " + amPm + " " + hour + ":" + min; 
		return amPm + " " + hour + ":" + min; 
	}
	
	function dateFormat(date){
		// 숫자가 아니면 숫자로 변환
		if (!isNaN(date)) { time = Number(date); }
		
		var selectDate = new Date(date);
		var d = selectDate.getDate();
		var m = selectDate.getMonth() + 1;
		var y = selectDate.getFullYear();
	   
		if(m < 10) m = "0" + m;
		if(d < 10) d = "0" + d;
	   
		return y + "년 " + m + "월" + d + "일"; 
	}
	
	function dateToMinFormat(date){
	   var selectDate = new Date(date);
	   var d = selectDate.getDate();
	   var m = selectDate.getMonth() + 1;
	   var y = selectDate.getFullYear();
	   var hour = selectDate.getHours();
	   var min = selectDate.getMinutes();
	   var sec = selectDate.getSeconds();
	   
	   if(m < 10)    m    = "0" + m;
	   if(d < 10)    d    = "0" + d;
	   if(hour < 10) hour = "0" + hour;
	   if(min < 10)  min  = "0" + min;
	   if(sec < 10)  sec  = "0" + sec;
	   
	   return y + "-" + m + "-" + d + " " + hour + ":" + min + ":" + sec; 
	}
	
	var bottom =  function () {
	  var chatContent = document.querySelector('#chatContent');
	  chatContent.scrollTop = chatContent.scrollHeight;
	}

  $(document).ready(function(){
	  
	// 페이지가 시작할 때 chatContent의 끝으로 스크롤 이동
	setTimeout(bottom, 800); 
	  
	
	//채팅 방 이름, 방 ID 및 사용자 이름을 입력 받습니다.
    var chttRoomCode = '${chttRoomVO.chttRoomCode}';
    var schulCode = '${chttRoomVO.schulCode}';
    var dsptchNm = '${USER_INFO.mberNm}';
    var dsptchId = '${USER_INFO.mberId}';
    var chttDt = dateToAmPmFormat(date);	
    var chttSn = "";


    var sockJs = new SockJS("/stomp/chat");
    //1. SockJS를 내부에 들고있는 stomp를 내어줌
    var stomp = Stomp.over(sockJs);

    //2. connection이 맺어지면 실행
    stomp.connect({}, function (){
      
      //채팅내역 불러오기
       $.ajax({
    	url: "/chat/chtt",
        type: "post",
        data: chttRoomCode,
        dataType: "json",
        beforeSend: function(xhr) {
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
        },
        success: function(result) {
        	var res = JSON.stringify(result);
        	var chtt = JSON.parse(res);
        	
        	$.each(chtt,function(idx,chttVO){
        		if(chttVO.dsptchNm === dsptchNm){
       	       	  str = "<div class='me-chat'>";
       	          if(dsptchId == crtrId){
       	        	  if(crtrImage){
     	          		str += "<img class='profile-img' src='/upload/profile/" + crtrImage + "' alt=''>";
       	        	  }else{
       	        		str += "<img class='profile-img' src='/resources/images/member/profile/user_l.png' alt=''>";
       	        	  }
      	          }else{
      	        	  if(prtcpntImage){
      	        		str += "<img class='profile-img' src='/upload/profile/" + prtcpntImage + "' alt=''>";
      	        	  }else{
      	        		str += "<img class='profile-img' src='/resources/images/member/profile/user_l.png' alt=''>";
      	        	  }
      	          }
       	          str += "<div class='me-chat-col'>";
       	          str += "<span class='my-profile-name'>"+chttVO.dsptchNm+"</span>";
       	          str += "<span class='balloon'>" + chttVO.chttCn + "</span>";
      	          str += "<time style='margin-top: 10px;' id='sendTime' datetime='"+hours+":"+minutes+":"+seconds+"+09:00'>"+dateToAmPmFormat(chttVO.chttDt)+"</time></div></div>";
       	        }
       	        else{
       	          str = "<div class='friend-chat'>";
       	          if(dsptchId == crtrId){
       	        	  if(prtcpntImage){
      	          		str += "<img class='profile-img' src='/upload/profile/" + prtcpntImage + "' alt=''>";
       	        	  }else{
       	        		str += "<img class='profile-img' src='/resources/images/member/profile/user_l.png' alt=''>";
       	        	  }
       	          }else{
       	        	  if(crtrImage){
       	        		str += "<img class='profile-img' src='/upload/profile/" + crtrImage + "' alt=''>";
       	        	  }else{
       	        		str += "<img class='profile-img' src='/resources/images/member/profile/user_l.png' alt=''>";
       	        	  }
       	          }
       	          str += "<div class='friend-chat-col'>";
       	          str += "<span class='profile-name'>"+chttVO.dsptchNm+"</span>";
       	          str += "<span class='balloon'>" + chttVO.chttCn + "</span>";
      	          str += "<time style='margin-left: auto;' id='receiveTime' datetime='"+hours+":"+minutes+":"+seconds+"+09:00'>"+dateToAmPmFormat(chttVO.chttDt)+"</time></div></div>";
       	        }
       	        $("#msgArea").append(str);
        	});
        }
	});
	
      //4. subscribe(path, callback)으로 메세지를 받을 수 있음
      stomp.subscribe("/sub/chat/room/" + chttRoomCode, function (chat) {
        var content = JSON.parse(chat.body);

        var writer = content.writer;
        var chttCn = content.chttCn;
       	chttDt = new Date();
        var str = '';
        
        
        if(writer === dsptchNm){
          str = "<div class='me-chat'>";
          if(dsptchId == crtrId){
        	  if(crtrImage){
        		str += "<img class='profile-img' src='/upload/profile/" + crtrImage + "' alt=''>";
        	  }else{
        		str += "<img class='profile-img' src='/resources/images/member/profile/user_l.png' alt=''>";
        	  }
  		  }else{
  			if(prtcpntImage){
          		str += "<img class='profile-img' src='/upload/profile/" + prtcpntImage + "' alt=''>";
        	}else{
        		str += "<img class='profile-img' src='/resources/images/member/profile/user_l.png' alt=''>";
        	}
  	      }
          str += "<div class='me-chat-col'>";
          str += "<span class='my-profile-name'>"+writer+"</span>";
          str += "<span class='balloon'>" + chttCn + "</span>";
          str += "<time style='margin-top: 10px;' id='sendTime' datetime='"+hours+":"+minutes+":"+seconds+"+09:00'>"+dateToAmPmFormat(chttDt)+"</time></div></div>";
          setTimeout(bottom, 80); 
        }
        else{
          str = "<div class='friend-chat'>";
          if(dsptchId == crtrId){
        	  if(crtrImage){
        		str += "<img class='profile-img' src='/upload/profile/" + crtrImage + "' alt=''>";
        	  }else{
        		str += "<img class='profile-img' src='/resources/images/member/profile/user_l.png' alt=''>";
        	  }
		  }else{
			  if(crtrImage){
        		str += "<img class='profile-img' src='/upload/profile/" + crtrImage + "' alt=''>";
        	  }else{
        		str += "<img class='profile-img' src='/resources/images/member/profile/user_l.png' alt=''>";
        	  }
	      }
          str += "<div class='friend-chat-col'>";
          str += "<span class='profile-name'>"+writer+"</span>";
          str += "<span class='balloon'>" + chttCn + "</span>";
          str += "<time style='margin-left: auto;' id='receiveTime' datetime='"+hours+":"+minutes+":"+seconds+"+09:00'>"+dateToAmPmFormat(chttDt)+"</time></div></div>";
          setTimeout(bottom, 80); 
        }
        $("#msgArea").append(str);
      });

      //3. send(path, header, message)로 메세지를 보낼 수 있음
      stomp.send('/pub/chat/enter', {}, JSON.stringify({chttRoomCode: chttRoomCode, writer: dsptchNm}))
    });

    $("#button-send").on("click", function(e){
      var msg = document.getElementById("msg");
      var chttCn = msg.value;
      var type = "chtt";

      
      socket.send(type+","+chttRoomCode+","+dsptchId+","+dsptchNm+","+chttCn+","+crtrId+","+prtcpntId);
      stomp.send('/pub/chat/message', {}, JSON.stringify({chttRoomCode: chttRoomCode, chttDt: chttDt, chttCn: chttCn, writer: dsptchNm, dsptchId: dsptchId, chttSn: chttSn, dsptchNm: dsptchNm}));
      msg.value = '';
      
    });
    
    //나가기 버튼 클릭 이벤트를 처리하는 함수를 정의
    $("#button-out").on("click",function(){
  		//Stomp 연결을 종료하고, 다른 페이지로 이동
    	stomp.disconnect();
  		
    	window.history.back();
    })
    
    var msg = document.getElementById("msg");
    
    //메시지 입력 창에서 키보드 입력 이벤트를 처리하는 함수를 정의
    msg.addEventListener("keypress", function (event) {
    	//입력된 키가 Enter 키인 경우
	    if (event.key === "Enter") {
	    	//폼의 디폴트 동작을 중지하고, 전송 버튼을 클릭
	        event.preventDefault();
	        document.getElementById("button-send").click();
	    }
	});
  
    //자동 입력
    $("#button-auto").on("click",function(){
	    //학부모일 경우
	    <sec:authorize access = "hasRole('A01003')" >
	    	$("#msg").val("오늘 상담 신청해도 될까요? ");
	    </sec:authorize>
	    
	  	//담임일 경우
	    <sec:authorize access = "hasRole('A14002')" >
			$("#msg").val("넵 신청해주세요 ㅎㅎ");
		</sec:authorize>
    });
  });
  
</script>
</html>