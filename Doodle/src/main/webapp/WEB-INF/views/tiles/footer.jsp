<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!-- sockJS -->
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<!-- STOMP -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<script src="/resources/js/jquery-3.6.0.js"></script>

<script>
// 전역변수 설정
var sock = null;
var socket = null;
var mberId = '${USER_INFO.mberId}';
// console.log("mberId>> : " + mberId);

function connectWebSocket() {
    // 웹소켓 연결
    sock = new SockJS("<c:url value="/echo"/>");
    socket = sock;
    
    sock.onopen = function () {
        console.log('Info: connection opened.');
    };
    
    sock.onmessage = onMessage; // 데이터를 전달 받았을 때 toast 생성
    
    sock.onclose = function(event) {
        // 연결이 끊겼을 때 다시 접속 시도
        setTimeout(function() {
            connectWebSocket();
        }, 5000); // 5초 후에 재접속 시도
    };
}

//toast생성 및 추가
function onMessage(evt){
    var data = evt.data;
    
    console.log("data:",data);

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

$(document).ready(function(){
	connectWebSocket(); // 페이지 로드시 웹소켓 연결
});

	
</script>
<script>
var sockJs = new SockJS("/stomp/chat");
var stomp = Stomp.over(sockJs);

stomp.connect({},function(){
	console.log("STOMP Connection");
	
// 	stomp.subscribe("/sub/chat/main/",function(){})
})
</script>

<div id="msgStack"></div>
<sec:authorize access="hasRole('A01001')">
	<div class="footer-copyright-area" style= "background: #ffd966e0;">
	    <div class="container-fluid">
	        <div class="row">
	            <div class="col-lg-12">
	                <div class="footer-copy-right">
	                	<p style="color: black;">Copyright © (주)디비디자바디부. All rights reserved</p>
	                </div>
	            </div>
	        </div>
	    </div>
	</div>
</sec:authorize>

<sec:authorize access="hasRole('A01002')">
	<div class="footer-copyright-area" style="background: rgb(0 0 0 / 82%);">
	    <div class="container-fluid">
	        <div class="row">
	            <div class="col-lg-12">
	                <div class="footer-copy-right">
	                    <p>Copyright © (주)디비디자바디부. All rights reserved</p>
	                </div>
	            </div>
	        </div>
	    </div>
	</div>
</sec:authorize>

<sec:authorize access="hasRole('A01003')">
	<div class="footer-copyright-area" style="background: rgb(0 112 255 / 88%);box-shadow: 0 8px 32px 0 rgba( 31, 38, 135, 0.37 );backdrop-filter: blur( 4px );-webkit-backdrop-filter: blur( 4px );border: 1px solid rgba( 255, 255, 255, 0.18 );">
	    <div class="container-fluid">
	        <div class="row">
	            <div class="col-lg-12">
	                <div class="footer-copy-right">
	                	<p>Copyright © (주)디비디자바디부. All rights reserved</p>
	                </div>
	            </div>
	        </div>
	    </div>
	</div>
</sec:authorize>


<!-- <div class="lobibox-notify-wrapper bottom right"> -->
<!-- 	<div -->
<!-- 		class="lobibox-notify lobibox-notify-default animated-fast fadeInDown" -->
<!-- 		style="width: 400px;"> -->
<!-- 		<div class="lobibox-notify-icon-wrapper"> -->
<!-- 			<div class="lobibox-notify-icon"> -->
<!-- 				<div> -->
<!-- 					<img src="img/notification/1.jpg"> -->
<!-- 				</div> -->
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 		<div class="lobibox-notify-body"> -->
<!-- 			<div class="lobibox-notify-title"> -->
<!-- 				Default -->
<!-- 				<div></div> -->
<!-- 			</div> -->
<!-- 			<div class="lobibox-notify-msg" style="max-height: 60px;">Lorem -->
<!-- 				ipsum dolor sit amet against apennine any created, spend loveliest, -->
<!-- 				building stripes.</div> -->
<!-- 		</div> -->
<!-- 		<span class="lobibox-close">×</span> -->
<!-- 		<div class="lobibox-delay-indicator"> -->
<!-- 			<div style="width: 73.94%;"></div> -->
<!-- 		</div> -->
<!-- 	</div> -->
<!-- </div> -->


