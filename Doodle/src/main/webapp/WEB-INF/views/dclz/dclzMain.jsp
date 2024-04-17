<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<link rel="stylesheet" href="/resources/css/mainPage.css">

<style>
#dclzMain {
	width :1400px;
	margin:auto;
}

#dclzMain > h3{
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

#dclzMain > h3 > img{
	width:50px;
}

.product-status-wrap img {
	height:20px;
	width:auto;
}

</style>

<script>
// 출결 정보 get
const getAllDclz = function(){
	let returnData;
	
	$.ajax({
		url :"/dclz/getAllDclz",
	    type:"post",
	    contentType:"application/json",
	    dataType:"json",
	    async: false,
	    beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success : function(res) {
			console.log("getAllDclz:",res);
			returnData = res;
		},
		 error:function(request,status,error){
			 alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		 }
	})
	
	return returnData;
}
// 반학생 목록 get
const getAllClasStd = function(){
	let returnData;
	
	$.ajax({
		url :"/dclz/getAllClasStd",
	    type:"post",
	    contentType:"application/json",
	    dataType:"json",
	    async: false,
	    beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success : function(res) {
			console.log("getAllClasStd:",res);
			returnData = res;
		},
		 error:function(request,status,error){
			 alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		 }
	})
	
	return returnData;
	
}

// (학생)출석 버튼
const insertStdDclz = function(){
	$.ajax({
		url :"/dclz/insertStdDclz",
	    type:"post",
	    contentType:"application/json",
	    dataType:"json",
	    beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success : function(res) {
			console.log("insertStdDclz:",res);
			if(res > 0){
				cjh.swAlert("완료", "출결 처리가 완료되었습니다.", "success");
				drawDclzTb();
			}else{
				cjh.swAlert("실패", "출결 처리에 실패했습니다.", "error");
			}
		},
		 error:function(request,status,error){
			 alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		 }
	})
}
// (교사)학생 출석 버튼
const insertDclz = function(cscode ,nm , day){
	event.stopPropagation();
	
	<sec:authorize access="hasRole('A01002')">
	cjh.swConfirm("출결 처리",  nm +" 학생의 "+ day + " 출결을 처리하시겠습니까?", "warning").then(function(res){
		if(res.isConfirmed){
			$.ajax({
				url :"/dclz/insertDclz",
			    type:"post",
			    data:cscode,
			    contentType:"application/json",
			    dataType:"json",
			    beforeSend:function(xhr){
					xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
				},
				success : function(res) {
					console.log("insertDclz:",res);
					if(res > 0){
						cjh.swAlert("완료", "출결 처리가 완료되었습니다.", "success");
					}else{
						cjh.swAlert("실패", "출결 처리에 실패했습니다.", "error");
					}
				},
				 error:function(request,status,error){
					 alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				 }
			})
		}
	})
	</sec:authorize>
}

//출결 정보 테이블 리스트로 생성
const makeDclzStr = function(){
	console.log("startDateFilter:",startDateFilter);
	console.log("endDateFilter:",endDateFilter);
	console.log("stdFilter:",stdFilter);
	
	if(stdFilter == "not"){
		return `<tr><td colspan = "100%" style ="text-align:center;">학생을 선택해주세요..</td></tr>`;
	}
	
	let str = ""; // return data
	let role = "";
	<sec:authorize access="hasRole('A01002')">
	role = "tch";
	</sec:authorize>
	
	// 날짜
	dclzRes.forEach(function(day,index1){
		if(startDateFilter > day.dtDt || endDateFilter < day.dtDt){
			return;
		};
		
		let dayStr = JSON.stringify(day);
		
		if(role =="tch" && stdFilter == 'all'){
			str += `<tr><th  colspan ="100%" style = "text-align:center;">\${day.dtDt}</th></tr>`
		}

		// 학생
		day.stdList.forEach(function(std,index2){
			if (role == 'tch' && stdFilter != "all" && stdFilter != std.clasStdntCode){
				return;
			}
			
			let stdStr = JSON.stringify(std);
			
			// 결석
			if(std.timeList.length == 0){
				
				str += `<tr onclick ="extendTr('CS\${std.clasStdntCode}_noData')" class = "d-tr">
						<td>\${day.dtDt}</td>
						<td>\${std.clasInNo}</td>
						<td>\${std.mberNm}</td>
						<td>출석 없음</td>
						<td>출석 없음</td>
						<td>결석</td>`;
				
				// 공결 문서 
				if(std.sanctnList.length != 0){
					str += `<td style ="text-align:center;"><img onclick ='clickDoc(\${JSON.stringify(std.sanctnList)})' src ="/resources/images/classRoom/freeBrd/free-file-solid.png" class ="san-img"></td>`;
				}else{
					str += `<td></td>`;
				}
						
				<sec:authorize access ="hasRole('A01003')">
				str +=	`
						<td style ="text-align:center;">
							<button class = "d-btn-blue" style ="width:100%; max-width:150px;"
							onclick ="subDoc()">제출 하기</button>
						</td>`;
				</sec:authorize>
						
				<sec:authorize access="hasRole('A01002')">
				str +=	`
						<td style ="text-align:center;">
							<button class = "d-btn-blue" style ="width:100%; max-width:150px;"
							onclick ="changeStatus('\${std.clasStdntCode}' , '\${std.mberNm}', '\${day.dtDt}')">변경</button>
						</td>
						<td style ="text-align:center;">`;
						
				if(cjh.isUnderToday(day.dtDt)){
					str +=	`<button class ="d-div-gray" style ="width:100%; max-width:150px;">불가</button>`;
				}else{
					str +=	`<button class ="d-btn-blue" style ="width:100%; max-width:150px;"
							onclick = "insertDclz('\${std.clasStdntCode}' , '\${std.mberNm}', '\${day.dtDt}')">출결</button>
							`;
				}
				
				str +=	`</td>
						</tr>`
				</sec:authorize>
				
				return;
			}
			
			// 시간
			std.timeList.forEach(function(time,index3){
				let timeStr = JSON.stringify(time);
				let nullTimeStr = 

				str += `<tr onclick ="extendTr('\${std.clasStdntCode}_\${day.dtDt}')" class = "d-tr">`;
				// 전체 정보
				if(index3 == 0){
					str += `
							<td>\${day.dtDt}</td>
							<td>\${std.clasInNo}</td>
							<td>\${std.mberNm}</td>
							<td>\${nullStr(std.timeList[0].dclzProcessTime, "출석 없음")}</td>
							<td>\${nullStr(std.timeList[std.timeList.length-1].dclzProcessTime, "출석 없음")}</td>
							<td>\${std.dclzCmmnNm}</td>`;
							
					// 공결 문서 
					if(std.sanctnList.length != 0){
						str += `<td style ="text-align:center;"><img onclick ='clickDoc(\${JSON.stringify(std.sanctnList)})' src ="/resources/images/classRoom/freeBrd/free-file-solid.png" class ="san-img"></td>`;
					}else{
						str += `<td></td>`;
					}
							
					<sec:authorize access ="hasRole('A01003')">
					str +=	`
							<td style ="text-align:center;">
								<button class = "d-btn-blue" style ="width:100%; max-width:150px;"
								onclick ="subDoc()">제출 하기</button>
							</td>`;
					</sec:authorize>
							
					<sec:authorize access="hasRole('A01002')">
						str +=	`
								<td style ="text-align:center;">
									<button class = "d-btn-blue" style ="width:100%; max-width:150px;"
									onclick ="changeStatus( '\${std.clasStdntCode}' , '\${std.mberNm}', '\${day.dtDt}' )">변경</button>
								</td>
								<td style ="text-align:center;">`;
								
						if(cjh.isUnderToday(day.dtDt)){
							str +=	`<button class ="d-div-gray" style ="width:100%; max-width:150px;">불가</button>`;
						}else{
							str +=	`<button class ="d-btn-blue" style ="width:100%; max-width:150px;"
									onclick = "insertDclz( '\${std.clasStdntCode}' , '\${std.mberNm}', '\${day.dtDt}' )">출결</button>
									`;
						}
						
						str +=	`</td>
								</tr>`;
					</sec:authorize>
				}

				// 상세
				// 상세 1개이며 출결 시간 없는 경우 (=공결처리) 표기 안함
				if(std.timeList.length ==1 && time.dclzProcessTime == null){
					return;
				}
				str += `<tr class ="CS\${std.clasStdntCode}_\${day.dtDt}" style ="display:none; background-color:#f5f5f5;">
						<td></td><td></td><td>[\${index3+1}]</td>`;
						
				if(index3%2 == 0){
					str +=	`<td>\${nullStr(time.dclzProcessTime, "-")}</td>
							<td>-</td>`;
				}else{
					str +=	`<td>-</td>
							<td>\${nullStr(time.dclzProcessTime, "-")}</td>`;
				}
				str +=	`<td></td><td></td><td></td>`;
						
				if(role =="tch"){
					str+=	`<td></td>
							`;
				}
				str += `</tr>`;
			
			})
		})
	})
	
	return str;
}

const nullStr = function(str, wantStr){
	if(str == null){return wantStr;}
	return str;
}

// 출결 리스트 테이블 그리기
const drawDclzTb = function(){
	let str = makeDclzStr(dclzRes);
	if(str != ''){
		document.querySelector("#dclzListTb tbody").innerHTML = str;
	}
}

// 행 펼치기 접기
const extendTr = function(trCl){
	let targets = document.querySelectorAll(".CS"+trCl);
	
	targets.forEach(function(target){
		if(target.style.display == "none"){
			target.style.display ="table-row";
		}else{
			target.style.display ="none";
		}
	})
}


// 필터링
const startTimeSelect = function(date){
	startDateFilter = date;
	drawDclzTb();
}
const endTimeSelect = function(date){
	endDateFilter = date;
	drawDclzTb();
}
const stdSelect = function(std){
	stdFilter = std;
	drawDclzTb();
}
// 학생 필터링 set
const setStdSelect = function(){
	<sec:authorize access="hasRole('A01002')">
	
	let dom = document.querySelector("#stdSelect");
	clasStdRes.forEach(function(std){
		let temp = document.createElement("option");
		temp.value = `\${std.clasStdntCode}`;
		temp.innerHTML = `\${std.clasInNo} \${std.mberNm}`;
		dom.append(temp);
	})
	</sec:authorize>
}

// 출결 처리 상태 변경
const changeStatus = function(stdClasCode, std, dtDt){
	event.stopPropagation();
	
	<sec:authorize access="hasRole('A01002')">
	let inputData = {};
	
	if(dclzCmmnRes == null){
		dclzCmmnRes = getDclzCmmn();
	}
	
	dclzCmmnRes.forEach(function(cmmn){
		inputData[cmmn.cmmnDetailCode] = cmmn.cmmnDetailCodeNm ;
	})
	
	cjh.swSelect(inputData, '출결 처리 상태 변경', std+" " + dtDt+" 출결 처리 상태를 선택하세요.")
	.then(function(res){
		if(res == '' || res == null){
			// 취소
		} else{
			// 변경 로직
// 			console.log("res:",res);
			let cnt = updateDclzCmmn(stdClasCode, dtDt, res);
			if(cnt >0){
				cjh.swAlert("완료","출결 처리 상태 변경이 완료되었습니다.").
				then(function(){
					history.go(0);
				})
			}else{
				cjh.swAlert("실패", "출결 처리 상태 변경에 실패했습니다." ,"error");
			}
		}
	})
	</sec:authorize>
}

// 출결 상태 값 목록
const getDclzCmmn = function(){
	let returnData = "";
	
	$.ajax({
		url :"/dclz/getDclzCmmn",
	    type:"post",
	    contentType:"application/json",
	    dataType:"json",
	    async : false,
	    beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success : function(res) {
			console.log("getDclzCmmn:",res);
			returnData = res;
		},
		error:function(request,status,error){
			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	})
	
	return returnData;
}

// 출결 상태 변경
const updateDclzCmmn = function(clasStdntCode, dtDt, res){
	let returnData = "";
	
	$.ajax({
		url :"/dclz/updateDclzCmmn",
	    type:"post",
	    data : JSON.stringify({clasStdntCode:clasStdntCode,
	    	   dtDt:dtDt,
	    	   cmmnDetailCode:res
	    }),
	    contentType:"application/json",
	    dataType:"json",
	    async : false,
	    beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success : function(res) {
// 			console.log("getDclzCmmn:",res);
			returnData = res;
		},
		error:function(request,status,error){
			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	})
	
	return returnData;
}

// 서류 읽기
const clickDoc = function(p){
	event.stopPropagation();
	
	let str ="";
	
	for(let i =0 ; i < p.length ; ++i){
		str += `<tr class = "d-tr" onclick ="openDoc('\${p[i].docCode}')">
				<td>\${dateFormat(p[i].rqstDe)}</td>
				<td>\${p[i].cmmnDocKndNm}</td>
				<td>\${cutStr(p[i].lrnStle,15)}</td>
				`;
		
		if(p[i].cmmnProcessSttus == 'A11001' || p[i].cmmnProcessSttus == 'A11005'){
			str += `<td><div class ="d-div-blue">`;
		}else if(p[i].cmmnProcessSttus == 'A11002'){
			str += `<td><div class ="d-div-green">`;
		}else if(p[i].cmmnProcessSttus == 'A11003'){
			str += `<td><div class ="d-div-yellow">`;
		}else if(p[i].cmmnProcessSttus == 'A11004'){
			str += `<td><div class ="d-div-red">`;
		}
		
		str += `\${p[i].cmmnProcessSttusNm}</div></td></tr>`;
				
	}
	document.querySelector("#docListModal tbody").innerHTML = str;
	
	$("#docListModal").modal('show');
}

const openDoc = function(docCode){
	location.href="/approval/approvalDetail?docCode="+docCode;
}

// 서류 제출 하기
const subDoc = function(clasStdntCode, dtDt){
	event.stopPropagation();
	
	<sec:authorize access="hasRole('A01001')">
	location.href = "/approval/approvalList?clasStdntCode=${CLASS_STD_INFO.clasStdntCode}";
	</sec:authorize>
}


let dclzDone = false; // 데이터 get 종료되었는지
const dclzRes = getAllDclz(); // 모든 출결 데이터
<sec:authorize access="hasRole('A01002')">
let clasStdDone = false; // 데이터 get 종료되었는지
const clasStdRes = getAllClasStd(); // 모든 반학생
let dclzCmmnRes = null; // 출결 상태 값
</sec:authorize>

let stdFilter = null; // 학생 필터링
let startDateFilter = null; // 시작일 필터링
let endDateFilter = null; // 종료일 필터링

window.onload = function(){
	let sel = document.querySelector("#stdSelect");
	<sec:authorize access="hasRole('A01002')">
	stdFilter = sel.options[sel.selectedIndex].value;
	setStdSelect();
	</sec:authorize>
	drawDclzTb();
}
</script>
   
<div id ="dclzMain">

	<h3><img src ="/resources/images/schedule/scheduleIcon2.png">출결<img src ="/resources/images/schedule/scheduleIcon2.png"></h3>
	
	<div  class ="box" style ="margin-bottom: 40px;">

		<div>
			<sec:authorize access ="hasRole('A01001')">
			<button onclick = "insertStdDclz()" class = "d-btn-blue" style ="width:320px; height:50px; margin-bottom: 20px;">출석</button>
			</sec:authorize>
			
			<div class="">
				<!-- 날짜 필터링 -->
				<input type ="date" onchange="startTimeSelect(this.value)" class ="d-sel-blue">
				<input type ="date" onchange="endTimeSelect(this.value)"   class ="d-sel-blue">
				<!-- 학생 필터링 -->
				<sec:authorize access="hasRole('A01002')">
				<select id = "stdSelect" onchange="stdSelect(this.value)" class ="d-sel-blue">
					<option value ="not">학생을 선택하세요..</option>
					<option value ="all" selected>전체 학생</option>
				</select>
				</sec:authorize>
			</div>
		</div>
		
		<div class="">
			<div class="product-status mg-b-15">
				<div class="container-fluid">
					<div class="row">
						<div class="product-status-wrap" style="position: relative;">
							<div class="add-product">
							</div>
							<div class="asset-inner">
								<table id ="dclzListTb">
									<thead>
										<tr>
											<th style ="width:10%">날짜</th>
											<th style ="width:5%">학급 번호</th>
											<th style ="width:10%">학생 명</th>
											<th style ="width:10%">등교 시간</th>
											<th style ="width:10%">하교 시간</th>
											<th style ="width:7%">출결 처리</th>
											<th style ="width:7%; text-align:center;">제출 서류</th>
		
											<sec:authorize access ="hasRole('A01003')">
											<th style = "width:10%; text-align:center;">제출하기</th>
											</sec:authorize>
											
											<sec:authorize access ="hasRole('A01002')">
											<th style = "width:10%; text-align:center;">처리 상태 변경</th>
											<th style = "width:10%; text-align:center;">출결</th>
											</sec:authorize>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td colspan="100%" style="text-align: center;">등록된 출석이 없습니다..</td>
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
	
	<!-- modal -->
	<div id="docListModal" class="modal modal-edu-general default-popup-PrimaryModal fade"role="dialog">
	
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-close-area modal-close-df">
					<a class="close" data-dismiss="modal" href="#"> <i
						class="fa fa-close"></i></a>
				</div>
				<div class="modal-body">
					<h3>제출 서류 목록</h3>
					<div class="product-status-wrap drp-lst overflow-scroll" style ="padding : 0px">
						<table id = "docListTb">
							<thead>
						        <tr>
							      <th>신청일</th>
							      <th>문서 종류</th>
							      <th>학습 명</th>
							      <th style="text-align: center; width:10%;">처리 상태</th>
						        </tr>
							</thead>
						    <tbody>
					        </tbody>
					    </table>
					</div>
				</div>
				<div class="modal-footer">
					<a data-dismiss="modal" href="#">취소</a>
				</div>
			</div>
		</div>
	</div>
</div>
