<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script type="text/javascript">
// beforeSend 전역변수 처리
const header="${_csrf.headerName}";
const token ="${_csrf.token}";

const schulCode = "${param.schulCode}";
const aschaCode = "${param.aschaCode}";

window.onload = function(){
	console.log("방과후학교 수정 실행되었습니다~")
	
	//날짜 포맷 생성  함수
	function dateFormat(date) {
		let dateFormat2 = date.getFullYear() +
		'-' + ( (date.getMonth()+1) < 9 ? "0" + (date.getMonth()+1) : (date.getMonth()+1) )+
		'-' + ( (date.getDate()) < 9 ? "0" + (date.getDate()) : (date.getDate()) );
		return dateFormat2;
	}
	
	document.querySelector("#btnList").addEventListener("click",function(){
		location.href = location.href = "/afterSchool?schulCode="+encodeURIComponent(schulCode);
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
		                    placeholder="주간계획 입력" />
		            </div>						
		        </div>`;
				
				console.log("str:",str);
				
				const temp = document.querySelector("#divWeekAdd").insertAdjacentHTML(
					    "beforeend", // HTML 요소가 삽입되는 위치 선언
					    str // 삽입할 문자열
				);
		
	}); // 방과후학교 주간계획 추가 끝	
	
	// 방과후학교 삭제
	// 삭제 버튼을 눌렀을 때 실행하기
	document.querySelector("#btnDelete").addEventListener("click", function(){
		
		let data = {
			"aschaCode"	: aschaCode	
		}
		
		console.log("data : ", data);
		
		$.ajax({
			url:"/afterSchool/afterSchoolDelete",
			contentType : "application/json; charset=utf-8",
			data:JSON.stringify(data),
			type:"post",
			dataType:"json",
			beforeSend: function(xhr){
				xhr.setRequestHeader(header, token);
			},
			success:function(result){
				console.log("result : ", result);
			    Swal.fire({
			        title: '방과후학교를 삭제하시겠습니까?',
			        text: "삭제 후에 다시 되돌릴 수 없습니다.",
			        icon: 'warning',
			        showCancelButton: true,
			        confirmButtonColor: '#3085d6',
			        cancelButtonColor: '#d33',
			        confirmButtonText: '삭제',
			        cancelButtonText: '취소',
			        reverseButtons: false, // 버튼 순서 거꾸로
			        
			      }).then((result) => {
			        if (result.isConfirmed) {
			          Swal.fire(
			            '방과후학교가 삭제 되었습니다.',
			            '목록으로 이동합니다.',
			            'success'
			          ).then(function(){
							location.href = "/afterSchool?schulCode="+encodeURIComponent(schulCode);
						});
			        }
			     });
			},
			error: function(xhr, status, error){
				Swal.fire({
		            icon: 'error',
		            title: '방과후학교 삭제 중 오류가 발생했습니다',
		            text: '다시 확인해주세요.'
		        });
			}							
		});
	});

	// 방과후학교 수정
	// 수정 버튼을 눌렀을 때 실행하기
	document.querySelector("#btnUpdate").addEventListener("click", function(){
		
		const aschaNm = document.querySelector("#aschaNm").value;	
		const aschaDetailCn = document.querySelector("#aschaDetailCn").value;	
		const aschaAtnlcCt = document.querySelector("#aschaAtnlcCt").value;	
		const aschaAceptncPsncpa = document.querySelector("#aschaAceptncPsncpa").value;	
		const aschaAtnlcBgnde = document.querySelector("#aschaAtnlcBgnde").value;	
		const aschaAtnlcEndde = document.querySelector("#aschaAtnlcEndde").value;	
		
		let formData = new FormData();
		
		formData.append("aschaCode",aschaCode);
		formData.append("schulCode",schulCode);
		formData.append("aschaNm" ,aschaNm);
		formData.append("aschaDetailCn" ,aschaDetailCn);
		formData.append("aschaAtnlcCt" ,aschaAtnlcCt);
		formData.append("aschaAceptncPsncpa" ,aschaAceptncPsncpa);
		formData.append("aschaAtnlcBgnde" ,aschaAtnlcBgnde);
		formData.append("aschaAtnlcEndde" ,aschaAtnlcEndde);
		
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
			url:"/afterSchool/afterSchoolUpdateAjax",
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
			        title: '방과후학교를 수정하시겠습니까?',
			        text: "수정후에는 목록으로 이동합니다.",
			        icon: 'warning',
			        showCancelButton: true,
			        confirmButtonColor: '#3085d6',
			        cancelButtonColor: '#d33',
			        confirmButtonText: '예',
			        cancelButtonText: '아니오',
			        reverseButtons: false, // 버튼 순서 거꾸로
			        
			      }).then((result) => {
			        if (result.isConfirmed) {
			          Swal.fire(
			            '방과후학교가 수정 되었습니다.',
			            '목록으로 이동합니다.',
			            'success'
			          ).then(function(){
							location.href = "/afterSchool?schulCode="+encodeURIComponent(schulCode);
						});
			        }
			     });
			},
			error: function(xhr, status, error){
				Swal.fire({
		            icon: 'error',
		            title: '방과후학교 수정 중 오류가 발생했습니다',
		            text: '다시 확인해주세요.'
		        });
			}
		});
	});
	
	// 수정 할 방과후학교 불러오기
		let data ={
			"schulCode" : schulCode,
			"aschaCode" : aschaCode
		}
		console.log("data: ",data);
		
		$.ajax({
			url: "/afterSchool/afterSchoolDetail",
			contentType: "application/json; charset= utf-8",
			data: JSON.stringify(data),
			type: "post",
			dataType: "json",
			beforeSend: function(xhr){
				xhr.setRequestHeader(header, token);
			},
			success: function(result){
				console.log("result : ", result);
				
				if(result.length>0){
					
					let aschaAtnlcBgnde = dateFormat(new Date(result[0].aschaAtnlcBgnde));
					let aschaAtnlcEndde = dateFormat(new Date(result[0].aschaAtnlcEndde));
					
					document.querySelector("#aschaNm").value = result[0].aschaNm;						// 방과후학교 명
					document.querySelector("#aschaDetailCn").value = result[0].aschaDetailCn;			// 강의 설명
					document.querySelector("#aschaAtnlcCt").value = result[0].aschaAtnlcCt;			// 수강 비용
					document.querySelector("#aschaAceptncPsncpa").value = result[0].aschaAceptncPsncpa;// 수강 정원
					document.querySelector("#aschaAtnlcBgnde").value = aschaAtnlcBgnde;				// 수강 시작 일자
					document.querySelector("#aschaAtnlcEndde").value = aschaAtnlcEndde;				// 수강 종료 일자
					
					let str = "";
					result.forEach(function(aschaVO, idx){
						aschaVO.aschaWeekPlanVOList.forEach(function(aschaWeekPlanVO,index){
							str +=`
								<div>
									<div style="width:10%;float:left;">
										<input type="text" class="form-control aschaWeek"
											name="aschaWeekPlanVOList[\${index}].aschaWeek" id="aschaWeek\${index+1}" value="\${index+1}주" />
									</div>
									<div style="width:90%;float:left;">
										<input type="text" class="form-control aschaWeekPlanCn"
											name="aschaWeekPlanVOList[\${index}].aschaWeekPlanCn" id="aschaWeekPlanCn\${index+1}"
											placeholder="주간계획 입력" value="\${aschaWeekPlanVO.aschaWeekPlanCn}"/>
									</div>						
								</div>`;
						});
						
					});
					console.log("str : ", str);
					document.querySelector("#divWeekAdd").innerHTML = str;
					
					
				}
			}
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
	font-size: 1.2rem;
}

.form-group input {
	border-radius: 10px;
	height: 55px;
	margin: 10px 0;
	font-size: 1.2rem;
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
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="devit-card-custom">
					<div class="form-group">
						<label>방과후학교 명</label> <input type="text" class="form-control"
							id="aschaNm" name="aschaNm">
					</div>
					<div class="form-group">
						<label>강의 설명</label>
						<textarea class="form-control" id="aschaDetailCn"
							name="aschaDetailCn"></textarea>
					</div>
					<div class="form-group">
						<label>수강 비용</label> <input type="number" class="form-control"
							id="aschaAtnlcCt" name="aschaAtnlcCt" value="0"
							placeholder="원 단위로 입력하세요">
					</div>
					<div class="form-group">
						<label>수용 정원</label> <input type="number" class="form-control"
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
						<label for="">주간계획 등록</label>
						<div>
							<button type="button"
								class="btn btn-custon-rounded-two btn-primary weekAdd">추가</button>
							<button type="button"
								class="btn btn-custon-rounded-two btn-danger weekMinus">삭제</button>
						</div>
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
										id="aschaWeekPlanCn1" placeholder="주간계획 입력" />
								</div>
							</div>
						</div>
					</div>

					<div class="btn-zone">
						<!-- 클릭시 alert창 띄우면서 목록으로 돌아가기 -->
						<button type="button" id="btnUpdate"
							class="btn btn-custon-rounded-two btn-primary">수정</button>
						<button type="button" id="btnDelete"
							class="btn btn-custon-rounded-two btn-danger">삭제</button>
						<button type="button" id="btnList"
							class="btn btn-custon-rounded-two btn-default">목록</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
