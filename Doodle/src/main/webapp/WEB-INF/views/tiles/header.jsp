<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<style>
.modal-body {
	padding: 30px;
}
#studentAuth:before{
	color:#333;
}

a:hover, a:focus {
  outline: none;
}
/*학생권한 메뉴css*/
.SMN_effect-3 a:after {
  position: absolute;
  top: 100%;
  left: 0;
  width: 100%;
  height: 1px;
  background: #776B5D;
  content: '';
  opacity: 0;
  -webkit-transition: height 0.3s, opacity 0.3s, -webkit-transform 0.3s;
  -moz-transition: height 0.3s, opacity 0.3s, -moz-transform 0.3s;
  transition: height 0.3s, opacity 0.3s, transform 0.3s;
  -webkit-transform: translateY(-10px);
  -moz-transform: translateY(-10px);
  transform: translateY(-10px);
}

.SMN_effect-3 a:hover:after, .SMN_effect-3 a:focus:after {
  height: 5px;
  opacity: 1;
  -webkit-transform: translateY(0px);
  -moz-transform: translateY(0px);
  transform: translateY(0px);
}
/*학생권한 메뉴 css 끝 */

/*학부모권한 메뉴 css*/
.SMN_effect-3Parents a:after {
  position: absolute;
  top: 100%;
  left: 0;
  width: 100%;
  height: 1px;
  background: #333A73;
  content: '';
  opacity: 0;
  -webkit-transition: height 0.3s, opacity 0.3s, -webkit-transform 0.3s;
  -moz-transition: height 0.3s, opacity 0.3s, -moz-transform 0.3s;
  transition: height 0.3s, opacity 0.3s, transform 0.3s;
  -webkit-transform: translateY(-10px);
  -moz-transform: translateY(-10px);
  transform: translateY(-10px);
}

.SMN_effect-3Parents a:hover:after, .SMN_effect-3Parents a:focus:after {
  height: 5px;
  opacity: 1;
  -webkit-transform: translateY(0px);
  -moz-transform: translateY(0px);
  transform: translateY(0px);
}

.parentsMenuIcon:hover,.parentsMenuIcon:active,.parentsMenuIcon .educate-icon .educate-nav:before:hover{
	color:#fff;
}
/*학부모권한 메뉴 css 끝*/

/*선생님권한 메뉴 css*/
.SMN_effect-3Teacher a:after {
  position: absolute;
  top: 100%;
  left: 0;
  width: 100%;
  height: 1px;
  background: #fff;
  content: '';
  opacity: 0;
  -webkit-transition: height 0.3s, opacity 0.3s, -webkit-transform 0.3s;
  -moz-transition: height 0.3s, opacity 0.3s, -moz-transform 0.3s;
  transition: height 0.3s, opacity 0.3s, transform 0.3s;
  -webkit-transform: translateY(-10px);
  -moz-transform: translateY(-10px);
  transform: translateY(-10px);
}

.SMN_effect-3Teacher a:hover:after, .SMN_effect-3Parents a:focus:after {
  height: 5px;
  opacity: 1;
  -webkit-transform: translateY(0px);
  -moz-transform: translateY(0px);
  transform: translateY(0px);
}

.teacherMenu:hover{
	color:#fff;
}
/*선생님권한 메뉴 css 끝 */
.child-content{
	display: flex;
    justify-content: center;
}

.reading h3{
	color: #ccc;
}
.reading p{
	color: #ccc;
}

input[type=checkbox]{
/*     width: 16px; */
    margin-left: 15px;
}

.noticeContainer{
    margin-bottom: 10px;
/*     min-height: 254px; */
    align-content: center;
}

.noticeList{
	padding: 9px 0px 9px 0px;
}

#noticeDelBtn{
	float: right;
    border: none;
    padding: 2px 10px;
    border-radius: 7px;
    background: #f9e09a;
    font-weight: bold;
}

#checkAllSpan{
	margin-left: 12px;
	padding: 2px 10px;
    border-radius: 7px;
    background: #ebeae6;
    font-weight: bold;
}

#checkAllBox{
	margin-left: 13px;
	zoom: 1.1;
}

.notification-view {
    padding-top: 5px;
}

.noticeTitle h3{
	width: 50px;
	margin: 0 0;
	font-size: 22px;
	background: linear-gradient(to top, #7cb8ff 20%, transparent 20%);
}

/* 알림 스크롤바 시작 */
.notification-author::-webkit-scrollbar {
	width: 5px;
}
.notification-author::-webkit-scrollbar-thumb {
	background-color: #e6e6e6;
	border-radius: 5px;
}
.notification-author::-webkit-scrollbar-track {
	border-radius: 5px;
	background-color: #f5f5f5;
}
/* 알림 스크롤바 끝 */

/* 프로필 */
.nav-item{
	align-content: center;
}
.header-right-info .nav>li>a>img {
	width: 26px;
    height: 26px;
    object-fit: cover;
    border-radius: 50%;
}

.profileImg{
	width: 26px;
    height: 26px;
    object-fit: cover;
    border-radius: 50%;
}

.header-right-info .admin-name {
	top: 0;
	font-weight: bold;
}

.modal-footer a{
	margin: 0px;
}
/* 알림 빨간 불 */
.indicator-nt{
	background:#ff6060;
}

/* 공통 css 끝*/

/* 학부모 학급클래스 선택 모달*/
.child-info {
	text-align: center;
	backdrop-filter: blur(4px);
	background-color: rgba(255, 255, 255, 1);
	border-radius: 50px;
	box-shadow: 35px 35px 68px 0px rgba(145, 192, 255, 0.5), inset -8px -8px 16px 0px rgba(145, 192, 255, 0.6), inset 0px 11px 28px 0px rgb(255, 255, 255);
	padding-top: 35px;
	padding-bottom: 35px;
	margin-bottom: 40px;
	padding: 10%;
	margin: 5%;
	width: 100%;
}	
/* 학부모 학급클래스 선택 모달 끝*/
</style>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<!-- <script type="text/javascript" src="/resources/js/commonFunction.js"></script> -->
<script type="text/javascript">
// 전역 변수
var mberId = "${USER_INFO.mberId}";
// var password = "${USER_INFO.password}";
var socket = null;
var noticeLength = "";

$(function(){
	// 모든 알림 불러오기
	getAllNotice();
	
	// 회원 이미지 가져오기
	$.ajax({
		url: "/header/getMberImage",
		type: "get",
		dataType: "text",
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success:function(mberImage){
			if(mberImage != null && mberImage != ""){
				$(".headerProfile").attr("src", "/upload/profile/" + mberImage);
			}else{
				if(isStudent()){
					$(".headerProfile").attr("src", "/resources/images/member/profile/루피2.png");
				}else{
					$(".headerProfile").attr("src", "/resources/images/member/profile/user_l.png");
				}
			}
		}
	})
	
	// 체크박스 전체 선택
	$("#checkAllBox").on("click", function(){
		if($(this).is(":checked")){
			$(".noticeCheckbox").prop("checked", true);
		}else{
			$(".noticeCheckbox").prop("checked", false);
		}
	})
	
	// (실시간 알림) 소켓 객체 생성
	var soc = new SockJS("<c:url value="/alram"/>");
	
	soc.onopen = function () {
        console.log('주희 Info: connection opened.');
    };
    
	soc.onmessage = function(data) {
		console.log("data", data);
		
		var str = "";
		str += "<div class='review-item-rating' style='margin-right: 15px;'>";
		str += elapsedTime(data.timeStamp);
		str += "</div></div>";
		
		$(".noticeContainer").prepend(data.data + str);
		$(".indicator-nt").removeAttr("style");
	};
	
	// 알림을 읽었을 때 알림 열람 여부 변경 이벤트
	$(document).on("click", ".noticeContent", function(){
	    var noticeCode = $(this).closest('.noticeList').find('#noticeCode').text();
		
		var data = {
			"noticeCode":noticeCode
		};
		
		$.ajax({
			url: "/header/updateNoticeReadngAt",
			type: "post",
			data: data,
			dataType: "text",
			beforeSend:function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			},
			success:function(res){
// 				alert("알림 열람 여부 잘 변경됐음");
			}
		});
	});
	
	// 알림 삭제
	$("#noticeDelBtn").on("click", function(){
		var checkedArr = [];
		var indexArr = [];
		var noticeCodeArr = [];
		
		for (var i = 0; i < noticeLength; i++) {
			// 모든 체크박스의 체크 여부 배열에 저장
			checkedArr.push($("#noticeCheckbox"+i).is(":checked"));
			
			// 체크된 경우(true), 체크된 배열의 index를 배열에 저장
			if(checkedArr[i] == true)
			indexArr.push(i);
		}
// 		console.log("checkedArr", checkedArr);
// 		console.log(indexArr);
		
		for (var i = 0; i < indexArr.length; i++) {
			// 체크된 배열의 index에 저장된 noticeCode를 배열에 저장
			noticeCodeArr.push($("#noticeCheckbox"+indexArr[i]).attr("data-noticeCode"));
		}
// 		console.log("noticeCodeArr", noticeCodeArr);
		
		if(noticeCodeArr.length == 0) return;
		
		$.ajax({
			url: "/header/noticeDelete",
			type: "post",
			data: {"noticeCodeArr" : noticeCodeArr},
			dataType: "json",
			traditional: true,
			beforeSend:function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			},
			success:function(res){
				// 모든 알림 불러오기
				getAllNotice();
			}
		});
	});
	
	// 교직원 권한일 경우, 학급 클래스 메뉴 안 보이게 하기
	<sec:authorize access="hasRole('A14003')">
		$(".goToClassMenu").attr("style", "display: none;");
	</sec:authorize>
});
</script>
<script>
// 권한(학생, 교직원, 부모)에 따라 마이페이지 경로 변경
const enterMypage = function(){
	$("#pwChk").attr("style", "display: none;");
	$("#enterMyPageModal").modal("show");
	
	// 비밀번호 입력 이벤트
	$("#enterMyPageBtn").on("click", function(){
		var inputPassword = $("#password").val();
		console.log("inputPassword: " + inputPassword);
		
		// 암호화된 비밀번호 해독 작업
		$.ajax({
			url: "/header/passwordDecode",
			type: "get",
			data: {inputPassword:inputPassword},
			dataType: "text",
			beforeSend:function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			},
			success:function(res){
				console.log(res);
				if(res === "true"){
					if(isStudent()){
						window.location.href = "/student/mypage";
					}
					if(isParent()){
						window.location.href = "/parents/mypage";
					}
					if(isEmployee()){
						window.location.href = "/teacher/mypage";
					}
				}else{
					$("#pwChk").removeAttr("style");
					$("#password").val("");
				}
			}
		});
	});
}

// 학교 메인 페이지로 이동
const headerSchool = function(){
	$("#goToSchoolForm").submit();
}

// 권한별로 학급 클래스 페이지로 이동
const headerEnterClass = function(){
	/* 학생 권한 */
	<sec:authorize access="hasRole('A01001')">
		$.ajax({
			url:"/header/getStudentClasStatus",
			type:"post",
			dataType:"json",
			beforeSend:function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			},
			success:function(clasStdntVO){
				// 소속된 클래스가 있는 경우
				if(clasStdntVO.clasCode != null && clasStdntVO.clasCode != ""){
					var cmmnSchulPsitnSttus = "${SCHOOL_USER_INFO.cmmnSchulPsitnSttus}";
					
					// 재학 중이고, 가입된 반이 있는 경우
					if(cmmnSchulPsitnSttus == "A02101" && clasStdntVO.cmmnClasPsitnSttus == "A03101"){
						$("#headerClasCode").val(clasStdntVO.clasCode);

						// 학급 클래스로 이동
						$("#goToClassForm").submit();
					// 가입 대기 중인 경우
					}else if(clasStdntVO.cmmnClasPsitnSttus == "A03001"){
						Swal.fire('아직 가입 대기 상태입니다.', '가입이 승인될 때까지 조금만 기다려 주세요.', 'warning');
						return;
					}else{
						Swal.fire('현재 소속된 클래스가 없습니다.', '', 'error');
						return;
					}
				// 소속된 클래스가 없는 경우
				}else{
					Swal.fire('현재 소속된 클래스가 없습니다.', '', 'error');
					return;
				} // end if
			} // end success
		}) // end ajax
	</sec:authorize>
		
	/* 선생님 권한 */
	<sec:authorize access="hasRole('A01002')">
	// 클래스 코드 가져오기
	$.ajax({
		url:"/header/getClasCode",
		type:"post",
		dataType:"text",
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success:function(clasCode){
			console.log("clasCode -> " + clasCode);
			
			// 소속된 클래스가 있는 경우
			if(clasCode != null && clasCode != ""){
				var cmmnSchulPsitnSttus = "${SCHOOL_USER_INFO.cmmnSchulPsitnSttus}";
				// 재직 중인 경우
				if(cmmnSchulPsitnSttus == "A02104"){
					$("#headerClasCode").val(clasCode);

					// 학급 클래스로 이동
					$("#goToClassForm").submit();
				}else{
					Swal.fire('현재 소속된 클래스가 없습니다.', '', 'error');
					return;
				}
			// 소속된 클래스가 없는 경우
			}else{
				Swal.fire('현재 소속된 클래스가 없습니다.', '', 'error');
				return;
			}
		}
	});
	</sec:authorize>

	/* 학부모 권한 */
	<sec:authorize access="hasRole('A01003')">
	// 자녀의 학급 클래스 목록 모달 창 띄우기
	$("#goToChildClassModal").modal("show");
	
	// 자녀 리스트
	$.ajax({
		url:"/header/childList",
		type:"get",
		dataType: "json",
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success:function(res){
			console.log("자녀 리스트", res);
	
			var str = "";
			var clasCode = ""; 		// 학생, 교사의 클래스 코드
// 			var clasCodeArr = []; 	// 학부모 자녀의 클래스 코드들
			console.log("res",  res);
			
			$.each(res, function(index, schulVOList){
				var item = schulVOList.schulVOList[0];
				str += "<div class='col-lg-4 col-md-4 col-sm-4 col-xs-4 child-info'>";
				str += "<div class='hpanel hblue contact-panel contact-panel-cs responsive-mg-b-30'>";
				str += "<div class='panel-body custom-panel-jw'>";
				str += "<h3>"+item.schulPsitnMberVO.memberVO.mberNm+"</h3>"
				str += "<p>"+item.schulNm+"</p>"
				str += "<p>"+item.clasVO.clasNm+"</p>"
				str += "<p>"+item.clasVO.clasCode+"</p>"
				str += "</div>";
				str += "<input type='button' onclick='goToClass(\"" + item.clasVO.clasCode + "\", \"" + schulVOList.stdntId + "\")' class='btn btn-primary waves-effect waves-light' value='이동하기'>";
				str += "</div></div>";
				
				$("#clasCode1").val(item.clasVO.clasCode);
			});
			
			$(".child-content").html(str);
		}
	});
	</sec:authorize>
};

const goToClass = function(clasCode, childId){
	console.log("clasCode: " + clasCode);
	
	if(childId != null){
		document.querySelector("#childId").value = childId;
	}
	
	if(clasCode != null){
		document.querySelector("#headerClasCode").value = clasCode;
		document.querySelector("#goToClassForm").submit();
	}
};

// 모든 알림 불러오기
function getAllNotice(){
	$.ajax({
		url:"/header/getAllNotice",
		type:"post",
		dataType: "json",
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success:function(res){
			console.log("알림", res);
			
			noticeLength = res.length;
			var str = "";
			var notReadingCount = 0; // 읽지 않은 알림의 수
			
			$.each(res, function(index, noticeList){
				if(noticeList.cmmnNoticeReadngAt == "A13001"){
					notReadingCount++;
				}
			});
			
			// 알림이 없는 경우
			if(res.length == 0){
				$(".noticeDelDiv").attr("style", "display: none;");
				$(".noticeContainer").attr("style", "min-height: 254px;");
				$(".indicator-nt").attr("style", "display: none;");
				str += "<div>";
				str += "<p style='text-align: center; color: #999;'>모든 알림을 확인했습니다.</p>";
				str += "</div>";
			// 알림이 있는 경우
			}else{
				// 알림을 다 읽은 경우
				if(notReadingCount == 0){
					$(".indicator-nt").attr("style", "display: none;");
				}
				
				$.each(res, function(index, noticeVO){
					var noticeCode = noticeVO.noticeCode;
					var taskCode = noticeVO.noticeCode.substring(0, 13);
					var clasCode = noticeVO.noticeCode.substring(0, 8);
					
					str += "<div class='single-review-st-text noticeList'>";
					str += "<input id='noticeCheckbox"+index+"' class='noticeCheckbox' type='checkbox' data-noticeCode='"+noticeCode+"'>";
					str += "<img src='/resources/images/header/letter.png' alt='' style='margin-left: 12px; margin-top: 6px; width: 33px; height: 33px;'>";
					str += "<div class='review-ctn-hf' style='margin-left: 11px;'>";
					str += "<a class='noticeContent";
					
					// 이미 읽은 알림인 경우, 읽음 표시 추가
					if(noticeVO.cmmnNoticeReadngAt == "A13002"){
						str += " reading";
					}
					
					// 게시판 구분이 '알림장'일 경우, 알림장 페이지로 이동
					if(noticeVO.cmmnBoardSe == "A08001"){
						str += "' href='/ntcn/ntcnList?clasCode="+clasCode+"'>";
						
					// 게시판 구분이 '과제'일 경우, 과제 상세 보기 페이지로 이동
					}else if(noticeVO.cmmnBoardSe == "A08005"){
						str += "' href='/task/taskDetail?taskCode="+taskCode+"&clasCode="+clasCode+"'>";
					}
					
					var noticeSj = noticeVO.noticeSj;
					
					if(noticeSj.length > 18){
						noticeSj = noticeSj.replace(noticeSj.substring(17), "···");
					}
					
					str += "<h3 id='noticeSj' style='font-size: 15px;'>"+noticeSj+"</h3>"
					str += "<p>"+noticeVO.noticeCn+"</p>";
					str += "<p id='noticeCode' style='display: none;'>"+noticeCode+"</p>";
					str += "</a>";
					str += "</div>";
					str += "<div class='review-item-rating' style='margin-right: 15px;'>";
					str += elapsedTime(noticeVO.noticeTrnsmitDt);
					str += "</div></div>";
				});
			}
			
			$(".noticeContainer").html(str);
		}
	});
}
</script>

<!-- 학급 클래스 이동 폼 -->
<form id="goToClassForm" action="/class/classMain" method="post">
	<input type="hidden" id="headerClasCode" name="clasCode" value="">
	<input type="hidden" id="childId" name="childId" value="">
	<sec:csrfInput />
</form>

<!-- 학교 이동 폼 -->
<form id="goToSchoolForm" action="/school/main" method="get"></form>

<!-- 학생 권한 header시작 -->
<sec:authorize access="hasRole('A01001')">
	<div class="header-top-area" style="background: #ffd966e0; box-shadow: 0 8px 32px 0 rgba( 31, 38, 135, 0.37 ); backdrop-filter: blur(4px); -webkit-backdrop-filter: blur(4px); border: 1px solid rgba(255, 255, 255, 0.18);height:65px;"> 
			<div class="container-fluid">
			<div class="row">
				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
					<div class="header-top-wraper">
						<div class="row">
							<div class="col-lg-1 col-md-0 col-sm-1 col-xs-12" style="width: 5%;">
								<div class="menu-switcher-pro">
									<button type="button" id="sidebarCollapse" class="btn bar-button-pro header-drl-controller-btn navbar-btn">
										<i class="educate-icon educate-nav" style="color:#333!important;"></i>
									</button>
								</div>
							</div>
							<div class="col-lg-6 col-md-7 col-sm-6 col-xs-12">
								<div class="header-top-menu tabl-d-n">
									<ul class="nav navbar-nav mai-top-nav SMN_effect-3" style="">
										<li class="nav-item">
											<a style="font-size: 16px; font-weight: 700; color:#333;" href="#" onclick="headerEnterClass()" class="nav-link headerhover"> 학급클래스 </a>
										</li>
										<li class="nav-item">
											<a style="font-size: 16px; font-weight: 700; color:#333;" href="#" onclick="headerSchool()" class="nav-link headerhover"> 학교정보 </a>
										</li>
									</ul>
								</div>
							</div>
							<div class="col-lg-5 col-md-5 col-sm-12 col-xs-12">
								<div class="header-right-info">
									<ul class="nav navbar-nav mai-top-nav header-right-menu" style="margin-right: 20px;">
										<!-- 학생 알림 -->
										<li class="nav-item">
											<a href="#" data-toggle="dropdown" role="button" aria-expanded="false" class="nav-link dropdown-toggle">
												<img src="/resources/images/header/bell_black.png" alt="프로필 사진" class="profileImg"/>
											<span class="indicator-nt"></span></a>
											<div role="menu" class="notification-author dropdown-menu animated zoomIn" style="width: 365px; height: 395px; overflow: auto; top: 183%;">
												<div class="noticeTitle" style='text-align: center; margin-top: 10px; display: flex; justify-content: center;'>
													<h3>알림</h3>
												</div>
												<hr>
												<div class="noticeDelDiv" style='height: 30px; margin-right: 15px;'>
													<input id='checkAllBox' type="checkbox" style='float: left;'>
													<span id='checkAllSpan'>전체 선택</span>
													<button id='noticeDelBtn' style='float: right;'>삭제</button>
												</div>
												<div class="noticeContainer"></div>
<!-- 												<div class="notification-view"> -->
<!-- 													<a href="#">모든 알림을 확인했습니다.</a> -->
<!-- 												</div> -->
											</div>
										</li>

										<!-- 학생 정보 -->
										<li class="nav-item">
											<!-- 학생 프로필 -->
											<a href="#" data-toggle="dropdown" role="button" aria-expanded="false" class="nav-link dropdown-toggle">
												<img src="" alt="" class="headerProfile" class="profileImg mem-img"/>
												<p class="admin-name" style="color:#333;">${USER_INFO.mberNm} 학생</p>
												<i style="color:#333;" class="fa fa-angle-down edu-icon edu-down-arrow"></i>
											</a>
											<!-- 학생 프로필 드롭 메뉴 -->
											<ul role="menu" class="dropdown-header-top author-log dropdown-menu animated zoomIn" style="top: 125%;">
												<li>
													<a href="#" onclick="enterMypage()">마이페이지</a>
												</li>
												<li>
													<a href="/student/complimentSticker">칭찬 스티커</a>
												</li>
												<li id="logoutBtn">
													<a href="javascript:void(0);">로그아웃</a>
												</li>
											</ul>
											<form action="/logout" method="post" id="logoutFrm">
												<sec:csrfInput />
											</form>
										</li>
									</ul>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</sec:authorize>
<!-- 학생 권한 header끝 -->
<!-- 교직원 권한 header시작 -->
<sec:authorize access="hasRole('A01002')">
	<div class="header-top-area"style="background: rgb(0 0 0/ 82%); box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.37); backdrop-filter: blur(4px); -webkit-backdrop-filter: blur(4px); border: 1px solid rgba(255, 255, 255, 0.18);height:65px;">
		<div class="container-fluid">
			<div class="row">
				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
					<div class="header-top-wraper">
						<div class="row">
							<div class="col-lg-1 col-md-0 col-sm-1 col-xs-12" style="width: 5%;">
								<div class="menu-switcher-pro">
									<button type="button" id="sidebarCollapse" class="btn bar-button-pro header-drl-controller-btn navbar-btn teacherMenu">
										<i class="educate-icon educate-nav"></i>
									</button>
								</div>
							</div>
							<div class="col-lg-6 col-md-7 col-sm-6 col-xs-12">
								<div class="header-top-menu tabl-d-n">
									<ul class="nav navbar-nav mai-top-nav SMN_effect-3Teacher" style="font-family: 'Pretendard';">
										<li class="nav-item goToClassMenu">
											<a style="font-size: 16px; font-weight: 700;" href="#" onclick="headerEnterClass()" class="nav-link"> 학급클래스 </a>
										</li>
										<li class="nav-item">
											<a style="font-size: 16px; font-weight: 700;" href="#" onclick="headerSchool()" class="nav-link"> 학교정보 </a>
										</li>
									</ul>
								</div>
							</div>
							<div class="col-lg-5 col-md-5 col-sm-12 col-xs-12">
								<div class="header-right-info">
									<ul class="nav navbar-nav mai-top-nav header-right-menu">
										<!-- 교직원 알림 -->
										<li class="nav-item">
											<a href="#" data-toggle="dropdown" role="button" aria-expanded="false" class="nav-link dropdown-toggle">
												<img src="/resources/images/header/bell.png" alt="프로필 사진" class="profileImg"/>
											<span class="indicator-nt" style="background:#ff6060;"></span></a>
											<div role="menu" class="notification-author dropdown-menu animated zoomIn" style="width: 365px; height: 395px; overflow: auto; top: 183%;">
												<div class="noticeTitle" style='text-align: center; margin-top: 10px; display: flex; justify-content: center;'>
													<h3>알림</h3>
												</div>
												<hr>
												<div class="noticeDelDiv" style='height: 30px; margin-right: 15px;'>
													<input id='checkAllBox' type="checkbox" style='float: left;'>
													<span id='checkAllSpan'>전체 선택</span>
													<button id='noticeDelBtn' style='float: right;'>삭제</button>
												</div>
												<div class="noticeContainer"></div>
<!-- 												<div class="notification-view"> -->
<!-- 													<a href="#">모든 알림을 확인했습니다.</a> -->
<!-- 												</div> -->
											</div>
										</li>

										<!-- 교직원 정보 -->
										<li class="nav-item">
											<!-- 교직원 프로필 -->
											<a href="#" data-toggle="dropdown" role="button" aria-expanded="false" class="nav-link dropdown-toggle">
												<img src="" alt="" class="headerProfile" class="profileImg mem-img"/>
												<!-- 교직원 권한 표기 -->
												<c:choose>
													<%-- 교사인 경우 --%>
													<c:when test="${USER_INFO.vwMemberAuthVOList[0].cmmnDetailCode == 'ROLE_A14002'||USER_INFO.vwMemberAuthVOList[0].cmmnDetailCode == 'ROLE_A14005'}">
														<p class="admin-name">${USER_INFO.mberNm} 선생님</p>
													</c:when>
													<%-- 행정실 직원인 경우 --%>
													<c:otherwise>
														<p class="admin-name">${USER_INFO.mberNm} 행정실</p>
													</c:otherwise>
												</c:choose>
												<i class="fa fa-angle-down edu-icon edu-down-arrow"></i>
											</a>
											<!-- 선생님 프로필 드롭 메뉴 -->
											<ul role="menu" class="dropdown-header-top author-log dropdown-menu animated zoomIn" style="top: 125%;">
												<li>
													<a href="#" onclick="enterMypage()">마이페이지</a>
												</li>
												<li id="logoutBtn">
													<a href="javascript:void(0);">로그아웃</a>
												</li>
											</ul>
											<form action="/logout" method="post" id="logoutFrm">
												<sec:csrfInput />
											</form>
										</li>
									</ul>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</sec:authorize>
<!-- 선생님 권한 header 끝 -->
<!-- 학부모 권한 header시작 -->
<sec:authorize access="hasRole('A01003')">
	<div class="header-top-area" style="background: rgb(0 112 255 / 88%);box-shadow: 0 8px 32px 0 rgba( 31, 38, 135, 0.37 );backdrop-filter: blur( 4px );-webkit-backdrop-filter: blur( 4px );border: 1px solid rgba( 255, 255, 255, 0.18 );height:65px;">
		<div class="container-fluid">
			<div class="row">
				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
					<div class="header-top-wraper">
						<div class="row">
							<div class="col-lg-1 col-md-0 col-sm-1 col-xs-12" style="width: 5%;">
								<div class="menu-switcher-pro">
									<button type="button" id="sidebarCollapse" class="btn bar-button-pro header-drl-controller-btn navbar-btn parentsMenuIcon">
										<i class="educate-icon educate-nav"></i>
									</button>
								</div>
							</div>
							<div class="col-lg-6 col-md-7 col-sm-6 col-xs-12">
								<div class="header-top-menu tabl-d-n">
									<ul class="nav navbar-nav mai-top-nav SMN_effect-3Parents" style="font-family: 'Pretendard';">
										<li class="nav-item">
											<a style="font-size: 16px; font-weight: 700;" onclick="headerEnterClass()" class="nav-link"> 학급클래스 </a>
										</li>
										<li class="nav-item">
											<a style="font-size: 16px; font-weight: 700;" onclick="headerSchool()" class="nav-link"> 학교정보 </a>
										</li>
									</ul>
								</div>
							</div>
							<div class="col-lg-5 col-md-5 col-sm-12 col-xs-12">
								<div class="header-right-info">
									<ul class="nav navbar-nav mai-top-nav header-right-menu">
										
										<!-- 학부모 알림 -->
										<li class="nav-item">
											<a href="#" data-toggle="dropdown" role="button" aria-expanded="false" class="nav-link dropdown-toggle">
												<img src="/resources/images/header/bell.png" class="profileImg"/>
											<span class="indicator-nt" style="background:#ff6060;"></span></a>
											<div role="menu" class="notification-author dropdown-menu animated zoomIn" style="width: 365px; height: 395px; overflow: auto; top: 183%;">
												<div class="noticeTitle" style='text-align: center; margin-top: 10px; display: flex; justify-content: center;'>
													<h3>알림</h3>
												</div>
												<hr>
												<div class="noticeDelDiv" style='height: 30px; margin-right: 15px;'>
													<input id='checkAllBox' type="checkbox" style='float: left;'>
													<span id='checkAllSpan'>전체 선택</span>
													<button id='noticeDelBtn' style='float: right;'>삭제</button>
												</div>
												<div class="noticeContainer"></div>
<!-- 												<div class="notification-view"> -->
<!-- 													<a href="#">모든 알림을 확인했습니다.</a> -->
<!-- 												</div> -->
											</div>
										</li>
										
										<!-- 학부모 정보 -->
										<li class="nav-item">
											<!-- 학부모 프로필 -->
											<a href="#" data-toggle="dropdown" role="button" aria-expanded="false" class="nav-link dropdown-toggle">
												<img src="" alt="" class="headerProfile" class="profileImg mem-img"/>
												<p class="admin-name">${USER_INFO.mberNm} 학부모</p>
												<i class="fa fa-angle-down edu-icon edu-down-arrow"></i>
											</a>
											<!-- 학부모 프로필 드롭 메뉴 -->
											<ul role="menu" class="dropdown-header-top author-log dropdown-menu animated zoomIn" style="top: 125%;">
												<li>
													<a href="#" onclick="enterMypage()">마이페이지</a>
												</li>
												<li id="logoutBtn">
													<a href="javascript:void(0);">로그아웃</a>
												</li>
											</ul>
											<form action="/logout" method="post" id="logoutFrm">
												<sec:csrfInput />
											</form>
										</li>

									</ul>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</sec:authorize>
<!-- 학부모 권한 header끝 -->
<!-- 관리자 권한 header시작 -->
<sec:authorize access="hasRole('A01000')">
	<div class="header-top-area" style="background: rgb(0 112 255 / 88%);box-shadow: 0 8px 32px 0 rgba( 31, 38, 135, 0.37 );backdrop-filter: blur( 4px );-webkit-backdrop-filter: blur( 4px );border: 1px solid rgba( 255, 255, 255, 0.18 );height:65px;">
		<div class="container-fluid">
			<div class="row">
				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
					<div class="header-top-wraper">
						<div class="row">
							<div class="col-lg-1 col-md-0 col-sm-1 col-xs-12">
								<div class="menu-switcher-pro">
									<button type="button" id="sidebarCollapse" class="btn bar-button-pro header-drl-controller-btn navbar-btn parentsMenuIcon">
										<i class="educate-icon educate-nav"></i>
									</button>
								</div>
							</div>
							<div class="col-lg-6 col-md-7 col-sm-6 col-xs-12">
								<div class="header-top-menu tabl-d-n">
									<ul class="nav navbar-nav mai-top-nav SMN_effect-3Parents" style="font-family: 'Pretendard';">
										<!-- header의 메뉴 들어갈 곳 -->
									</ul>
								</div>
							</div>
							<div class="col-lg-5 col-md-5 col-sm-12 col-xs-12">
								<div class="header-right-info">
									<ul class="nav navbar-nav mai-top-nav header-right-menu">
										<!-- 내 정보 -->
										<li class="nav-item">
											<a href="#" data-toggle="dropdown" role="button" aria-expanded="false" class="nav-link dropdown-toggle">
												<img src="/resources/kiaalap/img/product/pro4.jpg" alt="" /> <span class="admin-name">${USER_INFO.mberNm}</span><i class="fa fa-angle-down edu-icon edu-down-arrow"></i>
											</a>
											<ul role="menu" class="dropdown-header-top author-log dropdown-menu animated zoomIn">
												<li><a href="/student/mypage"><span class="edu-icon edu-home-admin author-log-ic"> </span>마이페이지</a></li>
												<li id="logoutBtn"><a href="javascript:void(0);"><span class="edu-icon edu-locked author-log-ic"></span>로그아웃</a></li>
											</ul>
											<form action="/logout" method="post" id="logoutFrm">
												<sec:csrfInput />
											</form>
										</li>

										<!-- 알림 -->
										<li class="nav-item"><a href="#" data-toggle="dropdown"
											role="button" aria-expanded="false"
											class="nav-link dropdown-toggle"><i
												class="educate-icon educate-bell" aria-hidden="true"></i><span
												class="indicator-nt"></span></a>
											<div role="menu"
												class="notification-author dropdown-menu animated zoomIn">
												<div class="notification-single-top">
													<h1>Notifications</h1>
												</div>
												<ul class="notification-menu">
													<li><a href="#">
															<div class="notification-icon">
																<i
																	class="educate-icon educate-checked edu-checked-pro admin-check-pro"
																	aria-hidden="true"></i>
															</div>
															<div class="notification-content">
																<span class="notification-date">16 Sept</span>
																<h2>Advanda Cro</h2>
																<p>Please done this project as soon possible.</p>
															</div>
													</a></li>
													<li><a href="#">
															<div class="notification-icon">
																<i class="fa fa-cloud edu-cloud-computing-down"
																	aria-hidden="true"></i>
															</div>
															<div class="notification-content">
																<span class="notification-date">16 Sept</span>
																<h2>Sulaiman din</h2>
																<p>Please done this project as soon possible.</p>
															</div>
													</a></li>
													<li><a href="#">
															<div class="notification-icon">
																<i class="fa fa-eraser edu-shield" aria-hidden="true"></i>
															</div>
															<div class="notification-content">
																<span class="notification-date">16 Sept</span>
																<h2>Victor Jara</h2>
																<p>Please done this project as soon possible.</p>
															</div>
													</a></li>
													<li><a href="#">
															<div class="notification-icon">
																<i class="fa fa-line-chart edu-analytics-arrow"
																	aria-hidden="true"></i>
															</div>
															<div class="notification-content">
																<span class="notification-date">16 Sept</span>
																<h2>Victor Jara</h2>
																<p>Please done this project as soon possible.</p>
															</div>
													</a></li>
												</ul>
<!-- 												<div class="notification-view"> -->
<!-- 													<a href="#">모든 알림을 확인했습니다.</a> -->
<!-- 												</div> -->
											</div>
										</li>
									</ul>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</sec:authorize>
<!-- 관리자 권한 header끝 -->
<!-- Mobile Menu start -->
<div class="mobile-menu-area">
	<div class="container">
		<div class="row">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="mobile-menu">
					<nav id="dropdown">
						<ul class="mobile-menu-nav">

							<li><a href="">학급클래스</a></li>
							<li><a href="">학교정보</a></li>
							<li><a href="">학교/클래스 찾기</a></li>
							<li><a href="">1대1 채팅</a></li>
							<li><a href="">공지사항</a></li>

							<!-- 
                                <li><a data-toggle="collapse" data-target="#Charts" href="#">Home <span class="admin-project-icon edu-icon edu-down-arrow"></span></a>
                                    <ul class="collapse dropdown-header-top">
                                        <li><a href="/resources/kiaalap/index.html">Dashboard v.1</a></li>
                                        <li><a href="/resources/kiaalap/index-1.html">Dashboard v.2</a></li>
                                        <li><a href="/resources/kiaalap/index-3.html">Dashboard v.3</a></li>
                                        <li><a href="/resources/kiaalap/analytics.html">Analytics</a></li>
                                        <li><a href="/resources/kiaalap/widgets.html">Widgets</a></li>
                                    </ul>
                                </li>
                                <li><a href="events.html">Event</a></li>
                                <li><a data-toggle="collapse" data-target="#demoevent" href="#">Professors <span class="admin-project-icon edu-icon edu-down-arrow"></span></a>
                                    <ul id="demoevent" class="collapse dropdown-header-top">
                                        <li><a href="/resources/kiaalap/all-professors.html">All Professors</a>
                                        </li>
                                        <li><a href="/resources/kiaalap/add-professor.html">Add Professor</a>
                                        </li>
                                        <li><a href="/resources/kiaalap/edit-professor.html">Edit Professor</a>
                                        </li>
                                        <li><a href="/resources/kiaalap/professor-profile.html">Professor Profile</a>
                                        </li>
                                    </ul>
                                </li>
                                <li><a data-toggle="collapse" data-target="#demopro" href="#">Students <span class="admin-project-icon edu-icon edu-down-arrow"></span></a>
                                    <ul id="demopro" class="collapse dropdown-header-top">
                                        <li><a href="/resources/kiaalap/all-students.html">All Students</a>
                                        </li>
                                        <li><a href="/resources/kiaalap/add-student.html">Add Student</a>
                                        </li>
                                        <li><a href="/resources/kiaalap/edit-student.html">Edit Student</a>
                                        </li>
                                        <li><a href="/resources/kiaalap/student-profile.html">Student Profile</a>
                                        </li>
                                    </ul>
                                </li>
                                <li><a data-toggle="collapse" data-target="#democrou" href="#">Courses <span class="admin-project-icon edu-icon edu-down-arrow"></span></a>
                                    <ul id="democrou" class="collapse dropdown-header-top">
                                        <li><a href="/resources/kiaalap/all-courses.html">All Courses</a>
                                        </li>
                                        <li><a href="/resources/kiaalap/add-course.html">Add Course</a>
                                        </li>
                                        <li><a href="/resources/kiaalap/edit-course.html">Edit Course</a>
                                        </li>
                                        <li><a href="/resources/kiaalap/course-profile.html">Courses Info</a>
                                        </li>
                                        <li><a href="course-payment.html">Courses Payment</a>
                                        </li>
                                    </ul>
                                </li>
                                <li><a data-toggle="collapse" data-target="#demolibra" href="#">Library <span class="admin-project-icon edu-icon edu-down-arrow"></span></a>
                                    <ul id="demolibra" class="collapse dropdown-header-top">
                                        <li><a href="/resources/kiaalap/library-assets.html">Library Assets</a>
                                        </li>
                                        <li><a href="/resources/kiaalap/add-library-assets.html">Add Library Asset</a>
                                        </li>
                                        <li><a href="/resources/kiaalap/edit-library-assets.html">Edit Library Asset</a>
                                        </li>
                                    </ul>
                                </li>
                                <li><a data-toggle="collapse" data-target="#demodepart" href="#">Departments <span class="admin-project-icon edu-icon edu-down-arrow"></span></a>
                                    <ul id="demodepart" class="collapse dropdown-header-top">
                                        <li><a href="/resources/kiaalap/departments.html">Departments List</a>
                                        </li>
                                        <li><a href="/resources/kiaalap/add-department.html">Add Departments</a>
                                        </li>
                                        <li><a href="/resources/kiaalap/edit-department.html">Edit Departments</a>
                                        </li>
                                    </ul>
                                </li>
                                <li><a data-toggle="collapse" data-target="#demo" href="#">Mailbox <span class="admin-project-icon edu-icon edu-down-arrow"></span></a>
                                    <ul id="demo" class="collapse dropdown-header-top">
                                        <li><a href="/resources/kiaalap/mailbox.html">Inbox</a>
                                        </li>
                                        <li><a href="/resources/kiaalap/mailbox-view.html">View Mail</a>
                                        </li>
                                        <li><a href="/resources/kiaalap/mailbox-compose.html">Compose Mail</a>
                                        </li>
                                    </ul>
                                </li>
                                <li><a data-toggle="collapse" data-target="#Miscellaneousmob" href="#">Interface <span class="admin-project-icon edu-icon edu-down-arrow"></span></a>
                                    <ul id="Miscellaneousmob" class="collapse dropdown-header-top">
                                        <li><a href="/resources/kiaalap/google-map.html">Google Map</a>
                                        </li>
                                        <li><a href="/resources/kiaalap/data-maps.html">Data Maps</a>
                                        </li>
                                        <li><a href="/resources/kiaalap/pdf-viewer.html">Pdf Viewer</a>
                                        </li>
                                        <li><a href="/resources/kiaalap/x-editable.html">X-Editable</a>
                                        </li>
                                        <li><a href="/resources/kiaalap/code-editor.html">Code Editor</a>
                                        </li>
                                        <li><a href="/resources/kiaalap/tree-view.html">Tree View</a>
                                        </li>
                                        <li><a href="/resources/kiaalap/preloader.html">Preloader</a>
                                        </li>
                                        <li><a href="/resources/kiaalap/images-cropper.html">Images Cropper</a>
                                        </li>
                                    </ul>
                                </li>
                                <li><a data-toggle="collapse" data-target="#Chartsmob" href="#">Charts <span class="admin-project-icon edu-icon edu-down-arrow"></span></a>
                                    <ul id="Chartsmob" class="collapse dropdown-header-top">
                                        <li><a href="/resources/kiaalap/bar-charts.html">Bar Charts</a>
                                        </li>
                                        <li><a href="/resources/kiaalap/line-charts.html">Line Charts</a>
                                        </li>
                                        <li><a href="/resources/kiaalap/area-charts.html">Area Charts</a>
                                        </li>
                                        <li><a href="/resources/kiaalap/rounded-chart.html">Rounded Charts</a>
                                        </li>
                                        <li><a href="/resources/kiaalap/c3.html">C3 Charts</a>
                                        </li>
                                        <li><a href="/resources/kiaalap/sparkline.html">Sparkline Charts</a>
                                        </li>
                                        <li><a href="/resources/kiaalap/peity.html">Peity Charts</a>
                                        </li>
                                    </ul>
                                </li>
                                <li><a data-toggle="collapse" data-target="#Tablesmob" href="#">Tables <span class="admin-project-icon edu-icon edu-down-arrow"></span></a>
                                    <ul id="Tablesmob" class="collapse dropdown-header-top">
                                        <li><a href="/resources/kiaalap/static-table.html">Static Table</a>
                                        </li>
                                        <li><a href="/resources/kiaalap/data-table.html">Data Table</a>
                                        </li>
                                    </ul>
                                </li>
                                <li><a data-toggle="collapse" data-target="#formsmob" href="#">Forms <span class="admin-project-icon edu-icon edu-down-arrow"></span></a>
                                    <ul id="formsmob" class="collapse dropdown-header-top">
                                        <li><a href="/resources/kiaalap/basic-form-element.html">Basic Form Elements</a>
                                        </li>
                                        <li><a href="/resources/kiaalap/advance-form-element.html">Advanced Form Elements</a>
                                        </li>
                                        <li><a href="/resources/kiaalap/password-meter.html">Password Meter</a>
                                        </li>
                                        <li><a href="/resources/kiaalap/multi-upload.html">Multi Upload</a>
                                        </li>
                                        <li><a href="/resources/kiaalap/tinymc.html">Text Editor</a>
                                        </li>
                                        <li><a href="/resources/kiaalap/dual-list-box.html">Dual List Box</a>
                                        </li>
                                    </ul>
                                </li>
                                <li><a data-toggle="collapse" data-target="#Appviewsmob" href="#">App views <span class="admin-project-icon edu-icon edu-down-arrow"></span></a>
                                    <ul id="Appviewsmob" class="collapse dropdown-header-top">
                                        <li><a href="/resources/kiaalap/basic-form-element.html">Basic Form Elements</a>
                                        </li>
                                        <li><a href="/resources/kiaalap/advance-form-element.html">Advanced Form Elements</a>
                                        </li>
                                        <li><a href="/resources/kiaalap/password-meter.html">Password Meter</a>
                                        </li>
                                        <li><a href="/resources/kiaalap/multi-upload.html">Multi Upload</a>
                                        </li>
                                        <li><a href="/resources/kiaalap/tinymc.html">Text Editor</a>
                                        </li>
                                        <li><a href="/resources/kiaalap/dual-list-box.html">Dual List Box</a>
                                        </li>
                                    </ul>
                                </li>
                                <li><a data-toggle="collapse" data-target="#Pagemob" href="#">Pages <span class="admin-project-icon edu-icon edu-down-arrow"></span></a>
                                    <ul id="Pagemob" class="collapse dropdown-header-top">
                                        <li><a href="/resources/kiaalap/login.html">Login</a>
                                        </li>
                                        <li><a href="/resources/kiaalap/register.html">Register</a>
                                        </li>
                                        <li><a href="/resources/kiaalap/lock.html">Lock</a>
                                        </li>
                                        <li><a href="/resources/kiaalap/password-recovery.html">Password Recovery</a>
                                        </li>
                                        <li><a href="/resources/kiaalap/404.html">404 Page</a></li>
                                        <li><a href="/resources/kiaalap/500.html">500 Page</a></li>
                                    </ul>
                                </li>
                                 -->
						</ul>
					</nav>
				</div>
			</div>
		</div>
	</div>
</div>



<!-- 학부모의 학급 클래스 입장 시, 자녀의 클래스 목록을 띄우는 모달 -->
<div id="goToChildClassModal"
	class="modal modal-edu-general default-popup-PrimaryModal fade"
	role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-close-area modal-close-df">
				<a class="close" data-dismiss="modal" href="#"> <i
					class="fa fa-close"></i></a>
			</div>
			<div class="modal-body">
				<h2><span style="background: linear-gradient(to top, #7cb8ff 20%, transparent 20%);">자녀 학급 클래스 목록</span></h2>
				<br>
				<div class="modal-body-clas-list">
					<div class="row child-content">
					</div>
				</div>
			</div>

		</div>
	</div>
</div>

<!-- 마이 페이지 입장 시 비밀번호 입력하는 모달 -->
<div id="enterMyPageModal"
	class="modal modal-edu-general default-popup-PrimaryModal fade"
	role="dialog" style="align-content: center;">
	<div class="modal-dialog" style="width: 450px;">
		<div class="modal-content" style="width: 450px; height: auto;">
			<div class="modal-close-area modal-close-df">
				<a class="close" data-dismiss="modal" href="#"><i class="fa fa-close"></i></a>
			</div>
			<div class="modal-body" style="padding: 40px 70px 30px 70px;">
				<div style="margin-bottom: 40px;">
					<h3><span style="background: linear-gradient(to top, #7cb8ff 20%, transparent 20%);">비밀번호 입력</span></h3>
				</div>
				<div id="pwChk" class="alert alert-danger alert-mg-b" role="alert" style="display: none;">
					비밀번호가 일치하지 않습니다.
				</div>
				<div id="enterMyPageContainer" style="margin-top: 10px; margin-bottom: 30px;">
					<ul class="InputPassword">
						<li>
							<input type="password" id="password" class="form-control" style="width: 100%;">
						</li>
					</ul>
				</div>
				<div class="modal-footer" style="text-align: center;">
					<a id="enterMyPageBtn" href="#">확인</a>
					<a data-dismiss="modal" href="#" style="margin-left: 10px;">취소</a>
				</div>
			</div>
		</div>
	</div>
</div>