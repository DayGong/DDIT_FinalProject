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

#waitBtn {
	background-color: #ffd77a;
	color: #333;
}

#rejectBtn {
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
	width: 120px;
}

</style>
<script>
$(function() {
	const clasCode = `${clasCode}`;
	
	$("#cnsltCalendar").parents("div").css('min-height', '783px');
	
	// 선생님의 상담 목록을 불러오는 Ajax 시작 //
	$.ajax({
		url: "/cnslt/loadTeacherCnsltResveList",
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
					eventSources: 						// (구글 캘린더 API) 한국 기념일 ko.south_korea 추가
	                	[ { googleCalendarId : 'ko.south_korea#holiday@group.v.calendar.google.com'
	                    , className : 'koHolidays'
	                    , textColor: '#666'				// 글씨 색 설정
	                    , backgroundColor: '#eee'		// 배경 색 설정
	                    , borderColor: '#eee'} ],		// 테두리 색 설정
                    eventDidMount: function(info) { 	// 캘린더 이벤트가 마운트된 후 실행
						$(".fc-event-time").hide();
					}, // end eventDidMount
					// 캘린더에서 일정을 클릭했을 때 실행되는 함수
					eventClick: function(info) {
						console.log("info ==> ", info);
						let cnsltCode = info.event.id;										// 상담 코드
						let cnsltTitle = info.event.title;									// [예약 상태 명] 상담 대상 이름
						let cnsltTrgetIdNm = info.event.extendedProps.cnsltTrgetIdNm;		// 상담 대상 아이디
						let sttusCode = info.event.extendedProps.sttus;						// 예약 상태 코드
						let cnsltDiary = info.event.extendedProps.cnsltDiary;				// 상담 일지
						let cnsltRequstCn = info.event.extendedProps.cnsltRequstCn;			// 상담 요청 내용
						let cnsltTrgetId = info.event.extendedProps.cnsltTrgetId;			// 상담 대상 아이디
						let cmmnCnsltTime = info.event.extendedProps.cmmnCnsltTime;			// 상담 시간
						let cnsltCn = info.event.extendedProps.cnsltCn;						// 상담 완료 시 상담 내역
						let classNames = info.event.classNames;								// 한국 기념일이라는 클래스 네임을 갖고있는지 확인하기위해 사용
						let cnsltDe = dateFormat(info.event.start);							// 상담일
						let sttus = cnsltTitle.substr(1, (cnsltTitle.indexOf(']') - 1) );	// 예약 상태 명
						
						let cnsltVO = { "cnsltCode" : cnsltCode };
						sessionStorage.setItem("cnsltVO", JSON.stringify(cnsltVO));			// 상담 코드를 클라이언트측 세션에 저장
						
// 						if (classNames !== null || classNames !== "") {
// 				            event.preventDefault();	// 이벤트의 기본 동작(구글 캘린더로의 이동)을 막음
//                     		return;
// 						}

						$("#cnsltDetailModal").modal("show");								// 상담 내역 상세보기 모달창 열기
						
						$("#cnsltSttus").html(sttus);										// 상담 상태 값 넣기
						$("#modalCnsltTrgetId").html(cnsltTrgetId);							// 상담 대상 아이디 값 넣기
						$("#modalCnsltTrgetIdNm").html(cnsltTrgetIdNm.trim());				// 상담 대상 이름 값 넣기
						$("#modalCnsltDe").html(cnsltDe);									// 상담 일자 값 넣기
						$("#modalCnsltTime").html(cmmnCnsltTime);							// 상담 시간 값 넣기
						cnsltRequstCn = cnsltRequstCn.replace(/\n/gi, "<br>");
						$("#modalCnsltRequstCn").html(cnsltRequstCn);						// 상담 요청 내용 값 넣기
						
						// 예약 대기
						if (sttusCode == 'A09001') {
							let html = `<a class="" id="confirmBtn">
											<i class="fa fa-check edu-checked-pro" aria-hidden="true"></i> 예약 확인
										</a>
										<a class="" id="rejectBtn">
											<i class="fa fa-times edu-danger-error" aria-hidden="true"></i> 예약 거부
										</a>`;
							$("#btnSpace").html(html);
						}
						
						// 예약 확인
						if (sttusCode == 'A09002') {
							let html = `<a class="" id="waitBtn">
											<i class="fa fa-exclamation-triangle edu-warning-danger" aria-hidden="true"></i> 예약 대기
										</a>
										<a class="" id="finishBtn">
											<i class="fa fa-check edu-checked-pro" aria-hidden="true"></i> 상담 완료
										</a>
										<a class="" id="rejectBtn">
											<i class="fa fa-times edu-danger-error" aria-hidden="true"></i> 예약 거부
										</a>`;
							$("#btnSpace").html(html);
						}
						
						// 예약 거부
						if (sttusCode == 'A09003') { 
							let html = `<a class="" id="modCnsltDiary" data-cnslt-diary="\${cnsltDiary}">
											상담 안내 수정
										</a>`;
							$("#btnSpace").html(html); 
						}
						
						// 상담 완료
						if (sttusCode == 'A09004') {
							let html = "";
							
							// 상담 일지 작성 완료 여부에따라 버튼을 보여주는 부분
							if (cnsltCn == null || cnsltCn == '') {		
								html = `<a id="insertCnsltCn">
											상담 일지 쓰기
										</a>`;
							} else { 
								html = `<a id="viewCnsltCn">
											상담 일지 보기
										</a>`
							}
							$("#btnSpace").html(html);
						}
						
						if ( !(cnsltDiary == null || cnsltDiary == '') ) {
							cnsltDiary = cnsltDiary.replace(/\n/gi, "<br>");
							$("#cnsltDiary").show();
							$("#modalCnsltDiary").html(cnsltDiary);
						} else if ( !(cnsltCn == null || cnsltCn =='') ) {
							$("#cnsltDiary").show();
							$('#modalCnsltDiary').html("상담 일지가 작성된 상담입니다.");
						} else {
							$("#cnsltDiary").hide();
						}
						
                    } // end eventClick
                } // end cnsltCalendar
            ); // end calendar

            cnsltCalendar.render(); // 캘린더를 렌더링
            
        });	// end loadCnsltResveList ajax
        
        // 상담 일지 보기 버튼을 클릭하면 페이지가 이동하는 메서드
        $(document).on("click", "#viewCnsltCn", function() {
        	let cnsltVO = JSON.parse(sessionStorage.getItem("cnsltVO"));
        	let cnsltCode = cnsltVO.cnsltCode;
        	
        	$("#frmCnsltCn").attr("action", "/cnslt/viewCnsltCnDetail");
        	
        	$("input[name='cnsltCode']").val(cnsltCode);
        	$("#frmCnsltCn").submit();
        });
        
     	// 상담 일지 쓰기 버튼을 클릭하면 페이지가 이동하는 메서드
        $(document).on("click", "#insertCnsltCn", function() {
        	let cnsltVO = JSON.parse(sessionStorage.getItem("cnsltVO"));
        	let cnsltCode = cnsltVO.cnsltCode;
        	
        	$("#frmCnsltCn").attr("action", "/cnslt/insertCnsltCn");
        	
        	$("input[name='cnsltCode']").val(cnsltCode);
        	$("#frmCnsltCn").submit();
        });
        
     	// 예약 대기 버튼 클릭 시
        $(document).on("click", "#waitBtn", function() {
        	let cnsltVO = JSON.parse(sessionStorage.getItem("cnsltVO"));
        	let cnsltCode = cnsltVO.cnsltCode;
        	
        	let data = {
        		"cnsltCode" : cnsltCode,
        		"sttus" : "A09001",
        		"cnsltDiary" : ""
        	};
        	
        	$.ajax({
        		url: "/cnslt/changeSttus",
        		data: JSON.stringify(data),
        		contentType: "application/json; charset=utf-8",
        		type: "post",
        		beforeSend:function(xhr) {
        			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
        		},
        		success: function(result) {
        			resultAlert(result, "상담 예약 대기를", ' ');
        		}
        	});
        }); // end waitBtn click
        
        // 예약 확인 버튼 클릭 시
        $(document).on("click", "#confirmBtn", function() {
        	let cnsltVO = JSON.parse(sessionStorage.getItem("cnsltVO"));
        	let cnsltCode = cnsltVO.cnsltCode;
        	
        	let data = {
        		"cnsltCode" : cnsltCode,
        		"sttus" : "A09002",
        		"cnsltDiary" : ""
        	};

        	$.ajax({
        		url: "/cnslt/changeSttus",
        		data: JSON.stringify(data),
        		contentType: "application/json; charset=utf-8",
        		type: "post",
        		beforeSend:function(xhr) {
        			xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
        		},
        		success: function(result) {
        			resultAlert(result, "상담 예약 확인을", ' ');
        		}
        	});
        }); // end confirmBtn click
        
        // 상담 완료 버튼 클릭 시
        $(document).on("click", "#finishBtn", function() {
        	let cnsltVO = JSON.parse(sessionStorage.getItem("cnsltVO"));
        	let cnsltCode = cnsltVO.cnsltCode;
        	
        	let data = {
        		"cnsltCode" : cnsltCode,
        		"sttus" : "A09004",
        		"cnsltDiary" : "상담이 완료되었습니다."
        	};
        	
        	let formData = new FormData();
        	formData.append("cnsltCode", cnsltCode);
        	formData.append("cnsltCn", '');
        	formData.append("deleteAt", "1");

        	$.ajax({
        		url: "/cnslt/insertCnsltCnAct",
        		processData: false,
        		contentType: false,
        		data: formData,
        		dataType: "text",
        		type: "post",
        		beforeSend: function(xhr) {
    				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
    			},
    			success: function(result) {
		        	$.ajax({
		        		url: "/cnslt/changeSttus",
		        		data: JSON.stringify(data),
		        		contentType: "application/json; charset=utf-8",
		        		type: "post",
		        		beforeSend:function(xhr) {
		        			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		        		},
		        		success: function(result) {
		        			resultAlert(result, "상담 완료를", ' ');
		        		}
		        	});
    			}
        	});	
        }); // end finishBtn click
        
        // 상담 안내 내용 수정
        $(document).on("click", "#modCnsltDiary", function() {
        	modCnsltDiary();
        });
        
        // 예약 거부 버튼 클릭 시
        $(document).on("click", "#rejectBtn", function() {
        	Swal.fire({
        	      title: `정말로 예약을 거부하시겠습니까?`,
        	      text: ' ',
        	      icon: 'warning',
        	      showCancelButton: true,
        	      confirmButtonColor: '#ff0000',
        	      cancelButtonColor: '#e0e0e0',
        	      confirmButtonText: '삭제하기',
        	      cancelButtonText: '닫기',
        	      reverseButtons: false, // 버튼 순서 거꾸로
      		}).then((result) => {
      			if (result.isConfirmed) { modCnsltDiary(); }
      		}) // end then
        }); // end rejectBtn click
        
        // 상담 사유 작성
        function modCnsltDiary() {
        	(async () => {
			    const { value : cnsltDiary } = await Swal.fire({
			        title: '거절 사유를 입력해주세요.',
			        text: ' ',
			        input: 'textarea',
			    })

			    // 이후 처리되는 내용.
			    if (cnsltDiary) {
		        	let cnsltVO = JSON.parse(sessionStorage.getItem("cnsltVO"));
		        	let cnsltCode = cnsltVO.cnsltCode;
		        	
		        	let data = {
	            		"cnsltCode" : cnsltCode,
	            		"sttus" : "A09003",
	            		"cnsltDiary" : cnsltDiary
	            	};
		        	
		        	// 예약 거부 사유를 상담 일지 게시판에 저장하는 코드
		        	let formData = new FormData();
		        	formData.append("cnsltCode", cnsltCode);
		        	formData.append("cnsltCn", cnsltDiary);
		        	formData.append("deleteAt", "1");
		        	
		        	$.ajax({
		        		url: "/cnslt/insertCnsltCnAct",
		        		processData: false,
		        		contentType: false,
		        		data: formData,
		        		dataType: "text",
		        		type: "post",
		        		beforeSend: function(xhr) {
		    				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		    			},
		    			success: function(result) {
				        	$.ajax({
				        		url: "/cnslt/changeSttus",
				        		data: JSON.stringify(data),
				        		contentType: "application/json; charset=utf-8",
				        		type: "post",
				        		beforeSend:function(xhr) {
				        			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
				        		},
				        		success: function(result) {
				        			resultAlert(result, "상담 예약 거부를", ' ');
				        		}
				        	});
		    			}
		        	}); //end ajax
			    } // end if (cnsltDiary)
			})() // end async
        }; // end modCnsltDiary
        
});	// end ready
</script>
<!-- 상담 일지 form -->
<form id="frmCnsltCn" method="post">
	<input type="hidden" name="cnsltCode" />
	<sec:csrfInput/>
</form>

<!-- 본문 시작 -->

<!-- 로그인 한 경우 -->
<sec:authorize access="isAuthenticated()">
	<!-- 캘린더 보이는 곳 -->
	<div id="CalendarContainer">
		<div id="cnsltCalendar"></div>
	</div>
</sec:authorize>

<!-- 로그인 안 한 경우 -->
<sec:authorize access="isAnonymous()">
	<jsp:include page="../error/needLogin.jsp"/>
</sec:authorize>

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
							<td><span id="modalCnsltTrgetId"></span></td>
						</tr>
						<tr>
							<td class="tableM"><span>상담자 이름</span></td>
							<td><span id="modalCnsltTrgetIdNm"></span></td>
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
            	<span id="btnSpace"></span>
                <a data-dismiss="modal" href="#" id="closeBtn">닫기</a>
            </div>
        </div>
    </div>
</div>
<!-- 상담 내용 상세보기 모달 창 끝 -->