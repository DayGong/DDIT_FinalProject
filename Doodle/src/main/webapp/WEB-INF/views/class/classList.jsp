<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
<style>
#clasInNo {
	border: 2px solid #bbb;
    border-radius: 5px; /* 둥근 테두리 설정 */
    font-size: 15px; /* 원하는 크기로 설정 */
    padding: 10px; /* 텍스트 입력란의 내부 여백 설정 */
    width: 50px; /* 입력 필드의 너비 설정 */
}

/* Chrome, Safari, Edge, Opera input 숫자 화살표 없애기*/
input::-webkit-outer-spin-button,
input::-webkit-inner-spin-button {
  -webkit-appearance: none;
  margin: 0;
}

/* Firefox  input 숫자 화살표 없애기*/
input[type='number'] {
  -moz-appearance: textfield;
}

.modal-dialog {
    max-width: 500px;
}

.modal-body h4,
.modal-body p,
.modal-footer {
    text-align: center;
}

.modal-body h4 {
    margin-top: 20px; /* 상단 여백 설정 */
}

.modal-area-button .Primary { /* 신청버튼 */
    background: #006DF0;
    font-size: 14px;
    padding: 8px 15px;
    border-radius: 3px;
}

.modal-area-button .mg-b-10 {
    margin-top: 0px;
}

.modal-area-button .danger-color {/* 종료버튼 */
    background: #eaeaea;
    padding: 8px 15px;
}

.table>tbody>tr>td, .table>tbody>tr>th, .table>tfoot>tr>td, .table>tfoot>tr>th, .table>thead>tr>td, .table>thead>tr>th {
    padding: 2px;
    line-height: 1.42857143;
    vertical-align: middle;
    border-top: 1px solid #ddd;
}

#classListContainer h3{
	font-size: 2.2rem;
	text-align: center;
	backdrop-filter: blur(4px);
	background-color: rgba(255, 255, 255, 1);
	border-radius: 50px;
	box-shadow: 35px 35px 68px 0px rgba(145, 192, 255, 0.5), inset -8px -8px 16px 0px rgba(145, 192, 255, 0.6), inset 0px 11px 28px 0px rgb(255, 255, 255);
	width: 370px;
	padding-top: 35px;
	padding-bottom: 35px;
	margin: auto;
	margin-bottom: 40px;
}
#classListContainer{
		min-height: 790px;
}
#classListContainer .custom-pagination{
	max-width:302px;
	margin: auto;
}

.modal-edu-general .modal-body p {
    line-height: 24px;
    font-size: 16px;
    font-weight: 400;
    padding: 15px;
}

.invCode:focus {
	outline:none;
}
  
#invCodeJoinModal input.invCode {
    font-family: inherit;
    font-size: 100%;
    line-height: 1.15;
    font-size: 40px;
    width: 300px;
    letter-spacing: 6.2px;
    /* 다른 스타일 속성들 */
}
	

#invCodeJoinModal p {
    line-height: 24px;
    font-size: 35px;
    font-weight: 400;
    margin-top: -25px;
    /* 다른 스타일 속성들 */
}

#cmmnClasSttusNm{
		height: 40px;
		border: 1px solid #ddd;
		border-radius: 5px;
		padding-left: 10px;
}

.searchForm{
		height: 40px;
		border: 1px solid #ddd;
		border-radius: 5px;
		padding: 15px 20px;
}

#btnSearch,#createBtn{
		background: #333;
		height: 40px;
		border: none;
		padding: 10px 15px;
		border-radius: 10px;
		font-family: 'Pretendard' !important;
		font-weight: 600;
		color: #fff;
}
#btnSearch:hover, #createBtn:hover{
	background: #ffd77a;
	color:#333;
	transition:all 1s;
	font-weight: 700;
}
#createBtn{
	background: #006DF0;
}

.modal-area-button tbody tr.none-tr:hover {
    background: #f5f5f5!important;
}


</style>
<script>
//전역 변수
var currentPage = "${param.currentPage}";
var keyword = "";
var schulCode = "${schulVO.schulCode}";
var cmmnClasSttusNm = "전체";
var clasCode = "";
var size = 10;
var mberClasCode = [];		//내가 속해있는 클래스들
var mberId = "${memberVO.mberId}";


$(function(){
	//console.log("존재:",$("#btnSearch")[0]);
	if(currentPage == "") currentPage = "1"; 

	//getMberClasCode();

	//기본조회
	fn_search(1);
	
	//input태그에서 엔터시 검색버튼누르기
	var input = $("#keyword");
	  input.on("keypress", function(event) {
	      if (event.key === "Enter") {
	          event.preventDefault();
	          $("#btnSearch").click();
	      }
	  });
	
	//검색조회
	$("#btnSearch").on("click",function(){
		fn_search(1);
	}); //검색 끝
		
	//상태 선택조회
    $("#cmmnClasSttusNm").change(function() {
    	fn_search(1);
    });//셀렉트끝


	//모달---------------- 

	//가입완료버튼 -> 클래스 코드 가져오기
	$(document).on('click', '#joinChk', function() {
	    clasCode = $(this).data('clas-code');
	    console.log("clasCode:", clasCode);
	});
    
	$("#joinBtn").on("click",function(){
		console.log("clasCode",clasCode);
		console.log("내가 가져온 값들 ->", clasCode + "랑 " + schulCode);
		
		let clasInNo = $("#clasInNo").val(); //학급 번호

		// 학생 번호 입력 체크 - sweetAlert2사용
		if (!clasInNo.trim()) { 
			  Swal.fire({
				  icon : "error",
			      title: "번호를 입력해주세요 !"
			    })
			return;
		}
		
		let data = {
				"schulCode":schulCode,
				"clasInNo":clasInNo,
				"clasCode":clasCode
		}
		console.log("data",data);
		
		//클래스 가입 ajax
		$.ajax({
			url:"/class/classJoinReqAjax",
			contentType:"application/json;charset=utf-8",
			data:JSON.stringify(data),
			type:"post",
			dataType:"text",
			beforeSend:function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			},success:function(result){
				console.log("result",result);
				//result=0 실패 / result=1성공
				if(result =="0"){
					Swal.fire({
						title: '이미 가입신청 한 클래스입니다.',
						text: '가입신청을 취소할까요?',
						icon: 'warning',
						
						showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
						confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
						cancelButtonColor: '#d33', // cancel 버튼 색깔 지정
						confirmButtonText: '승인', // confirm 버튼 텍스트 지정
						cancelButtonText: '취소', // cancel 버튼 텍스트 지정
						}).then(result => {
						// 만약 Promise리턴을 받으면,
						if (result.isConfirmed) { // 만약 모달창에서 confirm 버튼을 눌렀다면
						
							let data = {
									"schulCode":schulCode,	//학교코드
									"clasCode":clasCode		//클래스코드
							}
							$.ajax({
								url:"/class/classJoinReqCancelAajx",
								contentType:"application/json;charset=utf-8",
								data:JSON.stringify(data),
								type:"post",
								dataType:"text",
								beforeSend:function(xhr){
									xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
								},success:function(result){
									console.log("1이면 삭제성공! >> ",result);
								}
							}); //DELETE AJAX 끝
								Swal.fire({
								title: '가입신청을 취소했습니다.',
								icon: 'success'
								})
							$("#classroomJoinChekModal").modal('hide'); //모달 닫기
						}
					});
				}else if(result=="1"){
					Swal.fire({
						icon : "success",
						title: "가입신청이 완료되었습니다."
			    		}).then(() => {
							$("#classroomJoinChekModal").modal('hide'); //모달 닫기
						});
				}
			}//success끝
		}); //가입 ajax끝
	}); //가입버튼 끝
	//등록버튼
	$("#createBtn").on("click", function() {
			location.href = "/class/classCreate?schulCode="+schulCode; //GET방식
		});
});

//초대코드 가입하기 모달
$(document).on('click', '#invCodeBtn', function() {

	$('#classroomJoinChekModal').modal('hide');
});
//초대코드모달 -> 완료
$(document).on('click', '#invCodeChkBtn', function() {

	var invCode = $(".invCode").val();
	console.log("invCode",invCode);
	console.log("clasCode",clasCode);

	if(!invCode || invCode === null || invCode.trim() === ""){
		Swal.fire({
					icon : "warning",
					title: "초대코드를 입력해주세요"
				});
		return;
	}

	//학교 소속회원에 INSERT
	if(clasCode == invCode){

		let data = {
			"schulCode":schulCode,
			"clasCode":clasCode
		}
		console.log("schulCode",schulCode);

		$.ajax({
			type:"post",
			url:"/class/classInvCodeJoin",
			contentType:"application/json;charset=utf-8",
			data:JSON.stringify(data),
			dataType:"json",
			beforeSend:function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			},success:function(result){
				if(result == 0){
					Swal.fire({
						icon : "error",
						title: "이미 소속된 클래스입니다."
					});
				}else{
					Swal.fire({
						icon : "success",
						title: "가입이 완료되었습니다."
					}).then(result => {
					if (result.isConfirmed) {
					location.href = `/main`; //get방식
					}
				});
				}
			}

		})//Ajax 끝

		
	}else{
		Swal.fire({
					icon : "error",
					title: "초대코드를 확인해주세요."
			    });
		return;
	} //if문 끝
});//완료버튼끝



    //모달 ------------------

//내가 속해있는 클래스 조회
/*
function getMberClasCode(){
	$.ajax({
		url:"/class/getMberClasCode",
		type:"post",
		dataType:"json",
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success:function(result){
			console.log("result은????",result);
			$.each(result, function(index, clasStdntVO) {
					console.log("메로!", clasStdntVO);
					mberClasCode.push(clasStdntVO.clasCode);
				});
			console.log("찍혔남?",mberClasCode);
		}
	});

};
*/

// 클릭한 학급클래스 입장
/*
const enterClass = function(clasCode, childId){
	document.querySelector("#mainClasCode").value=clasCode;
	if(childId != null){
		document.querySelector("#mainChildId").value=childId;
	}
	console.log("clasCode잘아ㅗㅅ나",clasCode);
	console.log("mberId잘아ㅗㅅ나",mberId);
	document.querySelector("#mainGoToClassForm").submit();
}
*/

//기본조회함수
function fn_search(page) {
	
	var keyword = $("#keyword").val();
    var data = {
			"schulCode": schulCode,
			"keyword" : keyword,
    		"currentPage" : page,
    		"cmmnClasSttusNm" : $("#cmmnClasSttusNm").val(),
			"size":size
    }
    console.log("data : ",data);
    $("#classListBody").html(""); //목록 초기화
    $.ajax({
		url:"/class/classListAjax",
		type:"post",
		data:JSON.stringify(data), //현재 페이지 전달
		contentType:"application/json;charset=utf-8",
		dataType:"json",
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success:function(result){
			/* console.log("result.pagingArea", result.pagingArea); */
			console.log("result!!",result);
            if (result.total == 0) {
                $("#keyword").val('');

				var	str = `<tr data-index="0" class="none-tr">
								<td style="text-align: center;" colspan="6" >조회된 클래스가 없습니다.</td>
							</tr>`;
                
                $("#classListBody").html(str);
            } else {
				let html = "";
				$.each(result.content, function(idx, clasVO) {
					html += `<tr>
						<td>\${clasVO.rnum}</td>
						<td>\${clasVO.clasYear}</td>
						<td>\${clasVO.schulNm}</td>
						<td>\${clasVO.cmmnGradeNm}학년 \${clasVO.clasNm}</td>
						<td>\${clasVO.mberNm}</td>
						<td>\${clasVO.cmmnClasSttusNm}</td>
						<td>`;
					/* if (mberClasCode[0] == clasVO.clasCode) {
						html += `<div class='modal-area-button'><a class='Primary mg-b-10' onclick ="enterClass(\${clasVO.clasCode},\${mberId})" data-toggle='modal'>입장</a></div>`;
					} */
					if (clasVO.cmmnClasSttusNm === '운영') {
						html += `<div class='modal-area-button'><a class='Primary mg-b-10' href='#classroomJoinChekModal' data-toggle='modal' data-clas-code='\${clasVO.clasCode}' data-schul-code='\${clasVO.schulCode}' id='joinChk'>신청</a></div>`;
					} else if (clasVO.cmmnClasSttusNm === '중지' || clasVO.cmmnClasSttusNm === '종료') {
						html += `<div class='modal-area-button'><a class='Danger danger-color' href='#errorBtn' data-toggle='modal'>종료</a></div>`;
					} 
					html += `</td>
					</tr>`;
				});

				//누적!
				$("#classListBody").append(html);
			}
			//페이징처리
			$("#divPaging").html(result.pagingArea);
		 
		}
	}); //ajax끝
}
    
</script>

<!-- <form id="mainGoToClassForm" action="/class/classMain" method="post">
	<input type="hidden" id="mainClasCode" name="clasCode" value="">
	<input type="hidden" id="mainChildId" name="childId" value="">
	<sec:csrfInput />
</form> -->

<div id="classListContainer">
	<div class="sparkline13-list">
		<h3 id="title">
			<img src="/resources/images/classRoom/classList1.png" style="width:50px; display:inline-block; vertical-align:middel;">
				학급 클래스
			<img src="/resources/images/classRoom/classList2.png" style="width:50px; display:inline-block; vertical-align:middel;">		
		</h3>
		<div class="row">
			<div class="fixed-table-toolbar">
				<div class="pull-left button">
					<c:if test="${USER_INFO.vwMemberAuthVOList[0].cmmnDetailCode == 'ROLE_A14002'}">
						<button type="button" id="createBtn">학급 클래스 등록</button>
					</c:if>
				</div>
				<div class="pull-right search" style="margin-bottom: 20px;">
						<!-- 검색 셀렉트 -->
							<select name="cmmnClasSttusNm" id="cmmnClasSttusNm">
								<option value="전체">전체</option>
								<option value="운영">운영</option>
								<option value="중지">중지</option>
								<option value="종료">종료</option>
							</select>
						<!-- 검색 셀렉트 -->
						<!-- 검색어 시작 -->
						<input class="searchForm" type="text" placeholder="검색어를 입력해 주세요." name="keyword" id="keyword" value="${keyword}">
						<button type="button" id="btnSearch">검색</button>
						<!-- 검색어 끝 -->
				</div>
			</div>
			
		</div>
		<div class="static-table-list modal-area-button">
			<table class="table">
				<thead>
					<tr>
						<th>순번</th>
						<th>연도</th>
						<th>학교</th>
						<th>반이름</th>
						<th>담임선생님</th>
						<th>상태</th>
						<th>가입신청</th>
					</tr>
				</thead>
				<tbody id="classListBody">
					
				</tbody>
			</table>
		</div>
		<div class="pagination text-center" style="width:100%;" id="divPaging"></div>
	</div>
</div>

<!--학생 클래스 가입 모달 시작-->
<div id="classroomJoinChekModal" class="modal modal-edu-general default-popup-PrimaryModal fade in" role="dialog" style="display: none; padding-right: 17px;">
	<div class="modal-dialog" >
		<div class="modal-content">
			<div class="modal-close-area modal-close-df">
				<a class="close" data-dismiss="modal" href="#"><i class="fa fa-close"></i></a>
			</div>
			<div class="modal-body">
				<h3>클래스 가입 요청</h3>
				<p>교실에서 나는&nbsp;<input type="number" id="clasInNo" placeholder="99" required />&nbsp;번 입니다</p>
				<span style="font-weight: bold; cursor: pointer;" id="invCodeBtn" data-toggle="modal" data-target="#invCodeJoinModal">초대코드로 가입하기</span>
			</div>
			<div class="modal-footer">
				<a href="#" id="joinBtn">완료</a>
				<a data-dismiss="modal" href="#">취소</a>
			</div>
		</div>
	</div>
</div>
<!--학생 클래스 가입 모달 끝-->


<!--학부모 클래스 가입 모달 시작-->
<div id="invCodeJoinModal" class="modal modal-edu-general default-popup-PrimaryModal fade in" role="dialog" style="display: none; padding-right: 17px;">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-close-area modal-close-df">
				<a class="close" data-dismiss="modal" href="#"><i class="fa fa-close"></i></a>
			</div>
			<div class="modal-body">
				<h3>초대코드 입력</h3>
				<br>
				<input class="invCode" type="text" style="border: none;" maxlength="10">
				<hr>
				
			</div>
			<div class="modal-footer">
				<a href="#" id="invCodeChkBtn">완료</a>
				<a data-dismiss="modal" href="#">취소</a>
			</div>
		</div>
	</div>
</div>
<!--학부모 클래스 가입 모달 끝-->

<!-- 종료 클래스 가입 모달 시작 -->
<div id="errorBtn" class="modal modal-edu-general default-popup-PrimaryModal fade in" role="dialog" style="display: none; padding-right: 17px;">
	<div class="modal-dialog" >
		<div class="modal-content">
			<div class="modal-close-area modal-close-df">
				<a class="close" data-dismiss="modal" href="#"><i class="fa fa-close"></i></a>
			</div>
			<div class="modal-body">
				<h4>가입할 수 없는 상태의 클래스입니다.</h4>
			</div>
			<div class="modal-footer">
				<a data-dismiss="modal" href="#">확인</a>
			</div>
		</div>
	</div>
</div>
<!-- 종료 클래스 가입 모달 끝 -->

