<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<style>
p{
	margin-bottom:0;
}

input{
	padding:10px 15px;
}

.FreeBoardAll, .questionContainer{
	width: 1400px;
	margin: auto;
	backdrop-filter: blur(10px);
	background-color: rgba(255, 255, 255, 1);
	border-radius: 50px;
	box-shadow: 0px 35px 68px 0px rgba(145, 192, 255, 0.5), inset 0px -6px 16px 0px rgba(145, 192, 255, 0.6), inset 0px 11px 28px 0px rgb(255, 255, 255);
	padding: 50px 80px;
}


.questionContainer {
	margin-bottom: 50px;
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

.question{
	background: #111;
	width: fit-content;
	display: inline-block;
	color:#fff;
	padding:0px 5px;
	font-weight: 300;
	font-size:1.2rem;
	margin-bottom:15px;
	margin-top:30px;
}
.default-container p input, .multiple-choice-Survey p input, .ubjective-Survey p input{
	height:45px;
	border: 1px solid #ccc;
	border-radius: 5px;
	
}
.btnAll{
	border:none;
	background: #006DF0;
	border-radius: 80px;
	text-align: center;
	height: 35px;
	color:#fff;
	font-weight: 700;
	padding:0px 15px;
	display: inline-block;
	margin-top: 15px;
}

#btn-Zone{
	position: absolute;
	display: flex;
	justify-content: space-between;
	z-index: 5;
	right: 73px;
	bottom: 50px;
	width: 627px;
}

.excelUpload{
	border: 1px solid #ddd;
	border-radius: 0px;
	border-bottom-left-radius: 5px;
	border-top-left-radius: 5px;
	border-right: 0px;
}

#fileBtn{
	margin-right: 94px;
	border: none;
	border-radius: 0;
	border-bottom-right-radius: 5px;
	border-top-right-radius: 5px;
	padding: 5px 7px;
	font-weight: 600;
	background: #666;
	color: #fff;
}


#surveyAdd, .multipleAnswerAddBtn{
	background: #333;
}
#Survey-Zone{
	position: relative;
}
.FreeBoardAll{
	position: relative;
}
#FreeBoardContainer h3{
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
@keyframes fadein {
	from {
		opacity: 0;
	}
	to {
		opacity: 1;
	}
}
@-moz-keyframes fadein { /* Firefox */
	from {
		opacity: 0;
	}
	to {
		opacity: 1;
	}
}
@-webkit-keyframes fadein { /* Safari and Chrome */
	from {
		opacity: 0;
	}
	to {
		opacity: 1;
	}
}
@-o-keyframes fadein { /* Opera */
	from {
		opacity: 0;
	}
	to {
		opacity: 1;
	}
}
</style>


<script type="text/javascript">

	function dateFormat(date){
		var selectDate = new Date(date);
		var d = selectDate.getDate();
		var m = selectDate.getMonth() + 1;
		var y = selectDate.getFullYear();
	   
		if(m < 10) m = "0" + m;
		if(d < 10) d = "0" + d;
	   
		return y + "-" + m + "-" + d; 
	}
	
	$(function(){
		
		$("#autoBtn").on("click",function(){
			$("#voteQustnrNm").val("2024 학교 교육 과정 수립을 위한 설문 조사");
			$("#voteQustnrCn").val("안녕하십니까? 한 학기동안 학교의 교육 활동에 많은 관심과 격려를 보내주신 학생 여러분께 진심으로 감사의 말씀 전합니다. 평소 우리 학교 교육활동에 대하여 학생과 학부모의 바람과 생각이 반영될 수 있도록 성의껏 답해 주시길 바라며 설문 분석 내용은 교육과정 외에 다른 용도로 사용하지 않는다는 점을 알려드립니다.");
			document.querySelector("#voteQustnrBeginDt").value = "2024-04-17";
			document.querySelector("#voteQustnrEndDt").value = "2024-04-19";
		});
	
		$("#fileBtn").on("click",function(){
			
			
			var fm = document.SurveyFrm;
			var fnm = fm.upload;
			var filePath = fnm.value;
			var fileBtnChk= true;
			
			if(filePath==null || filePath == ''){
				fileBtnChk = false;
			}
			
			if(!fileBtnChk){
				alertError("파일을 선택하고 눌러주세요!");
				return;
			}
			
// 			console.log("fm-> ", fm);
// 			console.log("fnm-> ", fnm);
// 			console.log("filePath-> ", filePath);
// 			console.log("서브스터 확인 ", filePath.substr(filePath.length - 4) );
			
			if(filePath.substr(filePath.length - 4) == 'xlsx' || filePath == null || filePath == ''){
				//alert("엑셀파일 맞음");'
				
				var excelFrm = new FormData($("#SurveyFrm")[0]);
				
				$.ajax({
					url : "/freeBoard/surveyExcelRegistration",
					processData:false,
					contentType:false,
					data:excelFrm,
					dataType:"text",
					type:"post",
					beforeSend:function(xhr){
						xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
					},
					success:function(result){
						var map = {};
						$("#Survey-Zone").find(".questionContainer").remove();
						//게시글 등록이 성공했을때 1, 실패했을때 0
 						console.log("result : ", result);
						//text -> json
						const obj = JSON.parse(result);
						//JSON.stringify : json->text
						
				
// 						console.log("obj : ", obj);
						$.each(obj,function(idx,vo){
							//vo : {"0": "객관식","1": "친구나 선배에게 맞거나 갇혔다(폭행, 감금)","2": "없음","3": "6개월에 1~2번","4": "한 달에 1~2번",
							//"5": "1주일에 1~2번","6": "거의매일"}
							//ex) vo[0] : 객관식 / vo[6] : 거의매일
// 							console.log("vo["+idx+"] : ",vo);
// 							console.log(vo[0] + ", " + vo[1]);
							if(vo[0] != null && vo[0]!=''){
								if(vo[0]=="객관식"){
									var newHtml = '';
									newHtml +=	'<div class="questionContainer">';
									newHtml +=		'<div class="multiple-choice-Survey">';
									newHtml +=			'<div class="multiple-choice-Survey-Q">';
									newHtml +=				'<p>';
									newHtml +=					'<span class="question">(객관식) 설문하실 질문을 입력해주세요.</span>';
									newHtml +=					' <button type="button" class="btnAll questionDel">질문 삭제</button>';
									newHtml +=				'</p>';
									newHtml +=				'<p style="display: flex; justify-content: space-between;">'
									newHtml +=					'<span style="font-size: 1.6rem; font-weight: 700;">Q<span class="Qnum voteIemSn">'+ ($('.questionContainer').length+1) +'</span></span>';
									newHtml +=					'<input type="text" style="margin-left: 10px; width: 95%;" name="voteIemCn" data-target="vaild" value="'+vo[1]+'">';
									newHtml +=				'</p>';
									newHtml +=			'</div>';
									newHtml +=			'<div class="multiple-choice">'
									newHtml +=			'<p class="multiple-btn-zone">';
									newHtml +=				'<span class="question" style="margin-top:20px;">';
									newHtml +=					'(객관식) 보기를 입력해주세요.';
									newHtml +=				'</span> ';
									newHtml +=				'<button type="button" class="btnAll multipleAnswerAddBtn">보기 추가</button> ';
									newHtml +=				'<button style="display:none;" type="button" class="btnAll multipleAnswerDelBtn">보기 삭제</button>';
									newHtml +=			'</p>';
									for (var i = 2; i < Object.keys(vo).length; i++) {
											newHtml +=		'<p class="answers" style="display: flex; justify-content: space-between; margin-top: 5px;">';
											newHtml +=			'<span style="font-size: 1.6rem; font-weight: 700;" class="voteDetailIemSn">'+(i-1)+'</span> ';
											newHtml +=			'<input type="text" style="margin-left: 10px; width: 95%;" name="voteDetailIemCn" data-target="vaild" value="'+vo[i]+'">';
											newHtml +=		'</p>'	;	
									}
									newHtml +=			'</div>';
									newHtml +=		'</div>';
									newHtml +='</div>';
									
									$('#Survey-Zone').append(newHtml);
									
									var multiples = document.querySelectorAll(".multiple-choice");
									for(let i=0; i< multiples.length; i++){
										var answers = multiples[i].querySelectorAll("p.answers");
										if(answers.length >= 3){
											multiples[i].querySelector("button.multipleAnswerDelBtn").style.display="inline-block";
										}
									}
									
								}else{
									console.log("주관식");
									var newHtml = '';
									newHtml += '<div class="questionContainer">';
									newHtml += 	'<ul class="questionAnswerDefault">';
									newHtml += 		'<li>';
									newHtml += 			'<div class="ubjective-Survey">';
									newHtml += 				'<div class="ubjective-Survey-Q">';
									newHtml += 					'<p>';
									newHtml += 						'<span class="question" style="margin-top:0px;">(주관식) 설문하실 질문을 입력해주세요.</span> '
									newHtml += 						' <button type="button" class="btnAll questionDel">질문 삭제</button>';
									newHtml += 					'</p>';
									newHtml += 					'<p style="display: flex; justify-content: space-between;">';
									newHtml += 						'<span style="font-size: 1.6rem; font-weight: 700;">Q<span class="Qnum voteIemSn">'+ ($('.questionContainer').length+1) +'</span></span>';
									newHtml += 						'<input type="text" style="margin-left: 10px; width: 95%;" name="voteIemCn" data-target="vaild" value="'+vo[1]+'">';
									newHtml += 					'</p>';
									newHtml += 				'</div>';
									newHtml += 			'</div>';
									newHtml += 		'<li>';
									newHtml += 	'</ul>';
									newHtml += '</div>';
									
									
									$('#Survey-Zone').append(newHtml);
								
								}
							}
	
						});
						
						return;
					
					}
				});
			}else{
				alertError("설문지는 엑셀 파일만 등록 가능합니다.");
				return;
			}
		
		});
		
	
		$("#studentFreeBoardLi").css("display", "block");
		$("#teacherFreeBoardLi").css("display", "block");
		$("#parentFreeBoardLi").css("display", "block");
	
		var selectBoxVal = $("#selectBox option:selected").val();
		
		$("#surveyAdd").on("click",function(){
			var selectBox = $("#selectBox").val()||0;
			if(selectBox == 1) {
				console.log("객관식");
				var newHtml = '';
				newHtml +=	'<div class="questionContainer">'
				newHtml +=		'<div class="multiple-choice-Survey">'
				newHtml +=			'<div class="multiple-choice-Survey-Q">'
				newHtml +=				'<p>'
				newHtml +=					'<span class="question">(객관식) 설문하실 질문을 입력해주세요.</span>'
				newHtml +=					' <button type="button" class="btnAll questionDel">질문 삭제</button>'
				newHtml +=				'</p>'
				newHtml +=				'<p style="display: flex; justify-content: space-between;">'
				newHtml +=					'<span style="font-size: 1.6rem; font-weight: 700;">Q<span class="Qnum voteIemSn">'+ ($('.questionContainer').length+1) +'</span></span>'
				newHtml +=					'<input type="text" style="margin-left: 10px; width: 95%;" name="voteIemCn" data-target="vaild">'
				newHtml +=				'</p>'
				newHtml +=			'</div>'
				newHtml +=			'<div class="multiple-choice">'
				newHtml +=				'<p class="multiple-btn-zone">'
				newHtml +=					'<span class="question" style="margin-top:20px;">(객관식) 보기를 입력해주세요.</span>'
				newHtml +=					' <button type="button" class="btnAll multipleAnswerAddBtn">보기 추가</button>'
				newHtml +=					' <button style="display:none;" type="button" class="btnAll multipleAnswerDelBtn">보기 삭제</button>'	
				newHtml +=				'</p>'
				newHtml +=				'<p class="answers" style="display: flex; justify-content: space-between; margin-bottom: 5px;">'
				newHtml +=					'<span style="font-size: 1.6rem; font-weight: 700;" class="voteDetailIemSn">1</span>'
				newHtml +=					'<input type="text" style="margin-left: 10px; width: 95%;" name="voteDetailIemCn" data-target="vaild">'
				newHtml +=				'</p>'
				newHtml +=				'<p class="answers" style="display: flex; justify-content: space-between; margin-bottom: 5px;">'
				newHtml +=					'<span style="font-size: 1.6rem; font-weight: 700;" class="voteDetailIemSn">2</span>'
				newHtml +=					'<input type="text" style="margin-left: 10px; width: 95%;" name="voteDetailIemCn" data-target="vaild">'
				newHtml +=				'</p>'
				newHtml +=			'</div>'
				newHtml +=		'</div>'
				newHtml +='</div>';
				
				$('#Survey-Zone').append(newHtml);
				
			}else {
				console.log("주관식");
				var newHtml = '';
				newHtml += '<div class="questionContainer">';
				newHtml += 	'<ul class="questionAnswerDefault">';
				newHtml += 		'<li>';
				newHtml += 			'<div class="ubjective-Survey">';
				newHtml += 				'<div class="ubjective-Survey-Q">';
				newHtml += 					'<p>';
				newHtml += 						'<span class="question" style="margin-top:0px;">(주관식) 설문하실 질문을 입력해주세요.</span> '
				newHtml += 						' <button type="button" class="btnAll questionDel">질문 삭제</button>';
				newHtml += 					'</p>';
				newHtml += 					'<p style="display: flex; justify-content: space-between;">';
				newHtml += 						'<span style="font-size: 1.6rem; font-weight: 700;">Q<span class="Qnum voteIemSn">'+ ($('.questionContainer').length+1) +'</span></span>';
				newHtml += 						'<input type="text" style="margin-left: 10px; width: 95%;" name="voteIemCn" data-target="vaild">';
				newHtml += 					'</p>';
				newHtml += 				'</div>';
				newHtml += 			'</div>';
				newHtml += 		'<li>';
				newHtml += 	'</ul>';
				newHtml += '</div>';
				$('#Survey-Zone').append(newHtml);
			}
		});
		
		$("#Survey-Zone").on("click",".questionDel",function(){
			if($(".questionContainer").length <= 1){
				alertError("최소 1개의 질문은 존재해야합니다.");
				return;
			 }
	
			$(this).closest(".questionContainer").remove();
			var changeQnum ="";
			$(".questionContainer").each(function(idx){
				var Qnum = $(this).find("span.Qnum");
				changeQnum = Qnum.text(idx+1);
				$(".Qnum").innerText = changeQnum;
			}); //반복문 끝
		});
		
		$("#Survey-Zone").on("click", ".multipleAnswerAddBtn",function(){

			var newHtml = '';
			var multiple = $(this).closest(".multiple-choice");
			var answers = multiple.find("p.answers");
			var delBtn = multiple.find("button.multipleAnswerDelBtn");
			newHtml +='<p class="answers" style="display: flex; justify-content: space-between; margin-bottom: 5px;">'
			newHtml +=		'<span style="font-size: 1.6rem; font-weight: 700;">'+ (answers.length + 1) +'</span>'
			newHtml +=		'<input type="text" style="margin-left: 10px; width: 95%;" class="voteDetailIemCn" name="voteDetailIemCn" data-target="vaild">'
			newHtml +='</p>'
			$(this).closest(".multiple-choice").append(newHtml);
			
			
			if(answers.length > 1){
				delBtn.css("display","inline-block");
			}
			
		});
		
		$("#Survey-Zone").on("click", ".multipleAnswerDelBtn",function(){
			var multiple = $(this).closest(".multiple-choice");
			var answers = multiple.find("p.answers");
			var delBtn = multiple.find("button.multipleAnswerDelBtn");
	
			multiple.find(answers).last().remove();
			
	
			
			if(answers.length == 3) {
				delBtn.css("display", "none");
			}
		});
		
		$("#surveyInsertBtn").on("click",function(){
			//설문 설정 값 가져오기
			var voteQustnrNm = $("#voteQustnrNm").val();//설문이름
			var voteQustnrCn = $("#voteQustnrCn").val();//설문내용(목적)
			var voteQustnrBeginDt = $("#voteQustnrBeginDt").val();//설문시작날짜
	
			var voteQustnrEndDt = $("#voteQustnrEndDt").val();//설문종료일
			//설문시작 날짜와 종료날짜 비교를 위한 변수와 조건문
			var voteQustnrBeginDtArr = voteQustnrBeginDt.split('-');
			var voteQustnrEndDtArr = voteQustnrEndDt.split('-');
			var startDateCompare = new Date(voteQustnrBeginDtArr[0], parseInt(voteQustnrBeginDtArr[1])-1, voteQustnrBeginDtArr[2]);
			var endDateCompare = new Date(voteQustnrEndDtArr[0], parseInt(voteQustnrEndDtArr[1])-1, voteQustnrEndDtArr[2]);
			var now = new Date();
			
			now.setTime(new Date().getTime() - (1 * 24 * 60 * 60 * 1000)); //1일전     return d.format("d");
	
			
			if(startDateCompare.getTime() > endDateCompare.getTime()) {
				alertError("설문 종료일은 설문 시작일의 이전 일 수 없습니다.");
				return;
			}
			
			if(now.getTime() > startDateCompare.getTime()) {
				alertError("설문 시작일은 설문 작성일의 이전 일 수 없습니다.");
				return;
			}
			
			//설문지 등록시 null 체크
			if(voteQustnrNm == null || voteQustnrNm == ''){
				alertError("설문지의 이름을 작성해주세요.");
				return;
			}else if(voteQustnrBeginDt==null || voteQustnrBeginDt==''){
				alertError("설문지 시작일을 선택해주세요.");
				return;
			}else if(voteQustnrEndDt==null || voteQustnrEndDt == ''){
				alertError("설문지 종료일을 선택해주세요.");
				return;
			}else if(voteQustnrCn == null || voteQustnrCn == ''){
				alertError("설문지의 목적 및 내용을 작성해주세요.");
				return;
			}
			
			//설문질문지  null 체크
			var validChk = true;
			$("#Survey-Zone").find("div.questionContainer").each(function(idx, item) {
				$(item).find("input[data-target='vaild']").each(function(idx2, item2) {
					var value = $(item2).val().trim();
					if(value == '') {
						alertError("질문 또는 보기는 모두 필수 입력값입니다.");
						validChk = false;
						return false;
					}
				});
				if(!validChk) return false;
			}); //반복문 끝
	
			if(validChk) {
				var data = {};
				data.voteQustnrNm = $("#voteQustnrNm").val();
				data.voteQustnrBeginDt = $("#voteQustnrBeginDt").val();
				data.voteQustnrEndDt = $("#voteQustnrEndDt").val();
				data.voteQustnrCn = $("#voteQustnrCn").val();
				
				var qustnrList = [];
				$("#Survey-Zone").find("div.questionContainer").each(function(idx, item) {
					var obj = {};
					obj.voteIemCn = $(item).find("input[name='voteIemCn']").val();
					
					var exLength = $(item).find("input[name='voteDetailIemCn']").length;
					if(exLength > 0) {
						//객관식
						var exList = [];
						$(item).find("input[name='voteDetailIemCn']").each(function(idx2, item2) {
							exList.push($(item2).val());
						});
						obj.voteDetailIemCn = exList;
					}else {
						//주관식
						obj.voteDetailIemCn = null;
					}
					qustnrList.push(obj);
				});
				data.qustnrList = qustnrList;
				console.log(data);
				
				$.ajax({
					type : 'POST',
					url : '/freeBoard/surveyCreateAjax',
					data : {"data" : JSON.stringify(data)},
					dataType : 'JSON',
					beforeSend:function(xhr){
						xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
					},
					success : function(result) {
						if(result==1){
							resultAlert2(result, '설문 등록 ', '리스트로 이동합니다.', '/freeBoard/surveyList');
						}else{
							alertError("설문 등록 실패!");
							return;
						}
					}
				});
			}
		});
	
	});
	</script>

<!-- 자유게시판 hover효과 js -->
<div id="FreeBoardContainer">
	<h3>
		<img src="/resources/images/classRoom/freeBrd/survey.png" style="width:50px; display:inline-block; vertical-align:middel;">
			설문 생성
		<img src="/resources/images/classRoom/freeBrd/vote.png" style="width:50px; display:inline-block; vertical-align:middel;">		
	</h3>
	<form id="SurveyFrm" name="SurveyFrm">
		<div class="FreeBoardAll" style="width: 1400px; margin: auto; margin-bottom:50px;">
			<h2 style="border-bottom: 1px solid #111; padding-bottom:10px;">
				<img src="/resources/images/classRoom/freeBrd/svsetting.png" style="width:40px; display:inline-block; vertical-align:middel;">		
				설문 설정
			</h2>
			<div class="defaultAll" style="display:flex;">
				<ul class="default-container" style="flex:1;">
					<li>
						<p>
							<span class="question">1. 설문지의 이름을 작성해주세요.</span>
						</p>
						<p>
							<input type="text" name="voteQustnrNm" id="voteQustnrNm" style="width:90%;">
						</p>
					</li>
					<li>
						<p>
							<span class="question">2. 설문 시작일을 지정해주세요.</span>
						</p>
						<p>
							<input type="date" style="width:90%;padding: 10px 15px;" name="voteQustnrBeginDt" id="voteQustnrBeginDt"/>
						</p>
					</li>
					<li>
						<p>
							<span class="question">3. 설문 종료일을 지정해주세요.</span>
						</p>
						<p>
							<input type="date" style="width:90%;padding: 10px 15px;"name="voteQustnrEndDt" id="voteQustnrEndDt"/>
						</p>
					</li>
				</ul>
				<ul class="default-container" style="flex:1;">
					<li>
						<p>
							<span class="question">4. 설문지의 목적 및 내용을 작성해주세요.</span>
						</p>
						<p>
							<textarea rows="" cols="" id="voteQustnrCn" name="voteQustnrCn"style="border-radius:5px;border:1px solid #ccc;width:100%; height:156px;resize: none; padding:5px 10px;"></textarea>
						</p>
					</li>
				</ul>
			</div>
			<div id="btn-Zone">
				<!-- 엑셀파일 업로드  -->
				<div class="excelUpload">
					<input type="file"  accept=".xlsx" id="upload" name="upload" style="width: 195px;"/>
				</div>
				<button type="button" id="fileBtn" style="margin-right: 8px;">엑셀등록</button>
			
				<!-- 엑셀파일 업로드  끝 -->
				
				<select style="border: 1px solid #ccc; border-radius: 5px;" id="selectBox">
					<option value="2">주관식 설문지</option>
					<option value="1">객관식 설문지</option>
				</select>
				<button type="button" id="surveyAdd" class="btnAll" style="margin-right:0px; margin-top: 5px; margin-left: 5px;">
					질문 추가
				</button>
				<button type="button" id="autoBtn" class="btnAll" style="margin-right:0px; margin-top: 5px; margin-left: 5px;">
					자동입력
				</button>
				<button type="button" id="surveyInsertBtn" class="btnAll" style="margin-right:0px; margin-top: 5px; margin-left: 5px;">
					설문 등록
				</button>
				
			</div>
		</div>
		<!-- 사용자 설문 폼 시작 -->
		<div id="Survey-Zone">
			<div class="questionContainer">
				<ul class="questionAnswerDefault">
					<li>
						<div class="ubjective-Survey">
							<div class="ubjective-Survey-Q">
								<p>
									<span class="question" style="margin-top:0px;">(주관식) 설문하실 질문을 입력해주세요.</span>
									<button type="button" class="btnAll questionDel">질문 삭제</button>
								</p>
								<p style="display: flex; justify-content: space-between;">
									<span class="QAll" style="font-size: 1.6rem; font-weight: 700;">Q<span class="Qnum voteIemSn">1</span></span>
									<input type="text" style="margin-left: 10px; width: 95%;" name="voteIemCn" data-target="vaild">
								</p>
							</div>
						</div>
					</li>
				</ul>
			</div>
		</div>
	</form>
</div>