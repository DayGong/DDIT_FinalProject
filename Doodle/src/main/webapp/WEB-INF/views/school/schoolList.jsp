<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>
.modal-content, .modal-body {
	width: 750px;
}

.modal-title {
	margin-left: 50px;
}

.table tbody tr td {
	vertical-align: middle;
}

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

.signUpinputAll, .signUpinputAll tr {
	text-align: left;
}

.signUpinputAll tr {
	display:block;
}

.signUpinputAll .tableT {
	width: 80px;
}

.signUpinputAll .tableM {
	width: 130px;
}

.signUpinputAll tr, #schoolDetailTitle{
	margin-bottom: 20px;
}

#upPointerBtn {
	position: fixed;
	bottom: 62px;
	right: 45px;
	width: 50px;
	height: 50px;
	cursor:pointer;
}

#searchBtn, .closeModal {
	background: #333;
	height: 40px;
	border: none;
	padding: 10px 15px;
	border-radius: 10px;
	font-family: 'Pretendard' !important;
	font-weight: 600;
	color: #fff;
}

#searchBtn:hover, .schoolDetailBtn:hover, .classroomDetailBtn:hover, .goToSchoolMain:hover, .closeModal:hover {
	background: #ffd77a;
	color:#333 !important;
	transition:all 1s;
	font-weight: 700;
}
</style>
<script>
	window.onload = function() {
        const searchBtn = document.querySelector("#searchBtn");			// 검색 버튼
		const searchTxt = document.querySelector("#searchTxt"); 		// 검색 단어 input text
		const upPointerBtn = document.querySelector("#upPointerBtn");	// 상단 이동 버튼
		
		// 학교/학급클래스 탭 구분 변수
		const schoolTab = document.querySelector("#schoolTab");			// 학교 탭
		const classroomTab = document.querySelector("#classroomTab");	// 학급클래스(반) 탭
		const schoolTabDiv = document.querySelector("#schoolTabDiv");	// 학교 탭 출력 div
		const classroomTabDiv = document.querySelector("#classroomTabDiv");	// 학급클래스(반) 탭 출력 div
		
		// 학교 선언 변수
		const schoolTotalSpan = document.querySelector("#sTotal");			// 학교 검색 결과 개수 출력 span
		const schoolTbody = document.querySelector("#schoolTbody");			// 학교 검색 결과 출력 div
        const schoolModal = document.querySelector("#schoolDetailModal"); 	// 학교 자세히보기 모달
        const goToSchoolMain = document.querySelector(".goToSchoolMain");	// 학교 이동 버튼
        
		// 학급클래스(반) 선언 변수
		const classroomTotalSpan = document.querySelector("#cTotal");				// 학급클래스(반) 결과 개수 출력 span
		const classroomTbody = document.querySelector("#classroomTbody");			// 학급클래스(반) 검색 결과 출력 div
		const classroomModal = document.querySelector("#classroomDetailModal"); 	// 학급클래스(반) 자세히보기 모달
		
		let html = "";					// 목록 초기화
		let classroomHtml = "";			// 학급클래스(반) 목록 초기화
		let keyword = "";				// 키워드 선언
		let rowNum = 1;					// 행 번호 선언
		let classRowNum = 1;			// 학급클래스(반) 행 번호 선언
		let currentPage = 0;			// 첫 시작 페이지 선언
		let clasCurrentPage = 0;		// 학급클래스(반) 첫 시작 페이지 선언
		let size = 20;					// 한 번에 불러오는 데이터 갯수
		let timer;						// 디바운싱용 변수
		let tabFlag = true;				// 학교/학급클래스 구분 탭(true = 학교 / false = 학급클래스)
		
		// 검색창에서 엔터시 검색버튼누르기
		$("#searchTxt").on("keypress", function(event) {
			if (event.key === "Enter") {
				event.preventDefault();
				$("#searchBtn").click();
			}
		});
		
		// 페이지가 시작할 때 스크롤바를 맨 위에 올림
		setTimeout(() => { window.scrollTo(0, 0); }, 30);
		
		// 검색어가 없을 때 ""로 설정
		if (keyword == null || keyword == undefined) {	keyword = ""; }
		
		// 상단 이동 버튼
		upPointerBtn.addEventListener("click", function() { window.scrollTo(0, 0);	});
		
		// 학교/학급클래스 탭 클릭 구분 시작 //
		schoolTab.addEventListener("click", function() { 	// 학교
			tabFlag = true;
			schoolTabDiv.style.display = "block";
			classroomTabDiv.style.display = "none";
		}); 
		classroomTab.addEventListener("click", function() { // 학급클래스(반)
			tabFlag = false;
			schoolTabDiv.style.display = "none";
			classroomTabDiv.style.display = "block";
		}); // 학교/학급클래스 탭 클릭 구분 끝 //
		
		// 학교 목록을 불러오는 Ajax(schoolListAjax) 시작 //
		const schoolListAjax = function(keyword) {
			html = schoolTbody.innerHTML;
			currentPage++;
			
			let data = {
				"keyword" : keyword,
				"currentPage" : currentPage,	// 초기 페이지
				"size" : size			
			}
			
			$.ajax({
				type: "post",
				url: "/school/schoolListAjax",
				contentType: "application/json;charset=utf-8",
				data: JSON.stringify(data), // 현재 페이지 전달
				dataType:"json",
				beforeSend:function(xhr){
					xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
				},
				success: function(result) {
					const sTotal = result.total; 
					if (sTotal == null || sTotal == '') {
						html += `<tr>
									<td colspan='3' style='text-align: center;'>해당하는 학교가 존재하지 않습니다.</td>
								</tr>`;
					} else {
						let rows = result.content;
						for (let i = 0; i < rows.length; i++) {
							let row = rows[i];
							html += `<tr>
										<td>\${rowNum++}</td>
										<td>\${row.schulNm}</td>
										<td>
											<div class="modal-area-button">
												<a class="Primary mg-b-5 schoolDetailBtn" href="#" data-toggle="modal" data-target="#schoolDetailModal"
													data-schul-nm="\${row.schulNm}" data-schul-adres="\${row.schulAdres}"
													data-schul-tlphon-no="\${row.schulTlphonNo}" data-schul-annvrsry="\${row.schulAnnvrsry}"
													data-schul-code="\${row.schulCode}">자세히보기</a>
											</div> 
										</td>
									</tr>`;
						}
					}
					
					schoolTotalSpan.innerHTML = sTotal;
					schoolTbody.innerHTML = html;
				}
			});
		} // 학교 목록을 불러오는 Ajax(schoolListAjax) 끝 //
		
		// 학급클래스(반) 목록을 불러오는 Ajax(classroomListAjax) 시작 //
		const classroomListAjax = function(keyword) {
			classroomHtml = classroomTbody.innerHTML;
			clasCurrentPage++;
			
			let data = {
				"keyword" : keyword,
				"currentPage" : clasCurrentPage,	// 초기 페이지
				"size" : size			
			}
			
			$.ajax({
				url: "/class/classroomListAjax",
				contentType: "application/json;charset=utf-8",
				data: JSON.stringify(data), // 현재 페이지 전달
				type: "post",
				dataType:"json",
				beforeSend:function(xhr){
					xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
				},
				success: function(result) {
					console.log("result==> ", result);
					const cTotal = result.total; 
					if (cTotal == null || cTotal == '') {
						classroomHtml += `<tr>
											<td colspan='6' style='text-align: center;'>해당하는 학급클래스(반)가 존재하지 않습니다.</td>
										</tr>`;
					} else {
						let rows = result.content;
						for (let i = 0; i < rows.length; i++) {
							let row = rows[i];
							classroomHtml += `<tr>
										<td>\${classRowNum++}</td>
										<td>\${row.clasNm}</td>
										<td>\${row.cmmnGradeNm}학년</td>
										<td>\${row.schulVO.schulNm}</td>
										<td>\${row.schulVO.schulAdres}</td>
										<td>
											<div class="modal-area-button">
												<a class="Primary mg-b-5 classroomDetailBtn" href="#" data-toggle="modal" data-target="#classroomDetailModal"
													data-clas-code="\${row.clasCode}" data-clas-nm="\${row.clasNm}" data-clas-year="\${row.clasYear}"
													data-grade="\${row.cmmnGradeNm}" data-school-nm="\${row.schulVO.schulNm}"
													data-schul-adres="\${row.schulVO.schulAdres}" data-mber-nm="\${row.mberNm}"
													data-begin-tm="\${row.beginTm}" data-end-tm="\${row.endTm}">자세히보기</a>
											</div> 
										</td>
									</tr>`;
						}
					}
					
					classroomTotalSpan.innerHTML = cTotal;
					classroomTbody.innerHTML = classroomHtml;
				}
			});
		} // 학급클래스(반) 목록을 불러오는 Ajax(classroomListAjax) 끝 //
		
		schoolListAjax(keyword);		// 학교 목록 불러오기
		classroomListAjax(keyword);		// 학급클래스(반) 목록 불러오기
        
		// 무한 스크롤 시작 //
		const schoolScroll = function() {
			let scrollTop = document.documentElement.scrollTop;         // 위로 올라간 높이
	        let clientHeight = document.documentElement.clientHeight;   // 사용자 눈에 보이는 화면 높이
	        let scrollHeight = document.documentElement.scrollHeight;   // 문서 전체 높이
	
	        const tunningVal = 50;
	        
	     	// 스크롤바를 끝까지 내렸을 때
	        if ( (scrollTop + clientHeight) >= (scrollHeight - tunningVal) ) {
	        	if (tabFlag == true) {
	    			schoolListAjax(keyword);		// 학교 목록 불러오기
	    		} else {
	    			classroomListAjax(keyword);		// 학급클래스(반) 목록 불러오기
	    		}
	        }
		} // 무한 스크롤 끝 //

		// 디바운싱 시작: 이벤트가 맨 마지막에만 발생하도록 하는 것 (스크롤 이벤트가 여러번 발생하는 이슈 해결용)//
        window.addEventListener("scroll", () => {
        	if (timer) {
        		clearTimeout(timer);
        	}
        	timer = setTimeout(() => {
        		schoolScroll();
        	}, 50);
        }); // 디바운싱 끝 //
        
        // 학교/학급클래스 검색 시작 //
        searchBtn.onclick = () => {
        	keyword = searchTxt.value;

			schoolTbody.innerHTML = "";
			classroomTbody.innerHTML = "";
			
			// 현재 페이지 초기화
			currentPage = 0;
			clasCurrentPage = 0;
			
			// 번호 초기화
			rowNum = 1;
			classRowNum = 1;
			
			schoolListAjax(keyword);
			classroomListAjax(keyword);
			
		} // 학교/학급클래스 검색 끝 //
		
		// POST로 학교 바로가기 함수 시작 //
		function postSchulCode(schulCode, schulNm) {
	    	let form = document.createElement('form');

			let codeObj = document.createElement('input');
			codeObj.setAttribute('type', 'hidden');
			codeObj.setAttribute('name', 'schulCode');
			codeObj.setAttribute('value', schulCode);
			
			let nmObj = document.createElement('input');
			nmObj.setAttribute('type', 'hidden');
			nmObj.setAttribute('name', 'schulNm');
			nmObj.setAttribute('value', schulNm);

			let csrfObj = document.createElement('input');
			csrfObj.setAttribute('type', 'hidden');
			csrfObj.setAttribute('name', '_csrf');
			csrfObj.setAttribute('value', '${_csrf.token}');
		    
			form.appendChild(codeObj);
			form.appendChild(nmObj);
			form.appendChild(csrfObj);
			form.setAttribute('method', 'post');
			form.setAttribute('action', '/school/goToSchoolMain');
			document.body.appendChild(form);
			form.submit();
	    } // POST로 학교 바로가기 함수 끝 //
		
		// 상세 정보 모달 출력 시작 //
		document.addEventListener("click", function (e) {
			// 학교 관련 변수
			const schoolModalTitle = document.querySelector("#schoolTitle");
			const schoolTitle = document.querySelector("#schoolDetailTitle");
			const schoolAdres = document.querySelector("#schoolDetailAdres");
			const schoolTel = document.querySelector("#schoolDetailTel");
			const schoolAnnv = document.querySelector("#schoolDetailAnnv");
			
			// 학급클래스 관련 변수
			const classroomCode = document.querySelector("#classroomCode");
			const classroomModalTitle = document.querySelector("#classroomTitle");
			const classroomNm = document.querySelector("#classroomDetailNm");
			const classroomYear = document.querySelector("#classroomDetailYear");
			const classroomGrade = document.querySelector("#classroomDetailGrade");
			const classSchool = document.querySelector("#classroomDetailSchool");
			const classSchoolAdres = document.querySelector("#classroomDetailSchoolAdres");
			const classTeacher = document.querySelector("#classroomDetailTeacher");
			const classStartTm = document.querySelector("#classroomDetailStartTm");
			const classEndTm = document.querySelector("#classroomDetailEndTm");
			
        	let eTg = e.target;
        	
        	// 학교 자세히보기 시작 //
	        if (eTg.classList.contains("schoolDetailBtn")) {
	            let schulNm = eTg.getAttribute("data-schul-nm");
	            let schulAdres = eTg.getAttribute("data-schul-adres");
	            let schulTlphonNo = eTg.getAttribute("data-schul-tlphon-no");
	            let schulAnnvrsry = eTg.getAttribute("data-schul-annvrsry");
	            let schulCode = eTg.getAttribute("data-schul-code");	// 학교 코드
	            
	            schoolModalTitle.innerHTML = schulNm;
		        schoolTitle.innerHTML = schulNm;
		        schoolAdres.innerHTML = schulAdres;
		        schoolTel.innerHTML = schulTlphonNo;
		        schoolAnnv.innerHTML = getDate(schulAnnvrsry);
		        
		     	// 학교 바로가기 버튼에 학교 코드값과 학교명 설정
		        goToSchoolMain.setAttribute("data-schul-code", schulCode);
		        goToSchoolMain.setAttribute("data-schul-nm", schulNm);
		        
	        } // 학교 자세히보기 끝 //
	        
	        // 학급클래스(반) 자세히보기 시작 //
	        if (eTg.classList.contains("classroomDetailBtn")) {
	        	let clasCode = eTg.getAttribute("data-clas-code");
	        	let clasNm = eTg.getAttribute("data-clas-nm");
	        	let clasYear = eTg.getAttribute("data-clas-year");
	        	let grade = eTg.getAttribute("data-grade");
	        	let schulNm = eTg.getAttribute("data-school-nm");
	        	let schulAdres = eTg.getAttribute("data-schul-adres");
	        	let teacher = eTg.getAttribute("data-mber-nm");
	        	let beginTm = eTg.getAttribute("data-begin-tm");
	        	let endTm = eTg.getAttribute("data-end-tm");
	        	
	        	classroomCode.innerHTML = clasCode;
	        	classroomModalTitle.innerHTML = clasNm;
	        	classroomNm.innerHTML = clasNm;
	        	classroomYear.innerHTML = clasYear;
	        	classroomGrade.innerHTML = grade;
	        	classSchool.innerHTML = schulNm;
	        	classSchoolAdres.innerHTML = schulAdres;
	        	classTeacher.innerHTML = teacher;
	        	classStartTm.innerHTML = beginTm;
	        	classEndTm.innerHTML = endTm;
	        } // 학급클래스(반) 자세히보기 끝 //
	        
	        // 학교 바로가기 버튼 시작 //
	        if (eTg.classList.contains("goToSchoolMain")) {
	        	let schulCode = goToSchoolMain.getAttribute("data-schul-code");
	        	let schulNm = goToSchoolMain.getAttribute("data-schul-nm");
	        	postSchulCode(schulCode, schulNm);
	        } // 학교 바로가기 버튼 끝 //
	        
	    }); // 상세 정보 모달 출력 끝 //
	    

	    // 날짜 형식 변환 시작 //
	    function getDate(time) {
	    	// 숫자가 아니면 숫자로 변환
			if (!isNaN(time)) {
				time = Number(time);
			}
	    	
	    	const date = new Date(time);
	    	const year = date.getFullYear();
	    	const month = String(date.getMonth() + 1).padStart(2, '0');
	    	const day = String(date.getDate()).padStart(2, '0');
	    	
	    	return`\${year}-\${month}-\${day}`; 
	    } // 날짜 형식 변환 끝 //
	    
	} // end window.load
</script>

<!-- 학교 목록 검색 div 시작 -->
<div class="breadcome-area">
	<div class="container-fluid">
		<div class="row">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="breadcome-list single-page-breadcome" style="margin-bottom: 0px;">
					<div class="main-sparkline8-hd">
						<h1>학교/클래스 찾기</h1>
					</div>
					<div class="row">
						<div class="col-lg-12 col-md-6 col-sm-6 col-xs-12">
							<div class="breadcome-heading">
							    <form role="search" class="sr-input-func" style="width:100%;">
							        <div class="row">
							            <div class="col-md-9">
							                <input type="text" id="searchTxt" placeholder="학교/클래스 검색" class="search-int form-control" style="width:100%;">
							            </div>
							            <div class="col-md-3">
							                <button type="button" id="searchBtn">검색</button>
							            </div>
							        </div>
							    </form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- 학교 목록 검색 div 끝 -->
<!-- 학교 조회 목록 출력 시작 -->
<div class="product-sales-area" id="schoolListDiv">
	<div class="container-fluid">
		<div class="row">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="sparkline10-list mt-b-30">
					<div class="sparkline10-hd">
						<ul class="nav nav-tabs custom-menu-wrap custon-tab-menu-style1">
							<li class="active">
								<a id="schoolTab" data-toggle="tab" href="#TabProject">
									<span class="edu-icon edu-analytics tab-custon-ic"></span>
									학교 (<span id="sTotal"></span>)
								</a>
							</li>
							<li>
								<a id="classroomTab" data-toggle="tab" href="#TabDetails">
									<span class="edu-icon edu-analytics-arrow tab-custon-ic"></span>
									학급클래스 (<span id="cTotal"></span>)
								</a>
							</li>
						</ul>
					</div>
					<div class="admintab-wrap edu-tab1">
						<div class="tab-content">
							<div id="schoolTabDiv" class="tab-pane in active animated custon-tab-style1">
								<table class="table border-table">
									<thead>
										<tr>
											<th>번호</th>
											<th>학교 이름</th>
											<th>자세히보기</th>
										</tr>
									</thead>
									<tbody id="schoolTbody"></tbody>
								</table>
							</div>
							<div id="classroomTabDiv" class="tab-pane animated custon-tab-style1">
								<table class="table border-table">
									<thead>
										<tr>
											<th>번호</th>
											<th>반 이름</th>
											<th>학년</th>
											<th>학교</th>
											<th>학교 주소</th>
											<th>자세히보기</th>
										</tr>
									</thead>
									<tbody id="classroomTbody"></tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- 학교 조회 목록 출력 끝 -->
<!-- 학교 자세히보기 모달 창 시작 -->
<div id="schoolDetailModal" class="modal modal-edu-general default-popup-PrimaryModal fade" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header header-color-modal bg-color-1">
            	<table class="modal-title">
            		<tr>
            			<td class="tableT"><img src="/resources/images/school/schoolImg.png" style="width:50px;"></td>
            			<td><h2 id="schoolTitle" class="modal-title"></h2></td>
            		</tr>
            	</table>
                <div class="modal-close-area modal-close-df">
                    <a class="close" data-dismiss="modal" href="#"><i class="fa fa-close"></i></a>
                </div>
            </div>
            <div class="modal-body">
				<div id="signUpContainer">
					<h2 id="schoolDetailTitle"></h2>
					<table class="signUpinputAll">
						<tr>
							<td class="tableM"><span>학교 주소</span></td>
							<td><span id="schoolDetailAdres"></span></td>
						</tr>
						<tr>
							<td class="tableM"><span>학교 전화번호</span></td>
							<td><span id="schoolDetailTel"></span></td>
						</tr>
						<tr>
							<td class="tableM"><span>학교 설립 날짜</span></td>
							<td><span id="schoolDetailAnnv"></span></td>
						</tr>
					</table>
				</div>
            </div>
            <div class="modal-footer">
            	<a class="goToSchoolMain" href="#">학교 바로가기</a>
                <a data-dismiss="modal" class="closeModal" href="#">닫기</a>
            </div>
        </div>
    </div>
</div>
<!-- 학교 자세히보기 모달 창 끝 -->
<!-- 반 자세히보기 모달 창 시작 -->
<div id="classroomDetailModal" class="modal modal-edu-general default-popup-PrimaryModal fade" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header header-color-modal bg-color-1">
            	<table class="modal-title">
            		<tr>
            			<td class="tableT"><img src="/resources/images/school/schoolImg.png" style="width:50px;"></td>
            			<td><h2 id="classroomTitle" class="modal-title"></h2></td>
            		</tr>
            	</table>
                <div class="modal-close-area modal-close-df">
                    <a class="close" data-dismiss="modal" href="#"><i class="fa fa-close"></i></a>
                </div>
            </div>
            <div class="modal-body">
				<div id="signUpContainer">
					<h2 id="classroomDetailNm"></h2>
					<span id="classroomCode" style="display:none;"></span>
					<table class="signUpinputAll">
						<tr>
							<td class="tableM"><span>반 생성 연도</span></td>
							<td><span id="classroomDetailYear"></span></td>
						</tr>
						<tr>
							<td class="tableM"><span>반 학년</span></td>
							<td><span id="classroomDetailGrade"></span></td>
						</tr>
						<tr>
							<td class="tableM"><span>담임 선생님</span></td>
							<td><span id="classroomDetailTeacher"></span></td>
						</tr>
						<tr>
							<td class="tableM"><span>등교 시간</span></td>
							<td style="width: 150px;"><span id="classroomDetailStartTm"></span></td>
							<td class="tableM"><span>하교 시간</span></td>
							<td><span id="classroomDetailEndTm"></span></td>
						</tr>
						<tr>
							<td class="tableM"><span>학교</span></td>
							<td><span id="classroomDetailSchool"></span></td>
						</tr>
						<tr>
							<td class="tableM"><span>학교 주소</span></td>
							<td><span id="classroomDetailSchoolAdres"></span></td>
						</tr>
					</table>
				</div>
            </div>
            <div class="modal-footer">
                <a data-dismiss="modal" class="closeModal" href="#">닫기</a>
            </div>
        </div>
    </div>
</div>
<!-- 반 자세히보기 모달 창 끝 -->
<!-- 맨 위로 가기 버튼 시작 -->
<div id="upPointerBtn">
	<img src="/resources/images/common/toparrow.png">
</div>