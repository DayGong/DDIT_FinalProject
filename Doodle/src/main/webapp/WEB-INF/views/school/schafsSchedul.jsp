<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.List"%>
<%@ page import="kr.or.ddit.vo.SchafsSchdulVO"%>
<!DOCTYPE html>
<html>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<!-- FullCalendar -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.css">
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.1/moment.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/locales-all.js"></script>
<!-- 구글 캘린더 API(공휴일) -->
<script type="text/javascript" src="/resources/js/gcal.js"></script>

<style>
.fc-col-header{
	background: #f5f5f5;
}

.dataSpan{
	font-weight: bold;
    color: #999;
}
/* 일정 구분 시작 */
.scheduleSe{
	margin-right: 20px;
}
.scheduleSe:last-child{
	margin-right: 0px;
}
.inputSchedule{
	margin-bottom: 20px;
}
/* 일정 구분 끝 */

/* fullCalendar 배경색 */
#cnsltCalendar {
	background-color: white;
}

/* 하루짜리 일정 배경색 바꾸기 */
.fc-event-future{
/* 	background-color: red; */

	
}
.fc-event-future:hover{
	background-color: #fff;
}

/* 달력에 손가락 올리면 마우스 포인터가 손가락 모양되게 변경 */
.fc-daygrid-day:hover {
/* 	cursor: pointer; */
}

/* 전체 글씨 색 변경 */
.fc-day a {
	color: #444;
}

.fc-sticky{
	font-weight: bold;
}

/* 공휴일 글씨 변경 */
.koHolidays .fc-event-title {
  font-weight: bold;
}

/* 달력 hover css */
.fc-day:hover {
	background-color: rgba(200, 225, 255, 0.2);
}

/* 오늘 날짜 글씨 색과 bold 변경 */
.fc-day-today a {
  font-weight: bold;
  color: #666 !important;
}

/* 오늘 날짜 배경색 파란색으로 변경 */
:root {
	--fc-today-bg-color: rgb(200 225 255);
}

/* 일요일 날짜: 빨간색 */
.fc-day-sun a {
    color: red;
}
  
/* 토요일 날짜: 파란색 */
.fc-day-sat a {
    color: blue;
}

/*title 옆에 점*/
.fc-daygrid-event-dot{
	color: red;
}

/* 모달 css 시작 */
.schedulBody h3{
	background: linear-gradient(to top, #7cb8ff 20%, transparent 20%);
    width: 160px;
}
.schedulTitle{
	display: flex;
	justify-content: center;
}

.scheduleContent{
	box-shadow: 35px 35px 68px 0px rgba(145, 192, 255, 0.5), inset -8px -8px 16px 0px rgba(145, 192, 255, 0.6), inset 0px 11px 28px 0px rgb(255, 255, 255);
	padding: 30px 70px 50px;
    border-radius: 45px;
}
/* 모달 css 끝 */

/* 버튼 커서 만들기 */
#insertBtn, #updateBtn, #deleteBtn{
	cursor: pointer;
}
#deleteBtn{
	background-color: #666;
}
#closeBtn{
	background-color: black;
}
#autoBtn{
	background: black;
}
</style>
<head>
<script>
// 전역 변수
var schulCode = "${SCHOOL_USER_INFO.schulCode}";
var scheduleSe = "";

// FullCalendar API
$(document).ready(function() {
    // 페이지가 로드될 때 실행
    $(function() {
        var request = $.ajax({
            url: "/school/scheduleList",
            method: "GET",
            data: {schulCode:schulCode},
            dataType: "json"
        });
        
        // 데이터를 가져오는 요청이 완료되었을 때 실행
        request.done(function(data) {
            console.log("data", data);
            
            // FullCalendar를 생성하고 설정하는 부분
            var calendarEl = document.getElementById('calendar'); // 캘린더의 DOM 요소를 가져옴
            calendar = new FullCalendar.Calendar(
                calendarEl, {
	            	googleCalendarApiKey: 'AIzaSyCfJJJRMweKP_Mca-rRJDBvpdLXANPHS14', // (구글 캘린더 API) API Key
                    height: '700px', 	// 캘린더의 높이 설정
                    headerToolbar: { 	// 캘린더의 헤더 표시 설정
                        left: 'prev',
                        center: 'title',
                        right: 'next'
                    },
                    initialView: 'dayGridMonth', 	// 캘린더 초기 뷰 설정
                    navLinks: true, 				// 날짜를 선택하면 Day 캘린더에 링크
                    editable: true, 				// 캘린더 내 일정을 편집 가능하도록 설정
                    selectable: true, 				// 달력 일자를 드래그하여 일정을 선택 가능하도록 설정
                    droppable: true, 				// 드래그 가능한 요소를 캘린더에 떨어뜨릴 수 있도록 설정
//                     events:	data,					// 캘린더에 표시할 일정 데이터 설정
                    locale: 'ko', 					// 한국어 설정
					eventSources : 					// (구글 캘린더 API) 한국 기념일 ko.south_korea 추가
	                	[ { googleCalendarId : 'ko.south_korea#holiday@group.v.calendar.google.com'
	                      , className : 'koHolidays'
	                      , textColor: '#666'			// 글씨 색 설정
	                      , backgroundColor: '#ccc'		// 배경 색 설정
	                      , borderColor: '#ccc'} ],		// 테두리 색 설정
                    eventDidMount: function(info) { 	// 캘린더 이벤트가 마운트된 후 실행
                        $(".fc-event-time").hide();
                    }, 
                    /* 학사 일정 등록 */ 
                    // 캘린더에서 일정을 선택했을 때 실행되는 함수
                    select: function(arg) {
                    	/* 교직원 권한 시작 */
                    	if("${USER_INFO.vwMemberAuthVOList[0].cmmnDetailCode}" == "ROLE_A14003"){
	                    	// 등록 모달 띄우기
	                        $("#scheduleInsertModal").modal('show');
                    	}
                    	
                    	// 일정 명 입력란 초기화
                    	$("#schdulNm").val("");

                        var schdulNm = $("#schdulNm").val();
                		var schdulBegin = dateFormat(arg.start);
                		var schdulEnd = dateFormat(arg.end - 1);
                		var schafsSchdulSe = $("#schafsSchdulSe").val();
                		
                		$("#schdulBegin").val(schdulBegin);
                		$("#schdulEnd").val(schdulEnd);
                		/* 교직원 권한 끝 */
                    },

                    /* 학사 일정 수정 */
                    // 캘린더에서 일정을 클릭했을 때 실행되는 함수
                    eventClick: function(info) {
                    	console.log("info", info);
                    	var scheduleCd = info.event.extendedProps.scheduleCd;
                    	var scheduleSe = info.event.extendedProps.scheduleSe;
                        
                    	/* 교직원 권한 시작 */
                    	// 수정 모달 띄우기
                    	if("${USER_INFO.vwMemberAuthVOList[0].cmmnDetailCode}" == "ROLE_A14003"){
                        	$("#scheduleUpdateModal").modal('show');
                    	}
                    	
                        $("#schdulCode").val(scheduleCd);
						$("#schdulNm-u").val(info.event._def.title);
						$("#schdulBegin-u").val(dateFormat(info.event.start));
                		$("#schdulEnd-u").val(dateFormat(info.event.end));
                		
                		$("input[name='scheduleRadio-u'][value='"+scheduleSe+"']").prop('checked', true);
                		/* 교직원 권한 끝 */
                    }
                });
            
            /* 학사 일정 리스트 출력 */
            $.each(data, function(idx, scheduleList) {
            	console.log("scheduleList", scheduleList);
				
            	var backgroundColor = "";
            	var boderColor = "";
            	
            	if(scheduleList.scheduleSe == "학생"){
	            	backgroundColor = '#F7C8E0';	// 분홍
            		boderColor = '#F7C8E0';
            	}else if(scheduleList.scheduleSe == "학부모"){
            		backgroundColor = '#F6F7C1';	// 노랑
            		boderColor = '#F6F7C1';
            	}else if(scheduleList.scheduleSe == "선생님"){
            		backgroundColor = '#DFFFD8';	// 연두
            		boderColor = '#DFFFD8';
            	}else{ // 공통
            		backgroundColor = '#95BDFF';	// 파랑
            		boderColor = '#95BDFF';
            	}
            	
                calendar.addEvent({
                    title: scheduleList.scheduleNm,
                    start: scheduleList.scheduleBgnde,  // 시작일
                    end: scheduleList.scheduleEndde,    // 종료일
                    backgroundColor: backgroundColor,	// 배경 색
                    borderColor: boderColor,			// 테두리 색
                    textColor: "#444",					// 글씨 색
                    extendedProps: {
                        scheduleCd: scheduleList.scheduleCd, // scheduleCd 추가
                        scheduleSe: scheduleList.scheduleSe	 // scheduleSe 추가
                    }
                });
            });
            
            calendar.render(); // 캘린더를 렌더링
        });
    });
    
    /* 학사 일정 등록 */
    $("#insertBtn").on("click", function(){
		var schdulNm = $("#schdulNm").val();
		var schdulCn = $("#schdulCn").val();
		var schdulBegin = $("#schdulBegin").val();
		
		var schdulEnd = new Date($("#schdulEnd").val());
		schdulEnd.setHours(23);
		schdulEnd.setMinutes(59);
		
		var schedulSe = $("input[name=scheduleRadio]:checked").val();
		
// 		console.log("schdulNm:" + schdulNm);
// 		console.log("schdulCn:" + schdulCn);
// 		console.log("schdulBegin:" + schdulBegin);
// 		console.log("schdulEnd:" + schdulEnd);
// 		console.log("schedulSe:" + schedulSe);
		
		if(schdulNm == ""){
			Swal.fire('등록 실패!', '일정 명을 입력하지 않았습니다.', 'error');
			return;
		}
		
		var data = {
			"schafsSchdulNm":schdulNm,
			"schafsSchdulCn":schdulCn,
			"schafsSchdulBgnde":schdulBegin,
			"schafsSchdulEndde":schdulEnd,
			"schulCode":schulCode,
			"schafsSchdulSe":schedulSe
		};

		$.ajax({
			url:"/school/scheduleInsert",
			contentType:"application/json;charset=utf-8",
			type: "post",
			data: JSON.stringify(data),
			dataType: "json",
			beforeSend:function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			},
			success:function(res){
				Swal.fire({
	               title: '일정 등록이 완료되었습니다.',
	               text: '',
	               icon: 'success',
	               confirmButtonText: '확인',
	            }).then(result => {
					if (result.isConfirmed) {
						location.reload();
					}
	            });
			}
		})
    });
    
    /* 학사 일정 수정 */
    $("#updateBtn").on("click", function(){
		var schdulCode = $("#schdulCode").val();
		var schdulNm = $("#schdulNm-u").val();
		var schdulCn = $("#schdulCn-u").val();
		var schdulBegin = $("#schdulBegin-u").val();
		
		var schdulEnd = new Date($("#schdulEnd-u").val());
		schdulEnd.setHours(23);
		schdulEnd.setMinutes(59);
		
		var schedulSe = $("input[name=scheduleRadio-u]:checked").val();
		
		// 일정 명 입력하지 않을 시 처리
		if(schdulNm == ""){
			Swal.fire('수정 실패!', '일정 명을 입력하지 않았습니다.', 'error');
			return;
		}
		
        // 종료일이 시작일보다 이전일 때의 처리
        if(schdulBegin > schdulEnd){
        	Swal.fire('일정 등록 실패!', '종료일은 시작일보다 이전의 날짜일 수 없습니다.', 'error');
        	return;
        }
		
		var data = {
			"schafsSchdulCode":schdulCode,
			"schafsSchdulNm":schdulNm,
			"schafsSchdulCn":schdulCn,
			"schafsSchdulBgnde":schdulBegin,
			"schafsSchdulEndde":schdulEnd,
			"schulCode":schulCode,
			"schafsSchdulSe":schedulSe
		};

		$.ajax({
			url:"/school/scheduleUpdate",
			contentType:"application/json;charset=utf-8",
			type: "post",
			data: JSON.stringify(data),
			dataType: "json",
			beforeSend:function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			},
			success:function(res){
				Swal.fire({
	               title: '일정 수정이 완료되었습니다.',
	               text: '',
	               icon: 'success',
	               confirmButtonText: '확인',
	            }).then(result => {
					if (result.isConfirmed) {
						location.reload();
					}
	            });
			}
		})
    });
    
    /* 학사 일정 삭제 */
    $("#deleteBtn").on("click", function(){
    	var schdulCode = $("#schdulCode").val();
    	
    	Swal.fire({
			title: '일정을 삭제하시겠습니까?',
			text: '',
			icon: 'warning',
			showCancelButton: true,       	// cancel 버튼 보이기
			confirmButtonText: '삭제',       // confirm 버튼 텍스트 지정
			cancelButtonText: '취소',        // cancel 버튼 텍스트 지정
		}).then(result => {
			if(result.isConfirmed){
				$.ajax({
		            url: "/school/scheduleDelete",
		            type: "post",
		            data: {schdulCode:schdulCode},
		            dataType: "text",
		            beforeSend:function(xhr){
	                    xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
	            	},
					success: function(res){
						location.reload();
	            	}
	            });
	        }
	    });
    });
    
    /* 학사 일정 수정 시 시작일/종료일 값 넣는 이벤트 시작*/
    $("#inputSchdulBegin").on("input", function(){
		var schdulBegin = $("#inputSchdulBegin").val();
		$("#schdulBegin-u").val(schdulBegin);
    });
    
    $("#inputSchdulEnd").on("input", function(){
    	var schdulEnd = $("#inputSchdulEnd").val();
		$("#schdulEnd-u").val(schdulEnd);
    });
    /* 학사 일정 수정 시 시작일/종료일 값 넣는 이벤트 끝*/
    
	// 자동 완성 버튼
	$("#autoBtn").on("click", function(){
		document.querySelector("#schdulNm").value = "현장체험학습";
	});
});
</script>
</head>

<!-- fullCalendar가 들어갈 Div -->
<div id="calendar"></div>

<!-- 학사 일정 등록 모달 -->
<div id="scheduleInsertModal" class="modal modal-edu-general default-popup-PrimaryModal fade"
	role="dialog" style="align-content: center;">
	<div class="modal-dialog" style="width: 480px;">
		<div class="modal-content">
			<div class="modal-close-area modal-close-df">
				<a class="close" data-dismiss="modal" href="#"><i class="fa fa-close"></i></a>
			</div>
			<div class="modal-body schedulBody" style="padding: 40px 25px 25px;">
				<div class="schedulTitle">
					<h3>학사 일정 등록</h3>
				</div>
				<br>
				<div class="scheduleContainer">
					<ul class="scheduleContent">
						<li>
							<span class="dataSpan">일정 명</span>
							<input name="schdulNm" id="schdulNm" type="text" class="form-control inputSchedule">
						</li>
						<li>
							<span class="dataSpan">일정 시작일</span>
							<input name="schdulBegin" id="schdulBegin" type="text" class="form-control inputSchedule" readonly>
						</li>
						<li>
							<span class="dataSpan">일정 종료일</span>
							<input name="schdulEnd" id="schdulEnd" type="text" class="form-control inputSchedule" readonly>
						</li>
						<li><span class="dataSpan">일정 구분</span>
						<div style="height: 40px; align-content: center; border: 1px solid #ddd;">
							<span class="scheduleSe">
								<input name="scheduleRadio" type="radio" value="학생" checked>학생
							</span>
							<span class="scheduleSe">
								<input name="scheduleRadio" type="radio" value="학부모">학부모
							</span>
							<span class="scheduleSe">
								<input name="scheduleRadio" type="radio" value="선생님">선생님
							</span>
							<span class="scheduleSe">
								<input name="scheduleRadio" type="radio" value="공통">공통
							</span>
						</div>
					</ul>
				</div>
			</div>
			<div class="modal-footer" style="display: flex; justify-content: center; margin-bottom: 25px;">
				<a class="modDelBtn" id="insertBtn">등록</a>
				<a data-dismiss="modal" href="#" id="closeBtn" style="margin-left: 10px; background: #666;">닫기</a>
				<a class="modDelBtn" id="autoBtn" style="margin-left: 10px; padding: 10px 10px;">자동 완성</a>
			</div>
		</div>
	</div>
</div>

<!-- 학사 일정 수정 모달 -->
<div id="scheduleUpdateModal" class="modal modal-edu-general default-popup-PrimaryModal fade"
	role="dialog" style="align-content: center;">
	<div class="modal-dialog" style="width: 480px;">
		<div class="modal-content" >
			<div class="modal-close-area modal-close-df">
				<a class="close" data-dismiss="modal" href="#"><i class="fa fa-close"></i></a>
			</div>
			<div class="modal-body schedulBody" style="padding: 40px 25px 25px;">
				<div class="schedulTitle">
					<h3>학사 일정 수정</h3>
				</div>
				<br>
				<div class="scheduleContainer">
					<ul class="scheduleContent">
						<li>
							<span class="dataSpan">일정 명</span>
							<input name="schdulNm" id="schdulNm-u" type="text" class="form-control inputSchedule">
							<input id="schdulCode" type="hidden" class="form-control inputSchedule">
						</li>
						<span class="dataSpan">일정 시작일</span>
						<li style="display: flex;">
							<input name="schdulBegin" id="schdulBegin-u" type="text" class="form-control inputSchedule" readonly>
							<input id="inputSchdulBegin" type="date" class="form-control inputSchedule" style="width: 43px;">
						</li>
						<span class="dataSpan">일정 종료일</span>
						<li style="display: flex;">
							<input name="schdulEnd" id="schdulEnd-u" type="text" class="form-control inputSchedule" readonly>
							<input id="inputSchdulEnd" type="date" class="form-control inputSchedule" style="width: 43px;">
						</li>
						<li><span class="dataSpan">일정 구분</span>
						<div style="height: 40px; align-content: center; border: 1px solid #ddd;">
							<span class="scheduleSe">
								<input name="scheduleRadio-u" type="radio" value="학생" checked>학생
							</span>
							<span class="scheduleSe">
								<input name="scheduleRadio-u" type="radio" value="학부모">학부모
							</span>
							<span class="scheduleSe">
								<input name="scheduleRadio-u" type="radio" value="선생님">선생님
							</span>
							<span class="scheduleSe">
								<input name="scheduleRadio-u" type="radio" value="공통">공통
							</span>
						</div>
					</ul>
				</div>
			</div>
			<div class="modal-footer" style="display: flex; justify-content: center; margin-bottom: 25px;">
				<a class="modDelBtn" id="updateBtn">수정</a>
				<a class="modDelBtn" id="deleteBtn" style="margin-left: 10px;">삭제</a>
				<a data-dismiss="modal" href="#" id="closeBtn" style="margin-left: 10px;">닫기</a>
			</div>
		</div>
	</div>
</div>