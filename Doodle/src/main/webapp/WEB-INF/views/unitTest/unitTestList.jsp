<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script> <!-- 4.4.2 -->
<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.js"></script> -->
<script type="text/javascript" src="/resources/js/jquery.min.js"></script> 
<script type="text/javascript" src="/resources/js/unitTest.js"></script> 
<link rel="stylesheet" href="/resources/css/mainPage.css">

<style>
#unitTestList {
	width:1400px;
	margin:auto;
}

#unitTestList > h3{
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

#unitTestList > h3 > img{
	width:50px;
}

.curtain {
	position: absolute; 
	width:100%;
	height:100%; 
	background-color: #00000050; 
	display: flex; 
	align-items: center; 
	justify-content: center;
	border-radius: 5px;
	left: 0px;
	top: 0px;
}
.curtain span {
	font-size: 1.5rem;
	font-weight : 700; 
	color:white;
}

hr {
	border-color: var(--gray-color);
	border-style:dashed;
	margin:40px 0px;
}

.box {
	margin-bottom: 20px;
}

</style>

<script>
// 진짜진짜 모든 단원평가 정보
var ueRes = null;
// select 값 저장 변수
var scrTbUe = -2;
scrTbStd = -1;
// 성적 차트
let myScoreChart = null;
let myFinishRatioChart = null;
let mySectionChart = null;

window.onload = function(){
	// 진짜진짜 모든 단원평가 정보
	getAllUnitEvlAndAllGc();
	console.log("ueRes:",ueRes);
	// 단원평가 정보 get
	getUnitTestList();
	// 성적 그래프(꺾은선, 파이)
	
	if(ueRes.length != 0){
		let ctArr = document.querySelectorAll(".curtain");
		for(let i = 0; i < ctArr.length; ++i){
			ctArr[i].style.display = "none";
		} 
	}
	
	drawChart(null);
	
	<sec:authorize access = "hasRole('A01002')">
	drawScatterChart(); // 분산 그래프
	if(ueRes.length > 0){
			setSelStd(); // select박스
			setScoreTbSel(); // 
	}
	</sec:authorize>

	if(ueRes.length > 0){
		setScoreTable(); // 성적표 테이블
	}
}

// 진짜진짜 모든 단원평가 정보
const getAllUnitEvlAndAllGc = function(){
	$.ajax({
		url : "/unitTest/getAllUnitEvlAndAllGc",
		type:"post",
        dataType:"json",
        async : false,
        beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
        success:function(res){
        	console.log("getAllUnitEvlAndAllGc res:",res);
			ueRes = res;
        }
	})
}

//성적 테이블 출력
const setScoreTable = function(){
	let testDiv = document.querySelector("#tableDiv");
	tableDiv.parentNode.style.display ="block";
	
	let str = getScoreTableStr(ueRes,scrTbUe,scrTbStd);
	
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

// 성적표 테이블 단원평가<select> onchange
const scrTbUeSelChange = function(idx){
	scrTbUe = idx;
	setScoreTable();
}
const scrTbStdSelChange = function(idx){
	scrTbStd = idx;
	setScoreTable();
}

// 단원평가 리스트 읽어와 출력
const getUnitTestList = function(){
       	let str ="";
		
       	$.each(ueRes,function(index,ue){
       		let beginDt = dateToMinFormat(ue.unitEvlBeginDt);
       		let endDt   = dateToMinFormat(ue.unitEvlEndDt);
       		
       		// 학생. 시험을 보았는지
			<sec:authorize access="hasAnyRole('A01001', 'A01003')"> 
       		if(ue.unitEvlScoreVOList[0].gcCode == null && cjh.isUnderNowTime(endDt)){
				str +=`<tr onclick ="goExamConfirmForm()" class ="d-tr">`;
       		} else if(ue.unitEvlScoreVOList[0].gcCode == null && !cjh.isUnderNowTime(endDt)){
				str +=`<tr onclick ="goExamConfirmForm('\${ue.unitEvlCode}')" class ="d-tr">`;
       		} else{
				str +=`<tr onclick ="goDetail('\${ue.unitEvlCode}')" class ="d-tr">`;
       		}
       		</sec:authorize>

       		<sec:authorize access="hasRole('A01002')"> 
				str +=`<tr onclick ="goDetail('\${ue.unitEvlCode}')" class ="d-tr">`;
       		</sec:authorize>
       		
			str +=`<td>\${index+1}</td>
				   <td>\${cutStr(ue.unitEvlNm,40)}</td>
				   <td>\${beginDt}</td>
				   <td>\${endDt}</td>`
			
			let scoreStr = "";	// 학생 : 내 점수. 교사 : 평균 점수.		    
			let statusStr = ""; // 단원평가 상태	
			let cntStr = "";    // 응시, 미응시 인원
				   
			if(cjh.isUnderNowTime(endDt)){
				statusStr = `<td style="text-align:center;"><div class ="d-div-gray">종료</div></td></tr>`;
			}else{
				statusStr = `<td style="text-align:center;"><div class ="d-div-yellow">진행중</div></td></tr>`;
			}

			// 학생
			<sec:authorize access="hasAnyRole('A01001', 'A01003')"> 
			scoreStr = "<td>미응시</td>"; // 학생 : 내 점수
			// 응시 완료한 단원평가는 완료 상태로 변경.
			if(ue.unitEvlScoreVOList[0].gcCode != null){
				scoreStr = `<td>\${ue.unitEvlScoreVOList[0].scre}</td>`;
				statusStr = `<td style="text-align:center;"><div class ="d-div-green">완료</div></td></tr>`;
			}
			</sec:authorize>
			
			// 교사
			<sec:authorize access="hasRole('A01002')"> 
			cntStr += `<td>\${ue.allCnt-ue.doneCnt}</td>`;
			cntStr += `<td>\${ue.doneCnt}</td>`;
			cntStr += `<td>\${ue.allCnt}</td>`;
			scoreStr += `<td>\${ue.avgClasScore}</td>`;
			str += cntStr;
			</sec:authorize>

			
			str += scoreStr;
			str += statusStr;
		}); // res.forEach end...
		if(str != ""){
			document.querySelector("#listTbody").innerHTML = str;
		}
}

// 상세보기
const goDetail = function(unitEvlCode){
	document.querySelector("#formDataUnitEvlCode").value = unitEvlCode;
	let form = document.querySelector("#tempForm");
	form.action = "/unitTest/detail";
	console.log("form action : ",form.action);
	form.submit();
}

// 학생 : 단원평가 응시 버튼 클릭 (form post)
const goExamConfirmForm = function(unitEvlCode){
	<sec:authorize access ="hasAnyRole('A01003')">
		cjh.swAlert("실패", "아직 학생이 시험을 보지 않아 조회할 수 없습니다.", "warning");
		return;	
	</sec:authorize>
	
	if(unitEvlCode == null || unitEvlCode == ''){
		cjh.swAlert("실패", "기간이 지난 단원평가는 진행할 수 없습니다.", "warning");
		return;
	}
	cjh.swConfirm("주의","단원평가 진행 도중 중단하면 더이상 단원평가를 볼 수 없습니다. 단원평가를 진행하시겠습니까?","warning").then(function(res){
		if(res.isConfirmed){
			document.querySelector("#formDataUnitEvlCode").value = unitEvlCode;
			let form = document.querySelector("#tempForm");
			form.action = "/unitTest/exam";
			form.submit();
		}
	})
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
	console.log("chartOptions:",chartOptions);

	// 학생, 학부모
// 	<sec:authorize access="hasRole('A01001')">
// 	// 내 점수 추가
// 	let chartDataClone = JSON.parse(JSON.stringify(chartData[0]));
// 	for(let i =ueRes.length-1 ; i >= 0; --i){
// 		chartLabel.push(i+1+" "+ueRes[i].unitEvlNm);
// 		chartDataClone.data.push(ueRes[i].unitEvlScoreVOList[0].scre);
// 	}
// 	chartDataClone.backgroundColor = '#FCC25Bb0';
// 	chartDataClone.label = "내 점수"

// 	// 반 평균 점수 추가
// 	let chartDataClone2 = JSON.parse(JSON.stringify(chartData[0]));
// 	for(let i =ueRes.length-1 ; i >= 0; --i){
// 		chartDataClone2.data.push(ueRes[i].avgClasScore);
// 	}
// 	chartDataClone2.backgroundColor = '#ccccccb0';
// 	chartDataClone2.label = "반 평균 점수";

// 	chartOptions.plugins.legend.display = "true";
// 	// 그래프 push
// 	chartData.push(chartDataClone);
// 	chartData.push(chartDataClone2);
// 	</sec:authorize> // 학생 끝 .. 
	
	// 교사
// 	<sec:authorize access="hasRole('A01002')">
	// 학생 정보 put
// 	let chartDataClone = JSON.parse(JSON.stringify(chartData[0]));
// 	for(let i =ueRes.length-1 ; i >= 0; --i){
// 		chartLabel.push(i+1+" "+ueRes[i].unitEvlNm);
// 		chartDataClone.data.push(ueRes[i].avgClasScore);
// 	}
// 	chartDataClone.backgroundColor.push('#ccccccb0');
// 	chartDataClone.label = "반 평균 점수"
	
	// 막대 그래프 push
// 	chartData.push(chartDataClone);
// 	</sec:authorize> // 교사 끝 ..
	
	
	// 평균 점수 꺾은선 그래프 추가
	let chartDataClone3 = JSON.parse(JSON.stringify(chartData[0]));
	
	// 반 평균 점수 데이터
	for(let i =ueRes.length-1 ; i >= 0; --i){
		chartLabel.push("["+(i+1)+"] "+cutStr(ueRes[i].unitEvlNm,25));
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
	
	// 응시 비율 그래프
	drawFinishRatioChart();
	// 점수 구간 비율 그래프
	drawSectionChart();
	
	// 학생이면 자기 점수 표시
	<sec:authorize access = "hasAnyRole('A01001','A01003')">
	changeSelStd(0);
	</sec:authorize>
}

//응시 비율 그래프
const drawFinishRatioChart = function(sel){
	const finishRatioChart = document.querySelector('#finishRatioChart');
	finishRatioChart.parentNode.style.display ="block";

	let doneColor = window.getComputedStyle(document.documentElement).getPropertyValue('--blue-color');
	let yetColor = window.getComputedStyle(document.documentElement).getPropertyValue('--gray-color');
	
	chartData = {
			type:"pie",
			data:{
				labels:[],
				datasets:[{
					data:[],
					backgroundColor:[doneColor, yetColor],
				}],
			},
			options: {
	        	responsive: false,
	        }
	};

	let doneCnt = 0;
	let yetCnt = 0;
	
	// 전체 학생
	if(sel == null || sel == -1){
		for(let i = ueRes.length-1; i >= 0; --i){
			doneCnt += ueRes[i].doneCnt;
			yetCnt += ueRes[i].yetCnt;
		}
		chartData.data.labels.push("응시 인원");
		chartData.data.labels.push("미응시 인원");
	}
	else{ // 선택 학생
		for(let i = ueRes.length-1; i >= 0; --i){
			if(ueRes[i].unitEvlScoreVOList[sel].gcCode != null) {doneCnt++;}
			else{yetCnt++;}
		}	
		chartData.data.labels.push("응시 횟수");
		chartData.data.labels.push("미응시 횟수");
	}

	chartData.data.datasets[0].data.push(doneCnt);
	chartData.data.datasets[0].data.push(yetCnt);
	
	if(myFinishRatioChart != null) {
// 		myFinishRatioChart.config = chartData;
		myFinishRatioChart.destroy();
	} else{
// 		myFinishRatioChart = new Chart(finishRatioChart, chartData);
	}

	finishRatioChart.height = "300";
	myFinishRatioChart = new Chart(finishRatioChart, chartData);
	console.log("myFinishRatioChart:",myFinishRatioChart);
	// 도넛 중앙 텍스트
// 	textCenter(myFinishRatioChart, (doneCnt/(doneCnt+yetCnt) *100).toFixed());
	
	myFinishRatioChart.update();
}

// 분산도 그래프
const drawScatterChart = function(std){
	const scatterChart = document.querySelector('#scatterChart');
	scatterChart.parentNode.style.display ="block";

	chartData = {
			type:"scatter",
			data:{
				labels:[],
				datasets:[{
					label:"",
					backgroundColor:"",
					data:[],
				}],
			},
			options: {
	        	responsive: false,
        	 	scales: {
					x: {
						type: 'linear',
						position: 'bottom',
						ticks:{
							display:false,
							stepSize : 100,
						},
					},
					y: {
						max:100,
						grid: {
					           color: 'transparent',
					         },
					},
	       	    },
				plugins: {
		            legend: {
		              display: false
		            },
		        },
	        }
	};

	
	// 전체 학생
	if(std == null || std == -1){
		// 전체 단원평가
		for(let i = ueRes.length-1; i >= 0; --i){
			let clone = JSON.parse(JSON.stringify(chartData.data.datasets[0]));
			// 전체 학생
			for(let j = 0; j < ueRes[i].unitEvlScoreVOList.length; ++j){
				let sign = 1;
				if(j%2!=0){
					sign = -1;
				}
				
				clone.data.push({
								y:ueRes[i].unitEvlScoreVOList[j].scre,
								x:((ueRes.length-1-i)*100)+50+((j+1)/2*sign),
								}
				);
				chartData.data.labels.push(ueRes[0].unitEvlScoreVOList[j].mberNm); // 학생명
			}
			// (252, 194, 91) => (0, 109, 240)
			clone.backgroundColor = 'rgb('+(0+((255/(ueRes.length-1))*i))+', '+(109+(((194-109)/(ueRes.length-1))*i))+', '+(240-(((240-91)/(ueRes.length-1))*i))+')';
			clone.label=ueRes[i].unitEvlNm; // 시험명
			clone.order = i *-1;
			chartData.data.datasets.push(clone);
		}
	}
	else{ // 선택 학생
	}
	
	scatterChart.style.height = "200px";
	chartData.data.datasets.shift();
	
	myScatterChart = new Chart(scatterChart, chartData);
	myScatterChart.update();
}

// 성적 구간 비율 차트
const drawSectionChart = function(sel){
// 	const sectionChart = document.querySelector('#sectionChart');
// 	sectionChart.parentNode.style.display ="block";
	
// 	let over90 = 0;
// 	let over80 = 0;
// 	let over70 = 0;
// 	let over60 = 0;
// 	let over50 = 0;
// 	let over40 = 0;
// 	let over30 = 0;
// 	let under30 = 0;

// 	chartData = {
// 			type:"pie",
// 			data:{
// 				labels:[],
// 				datasets:[{
// 					data:[],
// 				}],
// 			},
// 			options: {
// 	        	responsive: false,
// 	        }
// 	};
	
// 	// 전체 학생
// 	if(sel == null || sel == -1){
// 		for(let i = ueRes.length-1; i >= 0; --i){
// 			for(let j = ueRes[i].unitEvlScoreVOList.length-1; j >= 0; --j){
// 				switch(ueRes[i].unitEvlScoreVOList[j].scre){
// 				case 90>=0 :
// 					over90 ++;
// 					break;
// 				case 80>=0 :
// 					over80 ++;
// 					break;
// 				case 70>=0 :
// 					over70 ++;
// 					break;
// 				case 60>=0 :
// 					over60 ++;
// 					break;
// 				case 50>=0 :
// 					over50 ++;
// 					break;
// 				case 40>=0 :
// 					over40 ++;
// 					break;
// 				case 30>=0 :
// 					over30 ++;
// 					break;
// 				case default :
// 					under30 ++;
// 					break;
// 				}
// 			}
// 		}
// 		chartData.data.labels.push("응시 인원");
// 		chartData.data.labels.push("미응시 인원");
// 	}
// 	else{ // 선택 학생
// 		for(let i = ueRes.length-1; i >= 0; --i){
// 			if(ueRes[i].unitEvlScoreVOList[sel].gcCode != null) {doneCnt++;}
// 			else{yetCnt++;}
// 		}	
// 		chartData.data.labels.push("응시 횟수");
// 		chartData.data.labels.push("미응시 횟수");
// 	}

// 	chartData.data.datasets[0].data.push(doneCnt);
// 	chartData.data.datasets[0].data.push(yetCnt);
	
// 	if(mySectionChart != null) {
// // 		myFinishRatioChart.config = chartData;
// 		mySectionChart.destroy();
// 	} else{
// // 		myFinishRatioChart = new Chart(finishRatioChart, chartData);
// 	}

// 	sectionChart.style.height = "300px";
// 	mySectionChart = new Chart(sectionChart, chartData);
// 	console.log("mySectionChart:",mySectionChart);
// 	// 도넛 중앙 텍스트
// // 	textCenter(myFinishRatioChart, (doneCnt/(doneCnt+yetCnt) *100).toFixed());
	
	
// 	mySectionChart.update();
}

// function textCenter(target, val) {
// 	console.log("target:",target);
// 	Chart.pluginService.register({
// 		clear: function(chart) {
// 			if(target.ctx != null)
// 				chart.ctx.clearRect(0, 0, chart.width,
// 				chart.height); },
// 		beforeDraw: function(chart) {
// 		  var width = chart.chart.width,
// 		      height = chart.chart.height,
// 		      ctx = target.ctx;
// // 		console.log("ctx:",ctx);
		
// 		  ctx.restore();
// 		  var fontSize = (height / 130).toFixed(2);
// 		  ctx.font = fontSize + "em sans-serif";
// 		  ctx.textBaseline = "middle";
		
// 		  var text = val+"%",
// 		      textX = Math.round((width - ctx.measureText(text).width) / 2),
// 		      textY = height / 2 + 15;
		
// 		  ctx.fillText(text, textX, textY);
// 		  ctx.save();
// 	  }
// 	});
// }

// 점수표 학생 select
const setSelStd = function(){
	let sel = document.querySelector("#selStd");

	ueRes[0].unitEvlScoreVOList.forEach(function(member, index){
		let temp = document.createElement("option");
		temp.value = index;
		temp.innerHTML = member.clasInNo +" "+ member.mberNm;
		sel.append(temp);
	})
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
	
	if(selStd != null){
		ueRes[0].unitEvlScoreVOList.forEach(function(member, index){
			let temp = document.createElement("option");
			temp.value = index;
			temp.innerHTML = member.clasInNo +" "+ member.mberNm;
			selStd.append(temp);
		})
	}
}

// 학생 select 변경
const changeSelStd = function(index){

	if(ueRes.length == 0){
		return;
	}
	
	if(myScoreChart.data.datasets.length >= 4){
		myScoreChart.data.datasets.pop();
// 		myScoreChart.data.datasets.pop();
		
		if(index == -1) {
			myScoreChart.update();
			// 응시 비율 차트
			drawFinishRatioChart(-1);
			return;
		}
	}

	let member = ueRes[0].unitEvlScoreVOList[index];
	
	// 막대 그래프
	let insertData = {};
// 	insertData.backgroundColor = "#FCC25BB0";
// 	insertData.borderWidth = 1;
// 	insertData.label = "["+member.clasInNo + "]"+member.mberNm + "의 점수";
// 	insertData.maxBarThickness = 200;
// 	for(i = ueRes.length-1; i >= 0; --i){
// 		if(insertData.data == null){
// 			insertData.data = [];
// 		}
// 		insertData.data.push(ueRes[i].unitEvlScoreVOList[index].scre);
// 	}

	// 꺽은선 그래프
	let lineClone = JSON.parse(JSON.stringify(insertData));
	lineClone.type = "line";
	lineClone.borderColor = "#FCC25BB0";
	lineClone.backgroundColor = "#FCC25B90";
	lineClone.borderWidth = "1";
	lineClone.tension = "0.1";
	lineClone.order = "1";
	lineClone.pointBackgroundColor = '#FCC25BB0';
	lineClone.label = "["+member.clasInNo + "]"+member.mberNm + "의 점수";
	<sec:authorize access = "hasAnyRole('A01001')">
	lineClone.label = "내 점수";
	</sec:authorize>
	lineClone.fill = true;
	for(i = ueRes.length-1; i >= 0; --i){
		if(lineClone.data == null){
			lineClone.data = [];
		}
		lineClone.data.push(ueRes[i].unitEvlScoreVOList[index].scre);
	}
	
// 	myScoreChart.data.datasets.push(insertData);
	myScoreChart.data.datasets.push(lineClone);
	myScoreChart.update();
	
	// 응시 비율 차트
	drawFinishRatioChart(index);
	drawSectionChart(index);
}

</script>

<form id = "tempForm" action ="" method ="post">
	<input type = "text" id = "formDataUnitEvlCode" name = "unitEvlCode" value = "" style="display:none;">
	<sec:csrfInput />
</form>

<div id = "unitTestList">

	<h3><img src ="/resources/images/classRoom/unitTest01.png">단원평가<img src ="/resources/images/classRoom/unitTest01.png"></h3>
	
	<!-- 차트 1행 -->
	<div class = "box" style ="display :flex; justify-content:space-between; position: relative;">
		<!-- 점수 꺾은선 차트 -->
		<div style ="display :inline-block; width : 75%;  padding:10px 0px;">
			<div style="width:100%; display :none;">
				<h3>반 점수 및 학생 점수</h3>
				<canvas id="scoreChart" style="height:300px; width:100%;"></canvas>

				<!-- 학생 select -->
				<sec:authorize access="hasRole('A01002')">
				<select id="selStd" onchange ="changeSelStd(this.value)" class = "d-sel-blue">
					<option value = "-1">학생 선택</option>
				</select>
				</sec:authorize>						
			</div>
		</div>							
		<!-- 응시 비율 차트 -->
		<div style ="display :inline-block; padding:10px 0px;">
			<div style="width:100%; display :none;">
				<h3>응시 비율</h3>
				<canvas id="finishRatioChart" style="height:300px;"></canvas>
			</div>
		</div>	
		
		<!-- 커튼 -->
		<div class = "curtain">
			<span>생성된 단원평가가 없습니다.</span>
		</div>
	</div>
	
	<!-- 2층 그래프 -->
	<sec:authorize access ="hasRole('A01002')">
	<div class = "box" style ="display : flex; justify-content:space-between; position: relative;">
	
		<!-- 분포도 차트 -->
		<div style ="width : 75%; padding:10px 0px;">
			<div style="width:100%; display :none;">
				<h3>분포도</h3>
				<canvas id="scatterChart" style="height:200px; width:100%;"></canvas>
			</div>
		</div>		
		
		<!-- 성적 구간 비율 차트 -->
		<div style =" padding:10px">
			<div style="width:100%; display :none;">
				<h3></h3>
				<canvas id="sectionChart" style="height:300px; width:100%;"></canvas>
			</div>
		</div>	
		
	
		<!-- 커튼 -->
		<div class = "curtain">
			<span>생성된 단원평가가 없습니다.</span>
		</div>

	</div> <!-- 2층 그래프 -->
	</sec:authorize>

	<!-- 성적 테이블 -->
	<div class = "box"  style="display:none; min-height:200px;">
		<h3>성적표</h3>
		<!-- 단원평가 필터링 -->
		<select id = "scoreTbSelUe" onchange="scrTbUeSelChange(this.value)" class ="d-sel-blue">
			<option value ="-2">단원평가를 선택하세요..</option>
			<option value ="-1">전체 단원평가</option>
		</select>
		<!-- 학생 필터링 -->
		<sec:authorize access="hasRole('A01002')">
		<select id = "scoreTbSelStd" onchange="scrTbStdSelChange(this.value)" class ="d-sel-blue">
			<option value ="-2">학생을 선택하세요..</option>
			<option value ="-1" selected>전체 학생</option>
		</select>
		</sec:authorize>
		<div id ="tableDiv"></div>
	</div>
	
	<div class = "box">
		<div class="product-status mg-b-15">
			<div class="container-fluid">
				<div class="row">
					<div class="product-status-wrap" style="position: relative;">
						<div class="add-product">
							<sec:authorize access ="hasRole('A01002')">
							<button class ="d-btn-blue pull-right" style ="margin:10px 0px; padding : 10px 20px; min-width: 100px" onclick="location.href='/unitTest/create'">단원평가 생성</button>
							</sec:authorize>
						</div>
						<div class="asset-inner">
							<table>
								<thead>
									<tr>
										<th>번호</th>
										<th>단원평가 명</th>
										<th>시작 일시</th>
										<th>종료 일시</th>
										<sec:authorize access ="hasAnyRole('A01001', 'A01003')">
										<th>내 점수</th>
										</sec:authorize>
										<sec:authorize access ="hasRole('A01002')">
										<th>미응시 인원</th>
										<th>응시 완료 인원</th>
										<th>총 인원</th>
										<th>평균 점수</th>
										</sec:authorize>
										<th style="text-align: center;">상태</th>
									</tr>
								</thead>
								<tbody id="listTbody">
									<tr>
										<td colspan="100%" style="text-align: center;">등록된 단원평가가
											없습니다..</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>




