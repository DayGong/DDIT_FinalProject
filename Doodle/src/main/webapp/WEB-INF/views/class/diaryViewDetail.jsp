<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script type="text/javascript" src="/resources/js/commonFunction.js"></script>
<script type="text/javascript" src="/resources/js/diary/diaryCommon.js"></script>
<script type="text/javascript" src="/resources/se2/js/HuskyEZCreator.js" charset="UTF-8"></script> <!-- 네이버 에디터 -->
<style>
#DiaryContainer {
	margin-bottom:50px;
}
#DiaryContainer h3 {
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
.DiaryAll, .replyContainer {
	width: 1400px;
	margin: auto;
	backdrop-filter: blur(10px);
	background-color: rgba(255, 255, 255, 1);
	border-radius: 50px;
	box-shadow: 0px 35px 68px 0px rgba(145, 192, 255, 0.5), inset 0px -6px 16px 0px rgba(145, 192, 255, 0.6), inset 0px 11px 28px 0px rgb(255, 255, 255);
	padding: 50px 80px;
}
.DiaryAll .diary-cont {
	border: 1px solid #ddd;
	border-radius: 10px;
	padding: 10px 20px;
	min-height: 83px;
	margin-top: 50px;
}
.DiaryAll .DiaryTit {
	display: flex;
	justify-content: space-between;
	position:relative;
}
.DiaryAll .title {
	font-size: 1.8rem;
	font-weight: 700;
	margin-top: 6px;
}
#goDiary, #delBtn, #modBtn {
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
#delBtn {
	background: #111;
	color:#fff;
}
#modBtn {
	background: #666;
	color:#fff;
}
#goDiary:hover,#modBtn:hover,#delBtn:hover, #addReplyBtn:hover {
	background: #ffd77a;
	transition: all 1s ease;
	color:#333;
	font-weight:600;
}
.uploadList {
	background: rgb(178 202 255 / 25%);
	backdrop-filter: blur(4px);
	-webkit-backdrop-filter: blur(4px);
	border-radius: 10px;
	border: 1px solid rgba(255, 255, 255, 0.18);
	padding: 15px 20px;
}
.uploadList ul {
	display: block;
}
.uploadList ul li {
	display: block;
	margin-bottom:5px;
}
.uploadList ul li.fileList {
	cursor: pointer;
}
.uploadList ul li.fileList:hover {
	text-decoration: underline;
}
.btn-zone {
	margin: auto;
	text-align: center;
}
.diaryInfo{
	margin-top: 20px;
	padding-left: 10px;
	font-size: 1rem;
	border-bottom: 1px solid #ddd;
	padding-bottom: 10px;
	text-align: right;
}

/*댓글 CSS 시작*/
.replyContainer .replyListAll {
	border-bottom:1px solid #ddd;
	padding: 15px 20px;
}
#addReplyBtn {
	background: #006DF0; color:#fff; border:none;
}
.modReplyBtn, .delReplyBtn {
	background: #333;
    color: #fff;
    padding: 8px 10px;
    box-shadow: none;
    border: none;
    border-radius: 20px;
    text-align: center;
    font-weight: 600;
}
.modReplyBtn{
	background: #ffd181;
	color: #333;
	font-weight: 700;
}
/*댓글 CSS 끝*/

.drawImg {
	width: 100%;
	height: 20%;
}
</style>
<script>
$(function() {
	let nttCode = ${param.nttCode};
	$("#replyNttCode").val(nttCode);
	
	// 일기 내용 불러오기
	fn_getDiaryDetail(nttCode);
	
	// 선생님 말씀 자동 완성
	$(document).on("click", "#replyAutoBtn", function(){
		console.log("테스트");
		$("#answerCn").html("정말 재밌는 하루를 보냈군요!\n앞으로 더 좋은 날만 가득할 거에요.");
	});

	// 목록 버튼
	$("#goDiary").on("click", function() { location.href = "/diary/goToDiaryList"; });
	
	// 수정 버튼
	$("#modBtn").on("click", function() { location.href = "/diary/addDiary?nttCode=" + nttCode; });
	
	// 삭제 버튼
	$("#delBtn").on("click", function() {
		let data = {
			"nttCode" : nttCode,
		}
		
		Swal.fire({
  	      title: `정말로 삭제하시겠습니까?`,
  	      text: ' ',
  	      icon: 'warning',
  	      showCancelButton: true,
  	      confirmButtonColor: '#ff0000',
  	      cancelButtonColor: '#e0e0e0',
  	      confirmButtonText: '삭제하기',
  	      cancelButtonText: '닫기',
  	      reverseButtons: false, // 버튼 순서 거꾸로
		}).then((result) => {
			if (result.isConfirmed) { 
				$.ajax({
					type: "post",
					url: "/diary/delDiary",
					data: JSON.stringify(data),
					contentType: "application/json; charset=utf-8",
					beforeSend:function(xhr){
		    			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		    		},
					success: function(result) {
						let res = "성공";
						let icon = "success";
						
						if (result != 1) { res = "실패"; icon = "error"; }
						
						Swal.fire({
					      title: "일기장 삭제를 " + res + '하였습니다.',
					      text: ' ',
					      icon: icon
						}).then(result => { location.href="/diary/goToDiaryList"; });
					}
				});
			}
		}) // end then
	});
	
	// 댓글 등록
	$("#addReplyBtn").on("click", function() {
		let answerCn = $("#answerCn").val();
		let data = {
			"nttCode" : nttCode,
			"answerCn" : answerCn,
			"mberId" : ${USER_INFO.mberId}
		};
		
		if ( answerCn.trim() == null || answerCn.trim() == '' ) {
			alertError('내용을 입력해주세요.', ' ');
			$("#answerCn").focus();
			return;
		}
		
		$.ajax({
			type: "post",
			url: "/diary/addReply",
			data: JSON.stringify(data),
			contentType: "application/json; charset=utf-8",
			beforeSend:function(xhr){
    			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
    		},
			success: function(result) {
				resultAlert(result, '선생님 말씀 등록을', ' ');
			}
		});
	});
	
	// 댓글 수정
	let flag = false;
	$(document).on("click", ".modReplyBtn", function() {
		let answerCode = $(this).data("answerCode");
		let replyContainer = $(this).closest(".replyListAll");
		
		// 현재 수정 중이 아닌 경우
		if (!replyContainer.data("editing")) { 					
	        let replyCn = replyContainer.find(".replylistCn"); 				// 댓글 내용
	        let originalCn = replyCn.html().trim(); 						// 원래 댓글 내용
	        originalCn = originalCn.replace(/<br>/gi, "\n");

	        // 댓글 내용을 textarea로 교체
	        let tarea = $("<textarea>").addClass("replyTextarea").val(originalCn);
	        tarea.attr({
	        	"name": "answerCn",
	            "rows": "",
	            "cols": "",
	            "style": "resize: none; width:96%; padding:10px 15px; border: 1px solid #ccc; border-bottom-right-radius:0px; border-top-right-radius:0px;"
	        });
	        replyCn.empty().append(tarea);									// 기존 내용 지우고 textarea 넣기

	     
	        replyContainer.data("editing", true); 							// 수정 중 플래그 설정
	        
	    } else { // 현재 수정 중인 경우												
	        let modCn = replyContainer.find(".replyTextarea").val().trim(); // 수정된 댓글 내용

	        submitReply(answerCode, replyContainer, modCn);					// 서버로 수정된 내용 전송
	        replyContainer.data("editing", false);							// 수정 중 플래그 해제
	    }
	});
	
	// 댓글 수정 함수
	function submitReply(answerCode, replyContainer, modCn) {
		txt = $("#answerCnMod").val();
		let data = {
			"answerCode" : answerCode,
			"answerCn" : modCn
		}
		
		$.ajax({
			type: "post",
			url: "/diary/modDiaryReply",
			data: JSON.stringify(data),
			contentType: "application/json; charset=utf-8",
			beforeSend:function(xhr){
    			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
    		},
			success: function(result) {
				let html = result.answerCn;
				html = html.replace(/\n/gi, "<br>");

				replyContainer.find(".replylistCn").html(html); // 수정된 내용으로 업데이트
			}
		});
	}
	
	// 댓글 삭제
	$(document).on("click", ".delReplyBtn", function() {
		let answerCode = $(this).data("answerCode");

		let data = {
			"answerCode" : answerCode,
		}
		
		Swal.fire({
  	      title: `정말로 삭제하시겠습니까?`,
  	      text: ' ',
  	      icon: 'warning',
  	      showCancelButton: true,
  	      confirmButtonColor: '#ff0000',
  	      cancelButtonColor: '#e0e0e0',
  	      confirmButtonText: '삭제하기',
  	      cancelButtonText: '닫기',
  	      reverseButtons: false, // 버튼 순서 거꾸로
		}).then((result) => {
			if (result.isConfirmed) { 
				$.ajax({
					type: "post",
					url: "/diary/delDiaryReply",
					data: JSON.stringify(data),
					contentType: "application/json; charset=utf-8",
					beforeSend:function(xhr){
		    			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		    		},
					success: function(result) {
						resultAlert(result, '선생님 말씀 삭제를', ' ');
					}
				});
			}
		}) // end then
	}); // end delReplyBtn
}); // end ready

function fn_getDiaryDetail(nttCode) {
	$.ajax({
		type: "get",
		url: "/diary/getDiaryDetail?nttCode=" + nttCode,
		dataType: "json",
		success: function(result) {
			let emotion = fn_emotionImg(result.nttAtchFileCode);
			let answerCode = result.answerCode;
			
			$("#day").html(result.strNttWritngDt);							// 작성 일자
			$("#weatherSpan").html(result.wethr);							// 날씨
			$("#emotionSpan").html(emotion + " " + result.nttAtchFileCode);	// 감정
			$("#writerSpan").html(result.mberId + " " + result.mberNm);		// 작성자
			$("#nttNm").attr("value", result.nttNm);						// 제목
			$("#nttCn").html(result.nttCn);									// 내용
			
			// 선생님 말씀 불러오기
			fn_getAnswerDetail(nttCode);
		}
	});
}

// 선생님 말씀
function fn_getAnswerDetail(nttCode) {
	let html = "";
	
	$.ajax({
		type: "get",
		url: "/diary/getDiaryReplyList?nttCode=" + nttCode,
		dataType: "json",
		async: false,		// 비동기 옵션을 false로 설정하여 동기적으로 요청을 보냄
		success: function(result) {
			console.log("rrr => ", result);
			if (result == null || result == '') {
				html += `<ul class="replyListAll">
							<li class="replyListLi">
								<ul class="replyInfoAll">
									<li>아직 등록된 선생님 말씀이 없습니다.</li>
								</ul>
							</li>
						</ul>`;
			} else {
				for (let i = 0; i < result.length; i++) {
					let res = result[i];					
					let answerCn = res.answerCn;
					answerCn = answerCn.replace(/\n/gi, "<br>");
					
					html += `<ul class="replyListAll">
								<li class="replyListLi">
									<ul class="replyInfoAll">
										<li style="display:flex; justify-content: space-between;">
											<span>
											<span class="replylistId" style="margin-bottom: 10px; font-weight: 800;">
												\${res.mberNm} 선생님
											</span>
											<span class="replylistDate" style="margin-bottom: 10px; font-weight: 500;">`;
					html += 					dateFormat(new Date(res.answerWritngDt));
					html +=					`</span>
										</span>
										<small>
											<button type="button" data-answer-code="\${res.answerCode}" class="modReplyBtn">수정</button>
											<button type="button" data-answer-code="\${res.answerCode}" class="delReplyBtn">삭제</button>
										</small>
									</li>
									<li>
										<p class="replylistCn " style="margin-bottom: 0px; font-weight: 500;">
											\${answerCn}
										</p>
									</li>
								</ul>
							</li>
						</ul>`;
				}
			}
		}
	});
	
	$("#answerCode").val(answerCode);
	$("#replySpan").html(html);
}
</script>
<div id="DiaryContainer">
	<h3>
		<img src="/resources/images/classRoom/diary/titleImg1.png" style="width:50px; display:inline-block; vertical-align:middel;">
		일기장
		<img src="/resources/images/classRoom/diary/titleImg2.png" style="width:50px; display:inline-block; vertical-align:middel;">
	</h3>
	<!-- 게시판 내용 제목/내용 시작 -->
	<div class="DiaryAll" style="width: 1400px; margin: auto; margin-bottom:50px; min-height:530px;">				
		<table style="width: 100%; margin-bottom:6px;">
			<tr style="height: 50px; font-size: 1.8rem; vertical-align: middle;">
				<td style="width: 40%;">
					<span id="day"></span>
				</td>
				<td style="width: 20%;">
					<span id="weatherSpan" style="margin-left: 10px;"></span>
				</td>
				<td style="width: 40%; text-align: right;">
					<span id="emotionSpan"></span>
				</td>
			</tr>
		</table>
		<!-- 선생님의 경우, 작성자를 볼 수 있음 -->
		<c:if test="${USER_INFO.mberId == teacherId}">
			<div class="diaryInfo">
				<span style="margin-left:15px; font-size: 1.5rem;">
					<span id="writerSpan" style="color:#666; font-size: 1.5rem;"></span>
				</span>
			</div>
		</c:if>
		<!-- end USER_INFO.mberId == teacherId -->
		<div class="DiaryTit">
			<input type="text" name="nttNm" id="nttNm" class="form-control input-sm" style="width:95%;border:none;background: none;height: 50px;font-size: 1.4rem;display: inline-block;vertical-align: middle; margin-bottom:6px;" readonly>
			<img src="/resources/images/classRoom/freeBrd/line.png" style="position: absolute;left: 0px;top: 10px;z-index: -1;">
		</div>
		<div class="diary-cont">
			<div id="nttCn" style="width:100%;" style="border:1px solid #ddd;"></div>
		</div>
		<div class="btn-zone">
			​​​​​​​​<input type="button" value="목록" id="goDiary"/>
			<c:choose>
				<c:when test="${USER_INFO.mberId == writerId}">
					​​​​​​​​<input type="button" value="수정" id="modBtn"/> 
					​​​​​​​​<input type="button" value="삭제" id="delBtn"/>
				</c:when>
				<c:when test="${USER_INFO.mberId == teacherId}">
					<input type="button" value="삭제" id="delBtn"/>
				</c:when>
				<c:otherwise></c:otherwise>
			</c:choose>
		</div>
	</div>
	<!-- 게시판 내용 제목/내용 끝 -->
	<!-- 댓글 시작 -->
	<div class="replyContainer">
		<!-- 댓글 작성 form 시작-->
		<form id="replyInsertForm">
			<input type="hidden" name="answerCode" id="answerCode">
			<h4>선생님 말씀 <i class="fa fa-pencil-square-o" id="replyAutoBtn" aria-hidden="true" style="cursor: pointer;"></i></h4>
			<c:if test="${USER_INFO.mberId == teacherId}">
				<div class="replyForm" style="display:flex; margin-bottom:35px;">
					<textarea name="answerCn" rows="" cols=""  id="answerCn" style="resize: none; width:96%; padding:10px 15px; border: 1px solid #ccc; border-radius:3px; border-right: none;  border-bottom-right-radius:0px; border-top-right-radius:0px;"></textarea>
					<button type="button" id="addReplyBtn" style="flex:1; border:none;  border-bottom-right-radius:5px; border-top-right-radius:5px;">
						등록
					</button>
				</div>
			</c:if>
			<sec:csrfInput />
		</form>
		<!-- 댓글 작성 form 끝-->
		<div data-div="replyDiv" id="replyDiv" style="border-top:1px solid #ddd;">
			<span id="replySpan"></span>
		</div>
	</div>
	<!-- 댓글 끝 -->
</div>