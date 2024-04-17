<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript" src="/resources/js/commonFunction.js"></script>
<!-- chart.js CDN -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script> <!-- 4.4.2 -->
<script src="https://cdn.jsdelivr.net/npm/moment"></script>
<script src="https://cdn.jsdelivr.net/npm/chartjs-adapter-moment"></script>
<style>
	#chartDiv {
		height: 420px;
		width: 100%;
	}
</style>
<script>
	const DATA_COUNT = 7;
	const NUMBER_CFG = {count: DATA_COUNT, min: 0, max: 1000};
	let ctDiv;

	window.onload = function() {
		
		complaintTask();		// 신고 게시물 관리
		getHmpgBrwsrCo();		// 브라우저 관리
		getTotalVisitrCo();		// 총 방문객 수
		getTodayLoginCo();		// 오늘 방문객 수
		getCmprBfeCo();			// 전날과 비교한 방문객
		getNttList();			// 게시물 조회수 리스트
		setVisitrChart().then((data) => drawChart(data));	// 일주일 방문객 수를 불러와 차트 설정

// 		setInterval(() => { 
// 			complaintTask();
// 			getHmpgBrwsrCo();
// 			getTotalVisitrCo();
// 			getTodayLoginCo();
// 			getCmprBfeCo();
// 			getNttList();
// 			setVisitrChart().then((data) => drawChart(data));
// 		}, 5000);
		
	} // end onload
	
	// chart.js 시작
	const setVisitrChart = function() {
		return new Promise((resolve, reject) => {
			const chartDiv = $("#chartDiv");
			const labels = [];
			const totalData = [];
			const loginData = [];
			const mberSbscrbData = [];
			
			$.ajax({
				type: "get",
				url: "/admin/setVisitrChart",
				dataType: "json",
				success: function(result) {
					// 데이터 설정
					for (let i = 0; i < DATA_COUNT; ++i) {
						labels.push(dateFormat(result[i].hmpgManageDe));
						totalData.push(result[i].visitrCo);
						loginData.push(result[i].loginCo);
						mberSbscrbData.push(result[i].mberSbscrbCo);
					}
					
					const data = {
							labels: labels,
							datasets: [{
								type: 'line',
								label: '홈페이지 방문자 수',
								backgroundColor: 'rgb(0, 109, 240, 0.7)',
								borderColor: 'rgb(0, 109, 240, 0.7)',
								fill: false,
								data: totalData,
							}, {
								type: 'bar',
								label: '로그인한 회원 수',
								backgroundColor: 'rgb(101, 177, 45, 0.7)',
								borderColor: 'rgb(101, 177, 45, 0.7)',
								data: loginData,
							}, {
								type: 'bar',
								label: '회원 가입한 회원 수',
								backgroundColor: 'rgb(223, 60, 60, 0.7)',
								borderColor: 'rgb(223, 60, 60, 0.7)',
								data: mberSbscrbData,
							}]
						}; // end data
						
						resolve(data);
				} // end success
			}); // end ajax /admin/setVisitrChart
		}); // end return
	} // end setChart

	// 차트 생성
	const drawChart = function(data) {
		// 기존 차트 파괴
	    if (typeof ctDiv !== 'undefined' && ctDiv !== null) {
	        ctDiv.destroy();
	    }
		
		ctDiv = new Chart(chartDiv, {
			type: 'line',
			data: data,
			options: {
				plugins: {
					title: {
						display: false
					}
				},
				scales: {
					x: {
						type: 'time',
						display: true,
				        offset: true,
				        ticks: {
							source: 'data'
				        },
				        time: {
							unit: 'day',
							displayFormats: {
		                        day: 'YY-MM-DD' // 보여지는 형식을 'YY-MM-DD'로 설정
		                    }
						},
					}, // end x
		            y: {
		                ticks: {
		                    stepSize: 20 // y축의 간격을 20으로 설정
		                }
		            } // end y
				}, // end scales
			}, // end options
		});
	} // end drawChart
	// chart.js 끝
	
	// 차트에 뿌려질 게시물 테이블 정보 가져오기
	function getWeeklyVisitrCo() {
		return new Promise((resolve, reject) => {
			$.ajax({
				type: "get",
				url: "/admin/getWeeklyVisitrCo",
				dataType: "json",
				async: false,
				success: function(result) {
					resolve(result);
				}
			});
		});
	} // end getWeeklyVisitrCo
	
	// 게시물 테이블을 조회수 내림차순으로 가져오는 메서드
	function getNttList() {
		$.ajax({
			type: "get",
			url: "/admin/getNttList",
			success: function(result) {
				let html = "";
				let res = "";
				let resLeng = result.length;
				
				if ( resLeng <= 0 ) {
					html += `<li>게시물이 존재하지 않습니다.</li>`;	
				} else {
					for ( let i = 0; i < result.length; i++ ) {
						res = result[i];
						html += `<li>\${i + 1}. \${res.nttNm}</li>`;	
					}
				}
				
				$("#nttListSpan").html(html);
			}
		});
	} // end getNttList
	
	// 숫자 카운트 효과
	function countingNumber(target, num) {
		if (num == 0) {
			$(`\${target}`).html('0');
		} else if (num < 0) {
			num = Math.abs(num);	// 음수를 양수로 변환
			
			const each = Math.ceil(num/33);	// 입력한 숫자를 33번에 걸쳐 0부터 올림
			let time = 0

		    for (let i = 0; i <= num; i += each) {
				setTimeout(() => { $(`\${target}`).html("-" + i); }, 20 * time);

				// 33으로 나누어 떨어지지않는 숫자를 마지막에 해당 숫자로 만들어주기 위함
				if ( (i + each) > this.num ) {
					setTimeout(() => { $(`\${target}`).html("-" + num); }, 20 * (time + 1));
				}
				time++;
			}
		} else {
			const each = Math.ceil(num/33);	// 입력한 숫자를 33번에 걸쳐 0부터 올림
			let time = 0

		    for (let i = 0; i <= num; i += each) {
				setTimeout(() => { $(`\${target}`).html(i); }, 20 * time);

				// 33으로 나누어 떨어지지않는 숫자를 마지막에 해당 숫자로 만들어주기 위함
				if ( (i + each) > this.num ) {
					setTimeout(() => {  $(`\${target}`).html(num);  }, 20 * (time + 1));
				}
				time++;
			}
		}
	} // end countingNumber
	
	// 전날과 비교해서 방문자 수와 회원가입한 회원 수를 조회하는 메서드
	function getCmprBfeCo() {
		$.ajax({
			type: "get",
			url: "/admin/getCmprBfeCo",
			success: function(result) {
				let visitrCo = result.visitrCo;
				let mberSbscrbCo = result.mberSbscrbCo;
				
				if (visitrCo >= 0) {
					$("#cmprBfeVisitr").attr("class", "svg-inline--fa fa-turn-up");
				} else {
					$("#cmprBfeVisitr").attr("class", "svg-inline--fa fa-turn-down");
				}
				
				if (mberSbscrbCo >= 0) {
					$("#cmprBfeMberSbscrb").attr("class", "svg-inline--fa fa-turn-up");
				} else {
					$("#cmprBfeMberSbscrb").attr("class", "svg-inline--fa fa-turn-down");
				}
				
				countingNumber("#cmprBfeVisitrSpan", visitrCo);
				countingNumber("#cmprBfeMberSbscrbSpan", mberSbscrbCo);
			}
		});
	} // end getCmprBfeCo
	
	// 오늘 로그인한 회원 수를 구하는 메서드
	function getTodayLoginCo() {
		$.ajax({
			type: "get",
			url: "/admin/getTodayLoginCo",
			success: function(result) {
				countingNumber("#loginCoSpan", result);
			}
		});
	} // end getTodayLoginCo
	
	// 총 방문자 수를 구하는 메서드
	function getTotalVisitrCo() {
		$.ajax({
			type: "get",
			url: "/admin/getTotalVisitrCo",
			success: function(result) {
				countingNumber("#totalVisitrCoSpan", result);
			}
		});
	} // end getTotalVisitrCo
	
	// 브라우저 수를 구하는 메서드
	function getHmpgBrwsrCo() {
		$.ajax({
			type: "get",
			url: "/admin/getHmpgBrwsrCo",
			dataType: "json",
			success: function(result) {
				let brwsrSum = result.brwsrSum;
				let brwsrChromeCo = result.brwsrChromeCo;
				let brwsrEdgeCo = result.brwsrEdgeCo;
				let brwsrWhaleCo = result.brwsrWhaleCo;
				let brwsrEtcCo = result.brwsrEtcCo;
				
				let chromPer = 0.0;
				let edgePer = 0.0;
				let whalePer = 0.0;
				let etcPer = 0.0;
				
				if (brwsrSum !== 0) { 
					chromPer = Math.floor(brwsrChromeCo/brwsrSum * 100);
					edgePer = Math.floor(brwsrEdgeCo/brwsrSum * 100);
					whalePer = Math.floor(brwsrWhaleCo/brwsrSum * 100);
					etcPer = Math.floor(brwsrEtcCo/brwsrSum * 100);
				}
				
				$("#chromSpan").html(chromPer);
				$("#edgeSpan").html(edgePer);
				$("#whaleSpan").html(whalePer);
				$("#etcSpan").html(etcPer);
				
			}
		});
	} // end getHmpgBrwsrCo
	
	// 신고 게시물 처리 프로세스
	function complaintTask() {
		getComplaintNtt()											// 전체 신고 게시물 개수
			.then( (totalCnt) => getTodayComplaintNtt(totalCnt) )	// 오늘 접수된 신고 게시물
				.then( (todayCnt) => {
					getUncnfrmComplaintNtt(todayCnt);				// 미확인 신고 게시물
					getNoProblemComplaintNtt(todayCnt);				// 이상없음 처리된 게시물
					getStopComplaintNtt(todayCnt);					// 정지 처리된 게시물
				});
	}
	
	// 정지 처리된 게시물
	function getStopComplaintNtt(todayCnt) {
		$.ajax({
			type: "get",
			url: "/admin/getStopComplaintNtt",
			success: function(result) {
				countingNumber("#stopCnt", result);
				
				let per = 0;
				if (todayCnt !== 0) { per = Math.floor(result/todayCnt * 100); }
				
				$(".stopPerSpan").html(per);
				$(".stopPerDiv").css('width', per + '%');
			}
		});
	} // end getStopComplaintNtt
	
	// 이상 없음 처리된 게시물
	function getNoProblemComplaintNtt(todayCnt) {
		$.ajax({
			type: "get",
			url: "/admin/getNoProblemComplaintNtt",
			success: function(result) {
				countingNumber("#noProblemCnt", result);
				
				let per = 0;
				if (todayCnt !== 0) { per = Math.floor(result/todayCnt * 100); }
				
				$(".noProblemPerSpan").html(per);
				$(".noProblemPerDiv").css('width', per + '%');
			}
		});
	} // end getNoProblemComplaintNtt
	
	// 미확인 신고 게시물
	function getUncnfrmComplaintNtt(todayCnt) {
		$.ajax({
			type: "get",
			url: "/admin/getUncnfrmComplaintNtt",
			success: function(result) {
				countingNumber("#uncnfrmCnt", result);
				
				let per = 0;
				if (todayCnt !== 0) { per = Math.floor(result/todayCnt * 100); }
				
				$(".uncnfrmPerSpan").html(per);
				$(".uncnfrmPerDiv").css('width', per + '%');
			}
		});
	} // end getUncnfrmComplaintNtt
	
	// 오늘 접수된 신고 게시물
	function getTodayComplaintNtt(totalCnt) {
		return new Promise((resolve, reject) => {
			$.ajax({
				type: "get",
				url: "/admin/getTodayComplaintNtt",
				success: function(result) {
					resolve(result);	// 오늘 접수된 신고 게시물 개수 리턴
					
					countingNumber("#todayCnt", result);
					
					let per = 0;
					if (totalCnt !== 0) { per = Math.floor(result/totalCnt * 100); }
					
					$(".todayPerSpan").html(per);
					$(".todayPerDiv").css('width', per + '%');
				}
			});
		});	// end return
	} // end loadTodayComplaintNtt
	
	// 전체 신고 게시물 개수
	function getComplaintNtt() {
		return new Promise((resolve, reject) => {
			$.ajax({
				type: "get",
				url: "/admin/getComplaintNtt",
				success: function(result) {
					resolve(result);	// 전체 신고 게시물 개수 리턴
				}
			});
		}); // end return
	} // end loadComplaintNtt
	
</script>
<!-- start 신고 게시물 부분 -->
<div class="analytics-sparkle-area">
	<div class="container-fluid">
		<div class="row">
			<div class="col-lg-3 col-md-6 col-sm-6 col-xs-12">
				<div class="analytics-sparkle-line reso-mg-b-30">
					<div class="analytics-content">
						<h5>오늘 접수된 신고 게시물</h5>
						<h2><span id="todayCnt"></span> <span class="tuition-fees">개(개수)</span></h2>
						<span class="text-success"><span class="todayPerSpan"></span>%</span>
						<div class="progress m-b-0">
							<div class="progress-bar progress-bar-danger todayPerDiv" role="progressbar" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100" style="width: 0%;">
								<span class="sr-only"><span class="todayPer"></span>% Complete</span> 
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="col-lg-3 col-md-6 col-sm-6 col-xs-12">
				<div class="analytics-sparkle-line reso-mg-b-30">
					<div class="analytics-content">
						<h5>미확인 신고 게시물</h5>
						<h2><span id="uncnfrmCnt"></span> <span class="tuition-fees">개(개수)</span></h2>
						<span class="text-danger"><span class="uncnfrmPerSpan"></span>%</span>
						<div class="progress m-b-0">
							<div class="progress-bar progress-bar-success uncnfrmPerDiv" role="progressbar" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100" style="width: 0%;">
								<span class="sr-only"><span class="uncnfrmPerSpan"></span>% Complete</span> 
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="col-lg-3 col-md-6 col-sm-6 col-xs-12">
				<div class="analytics-sparkle-line reso-mg-b-30 table-mg-t-pro dk-res-t-pro-30">
					<div class="analytics-content">
						<h5>이상 없음 처리된 게시물</h5>
						<h2><span id="noProblemCnt"></span> <span class="tuition-fees">개(개수)</span></h2>
						<span class="text-info"><span class="noProblemPerSpan"></span>%</span>
						<div class="progress m-b-0">
							<div class="progress-bar progress-bar-info noProblemPerDiv" role="progressbar" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100" style="width: 0%;"> 
								<span class="sr-only"><span class="noProblemPerSpan"></span>% Complete</span> 
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="col-lg-3 col-md-6 col-sm-6 col-xs-12">
				<div class="analytics-sparkle-line table-mg-t-pro dk-res-t-pro-30">
					<div class="analytics-content">
						<h5>정지 처리된 게시물</h5>
						<h2><span id="stopCnt"></span> <span class="tuition-fees">개(개수)</span></h2>
						<span class="text-inverse"><span class="stopPerSpan"></span>%</span>
						<div class="progress m-b-0">
							<div class="progress-bar progress-bar-inverse stopPerDiv" role="progressbar" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100" style="width: 0%;">
								<span class="sr-only"><span class="stopPerSpan"></span>% Complete</span>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- end 신고 게시물 부분 -->

<!-- start 그래프 부분 -->
<div class="product-sales-area mg-tb-30">
	<div class="container-fluid">
		<div class="row">
			<div class="col-lg-6 col-md-12 col-sm-12 col-xs-12">
				<div class="caption pro-sl-hd">
					<span class="caption-subject"><b>일별 방문자 수</b></span>
				</div>
				<canvas id="chartDiv"></canvas>
			</div>
			<div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
				<div class="white-box">
					<h3 class="box-title">접속한 브라우저</h3>
					<ul class="basic-list">
						<li>Google Chrome <span class="pull-right label-danger label-1 label"><span id="chromSpan"></span>%</span></li>
						<li>Naver Whale <span class="pull-right label-purple label-2 label"><span id="whaleSpan"></span>%</span></li>
						<li>Microsoft Edge <span class="pull-right label-success label-3 label"><span id="edgeSpan"></span>%</span></li>
						<li>Other <span class="pull-right label-purple label-7 label"><span id="etcSpan"></span>%</span></li>
					</ul>
				</div>
			</div>
			<div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
				<div class="white-box">
					<h3 class="box-title">게시물 조회수 순위</h3>
					<ul class="basic-list"><span id="nttListSpan"></span></ul>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- end 그래프 부분 -->

<!-- start 방문객 부분 -->
<div class="traffice-source-area mg-b-30">
	<div class="container-fluid">
		<div class="row">
			<div class="col-lg-3 col-md-6 col-sm-6 col-xs-12">
				<div class="white-box analytics-info-cs">
					<h3 class="box-title">총 방문자 수</h3>
					<ul class="list-inline two-part-sp">
						<li>
							<div id="sparklinedash"><canvas width="67" height="30" style="display: inline-block; width: 67px; height: 30px; vertical-align: top;"></canvas></div>
						</li>
						<li class="text-right sp-cn-r"><i class="fa fa-level-up" aria-hidden="true"></i> <span id="totalVisitrCoSpan" class="text-success"></span></li>
					</ul>
				</div>
			</div>
			<div class="col-lg-3 col-md-6 col-sm-6 col-xs-12">
				<div class="white-box analytics-info-cs res-mg-t-30 table-mg-t-pro-n">
					<h3 class="box-title">전날 대비 홈페이지 방문자 수</h3>
					<ul class="list-inline two-part-sp">
						<li>
						 	<div id="sparklinedash2"><canvas width="67" height="30" style="display: inline-block; width: 67px; height: 30px; vertical-align: top;"></canvas></div>
						</li>
						<li class="text-right graph-two-ctn"><i id="cmprBfeVisitr" class="fa fa-level-up" aria-hidden="true"></i> <span id="cmprBfeVisitrSpan" class="text-purple"></span></li>
					</ul>
				</div>
			</div>
			<div class="col-lg-3 col-md-6 col-sm-6 col-xs-12">
				<div class="white-box analytics-info-cs res-mg-t-30 res-tablet-mg-t-30 dk-res-t-pro-30">
					<h3 class="box-title">오늘 로그인한 회원 수</h3>
					<ul class="list-inline two-part-sp">
					<li>
						<div id="sparklinedash3"><canvas width="67" height="30" style="display: inline-block; width: 67px; height: 30px; vertical-align: top;"></canvas></div>
					</li>
					<li class="text-right graph-three-ctn"><i class="fa fa-level-up" aria-hidden="true"></i> <span id="loginCoSpan" class="text-info"></span></li>
					</ul>
				</div>
			</div>
			<div class="col-lg-3 col-md-6 col-sm-6 col-xs-12">
				<div class="white-box analytics-info-cs res-mg-t-30 res-tablet-mg-t-30 dk-res-t-pro-30">
					<h3 class="box-title">전날 대비 회원 가입한 회원 수</h3>
					<ul class="list-inline two-part-sp">
						<li>
							<div id="sparklinedash4"><canvas width="67" height="30" style="display: inline-block; width: 67px; height: 30px; vertical-align: top;"></canvas></div>
						</li>
						<li class="text-right graph-four-ctn"><i id="cmprBfeMberSbscrb" class="fa fa-level-down" aria-hidden="true"></i> <span id="cmprBfeMberSbscrbSpan" class="text-danger"></span></li>
					</ul>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- end 방문객 부분 -->