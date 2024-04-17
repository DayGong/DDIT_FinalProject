<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<script type="text/javascript" src="/resources/se2/js/HuskyEZCreator.js" charset="UTF-8"></script>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script>
	$(function(){
		
		$(".auto-reply-btn").on("click",function(){
			$("#answerCn").val("나도 정말 재미있었어. 다음에도 꼭 버스 옆자리 같이 앉자!");
		});
		//목록으로가기
		$("#goFree").on("click",function(){
			location.href="/freeBoard/freeBoardList"; //게시글 목록으로 가기 위함
		});
		
		/* 파일 개별다운로드 시작 */
		$('.fileList').on("click",function(){
			var atchFileCode  = $(this).data("atchFileCode");
			var atchFileSn  = $(this).data("atchFileSn");
			var atchFileNm  = $(this).data("atchFileNm");
			$("#atchFileCode").val(atchFileCode);
			$("#atchFileSn").val(atchFileSn);
			$("#atchFileNm").val(atchFileNm);
			$("#freeUploadFrm").submit();
		});
		/* 파일 개별다운로드 끝 */
		
		/* 게시글 삭제 */
		$("#freeDelBtn").on("click",function(){

			
			var data = {
				"nttAtchFileCode":"${nttVO.nttAtchFileCode}",
				"nttCode":"${nttVO.nttCode}"
			};
			
			
			$.ajax({
				url:"/freeBoard/deleteFreeBoardAjax",
				contentType:"application/json;charset=utf-8",
				data:JSON.stringify(data),
				type:"post",
				dataType:"json",
				beforeSend:function(xhr){
					xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
				},
				success:function(result){
					if(result==1){
						resultAlert2(result, "게시글 삭제 ", '리스트로 이동합니다.', '/freeBoard/freeBoardList');
					}else{
						alertError("게시글 삭제가 실패했습니다.");
					}
				}
			});
		});
		/* 게시글 삭제 끝*/
		
		/*게시글 수정 화면으로 이동*/
		$("#freeUpdBtn").on("click",function(){
			$("#atchFileCode3").val('${nttVO.nttAtchFileCode}');
			$("#nttCode2").val('${nttVO.nttCode}');
			$("#nttNm2").val('${nttVO.nttNm}');
			
			$("#freeUpdateFrm").submit();
		});
		/*게시글 수정 끝*/
		
		/*댓글 등록*/
		$("#replyInsertBtn").on("click",function(){
			var nullChk = /^\s*$/;
			var reply = $("#answerCn").val();
			
			/*댓글 null체크*/
			if(nullChk.test(reply)){
				alertError("댓글 내용을 입력해주세요.");
				return;
			}
			
			/*댓글 내용 가져오기*/
			var answerCn = $("#answerCn").val();
			
			var data = {
					"answerCn": answerCn,
					"nttCode":"${nttVO.nttCode}"
				};
			
			/*댓글 등록 전송*/
			$.ajax({
				url:"/freeBoard/createReply",
				contentType:"application/json;charset=utf-8",
				data:JSON.stringify(data),
				type:"post",
				dataType:"json",
				beforeSend:function(xhr){
					xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
				},
				success:function(result){
					if(result.result > 0){
						resultAlert2(result.result,"댓글 등록",'','');
					}
					/*댓글 날짜 포맷 그냥 오늘 날짜로 기입 디비에서 불러오니까 엉킴*/
					var replyDate = "";
					var date = new Date();
					var month = date.getMonth() + 1;
					var day = date.getDate();
					month = month >= 10 ? month : '0' + month;
					day = day >= 10 ? day : '0' + day;
					replyDate = date.getFullYear() + '-' + month + '-' + day;
					
					
// 					<button type='button' class='updateReplyBtn' data-target='updReplyBtn' data-reply-upd-id='"+result.answerVO.answerCode+"'>댓글 수정</button>
					/*댓글 등록 후 바로 내용 그리기*/
					var str="";
					str +="<ul class='replyListAll' data-target='target'>";
					str +=	"<li class='replyListLi'>";
					str += 		"<ul class='replyInfoAll'>";
					str +=			"<li style='display:flex; justify-content: space-between;'>";
					str +=				"<span>";
					str +=					"<span class='replylistId' style='margin-bottom: 10px; font-weight: 800;'>";
					str +=						"<span>"+result.answerVO.mberId+"</span>";
					str +=					"</span>";
					str +=					"<span class='replylistDate' style='margin-bottom: 10px; font-weight: 500;'> ";
					str += 							replyDate
					str	+=					"</span>";
					str +=				"</span>";
					str +=				"<small>";
					str += 					"<button type='button' class='updateReplyBtn' data-target='updateReplyBtn' data-reply-upd-id='"+result.answerVO.answerCode+"'>";
					str	+=						"댓글 수정";
					str +=					"</button>";
					str +=					" <button type='button' class='delReplyBtn' data-target='delReplyBtn' data-reply-id='"+result.answerVO.answerCode+"'>";
					str +=						"댓글 삭제"
					str +=					"</button>";
					str +=				"</small>";
					str +=			"</li>";
					str +=			"<li>";
					str +=				"<p class='replylistCn ' style='margin-bottom: 0px; font-weight: 500;'>";
					str += 					result.answerVO.answerCn
					str	+=				"</p>";
					str +=			"</li>";
					str +=		"</ul>";
					str +=	"</li>";
					str += "</ul>";
					/*댓글 아직 없을 때 상태 내용 지우기*/
					$("#noReplyUl").remove();
					/*새 댓글 그리기*/
					$("#replyDiv").prepend(str);
					/*댓글 등록 내용 값 초기화*/
					$("#answerCn").val("");
				}
			});
			
		});
		/*댓글 수정 이벤트 시작*/
		$("[data-div='replyDiv']").on("click","[data-target='updateReplyBtn']",function(){
			if(!confirm("댓글을 수정하시겠습니까?")){
				alertError("댓글 수정이 취소되었습니다.");
				return;
			}
			
			var btnObj = $(this);//ajax에서의 this와 여기의 this가 다르게 적용되어서 동일하게 사용하기위해 변수에 담음(클릭한 삭제버튼)
			
			var replyListAll = $(this).closest("ul.replyListAll");
			var replyListLi = replyListAll.find($(".replyListLi"));
			var replylistCn = replyListAll.find($(".replylistCn"));
			var replyInfoAll = replyListLi.find(".replyInfoAll");
			var replylistCnBtn = replyListAll.find($(".updateReplyBtn"));
			var answerCode = replylistCnBtn.data("replyUpdId");
 			var replylistCnText = replylistCn.text().trim();
 			var mberId = replyListLi.find(".replylistId").text();
			var replylistDate = replyListLi.find(".replylistDate").text();
			console.log("answerCode->", answerCode);
			console.log("answerCn->", answerCn);

			$(replyInfoAll).remove();
			
			var updateReply='';
			updateReply +=	"<ul class='replyInfoAll'>";
			updateReply +=		"<li style='display:flex; justify-content: space-between;'>";
			updateReply +=			"<span>";
			updateReply +=				"<span class='replylistId' style='margin-bottom: 10px; font-weight: 800;'>";
			updateReply +=					"<span class='freeReMemberId'>"+mberId+"</span>"
			updateReply +=				"</span>";
			updateReply +=				"<span class='replylistDate' style='margin-bottom: 10px; font-weight: 500;'> "+replylistDate+"</span>";
			updateReply +=			"</span>";
			updateReply +=			"<small>";
			updateReply +=				"<button type='button' class='updateReplyBtn' data-target='updateReplyBtn' data-reply-upd-id="+answerCode+">댓글 수정</button>";
			updateReply +=				" <button type='button' class='delReplyBtn' data-target='delReplyBtn' data-reply-id="+answerCode+">댓글 삭제</button>"
			updateReply +=			"</small>";
			updateReply +=		"</li>";
			updateReply +=		"<li>";
			updateReply +=			"<p class='replylistCn' style='margin-bottom: 0px; font-weight: 500; display:flex; padding-top: 10px;'>"
			updateReply +=		"<textarea rows='' cols='' style='width: 96%;resize: none; border:1px solid #ccc; padding:10px 15px; border-top-left-radius: 5px;border-bottom-left-radius: 5px;' class='upCnAra'>"+replylistCnText+"</textarea>";
			updateReply +=			"<button type='button' class='updateCommit' data-target='updateCommit'  style='flex:1;border:none;border-bottom-right-radius:5px;border-top-right-radius:5px;'>";
			updateReply +=				"완료";
			updateReply +=			"</button>";									
			updateReply +=		"</p>";
			updateReply +=	"</li>";
			updateReply +="</ul>";
			
			updateReply +=	"<p class='replylistCn' style='margin-bottom: 0px; font-weight: 500; display:flex; padding-top: 10px;'>";
			
			updateReply +=	"</p>";

			$(replyListLi).append(updateReply);
			
		});
		
		$("[data-div='replyDiv']").on("click","[data-target='updateCommit']",function(){
			var btnObj = $(this);
			var replyListAll = $(this).closest("ul.replyListAll");
			var replyListLi = replyListAll.find($(".replyListLi"));
			var replylistCn = replyListAll.find($(".replylistCn"));
			var replylistCnBtn = replyListAll.find($(".updateReplyBtn"));
			var answerCode = replylistCnBtn.data("replyUpdId");
			var mberId = replyListLi.find(".replylistId").text();
			var replyInfoAll = replyListLi.find(".replyInfoAll");
			console.log("answerCode->", answerCode);
			var upCnAra = replyListAll.find($(".upCnAra"));
			var answerCn = upCnAra.val();
			
			console.log("answerCn->", answerCn);
			
 			var data = {"answerCode": answerCode, "answerCn" : answerCn};
 			
 			var chk = true;
 			if(answerCn==null || answerCn==''){
 				chk=false;
 			}
 			
 			if(!chk){
 				alert("수정할 내용을 입력해주세요.");
 				return;
 			}
 			
 			
 			$.ajax({
				url:"/freeBoard/updateReply",
				contentType:"application/json;charset=utf-8",
				data:JSON.stringify(data),
				type:"post",
				dataType:"json",
				beforeSend:function(xhr){
					xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
				},
				success:function(result){
					console.log("result->", result);
					if(result > 0){
						resultAlert2(result, '댓글 수정 ', '', '');
						$(replyInfoAll).remove();
						var updateAfter="";
						updateAfter +=	"<ul class='replyListAll' data-target='target' style='padding: 0px;border-bottom: 0;'>";
						updateAfter +=		"<li class='replyListLi'>";
						updateAfter +=			"<ul class='replyInfoAll'>";
						updateAfter +=				"<li style='display:flex; justify-content: space-between;'>";
						updateAfter +=					"<span>";
						updateAfter +=						"<span class='replylistId' style='margin-bottom: 10px; font-weight: 800;'>";
						updateAfter +=							"<span>"+mberId+"</span>";
						updateAfter +=						"</span>";
						updateAfter +=						"<span class='replylistDate' style='margin-bottom: 10px; font-weight: 500;'>";
						updateAfter +=							" 방금 전";
						updateAfter +=						"</span>";
						updateAfter +=					"</span>";				
						updateAfter +=					"<small>";
						updateAfter +=						"<button type='button' class='updateReplyBtn' data-target='updateReplyBtn' data-reply-upd-id="+answerCode+">";
						updateAfter +=							"댓글 수정";
						updateAfter +=						"</button>";
						updateAfter +=						" <button type='button' class='delReplyBtn' data-target='delReplyBtn' data-reply-id="+answerCode+">댓글 삭제</button>";
						updateAfter +=					"</small>";			
						updateAfter +=				"</li>";
						updateAfter +=				"<li>";
						updateAfter +=					"<p class='replylistCn' style='margin-bottom: 0px; font-weight: 500; display:flex; padding-top: 10px;'>";
						updateAfter +=						answerCn											
						updateAfter +=					"</p>";
						updateAfter +=				"</li>";
						updateAfter +=			"</ul>";
						updateAfter +=		"</li>";
						updateAfter +=	"</ul>";
						$(replyListLi).append(updateAfter);
						
					}
				
				}
			});
		});
		/*댓글 수정 이벤트 끝*/
		/*댓글 삭제 이벤트 시작*/
		/*댓글 삭제 후 내용 해당 내용도 바로 화면에서 삭제시키려하는데 기존부터 삭제 이후에도 있는 div를 기준으로 지워야 지워짐 */
		$("[data-div='replyDiv']").on("click", "[data-target='delReplyBtn']", function(){
			
			var btnObj = $(this);//ajax에서의 this와 여기의 this가 다르게 적용되어서 동일하게 사용하기위해 변수에 담음(클릭한 삭제버튼)
			var answerCode = btnObj.data("replyId");
			
			var data = {"answerCode": answerCode};
			console.log("data->", data);
			$.ajax({
				url:"/freeBoard/deleteReply",
				contentType:"application/json;charset=utf-8",
				data:JSON.stringify(data),
				type:"post",
				dataType:"json",
				beforeSend:function(xhr){
					xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
				},
				success:function(result){
					console.log("result->", result);
					if(result == 1){
						resultAlert2(result, '댓글 삭제 ', '', '');
						btnObj.closest("[data-target='target']").remove();
						//댓글이 1개만 있는데 삭제할 경우 댓글이 없다는 내용을 띄워야해서 length기준으로 체크
						if($("[data-target='target']").length == 0) {
							var newHtml = '<ul class="replyListAll" id="noReplyUl"><li class="replyListLi"><ul class="replyInfoAll"><li>아직 작성한 댓글이 없습니다.</li></ul></li></ul>';
							$("#replyDiv").html(newHtml);
						}
					}else{
						alertError("댓글 삭제가 실패했습니다.");
					}
				}
			});
			
		});
		/*댓글 삭제 이벤트 끝*/
	});
</script>
<style>
#FreeBoardContainer {
	margin-bottom:50px;
}
#FreeBoardContainer h3{
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

.FreeBoardAll, .replyContainer{
	width: 1400px;
	margin: auto;
	backdrop-filter: blur(10px);
	background-color: rgba(255, 255, 255, 1);
	border-radius: 50px;
	box-shadow: 0px 35px 68px 0px rgba(145, 192, 255, 0.5), inset 0px -6px 16px 0px rgba(145, 192, 255, 0.6), inset 0px 11px 28px 0px rgb(255, 255, 255);
	padding: 50px 80px;
}

.FreeBoardAll .free-cont{
	border: 1px solid #ddd;
	border-radius: 10px;
	padding: 10px 20px;
	min-height: 83px;
	margin-top: 50px;
}
.FreeBoardAll .FreeTit {
	display: flex;
	justify-content: space-between;
	position:relative;
}


.FreeBoardAll .title{
	font-size: 1.8rem;
	font-weight: 700;
	margin-top: 6px;
}

#goFree, #freeDelBtn, #freeUpdBtn{
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
#freeDelBtn{
	background: #111;
	color:#fff;
}

#freeUpdBtn{
	background: #666;
	color:#fff;
}

#goFree:hover,#freeUpdBtn:hover,#freeDelBtn:hover, #replyInsertBtn:hover{
	background: #ffd77a;
	transition: all 1s ease;
	color:#333;
	font-weight:600;
}

.uploadList{
	background: rgb(178 202 255 / 25%);
	backdrop-filter: blur(4px);
	-webkit-backdrop-filter: blur(4px);
	border-radius: 10px;
	border: 1px solid rgba(255, 255, 255, 0.18);
	padding: 15px 20px;
}

.uploadList ul{
	display: block;
}
.uploadList ul li{
	display: block;
	margin-bottom:5px;
}

.uploadList ul li.fileList{
	cursor: pointer;
}
.uploadList ul li.fileList:hover{
	text-decoration: underline;
}

.btn-zone{
	margin: auto;
	text-align: center;
}

.freeInfo{
	margin-top: 20px;
	padding-left: 10px;
	font-size: 1rem;
	border-bottom: 1px solid #ddd;
	padding-bottom: 10px;
}

/*댓글 CSS 시작*/
.replyContainer .replyListAll{
	border-bottom:1px solid #ddd;
	padding: 15px 20px;
}

#replyInsertBtn{
	background: #006DF0; color:#fff; border:none;
}

.updateReplyBtn, .delReplyBtn{
	background: #333;
    color: #fff;
    padding: 8px 10px;
    box-shadow: none;
    border: none;
    border-radius: 20px;
    text-align: center;
    font-weight: 600;
}

.delReplyBtn{
	background: #ffd181;
	color: #333;
	ont-weight: 700;
}

/*댓글 CSS 끝*/
</style>



<div id="FreeBoardContainer">
	<!-- 데이터 전달용 form -->
	<form method="post" action="/freeBoard/download" id="freeUploadFrm">
		<input type="hidden" value="" name="atchFileCode" id="atchFileCode">
		<input type="hidden" value="" name="atchFileSn" id="atchFileSn">
		<sec:csrfInput />
	</form>
	<form method="post" action="/freeBoard/updateFreeBoard" id="freeUpdateFrm">
		<input type="hidden" value="" name="atchFileCode" id="atchFileCode3">
		<input type="hidden" value="" name="nttCode" id="nttCode2">
		<input type="hidden" value="" name="nttNm" id="nttNm2">
		<input type="hidden" value="${nttVO.nttCn}" name="nttCn" id="nttCn2">
		<sec:csrfInput />
	</form>
	<!-- 데이터 전달용 form 끝-->
	<!-- 게시판 타이틀 시작 -->
	<h3>
		<img src="/resources/images/classRoom/freeBrd/freeBoardTit.png" style="width:50px; display:inline-block; vertical-align:middel;">
			자유게시판
		<img src="/resources/images/classRoom/freeBrd/freeBoardTitChat.png" style="width:50px; display:inline-block; vertical-align:middel;">		
	</h3>
	<!-- 게시판 타이틀 끝 -->
		<!-- 게시판 내용 제목/내용 시작 -->
		<div class="FreeBoardAll" style="width: 1400px; margin: auto; margin-bottom:50px; min-height:530px;">
			<div class="FreeTit">
				<input type="text"  class="form-control input-sm" style="width:95%;border:none;background: none;height: 50px;font-size: 1.4rem;display: inline-block;vertical-align: middle; margin-bottom:6px;" 
				name="nttNm" id="nttNm" value="${nttVO.nttNm}" readonly>
				<img src="/resources/images/classRoom/freeBrd/line.png" style="position: absolute;left: 0px;top: 10px;z-index: -1;">
			</div>
			<div class="freeInfo">
				<span style="font-size: 14px;">
					<img src="/resources/images/classRoom/freeBrd/freeDateIcon.png" alt="게시글 등록일자 아이콘" style="width: 12px;margin-top: 4px;vertical-align: top;display: inline-block;"/>
						<small style="font-weight: 600;color: #222;font-size: 13px;">등록일자 : </small>
					<span style="color:#666; font-size: 13px;"><fmt:formatDate value="${nttVO.nttWritngDt}" pattern="yyyy-MM-dd" /></span>
				</span>
				<span style="margin-left:15px; font-size: 13px;">
					<img src="/resources/images/classRoom/freeBrd/freePersonIcon.png" alt="게시글 작성자 아이디 아이콘" style="width: 12px;margin-top: 5px;vertical-align: top;display: inline-block;"/>
						<small style="font-weight: 600;color: #222;font-size: 13px; line-height: 1.75;">작성자 아이디 : </small>
					<span style="color:#666; font-size: 13px;">${nttVO.mberId}</span>
				</span>
<!----------------신고--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------->
<!-- 				<span style="font-size: 16px; float: right; margin-right: 10px;"> -->
<!-- 					<img src="/resources/images/classRoom/freeBrd/freeSiren.png" alt="게시글 신고 횟수 아이콘" style="width: 14px; margin-top:2px; vertical-align: text-top;display: inline-block;"/> -->
<!-- 						<small style="font-weight: 600;color: #d9564e;font-size: 13px;">신고 : </small> -->
<!-- 					<span style="color: #d9564e; font-size: 13px;">0</span> -->
<!-- 				</span> -->
<!----------------신고 끝--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------->
			</div>
			<!-- 첨부파일 시작 -->
			<div class="mb-3" style="display:flex;margin-top:20px;">
				<img src="/resources/images/classRoom/freeBrd/freeFile.png" style="width:40px; display:inline-block;"alt="첨부파일 아이콘"/>
				<span style="font-size:1.05rem; display: inline-block; vertical-align: middle;line-height: 2.5;">첨부파일</span> 
			</div>
			<div class="uploadList">
				<ul>
					<c:choose>
						<c:when test="${fn:length(atchFileVOList) > 0}">
							<c:forEach items="${atchFileVOList}" var="atchVO" varStatus="status">
									<li class="fileList" data-atch-file-code ="${atchVO.atchFileCode}" 
									data-atch-file-sn="${atchVO.atchFileSn}" data-atch-file-nm="${atchVO.atchFileNm}">
										<img alt="${atchVO.atchFileNm}파일 다운로드" src="/resources/images/classRoom/freeBrd/free-download-solid.png" style="width:15px; height: 15px; margin-bottom:3px;"> 
										${atchVO.atchFileNm}
									</li>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<li>
								<p style="margin-bottom:0px;">
									<img alt="파일이 미존재 시 파일 아이콘 " src="/resources/images/classRoom/freeBrd/free-file-solid.png"  style=" width: 13px;margin-right: 2px; margin-bottom: 3px;">
									첨부된 파일이 없습니다.
								</p>
							</li>
						</c:otherwise>
					</c:choose>
				</ul>
			</div>
			<!-- 첨부파일 끝-->
			<div class="free-cont">
				​​​​​​​​<div id="smarteditor">
					<div id="nttCn" style="width:412px;" style="border:1px solid #ddd;">
						${nttVO.nttCn}
					</div>
				</div>
			</div>
			<div class="btn-zone">
				​​​​​​​​<input type="button" value="목록" id="goFree"/>
				<c:if test="${USER_INFO.mberId == nttVO.mberId || USER_INFO.vwMemberAuthVOList[0].cmmnDetailCode == 'ROLE_A14002' ||  USER_INFO.vwMemberAuthVOList[1].cmmnDetailCode == 'ROLE_A14002'}">
					​​​​​​​​<input type="button" value="수정" id="freeUpdBtn"/> 
					​​​​​​​​<input type="button" value="삭제" id="freeDelBtn"/>
				</c:if>
			</div>
		</div>
		<!-- 게시판 내용 제목/내용 끝 -->
		<!-- 댓글 시작 -->
		<div class="replyContainer">
			<!-- 댓글 작성 form 시작-->
			<form id="freeReplyInsertForm">
				<input type="hidden" value="" name="nttCode" id="nttCode3">
				<h4>댓글 <button type= "button" class="auto-reply-btn">자동입력</button></h4>
				
				<div class="replyForm" style="display:flex; margin-bottom:35px;">
					<textarea name="answerCn" rows="" cols=""  id="answerCn" style="resize: none; width:96%; padding:10px 15px; border: 1px solid #ccc; border-radius:3px; border-right: none;  border-bottom-right-radius:0px; border-top-right-radius:0px;"></textarea>
					<button type="button" id="replyInsertBtn" style="flex:1; border:none;  border-bottom-right-radius:5px; border-top-right-radius:5px;">
						등록
					</button>
				</div>
				<sec:csrfInput />
			</form>
			<!-- 댓글 작성 form 끝-->
			<div data-div="replyDiv" id="replyDiv" style="border-top:1px solid #ddd;">
				<c:choose>
					<c:when test="${fn:length(replyList) > 0}">
						<c:forEach var="answerVO" items="${replyList}" varStatus="status">
						<ul class="replyListAll" data-target="target">
							<li class="replyListLi">
									<ul class="replyInfoAll">
										<li style="display:flex; justify-content: space-between;">
											<span>
												<span class="replylistId" style="margin-bottom: 10px; font-weight: 800;">
													<span class="freeReMemberId">${answerVO.mberId}</span>
												</span>
												<span class="replylistDate" style="margin-bottom: 10px; font-weight: 500;">
													<fmt:formatDate value="${answerVO.answerWritngDt}" pattern="yyyy-MM-dd" />
												</span>
											</span>
											<c:if test="${USER_INFO.mberId == answerVO.mberId || USER_INFO.vwMemberAuthVOList[0].cmmnDetailCode == 'ROLE_A14002' ||  USER_INFO.vwMemberAuthVOList[1].cmmnDetailCode == 'ROLE_A14002'}">
												<small>
													<button type="button" class="updateReplyBtn" data-target="updateReplyBtn" data-reply-upd-id="${answerVO.answerCode}">댓글 수정</button>
													<button type="button" class="delReplyBtn" data-target="delReplyBtn" data-reply-id="${answerVO.answerCode}">댓글 삭제</button>
												</small>
											</c:if>
										</li>
										<li>
											<p class="replylistCn " style="margin-bottom: 0px; font-weight: 500; display:flex; padding-top: 10px;">
												${answerVO.answerCn}											
											</p>
										</li>
									</ul>
								</li>
							</ul>	
						</c:forEach>
					</c:when>
					<c:otherwise>
						<ul class="replyListAll" id="noReplyUl">
							<li class="replyListLi">
								<ul class="replyInfoAll">
									<li>아직 작성한 댓글이 없습니다.</li>
								</ul>
							</li>
						</ul>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
		<!-- 댓글 끝 -->
</div>