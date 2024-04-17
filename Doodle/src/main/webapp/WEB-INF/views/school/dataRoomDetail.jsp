<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<style>
#dataRoomContainer {
	margin-bottom:50px;
}

#dataRoomContainer h3{
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

#dataRoomContainer .dataRoomAll{
	width: 1400px;
	margin: auto;
	backdrop-filter: blur(10px);
	background-color: rgba(255, 255, 255, 1);
	border-radius: 50px;
	box-shadow: 0px 35px 68px 0px rgba(145, 192, 255, 0.5), inset 0px -6px 16px 0px rgba(145, 192, 255, 0.6), inset 0px 11px 28px 0px rgb(255, 255, 255);
	padding: 50px 80px;
}

#dataRoomContainer .dataRoomAll .free-cont{
	border: 1px solid #ddd;
	border-radius: 10px;
	padding: 10px 20px;
	min-height: 83px;
	margin-top: 50px;
}

#dataRoomContainer .dataRoomAll .FreeTit {
	display: flex;
	justify-content: space-between;
	position:relative;
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

#listBtn, #updateBtn, #deleteBtn{
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

#deleteBtn{
	background: #111;
	color:#fff;
}

#updateBtn{
	background: #666;
	color:#fff;
}

#listBtn:hover,#updateBtn:hover,#deleteBtn:hover{
	background: #ffd77a;
	transition: all 1s ease;
	color:#333;
	font-weight:600;
}


.dataRoomInfo{
	margin-top: 20px;
	padding-left: 10px;
	font-size: 1rem;
	border-bottom: 1px solid #ddd;
	padding-bottom: 10px;
}
</style>
<script>
	var schulCode = "${schulCode}";
 $(function(){
	//console.log("schulCode",schulCode);

	/* 파일 개별다운로드 시작 */
	$('.fileList').on("click",function(){
			var atchFileCode  = $(this).data("atchFileCode");
			var atchFileSn  = $(this).data("atchFileSn");
			var atchFileNm  = $(this).data("atchFileNm");
			$("#atchFileCode").val(atchFileCode);
			$("#atchFileSn").val(atchFileSn);
			$("#atchFileNm").val(atchFileNm);
			$("#dataUploadFrm").submit();
		});
		/* 파일 개별다운로드 끝 */
	
	//수정버튼
	$("#updateBtn").on("click",function(){
		Swal.fire({
			icon : "warning",
			title: "수정하시겠습니까?",
					
			showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
		    confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
		    cancelButtonColor: '#d33', // cancel 버튼 색깔 지정
		    confirmButtonText: '확인', // confirm 버튼 텍스트 지정
		    cancelButtonText: '취소', // cancel 버튼 텍스트 지정
		}).then(result => {
		    if (result.isConfirmed) { // 만약 모달창에서 confirm 버튼을 눌렀다면
		    	$("#atchFileCode3").val('${nttVO.nttAtchFileCode}');
				$("#nttCode2").val('${nttVO.nttCode}');
				$("#nttNm2").val('${nttVO.nttNm}');

				$("#dataUpdateFrm").submit();
		    } 
		});
		
	});
	
	
	//삭제
	$("#deleteBtn").on("click",function(){
		Swal.fire({
			icon : "warning",
			title: "삭제하시겠습니까?",
					
			showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
		    confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
		    cancelButtonColor: '#d33', // cancel 버튼 색깔 지정
		    confirmButtonText: '확인', // confirm 버튼 텍스트 지정
		    cancelButtonText: '취소', // cancel 버튼 텍스트 지정
		}).then(result => {
		    if (result.isConfirmed) {
		//삭제시작----------------------------------------
			let nttAtchFileCode = "${nttVO.nttAtchFileCode}";
			let nttCode = "${nttVO.nttCode}";
			
			
			let data = {
					"schulCode":schulCode,
					"nttCode":nttCode,
					"nttAtchFileCode":nttAtchFileCode//첨부파일도 같이 삭제되기 위함
			};
			
			//console.log("data : ", data);
			
			$.ajax({
				url:"/school/dataRoomDeleteAjax",
				contentType:"application/json;charset=utf-8",
				data:JSON.stringify(data),
				type:"post",
				dataType:"text",
				beforeSend:function(xhr){
					xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
				},
				success:function(result){
					//console.log("result:",result);
					location.href = "/school/dataRoom";
				}
			});
		//삭제끝----------------------------------------
		    } 
		});
	});
	
	
	//목록버튼
	$("#listBtn").on("click",function(){
		//console.log("목록이다옹");
		location.href = "/school/dataRoom"; //게시글 목록으로 가기
	});
}); 
</script>


<!------------------------------------------------------------------------------->
<div id="dataRoomContainer">
	<!-- 데이터 전달용 form -->
	<form method="post" action="/freeBoard/download" id="dataUploadFrm">
		<input type="hidden" value="" name="atchFileCode" id="atchFileCode">
		<input type="hidden" value="" name="atchFileSn" id="atchFileSn">
		<sec:csrfInput />
	</form>
	<!-- 데이터 전달용 form -->
	<form method="post" action="/school/dataRoomUpdate" id="dataUpdateFrm">
		<input type="hidden" value="" name="atchFileCode" id="atchFileCode3">
		<input type="hidden" value="" name="nttCode" id="nttCode2">
		<input type="hidden" value="" name="nttNm" id="nttNm2">
		<input type="hidden" value="${nttVO.nttCn}" name="nttCn" id="nttCn2">
		<sec:csrfInput />
	</form>
	<!-- 데이터 전달용 form 끝 -->
	<!-- 게시판 타이틀 시작 -->
	<h3>
		<img src="/resources/images/school/dataRoom1.png" style="width:50px; display:inline-block; vertical-align:middel;">
				자료실
		<img src="/resources/images/school/dataRoom2.png" style="width:50px; display:inline-block; vertical-align:middel;">		
	</h3>
	<!-- 게시판 타이틀 끝 -->
	<!-- 게시판 내용 제목/내용 시작 -->
	<div class="dataRoomAll">
		<div class="FreeTit">
			<input type="text" class="form-control input-sm" style="width:95%;border:none;background: none;height: 50px;font-size: 1.4rem;display: inline-block;vertical-align: middle; margin-bottom:6px;" name="nttNm" id="nttNm" value="${nttVO.nttNm}" readonly required />
			<img src="/resources/images/classRoom/freeBrd/line.png" style="position: absolute;left: 0px;top: 10px;z-index: -1;">
		</div>
		<div class="dataRoomInfo">
			<span style="font-size: 14px;">
				<img src="/resources/images/classRoom/freeBrd/freeDateIcon.png" alt="게시글 등록일자 아이콘" style="width: 12px;margin-top: 4px;vertical-align: top;display: inline-block;">
					<small style="font-weight: 600;color: #222;font-size: 13px;">등록일자 : </small>
				<span style="color:#666; font-size: 13px;"><fmt:formatDate value="${nttVO.nttWritngDt}" pattern="yyyy-MM-dd" /></span>
			</span>
			<span style="margin-left:15px; font-size: 13px;">
				<img src="/resources/images/classRoom/freeBrd/freePersonIcon.png" alt="게시글 작성자 아이디 아이콘" style="width: 12px;margin-top: 5px;vertical-align: top;display: inline-block;">
					<small style="font-weight: 600;color: #222;font-size: 13px; line-height: 1.75;">작성자 이름 : </small>
				<span style="color:#666; font-size: 13px;">${nttVO.mberNm}</span>
			</span>
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
				<div id="nttCn">
					${nttVO.nttCn}
				</div>
			</div>
		</div>
		<div class="btn-zone">
			​​​​​​​​<input type="button" value="목록" id="listBtn"/>
			<c:if test="${USER_INFO.mberId == nttVO.mberId}">
				​​​​​​​​<input type="button" value="수정" id="updateBtn"/> 
				​​​​​​​​<input type="button" value="삭제" id="deleteBtn"/>
			</c:if>
		</div>
	</div>
	<!-- 게시판 내용 제목/내용 끝 -->
		
</div>