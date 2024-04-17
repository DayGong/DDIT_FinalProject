<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<!-- <script type="text/javascript" src="/resources/js/commonFunction.js" ></script> -->
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=e03ac7f006917848896c4f551e98f356"></script>
<link rel="stylesheet" href="/resources/css/mainPage.css">

<style>
#schoolMain {
	/* 	font-size: 1.2rem; */
	width: 1400px;
	margin: auto;
}

#schoolMain h3, #schoolMain h2, #schoolMain h1 {
	display: inline-block;
}

.header-box {
	background-color: var(- -blue-color);
	color: white;
}

.InputPassword input {
	width: 100%;
}

.modal-body-school {
	text-align: center;
	backdrop-filter: blur(4px);
	background-color: rgba(255, 255, 255, 1);
	border-radius: 50px;
	box-shadow: 35px 35px 68px 0px rgba(145, 192, 255, 0.5), inset -8px -8px
		16px 0px rgba(145, 192, 255, 0.6), inset 0px 11px 28px 0px
		rgb(255, 255, 255);
	padding-top: 35px;
	padding-bottom: 35px;
	margin-bottom: 40px;
	padding: 10%;
	margin: 5%;
}

.modal-body-line {
	color: #333;
	padding: 30px 40px;
	background-color: rgba(255, 255, 255, 0.6);
	border-radius: 26px;
	backdrop-filter: blur(6px);
	box-shadow: 0px 35px 68px 0px rgba(145, 192, 255, 0.5), inset 0px -8px
		16px 0px rgba(145, 192, 255, 0.6), inset 0px 11px 28px 0px
		rgb(255, 255, 255);
}

.modal-body-line h2 {
	font-size: 2rem;
}

.schoolInfoAll span {
	font-size: 1.2rem;
}

.schoolInfoAll, .schoolInfoAll tr {
	text-align: left;
}

.schoolInfoAll tr {
	display: block;
}

.schoolInfoAll .tableT {
	width: 80px;
}

.schoolInfoAll .tableM {
	width: 130px;
}

.schoolInfoAll tr, #infoSchulNm {
	margin-bottom: 20px;
}

.modal-title {
	margin-left: 50px;
}

.menuBtn{
	width: 110px;
	height: 110px;
	margin: 5px;
	position: relative;
	background: #FFD4B2;
	padding: 20px 25px;
	border-radius: 113px;
}

.menuBtn p{
	right:0px;
}

/* 자료실/교육부 소식 테이블 */
.product-status-wrap table th {
	padding: 8px 5px;
}

/* 반 가입 아이콘  */
#classIcon{
	width: 95px;
    height: 95px;
    padding: 23px;
    background: #eee;
    border-radius: 25%;
}

.schoolIcon{
    margin-bottom: 4px;
    width: 35px;
    height: 35px;
}

/* 데이터 없을 때 글씨 색 */
.noData{
	color: #999;
}

/* 메뉴 이름 */
.headComment{
	padding: 0 10px;
}
.headComment p{
	margin: 0 0 10px;
}
.headComment h3{
	font-size: 20px;
}

/* 급식 */
.subHeadComment{
	margin-bottom: 3px;
	color: #555;
}
.inner-box2{
	padding: 10px;
	background: #fff;
}

.inner-box{
	margin-bottom: 0;
	padding: 10px 0 10px 10px;
}
.con{
	padding: 0;
/* 	height: 100%; */
}

/*퀵메뉴 css 시작*/
ul.quick-menu-container{
	display: block;
	width:100%;
	padding-left:5px;
}
ul.quick-menu-container li.first-box, ul.quick-menu-container li.second-box{
	display:block;
}

ul.quick-menu-container ul.ul-content{
	display:flex;
	justify-content: space-between;
}

ul.ul-content li{
	background: #d4e8ff;
	padding: 15px 20px;
	flex: 1;
	margin-top: 10px;
	margin-right: 5px;
	position:relative;
	cursor:pointer;
	overflow: hidden;
	min-height: 115px;
}
ul.ul-content li span{
	font-size:1.25rem;
	text-align: center;
	display: block;
	padding-top: 2px;
	font-weight: 700;
	color:#333;
}
ul.ul-content li.food-box{
	border-radius: 35px;
	border-bottom-right-radius: 0px;
	box-shadow: -5px 5px 5px -5px #c7daef;
}

ul.ul-content li.food-box .fod{
	position: absolute;
	background: url(/resources/images/school/food_back.png) no-repeat;
	width: 35px;
	height: 35px;
	background-size: cover;
	opacity: 40%;
}

ul.ul-content li.schoolcal-box .cal{
	position: absolute;
	background: url(/resources/images/school/cal_back.png) no-repeat;
	width: 35px;
	height: 35px;
	background-size: cover;
	opacity: 80%;
} 

ul.ul-content li.document-box .doc{
	position: absolute;
	background: url(/resources/images/school/doc_back.png) no-repeat;
	width: 35px;
	height: 35px;
	background-size: cover;
	opacity: 50%;
}

ul.ul-content li.after-box .aft{
	position: absolute;
	background: url(/resources/images/school/aft_back.png) no-repeat;
	width: 35px;
	height: 35px;
	background-size: cover;
	opacity: 80%;

}

/*퀵메뉴 급식*/
ul.ul-content li .back-ground-obj{
	top: 80px;
	left: 0px;
}

ul.ul-content li .back-ground-obj2{
	top: 0px;
	right: 0px;
	transform: rotateY(180deg) rotateX(180deg);
}


ul.ul-content li .quick-icon-box{
	width: 65px;
	display: block;
	margin: auto;
	margin-top: 10px;
}
ul.ul-content li .quick-tit{
	display: block;
	margin:auto;
	margin-top:5px;
}
/*퀵메뉴 학사일정*/
ul.ul-content li.schoolcal-box{
	border-radius: 35px;
	border-bottom-left-radius: 0px;
	background: #D0EEEA;
	box-shadow: 5px 5px 5px -5px #c0e1dc;
}

ul.ul-content li.schoolcal-box .back-ground-obj{
	top: 85px;
	left: 100px;
}
ul.ul-content li.schoolcal-box .back-ground-obj2{
	left: 0px;
	top: -8px;
}

/*퀵메뉴 자료실*/
ul.ul-content li.document-box{
	border-radius: 35px;
	border-top-right-radius: 0px;
	background: #FCDACF;
	box-shadow: -5px 5px 5px -5px #eac9be;
}

ul.ul-content li.document-box .back-ground-obj{
	top: 80px;
	left: 0px;
}

ul.ul-content li.document-box .back-ground-obj2{
	top: 0px;
	right: 0px;
	transform: rotateY(180deg) rotateX(180deg);
}

/*퀵메뉴 방과후 학교*/
ul.ul-content li.after-box{
	border-radius: 35px;
	border-top-left-radius: 0px;
	background: #FDF1D5;
	box-shadow: 5px 5px 5px -5px #e7dbc0;
}
ul.ul-content li.after-box .back-ground-obj{
	top: -10px;
	left: -6px;
}
ul.ul-content li.after-box .back-ground-obj2{
	top: 95px;
}

/* 지도 API */
#map div{
	border-radius: 10px; 
}
</style>

<script>
// 전역 변수
var mberId = "${USER_INFO.mberId}";

// 최초 로그인시 비밀번호 변경 요구
const passwordChange = function(){
    Swal.fire({
        title: '최초 1회 비밀번호 변경이 필요합니다.',
        text: '비밀번호를 변경해 주세요.',
        icon: 'info',
        showCancelButton: false,
        confirmButtonText: '확인',
	}).then(result => {
		if(result.isConfirmed){
			// 비밀번호 변경 모달 창 띄우기
			$("#UpdatePasswordModal").modal("show");
			
			var updateBtn = document.querySelector("#UpdatePasswordBtn");
			
			updateBtn.addEventListener("click", function(){
				var inputPassword = document.querySelector("#password1").value;
				var inputPasswordChk = document.querySelector("#password2").value;
				console.log(inputPassword);
				console.log(inputPasswordChk);
				console.log(mberId);
				
				var data = {
					"mberId":mberId,
					"password":inputPassword
				};
				
			    // 비밀번호 유효성 검사
			    if(inputPassword != inputPasswordChk || inputPassword == "" || inputPasswordChk == ""){
			        $("#firstPwChk").removeAttr("style");
			        $("#firstPwChk").html("비밀번호가 일치하지 않거나 올바르게 입력되지 않았습니다.");
			        return;
			    }
			    
			    $.ajax({
					url: "/updatePassword",
					contentType:"application/json; charset=utf-8",
					type:"post",
					data:JSON.stringify(data),
					dataType:"json",
					beforeSend:function(xhr){
						xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
					},
					success: function(res){
						Swal.fire('비밀번호 변경 성공!', '', 'success');
						$("#UpdatePasswordModal").modal("hide");
			        }
				});
			});
		}
	});
}

// 학교 정보 모달 초기화
const schoolInfoModalInit = function(){
	document.querySelector("#infoSchulNm").textContent = '${SCHOOL_INFO.schulNm}';
	document.querySelector("#infoSchulAdres").innerText  = '${SCHOOL_INFO.schulAdres}';
	document.querySelector("#infoSchulTlphonNo").innerText  = '${SCHOOL_INFO.schulTlphonNo}';
	document.querySelector("#infoSchulAnnvrsry").innerText  = modelDateFormat('${SCHOOL_INFO.schulAnnvrsry}');
}

// 학교 정보 버튼
const schoolInfoBtn = function(){
// 	console.log("classroomInfoBtn act");
	$("#schoolInfoModal").modal('show');
}

// 학교 수정
const modifySchool = function(){
	console.log("modifySchool act");
}

// 학교 삭제
const deleteSchool = function(){
	console.log("deleteSchool act");
}

// 급식 정보
const getMeals = function(){
	$.ajax({
		url:"/school/mainPageMeals",
		method:"post",
		dataType:"json",
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success:function(res){
// 			console.log(" getMeals res:",res);
			
			let today = res[0];
			let tomorrow = res[1];
			
// 			console.log("today:",today);
// 			console.log("tomorrow:",tomorrow);
			
			if(today != null){
				document.querySelector("#todayMeal").innerHTML = `<p>\${today.dietMenu}</p>`;
			}
			if(tomorrow != null){
				document.querySelector("#tomorrowMeal").innerHTML = `<p>\${tomorrow.dietMenu}</p>`;
			}
		}
	})
}

// 가입한 학교 목록
const getClassList = function(){
	$.ajax({
		url:"/school/myClassList",
		method:"post",
		dataType:"json",
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success:function(res){
			console.log("getClassList res:",res);
			let isTch = false;		
			<sec:authorize access ="hasRole('A01003')">
			isTch = true;
			</sec:authorize>
			
			let str = "";

			res.forEach(function(cl, index){
				
				<sec:authorize access ="hasRole('A01003')">
				cl.memberVO.forEach(function(mem, index){
				</sec:authorize>
					let childId = "";
					<sec:authorize access ="hasRole('A01003')">
					childId = `,'\${mem.mberId}'`;
					</sec:authorize>
					
					str +=  `
		                    <div class ="cl" style="align-content: center; text-align: center;">
		                    <div class = "clasBtn">
		                    <img id="classIcon" src="/resources/images/school/table.png" alt="" onclick ="enterClass('\${cl.clasCode}'\${childId})" style="padding: 13px;">
		                    </div>
		                    <p style="text-align: center;">
		                    `;
	               
	               <sec:authorize access ="hasRole('A01003')">
	               str += `\${mem.mberNm} 자녀의`;
	               </sec:authorize>
	               
	               str +=   `
	                     \${cl.cmmnDetailCodeVO.cmmnDetailCodeNm}학년 \${cl.clasNm}</p>
	                     </div>
	                     `;
					
					if(index==5){
						alert("그만.");
					}
				<sec:authorize access ="hasRole('A01003')">
				})
				</sec:authorize>
			});
			$("#clsContainer").prepend(str);
		},
		error:function(request, status, error){
			console.log("code: " + request.status)
	        console.log("message: " + request.responseText)
	        console.log("error: " + error);
		}
	})
}

// 교직원 목록
const getEmpList = function(){
	$.ajax({
		url:"/employee/employeeListAjax",
		data:JSON.stringify({schulCode:'${SCHOOL_INFO.schulCode}', currentPage:'1'}),
		contentType:"application/json; charset=utf-8",
		method:"post",
		dataType:"json",
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success:function(res){
			console.log("employeeListAjax res:", res);
			
			let str = "";
			res.content[0].schulPsitnMberVOList.forEach(function(mem){
				str += `<tr>
						<td style ="padding-left: 30px;">\${mem.memberVO.mberNm}</td>
						<td>\${mem.memberVO.mberEmail}</td>
						<td>\${mem.cmmnEmpClsf}</td>
						</tr>`;
			})
			
			if(str == ""){
				str =`<tr>
					  <td colspan = "100%" style ="text-align:center;">
				 	    등록된 교직원이 없습니다.
				 	  </td>
				 	  </tr>`
			}
			
			document.querySelector("#empListTb tbody").innerHTML = str;
		},
		error : function(request, status, error){
			console.log("code: " + request.status)
			console.log("message: " + request.responseText)
			console.log("error: " + error);
		}
	})
}

// 학사 일정
const getSchoolScheduleList = function(){
	$.ajax({
		url:"/school/scheduleListMain",
		data:{schulCode:'${SCHOOL_INFO.schulCode}'},
// 		contentType:"application/json; charset=utf-8",
		method:"get",
		dataType:"json",
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success:function(res){
			console.log("getSchoolScheduleList() res:",res);
			
			let str ="";
			
			res.forEach(function(con){
				str += `
						<div id='schoolSchedule' class='con inner-box' style='height: 21.7%; padding: 6.5px; width: 100%; float: right;margin-bottom: 10px;'>
						<p style='line-height: 130%; padding-left: 3px;'><span style ="color: #999;">
					`;
				
				// 시작일과 종료일이 같으면 시작일만 출력
				if(con.schafsSchdulBgnde != con.schafsSchdulEndde){
					str += `[\${dateFormat(con.schafsSchdulBgnde)} ~ \${dateFormat(con.schafsSchdulEndde)}]`;
				}else{
					str += `[\${dateFormat(con.schafsSchdulBgnde)}]`
				}
					str += `
							</span>
							<br>		
							\${con.schafsSchdulNm}
							</p>
							</div>
						`;
			})
			
			if(str == ""){
				str =`<p class='noData'>
				 	   등록된 일정이 없습니다.
				 	   </p>`
			}
			
			document.querySelector(".schoolSchedule").innerHTML = str;
		}
	});
}

// 자료실
const getDataRoomList = function(){
	let sendData = {"schulCode":'${SCHOOL_INFO.schulCode}',
					"currentPage":"1"};
	
	$.ajax({
		url:"/school/dataRoomAjax",
		data:JSON.stringify(sendData),
		contentType:"application/json; charset=utf-8",
		method:"post",
		dataType:"json",
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success:function(res){
// 			console.log("getDataRoomList() res:",res);
			
			let str ="";
			let schulCode = "${SCHOOL_INFO.schulCode}";
			
			res.content.forEach(function(con){
				str += `<tr class ="d-tr" onclick ="location.href ='/school/dataRoomDetail?schulCode=\${schulCode}&nttCode=\${con.nttCode}'">
						<td style ="padding-left: 30px;">\${dateFormat(con.nttWritngDt)}</td>
						<td>\${cutStr(con.nttNm,27)}</td>
						</tr>`;
			})
			
			if(str == ""){
				str =`<tr>
					  <td colspan = "100%" style ="text-align:center;">
				 	    등록된 게시물이 없습니다.
				 	  </td>
				 	  </tr>`
			}
			
			document.querySelector("#dataRoomTb tbody").innerHTML = str;
		}
	});
}

// 교육부
const getEduInfo = function(){
	var data = {
		"keyword":"",
		"currentPage":1,
		"size":10
	}

	$.ajax({
        url: "/school/edcInfoListAjax",
        type: "post",
        data: JSON.stringify(data),
        contentType: "application/json;charset=utf-8",
        dataType: "json",
        beforeSend: function(xhr) {
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
        },
        success: function(res) {
        	str ="";
        	
//         	console.log("getEduInfo res:",res);
        	
        	res.content.forEach(function(con){
				str += `<tr class ="d-tr" onclick ="window.open('\${con.edcInfoNttUrl}'), '_blank'">
						<td style ="padding-left: 30px;">\${con.edcInfoNttWritngDt}</td>
						<td>\${cutStr(con.edcInfoNttNm, 40)}</td>
						</tr>`;
        	})
			
			if(str == ""){
				str =`<tr>
					  <td colspan = "100%" style ="text-align:center;">
				 	    등록된 게시물이 없습니다.
				 	  </td>
				 	  </tr>`
			}

        	document.querySelector("#eduInfoTb tbody").innerHTML = str;
        } // fn.ajax.success
	}); // fn.ajax
} // fn

// 클릭한 학급클래스 입장
const enterClass = function(clasCode, childId){
	document.querySelector("#mainClasCode").value=clasCode;
	if(childId != null){
		document.querySelector("#mainChildId").value=childId;
	}
	document.querySelector("#mainGoToClassForm").submit();
}


// 지도 api
const initMap = function(){
	let schNm = "${SCHOOL_INFO.schulNm}";
	let y = 36.450701;
	let x = 127.270667;
	
	$.ajax({
		url:"https://dapi.kakao.com/v2/local/search/keyword.json",
		contentType:"application/json; charset=UTF-8;",
		data:{"query":schNm},
		headers: {"Authorization":"KakaoAK ed3b8c773b19e104fc3ab5f2ce2e548c"},
		method:"get",
		dataType:"json",
		async:false,
		success:function(res){
// 			console.log("initMap res:",res);
			
			res.documents.forEach(function(item){
				if(item.place_name == schNm){
					x = item.x;
					y = item.y;
					return false;
				}
			})
		}
	})
	
	var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
	var options = { //지도를 생성할 때 필요한 기본 옵션
		center: new kakao.maps.LatLng(y, x), //지도의 중심좌표.
		level: 4 //지도의 레벨(확대, 축소 정도)
	};

	var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
	
	var marker = new kakao.maps.Marker({ 
	    // 지도 중심좌표에 마커를 생성합니다 
	    position: map.getCenter() 
	}); 
	// 지도에 마커를 표시합니다
	marker.setMap(map);
	
	var iwContent = '<div style="width:150px; text-align :center; padding:5px 0px; margin:auto; font-size:1.1rem;"><a href="https://map.kakao.com/link/map/${SCHOOL_INFO.schulNm},'+y+','+x+'" target="_blank">${SCHOOL_INFO.schulNm}</a></div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
    iwPosition = new kakao.maps.LatLng(33.450701, 126.570667); //인포윈도우 표시 위치입니다

	// 인포윈도우를 생성합니다
	var infowindow = new kakao.maps.InfoWindow({
	    position : iwPosition, 
	    content : iwContent 
	});
	  
	// 마커 위에 인포윈도우를 표시합니다. 두번째 파라미터인 marker를 넣어주지 않으면 지도 위에 표시됩니다
	infowindow.open(map, marker); 
}

window.onload = function(){
	var password = "${USER_INFO.password}";
	
// 	<sec:authorize access = "hasAnyRole('A01001', 'A01002')">
// 	// 최초 로그인시 비밀번호 변경 요구
// 	$.ajax({
// 		url: "/firstLoginAt",
// 		type: "get",
// 		data: {password:password},
// 		dataType: "text",
// 		beforeSend:function(xhr){
// 			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
// 		},
// 		success:function(res){
// 			if(res === "true") passwordChange();
// 		}
// 	});
// 	</sec:authorize>
	
	getMeals(); 				// 급식 정보
	<sec:authorize access="hasAnyRole('A01001','A01003','A14002')">
	getClassList(); 			// 가입한 학교 목록
	</sec:authorize>
	<sec:authorize access="hasAnyRole('A14001','A14003','A14004','A14005')">
	getEmpList();				// 교직원 목록
	</sec:authorize>
	getSchoolScheduleList(); 	// 학사일정 목록
	getDataRoomList(); 			// 자료실 목록
	getEduInfo(); 				// 교육부
	initMap(); 					// 지도 api
	schoolInfoModalInit(); 		// 학교 정보 모달 초기화
}

$(function(){
	$(".schoolcal-box").on("click",function(){
		location.href="/school/schafsSchedul";
	});
	$(".document-box").on("click",function(){
		location.href="/school/dataRoom?schulCode=${SCHOOL_INFO.schulCode}";
	});
	$(".after-box").on("click",function(){
		location.href="/afterSchool?schulCode=${SCHOOL_INFO.schulCode}";
	});
});
</script>

<form id="mainGoToClassForm" action="/class/classMain" method="post">
	<input type="hidden" id="mainClasCode" name="clasCode" value="">
	<input type="hidden" id="mainChildId" name="childId" value="">
	<sec:csrfInput />
</form>

<div id="schoolMain" class="main-page">
	<div class="hor-div" style="height: 100px">
		<div class="box header-box" style="display: flex; align-items: center; justify-content: center; padding-top: 0px; padding-bottom: 0px; background: #78b0ff;">
			<h1 class="" style="margin: auto 0px; color: #fff; letter-spacing: 1px;" onclick="schoolInfoBtn()">${SCHOOL_INFO.schulNm}</h1>
			<img class="schoolIcon" src="/resources/images/school/school003.png" style="margin-left: 7px;">
		</div>
	</div>
	
	<div class="hor-div" style="height: 350px">
		<sec:authorize access="hasAnyRole('A01001','A01003','A14002')">
		<div class="box" style="width: 33%; position: relative;">
			<!-- 			<img src ="/resources/images/school/school001.png" style ="position: absolute; bottom:15px; right: 30px; z-index: 5; width:250px; height:250px; opacity:0.1;margin:auto 0px;"> -->
			<div class="headComment">
				<h3 style="order: 10;">가입한 반</h3>
			</div>
	        <div id ="clsContainer" style ="order: 10; ">
	           <div class="cl" style="align-content: center; text-align: center;">
	              <div class ="clasBtn" >
	                 <img id="classIcon" src="/resources/images/classRoom/plus_gray.png" alt="" onclick ="location.href ='/class/classList'" style="padding: 23px;">
	              </div>
	              <p style="text-align: center;">반 가입하기</p>
	           </div>
	        </div>
		</div>
		</sec:authorize>
		
		<sec:authorize access="hasAnyRole('A14001','A14003','A14004','A14005')">
		<div class="tb-box" style="width: 33%;">
			<div class="head-div" style="margin: 15px 15px 0px 15px;">
				<div class="headComment">
					<h3>교직원 목록</h3>
				</div>
			</div>
			<div class="con" style="padding: 0px;">
				<div class="product-status-wrap"
					style="position: relative; padding: 0px;">
					<div class="asset-inner">
						<table id="empListTb">
							<thead>
								<tr>
									<th style="padding-left: 30px;">교직원 명</th>
									<th>교직원 이메일</th>
									<th>교직원 구분</th>
								</tr>
							</thead>
							<tbody>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
		</sec:authorize>
		
		<div style="width: 44%; display: flex; margin: 0px 12px;">
			<div class="box" style="width: 50%; margin-left: 0px;">
				<div class="headComment">
					<h3 style="order: 10;">급식</h3>
				</div>
				<div class="inner-box2" style="background-color: #e6f2ff; height: 88%;">
						<!-- 						<a class="follow-cards" href="#" -->
						<!-- 							id="goToTaskList">➤바로 가기</a> -->
					<div class="ver-div" style="height: 100%;">
						<div class="subHeadComment">오늘</div>
						<div class="inner-box" style="height: 38%;">
							<div id="todayMeal" class="con">
								<p class='noData'>등록된 급식 정보가 없습니다.</p>
							</div>
						</div>
						<div class="subHeadComment" style="margin-top: 9px;">내일</div>
						<div class="inner-box" style="height: 38%;">
							<div id="tomorrowMeal" class="con">
								<p class='noData'>등록된 급식 정보가 없습니다.</p>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="box" style="width: 50%; margin-right: 0px;">
				<div class="headComment">
					<h3>학사 일정</h3>
				</div>
				<div id="schoolScheduleContainer" style="height: 89%;">
					<div class="inner-box2 schoolSchedule" style='background: #e2ffeb; height: 100%'>
						<div id="schoolSchedule" class="con inner-box" style="height: 100%">
							<p>
								[2024-04-04]<br> 운동회운동회운동회운동회
							</p>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="box" style="width: 22%;">
			<div class="headComment" style="font-size: 1.3rem;">
				<h3>빠른 메뉴</h3>
			</div>
			<ul class="quick-menu-container">
				<li class="first-box">
					<ul class="ul-content">
						<li class="food-box">
							<img src="/resources/images/school/quick_food.png" class="quick-icon-box">
							<span class="quick-tit">급식</span>
							<small class="back-ground-obj fod"></small>
							<small class="back-ground-obj2 fod"></small>
						</li>
						<li class="schoolcal-box" style="margin-right:0px;">
							<img src="/resources/images/school/quick_cal.png" class="quick-icon-box" style="width: 35px; height: auto;margin-top: 15px;">
							<span class="quick-tit">학사일정</span>
							<small class="back-ground-obj cal"></small>
							<small class="back-ground-obj2 cal"></small>
						</li>
					</ul>
				</li>
				<li class="second-box">
					<ul class="ul-content">
						<li class="document-box">
							<img src="/resources/images/school/quick_document.png" class="quick-icon-box" style="width:40px;">
							<span class="quick-tit" style="margin-top:10px;">자료실</span>
							<small class="back-ground-obj doc"></small>
							<small class="back-ground-obj2 doc"></small>
						</li>
						<li class="after-box" style="margin-right:0px;">
							<img src="/resources/images/school/quick_aft.png" class="quick-icon-box" style="width:40px;">
							<span class="quick-tit">방과후학교</span>
							<small class="back-ground-obj aft"></small>
							<small class="back-ground-obj2 aft"></small>
						</li>
					</ul>
				</li>
			</ul>
		</div>
	</div>
	<div class="hor-div" style="height: 350px">
		<div class="tb-box" style="width: 33%;">
			<div class="head-div" style="margin: 15px 15px 0px 15px;">
				<div class="headComment">
					<h3>자료실</h3>
				</div>
				<!-- 				<a class="follow-cards" href="/school/dataRoom" -->
				<!-- 					id="">➤바로 가기</a> -->
			</div>
			<div class="con" style="padding: 0px;">
				<div class="product-status-wrap"
					style="position: relative; padding: 0px;">
					<div class="asset-inner">
						<table id="dataRoomTb">
							<thead>
								<tr>
									<th style="padding-left: 30px;">날짜</th>
									<th>제목</th>
								</tr>
							</thead>
							<tbody>
							</tbody>
						</table>
					</div>
				</div>
			</div>

		</div>
		<div class="tb-box" style="width: 44%; overflow: hidden;">
			<div class="head-div" style="margin: 15px 15px 0px 15px;">
				<div class="headComment">
					<h3>교육부 소식</h3>
				</div>
				<!-- 				<a class="follow-cards" href="/school/eduInfo" -->
				<!-- 					id="goToTaskList">➤바로 가기</a> -->
			</div>
			<div class="con" style="padding: 0px;">
				<div class="product-status-wrap"
					style="position: relative; padding: 0px;">
					<div class="asset-inner">
						<table id="eduInfoTb">
							<thead>
								<tr>
									<th style="padding-left: 30px;">날짜</th>
									<th>제목</th>
								</tr>
							</thead>
							<tbody>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
		<div class="box" style="width: 22%;">
			<div class="headComment">
				<h3>학교 위치</h3>
			</div>
			<div class="inner-box2" style="background-color: #F4E6FF; height: 89%;">
				<div id="map" style="width: 100%; border-radius: 20px; box-shadow: 0px 0px 15px 1px #00000018"></div>
			</div>
		</div>
	</div>
	<div style="height: 80px"></div>
</div>

<!-- 학교 정보 modal -->
<div id="schoolInfoModal"
	class="modal modal-edu-general default-popup-PrimaryModal fade"
	role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header header-color-modal bg-color-1">
				<table class="modal-title">
					<tr>
						<td class="tableT"><img
							src="/resources/images/school/schoolImg.png" style="width: 50px;"></td>
						<td><h2 id="" class="modal-title" value="">초등학교 정보</h2></td>
					</tr>
				</table>
				<div class="modal-close-area modal-close-df">
					<a class="close" data-dismiss="modal" href="#"><i
						class="fa fa-close"></i></a>
				</div>
			</div>
			<div class="modal-body-school">
				<div id="modal-body-line">
					<h2 id="infoSchulNm"></h2>
					<table class="schoolInfoAll">
						<tr>
							<td class="tableM"><span>학교 주소</span></td>
							<td><span id="infoSchulAdres"></span></td>
						</tr>
						<tr>
							<td class="tableM"><span>학교 전화번호</span></td>
							<td><span id="infoSchulTlphonNo"></span></td>
						</tr>
						<tr>
							<td class="tableM"><span>학교 설립 날짜</span></td>
							<td><span id="infoSchulAnnvrsry"></span></td>
						</tr>
					</table>
				</div>
			</div>
			<div class="modal-footer">
				<a data-dismiss="modal" href="#">닫기</a>
			</div>
		</div>
	</div>
</div>

<!-- 최초 로그인 시 비밀번호 변경 모달 -->
<div id="UpdatePasswordModal"
	class="modal modal-edu-general default-popup-PrimaryModal fade"
	role="dialog" style="align-content: center;">

	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-close-area modal-close-df">
				<a class="close" data-dismiss="modal" href="#"> <i
					class="fa fa-close"></i></a>
			</div>
			<div class="modal-body" style="padding: 50px 70px 25px 70px;">
				<div>
					<h2>비밀번호 변경</h2>
					<span style="display: none;">*최초 1회 비밀번호 변경이 필요합니다.</span>
				</div>
				<br>
				<div id="firstPwChk" class="alert alert-danger alert-mg-b"
					role="alert" style="display: none;"></div>
				<div id="UpdatePasswordContainer">
					<ul class="InputPassword">
						<li><span>비밀번호</span> <input type="password" id="password1"
							class="form-control"> <small data-chk="dataChk">특수기호/영문가능</small>
						</li>
						<br>
						<li><span>비밀번호 확인</span> <input type="password"
							id="password2" class="form-control"> <small
							data-chk="dataChk">동일한 비밀번호를 입력해주세요</small></li>
					</ul>
				</div>
			</div>
			<div class="modal-footer"
				style="text-align: center; margin-bottom: 20px;">
				<a id="UpdatePasswordBtn" href="#">확인</a>
				<!--             <a data-dismiss="modal" href="#">취소</a> -->
			</div>
		</div>
	</div>
</div>
