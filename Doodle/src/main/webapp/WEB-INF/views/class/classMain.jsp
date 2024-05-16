<%@page import="kr.or.ddit.vo.HrtchrVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!-- 스와이프 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css"/>
<script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
<link rel="stylesheet" href="/resources/css/mainPage.css">
<style>
/* 프로필 시작 */
#profileImg{
   height: 150px;
   width: 150px; 
   border-radius: 70%;
   object-fit: cover;
}

.single-product-text .cards-hd-dn {
	margin-top: 0;
}
/* 프로필 끝 */

/* 메뉴 이름 */
.menuTitle h3{
	font-size: 20px;
	margin: 5px 0 0 5px;
}

/* 진행 중인 일정 */
.contentBox{
	border: 1px solid #ccc;
    border-radius: 10px;
    padding: 20px;
    margin: 12px 0px 7px 5px;
}

/* 바로 가기 시작 */
.shortcut{
	border: 1px solid #999;
    border-radius: 7px;
    padding: 0 5px;
    align-content: center;
    color: #777;
    font-size: small;
}

.shortcut:hover{
	background: #eee;
}

.shortcutIcon{
	width:12px; margin-right: 3px;
}
/* 바로 가기 끝 */

/* 불러온 목록 데이터 없을 때 처리 */
.noList{
	background: #f4f4f4;
    margin: auto;
    height: 260px;
    border-radius: 10px;
    align-content: center;
    text-align: center;
    color: #999;
}

#classMain {
	width :1400px;
	margin :auto;
}

#classMain h3, #classMain h2, #classMain h1 {
	display:inline-block;
}

#classMain td {
	border-radius: 0px;
}

.hor-div{
	margin-bottom: 12px;
}

.single-product-text {
    padding: 20px;
}

#classMain .d-btn-blue {
	height : 30px;
	width : 100%;
	display: inline-block;
	box-shadow: 0px 0px 10px 3px #0c4c9c20, inset 0px 0px 10px 1px #ffffff70;
}

.std-btn {
	font-size: 1.2rem;
	font-weight: 700;
	border-radius: 7px;
	box-shadow: 0px 0px 10px 3px #0c4c9c20, inset 0px 0px 10px 1px #ffffff70;
}

.box table {
	background-color: transparent;
}
.box .box {
	margin-bottom: 0px;
	margin-top: 0px;
}

.swiper-slide{
	display:flex;
	padding: 10px;
	justify-content: center;
}

.swiper-slide img {
	object-fit: cover;
	height : 100%; 
	width :227px;
	margin: 0px 10px;
	border-radius: 50px;
	box-shadow: 0px 0px 10px 2px #00000015;
}

.con {
	height : 90%;
	margin-top: 15px;
}

.modal-body-class-stdnt {
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
}	

.modal-body-class-stdnt h3{
	padding-bottom: 30px;
}

.product-status-wrap.drp-lst table td {
    padding: 10px 7px;
}
</style>

<script type="text/javascript" src="/resources/js/jquery.min.js" ></script>
<script type="text/javascript">
var clasCode = '${clasCode}';

// 새창에서 채팅창 여는 함수
function openChatPop(url) {
    window.open(url, '_blank', 'top=140, left=0, width=500, height=875, menubar=no, toolbar=no, location=no, directories=no, status=no, scrollbars=no, copyhistory=no, resizable=no');
}

// 상단 학교 정보
const setSchoolBanner = function(){
	let str = "${SCHOOL_INFO.schulNm} "+toNumGrade('${CLASS_INFO.cmmnGrade}')+"학년 ${CLASS_INFO.clasNm}"
	document.querySelector("#schoolInfoBanner").innerText = str;
}

// 반 정보 모달 초기화
const classInfoModalInit = function(){
	document.querySelector("#infoClasNm").value = '${CLASS_INFO.clasNm}';
	document.querySelector("#infoClasYear").value = '${CLASS_INFO.clasYear}';
	document.querySelector("#infoCmmnGrade").value = toNumGrade('${CLASS_INFO.cmmnGrade}');
	document.querySelector("#infoBeginTm").value = '${CLASS_INFO.beginTm}';
	document.querySelector("#infoEndTm").value = '${CLASS_INFO.endTm}';
}

// 반 정보 버튼
const classroomInfoBtn = function(){
    let url="/class/viewClassMgmt?clasCode=" + clasCode;
    let features = "scrollbars=no, width=500, height=700, location=no, resizable=yes";
    let windowName = "반 정보";
    classManagementWindow = window.open(url, windowName, features);
}

// 빈 수정
const modifyClassroom = function(){
	$.ajax({
		url:"/class/modifyClassroom",
		method:"post",
		contentType: "application/json; charset=utf-8",
		dataType:"json",
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success :function(res){
		}
	})
}

// 반 삭제
const deleteClassroom = function(){
	cjh.swConfirm("반 삭제", "해당 반을 삭제하시겠습니까?", "error").then(function(res){
		if(res.isConfirmed){
			$.ajax({
				url:"/class/deleteClassroom",
				method:"post",
				contentType: "application/json; charset=utf-8",
				dataType:"json",
				beforeSend:function(xhr){
					xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
				},
				success :function(res){
					if(res > 0){
						cjh.swAlert("완료", "반이 정상적으로 삭제되었습니다.", "success").then(function(){
							location.href = "/main";
						})
					} else{
						cjh.swAlert("실패", "반 삭제에 실패했습니다.", "error");
					}
				}
			})
		}
	})
}

// 학생 목록
const getStdList = function(){
	$.ajax({
		url:"/class/getStdList",
		method:"post",
		data:JSON.stringify({"clasCode":'${CLASS_INFO.clasCode}'}),
		contentType: "application/json; charset=utf-8",
		dataType:"json",
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success :function(res){
			str ="";
			res.forEach(function(std){
				str += `<tr>
						<td>\${std.clasInNo}</td>
						<td>\${std.memberVO.mberNm}</td>
						<td>\${std.memberVO.ihidnum}</td>
						<td>\${std.memberVO.moblphonNo}</td>
						<td>\${std.memberVO.mberEmail}</td>
						</tr>
						`;
			})
			
			if(str != ""){
				document.querySelector("#stdListTb tbody").innerHTML = str;
			}
			
		},error:function(request, status, error){
		}
	})
}

// 과제 목록
const getTaskList = function(){
	$.ajax({
		url:"/class/getTaskList",
		method:"post",
		data:JSON.stringify({"clasCode":'${CLASS_INFO.clasCode}',
			"size":"20"}),
		contentType: "application/json; charset=utf-8",
		dataType:"json",
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success :function(res){
			str = "";
			
			if(res.length > 0){
				res.forEach(function(task){
					str += `<tr class = "d-tr" onclick = "goToTask('\${task.taskCode}')">
							<td>\${cutStr(task.taskSj,15)}</td>
							<td>\${dateFormat(task.taskEndDt)}</td>
							</tr>`;
				})
				
				if(str != ""){
					document.querySelector("#taskListTb tbody").innerHTML = str;
				}
			}else{
				str = `
					<div class='noList'>
					<p>등록된 과제가 없습니다.</p>
					</div>
					`;
				document.querySelector("#taskListTb").innerHTML = str;
			}
			
		},error:function(request, status, error){
		}
	});
}

// 실행중인 단원평가
const getDoingExam = function(){
	$.ajax({
		url:"/unitTest/getDoingExam",
		method:"post",
		contentType: "application/json; charset=utf-8",
		dataType:"json",
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success :function(res){
			str = "";
			
			if(res.length > 0){
				res.forEach(function(ue){
					str += `<tr class = "d-tr" onclick = "goToUe('\${ue.unitEvlCode}')">
							<td>\${cutStr(ue.unitEvlNm, 15)}</td>
							<td>\${dateToMinFormat(ue.unitEvlEndDt)}</td>`;
				})
				
				if(str != ""){
					document.querySelector("#unitTestListTb tbody").innerHTML = str;
				}
			}else{
				str = `
					<div class='noList'>
					<p>등록된 단원평가가 없습니다.</p>
					</div>
					`;
				document.querySelector("#unitTestListTb").innerHTML = str;
			}
		},error:function(request, status, error){
		}
	});
}

//알림장 목록
const getNtcnList = function(){
	$.ajax({
		url:"/class/getNtcnList",
		method:"post",
		data:JSON.stringify({"clasCode":'${CLASS_INFO.clasCode}',
			"size":"20"}),
		contentType: "application/json; charset=utf-8",
		dataType:"json",
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success :function(res){
			str = "";
			
			if(res.length > 0){
				res.forEach(function(nt){
					let mmdd = dateFormat(nt.ntcnWritngDt).substr(5);
					
					str += `<tr class = "d-tr" onclick = "goToNt('\${nt.ntcnCode}')">
							<td>`;
	
					if(nt.imprtcNtcnAt == 1){
						str += `★` ;
					}
							
					str +=	`\${cutStr(nt.ntcnSj,13)}</td>
							<td>\${mmdd}</td>`;
				})
				
				if(str != ""){
					document.querySelector("#ntcnListTb tbody").innerHTML = str;
				}
			}else{
				str = `
					<div class='noList' style='height: 343px;'>
					<p>등록된 글이 없습니다.</p>
					</div>
					`;
				document.querySelector("#ntcnListTb").innerHTML = str;
			}
			
		},error:function(request, status, error){
		}
	});
}

//최근 출결 목록
const getRecentAtend = function(){
	$.ajax({
		url:"/dclz/getRecentAtend",
		method:"post",
		data:JSON.stringify({
			"clasCode":'${CLASS_INFO.clasCode}',
			"size":"30"
		}),
		contentType: "application/json; charset=utf-8",
		dataType:"json",
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success :function(res){
			str = "";
			
			if(res.length > 0){
				res.forEach(function(at){
					str += `<tr>
							<td>\${at.dclzProcessTime}</td>
							<td>\${at.mberNm}</td>
							<tr>`;
				})
				
				if(str != ""){
					document.querySelector("#recentAtendTb tbody").innerHTML = str;
				}
			}else{
				str = `
					<div class='noList' style='height: 247px;'>
					<p>출결 내역이 없습니다.</p>
					</div>
					`;
				document.querySelector("#recentAtendTb").innerHTML = str;
			}
			
		},error:function(request, status, error){
		}
	});
}

// 반 앨범 내 사진 get
const getClasImg = function(){
	$.ajax({
		url:"/class/getClasImg",
		method:"post",
		data:JSON.stringify({"size":"9"}),
		contentType: "application/json; charset=utf-8",
		dataType:"json",
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success :function(res){
			str = "";
			res.forEach(function(f,index) {
				if ((index)%3 == 0){
					str += `<div class="swiper-slide">`;
				}
				
	        	// 파일 경로(ex : /2024/03/13/)
	        	var folderPath = f.atchFileCours.substring(0, f.atchFileCours.lastIndexOf("/") + 1);
	        	// 파일 이름 갖고오기(ex : 51e7d73a-b77e-44bc-9a3f-95ce81d3099c_P1234.jpg)
		        var fileName = f.atchFileCours.substring(f.atchFileCours.lastIndexOf("/") + 1);
		        // 파일 경로
		        var filePath ="/upload"+folderPath + fileName;
		       	
		        str += "<img alt='로고' id='img"+index+"' src='" + filePath+"'>";

		        if ((index+1)%3 == 0){
					str += `</div>`;
				}
			})
			
			if(res.length%3 != 0){
				str += `</div>`;
			}
			
			if(str != ""){
				document.querySelector(".swiper-wrapper").innerHTML = str;
			}
		        
		},error:function(request, status, error){
		}
	});
}

// 출결 처리 버튼
const atendBtn = function(){
	cjh.swConfirm("출결", "출결 처리를 진행하시겠습니까?", "question").then(function(res){
		if(res.isConfirmed){
			$.ajax({
				url:"/dclz/insertStdDclz",
				method:"post",
				dataType:"json",
				beforeSend:function(xhr){
					xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
				},
				success:function(res){
					if(res>0){
						cjh.swAlert("완료", "출결 처리가 완료되었습니다.");
					}else{
						cjh.swAlert("실패", "출결 처리에 실패했습니다.", "error");
					}
				}
			})
		}
	})
}

// 오늘의 시간표 목록
const todaySchedule = function(){
	$.ajax({
		type:"post",
		url:"/class/todaySchedule",
		contentType:"application/json;charset=UTF-8",
		data:JSON.stringify({
			"clasCode":clasCode
		}),
		dataType:"json",
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success:function(result){
			let str = "";
			
			if(result.length> 0){
				result.forEach(function(skedVO, index){
					str +=`
						<tr>
							<td style="padding: 10px 7px;">\${skedVO.period}교시</td>
							<td style="padding: 10px 7px;">\${skedVO.cmmnSbject}</td>
						</tr>`;
				})
				document.querySelector("#skedListTb tbody").innerHTML = str;					
			}else{
				str=`<div class='noList' style='height: 247px;'>
						<p>오늘 시간표가 없습니다.</p>
					</div>`;	
				document.querySelector("#skedListTb").innerHTML = str;					
			}
			
		}
	})
}

// 학생 목록 버튼
const stdListBtn = function(){
	$("#stdListModal").modal('show');
}

// 스와이프
const nextSwipe = function(){
	// Now you can use all slider methods like
	swiper.slideNext();
}

//스와이프 초기화
const initSwiper = function(){
	var swiper = new Swiper('.swiper', {
	  slidesPerView : 'auto', 			// 한 슬라이드에 보여줄 갯수
	  spaceBetween : 6, 				// 슬라이드 사이 여백
	  loop : false, 				// 슬라이드 반복 여부
	  loopAdditionalSlides : 1, 			// 슬라이드 반복 시 마지막 슬라이드에서 다음 슬라이드가 보여지지 않는 현상 수정
	  pagination : false, 				// pager 여부
	  autoplay : {  				// 자동 슬라이드 설정 , 비 활성화 시 false
	    delay : 3000,   				// 시간 설정
	    disableOnInteraction : false,  		// false로 설정하면 스와이프 후 자동 재생이 비활성화 되지 않음
	  },
	  navigation: {   				// 버튼 사용자 지정
	  	nextEl: '.swiper-button-next',
	  	prevEl: '.swiper-button-prev',
	  },
	});
}

//화상수업
const virtualClass = function(){
	window.open("https://code-gun.github.io/", "_blank");
}

window.onload = function() {
	// 출력 데이터 get and set
	setSchoolBanner(); 
	classInfoModalInit();
	getStdList();
	getDoingExam();
	getTaskList();
	getNtcnList();
	getRecentAtend();
	getClasImg();
	todaySchedule();
	
	// 스와이퍼 초기화
	initSwiper();
	
	// 학생은 출석버튼 on
	<sec:authorize access ="hasAnyRole('A01002', 'A01003')">
		document.querySelector("#onTheAtend").style.height = "88%";
	</sec:authorize>
	<sec:authorize access ="hasRole('A01001')">
		document.querySelector("#onTheAtend").style.height = "73%";
	</sec:authorize>
	
	var mberNm = "${hrtchrVO.memberVO.mberNm}";
	var moblphonNo = "${hrtchrVO.memberVO.moblphonNo}";
	var mberEmail = "${hrtchrVO.memberVO.mberEmail}";
	var clasCode = '${clasCode}';
	
	//선생님과 채팅하기
	var teacherChatBtn = '${USER_INFO.vwMemberAuthVOList[0].cmmnDetailCode eq 'ROLE_A01003' }';
	var familyChatBtn = '${USER_INFO.vwMemberAuthVOList[0].cmmnDetailCode eq 'ROLE_A01002' || USER_INFO.vwMemberAuthVOList[1].cmmnDetailCode eq 'ROLE_A01002' }';

	if(teacherChatBtn === "true"){
		document.querySelector('#teacherChatBtn').addEventListener('click', function () {
			let myId = '${USER_INFO.mberId}';
			let teacherId = '${hrtchrVO.mberId}'
			let schulCode = '${hrtchrVO.clasVO.schulCode}';
			let data = {
				"crtrId":teacherId,
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
			         		openChatPop("/chat/chtt?chttRoomCode="+result);
			         	}
					//result가 없으면 내가 초대 받은 방이 있는지확인 
					else{
						let data = {
							"crtrId":myId,
							"prtcpntId":teacherId	 
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
					                      		openChatPop("/chat/chtt?chttRoomCode="+result);
					                      	}
								//result가 0이면 채팅방 생성
								else{
					                     		let data = {
					                       			"type":"room",
					                       			"schulCode":"",
					                       			"clasCode":clasCode,
					                       			"crtrId":teacherId,
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
														socket.send("room,"+teacherId+","+myId+","+result);
														openChatPop("/chat/chtt?chttRoomCode="+result);
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
	}
	
	if(familyChatBtn === "true"){
		//학부모와 채팅하기
		document.querySelector('#familyChatBtn').addEventListener('click', function () {
			openChatPop('/chat/clasFam?clasCode='+clasCode);
		});
	}
}
</script>

<form id ="dclzForm" action = "/dclz/insertStdDclz" method ="post"></form>

<div id = "classMain" class ="main-page">
	<div class = "hor-div" style ="align-items: center;">
		<div class="box header-box" style="display: flex; align-items: center; justify-content: center; padding-top: 0px; padding-bottom: 0px; background: #78b0ff;">
			<h1 id = "schoolInfoBanner" style ="margin:0px; margin-top: 22px; margin-bottom: 22px; color: #fff;" onclick ="classroomInfoBtn()"></h1>
			<a class ="d-btn-gray" onclick = "virtualClass()" style ="margin:10px; width : auto;">수업입장</a>
		</div>
	</div>
	
	<div class ="hor-div" style ="height:415px;">
		<div class="box" style ="width:20%; height:100%;">
			<div class="menuTitle">
				<h3>담임 선생님</h3>
			</div>
			<hr>
			<!-- 프로필 없으면 기본 이미지 표시 -->
			<div>
				<div class="profile-img" style="text-align: center;">
					<c:choose>
						<c:when test="${hrtchrVO.memberVO.mberImage != null}">
					        	<img id="profileImg" src="/upload/profile/${hrtchrVO.memberVO.mberImage}" alt="">
						</c:when>
						<c:otherwise>
					        	<img id="profileImg" src="/resources/images/member/profile/user_l.png" alt="">
						</c:otherwise>
					</c:choose>
				</div>
				<div class="single-product-text" style="padding: 15px;">
				    <h4><a class="cards-hd-dn" href="#">${hrtchrVO.memberVO.mberNm}</a></h4>
					<p style = "margin-bottom: 2px" class="ctn-cards">${hrtchrVO.clasVO.schulNm} ${hrtchrVO.clasVO.clasNm}</p>
					<p style = "margin-bottom: 2px; color:#afafaf;">☎ ${hrtchrVO.memberVO.moblphonNo}</p>
					<p style = "margin-bottom: 2px; color:#afafaf;">✉ ${hrtchrVO.memberVO.mberEmail}</p>
					
					<c:if test="${USER_INFO.vwMemberAuthVOList[0].cmmnDetailCode eq 'ROLE_A01003' }">
						<button type="button" class="d-btn-blue" style ="height: 45px; margin-top: 9px;" id="teacherChatBtn">선생님과채팅</button>
					</c:if>
					<c:if test="${USER_INFO.vwMemberAuthVOList[0].cmmnDetailCode eq 'ROLE_A01002' || USER_INFO.vwMemberAuthVOList[1].cmmnDetailCode eq 'ROLE_A01002' }">
						<button type="button" class="d-btn-blue" style ="height: 45px; margin-top: 9px;" id="familyChatBtn">학부모와채팅</button>
					</c:if>
				</div>
			</div>
		</div>
		
		<div class = "box" style ="width:60%; height:100%; position: relative;">
			<div class="menuTitle">
				<h3 style ="height : 10%; margin-bottom: 0px; margin-left: 10px;">진행중인 일정</h3>
			</div>
			<div id ="onTheAtend" style ="display :flex; height:75%;">
				<!-- 과제 -->
				<div class="contentBox" style ="width:50%; height:100%; margin-right: 5px;">
					<div style ="display: flex; justify-content: space-between;">
						<span style ="font-size: 1.1rem; font-weight: bold">과제</span>
						<a class="shortcut" href="/task/taskList?clasCode=${CLASS_INFO.clasCode}" id="goToTaskList">
							<img class="shortcutIcon" src="/resources/images/classRoom/shortcut.png" alt="">바로 가기
						</a>
					</div>
					<div class="product-status-wrap drp-lst con"
						style="padding: 0px; background-color: transparent; ">
						<table id="taskListTb">
							<thead>
								<tr>
									<th>과제 제목</th>
									<th>종료 일시</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td colspan="100%" style="text-align: center;">등록된 과제가 없습니다..</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
				<!-- 단원 평가 -->
				<div class="contentBox" style ="display:inline-block; width:50%; height:100%; margin-left: 5px;">
					<div style ="display: flex; justify-content: space-between;">
						<span style ="font-size: 1.1rem; font-weight: bold">단원평가</span>
						<a class="shortcut" href="/unitTest/list" id="goToTaskList">
							<img class="shortcutIcon" src="/resources/images/classRoom/shortcut.png" alt="">바로 가기
						</a>
					</div>
					<div class="product-status-wrap drp-lst con" style="padding: 0px; background-color: transparent;">
						<table id="unitTestListTb">
							<thead>
								<tr>
									<th>제목</th>
									<th>종료 일시</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td colspan="100%" style="text-align: center;">등록된 과제가 없습니다..</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			<sec:authorize access ="hasRole('A01001')">
			<div style ="display:flex; height:12%;">
				<div style ="width: 50%; height : 100%; margin: 12px">
					<button onclick = "atendBtn()" class ="d-btn-blue std-btn"style ="height : 100%; width:100%">오늘 출석하기</button>
				</div>
				<div style ="display :flex; width: 50%; height : 100%; margin: 12px">
					<button class ="d-btn-blue std-btn" onclick = "location.href ='/gallery/gallery?clasCode=${clasCode}'" style = "width:50%; height : 100%; margin-right : 5px;">사진첩</button>
					<button class ="d-btn-blue std-btn" onclick = "location.href ='/diary/goToDiaryList'" style = "width:50%; height : 100%;">일기장</button>
				</div>
			</div>
			</sec:authorize>
		</div>
		<!-- 알림장 -->
		<div class = "box" style ="width:20%; height:100%;">
			<div class="menuTitle" style ="display: flex; justify-content: space-between;">
				<h3 style ="display:inline-block;">알림장</h3>
				<a class="shortcut" href="/ntcn/ntcnList?clasCode=${CLASS_INFO.clasCode}">
					<img class="shortcutIcon" src="/resources/images/classRoom/shortcut.png" alt="">바로 가기
				</a>
			</div>
			<div class="product-status-wrap drp-lst con" style="padding: 0px; background-color: #fafafa;">
				<div id="ntcnContent">
					<table id = "ntcnListTb">
						<thead>
							<tr>
								<th>제목</th>
								<th>작성 일시</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td colspan="100%" style="text-align: center;">등록된 알림장이 없습니다..</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div> <!-- 1floor-div -->
	
	<div class ="hor-div" style ="height:320px; margin-bottom: 40px">
		<!-- 시간표 -->
		<div class = "box" style ="width:20%; height:100%;">
			<div class="menuTitle" style ="display: flex; justify-content: space-between;">
				<h3 style ="display:inline-block;">오늘의 시간표</h3>
				<a class="shortcut" href="/class/schedule">
					<img class="shortcutIcon" src="/resources/images/classRoom/shortcut.png" alt="">바로 가기
				</a>
			</div>
			<div class="product-status-wrap drp-lst overflow-scroll" id="todaySchedule" style="padding: 10px; background-color: #fafafa;">
				<table id="skedListTb" style="display: inline-table;text-align-last: center;">
					<thead>
						<tr>
							<th>교시</th>
							<th>과목 </th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td colspan="100%" style="text-align: center;">오늘은 주말/공휴일 입니다.</td>
						</tr>
					</tbody>
				</table>

			</div>
		</div>
		
		<!-- 갤러리 -->
		<div class = "box" style ="width:60%; height:100%;">
			<div class="menuTitle" style ="display: flex; justify-content: space-between;">
				<h3 style ="display:inline-block;">갤러리</h3>
			</div>
			<div class ="inner-box2" style = "padding-left: 0px; padding-right: 0px; height: 90%;">
				<div class="swiper" style ="height: 100%;">
					<!-- Additional required wrapper -->
					<div class="swiper-wrapper">
						<!-- Slides -->
						<div class="swiper-slide">
							<img src="/resources/images/student/루피1.png"/>
							<img src="/resources/images/student/루피1.png"/>
							<img src="/resources/images/student/루피1.png"/>
						</div>
						<div class="swiper-slide">
							<img src="/resources/images/student/루피1.png"/>
							<img src="/resources/images/student/루피1.png"/>
							<img src="/resources/images/student/루피1.png"/>
						</div>
						<div class="swiper-slide">
							<img src="/resources/images/student/루피1.png"/>
							<img src="/resources/images/student/루피1.png"/>
							<img src="/resources/images/student/루피1.png"/>
						</div>
					</div>
					<!-- If we need pagination -->
					<div class="swiper-pagination"></div>
					<!-- If we need navigation buttons -->
					<div class="swiper-button-prev"></div>
					<div class="swiper-button-next"></div>
				</div>
			</div>
		</div>
		<div class = "box" style ="width:20%; height:100%;">
			<div class="menuTitle" style ="display: flex; justify-content: space-between;">
				<h3 style ="display:inline-block;">오늘 출석</h3>
				<a class="shortcut" href="/dclz/main">
					<img class="shortcutIcon" src="/resources/images/classRoom/shortcut.png" alt="">바로 가기
				</a>
			</div>
			<div class="product-status-wrap drp-lst con" style="padding: 0px; background-color: transparent;">
				<table id = "recentAtendTb">
					<thead>
						<tr>
							<th>시간</th>
							<th>학생명</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td colspan="100%" style="text-align: center;">등록된 출결이 없습니다..</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div> <!-- 2floor-div -->
</div> <!-- master-div -->

<!-- modal -->
<div id="stdListModal" class="modal modal-edu-general default-popup-PrimaryModal fade" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-close-area modal-close-df">
				<a class="close" data-dismiss="modal" href="#"><i class="fa fa-close"></i></a>
			</div>
			<div class="modal-body-class-stdnt">
				<h3 style ="margin-bottom: 0px">
					<span style="background: linear-gradient(to top, #7cb8ff 20%, transparent 20%);">우리반 친구들</span>
				</h3>
				<div class="product-status-wrap drp-lst overflow-scroll" style ="padding : 0px">
					<table id = "stdListTb">
						<thead>
					        <tr>
								<th>번호</th>
								<th>이름</th>
								<th>성별</th>
								<th>전화번호</th>
								<th>이메일</th>
					        </tr>
						</thead>
					    <tbody>
					        <tr>
								<td colspan="100%" style="text-align: center;">학생이 없습니다..</td>
							</tr>
				        </tbody>
				    </table>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- 반 정보 modal -->
<div id="classroomInfoModal" class="modal modal-edu-general default-popup-PrimaryModal fade" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-close-area modal-close-df">
				<a class="close" data-dismiss="modal" href="#"> <i class="fa fa-close"></i></a>
			</div>
			<div class="modal-body">
				<h3>반 정보</h3>
				<div class="product-status-wrap drp-lst overflow-scroll" style ="padding : 0px">
					<div class = "modal-body-line">
						<label for = "infoClasMm">반 명</label>
						<input type = "text" id = "infoClasNm" value =""  disabled/>
					</div>
					<div class = "modal-body-line">
						<label for = "infoClasYear">연도</label>
						<input type = "text" id = "infoClasYear" value ="" disabled/>
					</div>
					<div class = "modal-body-line">
						<label for = "infoCmmnGrade">학년</label>
						<input type = "text" id = "infoCmmnGrade" value ="" disabled />
					</div>
					<div class = "modal-body-line">
						<label for = "infoBeginTm">등교 시간</label>
						<input type = "text" id = "infoBeginTm" value ="" disabled/>
					</div>
					<div class = "modal-body-line">
						<label for = "infoEndTm">하교 시간</label>
						<input type = "text" id = "infoEndTm" value ="" disabled/>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<sec:authorize access ="hasRole('A01002')">
					<button onclick="modifyClassroom()" class = "mf-btn d-btn-blue">수정</button>
					<button onclick="deleteClassroom()" class = "mf-btn d-btn-red">삭제</button>
				</sec:authorize>
				<button data-dismiss="modal" class = "mf-btn d-btn-gray">닫기</button>
			</div>
		</div>
	</div>
</div>
