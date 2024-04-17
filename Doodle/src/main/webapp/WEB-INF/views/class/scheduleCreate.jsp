<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
//beforeSend 전역변수 처리
const header="${_csrf.headerName}";
const token ="${_csrf.token}";

window.onload = function(){
	
	document.getElementById("semstr").addEventListener("change", function() {
		
		const clasCode = "${CLASS_INFO.clasCode}";
	    var selectedValue = this.value;
	    console.log("선택된 값: " + selectedValue);

	    let data ={
	    	"clasCode": clasCode,
	    	"semstr": selectedValue 
	    }
	    console.log("data : ",data);
	    
		// 학기 중복 확인
		$.ajax({
			url : "/class/checkScheduleSemstr",
			contentType: "application/json;charset=utf-8",
		    data: JSON.stringify(data),
		    type: "post",
		    dataType: "json",
		    beforeSend: function(xhr) {
		        xhr.setRequestHeader(header, token);
		    },
		    success: function(result){
		    	console.log("result:", result);
		    	if(result===1){
		    		Swal.fire({
		    		    icon: 'warning',
		    		    title: '이미 존재하는 학기 입니다.',
		    		    text: '중복 등록할 수 없습니다.'
		    		}).then(function(){
		    		    $("#insertBtn").prop("disabled", true); // 버튼 비활성화
		    		});
		    	
			    }
		    }
		}) // end ajax
	});
	
	
	
	// 자동 등록
	$("#btnAuto").on("click",function(){
		// 학기 선택
		$("#semstr").val("1");
		
// 	    // 첫 번째 td에 "국어" 값을 설정
// 	    $(".periodList:nth-child(1) #scheduleAdd .selectTr1 select").val("A07001");
	    
// 	    // 두 번째 td에 "영어" 값을 설정
// 	    $(".periodList:nth-child(2) .selectTr select").val("A07002");

// 	    // 세 번째 td에 "수학" 값을 설정
// 	    $(".periodList:nth-child(3) .selectTr select").val("A07003");

// 	    // 네 번째 td에 "과학" 값을 설정
// 	    $(".periodList:nth-child(4) .selectTr select").val("A07004");

// 	    // 다섯 번째 td에 "사회" 값을 설정
// 	    $(".periodList:nth-child(5) .selectTr select").val("A07005");

		// 1교시
		$(".periodList:nth-child(1) .selectTr.1 select").val("A07001");
		$(".periodList:nth-child(1) .selectTr.2 select").val("A07003");
		$(".periodList:nth-child(1) .selectTr.3 select").val("A07005");
		$(".periodList:nth-child(1) .selectTr.4 select").val("A07014");
		$(".periodList:nth-child(1) .selectTr.5 select").val("A07009");

		// 2교시
		$(".periodList:nth-child(2) .selectTr.1 select").val("A07013");
		$(".periodList:nth-child(2) .selectTr.2 select").val("A07012");
		$(".periodList:nth-child(2) .selectTr.3 select").val("A07013");
		$(".periodList:nth-child(2) .selectTr.4 select").val("A07003");
		$(".periodList:nth-child(2) .selectTr.5 select").val("A07010");

		// 3교시
		$(".periodList:nth-child(3) .selectTr.1 select").val("A07014");
		$(".periodList:nth-child(3) .selectTr.2 select").val("A07011");
		$(".periodList:nth-child(3) .selectTr.3 select").val("A07013");
		$(".periodList:nth-child(3) .selectTr.4 select").val("A07001");
		$(".periodList:nth-child(3) .selectTr.5 select").val("A07003");

		// 4교시
		$(".periodList:nth-child(4) .selectTr.1 select").val("A07009");
		$(".periodList:nth-child(4) .selectTr.2 select").val("A07014");
		$(".periodList:nth-child(4) .selectTr.3 select").val("A07009");
		$(".periodList:nth-child(4) .selectTr.4 select").val("A07012");
		$(".periodList:nth-child(4) .selectTr.5 select").val("A07014");
	});
	
	// 시간표 교시 추가하기
	document.querySelector(".scheduleAdd").addEventListener("click", function(){
		
		let len = document.querySelectorAll(".periodList").length;
		console.log("len : "+len);
		let str = "";
		
		if(len>7){
			Swal.fire({
			      icon: 'warning',
			      title: '8교시까지 등록할 수있습니다.',
			      text: '다시 시도해주세요.',
			})		
		}else{
			str +=`
				<tr class ="periodList">
					<th>\${len+1}교시</th>
					<td class = "selectTr 1" data-cmmn-day = "A18001" data-period="\${len+1}"></td>
					<td class = "selectTr 2" data-cmmn-day = "A18002" data-period="\${len+1}"></td>
					<td class = "selectTr 3" data-cmmn-day = "A18003" data-period="\${len+1}"></td>
					<td class = "selectTr 4" data-cmmn-day = "A18004" data-period="\${len+1}"></td>
					<td class = "selectTr 5" data-cmmn-day = "A18005" data-period="\${len+1}"></td>
				</tr>`;
		}
		console.log("str : ",str);
		
		const temp = document.querySelector("#listBody").insertAdjacentHTML(
			    "beforeend", // HTML 요소가 삽입되는 위치 선언
			    str // 삽입할 문자열		
		);
		// select 넣음
		insertSelectEl(); 
			
	}); // 시간표 교시 추가하기 끝
	
	// 시간표 교시 삭제하기
	document.querySelector(".scheduleMinus").addEventListener("click", function(){
		let len = document.querySelectorAll(".periodList").length;
		console.log("len : "+len);
		
		if(len<5){
			Swal.fire({
			      icon: 'warning',
			      title: '최소 4교시 이상 있어야 합니다.',
			      text: '다시 시도해주세요.',
			})			
		}else{
			let temp = document.querySelector("#listBody");
			temp.removeChild(temp.lastElementChild);
		}
	});	// 시간표 교시 삭제하기 끝
	
	const insertSelectEl = function() {
	    var selectElement = `
	        <select class="form-control selectSubject">
	            <option> 선택 </option>										
	            <option value="A07001">	국어			</option>
	            <option value="A07002">	영어         	</option>
	            <option value="A07003">	수학         	</option>
	            <option value="A07004">	과학         	</option>
	            <option value="A07005">	사회        	</option>
	            <option value="A07006">	도덕         	</option>
	            <option value="A07007">	음악         	</option>
	            <option value="A07008">	미술       		</option>
	            <option value="A07009">	체육        	</option>
	            <option value="A07010">	과학/실과   	</option>
	            <option value="A07011">	예술(음악/미술)</option>
	            <option value="A07012">	바른 생활    	</option>
	            <option value="A07013">	슬기로운 생활	</option>
	            <option value="A07014">	즐거운 생활	</option>									
	        </select>`;

	    var selectTrs = document.querySelectorAll(".selectTr");
	    selectTrs.forEach(function(tr) {
	        tr.innerHTML = selectElement;
	    });

	    // 각 select 요소에 id 속성을 추가하여 증가시킴
	    var selectElements = document.querySelectorAll(".selectTr select");
	    selectElements.forEach(function(select, index) {
	        select.setAttribute("id", "subject" + (index + 1));
	    });
	};

	insertSelectEl();
	
	// 시간표 추가하기
	// 등록 버튼 눌렀을 때 실행하기
	document.querySelector("#insertBtn").addEventListener("click",function(){
		
		const semstr = document.querySelector("#semstr").value;
		const clasCode = "${CLASS_INFO.clasCode}";
		
		// let formData = new FormData(); // 파일이 없으면 절대 필요없음!!!!!

		const skedVOList = [];

		// select된 교시, 요일, 과목데이터 배열에 넣기
		$(".selectTr").each(function(idx, subject){
			
			let skedVO = {
				semstr,
				clasCode,
				cmmnDay: $(this).data("cmmn-day"),
				period: $(this).data("period"),
				cmmnSbject:$(this).find(".selectSubject").val()  
			}

			skedVOList.push(skedVO);

		});
		console.log("보내는 값 항상 체크:",skedVOList);
	    console.log(header,token);
		$.ajax({
			type:"post",
			url : "/class/scheduleCreateAjax",
			contentType:"application/json;charset=UTF-8",
			data:JSON.stringify(skedVOList),
			dataType: "json",
			beforeSend: function(xhr){
				xhr.setRequestHeader(header, token);
			},
			success: function(result){
				console.log("항상 돌아온 값 체킁",result);
				Swal.fire({
				      icon: 'success',
				      title: '시간표가 등록되었습니다.',
				      text: '목록으로 이동합니다.',
					}).then(function(){
						location.href = "/class/schedule?clasCode="+encodeURIComponent(clasCode);
				});
			}
		});
	});
}
		


</script>

<style>
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
.ScheduleAll{
	width: 1400px;
	margin: auto;
	backdrop-filter: blur(10px);
	background-color: rgba(255, 255, 255, 1);
	border-radius: 50px;
	box-shadow: 0px 35px 68px 0px rgba(145, 192, 255, 0.5), inset 0px -6px 16px 0px rgba(145, 192, 255, 0.6), inset 0px 11px 28px 0px rgb(255, 255, 255);
	padding: 50px 80px;
}


.ScheduleAll .FreeTit {
	display: flex;
	justify-content: space-between;
	position:relative;
}


.ScheduleAll .title{
	font-size: 1.8rem;
	font-weight: 700;
	margin-top: 6px;
}

#insertBtn{
	display: block;
    margin: auto;
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
}

#insertBtn:hover{
	background: #ffd77a;
	transition: all 1s ease;
	color:#333;
}
</style>

<div id="ScheduleContainer">
	<h3>
		<!-- 사진 바꾸기 -->
		<img src="/resources/images/school/aftSchool/aftSchoolIcon1.png"
			style="width: 50px; display: inline-block; vertical-align: middel;">
		<span id="schoolNm"></span> <span>&nbsp;시간표</span> <img
			src="/resources/images/school/aftSchool/aftSchoolIcon2.png"
			style="width: 50px; display: inline-block; vertical-align: middel;">
	</h3>

	<div class="ScheduleAll"
		style="width: 1400px; margin: auto; margin-bottom: 50px;">
		<div class="free-cont">
			<div>
				<label for="">학기 선택 </label> 
				<select class="form-control searchCondition" id="semstr">
					<option>선택하세요.</option>
					<option value="1">1학기</option>
					<option value="2">2학기</option>
				</select>
			</div>

			<div>
				<label for="">시간표 입력</label>
			</div>
			<div>
				<button id="btnAuto" style="background:white; border:white">
					<i class="fa fa-pencil-square-o" aria-hidden="true" style="height:25px; width:25px; margin:5px; margin: 20px 10px 0 10px;"></i>
				</button>
				<button type="button"
					class="btn btn-custon-rounded-two btn-primary scheduleAdd">추가</button>
				<button type="button"
					class="btn btn-custon-rounded-two btn-danger scheduleMinus">삭제</button>
			</div>

			<div class="fixed-table-body">
				<table id="table" class="table JColResizer">
					<thead>
						<tr>
							<th>*</th>
							<th>월</th>
							<th>화</th>
							<th>수</th>
							<th>목</th>
							<th>금</th>
						</tr>
					</thead>
					<tbody id="listBody">
						<tr class="periodList" id="scheduleAdd">
							<th>1교시</th>
							<td class = "selectTr 1" data-cmmn-day = "A18001" data-period="1"></td>
							<td class = "selectTr 2" data-cmmn-day = "A18002" data-period="1"></td>
							<td class = "selectTr 3" data-cmmn-day = "A18003" data-period="1"></td>
							<td class = "selectTr 4" data-cmmn-day = "A18004" data-period="1"></td>
							<td class = "selectTr 5" data-cmmn-day = "A18005" data-period="1"></td>
						</tr>
						<tr class="periodList">
							<th>2교시</th>
							<td class = "selectTr 1" data-cmmn-day = "A18001" data-period="2"></td>
							<td class = "selectTr 2" data-cmmn-day = "A18002" data-period="2"></td>
							<td class = "selectTr 3" data-cmmn-day = "A18003" data-period="2"></td>
							<td class = "selectTr 4" data-cmmn-day = "A18004" data-period="2"></td>
							<td class = "selectTr 5" data-cmmn-day = "A18005" data-period="2"></td>
						</tr>
						<tr class="periodList">
							<th>3교시</th>
							<td class = "selectTr 1" data-cmmn-day = "A18001" data-period="3"></td>
							<td class = "selectTr 2" data-cmmn-day = "A18002" data-period="3"></td>
							<td class = "selectTr 3" data-cmmn-day = "A18003" data-period="3"></td>
							<td class = "selectTr 4" data-cmmn-day = "A18004" data-period="3"></td>
							<td class = "selectTr 5" data-cmmn-day = "A18005" data-period="3"></td>
						</tr>
						<tr class="periodList">
							<th>4교시</th>
							<td class = "selectTr 1" data-cmmn-day = "A18001" data-period="4"></td>
							<td class = "selectTr 2" data-cmmn-day = "A18002" data-period="4"></td>
							<td class = "selectTr 3" data-cmmn-day = "A18003" data-period="4"></td>
							<td class = "selectTr 4" data-cmmn-day = "A18004" data-period="4"></td>
							<td class = "selectTr 5" data-cmmn-day = "A18005" data-period="4"></td>
						</tr>
						<!-- 추가할 내용 들어갈 공간. -->
					</tbody>

				</table>
				<hr>
			</div>
		</div>
		​​​​​​​​<input type="button" value="등록" id="insertBtn" />
	</div>
</div>
