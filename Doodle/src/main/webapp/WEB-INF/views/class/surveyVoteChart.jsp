<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>
<style>
.chartbox{
	background: rgb(255 255 255 / 60%);
	box-shadow: 0 8px 32px 0 rgba( 31, 38, 135, 0.37 );
	backdrop-filter: blur( 4px );
	-webkit-backdrop-filter: blur( 4px );
	border-radius: 10px;
	border: 1px solid rgba( 255, 255, 255, 0.18 );
	margin-right:50px;
	padding: 20px 30px;
	min-height: 500px;
	margin-bottom:50px;
}
.chart-wrap{
	width:1400px;
	margin:auto;
	min-height: 500px;
	justify-content: space-between;
}
#chartContainer h3{
	font-size: 2.2rem;
	text-align: center;
	backdrop-filter: blur(4px);
	background-color: rgba(255, 255, 255, 1);
	border-radius: 50px;
	box-shadow: 35px 35px 68px 0px rgba(145, 192, 255, 0.5), inset -8px -8px 16px 0px rgba(145, 192, 255, 0.6), inset 0px 11px 28px 0px rgb(255, 255, 255);
	width: 390px;
	padding-top: 35px;
	padding-bottom: 35px;
	margin: auto;
	margin-bottom: 40px;
	-moz-animation: fadein 1s; /* Firefox */
	-webkit-animation: fadein 1s; /* Safari and Chrome */
	-o-animation: fadein 1s; /* Opera */
}
</style>
<script>
$( document ).ready(function() {
	<c:forEach var="smallList" items="${voteQustnrIemVOMapList}" varStatus="status">
		var arr = [];//투표항목
		var cnt = [];//투표항목 채택 인원 수
		<c:forEach var="iemvo" items="${smallList}" varStatus="status2">
			arr.push("${iemvo.VOTE_DETAIL_IEM_CN}");//투표항목
			cnt.push("${iemvo.CNT}");//투표항목 채택 인원 수
		</c:forEach>
		var ctx = document.getElementById("myChart" + "${status.count}" + "-1").getContext('2d');//div가져오기 id값은 겹치면 안되므로 status로 구분
		var myChart = new Chart(ctx, {
			type: 'bar',
			data: {
				labels: arr,
				datasets: [{
					label: '',
					data: cnt,
					backgroundColor: [
						'rgba(255, 99, 132, 0.2)',
						'rgba(54, 162, 235, 0.2)',
						'rgba(255, 206, 86, 0.2)',
						'rgba(75, 192, 192, 0.2)',
						'rgba(153, 102, 255, 0.2)',
						'rgba(255, 159, 64, 0.2)',
						'rgba(255, 99, 132, 0.2)',
						'rgba(54, 162, 235, 0.2)',
						'rgba(255, 206, 86, 0.2)',
						'rgba(75, 192, 192, 0.2)',
						'rgba(153, 102, 255, 0.2)',
						'rgba(255, 159, 64, 0.2)'
					],
					borderColor: [
						'rgba(255, 99, 132, 1)',
						'rgba(54, 162, 235, 1)',
						'rgba(255, 206, 86, 1)',
						'rgba(75, 192, 192, 1)',
						'rgba(153, 102, 255, 1)',
						'rgba(255, 159, 64, 1)',
						'rgba(255, 99, 132, 1)',
						'rgba(54, 162, 235, 1)',
						'rgba(255, 206, 86, 1)',
						'rgba(75, 192, 192, 1)',
						'rgba(153, 102, 255, 1)',
						'rgba(255, 159, 64, 1)'
					],
					hoverBackgroundColor: [
						'rgba(255, 99, 132, 1)',
						'rgba(54, 162, 235, 1)',
						'rgba(255, 206, 86, 1)',
						'rgba(75, 192, 192, 1)',
						'rgba(153, 102, 255, 1)',
						'rgba(255, 159, 64, 1)',
						'rgba(255, 99, 132, 1)',
						'rgba(54, 162, 235, 1)',
						'rgba(255, 206, 86, 1)',
						'rgba(75, 192, 192, 1)',
						'rgba(153, 102, 255, 1)',
						'rgba(255, 159, 64, 1)'
					],
					borderWidth: 1
				}]
			},
			options: {
				title:{
					display:true,
					text:'투표 현황',
					position:'bottom',
					fontSize:20,
					lineHeight:1.6,
					fontColor:'#111'
				},
				responsive: false,
				scales: {
					y: {
						beginAtZero: true
					}
				}
			}
		});
	</c:forEach>
	
	//도넛 차트
	<c:forEach var="responseList" items="${responseMemberList}" varStatus="status">
		var zeroCnt = 0;//미응시자 인원을 담을 카운트
		var oneCnt = 0;//응시자 인원을 담을 카운트
		<c:forEach var="map" items="${responseList}" varStatus="status2">
			if("0" == "${map.CNT}") {
				zeroCnt++;
			}else {
				oneCnt++;
			}
		</c:forEach>
		var cnt = [oneCnt, zeroCnt];
		var ctx2 = document.getElementById("myChart" + "${status.count}" + "-2").getContext('2d');
		var myChart2 = new Chart(ctx2, {
			type: 'doughnut',
			data: {
				labels: ['응시', '미응시'],
				datasets: [{
					data: cnt,
					backgroundColor: [
						'rgba(255, 99, 132, 0.2)',
						'rgba(54, 162, 235, 0.2)',
						'rgba(255, 206, 86, 0.2)',
						'rgba(75, 192, 192, 0.2)',
						'rgba(153, 102, 255, 0.2)',
						'rgba(255, 159, 64, 0.2)',
						'rgba(255, 99, 132, 0.2)',
						'rgba(54, 162, 235, 0.2)',
						'rgba(255, 206, 86, 0.2)',
						'rgba(75, 192, 192, 0.2)',
						'rgba(153, 102, 255, 0.2)',
						'rgba(255, 159, 64, 0.2)'
					],
					borderColor: [
						'rgba(255, 99, 132, 1)',
						'rgba(54, 162, 235, 1)',
						'rgba(255, 206, 86, 1)',
						'rgba(75, 192, 192, 1)',
						'rgba(153, 102, 255, 1)',
						'rgba(255, 159, 64, 1)',
						'rgba(255, 99, 132, 1)',
						'rgba(54, 162, 235, 1)',
						'rgba(255, 206, 86, 1)',
						'rgba(75, 192, 192, 1)',
						'rgba(153, 102, 255, 1)',
						'rgba(255, 159, 64, 1)'
					],
					hoverBackgroundColor: [
						'rgba(255, 99, 132, 1)',
						'rgba(54, 162, 235, 1)',
						'rgba(255, 206, 86, 1)',
						'rgba(75, 192, 192, 1)',
						'rgba(153, 102, 255, 1)',
						'rgba(255, 159, 64, 1)',
						'rgba(255, 99, 132, 1)',
						'rgba(54, 162, 235, 1)',
						'rgba(255, 206, 86, 1)',
						'rgba(75, 192, 192, 1)',
						'rgba(153, 102, 255, 1)',
						'rgba(255, 159, 64, 1)'
					],
					hoverOffset: 4
				}]
			},
			options: {
				responsive: false,
				title:{
					display:true,
					text:'응시 현황',
					position:'bottom',
					fontSize:20,
					lineHeight:1.5,
					fontColor:'#111'
				}
			}
		});
	</c:forEach>
	//투표한 사람의 권한 체크
	<c:forEach var="authList" items="${responseMemberList}" varStatus="status">
		var parents = 0;//학부모의 인원수
		var std = 0;//학생의 인원수
		<c:forEach var="map" items="${authList}" varStatus="status2">
			if("1" == "${map.CNT}") {
				if("ROLE_A01001"=="${map.CMMN_DETAIL_CODE}"){
					std++;
					
				}else{
					parents++;
				}
			}
			console.log("std -> ", std);
		</c:forEach>
		var cnt = [std, parents]
		var ctx3 = document.getElementById("myChart" + "${status.count}" + "-3").getContext('2d');
		var myChart3 = new Chart(ctx3, {
			type: 'pie',
			data: {
				labels: ['학생', '학부모 및 보호자'],
				datasets: [{
					data: cnt,
					backgroundColor: [
						'rgba(255, 99, 132, 0.2)',
						'rgba(54, 162, 235, 0.2)',
						'rgba(255, 206, 86, 0.2)',
						'rgba(75, 192, 192, 0.2)',
						'rgba(153, 102, 255, 0.2)',
						'rgba(255, 159, 64, 0.2)',
						'rgba(255, 99, 132, 0.2)',
						'rgba(54, 162, 235, 0.2)',
						'rgba(255, 206, 86, 0.2)',
						'rgba(75, 192, 192, 0.2)',
						'rgba(153, 102, 255, 0.2)',
						'rgba(255, 159, 64, 0.2)'
					],
					borderColor: [
						'rgba(255, 99, 132, 1)',
						'rgba(54, 162, 235, 1)',
						'rgba(255, 206, 86, 1)',
						'rgba(75, 192, 192, 1)',
						'rgba(153, 102, 255, 1)',
						'rgba(255, 159, 64, 1)'
					],
					hoverBackgroundColor: [
						'rgba(255, 99, 132, 1)',
						'rgba(54, 162, 235, 1)',
						'rgba(255, 206, 86, 1)',
						'rgba(75, 192, 192, 1)',
						'rgba(153, 102, 255, 1)',
						'rgba(255, 159, 64, 1)'
					],
					hoverOffset: 4
				}]
			},
			options: {
				responsive: false,
				title:{
					display:true,
					text:'참여자 현황',
					position:'bottom',
					fontSize:20,
					lineHeight:1.5,
					fontColor:'#111'
				}
			}
		});
	</c:forEach>
	
});
</script>

<div id="chartContainer">
	<h3>
		<img src="/resources/images/classRoom/freeBrd/grap.png"style="width: 50px; display: inline-block; vertical-align: middel;">
		투표 현황 
		<img src="/resources/images/classRoom/freeBrd/vote1.png" style="width: 50px; display: inline-block; vertical-align: middel;">
	</h3>
	<div class="chart-wrap">
		
		<c:choose>
			<c:when test="${voteNdQustnrVOMapList != null and fn:length(voteNdQustnrVOMapList) > 0}">
				<c:forEach var="voteNdQustnrVO"  items="${voteNdQustnrVOMapList}" varStatus="status">
					<div class="charts chartbox">
						<h4>
							${voteNdQustnrVO.VOTE_IEM_CN}
						</h4>
						<div class="chart-box" style="display: flex; justify-content: space-between;">
							<canvas id="myChart${status.count}-1" width="400" height="400"></canvas>
							<canvas id="myChart${status.count}-2" width="400" height="400"></canvas>
							<canvas id="myChart${status.count}-3" width="400" height="400"></canvas>
						</div>
					</div>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<div class="charts chartbox">
					<h4>
						<!-- 리스트가 없을 때 띄울 내용 구별-->
						현재 마감된 투표가 없습니다.
					</h4>
				</div>
			</c:otherwise>
		</c:choose>
		
	</div>
</div>
