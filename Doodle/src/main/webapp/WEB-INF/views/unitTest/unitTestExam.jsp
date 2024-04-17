<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>    
<script type="text/javascript" src="/resources/js/cjh.js"></script>  

<style>
#unitTestExamAll {
	--main-color : #006DF0;
	--main-color-dark : #0f4b92;
	--sub-color : #FCC25B;
	--sub-color-dark : #e1a130;
	
	font-size : 1.3rem;
	width:1400px;
	height: 790px;
	margin:auto;
}

#unitTestExamAll > h3{
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

#unitTestExamAll > h3 > img{
	width:50px;
}

#unitTestExamAll #cardDiv{
	width: 700px;
	height: 600px;
	margin: auto;
	margin-bottom:50px;
	backdrop-filter: blur(10px);
	background-color: rgba();
	border-radius: 50px;
	box-shadow: 0px 35px 68px 0px rgba(145, 192, 255, 0.5), inset 0px -6px 16px 0px rgba(145, 192, 255, 0.6), inset 0px 11px 28px 0px rgb(255, 255, 255);
	padding: 50px 80px;
	position:relative;
	left:0px;
}

.oxBtnContainer {
	height : 72%;
	display:flex;
	justify-content: space-between;
}

.ox-btn {
    font-size: 10rem;
    border: none;
    font-weight: 700;
    border-radius:20px;
    width:50%;
    box-shadow: 0px 0px 15px 5px #0c4c9c20, inset 0px 0px 3px 5px #ffffff90;
}

::-webkit-scrollbar {
  display: none;
}

</style>

<script>
var currentLen = 1;                              // 현재 문제 번호
var maxLen = ${fn:length(unitEvlVO.quesVOList)}; // 문제 총 개수
var arr = []; 									 // 학생의 선택
var isCardMoving = false;                        // 카드 애니메이션

window.onload = function(){
	var quesNoDiv = document.querySelector("#quesNoDiv");
	var quesDiv = document.querySelector("#quesDiv");
	var scoreDiv = document.querySelector("#scoreDiv");
	var cardDiv = document.querySelector("#cardDiv");
	if(!cardDiv.style.left){
		cardDiv.style.left = "0px";
	}
	
	// 최초 입장 시 성적표 생성
	makeGc();
}

// 성적표 생성
const makeGc = function(){
	$.ajax({
		url:"/unitTest/makeGc",
		type:"post",
		contentType:"application/json",
		data:"${unitEvlVO.unitEvlCode}",
		dataType:"text",
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success:function(res){
			console.log("makeGc:"+res);
		},
		error:function(xhr){
			console.log("error:"+xhr.status);
		}
	})
}

// 한 문제 풀 때마다 호출
const solve = function(v){
	if(isCardMoving){return;}
	
	arr.push(v);
	console.log("select value :"+v);
	console.log("arr",arr);

	currentLen ++;
	if(currentLen > maxLen){
		// 종료
		solveFinish();

		cjh.swConfirm("종료", "단원평가가 모두 끝났습니다. 수고하셨습니다.", "success").then(function(res){
			cjh.selOne("#postForm").action ="/unitTest/detail";
			cjh.selOne("#postForm #unitEvlCode").value = "${unitEvlVO.unitEvlCode}";
			cjh.selOne("#postForm").submit();
		})
		
		return;
	}
	
	cardAnimGone();
}

// 모든 문제 완료
const solveFinish = function(){
	let sendData = {"unitEvlCode":"${unitEvlVO.unitEvlCode}",
					"aswperArr":arr};
	
	$.ajax({
		url:"/unitTest/finishGc",
		type:"post",
		contentType:"application/json",
		data:JSON.stringify(sendData),
		dataType:"text",
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success:function(res){
			console.log("finishGc:"+res);
		}
	})
}

// 카드 사라짐 애니메이션
const cardAnimGone = function(){
	isCardMoving = true;
	
	let left = parseInt(cardDiv.style.left);
	cardDiv.style.left = parseInt(cardDiv.style.left) - 200 + "px";
	if(left > -1400){
		setTimeout(cardAnimGone, 10);
	}else{
		cardDiv.style.left = "1400px";
		
		// 문제 변경
		quesNoDiv.innerHTML = currentLen + ". ";
		quesDiv.innerHTML   = document.querySelector("#ques"+currentLen).innerText;
		scoreDiv.innerHTML  = "["+document.querySelector("#scre"+currentLen).innerText+"점]";

		cardAnimCome();
	}
}
// 카드 나타남 애니메이션
const cardAnimCome = function(){
	let left = parseInt(cardDiv.style.left);
	cardDiv.style.left = parseInt(cardDiv.style.left) - 200 + "px";
	if(left > 0){
		setTimeout(cardAnimCome, 10);
	}else{
		isCardMoving = false;
		cardDiv.style.left = "0px";
	}
}
</script>

<!-- post로 화면 이동 form -->
<form id = "postForm" action ="" method ="post">
	<input type = "text" id ="unitEvlCode" name = "unitEvlCode" value ="" style="display:none;">
	<sec:csrfInput />
</form>

<!-- 문제 저장 -->
<c:forEach var="item" items="${unitEvlVO.quesVOList}" varStatus="stat">
<div id = "ques${item.quesNo}" style ="display : none;">${item.quesQues}</div>
<div id = "scre${item.quesNo}" style ="display : none;">${item.quesAllot}</div>
</c:forEach>

<div id="unitTestExamAll">

	<h3><img src ="/resources/images/classRoom/unitTest01.png">단원평가<img src ="/resources/images/classRoom/unitTest01.png"></h3>
	
	<div id="cardDiv">
	
		<!-- 제목 -->
		<div style ="margin-bottom:15px; font-weight: 700; font-size: 2.0rem">
			${unitEvlVO.unitEvlNm}
		</div>
		
		<!-- 내용 -->
		<div style ="margin-bottom:20px;">
			<span id="quesNoDiv">${unitEvlVO.quesVOList[0].quesNo}. </span>	
			<span id="quesDiv">${unitEvlVO.quesVOList[0].quesQues}</span>			
			<span id="scoreDiv">[${unitEvlVO.quesVOList[0].quesAllot}점]</span>			
			<!-- 				<img src="/resources/images/classRoom/freeBrd/freeFile.png" style="width:40px; display:inline-block;"> -->
		</div>

		<!-- OX 카드 -->
		<div class="oxBtnContainer">
			<button id = "o-btn" value = "O" class = "d-btn-blue ox-btn" onclick = "solve('O')" style =" margin-right:5%;">O</button>
			<button id = "x-btn" value = "X" class = "d-btn-red ox-btn"  onclick = "solve('X')">X</button>
		</div>
	</div>
</div>
