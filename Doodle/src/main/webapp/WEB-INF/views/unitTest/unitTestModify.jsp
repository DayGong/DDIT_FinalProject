<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script type="text/javascript" src="/resources/js/commonFunction.js"></script>
<script type="text/javascript" src="/resources/js/cjh.js"></script>  
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<style>
.unitTestModify {
	width :1400px;
	margin:auto;
}

.unitTestModify > h3{
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

.unitTestModify > h3 > img{
	width:50px;
}

</style>

<script>
var unitEvlCode = ""; // 단원평가 코드
var cnt = 0; // 문항 수 
window.onload = function(){
	
	let quesDiv = document.querySelector("#quesDiv"); // 복사할 원본
	let addDiv = document.querySelector("#addDiv");    // 붙여넣기할 위치
	init();
}

const init = function(){
	
	$.ajax({
		url :"/unitTest/getUnitTestDetail",
	    type:"post",
	    data:"${unitEvlCode}",
	    contentType:"application/json",
	    dataType:"json",
	    async: false,
	    beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success : function(res) {
			if(res==null || res==""){
				alert("정보 로딩 실패");
				return;
			}
			
			console.log("res",res);
			unitEvlCode = res.unitEvlCode; // 단원평가 코드 저장
			
			/*
			단원평가 기본 정보
			*/
			let startDate = dateToMinFormat(res.unitEvlBeginDt);
			startDate     = startDate.split(" ");
			let startYmd  = startDate[0];
			let startHm   = startDate[1];
			
			let endDate   = dateToMinFormat(res.unitEvlEndDt);
			endDate       = endDate.split(" ");
			let endYmd    = endDate[0];
			let endHm     = endDate[1];
			
			let title     = cjh.selOne("#title").value   = res.unitEvlNm;
			let startDt   = cjh.selOne("#startDt").value = startYmd;
			let endDt     = cjh.selOne("#endDt").value   = endYmd;
			let startTm   = cjh.selOne("#startTm").value = startHm;
			let endTm     = cjh.selOne("#endTm").value   = endHm;
			
			/*
			답안
			*/
			res.quesVOList.forEach(function(item, idx){
				let clone = null;
				let cloneId = null;				
				
				if(idx == 0){ // 첫번째 항목은 있는 원본 사용
					cloneId = quesDiv.id;
					cnt++; // 원본은 처음부터 id1 처럼 넘버링이 되어있기 때문에 더해준 값을 붙이지 않는다.					
					
				}else { // 두번째 항목부터 복사
					clone = quesDiv.cloneNode(true);
					cloneId = clone.id;

					// 메인 div id 변경
					cloneId = cloneId + ++cnt;
					clone.id = cloneId;
					
					// 문서 붙여넣기
					addDiv.append(clone);
				}
				
				
				// 요소 찾기
				let quesNo     = cjh.selOne("#"+cloneId+" .no")          ;
				let quesQues   = cjh.selOne("#"+cloneId+" .ques")        ;
				let quesCnsr   = cjh.selAll("#"+cloneId+" .cnsr")        ;
				let quesAllot  = cjh.selOne("#"+cloneId+" .allot")       ;
				let quesExplna = cjh.selOne("#"+cloneId+" .explna")      ;

				noLabels       = cjh.selOne("#"+cloneId+" .noLabel")     ;
				quesLabels     = cjh.selOne("#"+cloneId+" .quesLabel")   ;
				allotLabels    = cjh.selOne("#"+cloneId+" .allotLabel")  ;
				cnsrLabels     = cjh.selOne("#"+cloneId+" .cnsrLabel")   ;
				explnaLabels   = cjh.selOne("#"+cloneId+" .explnaLabel") ;
				
// 				console.log("quesNo",quesNo);
// 				console.log("quesQues",quesQues);
				console.log("quesCnsr",quesCnsr);
// 				console.log("quesAllot",quesAllot);
// 				console.log("quesExplna",quesExplna);
// 				console.log("noLabels",noLabels);
// 				console.log("quesLabels",quesLabels);
// 				console.log("allotLabels",allotLabels);
// 				console.log("cnsrLabels",cnsrLabels);
// 				console.log("explnaLabels",explnaLabels);
				
				// id, name, value 변경
				quesNo.innerHTML = idx+1+"번 문제";
				quesQues.id      = "quesQues"  +cnt;
				quesQues.name    = "quesQues"  +cnt;
				quesQues.innerHTML = item.quesQues;
				for(let i =0 ; i<quesCnsr.length; ++i){
// 					quesCnsr[i].id      = "quesCnsr"  +cloneId;
					quesCnsr[i].name    = "quesCnsr"  +cnt;
					console.log("quesCnsr["+i+"].name:"+quesCnsr[i].name);
					console.log("quesCnsr["+i+"].value:"+quesCnsr[i].value);
					console.log("item.quesCnsr:"+item.quesCnsr);
					if(quesCnsr[i].value == item.quesCnsr){
						quesCnsr[i].checked = true;
					}
				}
				
				let temp = cjh.selAll("#"+cloneId+" .cnsr");
				console.log("temp : ",temp);
				for (let i = 0; i < temp.length; ++i){
					console.log("test snsr selected:",temp[i].checked);
				}
				
				quesAllot.id     = "quesAllot" +cnt;
				quesAllot.name   = "quesAllot" +cnt;
				quesAllot.value  = item.quesAllot;
				quesExplna.id    = "quesExplna"+cnt;
				quesExplna.name  = "quesExplna"+cnt;
				quesExplna.innerHTML = item.quesExplna;
				
				noLabels.setAttribute(    "for", "quesNo"    +cnt);
				quesLabels.setAttribute(  "for", "quesQues"  +cnt);
				allotLabels.setAttribute( "for", "quesCnsr"  +cnt);
				cnsrLabels.setAttribute(  "for", "quesAllot" +cnt);
				explnaLabels.setAttribute("for", "quesExplna"+cnt);
				
			});

			// textarea 높이 조절
			document.querySelectorAll("textarea").forEach(function(item, idx){
				item.addEventListener('change', autoTextareaSize(item));
			});
		}
	});
}

// textarea 높이 자동 조절 
const autoTextareaSize = function(me){
	me.style.height = 'auto';
	me.style.height = me.scrollHeight + 35 + 'px';
}

const addQues = function(){
    cnt ++;
    let str = "";
    str += `<hr>
			<!-- 문제 번호 -->
			<div class="form-group-inner">
				<div class="row">
					<div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
						<label class="login2 pull-right pull-right-pro">\${cnt}번 문제</label>
					</div>
					<div class="col-lg-9 col-md-9 col-sm-9 col-xs-12">
					</div>
				</div>
			</div>
			
			<!-- 지문 -->
			<div class="form-group-inner">
				<div class="row">
					<div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
						<label class="login2 pull-right pull-right-pro" for="quesQues\${cnt}">지문</label>
					</div>
					<div class="col-lg-9 col-md-9 col-sm-9 col-xs-12">
						<textarea rows="2" class ="form-control ques" name = "quesQues\${cnt}" id ="quesQues\${cnt}"></textarea>
					</div>
				</div>
			</div>
			
			<!-- 배점 -->
			<div class="form-group-inner">
				<div class="row">
					<div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
						<label class="login2 pull-right pull-right-pro" for="quesAllot\${cnt}">배점</label>
					</div>
					<div class="col-lg-9 col-md-9 col-sm-9 col-xs-12">
						<input type="number" class="form-control allot" name ="quesAllot\${cnt}" id="quesAllot\${cnt}">
					</div>
				</div>
			</div>
			
			<!-- 정답 -->
			<div class="form-group-inner">
				<div class="row">
					<div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
						<label class="login2 pull-right pull-right-pro">정답</label>
					</div>
					<div class="col-lg-9 col-md-9 col-sm-9 col-xs-9">
						<div class="bt-df-checkbox">
						<%--
							<input class="pull-left radio-checked cnsr" type="radio" checked=""
							value="O" id="" name="quesCnsr\${cnt}">O
							<input class="pull-left snsr" type="radio"
							value="X" id="" name="quesCnsr\${cnt}">X --%>
							<input class="cnsr" checked type="radio" value="O" id="" name="quesCnsr\${cnt}">O
							<input class="cnsr"         type="radio" value="X" id="" name="quesCnsr\${cnt}">X
						</div>
					</div>
				</div>
			</div>
	
			<!-- 해설 -->
			<div class="form-group-inner">
				<div class="row">
					<div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
						<label class="login2 pull-right pull-right-pro" for="quesExplna\${cnt}">해설</label>
					</div>
					<div class="col-lg-9 col-md-9 col-sm-9 col-xs-12">
						<textarea rows="4" class ="form-control explna" name = "quesExplna\${cnt}" id ="quesExplna\${cnt}"></textarea>
					</div>
				</div>
			</div>
	        `

    let temp = document.createElement("div");
    temp.innerHTML = str;
    addDiv.append(temp);
}

// 문항 삭제
const delQues = function(){
    let targetDom = addDiv.lastChild;
    if(targetDom!=null){
    	targetDom.remove();
        cnt--;
    }
}
// 시험 수정 완료
const completeModify = function(){
	
	let formData = new FormData();
	
	let title     = cjh.selOne("#title").value;
	let startDt   = cjh.selOne("#startDt").value;
	let endDt     = cjh.selOne("#endDt").value;
	let startTm   = cjh.selOne("#startTm").value;
	let endTm     = cjh.selOne("#endTm").value;
	
	// 단원 평가
	formData.append("unitEvlNm",title);
	formData.append("unitEvlBeginDt",startDt + " " + startTm);
	formData.append("unitEvlEndDt",endDt + " " + endTm);	 
	formData.append("unitEvlCode", unitEvlCode);
	
	// 문항
	$(".ques").each(function(idx,ques){
		console.log("quesQues"+idx+":",$(this).val());
		formData.append("quesVOList["+idx+"].quesNo", idx+1);
		formData.append("quesVOList["+idx+"].quesQues", $(this).val());
	});
	$(".allot").each(function(idx,explna){
		console.log("quesAllot"+idx+":",$(this).val());
		formData.append("quesVOList["+idx+"].quesAllot", $(this).val());
	});
	$(".cnsr:checked").each(function(idx,cnsr){
		console.log("quesCnsr"+idx+":",$(this).val());
		formData.append("quesVOList["+idx+"].quesCnsr", $(this).val());
	});
	$(".explna").each(function(idx,explna){
		console.log("quesExplna"+idx+":",$(this).val());
		formData.append("quesVOList["+idx+"].quesExplna", $(this).val());
	});
	
	$.ajax({
        url :"/unitTest/updateUnitTest",
        type:"post",
        processData : false,
		contentType : false,
        data:formData,
        dataType:"text",
        beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
        success:function(res){
            if(res>0){
            	cjh.swAlert("완료","단원평가가 성공적으로 수정되었습니다.","success").then(function(res){
            		if(res.isConfirmed){
						cjh.selOne("#postForm").action ="/unitTest/detail";
						cjh.selOne("#postForm #unitEvlCode").value = unitEvlCode;
						cjh.selOne("#postForm").submit();
            		}
            	});
            }
            else{
            	cjh.swAlert("실패","단원평가 등록에 실패했습니다.","error").then(function(res){
            		if(res.isConfirmed){
            			alert("단원평가 등록에 실패했습니다.");
            		}
            	})
            }
        },
        error:function(xhr){
            console.log(xhr.status);
        }
    })
}

// 시험 생성 취소
const backToList = function(){
	cjh.swConfirm("취소","단원평가 수정을 취소하고 돌아가시겠습니까?","warning").then(function(res){
		if(res.isConfirmed){
			location.href = "/unitTest/list";
		}
	});
}
</script>

<!-- post로 화면 이동 form -->
<form id = "postForm" action ="" method ="post">
	<input type = "text" id ="unitEvlCode" name = "unitEvlCode" value ="" style="display:none;">
	<sec:csrfInput />
</form>


<div class = "unitTestModify">

	<h3><img src ="/resources/images/classRoom/unitTest01.png">단원평가 수정<img src ="/resources/images/classRoom/unitTest01.png"></h3>
	
	<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
		<div class="sparkline12-list">
			<div class="sparkline12-graph">
				<div class="basic-login-form-ad">
					<div class="row">
						<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
							<div class="all-form-element-inner">
								<form action="">
									<div class="form-group-inner">
										<div class="row">
											<div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
												<label class="login2 pull-right pull-right-pro" for="title">단원평가
													제목</label>
											</div>
											<div class="col-lg-9 col-md-9 col-sm-9 col-xs-12">
												<input type="text" class="form-control" id="title">
											</div>
										</div>
									</div>
									<div class="form-group-inner">
										<div class="row">
											<div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
												<label class="login2 pull-right pull-right-pro" for="startDt">시작
													일자</label>
											</div>
											<div class="col-lg-9 col-md-9 col-sm-9 col-xs-12">
												<input type="date" class="form-control" id="startDt">
											</div>
										</div>
									</div>
	
									<div class="form-group-inner">
										<div class="row">
											<div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
												<label class="login2 pull-right pull-right-pro" for="startTm">시작
													시간</label>
											</div>
											<div class="col-lg-9 col-md-9 col-sm-9 col-xs-12">
												<input type="time" class="form-control" id="startTm">
											</div>
										</div>
									</div>
	
									<div class="form-group-inner">
										<div class="row">
											<div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
												<label class="login2 pull-right pull-right-pro" for="endDt">종료
													일자</label>
											</div>
											<div class="col-lg-9 col-md-9 col-sm-9 col-xs-12">
												<input type="date" class="form-control" id="endDt">
											</div>
										</div>
									</div>
	
									<div class="form-group-inner">
										<div class="row">
											<div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
												<label class="login2 pull-right pull-right-pro" for="endTm">종료
													시간</label>
											</div>
											<div class="col-lg-9 col-md-9 col-sm-9 col-xs-12">
												<input type="time" class="form-control" id="endTm">
											</div>
										</div>
									</div>
	
									<div id="quesDiv">
									<hr>
										<!-- 문제 번호 -->
										<div class="form-group-inner">
											<div class="row">
												<div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
													<label class="login2 pull-right pull-right-pro noLabel"><span class ="no">1번
														문제</span></label>
												</div>
												<div class="col-lg-9 col-md-9 col-sm-9 col-xs-12"></div>
											</div>
										</div>
	
										<!-- 지문 -->
										<div class="form-group-inner">
											<div class="row">
												<div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
													<label class="login2 pull-right pull-right-pro quesLabel"
														for="quesQues1">지문</label>
												</div>
												<div class="col-lg-9 col-md-9 col-sm-9 col-xs-12">
													<textarea rows="2" class="form-control ques"
														name="quesQues1" id="quesQues1"></textarea>
												</div>
											</div>
										</div>
	
										<!-- 배점 -->
										<div class="form-group-inner">
											<div class="row">
												<div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
													<label class="login2 pull-right pull-right-pro allotLabel"
														for="quesAllot1">배점</label>
												</div>
												<div class="col-lg-9 col-md-9 col-sm-9 col-xs-12">
													<input type="number" class="form-control allot"
														name="quesAllot1" id="quesAllot1">
												</div>
											</div>
										</div>
	
										<!-- 정답 -->
										<div class="form-group-inner">
											<div class="row">
												<div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
													<label class="login2 pull-right pull-right-pro cnsrLabel">정답</label>
												</div>
												<div class="col-lg-9 col-md-9 col-sm-9 col-xs-12">
													<div class="bt-df-checkbox">
														<input class="cnsr" checked type="radio" value="O" id="quesCnsr1"
															name="cnsr1">O <input class="cnsr" type="radio"
															value="X" id="quesCnsr1" name="cnsr1">X
													</div>
												</div>
											</div>
										</div>
	
										<!-- 해설 -->
										<div class="form-group-inner">
											<div class="row">
												<div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
													<label class="login2 pull-right pull-right-pro explnaLabel"
														for="quesExplna1">해설</label>
												</div>
												<div class="col-lg-9 col-md-9 col-sm-9 col-xs-12">
													<textarea rows="4" class="form-control explna"
														name="quesExplna1" id="quesExplna1"></textarea>
												</div>
											</div>
										</div>
									</div>
	
									<div id="addDiv"></div>
									<br>
									
									<div class="form-group-inner">
										<div class="row">
											<div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
												<label class="login2 pull-right pull-right-pro" for=""></label>
											</div>
											<div class="col-lg-9 col-md-9 col-sm-9 col-xs-12">
												<button
													class="btn btn-custon-four btn-primary waves-effect waves-light"
													type="button" onclick="addQues()">+</button>
												<button class="btn btn-custon-four btn-danger waves-effect"
													type="button" onclick="delQues()">-</button>
											</div>
										</div>
									</div>
	
									<br> <br> <br>
									<div class="form-group-inner">
										<div class="row">
											<div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
												<label class="login2 pull-right pull-right-pro" for=""></label>
											</div>
											<button class="btn btn-white " type="button"
												onclick="backToList()">목록으로 돌아가기</button>
											<button class="btn btn-primary waves-light " type="button"
												onclick="completeModify()">수정 완료</button>
										</div>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

</div>