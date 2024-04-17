<%@ page language="java" contentType="text/html; charset=UTF-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko" data-dark="false" class="con">
<head>
<style type="text/css">

</style>
<meta charset="utf-=8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Doodle employee List</title>
<link rel="stylesheet" href="/resources/chat/CSS/main-layout.css" />
<link rel="stylesheet" href="/resources/chat/CSS/friend.css" />
<link rel="stylesheet" href="/resources/chat/CSS/general.css" />
<link rel="preconnect" href="https://fonts.gstatic.com" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" />
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap" rel="stylesheet" />
<link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
    rel="stylesheet"
    integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
    crossorigin="anonymous"
/>
<link rel="stylesheet" href="/resources/css/sweetalert2.min.css">
<script src="/resources/css/sweetalert2.min.js"></script>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<!-- sockJS -->
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
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
<script type="text/javascript">
//모달 열고 모달에 정보넣기
function openModal(e, mberNm, mberImage, mberId, moblphonNo, mberEmail, mberAdres) {
    var modalTitle = document.querySelector('.modal-title');
    var modalBody = document.querySelector('.modal-body');

    modalTitle.textContent = mberNm; // 모달 제목 변경
    modalBody.innerHTML +="<input type='text' name='friend' value='" + mberId + "' style='display:none;' />"
	
    if(mberImage=='null'||mberImage==''){
		$("#profileImg").attr("src", "/resources/images/member/profile/user_l.png");
	}else{
		$("#profileImg").attr("src", "/upload/profile/" + mberImage);
	}
	$("#memPh").text("☎" + moblphonNo);
	$("#memMail").text("✉" + mberEmail);
	$("#memAddr").text("🏠" + mberAdres);
	
    $('.modal').css('display', 'block');
}
        
//모달 닫기
function closeModal() {
    $('.modal').css('display', 'none');
}

$(function () {
	
	let target = $("#chatting");
	console.log("target:",target);
	
	//대화하기
	$("#chatting").on("click",function(){
		let myId = '${USER_INFO.mberId}';
		
		let schulCode = '${param.schulCode}';
		
		let friend = $('input[name="friend"]').map(function() {
		    return this.value;
		}).get().join(',');
		
		
		//내가 생성한 방이 있나 확인
		let data = {
			"crtrId":friend,
   			"prtcpntId":myId
		}
		
		$.ajax({
		 	url: '/chat/roomCode',
            type: 'post',
            data: JSON.stringify(data),
            contentType: 'application/json;charset=utf-8',
            dataType: 'text',
            beforeSend: function (xhr) {
                xhr.setRequestHeader('${_csrf.headerName}', '${_csrf.token}');
            },
            success: function (result) {
           	//result가 있으면 내가 생성한 방이 있으므로 생성된 방으로 이동
           	if(result !='' && result != null){
          		location.href = "/chat/chtt?chttRoomCode="+result;
          	}
           	 //result가 없으면 내가 초대 받은 방이 있는지확인 
           	 else{
           		 let data = {
         			"crtrId":myId,
             		"prtcpntId":friend	 
           		 }
           		 
           		$.ajax({
          			 url: '/chat/roomCode',
                       type: 'post',
                       data: JSON.stringify(data),
                       contentType: 'application/json;charset=utf-8',
                       dataType: 'text',
                       beforeSend: function (xhr) {
                           xhr.setRequestHeader('${_csrf.headerName}', '${_csrf.token}');
                       },
                       success: function (result) {
                      	//result가 있으면 내가 초대 받은 방이 있으므로 초대 받은 방으로 이동
                        if(result != '' && result != null){
                       		location.href = "/chat/chtt?chttRoomCode="+result;
                       	}
                      	 //result가 0이면 채팅방 생성
                      	 else{
                      		let data = {
                        			"type":"room",
                        			"schulCode":schulCode,
                        			"clasCode":"",
                        			"crtrId":friend,
                        			"prtcpntId":myId
                        		}
                        		
                        		
                        		$.ajax({
                        			 url: '/chat/room',
                                     type: 'post',
                                     data: JSON.stringify(data),
                                     contentType: 'application/json;charset=utf-8',
                                     dataType: 'json',
                                     beforeSend: function (xhr) {
                                         xhr.setRequestHeader('${_csrf.headerName}', '${_csrf.token}');
                                     },
                                     success: function (result) {
                                    	 
                                    	 $.ajax({
                                  			 url: '/chat/roomCode',
                                               type: 'post',
                                               data: JSON.stringify(data),
                                               contentType: 'application/json;charset=utf-8',
                                               dataType: 'text',
                                               beforeSend: function (xhr) {
                                                   xhr.setRequestHeader('${_csrf.headerName}', '${_csrf.token}');
                                               },
                                               success: function (result) {
                                            	   //result가 있으면 내가 만든 방이 있으므로 만든 방으로 이동
                                                   if(result != '' && result != null){
                                                  		socket.send("room,"+friend+","+myId+","+result);	
                                                  		location.href = "/chat/chtt?chttRoomCode="+result;
                                                  	}
                                            	   else{
                                            		   var Toast = Swal.mixin({
                                            			   toast: true,
                                       					   position: 'top-end',
                                       					   showConfirmButton: true,
                                       					   timer: 3000
                                       				   });
                                       				   Toast.fire({
                                       					   icon:'error',
                                       					   title:'채팅방 만들기 실패'
                                       				   });
                                            		   return;
                                            	   }
                                               },
                                               error:function(xhr){
                                               } 
                                         });
                                    	 
                                    	 
                                     },
                                     error:function(xhr){
                                     }
                        		});
                      	 }
                      	 
                       },
                       error:function(xhr){
                       }
          			});
           		 
           	 }
           	 
            },
            error:function(xhr){
            }
		});
	});
	
    // 교직원 목록
   	let data = {
        //  	"member":"${USER_INFO}",
        schulCode: '${param.schulCode}',
    };

    $.ajax({
        url: '/chat/friends',
        type: 'post',
        data: JSON.stringify(data),
        contentType: 'application/json;charset=utf-8',
        dataType: 'json',
        beforeSend: function (xhr) {
            xhr.setRequestHeader('${_csrf.headerName}', '${_csrf.token}');
        },
        success: function (result) {
            /* result : List<SchulPsitnMberVO> */

            let str = '';
            /* 설정바(최소화, 닫기 버튼 등) */
            str += "<div class='setting_bar'>";
            str += "</div>";
            /* 헤더: 제목, 친구 찾기 버튼, 친구 추가 버튼 */
            str += "<header>";
            str += "<div style='display: flex; justify-content: space-between;'>";
            str += "<div>";
            str += "<h1>교직원</h1>";
            str += "</div>";
            str += "<div>";
            str += "</div>";
            str += "</div>";
            str += "</header>";
            /* 메인: 친구창 메인 내용 */
            str += "<main id='mainBody'>";
            str += "<div>";
            str += "<ul>";
            str += "<li>";
            if('${USER_INFO.mberImage}'==null||'${USER_INFO.mberImage}'==''){
            	str += "<img src='/resources/images/member/profile/user_l.png' alt=''>";
            }else{
            	str += "<img src='/upload/profile/${USER_INFO.mberImage}' alt=''>";
            }
            str += "<div class='profile'>";
            str += "<p>${USER_INFO.mberNm}</p>";
            str += "</div>";
            str += "</li>";
            str += "</ul>";
            str += "</div>";
            /* 친구 프로필 모음 */
            str += "<div>";
            str += "<div class='profile-title'>";
            str += "<h2>교직원</h2>";
            str += "<p>"+result.length+"</p>";
            str += "</div>";
            str += "<ul id='friendBody'>";
            $.each(result, function (idx, SchulPsitnMberVO) {

                str += "<li class='friend-li' onclick='openModal(this, \"" + SchulPsitnMberVO.memberVO.mberNm + "\", \"" + SchulPsitnMberVO.memberVO.mberImage + "\",\"" + SchulPsitnMberVO.memberVO.mberId + "\",\"" + SchulPsitnMberVO.memberVO.moblphonNo + "\",\"" + SchulPsitnMberVO.memberVO.mberEmail + "\",\"" + SchulPsitnMberVO.memberVO.mberAdres + "\")'>";
				if(SchulPsitnMberVO.memberVO.mberImage==null||SchulPsitnMberVO.memberVO.mberImage==''){
                	str += "<img src='/resources/images/member/profile/user_l.png' alt=''>";
				}else{
                	str += "<img src='/upload/profile/" + SchulPsitnMberVO.memberVO.mberImage + "' alt=''>";
				}
                str += "<p style='display:none;'>" + SchulPsitnMberVO.mberId + "</p>";
                str += "<div class='profile'>";
                str += "<p>" + SchulPsitnMberVO.memberVO.mberNm + "</p>";
                str += "<p>" + SchulPsitnMberVO.cmmnEmpClsf + "</p>";
                str += "</div>";
                str += "</li>";
            });

            str += "</ul>";
            str += "</div>";
            str += "</main>";
            str += "<aside>";
            
            str += "<div class='main-menu' style='display: flex; justify-content: space-evenly;'>";
            str += "<a href='/chat/friends?schulCode=" + result[0].schulCode + "' id='friendList'>";
            str += "<i class='fa-solid fa-user' alt='친구메뉴' title='친구'></i>";
            str += "</a>";
            str += "<a href='/chat/rooms?schulCode=" + result[0].schulCode + '&mberId='+'${USER_INFO.mberId}'+"' id = 'friend'>";
            str += "<i class='fa-solid fa-comment' alt='채팅메뉴' title='채팅'></i>";
			str += "</div>";
            str += "</aside>";
            $('#content').html(str);
            
            //나가기 클릭시 창 종료
            $("#button-out").on("click",function(){
            	window.close();
            });
        },
    });
});	
</script>
</head>
<body class="sidebar-mini sidebar-closed sidebar-collapse">
<div id="msgStack"></div>
<div id="content">

</div>
<div class="modal" tabindex="-1">
	<div class="modal-dialog">
		<div class="modal-content" style="border-radius: 26px;">
			<div class="modal-header" style="border-bottom: 0px;">
				<h5 class="modal-title">Modal title</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close" onclick="closeModal()" style="position: absolute; margin-left: 200px;"></button>
			</div>
			<div class="modal-body">
				<div class="profile-img" style="text-align: center;">
			        <img id="profileImg" src="" alt="">
				</div>
				<div class="single-product-text">
					<p style="margin-bottom: 2px" class="ctn-cards" id="memPh"></p>
					<p style="margin-bottom: 2px;" id="memMail"></p>
					<p style="margin-bottom: 2px;" id="memAddr"></p>
				</div>
			</div>
			<div class="modal-footer" style="border-top: 0px">
				<button type="button" class="btn btn-primary" id="chatting">대화하기</button>
				<button type="button" class="btn btn-secondary"
					data-bs-dismiss="modal" onclick="closeModal()">닫기</button>
			</div>
		</div>
	</div>
</div>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
	crossorigin="anonymous"></script>
</body>
</html>




						