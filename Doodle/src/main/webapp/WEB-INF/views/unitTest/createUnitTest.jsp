<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script type="text/javascript" src="/resources/js/commonFunction.js"></script>
<script type="text/javascript" src="/resources/js/cjh.js"></script> 
<link rel="stylesheet" href="/resources/css/mainPage.css">

<style>

.createUnitTest {
	width :1400px;
	margin:auto;
}

.createUnitTest > h3{
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

.createUnitTest > h3 > img{
	width:50px;
}


textarea {
	resize: none;
}

.sparkline12-list {
	background-color: transparent;
}

.box {
	margin-bottom: 20px;
}

hr {
	border-style: dashed;
	border-color: var(--gray-color);
}

.form-group-inner {
	padding-right: 80px;
	padding-left: 40px;
}

.add-btn{
	font-size:1.5rem;
	width:45%; 
}

</style>

<script>
	window.onload = function(){
	    const addDiv = document.querySelector("#addDiv");
	}
	
	var cnt = 1; // 문항 수
    // 문항 추가
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
    
    // 단원 평가 등록
    const createUnitEvl = function(){
    	
    	let formData = new FormData();
    	
    	let title = document.querySelector("#title").value;
    	let startDt = document.querySelector("#startDt").value;
    	let endDt = document.querySelector("#endDt").value;
    	let startTm = document.querySelector("#startTm").value;
    	let endTm = document.querySelector("#endTm").value;
    	
    	console.log("title : " + title + ", startDt : " +  startDt + ", endDt : " + endDt + ", startTm : " + startTm + ", endTm : " + endTm);
    	
    	// 단원 평가
    	formData.append("unitEvlNm",title);
    	formData.append("unitEvlBeginDt",startDt + " " + startTm);//2024-03-08 04:27
    	formData.append("unitEvlEndDt",endDt + " " + endTm);	//2024-03-21 18:31
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
            url :"/unitTest/createUnitTest",
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
	            	cjh.swAlert("성공","단원평가가 성공적으로 등록되었습니다.","success").then(function(res){
						// 목록으로 이동
		            	location.href = "/unitTest/list";
	            	});
                }
                else{
	            	cjh.swAlert("실패","단원평가 등록에 실패했습니다.","error");
                }
            },
            error:function(xhr){
                console.log(xhr.status);
            }
        })
    }
    
	 // 시험 생성 취소
    const cancelCreate = function(){
    	cjh.swConfirm("취소","생성을 취소하고 목록으로 돌아가시겠습니까?","warning").then(function(res){
    		if(res.isConfirmed){
				location.href = "/unitTest/list";
    		}
    	});
    }
	 
	 // 자동 입력
	const autoInput = function(){
		let today = new Date();   
		today = dateToMinFormat(today);
		
		for(let i = cnt ; i < 5 ; ++i){
			addQues();
		}
		 
		document.querySelector("#title").value = "1학기 과학 4단원 평가";
		document.querySelector("#startDt").value = "2024-04-11";
		document.querySelector("#endDt").value = "2024-04-19";
		document.querySelector("#startTm").value = "09:00:00";
		document.querySelector("#endTm").value = "09:00:00";
		
		document.querySelector("#quesQues1").value = "지구는 자전을 하면서 동시에 공전을 할 수 있다.";
		document.querySelector("#quesAllot1").value = "20";
		document.querySelector("[name='quesCnsr1'][value='O']").setAttribute('checked', true);
		document.querySelector("#quesExplna1").value = "지구는 하루에 한바퀴 자전과 일년에 태양의 중심으로 한바퀴 공전을 할 수 있습니다.";
		
		document.querySelector("#quesQues2").value = "지구는 태양을 중심으로 1년에 한바퀴씩 자전한다.";
		document.querySelector("#quesAllot2").value = "20";
		document.querySelector("[name='quesCnsr2'][value='X']").setAttribute('checked', true);
		document.querySelector("#quesExplna2").value = "지구가 태양을 중심으로 도는 것을 자전이 아닌 공전이라고 합니다.";
		
		document.querySelector("#quesQues3").value = "하루 동안 달의 위치는 변하지 않고 그대로 떠 있다.";
		document.querySelector("#quesAllot3").value = "20";
		document.querySelector("[name='quesCnsr3'][value='X']").setAttribute('checked', true);
		document.querySelector("#quesExplna3").value = "시간이 지나면서 지구가 자전하게 되며 달은 동쪽에서 서쪽으로 움직이는 것처럼 보이게 됩니다.";
		
		document.querySelector("#quesQues4").value = "낮과 밤이 생기는 이유는 태양이 자전하기 때문입니다.";
		document.querySelector("#quesAllot4").value = "20";
		document.querySelector("[name='quesCnsr4'][value='X']").setAttribute('checked', true);
		document.querySelector("#quesExplna4").value = "태양이 아니라 지구가 자전하기 때문에 생깁니다.";
		
		document.querySelector("#quesQues5").value = "달의 공전 주기는 7일이다.";
		document.querySelector("#quesAllot5").value = "20";
		document.querySelector("[name='quesCnsr5'][value='X']").setAttribute('checked', true);
		document.querySelector("#quesExplna5").value = "달의 공전 주기는 약 27일 입니다.";
	}

</script>

<div class ="createUnitTest">
	<h3><img src ="/resources/images/classRoom/unitTest01.png">단원평가 생성<img src ="/resources/images/classRoom/unitTest01.png"></h3>

	<div class = "box">
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
												<label class="login2 pull-right pull-right-pro"
													for="startDt">시작 일자</label>
											</div>
											<div class="col-lg-9 col-md-9 col-sm-9 col-xs-12">
												<input type="date" class="form-control" id="startDt">
											</div>
										</div>
									</div>
		
									<div class="form-group-inner">
										<div class="row">
											<div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
												<label class="login2 pull-right pull-right-pro"
													for="startTm">시작 시간</label>
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
		
									<hr>
									<div id="quesDiv">
										<!-- 문제 번호 -->
										<div class="form-group-inner">
											<div class="row">
												<div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
													<label class="login2 pull-right pull-right-pro">1번
														문제</label>
												</div>
												<div class="col-lg-9 col-md-9 col-sm-9 col-xs-12"></div>
											</div>
										</div>
		
										<!-- 지문 -->
										<div class="form-group-inner">
											<div class="row">
												<div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
													<label class="login2 pull-right pull-right-pro"
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
													<label class="login2 pull-right pull-right-pro"
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
													<label class="login2 pull-right pull-right-pro">정답</label>
												</div>
												<div class="col-lg-9 col-md-9 col-sm-9 col-xs-12">
													<div class="bt-df-checkbox">
														<input class="cnsr" checked type="radio" value="O" id=""
															name="quesCnsr1">O <input class="cnsr" type="radio"
															value="X" id="" name="quesCnsr1">X
													</div>
												</div>
											</div>
										</div>
		
										<!-- 해설 -->
										<div class="form-group-inner">
											<div class="row">
												<div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
													<label class="login2 pull-right pull-right-pro"
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
											<div class="col-lg-9 col-md-9 col-sm-9 col-xs-12" style="display:flex; justify-content: space-between;">
												<button
													class="d-btn-blue add-btn"
													type="button" onclick="addQues()">+</button>
												<button class="d-btn-red add-btn"
													type="button" onclick="delQues()">-</button>
											</div>
										</div>
									</div>
		
									<div class="form-group-inner" style ="margin-top: 40px;">
										<div class="row">
											<div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
												<label class="login2 pull-right pull-right-pro" for=""></label>
											</div>
											<div class="col-lg-9 col-md-9 col-sm-9 col-xs-12" style ="display:flex; justify-content: flex-end;">
												<button class="d-btn-gray" type="button" style ="margin-right: 10px;"
													onclick="autoInput()">자동 입력</button>
												<button class="d-btn-gray" type="button" style ="margin-right: 10px;"
													onclick="cancelCreate()">목록으로 돌아가기</button>
												<button class="d-btn-blue" type="button"
													onclick="createUnitEvl()">생성 완료</button>
											</div>
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