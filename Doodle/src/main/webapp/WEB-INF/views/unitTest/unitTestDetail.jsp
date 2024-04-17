<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>    
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script> <!-- 4.4.2 -->
<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.js"></script> -->
<script type="text/javascript" src="/resources/js/commonFunction.js"></script>  
<script type="text/javascript" src="/resources/js/cjh.js"></script>  
<script type="text/javascript" src="/resources/js/unitTest.js"></script>  
<link rel="stylesheet" href="/resources/css/mainPage.css">

<style>
#unitTest {
	width:1400px;
	margin:auto;
}

#unitTest > h3{
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

#unitTest > h3 > img{
	width:50px;
}

.resDiv {
	display:inline-block;
	vertical-align:text-top;
}
textarea {
	resize: none;
}
.d-tb th {
	text-align: center;
}

#title-tb th, #title-tb td {
	font-size: 1.2rem;
}

.box {
	margin-bottom: 20px;
}
</style>

<script>
// 학생 결과 목록 테이블 가로 길이
var rowsCount = 0;
// 단원평가 모든 정보
var ueRes = {};

// 학생 결과 목록 테이블 가로 길이 설정
<sec:authorize access ="hasRole('A01002')">
rowsCount =6;
</sec:authorize>
<sec:authorize access ="hasAnyRole('A01001', 'A01003')">
rowsCount =5;
</sec:authorize>

window.onload = function(){
	// 모든 시험 정보 가져오는 ajax
	getOneUnitEvlAndAllGc();
	console.log("ueRes:",ueRes);
	// 성적 테이블 출력
	<sec:authorize access="hasAnyRole('A01002', 'A01003')">
	setScoreTable();
	</sec:authorize>
	// 시험 정보 및 답안 출력
	setUnitTestDetail();
	// 학생 시험 결과 목록 출력
	setGcList();
	
	// 교사의 학생 성적 차트
	<sec:authorize access ="hasAnyRole('A01002', 'A01003')">
	drawChart();
	</sec:authorize>
}

const getOneUnitEvlAndAllGc = function(){
	$.ajax({
		url :"/unitTest/getOneUnitEvlAndAllGc",
	    type:"post",
	    data:"${unitEvlCode}",
	    contentType:"application/json",
	    dataType:"json",
	    async : false,
	    beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success : function(res) {
		ueRes = res;
		}
	})
}

// 시험 기본 정보 및 답안 출력
const setUnitTestDetail = function(){
	// 교사는 답안 정보 보임
	<sec:authorize access ="hasRole('A01002')">
	document.querySelector("#aswperViewer").style.display = "block";
	</sec:authorize>
			
	/*
	단원평가 기본 정보
	*/
	cjh.selOne("#unitTestNm").innerHTML = cutStr(ueRes[0].unitEvlNm,45);
	cjh.selOne("#unitStartDate").innerHTML = dateToMinFormat(ueRes[0].unitEvlBeginDt);
	cjh.selOne("#unitEndDate").innerHTML = dateToMinFormat(ueRes[0].unitEvlEndDt);
	
	/*
	문항 
	*/
	let num = 1;
	ueRes[0].quesList.forEach(function(item, idx){
		// 구조 복사
		let clone = document.querySelector("#quesDiv").cloneNode(true);
		let quesCon = document.querySelector("#quesContainer");
		
		// 메인 div id 변경
		let cloneId = clone.id;
		cloneId = cloneId + ++num;
		clone.id = cloneId;
		// 보이게 변경
		clone.style = "display:block;";
		// 문서 붙여넣기
		quesCon.append(clone);
		
		// 요소 찾기
		let quesNo     = cjh.selOne("#"+cloneId+" .no")          ;
		let quesQues   = cjh.selOne("#"+cloneId+" .ques")        ;
		let quesCnsr   = cjh.selOne("#"+cloneId+" .cnsr")        ;
		let quesAllot  = cjh.selOne("#"+cloneId+" .allot")       ;
		let quesExplna = cjh.selOne("#"+cloneId+" .explna")      ;

		noLabels       = cjh.selOne("#"+cloneId+" .noLabel")     ;
		quesLabels     = cjh.selOne("#"+cloneId+" .quesLabel")   ;
		allotLabels    = cjh.selOne("#"+cloneId+" .allotLabel")  ;
		cnsrLabels     = cjh.selOne("#"+cloneId+" .cnsrLabel")   ;
		explnaLabels   = cjh.selOne("#"+cloneId+" .explnaLabel") ;
		
		// id, name, value 변경
		quesNo.innerHTML = idx+1+"번 문제";
		quesQues.id      = "quesQues"  +cloneId;
		quesQues.name    = "quesQues"  +cloneId;
		quesQues.innerHTML = item.quesQues;
		quesCnsr.id      = "quesCnsr"  +cloneId;
		quesCnsr.name    = "quesCnsr"  +cloneId;
		quesCnsr.value = item.quesCnsr;
		quesAllot.id     = "quesAllot" +cloneId;
		quesAllot.name   = "quesAllot" +cloneId;
		quesAllot.value = item.quesAllot;
		quesExplna.id    = "quesExplna"+cloneId;
		quesExplna.name  = "quesExplna"+cloneId;
		quesExplna.innerHTML = item.quesExplna;
		
		noLabels.setAttribute(    "for", "quesNo"    +cloneId);
		quesLabels.setAttribute(  "for", "quesQues"  +cloneId);
		allotLabels.setAttribute( "for", "quesCnsr"  +cloneId);
		cnsrLabels.setAttribute(  "for", "quesAllot" +cloneId);
		explnaLabels.setAttribute("for", "quesExplna"+cloneId);
		
		// (학생) 응시 기간이 지나면 버튼 상태 종료됨.
		<sec:authorize access="hasAnyRole('A01001', 'A01003')">
			if(cjh.isUnderNowTime(dateToMinFormat(ueRes[0].unitEvlEndDt), true)){
				let btn = document.querySelector("#examBtn");
				btn.innerHTML = "응시 기간 종료";
				btn.className = "d-div-gray";
				btn.disabled = "true";
				btn.style ="width:100%";
			}examBtn
		</sec:authorize>
	});
	
	// 원본 삭제
	document.querySelector("#quesDiv").remove;

	// textarea 높이 조절
	document.querySelectorAll("textarea").forEach(function(item, idx){
		item.style.height = 'auto';
	    item.style.height = item.scrollHeight + 35 + 'px';
	})
}

// 성적 테이블 출력
const setScoreTable = function(){
	let testDiv = document.querySelector("#tableDiv");
	tableDiv.style.display ="block";
	
	let str = getScoreTableStr(ueRes);
	
	tableDiv.innerHTML = str;
	let rs = document.querySelector("#rs").innerText;
	document.querySelector("#blank").setAttribute("rowspan", rs);
}

// 학생 시험 결과 목록 출력
const setGcList = function(){
	let str = "";
	if(ueRes[0].unitEvlScoreVOList.length == 0){
		str = `<tr><td colspan="100%" style="text-align: center;">등록된 단원평가 결과가
			    없습니다..</td></tr>`
		document.querySelector("#listTbody").innerHTML = str;
		return;
	}
	
	let myMberId = "${CLASS_STD_INFO.mberId}";

	ueRes[0].unitEvlScoreVOList.forEach(function(item, index){
		let isDone = item.gcCode == null ? false:true ; // 학생이 시험에 응시했는지
		
		str += `<tbody>
				<tr>
				<td>\${item.clasInNo}</td>
				<td>\${item.mberNm}</td>`;
		// 미응시 학생이면 응시 일시 : 미응시
		if(isDone){ 
			str +=  `<td>\${dateToMinFormat(item.gcDate)}</td>`;
		}else{
			str += `<td>미응시</td>`;
		}
				
		str +=  `<td>\${item.scre}</td>
				<td style="text-align: center">`;
		
		// 학생 답안 보기 버튼
		if(isDone){ 
			str +=	`<button onclick="showResDet('\${index}')" class = "d-btn-blue">보기</button>`;
		}
		str +=	`</td>
	  			 <td style="text-align: center">`;
		
		// (교사) 학생 성적표 삭제 버튼
		<sec:authorize access="hasRole('A01002')">
		if(isDone){ 
			str +=  `<button onclick="deleteStdRes('\${index}')" class ="d-btn-red">삭제</button>`;
		}
		</sec:authorize>
		str +=	`</td>`;
		
		// (교사) 문자 발송 버튼
		<sec:authorize access="hasRole('A01002')">
		str +=  `<td style="text-align: center">
				<button onclick="sendMsg('\${index}')" class ="d-btn-blue">문자 전송</button>
				<td>`;
		</sec:authorize>
		
		str +=	`</tr>
				<tbody>`;
				
		// (학생) 이미 시험을 본 학생이면 버튼 비활성화, 답안지 보임
	    <sec:authorize access ="hasAnyRole('A01001','A01003')">
	    if(myMberId == item.mberId && isDone){
		    let btn = document.querySelector("#examBtn");
			btn.innerHTML = "응시 완료";
			btn.className = "d-div-green";
			btn.disabled = "true";
			btn.style ="width:100%";
			
			// 답안 결과 보임.
			document.querySelector("#aswperViewer").style.display = "block";
			setScoreTable();
			
			// 차트
			drawChart();
	    }
		</sec:authorize>
	})
	document.querySelector("#listTbody").innerHTML = str;
}

// 단원평가 응시 버튼 클릭 (form post)
const goExamConfirmForm = function(){
	cjh.swConfirm("주의","시험 응시 도중 시험을 중단하면 두 번 다시는 시험을 볼 수 없습니다. 시험 전 컴퓨터 네트워크 상태를 확인해주세요. 시험을 응시하러 가시겠습니까?","warning").then(function(res){
		if(res.isConfirmed){
			document.querySelector("#goExamForm").submit();
		}
	})
}

// 학생 답안 출력
const showResDet = function(index){
	return;
	
	let member = ueRes[0].unitEvlScoreVOList[index];
	let str = "";
	
	if(index==null){
		str = `<tr><td rowspan="2" style="text-align :center;">학생 답안 상세</td></tr>`
		document.querySelector("#aswperTbody").innerHTML = str;
		return;
	}
	
	member.aswperList.forEach(function(aswper, index){
		str +=`<tr>
			   <th>\${aswper.quesNo}번 문제</th>
			   <td>\${aswper.aswperCn}</td>
			   </tr>`
	})

	document.querySelector("#aswperTbody").innerHTML = str;
}

// 학생 답안 삭제
const deleteStdRes = function(index){
	cjh.swConfirm("삭제","학생 답안 결과를 삭제하시겠습니까?","warning", '삭제', '아니오'  ,'red').then(function(res){
		if(res.isConfirmed){
			stdCode = ueRes[0].unitEvlScoreVOList[index].unitEvlCode;
			$.ajax({
				url :"/unitTest/deleteStdRes",
			    type:"post",
			    data:JSON.stringify({"unitEvlCode":"${unitEvlCode}",
			    	  				 "clasStdntCode":stdCode}),
			    contentType:"application/json",
			    dataType:"text",
			    beforeSend:function(xhr){
					xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
				},
				success : function(res) {
					if(res>0){
						alert("성적표 및 답안이 정상적으로 삭제되었습니다.");
						getGcList(); 	  // 새로고침
						showResDet(null); // 답안 상세칸 없앰
					}
				}
			})
		}
	})
}

// 시험 삭제
const deleteUnitTest = function(){
	cjh.swConfirm("삭제","해당 단원평가를 삭제하시겠습니까?","warning",'삭제', '아니오' ,'red').then(function(res){
		if(res.isConfirmed){
			$.ajax({
				url :"/unitTest/deleteUnitTest",
			    type:"post",
			    data:"${unitEvlCode}",
			    contentType:"application/json",
			    dataType:"json",
			    async : false,
			    beforeSend:function(xhr){
					xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
				},
				success : function(res) {
					if(res > 0){
						cjh.swAlert("완료", "단원평가 삭제가 완료되었습니다.").then(function(res){
							location.href ="/unitTest/list";
						})
					}else{
						cjh.swAlert("실패","단원평가  삭제에 실패했습니다.","error");
					}
				}
			})
		}
	})
}

// chartjs
// 4.4.2
const drawChart = function(){
	const scoreChart = document.querySelector('#scoreChart');
	scoreChart.style.display ="block";
	let chartType     = "bar";
	let chartLabel    = [];
	let chartData	  = [{
						data:[],
					    borderWidth:1,
					    backgroundColor:[],
					    }];
	let chartOptions  = null;
	
	// 복사
	let clone = JSON.parse(JSON.stringify(chartData[0]));
	
	// 학생, 학부모
	// 라벨 
	<sec:authorize access="hasRole('A01001')">
	chartLabel.push("내점수");
	</sec:authorize>
	<sec:authorize access="hasRole('A01003')">
	chartLabel.push("자녀 점수");
	</sec:authorize>

	<sec:authorize access="hasAnyRole('A01001', 'A01003')">
	chartLabel.push("반평균");
	chartData[0].data.push(ueRes[0].unitEvlScoreVOList[0].scre);
	chartData[0].data.push(ueRes[0].avgClasScore);
	chartData[0].backgroundColor.push('#FCC25BB0');
	chartData[0].backgroundColor.push('#ccccccb0');
	chartData[0].maxBarThickness=45;
	
	
	chartOptions = {
    	responsive: false,
    	indexAxis : 'y', // 가로 차트

        scales: {
            x: {
                beginAtZero: true,
            	max :100,
	        	ticks:{
	        		stepSize:5
	        	},
            },
        },
        plugins: {
            legend: {
              display: false
            },
        },
	}
	</sec:authorize>
	
	// 교사
	<sec:authorize access="hasRole('A01002')">
	
	chartData[0].maxBarThickness = "200";
	console.log("charData[0]",chartData[0]);

	// 반평균 점수 put
		chartLabel.push("평균 점수");
		chartData[0].data.push(ueRes[0].avgClasScore);
		chartData[0].backgroundColor.push('#ccccccb0');
		chartLabel.push("최저 점수");
		chartData[0].data.push(ueRes[0].minScore);
		chartData[0].backgroundColor.push('#006DF0b0');
		chartLabel.push("최고 점수");
		chartData[0].data.push(ueRes[0].maxScore);
		chartData[0].backgroundColor.push('#df3c3cb0');
		chartData[0].maxBarThickness=45;
	
	// 학생 정보 put
	for(let i = 0; i < ueRes[0].unitEvlScoreVOList.length; ++i){
		chartLabel.push(ueRes[0].unitEvlScoreVOList[i].mberNm);
		chartData[0].data.push(ueRes[0].unitEvlScoreVOList[i].scre);
		chartData[0].backgroundColor.push('#FCC25BB0');
	}
	
	chartOptions = {
    	responsive: false,

        scales: {
            y: {
                beginAtZero: true,
            	max :100,
	        	ticks:{
		         	stepSize :5,
	        	},
            },
        },
        plugins: {
            legend: {
              display: false
            }
        },
	}	
	scoreChart.style.height = "300px";
	</sec:authorize>
	
	let myScoreChart = new Chart(scoreChart, {
	    type: chartType,
	    data: {
	        labels: chartLabel,
	        datasets: chartData,
	    },
	    options: chartOptions
	});
	
	myScoreChart.update();
	
	// 응시 비율 그래프
	const finishRatioChart = document.querySelector('#finishRatioChart');
	finishRatioChart.style.display ="block";
	let doneColor = window.getComputedStyle(document.documentElement).getPropertyValue('--blue-color');
	let yetColor = window.getComputedStyle(document.documentElement).getPropertyValue('--gray-color');

	<sec:authorize access="hasRole('A01002')">
	finishRatioChart.style.height = "300px";
	</sec:authorize>
	
	let myFinishRatioChart = new Chart(finishRatioChart, {
	    type: "pie",
	    data: {
	        labels: ["응시 인원", "미응시 인원"],
	        datasets: [{
	        	data :[ueRes[0].doneCnt,ueRes[0].yetCnt],
	    		backgroundColor :[doneColor, yetColor],
	        }],
	    },
	    options: {
        	responsive: false,
            plugins: {
//                 legend: {
//                   display: false
//                 },
                
                responsive: true,
			    legend: {
			      display: false
			    },
			    cutoutPercentage: 80,
			    tooltips: {
			    	filter: function(item, data) {
			        var label = data.labels[item.index];
			        if (label) return item;
			      }
			    }
            },
        }
	});
	
// 	textCenter(myFinishRatioChart, (ueRes[0].doneCnt/ueRes[0].allCnt*100).toFixed() );
	myFinishRatioChart.update();
}


// function textCenter(target, val) {
//   Chart.pluginService.register({
//     beforeDraw: function(chart) {
//       var width = chart.chart.width,
//           height = chart.chart.height,
//           ctx = target.ctx;

//       ctx.restore();
//       var fontSize = (height / 130).toFixed(2);
//       ctx.font = fontSize + "em sans-serif";
//       ctx.textBaseline = "middle";

//       var text = val+"%",
//           textX = Math.round((width - ctx.measureText(text).width) / 2),
//           textY = height / 2 + 15;

//       ctx.fillText(text, textX, textY);
//       ctx.save();
//     }
//   });
// }

// 경고 문자 전송
const sendMsg = function(index){
	member = ueRes[0].unitEvlScoreVOList[index];
	console.log("member:",member);
	let sendStr = "[두들 학습 시스템 성적 경고문] " + member.mberNm+" 자녀의 " + ueRes[0].unitEvlNm +" 단원평가 결과 점수는 " +member.scre + "점입니다.";
	
	Swal.fire({
		   title: "["+member.mberNm+'] 경고 문자 발송',
		   text: '학부모에게 보낼 경고 문자 내용을 입력하세요.',
		   icon: 'info', // warning, error, success, info, question
		   input:"text",
		   inputValue:sendStr,
		   
		   showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
		   confirmButtonColor: 'var(--blue-color)', // confrim 버튼 색깔 지정
		   cancelButtonColor: 'var(--gray-color-dark)', // cancel 버튼 색깔 지정
		   confirmButtonText: '문자 전송', // confirm 버튼 텍스트 지정
		   cancelButtonText: '취소', // cancel 버튼 텍스트 지정
		   
		})
		.then(result => {
			
			if (result.isConfirmed) { // 만약 모달창에서 confirm 버튼을 눌렀다면
				console.log("member.mberId:",member.mberId);
				let parentList = getParents(member.mberId);
				console.log("parentList", parentList);
				
				if(parentList == null){
					cjh.swAlert("실패","등록된 학부모가 없어 문자 전송에 실패했습니다.","error").then(function(res){
		    			return;
		    		})
				}
				
				let parentsStr = "";
				parentList.forEach(function(item,index){
					// 문자 전송
					$.ajax({
						url:"/sms/sendMsg",
						type:"post",
						data:JSON.stringify({"moblphonNo":item.parentMemberVO.moblphonNo,
							  "msg":result.value
						}),
						contentType:"application/json",
					    dataType:"json",
					    async : false,
					    beforeSend:function(xhr){
							xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
						},
						success : function(res) {
							if(index > 0 ){
								parentsStr += ", ";
							}
							if(res.success_count > 0){
								parentsStr += item.parentMemberVO.mberNm +"님("+item.parentMemberVO.moblphonNo+")";
							}
						}, error : function(request, status, error){
							console.log("code: " + request.status)
							console.log("message: " + request.responseText)
							console.log("error: " + error);
						}
					})
				})
				
				if(parentsStr != ""){
					cjh.swAlert('학부모['+parentsStr+']에게 문자 전송이 완료되었습니다.',result.value,"success").then(function(res){
		    			console.log("done");
						return;
		    		})
				}
				else{
					cjh.swAlert('실패','문자 전송에 실패했습니다.',"error").then(function(res){
		    			return;
		    		})
				}
			}
		});
}

// 학부모 정보 get ajax
const getParents = function(mberId){
	let parentList = null;
	$.ajax({
		url:"/unitTest/getParents",
		type:"post",
		data:mberId,
		contentType:"application/json",
	    dataType:"json",
	    async : false,
	    beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success : function(res) {
			parentList = res;
		}, error : function(request, status, error){
			console.log("code: " + request.status)
			console.log("message: " + request.responseText)
			console.log("error: " + error);
		}
	})
	return parentList;
}
</script>

<!-- post로 화면 이동 form -->
<form id = "postForm" action ="" method ="post">
	<input type = "text" id ="unitEvlCode" name = "unitEvlCode" value ="" style="display:none;">
	<sec:csrfInput />
</form>

<div id ="unitTest">
	
<h3><img src ="/resources/images/classRoom/unitTest01.png">단원평가<img src ="/resources/images/classRoom/unitTest01.png"></h3>


<div class="box">
	<div class="product-status mg-b-15">
		<div class="container-fluid" >
			<div class="row">
				<sec:authorize access="hasRole('A01002')">
					<button class="d-btn-red pull-right"
					onclick="deleteUnitTest()" style="margin: 1px;">단원평가
					삭제하기</button>
					<form id = "modForm" action="/unitTest/modify" method="post">
						<input type ="text" name = "unitEvlCode" value = "${unitEvlCode}" style="display:none;">
						<button class="d-btn-blue pull-right" type = "submit"
							 style="margin: 1px; margin-right: 10px">단원평가
							수정하기</button>
							<sec:csrfInput />
					</form>
				</sec:authorize>
			</div>
		
			<div class="row">
				<div class="product-status-wrap" style="position: relative;">
					<div class="asset-inner">
						<form action="/unitTest/exam" method="post" id ="goExamForm">
							<input type="text" name="unitEvlCode" style="display: none;"
								value="${unitEvlCode}">
							<table id = "title-tb">
								<thead>
									<tr>
										<th style ="width:50%">단원평가 명</th>
										<th>시작 일시</th>
										<th>종료 일시</th>
										<sec:authorize access="hasAnyRole('A01001', 'A01003')">
											<th style="text-align: center;">상태</th>
										</sec:authorize>
									</tr>
								</thead>
								<tbody id="">
									<tr>
										<td id="unitTestNm"></td>
										<td id="unitStartDate"></td>
										<td id="unitEndDate"></td>
										<td id="" style="text-align: center">
											<sec:authorize access="hasRole('A01001')">
												<button class="d-btn d-btn-blue" id="examBtn"
													type="button" onclick ="goExamConfirmForm()" style="width: 100%;">단원평가
													실시하기</button>
											</sec:authorize>
											<sec:authorize access="hasRole('A01003')">
												<div class="d-div-yellow" id="examBtn" style="width: 100%;">단원평가 실시중</div>
											</sec:authorize>
										</td>
									</tr>
								</tbody>
							</table>
							<sec:csrfInput />
						</form>

						<div id="examAlarm"></div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>


<!-- 정답지 -->
<div id = "aswperViewer" class="box" style = "display:none;">
	<h4>정답지</h4>
	<div class="product-status mg-b-30">
		<div class="container-fluid">
			<div class="row">
				<div class="alert-title">
					<p></p>
					<div class="panel-group edu-custon-design" id="accordion">
						<div class="panel panel-default">

							<div class="panel-heading accordion-head" style="padding:0px;">
								<h4 class="panel-title" style="height:50px; vertical-align: middle;">
									<a data-toggle="collapse" data-parent="#accordion"
										href="#collapse1" class="collapsed" aria-expanded="false"
										style="display: block; width:100%; height:100px; padding:10px;"> 해설 펼쳐서 보기</a>
								</h4>
							</div>
							<div id="collapse1" class="panel-collapse panel-ic collapse"
								aria-expanded="false" style="height: 0px;">
								<div id="quesContainer" class="panel-body admin-panel-content animated bounce">

									<div id="quesDiv" style="display: none;">
										<!-- 문제 번호 -->
										<div class="form-group-inner">
											<div class="row">
												<div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
													<label class="login2 pull-right pull-right-pro noLabel"><span
														class="no">1번 문제</span></label>
												</div>
												<div class="col-lg-9 col-md-9 col-sm-9 col-xs-12"></div>
											</div>
										</div>

										<!-- 지문 -->
										<div class="form-group-inner">
											<div class="row">
												<div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
													<label class="login2 pull-right pull-right-pro quesLabel"
														for="quesQues">지문</label>
												</div>
												<div class="col-lg-9 col-md-9 col-sm-9 col-xs-12">
													<textarea rows="2" class="form-control ques"
														name="quesQues" id="quesQues" readonly></textarea>
												</div>
											</div>
										</div>

										<!-- 배점 -->
										<div class="form-group-inner">
											<div class="row">
												<div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
													<label class="login2 pull-right pull-right-pro allotLabel"
														for="quesAllot">배점</label>
												</div>
												<div class="col-lg-9 col-md-9 col-sm-9 col-xs-12">
													<input type="text" class="form-control allot"
														name="quesAllot" id="quesAllot" readonly>
												</div>
											</div>
										</div>

										<!-- 정답 -->
										<div class="form-group-inner">
											<div class="row">
												<div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
													<label class="login2 pull-right pull-right-pro cnsrLabel"
														for="cnsr">정답</label>
												</div>
												<div class="col-lg-9 col-md-9 col-sm-9 col-xs-12">
													<input type="text" class="form-control cnsr" name="cnsr"
														id="cnsr" readonly>
												</div>
											</div>
										</div>

										<!-- 해설 -->
										<div class="form-group-inner">
											<div class="row">
												<div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
													<label class="login2 pull-right pull-right-pro explnaLabel"
														for="quesExplna">해설</label>
												</div>
												<div class="col-lg-9 col-md-9 col-sm-9 col-xs-12">
													<textarea rows="4" class="form-control explna"
														name="quesExplna" id="quesExplna" readonly></textarea>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>


<!-- 점수 차트 -->
<div class = "box" style ="display :flex;">
	<div style ="width :75%">
		<h4>학생 점수</h4>
		<div style="width:100%; ">
			<canvas id="scoreChart" style="height:200px; width:100%; display :none;"></canvas>
		</div>
	</div>
	
	<!-- 응시 비율 차트 -->
	<div style ="width :25%">
		<h4>응시 비율</h4>
		<div style="width:100%;">
			<canvas id="finishRatioChart" style="height:200px; width:100%; display :none;"></canvas>
		</div>
	</div>
</div>

<!-- 전체 표 -->
<div class="box">
	<h4>성적표</h4>
	<div id="tableDiv" style ="display :none;"></div>
</div>


<!-- 학생 단원평가 결과 -->
<div class="box">
	<h4>결과 정보</h4>
	<div class="product-status mg-b-15">
		<div class="container-fluid">
			<div class="row">
				<div class="product-status-wrap" style="position: relative;">
					<div class="asset-inner resDet">
						<table>
							<thead>
								<tr>
									<th>학급 번호</th>
									<th style ="width:40%">학생명</th>
									<th>응시 일시</th>
									<th>성적</th>
									<th style="text-align: center;">상세</th>
									<sec:authorize access="hasRole('A01002')">
										<th style="text-align: center">삭제</th>
										<th style="text-align: center">경고 문자</th>
									</sec:authorize>
								</tr>
							</thead>
							<tbody id="listTbody">
								<tr>
									<td id = "ueResDefaultTd" colspan="100%" style="text-align: center;">등록된 단원평가가
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

<div class="">
	<div class="product-status mg-b-30">
		<div class="container-fluid">
			<div class="row" style = "text-align: center">
				<button class="d-btn-black pull-right"
					onclick="location.href='/unitTest/list'">목록으로 돌아가기</button>
			</div>
		</div>
	</div>
</div>

</div>
