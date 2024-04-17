<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<style>
/*학생 권한 사이드바 CSS*/
.student-sidebar{
	background: rgb(255 254 246 / 84%)!important;
    box-shadow: 0 8px 32px 0 rgba( 31, 38, 135, 0.37 )!important;
    backdrop-filter: blur(4px)!important;
    border: 1px solid rgba(255, 255, 255, 0.18)!important;
}
.student-sidebar .educate-icon:before{
	color:#ffa708 !important;
}
/*학생 권한 사이드바 CSS 끝*/

/*학부모 권한 사이브바 CSS 시작*/
.parents-sidebar{
	background: rgb(255 254 246 / 84%)!important;
    box-shadow: 0 8px 32px 0 rgba( 31, 38, 135, 0.37 )!important;
    backdrop-filter: blur(4px)!important;
    border: 1px solid rgba(255, 255, 255, 0.18)!important;
}
/*학부모 권한 사이브바 CSS 끝*/
/*선생님 권한 사이브바 CSS 시작*/
.teacher-sidebar{
	background: rgb(255 254 246 / 84%)!important;
    box-shadow: 0 8px 32px 0 rgba( 31, 38, 135, 0.37 )!important;
    backdrop-filter: blur(4px)!important;
    border: 1px solid rgba(255, 255, 255, 0.18)!important;
}
.teacher-sidebar .educate-icon:before{
	color:#111 !important;
}

.comment-scrollbar{
	height: 100%;
}
/*선생님 권한 사이브바 CSS 끝*/
</style>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script>

function openChatPop(url) {
	window.open(url, '_blank' , 'top=140, left=0, width=500, height=875, menubar=no, toolbar=no, location=no, directories=no, status=no, scrollbars=no, copyhistory=no, resizable=no');
}

window.onload = function(){
	var currentUrl = window.location.href;
	var str = "";
	
	$.ajax({
		url:"/getCurrentUrl",
		type:"get",
		data:{currentUrl:currentUrl},
		dataType:"text",
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success: function(res){
			// 학생 마이 페이지 or 칭찬 스티커 페이지인 경우 aside 설정
			if(res == "http://localhost/student/mypage" || res == "http://localhost/student/complimentSticker"){
				str += `
					<li>
					<a title="Landing Page" href="#" onclick="enterMypage()" aria-expanded="false">
					<span class="educate-icon educate-event icon-wrap sub-icon-mg" aria-hidden="true"></span>
					<span class="mini-click-non">마이 페이지</span>
					</a>
					</li>
					
					<li>
					<a title="Landing Page" href="/student/complimentSticker" aria-expanded="false">
					<span class="educate-icon educate-event icon-wrap sub-icon-mg" aria-hidden="true"></span>
					<span class="mini-click-non">칭찬 스티커</span>
					</a>
					</li>
					`;
				$(".metismenu").html(str);
			// 선생님/학부모 마이 페이지인 경우 aside 설정
			}else if(res == "http://localhost/teacher/mypage" || res == "http://localhost/parents/mypage"){
				str += `
					<li>
					<a title="Landing Page" href="#" onclick="enterMypage()" aria-expanded="false">
					<span class="educate-icon educate-event icon-wrap sub-icon-mg" aria-hidden="true"></span>
					<span class="mini-click-non">마이 페이지</span>
					</a>
					</li>
					`;
				$(".metismenu").html(str);
			} // end if
		} // end sucess
	}) // end ajax
}

</script>
<!-- 학생권한 사이드바 시작 -->
<sec:authorize access="hasRole('A01001')">
	<nav id="sidebar" class="student-sidebar">
		<form id="goServeyVote" method="post" action="/freeBoard/surveyAndVote"></form>
    	<div class="sidebar-header">
	    	<!-- 아이콘/프로젝트명 -->
	    	<a href="/main"><img src="/resources/images/common/Doodle.png" alt="" style="width: 90px;margin-top: 7px;"></a>
	        <strong>
	        	<a href="index.html">
	<!--         		<img src="/resources/kiaalap/img/logo/logosn.png" alt="" /> -->
	        	</a>
	        </strong>
	    </div>
	    <div class="left-custom-menu-adp-wrap comment-scrollbar">
	        <nav class="sidebar-nav left-sidebar-menu-pro">
	            <ul class="metismenu" id="menu1">
					<!-------------------------- 공통 권한 ----------------------------->	
					<!-------------------------- 공통 권한 ----------------------------->	
	                <li>
	                    <a title="Landing Page" href="/school/schoolList" aria-expanded="false">
		                    <span class="educate-icon educate-event icon-wrap sub-icon-mg" aria-hidden="true"></span>
		                    <span class="mini-click-non">학교/클래스 찾기</span>
	                    </a>
	                </li>
	                <!-- 교육부 소식 안내 게시판 시작-->
	                <li>
	                    <a title="Landing Page" href="/school/eduInfo" aria-expanded="false">
		                    <span class="educate-icon educate-event icon-wrap sub-icon-mg" aria-hidden="true"></span>
		                    <span class="mini-click-non">교육부 소식 안내</span>
	                    </a>
	                </li>
	                <!-- 교육부 소식 안내 게시판 끝 -->
					<sec:authorize access="isAuthenticated()">
					
					
					<!-------------------------- 학생 반 권한 ----------------------------->	
					<!-------------------------- 학생 반 권한 ----------------------------->	                
					<c:if test="${sessionScope.CLASS_INFO.clasCode ne null}">
					<!-- 학생 목록 시작 -->
					<li>
	                    <a title="Landing Page" href="/class/classStdntList" aria-expanded="false">
		                    <span class="educate-icon educate-student icon-wrap"></span>
<!-- 		                    <span class="educate-icon educate-event icon-wrap sub-icon-mg" aria-hidden="true"></span> -->
		                    <span class="mini-click-non">우리반 친구들</span>
	                    </a>
	                </li>
					<!-- 학생 목록 끝-->
					<!-- 출결 시작 -->
					<li>
						<a title="Landing Page" href="/dclz/main" aria-expanded="false">
		                    <span class="educate-icon educate-data-table icon-wrap sub-icon-mg" aria-hidden="true"></span>
		                    <span class="mini-click-non">출결</span>
	                    </a>
					</li>
					<!-- 출결 끝 -->
					<!-- 수업 시작 -->
					<li>
						<a title="Landing Page" href="https://code-gun.github.io/" target="_blank" aria-expanded="false">
		                    <span class="educate-icon educate-data-table icon-wrap sub-icon-mg" aria-hidden="true"></span>
		                    <span class="mini-click-non">수업</span>
	                    </a>
					</li>
					<!-- 수업 끝 -->
					<!-- 단원평가 + 과제 시작 -->
					<li class="" id="studentFreeBoardLi">
						<a class="has-arrow" href="index.html" aria-expanded="false">
							<span class="educate-icon educate-comment icon-wrap"></span>
								<span class="mini-click-non">단원평가/과제</span>
						</a>
						<ul class="submenu-angle collapse" aria-expanded="true" style="height: 0px;">
							<!-- 단원평가 -->
							<li>
								<a title="Landing Page" href="/unitTest/list" aria-expanded="false">
				                    <span class="mini-click-non">단원평가</span>
			                    </a>
							</li>
							<!-- 과제 게시판 시작 -->
							<li>
			                    <a title="Landing Page" href="/task/taskList?clasCode=${CLASS_INFO.clasCode}" aria-expanded="false">
				                    <span class="mini-click-non">과제 게시판</span>
			                    </a>
			                </li>
						</ul>
					</li>
					<!-- 단원평가 + 과제 끝 -->
					<!-- 게18 -->
					<sec:authorize access="isAuthenticated()">
						<li class="" id="studentFreeBoardLi">
							<a class="has-arrow" href="index.html" aria-expanded="false">
								<span class="educate-icon educate-comment icon-wrap"></span>
									<span class="mini-click-non">학급 마당</span>
							</a>
							<ul class="submenu-angle collapse" aria-expanded="true" style="height: 0px;">
								<li>
									<a title="Dashboard v.1" href="javascript:void(0);" onclick="location.href='/freeBoard/freeBoardList'">
										<span class="mini-sub-pro">자유 게시판</span>
									</a>
								</li>
								<li>
									<a title="Dashboard v.1" href="/gallery/gallery?clasCode=${CLASS_INFO.clasCode}">
										<span class="mini-sub-pro">학급 갤러리</span>
									</a>
								</li>
							</ul>
						</li>
						<li>
							<a class="has-arrow" href="index.html" aria-expanded="false">
								<span class="educate-icon educate-charts icon-wrap"></span>
								<span class="mini-click-non">설문/투표 게시판</span>
							</a>
							<ul class="submenu-angle collapse" aria-expanded="true" style="height: 0px;">
								<li>
									<a title="Dashboard v.2" href="javascript:void(0);" onclick="location.href='/freeBoard/surveyList'">
										<span class="mini-sub-pro">설문게시판</span>
									</a>
								</li>
								<li>
									<a title="Dashboard v.2" href="javascript:void(0);" onclick="location.href='/freeBoard/voteList'">
										<span class="mini-sub-pro">투표게시판</span>
									</a>
								</li>
								<sec:authorize access="hasRole('A01002')">
									<li>
										<a title="Dashboard v.2" href="javascript:void(0);" onclick="location.href='/freeBoard/surveyVoteChart'">
											<span class="mini-sub-pro">투표 현황</span>
										</a>
									</li>
								</sec:authorize>
							</ul>
						</li>
						</sec:authorize>
					<!-- 게18 끝-->
					
					
<!-- 					<li> -->
					<!-- 알림장 시작 -->
					<li>
	                    <a title="Landing Page" href="/ntcn/ntcnList?clasCode=${CLASS_INFO.clasCode}" aria-expanded="false">
		                    <span class="educate-icon educate-data-table icon-wrap sub-icon-mg" aria-hidden="true"></span>
		                    <span class="mini-click-non">알림장</span>
	                    </a>
	                </li>
					<!-- 알림장 끝 -->
					
					<!-- 일기장 시작 -->
					<li>
	                    <a title="Landing Page" href="/diary/goToDiaryList" aria-expanded="false">
		                    <span class="educate-icon educate-data-table icon-wrap"></span>
		                    <span class="mini-click-non">일기장</span>
	                    </a>
					</li>
					<!-- 일기장 끝 -->
					
					<!-- 방과후 임시 -->
	                <li class="">
						<a class="has-arrow" href="index.html" aria-expanded="false">
							<span class="educate-icon educate-data-table icon-wrap sub-icon-mg"></span>
								<span class="mini-click-non">방과후 학교</span>
						</a>
						<ul class="submenu-angle collapse" aria-expanded="true" style="height: 0px;">
							<li><a title="Dashboard v.1" href="javascript:void(0);" onclick="location.href='/afterSchool?schulCode=${SCHOOL_INFO.schulCode}'"><span class="mini-sub-pro">방과후학교 조회</span></a></li>
							<li><a title="Dashboard v.2" href="javascript:void(0);" onclick="location.href='/afterSchool/afterSchoolStdntMain?mberId=${USER_INFO.mberId}&schulCode=${SCHOOL_INFO.schulCode}'"><span class="mini-sub-pro">나의 방과후학교</span></a></li>
						</ul>
					</li>
					<!-- 방과후 임시 -->
					
					</c:if>
				

					<!-------------------------- 학생 학교 권한 ----------------------------->
					<!-------------------------- 학생 학교 권한 ----------------------------->
					<c:if test="${sessionScope.SCHOOL_INFO.schulCode ne null && sessionScope.CLASS_INFO == null}">
					<!-- 교직원 목록 시작 -->
	                <li>
	                    <a title="Landing Page" href="/employee/employeeList?schulCode=${SCHOOL_INFO.schulCode}" aria-expanded="false">
		                    <span class="educate-icon educate-professor icon-wrap"></span>
<!-- 		                    <span class="educate-icon educate-event icon-wrap sub-icon-mg" aria-hidden="true"></span> -->
		                    <span class="mini-click-non">교직원 목록</span>
	                    </a>
	                </li>
	                <!-- 교직원 목록 끝 -->
					<!-- 클래스 가입 시작 -->
					<li>
	                    <a title="Landing Page" href="/class/classList" aria-expanded="false">
		                    <span class="educate-icon educate-data-table icon-wrap sub-icon-mg" aria-hidden="true"></span>
		                    <span class="mini-click-non">클래스 가입 </span>
	                    </a>
	                </li>
					<!-- 클래스 가입 끝 -->
                	<li>
	                    <a title="Landing Page" href="/school/schafsSchedul" aria-expanded="false">
		                    <span class="educate-icon educate-event icon-wrap sub-icon-mg" aria-hidden="true"></span>
		                    <span class="mini-click-non">학사 일정</span>
	                    </a>
	                </li>
					<!-- 자료실 -->
					<li>
	                    <a title="Landing Page" href="/school/dataRoom" aria-expanded="false">
	                    	<span class="educate-icon educate-library icon-wrap"></span>
<!-- 		                    <span class="educate-icon educate-data-table icon-wrap sub-icon-mg" aria-hidden="true"></span> -->
		                    <span class="mini-click-non">자료실</span>
	                    </a>
	                </li>
					<!-- 자료실 끝 -->
	                </c:if>
					</sec:authorize>
	            </ul>
	        </nav>
	    </div>
	</nav>
</sec:authorize>
<!-- 학생권한 사이드바 끝 -->

<!-- 선생님권한 사이드바 시작 -->
<sec:authorize access="hasRole('A01002') or hasRole('A14003')">
	<nav id="sidebar" class="teacher-sidebar">
	    <div class="sidebar-header">
	    	<!-- 아이콘/프로젝트명 -->
	    	<a href="/main"><img src="/resources/images/common/Doodle.png" alt="" style="width: 90px;margin-top: 7px;"></a>
	        <strong>
	        	<a href="index.html">
	<!--         		<img src="/resources/kiaalap/img/logo/logosn.png" alt="" /> -->
	        	</a>
	        </strong>
	    </div>
	    <div class="left-custom-menu-adp-wrap comment-scrollbar">
	        <nav class="sidebar-nav left-sidebar-menu-pro">
	            <ul class="metismenu" id="menu1">
	            	
					<!-------------------------- 공통 권한 ----------------------------->	
					<!-------------------------- 공통 권한 ----------------------------->	
	                <li>
	                    <a title="Landing Page" href="/school/schoolList" aria-expanded="false">
		                    <span class="educate-icon educate-event icon-wrap sub-icon-mg" aria-hidden="true"></span>
		                    <span class="mini-click-non">학교/클래스 찾기</span>
	                    </a>
	                </li>
	                <!-- 교육부 소식 안내 게시판 시작-->
	                <li>
	                    <a title="Landing Page" href="/school/eduInfo" aria-expanded="false">
		                    <span class="educate-icon educate-event icon-wrap sub-icon-mg" aria-hidden="true"></span>
		                    <span class="mini-click-non">교육부 소식 안내</span>
	                    </a>
	                </li>
	                <!-- 교육부 소식 안내 게시판 끝 -->
	                
	                <sec:authorize access="isAuthenticated()">
					
					<!-------------------------- 교사 반 권한 ----------------------------->	
					<!-------------------------- 교사 반 권한 ----------------------------->	                
					<c:if test="${sessionScope.CLASS_INFO.clasCode ne null}">
					<!-- 출결 시작 -->
					<li>
						<a title="Landing Page" href="/dclz/main" aria-expanded="false">
		                    <span class="educate-icon educate-data-table icon-wrap sub-icon-mg" aria-hidden="true"></span>
		                    <span class="mini-click-non">출결</span>
	                    </a>
					</li>
					<!-- 출결 끝 -->
					<!-- 체험학습 처리 목록 시작 -->
					<li>
						<a title="Landing Page" href="javascript:void(0);" onclick="location.href='/approval/approvalList?clasCode=${CLASS_INFO.clasCode}'">
							<span class="educate-icon educate-data-table icon-wrap sub-icon-mg" aria-hidden="true"></span>
							<span class="mini-click-non">체험학습 목록</span>
						</a>
					</li>
					<!-- 체험학습 처리 목록 끝 -->
					<!-- 수업 시작 -->
					<li>
						<a title="Landing Page" href="https://code-gun.github.io/" target="_blank" aria-expanded="false">
		                    <span class="educate-icon educate-data-table icon-wrap sub-icon-mg" aria-hidden="true"></span>
		                    <span class="mini-click-non">수업</span>
	                    </a>
					</li>
					<!-- 수업 끝 -->
					<!-- 게18 -->
					<sec:authorize access="isAuthenticated()">
						<li class="" id="studentFreeBoardLi">
							<a class="has-arrow" href="index.html" aria-expanded="false">
								<span class="educate-icon educate-comment icon-wrap"></span>
									<span class="mini-click-non">학급 마당</span>
							</a>
							<ul class="submenu-angle collapse" aria-expanded="true" style="height: 0px;">
								<li>
									<a title="Dashboard v.1" href="javascript:void(0);" onclick="location.href='/freeBoard/freeBoardList'">
										<span class="mini-sub-pro">자유 게시판</span>
									</a>
								</li>
								<li>
									<a title="Dashboard v.1" href="/gallery/gallery?clasCode=${CLASS_INFO.clasCode}">
										<span class="mini-sub-pro">학급 갤러리</span>
									</a>
								</li>
							</ul>
						</li>
						<li>
							<a class="has-arrow" href="index.html" aria-expanded="false">
								<span class="educate-icon educate-charts icon-wrap"></span>
								<span class="mini-click-non">설문/투표 게시판</span>
							</a>
							<ul class="submenu-angle collapse" aria-expanded="true" style="height: 0px;">
								<li>
									<a title="Dashboard v.2" href="javascript:void(0);" onclick="location.href='/freeBoard/surveyList'">
										<span class="mini-sub-pro">설문게시판</span>
									</a>
								</li>
								<li>
									<a title="Dashboard v.2" href="javascript:void(0);" onclick="location.href='/freeBoard/voteList'">
										<span class="mini-sub-pro">투표게시판</span>
									</a>
								</li>
								<sec:authorize access="hasRole('A01002')">
									<li>
										<a title="Dashboard v.2" href="javascript:void(0);" onclick="location.href='/freeBoard/surveyVoteChart'">
											<span class="mini-sub-pro">투표 현황</span>
										</a>
									</li>
								</sec:authorize>
							</ul>
						</li>		
					</sec:authorize>
					<!-- 게18 끝-->
					<!-- 단원평가 + 과제 -->
					<li class="" id="studentFreeBoardLi">
						<a class="has-arrow" href="index.html" aria-expanded="false">
							<span class="educate-icon educate-comment icon-wrap"></span>
								<span class="mini-click-non">단원평가/과제</span>
						</a>
						<ul class="submenu-angle collapse" aria-expanded="true" style="height: 0px;">
							<!-- 단원평가 -->
							<li>
								<a title="Landing Page" href="/unitTest/list" aria-expanded="false">
				                    <span class="mini-click-non">단원평가</span>
			                    </a>
							</li>
							<!-- 과제 게시판 시작 -->
							<li>
			                    <a title="Landing Page" href="/task/taskList?clasCode=${CLASS_INFO.clasCode}" aria-expanded="false">
				                    <span class="mini-click-non">과제 게시판</span>
			                    </a>
			                </li>
						</ul>
					</li>
					<li>
					
					<!-- 알림장 -->
					<li>
	                    <a title="Landing Page" href="/ntcn/ntcnList?clasCode=${CLASS_INFO.clasCode}" aria-expanded="false">
		                    <span class="educate-icon educate-data-table icon-wrap sub-icon-mg" aria-hidden="true"></span>
		                    <span class="mini-click-non">알림장</span>
	                    </a>
	                </li>
					<!-- 알림장 끝-->
					<!-- 선생님이 확인하는 상담 예약 시작 -->
	                <li class="">
						<a class="has-arrow" href="index.html" aria-expanded="false">
							<span class="educate-icon educate-data-table icon-wrap sub-icon-mg"></span>
								<span class="mini-click-non">학부모 상담 관리</span>
						</a>
						<ul class="submenu-angle collapse" aria-expanded="true" style="height: 0px;">
							<li><a title="상담 일정 보기" href="/cnslt/goToTeacherCnsltList"><span class="mini-sub-pro">상담 일정 관리</span></a></li>
							<li><a title="상담 일지 게시판" href="/cnslt/goToCnsltDiaryList"><span class="mini-sub-pro">상담 일지 게시판</span></a></li>
						</ul>
					</li>
					<!-- 선생님이 확인하는 상담 예약 끝 -->
					<!-- 클래스 -->
					<sec:authorize access="isAuthenticated()">
						<li class="">
							<a class="has-arrow" href="index.html" aria-expanded="false">
								<span class="educate-icon educate-comment icon-wrap"></span>
									<span class="mini-click-non">클래스 관리</span>
							</a>
							<ul class="submenu-angle collapse" aria-expanded="true" style="height: 0px;">
								<li><a title="Dashboard v.1" href="javascript:void(0);" onclick="location.href='/class/classTStudList'"><span class="mini-sub-pro">학생 목록</span></a></li>
								<li><a title="Dashboard v.1" href="javascript:void(0);" onclick="location.href='/class/classTParentList'"><span class="mini-sub-pro">학부모 목록</span></a></li>
							</ul>
						</li>
					</sec:authorize>
					<!-- 클래스 끝-->
					<!-- 가입관리 -->
					<sec:authorize access="isAuthenticated()">
						<li class="">
							<a class="has-arrow" href="index.html" aria-expanded="false">
								<span class="educate-icon educate-comment icon-wrap"></span>
									<span class="mini-click-non">가입 관리</span>
							</a>
							<ul class="submenu-angle collapse" aria-expanded="true" style="height: 0px;">
								<li><a title="Dashboard v.1" href="javascript:void(0);" onclick="location.href='/class/classJoinReqList'"><span class="mini-sub-pro">가입신청 목록</span></a></li>
								<li><a title="Dashboard v.1" href="javascript:void(0);" onclick="location.href='/class/classJoinRJList'"><span class="mini-sub-pro">가입거절 목록</span></a></li>
							</ul>
						</li>
					</sec:authorize>
					<!-- 가입관리 끝-->
					<!-- 일기장 시작 -->
					<li>
	                    <a title="Landing Page" href="/diary/goToDiaryList" aria-expanded="false">
		                    <span class="educate-icon educate-data-table icon-wrap"></span>
		                    <span class="mini-click-non">학급 일기장</span>
	                    </a>
					</li>
					<!-- 일기장 끝 -->
					<!-- 방과후 학교 -->
					<li class="">
						<a class="has-arrow" href="index.html" aria-expanded="false">
							<span class="educate-icon educate-course icon-wrap"></span>
<!-- 							<span class="educate-icon educate-data-table icon-wrap sub-icon-mg"></span> -->
							<span class="mini-click-non">방과후 학교</span>
						</a>
						<ul class="submenu-angle collapse" aria-expanded="true" style="height: 0px;">
							<li><a title="Dashboard v.1" href="javascript:void(0);" onclick="location.href='/afterSchool?schulCode=${SCHOOL_INFO.schulCode}'"><span class="mini-sub-pro">방과후학교 조회</span></a></li>
							<li><a title="Dashboard v.2" href="javascript:void(0);" onclick="location.href='/afterSchool/afterSchoolMain?mberId=${USER_INFO.mberId}&schulCode=${SCHOOL_INFO.schulCode}'"><span class="mini-sub-pro">방과후학교 관리</span></a></li>						</ul>
					</li>
					<!-- 방과후 학교 끝 -->
					</c:if>
					
					<!-------------------------- 교사 학교 권한 ----------------------------->
					<!-------------------------- 교사 학교 권한 ----------------------------->
					<c:if test="${sessionScope.SCHOOL_INFO.schulCode ne null && sessionScope.CLASS_INFO == null}">
	                <!-- 학교 구성원 목록 시작 -->
	                <li>
						<a class="has-arrow" href="index.html" aria-expanded="false">
							<span class="educate-icon educate-student icon-wrap"></span>
							<span class="mini-click-non">학교 구성원</span>
						</a>
						<ul class="submenu-angle collapse" aria-expanded="true" style="height: 0px;">
							<li>
			                    <a title="Landing Page" href="/employee/employeeList?schulCode=${SCHOOL_INFO.schulCode}" aria-expanded="false">
				                    <span class="mini-click-non">교직원 목록</span>
			                    </a>
			                </li>
							<li>
								<a title="Landing Page" href="/employee/studentList?schulCode=${SCHOOL_INFO.schulCode}" aria-expanded="false">
				                    <span class="mini-click-non">학생 목록</span>
			                    </a>
			                </li>
						</ul>
					</li>
	                <!-- 학교 구성원 목록 끝 -->
					<!-- 채팅 시작 -->
					<li>
	                    <a title="Landing Page" href="javascript:void(0);" onclick="openChatPop('/chat/friends?schulCode=${SCHOOL_INFO.schulCode}')" id="openChat" aria-expanded="false">
	                    	<span class="educate-icon educate-interface icon-wrap"></span>
<!-- 		                    <span class="educate-icon educate-event icon-wrap sub-icon-mg" aria-hidden="true"></span> -->
		                    <span class="mini-click-non">1대1 채팅</span>
	                    </a>
	                </li>
	                <!-- 채팅 끝 -->
					<!-- 클래스 가입 시작 -->
					<li>
	                    <a title="Landing Page" href="/class/classList" aria-expanded="false">
	                    	<span class="educate-icon educate-course icon-wrap"></span>
<!-- 		                    <span class="educate-icon educate-data-table icon-wrap sub-icon-mg" aria-hidden="true"></span> -->
		                    <span class="mini-click-non">교내 클래스 </span>
	                    </a>
	                </li>
					<!-- 클래스 가입 끝 -->

					<li>
	                    <a title="Landing Page" href="/school/schafsSchedul" aria-expanded="false">
		                    <span class="educate-icon educate-event icon-wrap sub-icon-mg" aria-hidden="true"></span>
		                    <span class="mini-click-non">학사 일정</span>
	                    </a>
	                </li>
	                <!-- 자료실 -->
					<li>
	                    <a title="Landing Page" href="/school/dataRoom" aria-expanded="false">
	                    	<span class="educate-icon educate-library icon-wrap"></span>
<!-- 		                    <span class="educate-icon educate-data-table icon-wrap sub-icon-mg" aria-hidden="true"></span> -->
		                    <span class="mini-click-non">자료실</span>
	                    </a>
	                </li>
					<!-- 자료실 끝 -->
					
						<sec:authorize access="hasRole('A14005')">
							<li>
								<a title="Landing Page" href="javascript:void(0);" onclick="location.href='/approval/approvalList?schulCode=${SCHOOL_INFO.schulCode}'">
									<span class="educate-icon educate-data-table icon-wrap sub-icon-mg" aria-hidden="true"></span>
									<span class="mini-click-non">체험학습 목록</span>
								</a>
							</li>
						</sec:authorize>
					</c:if>
					</sec:authorize>	
	                
	            </ul>
	        </nav>
	    </div>
	</nav>
</sec:authorize>
<!-- 선생권한 사이드바 끝-->
<!-- 학부모권한 사이드바 시작 -->
<sec:authorize access="hasRole('A01003')">
	<nav id="sidebar" class="parents-sidebar">
	    <div class="sidebar-header">
	    	<!-- 아이콘/프로젝트명 -->
	    	<a href="/main"><img src="/resources/images/common/Doodle.png" alt="" style="width: 90px;margin-top: 7px;"></a>
	        <strong>
	        	<a href="index.html">
	<!--         		<img src="/resources/kiaalap/img/logo/logosn.png" alt="" /> -->
	        	</a>
	        </strong>
	    </div>
	    <div class="left-custom-menu-adp-wrap comment-scrollbar">
	        <nav class="sidebar-nav left-sidebar-menu-pro">
	            <ul class="metismenu" id="menu1">

					<!-------------------------- 학부모 공통 권한 ----------------------------->	
					<!-------------------------- 학부모 공통 권한 ----------------------------->	
	                <li>
	                    <a title="Landing Page" href="/school/schoolList" aria-expanded="false">
		                    <span class="educate-icon educate-event icon-wrap sub-icon-mg" aria-hidden="true"></span>
		                    <span class="mini-click-non">학교/클래스 찾기</span>
	                    </a>
	                </li>
	                <!-- 교육부 소식 안내 게시판 시작-->
	                <li>
	                    <a title="Landing Page" href="/school/eduInfo" aria-expanded="false">
		                    <span class="educate-icon educate-event icon-wrap sub-icon-mg" aria-hidden="true"></span>
		                    <span class="mini-click-non">교육부 소식 안내</span>
	                    </a>
	                </li>
	                <!-- 교육부 소식 안내 정보 게시판 끝 -->
	                
	                
            		<sec:authorize access="isAuthenticated()">
					
					<!-------------------------- 학부모 반 권한 ----------------------------->	
					<!-------------------------- 학부모 반 권한 ----------------------------->	                
					<c:if test="${sessionScope.CLASS_INFO.clasCode ne null}">
					<!-- 학생 목록 시작 -->
					<li>
	                    <a title="Landing Page" href="/class/classStdntList" aria-expanded="false">
		                    <span class="educate-icon educate-student icon-wrap"></span>
<!-- 		                    <span class="educate-icon educate-event icon-wrap sub-icon-mg" aria-hidden="true"></span> -->
		                    <span class="mini-click-non">우리반 친구들</span>
	                    </a>
	                </li>
					<!-- 학생 목록 끝-->
					<!-- 출결 시작 -->
					<li>
						<a title="Landing Page" href="/dclz/main" aria-expanded="false">
		                    <span class="educate-icon educate-data-table icon-wrap sub-icon-mg" aria-hidden="true"></span>
		                    <span class="mini-click-non">출결</span>
	                    </a>
					</li>
					<!-- 출결 끝 -->
					<!-- 결석 신청 -->
					<li class="">
						<a class="has-arrow" href="index.html" aria-expanded="false">
							<span class="educate-icon educate-comment icon-wrap"></span>
								<span class="mini-click-non">공결신청</span>
						</a>
						<ul class="submenu-angle collapse" aria-expanded="true" style="height: 0px;">
							<li><a title="Dashboard v.1" href="javascript:void(0);" onclick="location.href='/approval/approvalList?clasStdntCode=${CLASS_STD_INFO.clasStdntCode}'"><span class="mini-sub-pro">체험학습 목록</span></a></li>
						</ul>
						<ul class="submenu-angle collapse" aria-expanded="true" style="height: 0px;">
							<li><a title="Dashboard v.1" href="javascript:void(0);" onclick="location.href='/approval/fieldStudyApply?clasCode=${CLASS_INFO.clasCode}'"><span class="mini-sub-pro">체험학습 신청서</span></a></li>
						</ul>
						<ul class="submenu-angle collapse" aria-expanded="true" style="height: 0px;">
							<li><a title="Dashboard v.1" href="javascript:void(0);" onclick="location.href='/approval/fieldStudyReport?clasCode=${CLASS_INFO.clasCode}'"><span class="mini-sub-pro">체험학습 보고서</span></a></li>
						</ul>
					</li>
					<!-- 결석 신청 끝-->
					<!-- 단원평가 + 과제 -->
					<li class="" id="studentFreeBoardLi">
						<a class="has-arrow" href="index.html" aria-expanded="false">
							<span class="educate-icon educate-comment icon-wrap"></span>
								<span class="mini-click-non">단원평가/과제</span>
						</a>
						<ul class="submenu-angle collapse" aria-expanded="true" style="height: 0px;">
							<!-- 단원평가 -->
							<li>
								<a title="Landing Page" href="/unitTest/list" aria-expanded="false">
				                    <span class="mini-click-non">단원평가</span>
			                    </a>
							</li>
							<!-- 과제 게시판 시작 -->
							<li>
			                    <a title="Landing Page" href="/task/taskList?clasCode=${CLASS_INFO.clasCode}" aria-expanded="false">
				                    <span class="mini-click-non">과제 게시판</span>
			                    </a>
			                </li>
						</ul>
					</li>
					<!-- 학부모 학급클래스 -->
					<sec:authorize access="isAuthenticated()">
						<li class="" id="studentFreeBoardLi">
							<a class="has-arrow" href="index.html" aria-expanded="false">
								<span class="educate-icon educate-comment icon-wrap"></span>
									<span class="mini-click-non">학급 마당</span>
							</a>
							<ul class="submenu-angle collapse" aria-expanded="true" style="height: 0px;">
								<li>
									<a title="Dashboard v.1" href="javascript:void(0);" onclick="location.href='/freeBoard/freeBoardList'">
										<span class="mini-sub-pro">자유 게시판</span>
									</a>
								</li>
								<li>
									<a title="Dashboard v.1" href="/gallery/gallery?clasCode=${CLASS_INFO.clasCode}">
										<span class="mini-sub-pro">학급 갤러리</span>
									</a>
								</li>
							</ul>
						</li>
						<li>
							<a class="has-arrow" href="index.html" aria-expanded="false">
								<span class="educate-icon educate-charts icon-wrap"></span>
								<span class="mini-click-non">설문/투표 게시판</span>
							</a>
							<ul class="submenu-angle collapse" aria-expanded="true" style="height: 0px;">
								<li>
									<a title="Dashboard v.2" href="javascript:void(0);" onclick="location.href='/freeBoard/surveyList'">
										<span class="mini-sub-pro">설문게시판</span>
									</a>
								</li>
								<li>
									<a title="Dashboard v.2" href="javascript:void(0);" onclick="location.href='/freeBoard/voteList'">
										<span class="mini-sub-pro">투표게시판</span>
									</a>
								</li>
								<sec:authorize access="hasRole('A01002')">
									<li>
										<a title="Dashboard v.2" href="javascript:void(0);" onclick="location.href='/freeBoard/surveyVoteChart'">
											<span class="mini-sub-pro">투표 현황</span>
										</a>
									</li>
								</sec:authorize>
							</ul>
						</li>
					</sec:authorize>		
	                <!-- 게18 끝-->
	                
					<li>
	                
					<!-- 알림장 시작 -->
					<li>
	                    <a title="Landing Page" href="/ntcn/ntcnList?clasCode=${CLASS_INFO.clasCode}" aria-expanded="false">
		                    <span class="educate-icon educate-data-table icon-wrap sub-icon-mg" aria-hidden="true"></span>
		                    <span class="mini-click-non">알림장</span>
	                    </a>
	                </li>
					<!-- 알림장 끝 -->
					<!-- 학부모 학급클래스 시작 -->
	                <li>
	                    <a title="Landing Page" href="/cnslt/goToCnsltList" aria-expanded="false">
		                    <span class="educate-icon educate-data-table icon-wrap sub-icon-mg" aria-hidden="true"></span>
		                    <span class="mini-click-non">상담 예약</span>
	                    </a>
	                </li>
	                <!-- 학부모 학급클래스 끝 -->
					<!-- 방과후 학교 -->
					<li class=""><a class="has-arrow" href="index.html"
						aria-expanded="false"> <span
							class="educate-icon educate-data-table icon-wrap sub-icon-mg"></span>
							<span class="mini-click-non">방과후 학교</span>
					</a>
						<ul class="submenu-angle collapse" aria-expanded="true"
							style="height: 0px;">
							<li><a title="Dashboard v.1" href="javascript:void(0);"
								onclick="location.href='/afterSchool?schulCode=${SCHOOL_INFO.schulCode}'"><span
									class="mini-sub-pro">방과후학교 조회</span></a></li>
							<li><a title="Dashboard v.2" href="javascript:void(0);"
								onclick="location.href='/afterSchool/afterSchoolStdntMain?mberId=${CLASS_STD_INFO.mberId}&schulCode=${SCHOOL_INFO.schulCode}'"><span
									class="mini-sub-pro">내 자녀 방과후학교</span></a></li>
						</ul></li>
					<!-- 방과후 학교-->
		                
	                </c:if>
	                
	                
	                <!-------------------------- 학부모 학교 권한 ----------------------------->	
					<!-------------------------- 학부모 학교 권한 ----------------------------->	                
					<c:if test="${sessionScope.SCHOOL_INFO.schulCode ne null && sessionScope.CLASS_INFO == null}">	  
	                <!-- 교직원 목록 시작 -->
	                <li>
	                    <a title="Landing Page" href="/employee/employeeList?schulCode=${SCHOOL_INFO.schulCode}" aria-expanded="false">
		                    <span class="educate-icon educate-professor icon-wrap"></span>
<!-- 		                    <span class="educate-icon educate-event icon-wrap sub-icon-mg" aria-hidden="true"></span> -->
		                    <span class="mini-click-non">교직원 목록</span>
	                    </a>
	                </li>
	                <!-- 교직원 목록 끝 -->
	                <!-- 클래스 가입 시작 -->
					<li>
	                    <a title="Landing Page" href="/class/classList" aria-expanded="false">
		                    <span class="educate-icon educate-data-table icon-wrap sub-icon-mg" aria-hidden="true"></span>
		                    <span class="mini-click-non">클래스 가입 </span>
	                    </a>
	                </li>
					<!-- 클래스 가입 끝 -->
	                 <li>
	                    <a title="Landing Page" href="/school/schafsSchedul" aria-expanded="false">
		                    <span class="educate-icon educate-event icon-wrap sub-icon-mg" aria-hidden="true"></span>
		                    <span class="mini-click-non">학사 일정</span>
	                    </a>
	                </li>
					<!-- 자료실 -->
					<li>
	                    <a title="Landing Page" href="/school/dataRoom" aria-expanded="false">
		                    <span class="educate-icon educate-library icon-wrap"></span>
<!-- 		                    <span class="educate-icon educate-data-table icon-wrap sub-icon-mg" aria-hidden="true"></span> -->
		                    <span class="mini-click-non">자료실</span>
	                    </a>
	                </li>
					<!-- 자료실 끝 -->
	                </c:if>
	                </sec:authorize>
					
	            </ul>
	        </nav>
	    </div>
	</nav>
</sec:authorize>
<!-- 선생님 권한 사이드바 끝 -->
<!-- 관리자 권한 사이드바 시작 -->
<sec:authorize access="hasRole('A01000')">
	<nav id="sidebar" class="parents-sidebar">
	    <div class="sidebar-header">
	    	<!-- 아이콘/프로젝트명 -->
	    	<div style ="height:60px;"><a href="/admin/adminMain" style="color:#111;">DOODLE</a></div>
	        <strong>
	        	<a href="index.html">
	<!--         		<img src="/resources/kiaalap/img/logo/logosn.png" alt="" /> -->
	        	</a>
	        </strong>
	    </div>
	    <div class="left-custom-menu-adp-wrap comment-scrollbar">
	        <nav class="sidebar-nav left-sidebar-menu-pro">
	            <ul class="metismenu" id="menu1">
	            	<!-- 교육부 소식 안내 게시판 시작-->
	                <li>
	                    <a title="Landing Page" href="/school/eduInfo" aria-expanded="false">
		                    <span class="educate-icon educate-event icon-wrap sub-icon-mg" aria-hidden="true"></span>
		                    <span class="mini-click-non">교육부 소식 안내</span>
	                    </a>
	                </li>
	                <!-- 교육부 소식 안내 게시판 끝 -->
	            	<!-- 이하 메뉴 버튼 -->
	                <li>
	                    <a title="Landing Page" href="/admin/complaint" aria-expanded="false">
		                    <span class="educate-icon educate-event icon-wrap sub-icon-mg" aria-hidden="true"></span>
		                    <span class="mini-click-non">신고 게시판</span>
	                    </a>
	                </li>
	            </ul>
	        </nav>
	    </div>
	</nav>
</sec:authorize>
<!-- 관리자 권한 사이드바 끝 -->