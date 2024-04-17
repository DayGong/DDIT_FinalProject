<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<!-- 네이버 스마트 에디터 JS -->
<script type="text/javascript" src="/resources/se2/js/HuskyEZCreator.js" charset="UTF-8"></script>
<script type="text/javascript">
const header = "${_csrf.headerName}";
const token = "${_csrf.token}"; 
// 네이버 스마트 에디터 API
var oEditors = [];
var snArr = "";
$(function() {
	nhn.husky.EZCreator.createInIFrame({
		oAppRef : oEditors,
		elPlaceHolder : "nttCn",
		//SmartEditor2Skin.html 파일이 존재하는 경로
		sSkinURI : '<c:url value="/resources/se2/SmartEditor2Skin.html"/>',
		htParams : {
			bUseToolbar : true,						// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseVerticalResizer : false,			// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseModeChanger : false,				 // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
			bSkipXssFilter : true,			// client-side xss filter 무시 여부 (true:사용하지 않음 / 그외:사용)
			//aAdditionalFontList : aAdditionalFontSet,			// 추가 글꼴 목록
			fOnBeforeUnload : function(){
				 //alert("완료!");
			},
//							 I18N_LOCALE : sLang
			}, //boolean
			fOnAppLoad : function(){
							//예제 코드
//							 oEditors.getById["nttCn"].exec("PASTE_HTML", ["로딩이 완료된 후에 본문에 삽입되는 text입니다."]);
			},
		fCreator: "createSEditor2"
	});
// 네이버 스마트 에디터 API 끝

	//수정완료버튼 시작
	$("#updateBtn").on("click",function(){
		// 에디터에 적은 내용 가져오기
		var nttNm = $("#nttNm").val();
		var nttCn = oEditors.getById["nttCn"].getIR();
		
		//게시글 null체크
		if(nttNm == null || nttNm==''){
			alert("제목을 입력해주세요!");
			return;
		}else if(nttCn==null || nttCn=='' || nttCn=='<br>'){
			alert("내용을 입력해주세요!");
			return;
		}
		
		oEditors.getById["nttCn"].exec("UPDATE_CONTENTS_FIELD",[]);
		console.log("nttNm",nttNm);
		console.log("nttCn",nttCn);
		
		//게시글 등록 실행
		var frm = new FormData($("#frm")[0]);
		if(snArr.length > 0) {
				// 1,2,3, --> 1,2,3
				snArr = snArr.substring(0, snArr.lastIndexOf(','));
				frm.append("snArr", snArr);
			}

		$.ajax({
				url:"/school/dataRoomUpdateAjax",
				processData:false,
				contentType:false,
				data:frm,
				dataType:"text",
				type:"post",
				beforeSend:function(xhr){
					xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
				},
				success:function(result){
					console.log("result :",result);
					if(result==1){
						Swal.fire({
							icon : "success",
							title: "게시글이 수정되었습니다."
						}).then(result => {
		 				   if (result.isConfirmed) {
							location.href="/school/dataRoom"; //자료실 목록
						   }
						});
					}else{
						Swal.fire({
							icon : "error",
							title: "게시글이 수정되지 않았습니다."
						})
					}
				}
			}); //ajax끝
	});//수정완료버튼 끝

	$("#cancelBtn").on("click",function(){
		
		Swal.fire({
			icon : "warning",
			title: "수정을 취소 하시겠습니까?",
			
			showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
		    confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
		    cancelButtonColor: '#d33', // cancel 버튼 색깔 지정
		    confirmButtonText: '확인', // confirm 버튼 텍스트 지정
		    cancelButtonText: '취소', // cancel 버튼 텍스트 지정
		}).then(result => {
		    if (result.isConfirmed) {
				Swal.fire({
					icon : "success",
					title: "수정 작업이 취소되었습니다.",
					showConfirmButton: false, // 확인 버튼 없음
           			 timer: 1500 // 1.5초 후에 자동으로 닫힘
				}).then(() => {
					history.back(); // 이전 화면으로 이동
				});
			}
		})
		
	});

	//첨부파일 개별 삭제
	$(".FreedelAtch").on("click",function(){
		snArr += $(this).parent().data('atchFileSn') + ","
		console.log("snArr->",snArr); // 1,2,3,
		$(this).parent().remove();
	});
	
});
</script>
<style>
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

.dataRoomAll{
	width: 1400px;
	margin: auto;
	backdrop-filter: blur(10px);
	background-color: rgba(255, 255, 255, 1);
	border-radius: 50px;
	box-shadow: 0px 35px 68px 0px rgba(145, 192, 255, 0.5), inset 0px -6px 16px 0px rgba(145, 192, 255, 0.6), inset 0px 11px 28px 0px rgb(255, 255, 255);
	padding: 50px 80px;
}

.dataRoomAll .dataRoomTit {
	display: flex;
	justify-content: space-between;
	position:relative;
}

.dataRoomAll .title{
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
<!-- 자료실 hover효과 js -->
<div id="dataRoomContainer">
	<h3>
		<img src="/resources/images/school/dataRoom1.png" style="width:50px; display:inline-block; vertical-align:middel;">
				자료실
		<img src="/resources/images/school/dataRoom2.png" style="width:50px; display:inline-block; vertical-align:middel;">		
	</h3>
	<form id="frm">
		<div class="dataRoomAll" style="width: 1400px; margin: auto; margin-bottom:50px;">
			<input type="hidden" value="${nttVO.nttCode}" name="nttCode">
			<input type="hidden" value="${nttVO.clasCode}" name="clasCode">
			<input type="hidden" value="${nttVO.schulCode}" name="schulCode">
			<input type="hidden" value="${atchFileVO.atchFileCode}" name="atchFileCode">
			<div class="dataRoomTit">
				<input type="text"  class="form-control input-sm" style="width:95%;border:none;background: none;height: 50px;font-size: 1.4rem;display: inline-block;vertical-align: middle; margin-bottom:6px;" 
				name="nttNm" id="nttNm" value="${nttVO.nttNm}">
				<img src="/resources/images/classRoom/freeBrd/line.png" style="position: absolute;left: 0px;top: 10px;z-index: -1;">
			</div>
			<div class="mb-3" style="display:flex;">
				<img src="/resources/images/classRoom/freeBrd/freeFile.png" style="width:40px; display:inline-block;">
				<span style="font-size:1.05rem; display: inline-block; vertical-align: middle;line-height: 2.5;">첨부파일</span> 
<!-- 				<input name="upload" class="form-control" style=" margin-top: 15px; display:inline-block; border: none;"type="file" id="upload" multiple="multiple"> -->
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