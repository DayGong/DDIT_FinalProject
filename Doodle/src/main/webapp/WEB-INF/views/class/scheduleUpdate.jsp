<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
//beforeSend 전역변수 처리
const header="${_csrf.headerName}";
const token ="${_csrf.token}";

let tbody;

window.onload = function(){
	tbody = document.getElementById("listBody");
	// 수정할 시간표 목록 가지고오기
	const scheduleList = function(){
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
					
					for(let i=1; i<=8; i++){
						tbodyStr += `<tr><td>\${i}교시</td><td></td><td></td><td></td><td></td><td></td><td></td></tr>`;
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

					}
			    }
			});
	}
	// 수정할 학기 선택
	const selectSemstr = function() {

		var semstr = document.querySelector("#semstr").value;
		console.log(selectSemstr);
		// 학기 선택후 목록 다시 불러옴.
		scheduleList();
	}
	selectSemstr();
	document.querySelector("#semstr").addEventListener("change",selectSemstr);
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
				<button type="button"
					class="btn btn-custon-rounded-two btn-default btnAuto">자동등록</button>
				<button type="button"
					class="btn btn-custon-rounded-two btn-primary scheduleAdd">추가</button>
				<button type="button"
					class="btn btn-custon-rounded-two btn-danger scheduleMinus">삭제</button>
			</div>

			<div class="fixed-table-body">
				<table id="table" class="table JColResizer" >
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
					</tbody>

				</table>
				<hr>
			</div>
		</div>
		​​​​​​​​<input type="button" value="등록" id="insertBtn" />
	</div>
</div>
