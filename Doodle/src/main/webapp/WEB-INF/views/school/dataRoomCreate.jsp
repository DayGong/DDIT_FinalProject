<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<!-- 네이버 스마트 에디터 JS -->
<script type="text/javascript" src="/resources/se2/js/HuskyEZCreator.js" charset="UTF-8"></script>
<script type="text/javascript">
const header = "${_csrf.headerName}";
const token = "${_csrf.token}"; 
var schulCode = "${schulCode}";
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
//				oEditors.getById["nttCn"].exec("PASTE_HTML", ["로딩이 완료된 후에 본문에 삽입되는 text입니다."]);
				oEditors.getById['nttCn'].setDefaultFont( "나눔고딕", 18);
			},
		fCreator: "createSEditor2"
	});
	// 네이버 스마트 에디터 API 끝

	//등록버튼 클릭 이벤트 시작
	$("#createBtn").on("click",function(){
		// 에디터에 적은 내용 가져오기
		var nttNm = $("#nttNm").val();
		var nttCn = oEditors.getById["nttCn"].getIR();
		
		//게시글 null체크
		if(nttNm == null || nttNm==''){
			Swal.fire({
						icon : "warning",
						title: "제목을 입력해주세요!"
					});
			return;
		}else if(nttCn==null || nttCn=='' || nttCn=='<br>'){
			Swal.fire({
						icon : "warning",
						title: "내용을 입력해주세요!"
					});
			return;
		}
		
		oEditors.getById["nttCn"].exec("UPDATE_CONTENTS_FIELD",[]);
		console.log("nttNm",nttNm);
		console.log("nttCn",nttCn);
		
		//게시글 등록 실행
		var frm = new FormData($("#frm")[0]);
		$.ajax({
			url : "/school/dataRoomCreateAjax",
			processData:false,
			contentType:false,
			data:frm,
			dataType:"text",
			type:"post",
			beforeSend:function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			},
			success:function(nttCode){
				console.log("nttCode!!",nttCode);
				console.log("schulCode!!",schulCode);
				//게시글 등록이 성공했을때 1, 실패했을때 0
				if(nttCode!="fail"){
					Swal.fire({
						icon : "success",
						title: "게시글이 등록되었습니다."
					}).then(result => {
							if (result.isConfirmed) { // 만약 모달창에서 confirm 버튼을 눌렀다면
								location.href = `/school/dataRoomDetail?schulCode=\${schulCode}&nttCode=\${nttCode}`;
							}
						});
				}else{
					Swal.fire({
						icon : "error",
						title: "게시글이 등록되지 않았습니다."
					});
					return;
				}
			}
		})	
	});
});


function autoComplete(){

	//게시글 제목
	let nttNm = document.getElementById("nttNm");
	nttNm.value = `2024학년도 교외현장체험학습 신청서와 보고서 양식(국내외)`;

	/* let nttCn = document.getElementById("nttCn");
	nttCn.value = `2024학년도 변경된 교외체험학습 신청서 및 보고서 양식 안내드립니다.`;
	nttCn.value += `체험학습 2일 전에 신청하여 학교장 허가를 받아야 하며, 체험학습 실시 후 7일 이내에 보고서를 제출해야 출석으로 인정됩니다.`;
	nttCn.value += `(단, 부모와 동행하지 않을 경우 4쪽 위임장 작성 후 제출)`;
	nttCn.value += `※ 국내 교외체험학습 / 국외 교외체험학습의 양식이 다르니 구분하여 제출부탁드립니다.`; */

	// 네이버 스마트 에디터의 내용 설정
    oEditors.getById["nttCn"].exec("PASTE_HTML", [`<p>2024학년도 변경된 교외체험학습 신청서 및 보고서 양식 안내드립니다.</p>
    <p>체험학습 2일 전에 신청하여 학교장 허가를 받아야 하며, </p>
    <p>체험학습 실시 후 7일 이내에 보고서를 제출해야 출석으로 인정됩니다.</p>
    <p>(단, 부모와 동행하지 않을 경우 4쪽 위임장 작성 후 제출)</p>
    <p>※ 국내 교외체험학습 / 국외 교외체험학습의 양식이 다르니 구분하여 제출부탁드립니다.</p>`]);
	}

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

.btn-zone{
	margin: auto;
	text-align: center;
}

#createBtn:hover{
	background: #ffd77a;
	transition: all 1s ease;
	color:#333;
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
			<div class="dataRoomTit">
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
			<div class="btn-zone">
				​​​​​​​​<input type="button" value="등록" id="createBtn"/>
				<i class="fa fa-pencil-square-o" aria-hidden="true" onclick="autoComplete()"></i> <!-- 자동생성버튼 -->
			</div>
		</div>
	</form>
</div>