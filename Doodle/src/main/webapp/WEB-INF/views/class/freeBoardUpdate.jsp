<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<!-- 네이버 스마트 에디터 JS -->
<script type="text/javascript" src="/resources/se2/js/HuskyEZCreator.js" charset="UTF-8"></script>
<!-- 자유게시판 수정 jsp -->
<%-- ${nttVO} --%>
<%-- ${atchFileVO} --%>

<script>
var oEditors = [];
var snArr = "";
$(function() {
	
	nhn.husky.EZCreator.createInIFrame({
		oAppRef : oEditors,
		elPlaceHolder : "nttCn",
		//SmartEditor2Skin.html 파일이 존재하는 경로
		sSkinURI : '<c:url value="/resources/se2/SmartEditor2Skin.html"/>',
		htParams : {
			bUseToolbar : true,				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseVerticalResizer : false,			// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseModeChanger : false,			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
			bSkipXssFilter : true,				// client-side xss filter 무시 여부 (true:사용하지 않음 / 그외:사용)
			fOnBeforeUnload : function(){},
		}, //boolean
		fOnAppLoad : function(){
		},
		fCreator: "createSEditor2"
	});
	
	$("#updateBtn").on("click",function(){
		// 에디터에 적은 내용 가져오기
		var nttNm = $("#nttNm").val();
		var nttCn = oEditors.getById["nttCn"].getIR();
		
		//게시글 null체크
		if(nttNm == null || nttNm==''){
			alertError('제목을 입력해주세요!');
			return;
		}else if(nttCn==null || nttCn=='' || nttCn=='<br>'){
			alertError('내용을 입력해주세요!');
			return;
		}
		
		oEditors.getById["nttCn"].exec("UPDATE_CONTENTS_FIELD",[]);
		
		//수정버튼 실행
		var frm = new FormData($("#frm")[0]);
		if(snArr.length > 0) {
			// 1,2,3, --> 1,2,3
			snArr = snArr.substring(0, snArr.lastIndexOf(','));
			frm.append("snArr", snArr);
		}
		
		$.ajax({
			url : "/freeBoard/updateFreeBoardAjax",
			processData:false,
			contentType:false,
			data:frm,
			dataType:"text",
			type:"post",
			beforeSend:function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			},
			success:function(result){
				if(result==1){
					resultAlert2(result, '게시글 수정 ', '리스트로 이동합니다.', '/freeBoard/freeBoardList');
				}else{
					alertError("게시글 수정 실패!");
				}
			}
		});
		
	});
	
	$("#cancelBtn").on("click",function(){
		resultConfirm('수정을 취소하시겠습니까?', '입력하신 내용은 저장되지 않습니다.', '/freeBoard/freeBoardList');
	});
	
	$(".FreedelAtch").on("click",function(){
		snArr += $(this).parent().data('atchFileSn') + ","
		$(this).parent().remove();
	});
	
});
</script>
<style>
#FreeBoardContainer h3{
	font-size: 2.2rem;
	text-align: center;
	margin-top: 60px;
	backdrop-filter: blur(4px);
	background-color: rgba(255, 255, 255, 1);
	border-radius: 50px;
	box-shadow: 35px 35px 68px 0px rgba(145, 192, 255, 0.5), inset -8px -8px 16px 0px rgba(145, 192, 255, 0.6), inset 0px 11px 28px 0px rgb(255, 255, 255);
	width: 370px;
	padding-top: 35px;
	padding-bottom: 35px;
	margin: auto;
	margin-top: 50px;
	margin-bottom: 40px;
}

.FreeBoardAll{
	width: 1400px;
	margin: auto;
	backdrop-filter: blur(10px);
	background-color: rgba(255, 255, 255, 1);
	border-radius: 50px;
	box-shadow: 0px 35px 68px 0px rgba(145, 192, 255, 0.5), inset 0px -6px 16px 0px rgba(145, 192, 255, 0.6), inset 0px 11px 28px 0px rgb(255, 255, 255);
	padding: 50px 80px;
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

.btn-zone{
	margin: auto;
	text-align: center;
}
#updateBtn, #cancelBtn{
	background: #006DF0;
	padding: 15px 30px;
	font-size: 1rem;
	border: none;
	color: #fff;
	font-weight: 700;
	border-radius: 5px;
	margin-top: 30px;
	margin-right:15px;
}
#cancelBtn{
	background: #333;
	color:#fff
}
#updateBtn:hover, #cancelBtn:hover{
	background: #ffd77a;
	transition: all 1s ease;
	color:#333;
}

.uploadList{
	background: rgb(178 202 255 / 25%);
	backdrop-filter: blur(4px);
	-webkit-backdrop-filter: blur(4px);
	border-radius: 10px;
	border: 1px solid rgba(255, 255, 255, 0.18);
	padding: 15px 20px;
}
.fileList:hover{
	text-decoration: underline;
}

.FreedelAtch{
	cursor: pointer;
}
</style>
<!-- 자유게시판 hover효과 js -->
<div id="FreeBoardContainer">
	<h3>
		<img src="/resources/images/classRoom/freeBrd/freeBoardTit.png" style="width:50px; display:inline-block; vertical-align:middel;">
			자유게시판
		<img src="/resources/images/classRoom/freeBrd/freeBoardTitChat.png" style="width:50px; display:inline-block; vertical-align:middel;">		
	</h3>
	<form id="frm">
		<div class="FreeBoardAll" style="width: 1400px; margin: auto; margin-bottom:50px;">
			<input type="hidden" value="${nttVO.nttCode}" name="nttCode">
			<input type="hidden" value="${nttVO.clasCode}" name="clasCode">
			<input type="hidden" value="${atchFileVO.atchFileCode}" name="atchFileCode">
			<div class="FreeTit">
				<input type="text"  class="form-control input-sm" style="width:95%;border:none;background: none;height: 50px;font-size: 1.4rem;display: inline-block;vertical-align: middle; margin-bottom:6px;" 
				name="nttNm" id="nttNm" value="${nttVO.nttNm}">
				<img src="/resources/images/classRoom/freeBrd/line.png" style="position: absolute;left: 0px;top: 10px;z-index: -1;">
			</div>
			<div class="mb-3" style="display:flex;">
				<img src="/resources/images/classRoom/freeBrd/freeFile.png" style="width:40px; display:inline-block;">
				<span style="font-size:1.05rem; display: inline-block; vertical-align: middle;line-height: 2.5;">첨부파일</span> 
			</div>
			<div class="uploadList">
				<ul>
					<c:if test="${fn:length(atchFileVOList) > 0}">
						<c:forEach items="${atchFileVOList}" var="atchVO" varStatus="status">
							<li class="fileList" data-atch-file-sn="${atchVO.atchFileSn}" style="display: flex; justify-content: flex-start;">
								<img  class="FreedelAtch"alt="${atchVO.atchFileNm}파일 삭제" src="/resources/images/classRoom/freeBrd/free-circle-xmark-solid.png" style="width:15px; height: 15px; margin-top: 3px;margin-right: 5px;">
								<span class="fileName">${atchVO.atchFileNm}</span>
							</li>
						</c:forEach>
					</c:if>
					<li>
						<input name="upload" class="form-control" style=" background:none; display:inline-block; border: none;"type="file" id="upload" multiple="multiple">
					</li>
				</ul>
			</div>
			<div class="free-cont">
				​​​​​​​​<div id="smarteditor">
					<textarea name="nttCn" id="nttCn" style="width: 100%; height: 412px;">
						${nttVO.nttCn}
					</textarea>
				</div>
			</div>
			<div class="btn-zone">
				​​​​​​​​<input type="button" value="수정" id="updateBtn"/>
				​​​​​​​​<input type="button" value="취소" id="cancelBtn"/>
			</div>
		</div>
	</form>
</div>
