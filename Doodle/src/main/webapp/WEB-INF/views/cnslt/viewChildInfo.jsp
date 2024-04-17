<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script> <!-- 4.4.2 -->
<script type="text/javascript" src="/resources/js/commonFunction.js"></script>
<style>
	#StdntDetailContainer h3 {
		font-size: 2.2rem;
		text-align: center;
		margin-top: 60px;
		backdrop-filter: blur(4px);
		background-color: rgba(255, 255, 255, 1);
		border-radius: 50px;
		box-shadow: 35px 35px 68px 0px rgba(145, 192, 255, 0.5), inset -8px -8px 16px 0px rgba(145, 192, 255, 0.6), inset 0px 11px 28px 0px rgb(255, 255, 255);
		width: 370px;
		padding-top: 35px;
		padding-bottom: 35px;
		margin: auto;
		margin-top: 50px;
		margin-bottom: 40px;
	}
</style>
<script>
// 모든 단원평가 정보
var ueRes = null;
// 성적 차트
let myScoreChart = null;

window.onload = function(){
	// 모든 단원평가 정보
	getStdGcList();
	
	// chartjs
	drawChart(null);
	
	setScoreTbSel();
	
	// 성적표 테이블
	setScoreTable();
}

// 모든 단원평가 정보
const getStdGcList = function(){
	let data = { 
    	"clasStdntCode" : `${clasStdntVO.clasStdntCode}`,
    	"clasCode" : `${clasStdntVO.clasCode}`,
    	"mberId" : `${clasStdntVO.memberVO.mberId}`
    };
	
	$.ajax({
		url : "/unitTest/getStdGcList",
		type:"post",
		contentType: "application/json; charset=utf-8",
        data: JSON.stringify(data),
        dataType:"json",
        async : false,
        beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
        success:function(res){
			ueRes = res;
        }
	});
} // end getStdGcList

const getScoreTableStr = function(ueRes){
	let str = `<div style="width: 100%; height: 20px;"></div>`;	
		
	// 단원평가 정보
	ueRes.forEach(function(unitTest, index){
		str += `<table class = "d-tb" style ="width : 100%">`;
			
		// 문제 기본 정보
		str += `<tr>
					<th style="width: 15%; text-align:center;">단원평가 명</th>
					<td style="width: 35%;">\${unitTest.unitEvlNm}</td>
					<th style="width: 15%; text-align:center;">단원평가 기간</th>
					<td style="width: 35%;">\${dateToMinFormat(unitTest.unitEvlBeginDt)}~\${dateToMinFormat(unitTest.unitEvlEndDt)}</td>
				</tr>`;
			
		// 학생 정보
		str += `<tr>
					<th style ="text-align:center;" style ="text-align:center;">반 평균 점수</th>
					<td style ="text-align:center;">\${unitTest.avgClasScore}</td>
					<th style ="text-align:center;"  style ="text-align:center;">${clasStdntVO.memberVO.mberNm} 점수</th>
					<td style = "text-align :right;">\${unitTest.unitEvlScoreVOList[0].scre}점</td>
				</tr>`;
		
		str += `</table>`;
		str += `<div style="width: 100%; height: 20px;"></div>`;
	})
	
	
	return str;
}

//성적 테이블 출력
const setScoreTable = function(){
	let testDiv = document.querySelector("#tableDiv");
	tableDiv.parentNode.style.display ="block";
	
	let str = getScoreTableStr(ueRes, "-1");
	console.log("setScoreTable => " + setScoreTable);
	
	tableDiv.innerHTML = str;
	
	let rs =[];
	let rsDiv = document.querySelectorAll("#rs");
	for(let i = 0 ; i <rsDiv.length; ++i){
		rs.push(rsDiv[i].innerText);
	}

	let blankDiv = document.querySelectorAll("#blank");
	for(let i = 0 ; i <blankDiv.length; ++i){
		blankDiv[i].setAttribute("rowspan", rs[i]);
	}
}

const scrTbStdSelChange = function(idx){
	scrTbStd = idx;
	setScoreTable();
}

//chartjs
// 4.4.2
const drawChart = function(){
	const scoreChart = document.querySelector('#scoreChart');
	scoreChart.parentNode.style.display ="block";
	let chartType     = "bar";
	let chartLabel    = [];
	let chartData	  = [{
						data:[],
					    borderWidth:1,
					    backgroundColor:[],
						maxBarThickness: "200"
					    }];
	let chartOptions  = {
					    	responsive: false,
				
					        scales: {
					            y: {
					                beginAtZero: true,
					            	max :100,
						        	ticks:{
						        		stepSize:5
						        	},
					            },
					        },
					        plugins: {
					            legend: {
					              display: true
					            },
					        },
						};
	
	// 평균 점수 꺾은선 그래프 추가
	let chartDataClone3 = JSON.parse(JSON.stringify(chartData[0]));
	
	// 반 평균 점수 데이터
	for(let i =ueRes.length-1 ; i >= 0; --i){
		chartLabel.push(i+1+" "+cutStr(ueRes[i].unitEvlNm,25));
		chartDataClone3.data.push(ueRes[i].avgClasScore);
	}
	chartDataClone3.label = "반 평균 점수"

	chartDataClone3.type = "line";
	chartDataClone3.borderColor = "#959595b0";
	chartDataClone3.backgroundColor = "#959595b0";
	chartDataClone3.borderWidth = "1";
	chartDataClone3.tension = "0.1";
	chartDataClone3.order = "-10";
	chartDataClone3.pointBackgroundColor = '#959595b0';
	// 역할별로 라벨
	chartDataClone3.label = "반 평균 점수 변화";
	
	// 그래프 push
	chartData.push(chartDataClone3);
	
	// 최고 점수
	let chartDataClone4 = JSON.parse(JSON.stringify(chartDataClone3));
	chartDataClone4.data = [];
	chartDataClone4.borderColor = "#df3c3cb0";
	chartDataClone4.backgroundColor = "#df3c3cb0";
	chartDataClone4.pointBackgroundColor = '#df3c3cb0';
	chartDataClone4.order = "-3";
	chartDataClone4.label = "최고 점수";
	chartDataClone4.fill = false;
	for(let i =ueRes.length-1 ; i >= 0; --i){
		chartDataClone4.data.push(ueRes[i].maxScore);
	}
	chartData.push(chartDataClone4);
	
	// 최저 점수
	let chartDataClone5 = JSON.parse(JSON.stringify(chartDataClone3));
	chartDataClone5.data = [];
	chartDataClone5.borderColor = "#006DF0b0";
	chartDataClone5.backgroundColor = "#006DF0b0";
	chartDataClone5.pointBackgroundColor = '#006DF0b0';
	chartDataClone5.order = "-15";
	chartDataClone5.label = "최저 점수";
	chartDataClone5.fill = false;
	for(let i =ueRes.length-1 ; i >= 0; --i){
		chartDataClone5.data.push(ueRes[i].minScore);
	}
	chartData.push(chartDataClone5);
	
	chartData.shift();
	myScoreChart = new Chart(scoreChart, {
	    type: chartType, 
	    data: {
	        labels: chartLabel,
	        datasets: chartData,
	    },
	    options: chartOptions
	});
	
	myScoreChart.update();
	
	// 학생이면 자기 점수 표시
	changeSelStd(0);
}

// 점수표 학생 select
const setScoreTbSel = function(){
	let selUe = document.querySelector("#scoreTbSelUe");
	let selStd = document.querySelector("#scoreTbSelStd");

	ueRes.forEach(function(ue, index){
		let temp = document.createElement("option");
		temp.value = index;
		temp.innerHTML = cutStr(ue.unitEvlNm,30);
		selUe.append(temp);
	})
}

// 학생 select 변경
const changeSelStd = function(index){

	let member = ueRes[0].unitEvlScoreVOList[0];
	
	// 막대 그래프
	let insertData = {};

	// 꺽은선 그래프
	let lineClone = JSON.parse(JSON.stringify(insertData));
	lineClone.type = "line";
	lineClone.borderColor = "#FCC25BB0";
	lineClone.backgroundColor = "#FCC25B90";
	lineClone.borderWidth = "1";
	lineClone.tension = "0.1";
	lineClone.order = "1";
	lineClone.pointBackgroundColor = '#FCC25BB0';
	lineClone.label = `${clasStdntVO.memberVO.mberNm}의 점수`;
	lineClone.fill = true;
	for(i = ueRes.length-1; i >= 0; --i){
		if(lineClone.data == null){
			lineClone.data = [];
		}
		lineClone.data.push(ueRes[i].unitEvlScoreVOList[index].scre);
	}
	
	myScoreChart.data.datasets.push(lineClone);
	myScoreChart.update();
}
</script>
<div id="StdntDetailContainer">
	<h3>
		<img src="/resources/images/consultation/folder.png" style="width:50px; display:inline-block; vertical-align:middel;">
		학생 상세 정보
		<img src="/resources/images/consultation/folder2.png" style="width:50px; display:inline-block; vertical-align:middel;">
	</h3>
	<table class="d-tb" style="width: 100%;">
		<tbody>
			<tr>
				<td colspan="2" rowspan="4" style="width: 250px; height: 300px;">
	                <img src="/upload/profile/${clasStdntVO.memberVO.mberImage}" style="width: 100%; height: 100%;" >
	            </td>
				<th style="width: 15%;">학생 아이디</th>
				<td style="width: 20%;">${clasStdntVO.memberVO.mberId}</td>
				<th style="width: 15%;">학급 번호</th>
				<td style="width: 20%;">${clasStdntVO.clasInNo}</td>
			</tr>
			<tr>
				<th>학생 이름</th>
				<td>${clasStdntVO.memberVO.mberNm}</td>
				<th>주민등록번호</th>
				<td>${clasStdntVO.memberVO.ihidnum}</td>
			</tr>
			<tr>
				<th>휴대폰 번호</th>
				<td>${clasStdntVO.memberVO.moblphonNo}</td>
				<th>이메일</th>
				<td>${clasStdntVO.memberVO.mberEmail}</td>
			</tr>
			<tr>
				<th>주소</th>
				<td colspan="3">[${clasStdntVO.memberVO.zip}] ${clasStdntVO.memberVO.mberAdres}
				</td>
			</tr>
			<tr>
				<th colspan="100%" style="text-align: center;">학급 활동</th>
			</tr>
		</tbody>
	</table>
	<table class="d-tb" style="width: 100%;">
		<tbody>
			<tr>
				<th style="width: 10%; text-align: center;">성적표</th>
				<td>
					<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style ="margin-bottom: 20px;">
						<!-- 점수 꺾은선 차트 -->
						<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
							<div style="width:100%; display :none;">
								<canvas id="scoreChart" style="height:300px; width:100%;"></canvas>
							</div>
						</div>
					</div>
					<div id ="tableDiv"></div>
				</td>
			</tr>
		</tbody>
	</table>
	<table>
		<tbody>
			<tr>
				<td colspan="100%">
					<!-- 성적 테이블 -->
					<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
						<div style="display:none; min-height:200px">
							<!-- 단원평가 필터링 -->
							<select id="scoreTbSelUe" onchange="scrTbUeSelChange(-1)" class ="d-sel-blue"></select>
						</div>
					</div>
				</td>
			</tr>
		</tbody>
	</table>
</div>