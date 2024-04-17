<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script type="text/javascript">
//beforeSend 전역변수 처리
const header="${_csrf.headerName}";
const token ="${_csrf.token}";

window.onload = function(){
	console.log("실행되었습니다~ ")
	
	//날짜 포맷 생성  함수
	function dateFormat(date) {
		let dateFormat2 = date.getFullYear() +
		'-' + ( (date.getMonth()+1) < 9 ? "0" + (date.getMonth()+1) : (date.getMonth()+1) )+
		'-' + ( (date.getDate()) < 9 ? "0" + (date.getDate()) : (date.getDate()) );
		return dateFormat2;
	}
	
	var mberId = "${CLASS_STD_INFO.mberId}";
	console.log("mberId : ",mberId);
	// 학생이 수강신청한 방과후학교 목록 불러오는 ajax
	let data = {
		"mberId" : mberId	
	};
	
	$.ajax({
		url: "/afterSchool/afterSchoolLectureList",
		contentType: "application/json ; charset=utf-8",
		data: data,
		type: "get",
		dataType: "json",
		beforeSend : function(xhr){
			xhr.setRequestHeader(header, token);
		},
		success:function(result){
			console.log("result : ", result);
			let str = "";
			result.forEach(function(aschaVO, idx){
				let aschaAtnlcBgnde = dateFormat(new Date(aschaVO.aschaAtnlcBgnde));
				let aschaAtnlcEndde = dateFormat(new Date(aschaVO.aschaAtnlcEndde));
				
				str += `
					<tr data-code="code" data-ascha-code=\${aschaVO.aschaCode}>
					<td>\${idx+1}</td>
					<td data-ascha-code=\${aschaVO.aschaCode}>\${aschaVO.aschaNm}</td>
					<td>\${aschaVO.aschaAceptncPsncpa}</td>
					<td>\${aschaAtnlcBgnde}</td>
					<td>\${aschaAtnlcEndde}</td>
					<td>\${aschaVO.mberNm}</td>
					<td>`;					
				if (aschaVO.cmmnAtnlcNm==='종강'){
					str += `<label style="background: #df3c3c; padding: 5px 20px;
					    border-radius: 10px; color: white; font-size: 15px;">종강</label>`;
				}else if(aschaVO.cmmnAtnlcNm==='수업 진행중'){
					str += `<label style="background: #ffd34f; padding: 5px 8px;
					    border-radius: 10px; color: white; font-size: 15px;">수업 진행중</label>`;
				}else if(aschaVO.cmmnAtnlcNm==='신청 진행중'){
					str += `<label style="background: #1F81FF; padding: 5px 8px;
					    border-radius: 10px; color: white; font-size: 15px;">신청 진행중</label>`;
				}else{
					str += `<label style="background: #262626; padding: 5px 20px;
					    border-radius: 10px; color: white; font-size: 15px;">폐강</label>`;
				}
					str +=`	
						</td><td>`;
				if(aschaVO.stdntState==='종강'){
					str += `<label style="background: #df3c3c; padding: 5px 20px;
    				    border-radius: 10px; color: white; font-size: 15px;">종강</label>`;
				}else if(aschaVO.stdntState==='수업 진행중'){
					str += `<label class="btnLetureStart" style="background: #ffd34f; padding: 5px 8px;
    				    border-radius: 10px; color: white; font-size: 15px;">수업 진행중</label>`;
				}else if(aschaVO.stdntState==='결제 완료'){
                    str += `<label class="btnPayDone" style="background: #1F81FF; padding: 5px 8px;
    				    border-radius: 10px; color: white; font-size: 15px;">결제 완료</label>`;
                 }else if(aschaVO.stdntState==='결제 대기'){
                    str += `<label class="btnPayWait" style="background: #dfdfdf; padding: 5px 8px;
    				    border-radius: 10px; color: white; font-size: 15px;">결제 대기</label>`;
                 }else{
                    str += `<label style="background: #262626; padding: 5px 20px;
    				    border-radius: 10px; color: white; font-size: 15px;">취소</label>`;
                 }
					str +=`
                    	</td>
                    	</tr>`;
			});
			console.log("str : ", str);
			document.querySelector("#stdntListBody").innerHTML = str;
			
		}
	});
	
	// 클릭시 출석부 리스트 출력.
	$(document).on("click",'tr[data-code="code"]',function(){
		var aschaCode = this.getAttribute("data-ascha-code");
		var stdntId = "${CLASS_STD_INFO.mberId}";
		
		let data = {
			"aschaCode": aschaCode,
			"stdntId": stdntId
		}
		console.log(data);
		
		$.ajax({
			url:"/afterSchool/studAttendanceList",
			 contentType : "application/json;charset=utf-8",
	         data: JSON.stringify(data),
	         type: "post",
	         dataType: "json",   
	         beforeSend: function(xhr){
	            xhr.setRequestHeader(header, token);
	         },
	         success:function(result){
	        	 console.log("result : ", result);
	        	 
	        	 let tblStr ="";
	        	 if(result.length===0){
	        		tblStr = `<tr><td colspan='4' style="text-align: center;">출결기록이 없습니다.</tr>`
	        			lectureStudentListBody.innerHTML = tblStr;
	        	 }else{
	        		 $.each(result[0].aschaDclzVOList, function(idx,aschaDclzVO){
	        			 let aschaAtendDe = dateFormat(new Date(aschaDclzVO.aschaAtendDe));
	        			 tblStr +=`
	        			 	<tr>
	        			 		<td>\${idx+1}</td>
	        			 		<td>\${aschaAtendDe}</td>
	        			 		<td>\${aschaDclzVO.aschaNm}</td>
	        			 		<td>\${aschaDclzVO.stdntState}</td>
	        			 	</tr>`;
	        		 });
	        		 console.log("tblStr :",tblStr);
	        		 document.querySelector("#lectureStudentListBody").innerHTML= tblStr;
	        	 }
	         }
		});
	});
	
	// 결제 대기상태 결제 하기
	document.querySelector("#btnPayWait").addEventListener("click", function(){
		
	});
	
}


</script>

<style>
#AfterSchoolContainer h3 {
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

#AfterSchoolContainer h2 {
	font-size: 1.5rem;
	text-align: center;
	backdrop-filter: blur(4px);
	background-color: rgba(255, 255, 255, 1);
	border-radius: 50px;
	box-shadow: 35px 35px 68px 0px rgba(145, 192, 255, 0.5), inset -8px -8px
		16px 0px rgba(145, 192, 255, 0.6), inset 0px 11px 28px 0px
		rgb(255, 255, 255);
	width: 250px;
	padding-top: 35px;
	padding-bottom: 35px;
	margin: auto;
	margin-bottom: 40px;
}

#AfterSchoolContainer {
	min-height: 790px;
}

#AfterSchoolContainer .custom-pagination {
	max-width: 302px;
	margin: auto;
}

#AfterSchoolContainer .custom-pagination .pagination {
	width: max-content;
}

.content {
	display: flex;
	justify-content: center;
	align-items: center;
}

.single-product-text {
	padding: 5px;
}

.overflow-scroll {
	height: 650px;
	overflow-y: auto; /* 세로 스크롤 설정 */
}

.class-container {
	width: 800px;
	margin: 8px;
	height: 820px;
	background-color: #ffffff;
	padding: 15px;
	border-radius: 10px;
	margin: 5px;
	box-shadow: 0px 0px 10px 3px #0c4c9c20, inset 0px 0px 10px 2px #ffffffc0;
}

.btn {
	height: 35px;
	width: 90px;
}

button.pd-setting.btnUpdate {
	background: #df3c3c;
}

.btnPayDone {
	color: #fff;
	background-color: #96DB5B;
	border-color: #96DB5B;
}

td {
	text-align: center;
}

.btn-zone {
	margin: auto;
	text-align: center;
}

#btnList, #addAfterSchool {
	display: inline-block;
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
	margin-right: 15px;
}

#btnList:hover, #addAfterSchool:hover {
	background: #ffd77a;
	transition: all 1s ease;
	color: #333;
	font-weight: 600;
}

#btnList, #addAfterSchool {
	display: inline-block;
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
	margin-right: 15px;
}

#addAfterSchool {
	background: #006DF0;
	color: #fff;
}

#addAfterSchool:hover {
	background: #ffd77a;
	transition: all 1s ease;
	color: #333;
	font-weight: 600;
}

#shTbl th {
	text-align: center;
	font-size: 17px;
	color: white;
	background-color: rgba(0, 109, 240, 0.8);
}

#shTbl td, #shTbl tr {
	text-align: center;
	height: 40px;
	width: 110px;
	font-size: 17px;
}
</style>
<div id="AfterSchoolContainer">
	<div class="analytics-sparkle-area">
		<h3>
			<img src="/resources/images/school/aftSchool/aftSchoolIcon1.png"
				style="width: 50px; display: inline-block; vertical-align: middel;">
			<span id="schoolNm"></span> <span>&nbsp;방과후학교 관리</span> <img
				src="/resources/images/school/aftSchool/aftSchoolIcon2.png"
				style="width: 50px; display: inline-block; vertical-align: middel;">
		</h3>

		<div class="container-fluid ">
			<div class="content">
				<div class="class-container">
					<div class="courses-title">
						<h2>방과후 신청 목록</h2>
						<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12"
							style="padding: 0px;">
							<div class="product-status-wrap drp-lst overflow-scroll"
								style="padding: 0px;">
								<table class="table table-hover JColResizer">
									<thead>
										<tr>
											<th>순번</th>
											<th>방과후학교 명</th>
											<th>수용정원(명)</th>
											<th>수강시작일자</th>
											<th>수강종료일자</th>
											<th>담당 선생님</th>
											<th>운영상태</th>
											<th>학생상태</th>
										</tr>
									</thead>
									<tbody id="stdntListBody">
										<!-- 여기에 테이블 내용 추가 -->
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>


				<!-- 수강신청한 학생목록 띄우기 -->
				<div class="class-container">
					<div
						class="courses-inner res-mg-t-30 table-mg-t-pro-n tb-sm-res-d-n dk-res-t-d-n">
						<div class="courses-title">
							<div>
								<h2>출결 현황</h2>
							</div>
							<div style="padding: 0px;transform: translate(10px, -30px);">
								<div class="product-status-wrap drp-lst overflow-scroll"
									style="padding: 0px;">
									<table>
										<thead>
											<tr>
												<th style="width: 10%;" tabindex="0">순번</th>
												<th style="width: 30%;" tabindex="0">출석 날짜</th>
												<th style="width: 30%;" tabindex="0">방과후학교명</th>
												<th style="width: 30%;" tabindex="0">출석상태</th>
											</tr>
										</thead>
										<tbody id="lectureStudentListBody">
										<tr><td colspan='4' style="text-align: center;">과목을 선택해주세요.</td></tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>