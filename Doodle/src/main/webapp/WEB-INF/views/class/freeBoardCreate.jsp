<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<!-- 네이버 스마트 에디터 JS -->
<script type="text/javascript" src="/resources/se2/js/HuskyEZCreator.js" charset="UTF-8"></script>
<%-- <h1>자유게시판 create${USER_INFO.mberNm}</h1> --%>
<script type="text/javascript">


// 네이버 스마트 에디터 API
var oEditors = [];
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
//등록버튼 클릭 이벤트 시작
$("#insertBtn").on("click",function(){
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
	console.log($("#nttCn").val());
	
	//게시글 등록 실행
	var frm = new FormData($("#frm")[0]);
	$.ajax({
		url : "/freeBoard/freeBoarRegistration",
		processData:false,
		contentType:false,
		data:frm,
		dataType:"text",
		type:"post",
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success:function(result){
			//게시글 등록이 성공했을때 1, 실패했을때 0
				console.log("result : ", result);
			if(result==1){
				resultAlert2(result, '게시글 등록 ', '리스트로 이동합니다.', '/freeBoard/freeBoardList');
			}else{
				alertError('게시글 등록 실패!');
			}
		}
	})	
});
	
});


</script>


<style>
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
			<div class="FreeTit">
				<input type="text"  class="form-control input-sm" style="width:95%;border:none;background: none;height: 50px;font-size: 1.4rem;display: inline-block;vertical-align: middle; margin-bottom:6px;" name="nttNm" id="nttNm" placeholder="제목을 입력해주세요.">
				<img src="/resources/images/classRoom/freeBrd/line.png" style="position: absolute;left: 0px;top: 10px;z-index: -1;">
			</div>
			<div class="mb-3" style="display:flex;">
				<img src="/resources/images/classRoom/freeBrd/freeFile.png" style="width:40px; display:inline-block;">
				<input name="upload" class="form-control" style=" margin-top: 15px; display:inline-block; border: none;"type="file" id="upload" multiple="multiple">
			</div>
			<div class="free-cont">
				​​​​​​​​<div id="smarteditor">
					<textarea name="nttCn" id="nttCn" style="width: 100%; height: 412px;"></textarea>
				</div>
			</div>
			​​​​​​​​<input type="button" value="등록" id="insertBtn"/>
		</div>
	</form>
</div>