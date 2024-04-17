<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
/* 글 양식 셀렉트 박스 시작 */
#selectNtcn {
	height: inherit;
	background: transparent;
	outline: 0 none;
	padding: 0 5px;
	position: relative;
	z-index: 3;
	width: 100%;
	height: 30px;
	margin-left: 10px;
	font-size: 16px;
	padding: 5px; float: right;
	border: 1px solid #ccc;
	border-radius: 7px;
	margin-top: 7px;
}
  
#selectNtcn option {
	background: #fff;
	color: #999;
	font-weight: bolder;
	padding: 3px 0;
	font-size: 16px;
}

#selectNtcn:hover {
	background: #f5f5f5;
}
/* 글 양식 셀렉트 박스 끝 */

iframe{
	margin-bottom: 10px;
}

.ntcnContent{
	width: 100%;
}
#NtcnContainer h3{
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

.NtcnAll{
	width: 1200px;
	margin: auto;
	backdrop-filter: blur(10px);
	background-color: rgba(255, 255, 255, 1);
	border-radius: 50px;
	box-shadow: 0px 35px 68px 0px rgba(145, 192, 255, 0.5), inset 0px -6px 16px 0px rgba(145, 192, 255, 0.6), inset 0px 11px 28px 0px rgb(255, 255, 255);
	padding: 50px 80px;
}

.NtcnAll .NtcnTit {
	display: flex;
	justify-content: space-between;
	position:relative;
}

.NtcnAll .title{
	font-size: 1.8rem;
	font-weight: 700;
	margin-top: 6px;
}

#insertBtn, #cancelBtn, #autoBtn{
	display: block;
    margin: 10px;
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

#autoBtn{
	width: 87px;
	padding: 15px 3px;
	background: #303030;
}

#insertBtn:hover, #cancelBtn:hover{
	background: #ffd77a;
	transition: all 1s ease;
	color:#333;
}

#cancelBtn{
	background: #666;
}

.btnContainer{
   display: flex;
   justify-content: center;
}
.file-upload {
  width: 100%;
}
.input {
  display: flex;
  align-items: center;
}
.prepend-big-btn {
  position: ;
}
.icon-right {
  margin-right: 10px;
}
.file-button {
  background-color: #007bff;
  color: #fff;
  padding: 8px 16px;
  margin-right: 10px;
  cursor: pointer;
  
}
.file-button input {
  display: none;
}
.file-button label {
  cursor: pointer;
}
.file-upload input[type="text"] {
  flex-grow: 1;
/*   margin-left: 10px; */
  padding: 8px;
  border: 1px solid #ced4da;
  width: calc(100% - 100px - 10px - 16px); /* Subtract button width and margins */
}
.input-file-button{
  background-color:#007bff;
  border-radius: 4px;
  color: white;
  cursor: pointer;
}

.file-name{
  width: 300px;
  height: 32px;
  border-style: none;
}

.form-control{
	width: 100%;
}

label{
	margin-bottom: 0px;
}

.file-upload-div {
    border: 1px solid #ccc;
    margin: 0px 0px;
    padding: 20px;
    text-align: center;
}

/* 업로드한 이미지 썸네일이 출력되는 Div */
#imageDiv{
	display: flex;
	justify-content: flex-start;
	border: 1px solid #ccc;
	height: 105px;
/* 	margin-top: 10px; */
    margin-bottom: 10px;
}

.images{
	width: 90px;
	height: 90px;
	object-fit: cover;
	border-radius: 5px;
	margin: 7px 0px 7px 7px;
/* 	margin-top: 10px; */
	cursor: pointer;
}
</style>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<!-- 네이버 스마트 에디터 JS -->
<script type="text/javascript" src="/resources/se2/js/HuskyEZCreator.js" charset="UTF-8"></script>
<script type="text/javascript">
// 전역 변수
var clasCode = "${CLASS_INFO.clasCode}";
var schulCode = "${CLASS_INFO.schulCode}";
var loginId = "${USER_INFO.mberId}";

var files = [];
var index = 0;

var oEditors = [];

// 이미지 드래그 앤 드롭
window.onload = function(){
	var fu = document.querySelector('.file-upload-div');
    var imgStr = "";
	
	/* 박스 안에 Drag를 하고 있을 때 */
	fu.addEventListener('dragover', function(e) {
        e.preventDefault();
    });
	
	/* 박스 안에서 Drag를 Drop했을 때 */
    fu.addEventListener('drop', function(e) {
        e.preventDefault();
        
        $("#imageDiv").removeAttr("style");
        
//         console.log(e.dataTransfer.files);
        
        // 드래그한 파일들을 files에 추가
	    for (var i = 0; i < e.dataTransfer.files.length; i++) {
	        files.push(e.dataTransfer.files[i]);
	        
	        var fileName = [];
	        fileName[i] = e.dataTransfer.files[i].name;
	        
	    	var imgTag = document.createElement('img');
	    	imgTag.setAttribute('id', 'images'+(index++));
	    	imgTag.setAttribute('class', 'images');
	    	imgTag.setAttribute('src', '/upload/시연용 폴더/'+fileName[i]);
	       
	    	var imageDiv = document.querySelector("#imageDiv");
	        imageDiv.appendChild(imgTag);
	    }
    });
}

$(function(){
	// 소켓 객체 생성
    var soc = new SockJS("/alram");

	$("#ntcnSj").on("focus");
	
	$("#uploadBtn").on("click", function(){
		$("#inputImage").trigger("click");
	});
	
	// 파일 이름 넣기
	$("#inputImage").on("input", function() {
		var inputImage = $("#inputImage")[0];
		
		console.log(inputImage.files);

		// 업로드한 파일 가져와서 넣기
		for (var i = 0; i < inputImage.files.length; i++) {
	        files.push(inputImage.files[i]);
	        
			// 이미지 태그 동적 생성
	    	var imgTag = document.createElement('img');
	    	imgTag.setAttribute('id', 'images' + (index++));
	    	imgTag.setAttribute('class', 'images');
	    	imgTag.setAttribute('src', '/upload/시연용 폴더/' + inputImage.files[i].name);
	       
	    	var imageDiv = document.querySelector("#imageDiv");
	        imageDiv.appendChild(imgTag);
		}
		
	});
	
	// 첨부한 사진 개별 삭제 이벤트
	$(document).on("click", ".images", function(){
		var imageId = $(this).attr("id"); // 클릭한 이미지의 id 가져오기
	    var idx = imageId.replace("images", ""); // images를 제거하여 인덱스 추출
		  
	    delete files[idx];
	    
	    $("#images"+idx).remove();
	    
	    console.log("파일 확인", files);
	    
	    var notUndefinedChk = 0;
	    
	    for (var i = 0; i < files.length; i++) {
			if(files[i] != undefined){
				notUndefinedChk++;
			}
		}
	    
	    if(notUndefinedChk == 0){
	    	$("#imageDiv").attr("style", "display: none;");
	    }
	});
      
	// 알림장 게시글 등록
	$("#insertBtn").click(function() {
        // 입력 정보들 가져오기
        var ntcnSj = $("#ntcnSj").val();
	    
        // 에디터에 적은 내용 가져오기
        var ntcnCn = oEditors.getById["se2Cn"].getIR();
        $("#ntcnCn").val(ntcnCn);
        
        // 업로드한 파일 가져오기
        // 개별 삭제 되어 empty처리 된 인덱스 필터 작업
		files = files.filter(function(item){
			return item !== undefined && item !== null;
		});
		
// 		console.log("필터 후 files", files);
		
        var formData = new FormData();
        formData.append("clasCode", clasCode);
        formData.append("ntcnSj", ntcnSj);
        formData.append("ntcnCn", ntcnCn);
         
        for (var i = 0; i < files.length; i++) {
        	formData.append("uploadFiles", files[i]);
        };
         
        $.ajax({
	        url: "/ntcn/ntcnInsert",
	        processData: false,
	        contentType: false,
	        type: "POST",
	        data: formData,
	        dataType: "text",
	        beforeSend:function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
	        },
           	success: function(res){
	            console.log("ntcnCode", res);
	            
	            var ntcnCode = res;
	            
	            ntcnSj = "[알림장] " + ntcnSj;
				var noticeCn = "새 글이 등록되었습니다.";
				
				var data = {
					"noticeSndId":loginId,
					"clasCode":clasCode,
					"ntcnCode":ntcnCode,
					"noticeSj":ntcnSj,
					"noticeCn":noticeCn
				};
				
				// 과제 게시글 등록 -> 알림 테이블 insert
		        $.ajax({
		        	url: "/ntcn/noticeInsertAll",
		        	contentType:"application/json;charset=utf-8",
		        	type: "post",
		        	data: JSON.stringify(data),
		        	dataType: "text",
		        	beforeSend:function(xhr){
						xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			        },
		           	success: function(res){
						// 소켓 객체 생성
			            var soc = new SockJS("/alram");
			            
			            var str = "";
			            str += "<div class='single-review-st-text'>";
			            str += "<input id='noticeCheckBox0' class='noticeCheckBox' type='checkbox'>";
			            str += "<img src='/resources/images/header/letter.png' alt='' style='margin-left: 12px; margin-top: 6px; width: 33px; height: 33px;'>";
			            str += "<div class='review-ctn-hf' style='margin-left: 11px;'>";
			            str += "<a id='readNotice' href='/ntcn/ntcnList?clasCode="+clasCode+"'>";
			            str += "<h3 style='font-size: 16px;'>"+ntcnSj+"</h3>";
			            str += "<p>"+noticeCn+"</p>";
			            str += "</a>";
			            str += "</div>";
		               
			            // 학생, 학부모 모두에게 보내기
						var msg = str+",toAll";
						
						soc.onopen = function() {
						   soc.send(msg);
						};
						
						Swal.fire({
			               title: '등록이 완료되었습니다.',
			               text: '',
			               icon: 'success',
			               confirmButtonText: '확인',
			            }).then(result => {
							if (result.isConfirmed) {
								location.href = "/ntcn/ntcnList?clasCode="+clasCode;
							}
			            });
		           	}
		        });
			}
		});
	});
	
    // 알림장 양식 불러오기
    $("#selectNtcn").on("change", function(){
		var selectVal = $(this).val();
		var ntcnData = "";
		
		if(selectVal == "fieldLearning"){
			ntcnData = "현장체험학습";
		}else if(selectVal == "summerVacation"){
			ntcnData = "여름방학";
		}else{
			return;
		}
		
		$.ajax({
			url:"/ntcn/getNtcnForm",
			data:{"nttNm":ntcnData},
			dataType:"text",
			type:"post",
			beforeSend:function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
	        },
           	success: function(ntcnForm){
           		oEditors.getById["se2Cn"].exec("SET_IR", [""]); // 네이버 에디터 초기화
           		oEditors.getById["se2Cn"].exec("PASTE_HTML", [ntcnForm]);
           	}
		})
    });
    
	// 자동 완성 버튼
	$("#autoBtn").on("click", function(){
		document.querySelector("#ntcnSj").value = "서대전초등학교 봄 현장체험학습 안내";
	});
});

// 네이버 스마트 에디터 API
$(function() {
	nhn.husky.EZCreator.createInIFrame({
      oAppRef : oEditors,
      elPlaceHolder : "se2Cn",
      //SmartEditor2Skin.html 파일이 존재하는 경로
      sSkinURI : '<c:url value="/resources/se2/SmartEditor2Skin.html"/>',
      htParams : {
         bUseToolbar : true,          // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
         bUseVerticalResizer : true,  // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
         bUseModeChanger : true,      // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
         bSkipXssFilter : true,       // client-side xss filter 무시 여부 (true:사용하지 않음 / 그외:사용)
         }, //boolean
      fCreator: "createSEditor2"
   });
});
</script>

<div id="NtcnContainer">
	<h3>
		<img src="/resources/images/classRoom/notice/noticeContent.png" style="width:50px; margin-bottom: 5px; display:inline-block; vertical-align:middel;">
			알림장
		<img src="/resources/images/classRoom/notice/star.png" style="width:40px; margin-bottom: 10px; display:inline-block; vertical-align:middel;">		
	</h3>
	<div class="NtcnAll" style="width: 1200px; margin: auto; margin-bottom:50px;">
		<div class="NtcnTit">
			<input type="text" name="ntcnSj" id="ntcnSj" placeholder="제목을 입력하세요" class="form-control input-sm" style="width:95%;border:none;background: none;height: 50px;font-size: 1.4rem;display: inline-block;vertical-align: middle; margin-bottom:6px;">
			<img src="/resources/images/classRoom/freeBrd/line.png" style="position: absolute;left: 0px;top: 14px;z-index: -1;">
		</div>
		<div>
			<input type="file" value="파일 첨부" name="uploadFile" id="inputImage" accept="image/*" multiple style="display: none;">
			<select id="selectNtcn">
				<option selected>글 양식을 선택하세요</option>
				<option value="fieldLearning">현장체험학습</option>
				<option value="summerVacation">여름방학</option>
				<option value="winterVacation">겨울방학</option>
				<option value="">개학식</option>
				<option value="">졸업식</option>
			</select>
		</div>
		<div class="ntcn-cont" style="margin-top: 25px;">
			​​​​​​​​<div id="smarteditor">
				<textarea name="se2Cn" id="se2Cn" style="width: 100%; height: 412px;"></textarea>
				<textarea name="taskCn" id="taskCn" style="width: 100%; height: 412px; display: none;"></textarea>
				<div id="imageDiv" style="display: none;">
<!-- 					<p>첨부된 파일이 없습니다.</p> -->
				</div>
				<div class="file-upload-div">
					<i class="fa fa-cloud-download" aria-hidden="true" style="color: #ccc; font-size: 50px;"></i>
					<p>
						드래그 혹은 클릭하여 파일을 업로드 해주세요.<br>이미지 파일(jpeg, png, gif)만 업로드 가능합니다.
					</p>
					<button id="uploadBtn" class="d-btn-black">파일 업로드</button>
				</div>
			</div>
		</div>
	<div class="btnContainer" style="">
		​​​​​​​​<input type="button" value="등록" id="insertBtn"/>
		​​​​​​​​<input type="button" value="취소" id="cancelBtn" onclick="location.href='/ntcn/ntcnList?clasCode=${CLASS_INFO.clasCode}'"/>
		​​​​​​​​<input type="button" value="자동 완성" id="autoBtn"/>
	</div>
	</div>
</div>
