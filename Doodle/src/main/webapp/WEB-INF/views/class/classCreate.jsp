<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script type="text/javascript"></script>
<script>
$(function(){
	//학교 코드
	var schulCode = "${schulPsitnMberVO.schulCode}";
	
	//클래스 등록
	$("#createBtn").on("click",function(){
		var clasYear = $("#clasYear").val();							//년도
		// var grade = $("#grade").val();									//학년
		var cmmnGrade = document.getElementById("cmmnGrade").value;			//선택학년
		var clasNm = $("#clasNm").val();//반 명
		
		var cmmnClasSttus = document.getElementById("classState").value;
		var beginTm = document.getElementById("beginTm").value;
		var endTm = document.getElementById("endTm").value;
		
		if(clasYear==""){
			Swal.fire({
				  icon : "warning",
			      title: "생성 연도를 입력해주세요 !"
			    })
			return;
		}else if(cmmnGrade==="선택"){
			Swal.fire({
				  icon : "warning",
			      title: "학년을 선택해주세요 !"
			    })
			   return;
		}else if(clasNm==""){
			 Swal.fire({
				  icon : "warning",
			      title: "반을 입력해주세요 !"
			    })
			 return;
		}else if(beginTm=="" || endTm==""){
			 Swal.fire({
				  icon : "warning",
			      title: "등하교 시간을 입력해주세요 !"
			    })
			 return;
		}

		//공통 학년
		/* let cmmnGrade = "";
			if(grade === "1"){ cmmnGrade = "A22001"; }
			if(grade === "2"){ cmmnGrade = "A22002"; }
			if(grade === "3"){ cmmnGrade = "A22003"; }
			if(grade === "4"){ cmmnGrade = "A22004"; }
			if(grade === "5"){ cmmnGrade = "A22005"; }
			if(grade === "6"){ cmmnGrade = "A22006"; }
			console.log("cmmnGrade", cmmnGrade);
		*/

		let data = {
				"schulCode":schulCode,			//학교코드
				"clasYear":clasYear,			//연도
				"clasNm":clasNm,				//반이름
				"cmmnGrade":cmmnGrade,			//학년
				"cmmnClasSttus":cmmnClasSttus,	//상태
				"beginTm":beginTm,				//등교시간
				"endTm":endTm					//하교시간
		}
		console.log("data : ", data);
		
		$.ajax({
			url:"/class/classCreateAjax",
			contentType:"application/json;charset=utf-8",
			data:JSON.stringify(data),
			type:"post",
			dataType:"text",
			beforeSend:function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			},success:function(result){
				console.log("0실패, 1성공 : ", result);
				//result : 0 => 실패
				//result : 1 => 성공
				if(result=="0"){
					Swal.fire({
						icon : "error",
						title: "이미 존재하는 클래스입니다."
						})
					return;
				}else{
					Swal.fire({
						icon : "success",
						title: "클래스가 생성되었습니다."
						}).then(result => {
							if (result.isConfirmed) { // 만약 모달창에서 confirm 버튼을 눌렀다면
								location.href = "/school/main";
							}
						});
				}
			}
		}); //ajax끝
	});//등록 끝
	
});

function autoComplete(){
	let clasYear = document.querySelector("#clasYear");
	clasYear.value = `2024`;
	
	let cmmnGrade = document.querySelector("#cmmnGrade");
	cmmnGrade.value = `A22001`;

	let clasNm = document.querySelector("#clasNm");
	clasNm.value = `3`;

	let classState = document.querySelector("#classState");
	classState.value = `A16001`;

	let beginTm = document.querySelector("#beginTm");
	beginTm.value = `08:30`;

	let endTm = document.querySelector("#endTm");
	endTm.value = `13:00`;
}

</script>
<style>
.input-mark-inner {
	margin-bottom: 50px; /* 원하는 여백 값으로 조정 */
}

#classCreateContainer {
	margin-bottom:50px;
	margin-left: auto;
    margin-right: auto;
}

#classCreateContainer h3{
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

#classCreateContainer .row{
	width: 800px;
	height: 550px;
	margin: auto;
	backdrop-filter: blur(10px);
	background-color: rgba(255, 255, 255, 1);
	border-radius: 50px;
	box-shadow: 0px 35px 68px 0px rgba(145, 192, 255, 0.5), inset 0px -6px 16px 0px rgba(145, 192, 255, 0.6), inset 0px 11px 28px 0px rgb(255, 255, 255);
	padding: 50px 80px;
}

#classCreateContainer .row .free-cont{
	border: 1px solid #ddd;
	border-radius: 10px;
	padding: 10px 20px;
	min-height: 83px;
	margin-top: 50px;
}

#classCreateContainer .row {
	display: flex;
	justify-content: space-between;
	position:relative;
}

.col-md-12 {
    width: 80%;
}

.btn-zone{
	margin: auto;
	text-align: center;
}

#createBtn{
	display:inline-block;
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
	margin-right:15px;
}

</style>
<div id="classCreateContainer">
	<h3>
		<img src="/resources/images/classRoom/classList1.png" style="width:50px; display:inline-block; vertical-align:middel;">
				학급 클래스 생성
		<img src="/resources/images/classRoom/classList2.png" style="width:50px; display:inline-block; vertical-align:middel;">		
	</h3>
	<div class="row">
		<div class="col-md-12">
			<div class="form-group">
				<label>학교명</label>
				<input type="text" class="form-control" name="schulNm" value="${schulVO.schulNm}" disabled /> <!--접속중인 학교 세션 -->
			</div>
			<div class="form-group">
				<label>연도</label>
				<input type="number" id="clasYear" name="clasYear" placeholder="숫자만 입력하세요" class="form-control" />
			</div>
			<div class="form-group" style="width:50%;float:left;">
				<label>학년</label>
				<select class="form-control" id="cmmnGrade">
					<option selected hidden>선택</option>
					<option value="A22001">1학년</option>
					<option value="A22002">2학년</option>
					<option value="A22003">3학년</option>
					<option value="A22004">4학년</option>
					<option value="A22005">5학년</option>
					<option value="A22006">6학년</option>
				</select>
			</div>
			<div class="form-group" style="width:50%;float:left;">
				<label>반</label>
						<input type="text" id="clasNm" name="clasNm" class="form-control" />
			</div>
			<div class="form-group">                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
				<label>상태</label>
				<select class="form-control" id="classState">
					<option value="A16001">운영</option>
					<option value="A16002">중지</option>
					<option value="A16003">종료</option>
				</select>
		</div>
		<div class="form-group" style="width:50%;float:left;">                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
				<label>등교시간</label>
				<input type="time" id="beginTm" name="beginTm" class="form-control" />

		</div>
		<div class="form-group" style="width:50%;float:left;">        
				<label>하교시간</label>
				<input type="time" id="endTm" name="endTm" class="form-control" />
		</div>
		<div class="btn-zone">
			​​​​​​​​<input type="button" value="등록" id="createBtn"/> 
			<i class="fa fa-pencil-square-o" aria-hidden="true" onclick="autoComplete()"></i> <!-- 자동생성버튼 -->
		</div>


	</div>

	</div>

</div>