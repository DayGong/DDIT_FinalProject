<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css">
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script type="text/javascript" src="/resources/js/commonFunction.js"></script>
<style>
/* 달력 css 시작 */
.dateHead div {
	background: #006DF0;
	color: #fff;
	text-align: center;
	border-radius: 5px;
}

.grid {
	display: grid;
	grid-template-columns: repeat(7, 1fr);
	grid-gap: 5px;
}

.grid div {
	padding: .6rem;
	font-size: .9rem;
	cursor: pointer;
}

.dateBoard div {
	color: #222;
	font-weight: bold;
	min-height: 4rem;
	padding: .6rem .6rem;
	border-radius: 5px;
	border: 1px solid #eee;
	text-align: center;
}

.dateBoard div:hover {
	background-color: #ffd77a;
	color: #333 !important;
}

.noColor {
	background: #eee;
	pointer-events : none;
}

.calendarHeader {
	display: flex;
	justify-content: space-between;
	padding: 1rem 2rem;
}

.calendarHeader h2 {
	margin: 4px 0 10px;
}

.calendarBtn {
	display: block;
	width: 40px;
	height: 40px;
	cursor: pointer;
}

* {
	margin: 0;
	padding: 0;
	list-style: none;
	box-sizing: border-box;  
	font-family: Pretendard;
}

.rap {
	max-width: 820px;
	padding: 0 1.4rem;
	margin-top: 1.4rem;
	margin-bottom: 1.4rem;
	background-color: white;
}

.dateHead {
	margin: .4rem 0;
}

.onSelected {
	background-color : rgba(0, 109, 240, 0.8);
	color : #FFFFFF !important;
}

.timepicker_selector .time_selector {
    display: block;
    padding: 5px 10px;
}
/* 달력 css 끝 */

/* 선택된 시간 */
.select_time li.complete {
    background: #eaeaea;
    cursor: default;
}

/* 시간 목록 출력 */
.select_time li {
    border: 1px solid #eaeaea;
    box-sizing: border-box;
    margin-top: 3px;
    display: inline-block;
    width: calc(50% - 2px);
    transition: all 0.5s;
}

.select-time-li:hover {
	background: #eaeaea;
	cursor: pointer;
}

#timepicker {
	margin-top: 1.4rem;
	margin-bottom: 0.8rem;
}

textarea {
	resize: none;
}

.cnsltDiarySpan {
	color: lightgray;
}

.autoBtn {
	background: #333;
	height: 40px;
	border: none;
	padding: 10px 15px;
	border-radius: 10px;
	font-family: 'Pretendard' !important;
	font-weight: 600;
	color: #fff;
}
</style>
<script>
window.onload = function() {
	$(document).on("click", "#diaryAutoBtn", function() {
		let txt = `지은이가 집에서 열심히 공부하는데도 성적이 너무 낮아서 고민입니다.\n노력에비해 결과가 나오지않으니 우리 지은이도 너무 힘들어해요.`;
		let cnsltDe = `2024-04-17`;
		let cmmnCnsltTime = `16:00`;
		$("#cnsltRequstCn").html(txt);
		$("#cnsltDe").val(cnsltDe);
		$("#cmmnCnsltTime").val(cmmnCnsltTime);
	});
	
	const clasCode = `${clasCode}`;

	let selectedDate = `${param.cnsltResveDate}`;	// 데이터 파라미터 값
	if (selectedDate == null || selectedDate == '') { selectedDate = getDate(`${cnsltResveDate}`); }
    
	const modFlag = `${cnsltResveFlag}`;	// 수정 모드인지 확인
	if ( modFlag == 'mod' ){
		$("input[name='cnsltDe']").val(selectedDate);
		$("input[name='cmmnCnsltTime']").val(`${modCnsltVO.cmmnCnsltTime}`);
		$("textarea[name='cnsltRequstCn']").val(`${modCnsltVO.cnsltRequstCn}`);
		
		$("#btnSpan").html(`<button type='button' id='modifyBtn' class='btn btn-custon-rounded-two btn-warning'>
								<i class='fa fa-check edu-checked-pro' aria-hidden='true'></i>상담 수정하기
							</button>`);
	} else {
		$("#btnSpan").html(`<button type='button' id='submitBtn' class='btn btn-custon-rounded-two btn-primary'>
								<i class='fa fa-check edu-checked-pro' aria-hidden='true'></i>상담 예약하기
							</button>`);
	}
	
	// 날짜 형식 변환
    	function getDate(time) {
		// 숫자가 아니면 숫자로 변환
		if (!isNaN(time)) { time = Number(time); }
		
		const date = new Date(time.replace("KST", "GMT+0900"));
		const year = date.getFullYear();
		const month = String(date.getMonth() + 1).padStart(2, '0');
		const day = String(date.getDate()).padStart(2, '0');
		
		return`\${year}-\${month}-\${day}`; 
	} // end getDate
    
	// 달력 출력 시작 //
	const makeCalendar = (date) => {
		const currentYear = new Date(date).getFullYear();
		const currentMonth = new Date(date).getMonth() + 1;

		const firstDay = new Date(date.setDate(1)).getDay();
		const lastDay = new Date(currentYear, currentMonth, 0).getDate();

		const limitDay = firstDay + lastDay;
		const nextDay = Math.ceil(limitDay / 7) * 7;

		let html = '';
		let today = '';	// 오늘 날짜를 저장하는 변수

		for (let i = 0; i < firstDay; i++) { html += `<div class="noColor"></div>`; }

		for (let i = 1; i <= lastDay; i++) {
			const dateCheck = currentYear + "-" + String(currentMonth).padStart(2, '0') + "-" + String(i).padStart(2, '0');
			if (dateCheck == selectedDate) { today = i; } // 오늘 날짜 확인
			
			// 오늘 이전 날짜와 주말은 선택되지 않게 설정
			if ( getDayOfWeek(dateCheck) == false || prevToday(dateCheck) == false ) { 
				html += `<div class="noColor" value="\${dateCheck}" id="day\${i}">\${i}</div>`;
			} else {	// 예약 가능한 날짜
				let endResve= "";
			
				let cnsltVO = {
					"cnsltDe" : dateCheck,
					"clasCode" : clasCode
				};
	
				// 예약 개수를 불러오는 ajax
				$.ajax({
					url: "/cnslt/loadResveCnt",
					async: false, // 동기 처리 = ajax 실행 후 아래 코드가 실행 됨
					data: JSON.stringify(cnsltVO),
					contentType: "application/json; charset=utf-8",
					type: "post",
					dataType: "text",
					beforeSend:function(xhr){
						xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
					},
					success: function(result) {
						if ( result === "TRUE") { endResve = "<br><예약 마감>"; }
					}
				});	// 예약 날짜 개수를 불러오는 ajax 끝 //
				
				html += `<div class="getDate" value="\${dateCheck}" id="day\${i}">\${i}\${endResve}</div>`;
			}
		}

		for (let i = limitDay; i < nextDay; i++) { html += `<div class="noColor"></div>`; }
		
		document.querySelector(`.dateBoard`).innerHTML = html;
		document.querySelector(`.dateTitle`).innerText = `\${currentYear}년 \${currentMonth}월`;

		// 오늘 날짜의 class를 onSelected로 변경
		document.getElementById(`day\${today}`).setAttribute("class", "getDate onSelected");
		
	}

	const date = new Date(selectedDate);
	makeCalendar(date);

	// 이전달 이동
	document.querySelector(`.prevDay`).onclick = () => {
		makeCalendar(new Date(date.setMonth(date.getMonth() - 1)));
	}

	// 다음달 이동
	document.querySelector(`.nextDay`).onclick = () => {
		makeCalendar(new Date(date.setMonth(date.getMonth() + 1)));
	}
	// 달력 출력 끝 //

	// 상담 시간을 불러오는 메서드 시작
	const loadCnsltTime = function (cnsltDe) {
		return new Promise((resolve) => {			// 상담 시간 불러온 뒤(loadCnsltTime) 상담 시간과 일치하면 해당 시간을 비활성화(loadCnsltResve)
			let prevDayFlag = prevToday(getDate(cnsltDe)); 	// 오늘 날짜 이전인지 확인
			
			// 상담 시간을 불러오는 Ajax 시작
			$.ajax({
				url: "/cnslt/loadTime",
				type: "get",
				dataType: "json",
				success: function(result) {
					let html = '<ul class="select_time">';
					
					for (let i = 0; i < result.length; i++) {
						let time = result[i];
						
						html += `<li class='select-time-li'>
									<span class='time'>\${time}</span>
									<span class='btn'>
										<a href='#' id='btn\${i}' data-time='\${time}' class='btn-custon-rounded-four btn-warning time_selector ok-click'>예약선택</a>
									</span>
									<span id='nmSpace\${i}' style='right: auto;'></span>
								</li>`;
					}
					html += '</ul>';
					
					$("#timepicker").html(html);
					
					// 오늘 이전 날짜인 경우 비활성화
					if (prevDayFlag == false) {
						let timeSelect = $(".time_selector");
						let timeSelectCls= timeSelect.prop('class');
						
						timeSelect.removeClass('ok-click');
						timeSelect.css('background-color', 'gray');
						timeSelect.closest('li').css('background-color', '#eaeaea');
						timeSelect.html('예약불가');
					}
					
					 resolve(); // 작업이 완료되었음을 알림
					 
	            } // end Success
			});	// end 상담 시간을 불러오는 Ajax
		}); // end Promise
	} // end loadCnsltTime
	
	const loadCnsltResve = function(cnsltDe) {
		let cnsltVO = {
			"cnsltDe" : cnsltDe,
			"clasCode" : clasCode
		};
		
		// 오늘 날짜에 해당하는 예약 내역을 불러오는 메서드
		loadCnsltTime(cnsltDe)
			.then(function() {
				// 예약된 상담 시간과 일치하는 예약 선택 버튼을 비활성화하는 Ajax 시작 //
				$.ajax({
					url: "/cnslt/loadCnsltResve",
					data: JSON.stringify(cnsltVO),
					contentType: "application/json; charset=utf-8",
					type: "post",
					dataType: "json",
					beforeSend:function(xhr){
						xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
					},
					success: function(result) {
						if (result == null || result == '') { return; }	// 예약 내역이 없을 때
						
						if (modFlag != 'mod') {	// 수정일 때는 중복 확인 해제
			 				for (let i = 0; i < result.length; i++) {			// 해당 날짜에 예약 내역이 중복되는지 확인
			 					if (result[i].cnsltTrgetId == `${USER_INFO.mberId}`) {
			 						Swal.fire({
			 							title: "같은 날짜에 중복 예약은 불가합니다.",
			 							text: "상담 예약 화면으로 이동합니다.",
			 							icon: 'error',
			 							confirmButtonColor: '#d33',
			 							confirmButtonText: '닫기'
			 						}).then(() => { history.back() });
			 					} // end if (result[i].cnsltTrgetId == `${USER_INFO.mberId}`)
			 				} // end 중복 확인
						} // end if (modFlag != 'mod')
				        
		 				for (let i = 0; i < result.length; i++) {
		 					let resvetime = result[i].cmmnCnsltTime;					// 예약된 시간
		 					let resveId = result[i].cnsltTrgetId;						// 예약 아이디
		 					let resveNm = result[i].cnsltTrgetIdNm;						// 예약 이름
		 					let pwNm = resveNm;											// *처리 된 다른 사람 이름
		 					
		 					for (let j = 0; j < $(".time_selector").length; j++) {
		 						let timeSpan = $(".time_selector").eq(j).data("time");	// 예약 시간 div 불러오기
								
		 						let btn = $(`#btn\${j}`);
		 						if (timeSpan == resvetime) {							// 예약된 시간은 비활성화
		 							btn.removeClass('ok-click');
		 							btn.css('background-color', 'gray');
		 							btn.closest('li').css('background-color', '#eaeaea');
		 							btn.html('예약불가');
		 							
		 							if ( !(resveId == `${USER_INFO.mberId}`) ) {
										pwNm = "";	// 값 초기화
		 								
		 								let nmArry = resveNm.split("");
		 							
		 								for (let i = 0; i < nmArry.length; i++) {	// 중간 이름 *로 대체
		 									if ( 1 <= i && i < (nmArry.length - 1)) { nmArry[i] = "*"; }
		 									pwNm += nmArry[i];
		 								}
		 							}
		 							
	 								$(`#nmSpace\${j}`).html("예약자 이름 : " + pwNm);
		 							
		 						}  // end if (timeSpan == resvetime)
		 					} // end  for(j)
		 				} // end for(i)
					} // end success
				});	// end 예약된 상담 시간과 일치하는 예약 선택 버튼을 비활성화하는 Ajax	
			}); // end loadCnsltTime.then
	} // end loadCnsltResve
	
	loadCnsltResve(selectedDate);
	
	// 달력의 날짜를 클릭하면 해당 날짜의 예약 목록을 불러오는 이벤트 시작 //
	$(document).on("click", ".getDate", function() {
		let todayFlag = "";	// 오늘 날짜 이전/이후 확인 flag
		
		$(".onSelected").removeClass('onSelected');		// 현재 날짜의 선택을 해제
		$(this).attr('class', 'getDate onSelected');	// 선택한 날짜의 클래스에 onSelected 추가
		
		let selectDay = $(this).attr("value");
		loadCnsltResve(selectDay);
	});
	// 달력의 날짜를 클릭하면 해당 날짜의 예약 목록을 불러오는 이벤트 끝 //
	
	// 예약하기/예약불가를 클릭하는 함수 시작 //
	$(document).on("click", ".ok-click", function() {
		let time = $(this).data("time");
		
		$("#cnsltDe").val(selectedDate);
		$("#cmmnCnsltTime").val(time);
	}); 
	// 예약하기/예약불가를 클릭하는 함수 끝 //
	
	// textarea 글자수 카운트하는 함수 시작 //
	$("#cnsltRequstCn").keyup(function (e) {
		let content = $(this).val();
		let cntSpan = $("#cntTxt");
		// 글자수 세기
		if (content.length == 0 || content == '') {
			cntSpan.text('0');
		} else {
			cntSpan.text(content.length);
		}
		
		// 글자수 제한
		if(content.length > 200) {
	        $(this).val(content.substring(0, 200));
	        $("#cntTxtWrap").css('color', 'red');
	    };
	});
	// textarea 글자수 카운트하는 함수 끝 //
	
	// 입력 폼을 보내서 insert하는 함수 시작 //
	$(document).on("click", "#submitBtn", function(){
		let cnsltTrgetId = $("#cnsltTrgetId").val();
		let mberNm = $("#mberNm").val();
		let cnsltDe = $("#cnsltDe").val();
		let cmmnCnsltTime = $("#cmmnCnsltTime").val();
		let cnsltRequstCn = $("#cnsltRequstCn").val();
		
		if ( cnsltTrgetId == null || cnsltTrgetId == '' ) {
			Swal.fire({ title: '아이디를 입력해주세요', text: ' ', icon: 'info' }); $("#cnsltTrgetId").focus(); return false; 
		}
		if ( mberNm == null || mberNm == '' ) {
			Swal.fire({ title: '이름을 입력해주세요', text: ' ', icon: 'info' }); $("#mberNm").focus(); return false;
		}
		if ( cnsltDe == null || cnsltDe == '' || cmmnCnsltTime == null || cmmnCnsltTime == '') { 
			Swal.fire({ title: '시간을 선택해주세요', text: ' ', icon: 'info' }); return false; 
		}
		if ( cnsltRequstCn == null || cnsltRequstCn == '' ) { 
			Swal.fire({ title: '상담 요청 내용을 입력해주세요', text: ' ', icon: 'info' }); $("#cnsltRequstCn").focus(); return false; 
		}
		
		let formData = {
			"cnsltTrgetId" : cnsltTrgetId,
			"cnsltDe" : cnsltDe,
			"cmmnCnsltTime" : cmmnCnsltTime,
			"cnsltRequstCn" : cnsltRequstCn,
			"clasCode" : clasCode
		};
		
		$.ajax({
			url: "/cnslt/setCnsltRequest",
			type: "post",
			data: JSON.stringify(formData),
			contentType: "application/json; charset=utf-8",
			dataType: "text",
			beforeSend: function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			},
			success: function(url){
				let res = "성공";
				let icon = "success";
				
				if (url == null || url == '') { res = "실패"; icon = "error"; }
				
				Swal.fire({
					title: '상담 신청이 ' + res + '하였습니다.',
					text: '상담 예약 화면으로 이동합니다.',
					icon: icon
				}).then(result => { location.href = url; });
			}
		}); // end ajax
	});
	// 입력 폼을 보내서 insert하는 함수 끝 //
	
	// 입력 폼을 보내서 수정하는 함수 시작 //
	$(document).on("click", "#modifyBtn", function(){
		let cnsltCode = sessionStorage.getItem("cnsltCode");
		let cnsltDe = $("#cnsltDe").val();
		let cmmnCnsltTime = $("#cmmnCnsltTime").val();
		let cnsltRequstCn = $("#cnsltRequstCn").val();
		
		if ( cnsltTrgetId == null || cnsltTrgetId == '' ) {
			Swal.fire({ title: '아이디를 입력해주세요', text: ' ', icon: 'info' }); $("#cnsltTrgetId").focus(); return false; 
		}
		if ( mberNm == null || mberNm == '' ) {
			Swal.fire({ title: '이름을 입력해주세요', text: ' ', icon: 'info' }); $("#mberNm").focus(); return false; 
		}
		if ( cnsltDe == null || cnsltDe == '' || cmmnCnsltTime == null || cmmnCnsltTime == '') {
			Swal.fire({ title: '시간을 선택해주세요', text: ' ', icon: 'info' }); return false;
		}
		if ( cnsltRequstCn == null || cnsltRequstCn == '' ) {
			Swal.fire({ title: '상담 요청 내용을 입력해주세요', text: ' ', icon: 'info' }); $("#cnsltRequstCn").focus(); return false; 
		}
		
		let formData = {
			"cnsltCode" : cnsltCode,
			"cnsltDe" : cnsltDe,
			"cmmnCnsltTime" : cmmnCnsltTime,
			"cnsltRequstCn" : cnsltRequstCn
		};
		
		$.ajax({
			url: "/cnslt/modifyCnsltResveAct",
			type: "post",
			data: JSON.stringify(formData),
			contentType: "application/json; charset=utf-8",
			dataType: "text",
			beforeSend: function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			},
			success: function(url){
				let res = "성공";
				let icon = "success";
				
				if (url == null || url == '') { res = "실패"; icon = "error"; }
				
				Swal.fire({
					title: '상담 신청 수정을 ' + res + '하였습니다.',
					text: '상담 예약 화면으로 이동합니다.',
					icon: icon
				}).then(result => { location.href = url; });
			}
		}); // end ajax
	});
	// 입력 폼을 보내서 수정하는 함수 끝 //
	
}; // end onload
</script>
<!-- 로그인 한 경우 -->
<sec:authorize access="isAuthenticated()">
	<div class="container-fluid">
		<div class="row">
			<div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
				<div class='rap'>
					<div class="calendarHeader">
						<div class="calendarBtn prevDay">
							<img src="/resources/images/common/left-arrow.png">
						</div>
						<h2 class='dateTitle'></h2>
						<div class="calendarBtn nextDay">
							<img src="/resources/images/common/right-arrow.png">
						</div>
					</div>
					<div class="grid dateHead">
						<div>일</div><div>월</div><div>화</div><div>수</div><div>목</div><div>금</div><div>토</div>
					</div>
					<div class="grid dateBoard"></div>
					<div style="height: 20px;"></div>	<!-- 공백 div -->
				</div>
			</div>
			<div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
				<div class='rap'>
					<div class="sparkline12-list">
						<div class="sparkline12-hd"><div class="main-sparkline12-hd"></div></div>
						<div class="sparkline12-graph">
							<div class="basic-login-form-ad">
								<div class="row">
									<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
										<div class="all-form-element-inner">
												<div class="form-group-inner">
													<div class="row">
														<div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
															<label class="login2 pull-right pull-right-pro">상담자 아이디</label>
														</div>
														<div class="col-lg-9 col-md-9 col-sm-9 col-xs-12">
															<input type="text" id="cnsltTrgetId" name="cnsltTrgetId" value="${USER_INFO.mberId}" class="form-control" readonly />
														</div>
													</div>
												</div>
												<div class="form-group-inner">
													<div class="row">
														<div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
															<label class="login2 pull-right pull-right-pro">상담자 이름</label>
														</div>
														<div class="col-lg-9 col-md-9 col-sm-9 col-xs-12">
															<input type="text" id=mberNm value="${USER_INFO.mberNm}" class="form-control" readonly/>
														</div>
													</div>
												</div>
												<div class="form-group-inner">
													<div class="row">
														<div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
															<label class="login2 pull-right pull-right-pro">상담 일자</label>
														</div>
														<div class="col-lg-3 col-md-3 col-sm-3 col-xs-12" style="width: 29%;">
															<input type="date" id="cnsltDe" name="cnsltDe" class="form-control" readonly />
														</div>
														<div class="col-lg-2 col-md-2 col-sm-2 col-xs-12">
															<label class="login2 pull-right pull-right-pro">상담 시간</label>
														</div>
														<div class="col-lg-3 col-md-3 col-sm-3 col-xs-12" style="width: 29%;">
															<input type="text" id="cmmnCnsltTime" name="cmmnCnsltTime" class="form-control" readonly />
														</div>
													</div>
												</div>
												<div class="form-group-inner">
													<div class="row">
														<div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
															<label class="login2 pull-right pull-right-pro">상담 요청 내용</label>
														</div>
														<div class="col-lg-9 col-md-9 col-sm-9 col-xs-12">
															<textarea id="cnsltRequstCn" name="cnsltRequstCn" maxlength="200" class="form-control" style="height: 321px;"></textarea>
													</div>
													<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="text-align: right;">
														<span id="cntTxtWrap">(<span id="cntTxt">0</span>/200글자)</span>
													</div>
												</div>
											</div>
											
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="container-fluid">
		<div class="row">
			<div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
				<div class='rap'>
					<!-- 상담 예약 시간이 나오는 부분 -->
					<div class="timepicker_selector">
						<div id="timepicker"></div>
					</div>
				</div>
			</div>
			<div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
				<div class='rap'>
					<!-- 버튼이 나오는 부분 -->
					<div class="row">
						<div class="timepicker_selector" style="text-align: right; margin-right: 1.5rem;">
							<span id="btnSpan"></span>
							<button type="button" onClick="history.back();" class="btn btn-custon-rounded-two btn-danger"><i class="fa fa-times edu-danger-error" aria-hidden="true"></i>뒤로가기</button>
						</div>
						<!------------------------- 자동 완성 버튼 시작 --------------------------->
						<div style="text-align: right; margin-right: 1.5rem;">
							<button id="diaryAutoBtn" class="autoBtn">
								<i class="fa fa-pencil-square-o" aria-hidden="true" style="cursor: pointer;"></i>
							</button>
						</div>
						<!------------------------- 자동 완성 버튼 끝 ----------------------------->
					</div>
				</div>
			</div>
		</div>
	</div>
</sec:authorize>
<!-- 로그인 안 한 경우 -->
<sec:authorize access="isAnonymous()">
	<jsp:include page="../error/needLogin.jsp"/>
</sec:authorize>
