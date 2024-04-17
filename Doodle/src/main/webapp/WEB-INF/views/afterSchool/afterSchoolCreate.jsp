<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script type="text/javascript">
// beforeSend 전역변수 처리
const header="${_csrf.headerName}";
const token ="${_csrf.token}";
const schulCode = "${param.schulCode}";

window.onload = function(){
	// 자동 등록
	$("#btnAuto").on("click",function(){
		// 방과후학교 명
		$("#aschaNm").val("재미있는 코딩교실");
		// 강의 설명
		$("#aschaDetailCn").val("코딩에 관심 있는 친구들은 모두 참여해보세요 ^^ 놀이로 배우는 코딩교실 입니다~");
		// 수강 비용
		$("#aschaAtnlcCt").val("30000");
		// 수강 정원
		$("#aschaAceptncPsncpa").val("20");
		// 수강 시작일자
		$("#aschaAtnlcBgnde").val("2024-05-01");
		// 수강 종료일자
		$("#aschaAtnlcEndde").val("2024-05-31");
		// 주간 계획
	    let autoData = `
	        <div>
	            <div style="width:10%;float:left;">
	                <input type="text" class="form-control aschaWeek"
	                    name="aschaWeekPlanVOList[0].aschaWeek" id="aschaWeek1" value="1주" />
	            </div>
	            <div style="width:90%;float:left;">
	                <input type="text" class="form-control aschaWeekPlanCn"
	                    name="aschaWeekPlanVOList[0].aschaWeekPlanCn" id="aschaWeekPlanCn1"
	                    placeholder="주간계획 입력" style=" margin-left: 10px;" value="기초 코딩"/>
	            </div>						
	        </div>
	        
	        <div>
		        <div style="width:10%;float:left;">
		            <input type="text" class="form-control aschaWeek"
		                name="aschaWeekPlanVOList[1].aschaWeek" id="aschaWeek2" value="2주" />
		        </div>
		        <div style="width:90%;float:left;">
		            <input type="text" class="form-control aschaWeekPlanCn"
		                name="aschaWeekPlanVOList[1].aschaWeekPlanCn" id="aschaWeekPlanCn2"
		                placeholder="주간계획 입력" style=" margin-left: 10px;" value="게임으로 배우는 코딩1"/>
		        </div>						
	    	</div>
	    	
	        <div>
		        <div style="width:10%;float:left;">
		            <input type="text" class="form-control aschaWeek"
		                name="aschaWeekPlanVOList[2].aschaWeek" id="aschaWeek3" value="3주" />
		        </div>
		        <div style="width:90%;float:left;">
		            <input type="text" class="form-control aschaWeekPlanCn"
		                name="aschaWeekPlanVOList[2].aschaWeekPlanCn" id="aschaWeekPlanCn2"
		                placeholder="주간계획 입력" style=" margin-left: 10px;" value="게임으로 배우는 코딩2"/>
		        </div>						
	    	</div>

	    	<div>
		        <div style="width:10%;float:left;">
		            <input type="text" class="form-control aschaWeek"
		                name="aschaWeekPlanVOList[3].aschaWeek" id="aschaWeek3" value="4주" />
		        </div>
		        <div style="width:90%;float:left;">
		            <input type="text" class="form-control aschaWeekPlanCn"
		                name="aschaWeekPlanVOList[3].aschaWeekPlanCn" id="aschaWeekPlanCn2"
		                placeholder="주간계획 입력" style=" margin-left: 10px;" value="실전 코딩"/>
		        </div>						
	    	</div>`;

		$("#divWeekAdd").html(autoData);
		
	});
	
	
	// 방과후학교 주간계획 삭제
	document.querySelector(".weekMinus").addEventListener("click", function(){
		console.log("계획추가버튼 삭제함");
		
		let len = document.querySelectorAll(".aschaWeek").length;
		console.log("len : " + len);
		
		if(len<2){
			Swal.fire({
			      icon: 'warning',
			      title: '주간계획은 최소 한 개가 있어야 합니다.',
			      text: '다시 시도해주세요.',
			})
		}else{
			// 마지막 요소 삭제
			let temp = document.querySelector("#divWeekAdd");
			temp.removeChild(temp.lastElementChild);
		}
	});	// 주간계획 삭제 끝
	
	
	// 방과후학교 주간계획 추가
	document.querySelector(".weekAdd").addEventListener("click", function(){
		console.log("계획추가버튼 클릭함");
		
		let len = document.querySelectorAll(".aschaWeek").length;
		console.log("len : "+len);
		
		let str = "";
	    str += `
		        <div>
		            <div style="width:10%;float:left;">
		                <input type="text" class="form-control aschaWeek"
		                    name="aschaWeekPlanVOList[\${len}].aschaWeek" id="aschaWeek\${len+1}" value="\${len+1}주" />
		            </div>
		            <div style="width:90%;float:left;">
		                <input type="text" class="form-control aschaWeekPlanCn"
		                    name="aschaWeekPlanVOList[\${len}].aschaWeekPlanCn" id="aschaWeekPlanCn\${len+1}"
		                    placeholder="주간계획 입력" style=" margin-left: 10px;" />
		            </div>						
		        </div>`;
				
				console.log("str:",str);
				
				const temp = document.querySelector("#divWeekAdd").insertAdjacentHTML(
					    "beforeend", // HTML 요소가 삽입되는 위치 선언
					    str // 삽입할 문자열
				);
				
// 				let divWeekAdd = document.getElementById("divWeekAdd");
// 				divWeekAdd.append(str);
				
// 				document.querySelector("#divWeekAdd").append(str);
// 				$("#divWeekAdd").append(str);
		
	}); // 방과후학교 주간계획 추가 끝
	

	
	// 방과후학교 추가하기
	// 등록 버튼 눌렀을 때 실행하기
	document.querySelector("#btnCreate").addEventListener("click",function(){

		const aschaNm = document.querySelector("#aschaNm").value;
		const aschaDetailCn = document.querySelector("#aschaDetailCn").value;
		const aschaAtnlcCt = document.querySelector("#aschaAtnlcCt").value;
		const aschaAceptncPsncpa = document.querySelector("#aschaAceptncPsncpa").value;
		const aschaAtnlcBgnde = document.querySelector("#aschaAtnlcBgnde").value;
		const aschaAtnlcEndde = document.querySelector("#aschaAtnlcEndde").value;
		
		let formData = new FormData();
		
		formData.append("schulCode",schulCode);
		formData.append("aschaNm",aschaNm);
		formData.append("aschaDetailCn",aschaDetailCn);	    
		formData.append("aschaAtnlcCt",aschaAtnlcCt);    
		formData.append("aschaAceptncPsncpa",aschaAceptncPsncpa);	
		formData.append("aschaAtnlcBgnde",aschaAtnlcBgnde);
		formData.append("aschaAtnlcEndde",aschaAtnlcEndde);
		
		
		// 주간 데이터 배열에 넣기
		$(".aschaWeek").each(function(idx,week){
			formData.append("aschaWeekPlanVOList["+idx+"].aschaWeek",$(this).val());			
		});
		
		// 주간계획 데이터 배열에 넣기
		$(".aschaWeekPlanCn").each(function(idx, weekPlan){
			formData.append("aschaWeekPlanVOList["+idx+"].aschaWeekPlanCn",$(this).val());
		});
		
		for(let key of formData.keys()){
			console.log(key, ":", formData.get(key));
		}
		
		$.ajax({
			url: "/afterSchool/afterSchoolCreateAjax",
			processData:false,
			contentType:false,
			data:formData,
			type:"post",
			dataType: "text",
			beforeSend: function(xhr){
				xhr.setRequestHeader(header, token);
			},
			success: function(result){
				Swal.fire({
				      icon: 'success',
				      title: '방과후학교가 등록되었습니다.',
				      text: '목록으로 이동합니다.',
					}).then(function(){
						location.href = "/afterSchool/afterSchoolMain?mberId="+"${USER_INFO.mberId}"+"&schulCode="+"${SCHOOL_INFO.schulCode}";
				});
			}
		});	
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

.btn-primary {
	color: #fff;
	background-color: #006DF0;
	border-color: #005Dd0;
}

.btn-group, .btn-group-vertical {
	position: relative;
	display: inline-block;
	vertical-align: middle;
	margin-top: 4px;
}

.btn-success {
	color: #fff;
	background-color: #FCC25B;
	border-color: #FCC25B;
	/*     border-color: #e1a130; */
}

.btn-success:hover {
	color: #fff;
	background-color: #e1a130;
	border-color: #e1a130;
	transition: 0.8s;
}

.btn-success:active {
	color: #fff;
	background-color: #e1a130;
	border-color: #e1a130;
}

.button-group {
	padding: 40px 0 10px 0;
}

.AfterSchoolAll, .replyContainer {
	width: 1400px;
	margin: auto;
	backdrop-filter: blur(10px);
	background-color: rgba(255, 255, 255, 1);
	border-radius: 50px;
	box-shadow: 0px 35px 68px 0px rgba(145, 192, 255, 0.5), inset 0px -6px
		16px 0px rgba(145, 192, 255, 0.6), inset 0px 11px 28px 0px
		rgb(255, 255, 255);
	padding: 50px 80px;
}

.AfterSchoolAll .free-cont {
	border: 1px solid #ddd;
	border-radius: 10px;
	padding: 10px 20px;
	min-height: 83px;
	margin-top: 50px;
}

.AfterSchoolAll .FreeTit {
	display: flex;
	justify-content: space-between;
	position: relative;
}

.AfterSchoolAll .title {
	font-size: 1.8rem;
	font-weight: 700;
	margin-top: 6px;
}

.btn-zone {
	margin: auto;
	text-align: center;
}

#btnCreate, #btnDeleteAll {
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

#btnDeleteAll {
	background: #111;
	color: #fff;
}

#btnCreate {
	background: #006DF0;
	color: #fff;
}

#btnCreate:hover, #btnDeleteAll:hover {
	background: #ffd77a;
	transition: all 1s ease;
	color: #333;
	font-weight: 600;
}

label {
	font-size: 1.1rem;
}

.form-group input {
	border-radius: 10px;
	height: 50px;
	margin: 10px 0;
	font-size: 1.1rem;
}
</style>
<div id="AfterSchoolContainer">
	<div class="review-content-section">
		<h3>
			<img src="/resources/images/school/aftSchool/aftSchoolIcon1.png"
				style="width: 50px; display: inline-block; vertical-align: middel;">
			<span id="schoolNm"></span> <span>&nbsp;방과후학교 관리</span> <img
				src="/resources/images/school/aftSchool/aftSchoolIcon2.png"
				style="width: 50px; display: inline-block; vertical-align: middel;">
		</h3>
		<div class="AfterSchoolAll"
			style="width: 1400px; margin: auto; margin-bottom: 50px; min-height: 820px; padding: 50px 80px;">
			<div>
				<div class="form-group">
					<label>방과후학교 명</label> <input type="text" class="form-control"
						id="aschaNm" name="aschaNm">
				</div>
				<div class="form-group">
					<label>강의 설명</label>
					<textarea class="form-control" id="aschaDetailCn"
						name="aschaDetailCn" style="border-radius: 10px; font-size: 1.1rem;"></textarea>
				</div>
				<div class="form-group">
					<label>수강 비용</label> <input type="number" class="form-control"
						id="aschaAtnlcCt" name="aschaAtnlcCt" value="0"
						placeholder="원 단위로 입력하세요">
				</div>
				<div class="form-group">
					<label>수강 정원</label> <input type="number" class="form-control"
						id="aschaAceptncPsncpa" name="aschaAceptncPsncpa" value="0"
						placeholder="명 단위로 입력하세요">
				</div>
				<div class="form-group">
					<label>수강 시작 일자</label> <input type="date" class="form-control"
						id="aschaAtnlcBgnde" name="aschaAtnlcBgnde" value="0">
				</div>
				<div class="form-group">
					<label>수강 종료 일자</label> <input type="date" class="form-control"
						id="aschaAtnlcEndde" name="aschaAtnlcEndde" value="0">
				</div>

				<!-- 주간계획 -->
				<div class="form-group">
					<div style="display: inline-flex;">
						<label for="">주간계획 등록</label>
						<div style="margin-left: 32px;">
							<button type="button"
								class="btn btn-custon-rounded-two btn-primary weekAdd">추가</button>
							<button type="button"
								class="btn btn-custon-rounded-two btn-danger weekMinus">삭제</button>
						</div>
					</div>
					<hr>
					<div class="form-group" id="divWeekAdd">
						<div>
							<!-- 주간계획 입력하기 -->
							<div style="width: 10%; float: left;">
								<input type="text" class="form-control aschaWeek"
									name="aschaWeekPlanVOList[0].aschaWeek" id="aschaWeek1"
									value="1주" />
							</div>
							<div style="width: 90%; float: left;">
								<input type="text" class="form-control aschaWeekPlanCn"
									name="aschaWeekPlanVOList[0].aschaWeekPlanCn"
									id="aschaWeekPlanCn1" placeholder="주간계획 입력"
									style="margin-left: 10px;" />
							</div>
						</div>
					</div>
				</div>

				<div class="btn-zone">
				<i class="fa fa-pencil-square-o" id="btnAuto" aria-hidden="true" style="height:25px; width:25px; margin:5px; margin: 20px 10px 0 10px;"></i>
					​​​​​​​​<input type="button" value="등록" id="btnCreate" /> ​​​​​​​​<input
						type="button" value="취소" id="btnDeleteAll" />
				</div>
			</div>
		</div>
	</div>
</div>
