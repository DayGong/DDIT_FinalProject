<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script type="text/javascript" src="/resources/js/commonFunction.js"></script>

<!-- FullCalendar -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.css">
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.1/moment.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/locales-all.js"></script>
<!-- 구글 캘린더 API(공휴일) -->
<script type="text/javascript" src="/resources/js/gcal.js"></script>

<style>
/* fullCalendar 배경색 */
#cnsltCalendar {
	background-color: white;
}

/* 달력에 손가락 올리면 마우스 포인터가 손가락 모양되게 변경 */
.fc-daygrid-day:hover {
	cursor: pointer;
}

/* 전체 글씨 색 변경 */
.fc-day a {
	color: black;
}

/* 달력에 손가락 올리면 해당 부분이 노란색으로 변경 됨 */
.fc-day:hover {
  background-color: #ffd77a;
  color: #333;
  cursor: pointer;
}

/* 오늘 날짜 글씨 색과 bold 변경 */
.fc-day-today a {
  font-weight: bold;
  color: #FFFFFF !important;
}

/* 일요일 날짜: 빨간색 */
.fc-day-sun a {
    color: red;
}
  
/* 토요일 날짜: 파란색 */
.fc-day-sat a {
    color: blue;
}

/* 오늘 날짜 배경색 파란색으로 변경 */
:root {
	--fc-today-bg-color: rgba(0, 109, 240, 0.8);
}

/* 모달 css */
#signUpContainer{
	color:#333;
	padding: 30px 40px;
	background-color: rgba(255, 255, 255, 0.6);
	border-radius: 26px;
	backdrop-filter: blur(6px);
	box-shadow: 0px 35px 68px 0px rgba(145, 192, 255, 0.5), inset 0px -8px 16px 0px rgba(145, 192, 255, 0.6), inset 0px 11px 28px 0px rgb(255, 255, 255);
}

#signUpContainer h2{
	font-size:2rem;
}

#signUpContainer span{
	font-size:1.2rem;
}

#modBtn {
	background-color: #ffd77a;
	color: #333;
}

#delBtn {
	background-color: #333;
}

#closeBtn {
	background-color: gray;
}

.modal-title {
	margin-left: 50px;
}

.table tbody tr td {
	vertical-align: middle;
}

.modal-footer a {
	cursor: pointer;
}

.cnsltDetailTb, .cnsltDetailTb tr {
	text-align: left;
}

.cnsltDetailTb tr{
	display: block;
	margin-bottom: 20px;
}

.cnsltDetailTb .tableM {
	width: 130px;
}

</style>
<script>
$(function() {
	const clasCode = `${clasCode}`;
	
	$("#cnsltCalendar").parents("div").css('min-height', '783px');
	
	// 날짜 형식 변환 시작 //
    function getDate(time) {
        // 숫자가 아니면 숫자로 변환
        if (!isNaN(time)) { time = Number(time); }

        const date = new Date(time);
        const year = date.getFullYear();
        const month = String(date.getMonth() + 1).padStart(2, '0');
        const day = String(date.getDate()).padStart(2, '0');

        return`\${year}-\${month}-\${day}`; 
    } // 날짜 형식 변환 끝 //
	
    // 상담 예약 확인 confirm 시작 //
	function dayCheck(date) {
    	Swal.fire({
  	      title: `\${date}\n상담을 예약하시겠습니까?`,
  	      text: ' ',
  	      icon: 'warning',
  	      showCancelButton: true,
  	      confirmButtonColor: '#3085d6',
  	      cancelButtonColor: '#d33',
  	      confirmButtonText: '예약하기',
  	      cancelButtonText: '닫기',
  	      reverseButtons: false, // 버튼 순서 거꾸로
		}).then((result) => {
			if (result.isConfirmed) { location.href = "/cnslt/goToStdnprntResvePage?cnsltResveDate="+`\${date}`; }
		})
    }; // 상담 예약 확인 confirm 끝 //
	
	// 선생님의 상담 목록을 불러오는 Ajax 시작 //
	$.ajax({
		url: "/cnslt/loadCnsltResveList",
		data: JSON.stringify({ "clasCode" : clasCode }),
		contentType: "application/json; charset=utf-8", // JSON.stringify(data)일 때 사용
		type: "post",
		dataType: "json",
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		}
	}).done(function(data) {
		// FullCalendar를 생성하고 설정하는 부분
		var cnsltCalendarEl = document.querySelector('#cnsltCalendar'); // 캘린더의 DOM 요소를 가져옴
		var cnsltCalendar = new FullCalendar.Calendar(
			cnsltCalendarEl, {
				googleCalendarApiKey: 'AIzaSyBNa5QJDzfzJgxfdvfdlyoOgobKuhBCz4U', // (구글 캘린더 API) API Key
				height: '740px', // 캘린더의 높이 설정
				headerToolbar: { left: 'prev', center: 'title', right: 'next' }, // 캘린더의 헤더 표시 설정
				initialView: 'dayGridMonth', 	// 캘린더 초기 뷰 설정
				navLinks: true, 				// 날짜를 선택하면 Day 캘린더에 링크
				editable: false, 				// 캘린더 내 일정을 편집 가능하도록 설정
				selectable: false, 				// 달력 일자를 드래그하여 일정을 선택 가능하도록 설정
				droppable: false, 				// 드래그 가능한 요소를 캘린더에 떨어뜨릴 수 있도록 설정
				
				// 캘린더에 표시할 일정 데이터 설정
				events: data,					
					locale: 'ko', 						// 한국어 설정
					eventSources:						// (구글 캘린더 API) 한국 기념일 ko.south_korea 추가
	                	[ { googleCalendarId : 'ko.south_korea#holiday@group.v.calendar.google.com'
	                    , className : 'koHolidays'
	                    , textColor: '#666'				// 글씨 색 설정
	                    , backgroundColor: '#eee'		// 배경 색 설정
	                    , borderColor: '#eee'			// 테두리 색 설정
	                    } ],		
                    eventDidMount: function(info) {	// 캘린더 이벤트가 마운트된 후 실행
						$(".fc-event-time").hide();
					}, // end eventDidMount
					// 날짜 박스를 선택했을 때 실행되는 함수
                    dateClick: function(date) {
                    	date = date.dateStr;			// 날짜
                    	if ( getDayOfWeek(date) == false ) { 
                    		alertError('주말은 상담 예약이 불가합니다!', '다른 날짜를 선택해주세요.');
                    		return;
                    	}
                    	if ( prevToday(date) == false ) { 
                    		alertError('오늘 이전 날짜는\n상담 예약이 불가합니다!', '다른 날짜를 선택해주세요.');
                    		return;
                    	}
                    	dayCheck(date);
                    },	// end dateClick
                    // 날짜 클릭하면 발생하는 이벤트
                    navLinkDayClick: function(date, jsEvent) {
                    	console.log("jsEvent ==> ", jsEvent);
                    	date = getDate(date);		// 날짜
                    	if ( getDayOfWeek(date) == false ) { 
                    		alertError('주말은 상담 예약이 불가합니다!', '다른 날짜를 선택해주세요.');
                    		return;
                    	}
                    	if ( prevToday(date) == false ) { 
                    		alertError('오늘 이전 날짜는\n상담 예약이 불가합니다!', '다른 날짜를 선택해주세요.');
                    		return;
                    	}
                    	dayCheck(date);
                    }, // end navLinkDayClick
					// 캘린더에서 일정을 클릭했을 때 실행되는 함수
					eventClick: function(info) {
						let cnsltCode = info.event.id;									// 상담 코드
						let cnsltTrgetIdNm = info.event.title;							// 상담 대상 이름
						let sttusCode = info.event.extendedProps.sttus;					// 예약 상태 코드
						let sttus = cnsltTrgetIdNm.substr(1, (cnsltTrgetIdNm.indexOf(']') - 1) );	// 예약 상태 명
						let cnsltDe = getDate(info.event.start);						// 상담일
						let cnsltDiary = info.event.extendedProps.cnsltDiary;			// 상담 일지
						let cnsltRequstCn = info.event.extendedProps.cnsltRequstCn;		// 상담 요청 내용
						let cnsltTrgetId = info.event.extendedProps.cnsltTrgetId;		// 상담 대상 아이디
						let cmmnCnsltTime = info.event.extendedProps.cmmnCnsltTime;		// 상담 시간
						let classNames = info.event.classNames;							// 한국 기념일이라는 클래스 네임을 갖고있는지 확인하기위해 사용
						
						sessionStorage.setItem("cnsltCode",cnsltCode);					// 상담 코드를 클라이언트측 세션에 저장
						
// 						if (classNames !== null || classNames !== "") {
// 				            event.preventDefault();	// 이벤트의 기본 동작(구글 캘린더로의 이동)을 막음
//                     		return;
// 						}
						
						// 예약 확인 이후면 수정, 삭제 불가
						if (sttusCode == "A09001") {	
							$(".modDelBtn").css('display', 'inline-block');
						} else {
							$(".modDelBtn").css('display', 'none');
						}
						
						// 자신만 열람 가능
						if ( !(cnsltTrgetId == `${USER_INFO.mberId}`) ) {
							alertError("열람 권한이 없습니다.", "자신의 상담 예약만 열람 가능합니다.");
							return;
						}
						
						$("#cnsltDetailModal").modal("show");
						
						$("#cnsltSttus").html(sttus);
						$("#modalCnsltDe").html(cnsltDe);
						$("#modalCnsltTime").html(cmmnCnsltTime);
						
						cnsltRequstCn = cnsltRequstCn.replace(/\n/gi, "<br>");
						$("#modalCnsltRequstCn").html(cnsltRequstCn);
						
						if ( !(cnsltDiary == null || cnsltDiary == '') ) {
							cnsltDiary = cnsltDiary.replace(/\n/gi, "<br>");
							$("#modalCnsltDiary").html(cnsltDiary);
							$("#cnsltDiary").show();
						} else {
							$("#cnsltDiary").hide();
						}
						
                    } // end eventClick
                }
            ); // end calendar

            cnsltCalendar.render(); // 캘린더를 렌더링
            
        });	// end loadCnsltResveList ajax
        
        $("#modBtn").on("click", function(){
        	let cnsltCode = sessionStorage.getItem("cnsltCode");
        	
        	$("input[name='cnsltCode']").val(cnsltCode);
        	$("#frmCnslt").submit();
        }); // end modBtn
        
        $(document).on("click", "#delBtn", function(){
        	Swal.fire({
        	      title: `정말로 예약을 삭제하시겠습니까?`,
        	      text: ' ',
        	      icon: 'warning',
        	      showCancelButton: true,
        	      confirmButtonColor: '#ff0000',
        	      cancelButtonColor: '#e0e0e0',
        	      confirmButtonText: '삭제하기',
        	      cancelButtonText: '닫기',
        	      reverseButtons: false, // 버튼 순서 거꾸로
      		}).then((result) => {
      			if (result.isConfirmed) {
		        	let cnsltCode = sessionStorage.getItem("cnsltCode");
		        	
		        	$.ajax({
		        		url: "/cnslt/deleteCnsltResve",
		        		data: JSON.stringify({ "cnsltCode" : cnsltCode }),
		        		contentType: "application/json; charset=utf-8",
		        		type: "post",
		        		beforeSend:function(xhr){
		        			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		        		},
		        		success: function(ires) {
		        			resultAlert(ires, '상담 예약 삭제를', ' ');
		        		} // end success
		        	}); // end ajax
      			} // end if (result.isConfirmed)
      		}) // end then
        }); // end delBtn
});	// end ready
</script>
<!-- 로그인 한 경우 -->
<sec:authorize access="isAuthenticated()">
	<!-- 캘린더 보이는 곳 -->
	<div id="cnsltCalendar"></div>
</sec:authorize>
<!-- 로그인 안 한 경우 -->
<sec:authorize access="isAnonymous()">
	<jsp:include page="../error/needLogin.jsp"/>
</sec:authorize>

<!-- forwarding으로 데이터를 보내기위한 form -->
<form id="frmCnslt" method="post" action="/cnslt/modifyCnsltResve">
	<input type="hidden" name="cnsltCode" />
	<sec:csrfInput/>
</form>

<!-- 상담 내용 상세보기 모달 창 시작 -->
<div id="cnsltDetailModal" class="modal modal-edu-general default-popup-PrimaryModal fade" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header header-color-modal bg-color-1">
            	<table>
            		<tr>
            			<td class="tableT"><img src="/resources/images/consultation/cnsltImg.png" style="width: 50px;"></td>
            			<td><h2 id="cnsltSttus" class="modal-title"></h2></td>
            		</tr>
            	</table>
                <div class="modal-close-area modal-close-df">
                    <a class="close" data-dismiss="modal" href="#"><i class="fa fa-close"></i></a>
                </div>
            </div>
            <div class="modal-body">
				<div id="signUpContainer">
					<table class="cnsltDetailTb">
						<tr>
							<td class="tableM"><span>상담자 아이디</span></td>
							<td><span>${USER_INFO.mberId}</span></td>
						</tr>
						<tr>
							<td class="tableM"><span>상담자 이름</span></td>
							<td><span>${USER_INFO.mberNm}</span></td>
						</tr>
						<tr>
							<td class="tableM"><span>상담 일자</span></td>
							<td><span id="modalCnsltDe"></span></td>
						</tr>
						<tr>
							<td class="tableM"><span>상담 시간</span></td>
							<td><span id="modalCnsltTime"></span></td>
						</tr>
						<tr>
							<td class="tableM" style="vertical-align: top;"><span>상담 요청 내용</span></td>
							<td><span id="modalCnsltRequstCn"></span></td>
						</tr>
						<tr id="cnsltDiary">
							<td class="tableM" style="vertical-align: top;"><span>선생님 말씀</span></td>
							<td><span id="modalCnsltDiary"></span></td>
						</tr>
					</table>
				</div>
            </div>
            <div class="modal-footer">
				<a class="modDelBtn" id="modBtn">수정하기</a>
				<a class="modDelBtn" id="delBtn">삭제하기</a>
                <a data-dismiss="modal" href="#" id="closeBtn">닫기</a>
            </div>
        </div>
    </div>
</div>
<!-- 상담 내용 상세보기 모달 창 끝 -->