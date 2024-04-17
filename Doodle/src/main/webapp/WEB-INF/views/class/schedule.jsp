<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
	//beforeSend 전역변수 처리
	const header = "${_csrf.headerName}";
	const token = "${_csrf.token}";

	let tbody;

	window.onload = function() {
		// 시간표 등록 버튼 클릭시 생성화면으로 이동하기
		if("${USER_INFO.vwMemberAuthVOList[0].cmmnDetailCode}" == 'ROLE_A14002'){
			console.log("체크",document.querySelector("#addSchedule"));
			document.querySelector("#addSchedule").addEventListener("click", function(){
				location.href = "/class/scheduleCreate?clasCode="+"${CLASS_INFO.clasCode}";
			});
		
			// 시간표 수정 버튼 클릭시 수정화면으로 이동하기
			document.querySelector("#updateSchedule").addEventListener("click", function(){
				location.href = "/class/scheduleUpdate?clasCode="+"${CLASS_INFO.clasCode}";
			});
		}
		
		tbody = document.querySelector("#listBody");
		
		// 시간표 목록
		const scheduleList = function() {
			let clasCode = "${CLASS_INFO.clasCode}";
			let semstr = "";
			
			let data = {
				"clasCode" : clasCode,
				"semstr" : $("#semstr").val()
			};

			console.log("data : ", data);

			// 시간표 목록 가져오는 ajax
			$.ajax({
				 url: "/class/scheduleList",
				    contentType: "application/json;charset=utf-8",
				    data: JSON.stringify(data),
				    type: "post",
				    dataType: "json",
				    beforeSend: function(xhr) {
				        xhr.setRequestHeader(header, token);
				    },
				    success: function(result) {
				        console.log("result : ", result);
				        let tbodyStr ="";
				        
				        if(result.length ===0){
				        	// 로그인한 사람이 교사일때 시간표 생성 화면으로 이동.
				        	if("${USER_INFO.vwMemberAuthVOList[0].cmmnDetailCode}" == 'ROLE_A14002'){
					        	Swal.fire(
										"시간표가 생성되지 않았습니다.",
										"시간표 생성 페이지로 이동합니다.",
										"info"
					          ).then(function(){
							        // create로 이동
					        	  	location.href = "/class/scheduleCreate?clasCode="+"${CLASS_INFO.clasCode}";
					          });
				        	}
				        	
				        }else{
							for(let i=1; i<=6; i++){
								tbodyStr += `<tr><td>\${i}교시</td><td></td><td></td><td></td><td></td><td></td></tr>`;
							}
							tbody.innerHTML = tbodyStr;
							let trs = tbody.querySelectorAll("tr");
							
							const weekday = {
								"월":1,
								"화":2,
								"수":3,
								"목":4,
								"금":5,
							}
	
							for(let i=0; i<result.length;i++){
								let skedVO = result[i];
								console.log("skedVO:",skedVO)
								trs[skedVO.period-1].children[weekday[skedVO.cmmnDayNm]].innerHTML = skedVO.cmmnSbject;
	
	
								/*  이력서, 자기소개소 
								if(skedVO.cmmnDayNm == "월"){
										console.log("월", skedVO.cmmnSbject);
										trs[skedVO.period-1].children[1].innerHTML = skedVO.cmmnSbject;
								}
								if(skedVO.cmmnDayNm == "화"){
									console.log("화", skedVO.cmmnSbject);
										trs[skedVO.period-1].children[2].innerHTML = skedVO.cmmnSbject;
								}
								if(skedVO.cmmnDayNm == "수"){
									console.log("수", skedVO.cmmnSbject);
										trs[skedVO.period-1].children[3].innerHTML = skedVO.cmmnSbject;
								}
								if(skedVO.cmmnDayNm == "목"){
									console.log("목", skedVO.cmmnSbject);
										trs[skedVO.period-1].children[4].innerHTML = skedVO.cmmnSbject;
								}
								if(skedVO.cmmnDayNm == "금"){
									console.log("금", skedVO.cmmnSbject);
										trs[skedVO.period-1].children[5].innerHTML = skedVO.cmmnSbject;
								}
								*/
							}
				        }
	
	
							// tbody에 맹글깅!
						
				        	/* 요일별로 데이터 묶기
				        	const groupDay ={};
				        	result.forEach(function(skedVO,idx){
								if(!groupDay[skedVO.cmmnDayNm]){
									groupDay[skedVO.cmmnDayNm] = [];
								}
								groupDay[skedVO.cmmnDayNm].push(skedVO);
					        });		
				        	console.log("groupDay :",groupDay);
							*/
	
					        /* 시간표 출력
							let trs = tbody.querySelectorAll("tr");
					        let str = "";
					        Object.keys(groupDay).forEach(function(day){
								console.log("day: ", day);
					        	for (let i = 0; i < groupDay[day].length; i++) {
					        	    const skedVO = groupDay[day][i];
									if(skedVO.cmmnDaynm == "월"){
										trs[i].children[1].innerHTML = skedVO.cmmnSubject;
									}
									if(skedVO.cmmnDaynm == "화"){
										trs[i].children[2].innerHTML = skedVO.cmmnSubject;
									}
									if(skedVO.cmmnDaynm == "수"){
										trs[i].children[3].innerHTML = skedVO.cmmnSubject;
									}
									if(skedVO.cmmnDaynm == "목"){
										trs[i].children[4].innerHTML = skedVO.cmmnSubject;
									}
									if(skedVO.cmmnDaynm == "금"){
										trs[i].children[5].innerHTML = skedVO.cmmnSubject;
									}
					        	};
					        	
					        });
							*/
					       // console.log("str : ",str);
					       // document.querySelector("#listBody").innerHTML = str;
				    }
				});

		}
		
		// 학기 선택
		const selectSemstr = function() {

			var semstr = document.querySelector("#semstr").value;
			console.log("selectSemstr:",semstr);
			// 학기 선택후 목록 다시 불러옴.
			scheduleList();
		}
		selectSemstr();
		document.querySelector("#semstr").addEventListener("change",selectSemstr);
	}
	
</script>
<style>
.pagination {
	display: inline-flex;
	padding-left: 0;
	margin: 20px 0;
	border-radius: 4px;
}

#ScheduleContainer h3 {
	font-size: 2.2rem;
	text-align: center;
	backdrop-filter: blur(4px);
	background-color: rgba(255, 255, 255, 1);
	border-radius: 50px;
	box-shadow: 35px 35px 68px 0px rgba(145, 192, 255, 0.5), inset -8px -8px
		16px 0px rgba(145, 192, 255, 0.6), inset 0px 11px 28px 0px
		rgb(255, 255, 255);
	width: 650px;
	padding-top: 35px;
	padding-bottom: 35px;
	margin: auto;
	margin-bottom: 40px;
}

#ScheduleContainer {
	min-height: 790px;
}

#ScheduleContainer .custom-pagination {
	max-width: 302px;
	margin: auto;
}

#ScheduleContainer .custom-pagination .pagination {
	width: max-content;
}

.custom-datatable-overright table tbody tr.none-tr td:hover {
	background: #fff !important;
}

.sparkline13-graph {
	float: right;
}

.searchCondition {
	height: 40px;
	border: 1px solid #ddd;
	border-radius: 5px;
	padding-left: 10px;
}
.fixed-table-body {
    padding: 0 50px;
    text-align: center;
    display: inline-block;
}
th {
    text-align: center;
    height: 50px;
    width: 160PX;
    border: 1px solid #999;
}
td {
    height: 50px;
    width: 160PX;
    border: 1px solid #999;
}
table{
    font-size: 20px;
    border: 2px solid #999;
    margin-bottom: 10px;
}
.btn-zone{
	margin: auto;
	text-align: center;
}
#addSchedule, #updateSchedule{
	display:inline-block;
	text-align: center;
	background: #006DF0;
	padding: 15px 30px;
	font-size: 1rem;
	border: none;
	color: #fff;
	font-weight: 700;
	border-radius: 5px;
	margin-top: 30px;
	margin-bottom: 40px;
	margin-right:15px;
}
#addSchedule{
	background: #006DF0;
	color:#fff;
}

#updateSchedule{
	background: #df3c3c;
	color:#fff;
}

#addSchedule:hover,#updateSchedule:hover{
	background: #ffd77a;
	transition: all 1s ease;
	color:#333;
	font-weight:600;
}
</style>

<div id="ScheduleContainer">
	<div class="container-fluid">
		<div class="row">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="breadcome-list single-page-breadcome">
					<h3>
						<!-- 사진 바꾸기 -->
						<img src="/resources/images/school/aftSchool/aftSchoolIcon1.png"
							style="width: 50px; display: inline-block; vertical-align: middel;">
						<span id="schoolNm"></span> <span>&nbsp;시간표</span> <img
							src="/resources/images/school/aftSchool/aftSchoolIcon2.png"
							style="width: 50px; display: inline-block; vertical-align: middel;">
					</h3>


					<div class="sparkline13-graph">
						<div class="datatable-dashv1-list custom-datatable-overright">
							<div class="fixed-table-toolbar">
								<div class="pull-right search" style="margin-bottom: 20px;transform: translate(-320px, 0px);">
									<!-- 검색 셀렉트 -->
									<select class="form-control searchCondition" id="semstr">
										<option value="1" selected>1학기</option>
										<option value="2">2학기</option>
									</select>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- 시간표 -->

	<div class="fixed-table-container" style="padding-bottom: 0px;text-align: center;" >
		<div class="fixed-table-body" >
			<table>
				<thead>
					<tr style="background-color: #8ebdfa;">
						<th></th>
						<th>월</th>
						<th>화</th>
						<th>수</th>
						<th>목</th>
						<th>금</th>
					</tr>
				</thead>
				<tbody id="listBody">
					<!-- 내용 들어옴 -->
					<tr><td colspan='7'style="text-align: center;">등록된 시간표가 없습니다.</td></tr>
				</tbody>

			</table>
		</div>
		<!-- 선생님 권한 버튼 -->
		<c:if test="${USER_INFO.vwMemberAuthVOList[0].cmmnDetailCode == 'ROLE_A14002'}">
			<div class="btn-zone">
				<button type="button" id="addSchedule">등록</button>
				<button type="button" id = "updateSchedule">수정</button>
			</div>
        </c:if>		
	</div>
</div>
