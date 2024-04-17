<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
#TaskContainer h3{
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

.TaskBoardAll{
	width: 1200px;
	margin: auto;
	backdrop-filter: blur(10px);
	background-color: rgba(255, 255, 255, 1);
	border-radius: 50px;
	box-shadow: 0px 35px 68px 0px rgba(145, 192, 255, 0.5), inset 0px -6px 16px 0px rgba(145, 192, 255, 0.6), inset 0px 11px 28px 0px rgb(255, 255, 255);
	padding: 50px 80px;
}

.TaskBoardAll .TaskTit {
	display: flex;
	justify-content: space-between;
	position:relative;
}

.TaskBoardAll .title{
	font-size: 1.8rem;
	font-weight: 700;
	margin-top: 6px;
}

#updateBtn, #cancelBtn{
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

#updateBtn:hover, #cancelBtn:hover{
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
.btnContainer .btn {
    margin-right: 10px;
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
  background-color: #fff;
  height: 40px;
  margin-right: 10px;
  cursor: pointer;
  padding: 0px 15px 0px 7px;
  border-bottom: 1px solid #d7d7d7;
/*   border-radius: 5px; */
  
}
.file-button input {
  display: none;
}
.file-button label {
  cursor: pointer;
  font-size: 14px;
  margin-top: 2px;
}
.file-upload input[type="text"] {
  flex-grow: 1;
  padding: 8px;
  border-bottom: 1px solid #ced4da;
  border-left: none;
  border-right: none;
  border-top: none;
  width: calc(100% - 100px - 10px - 16px); /* Subtract button width and margins */
}
.input-file-button{
  background-color:#fff;
  border-radius: 4px;
/*   color: white; */
  cursor: pointer;
}

#taskEndDt{
  margin-left: 8px;
  border-bottom: 1px solid #ced4da;
  border-left: none;
  border-right: none;
  border-top: none;
}

.task-form{
  margin: 15px 5px 15px 0px;
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
</style>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script type="text/javascript" src="/resources/js/cjh.js"></script>
<!-- 네이버 스마트 에디터 JS -->
<script type="text/javascript" src="/resources/se2/js/HuskyEZCreator.js" charset="UTF-8"></script>
<script type="text/javascript">
var oEditors = [];
var clasCode = "${taskVO.clasCode}";
var taskCode = "${taskVO.taskCode}";
var taskEndDt = cjh.modelDateFormat("${taskVO.taskEndDt}");
var atchFileCode = "${taskVO.atchFileCode}";

// 네이버 스마트 에디터 API
$(function() {
	nhn.husky.EZCreator.createInIFrame({
		oAppRef : oEditors,
		elPlaceHolder : "se2Cn",
		//SmartEditor2Skin.html 파일이 존재하는 경로
		sSkinURI : '<c:url value="/resources/se2/SmartEditor2Skin.html"/>',
		htParams : {
			bUseToolbar : true, 		// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseVerticalResizer : true, // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseModeChanger : true, 	// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
			bSkipXssFilter : true, 		// client-side xss filter 무시 여부 (true:사용하지 않음 / 그외:사용)
			fCreator : "createSEditor2"
		}, //boolean
	});
});

$(function() {
// 	console.log("${taskVO}");

	/* 파일이 여러 개일 때 처리 시작*/
    var fileNameValue = '';

    <c:forEach var="atchFileVO" items="${taskVO.atchFileVOList}" varStatus="status">
	    fileNameValue += '${atchFileVO.atchFileNm}';
	    // 마지막 파일 이름엔 콤마 안 붙이기
	    <c:if test="${not status.last}">
	        fileNameValue += ',';
	    </c:if>
	</c:forEach>

    document.querySelector('#fileName').value = fileNameValue;
    /* 파일이 여러 개일 때 처리 끝*/
    
    // input 요소에 값을 설정
    document.getElementById("taskEndDt").value = taskEndDt;
    
	// 파일 이름 넣기
	$("#inputTask").on("input", function() {
		// 업로드한 파일 가져오기
		var files = $("#inputTask")[0].files;

		// 파일 이름들 가져오기
		var fileNames = [];
		for (var i = 0; i < files.length; i++) {
			fileNames.push(files[i].name);
		}

		$("#fileName").val(fileNames);
	});

	// 과제 게시글 수정
	$("#updateBtn").click(function() {
	    oEditors.getById["se2Cn"].exec("UPDATE_CONTENTS_FIELD", []);
	
	    // 입력 정보들 가져오기
	    var taskSj = $("#taskSj").val();
	    
        var newTaskEndDt = new Date($("#taskEndDt").val());
        newTaskEndDt.setHours(23);   // 시간을 23으로 설정
        newTaskEndDt.setMinutes(59); // 분을 59으로 설정
        newTaskEndDt = dateToMinFormat(newTaskEndDt).toString();
	    
	    // 에디터에 적은 내용 가져오기
	    var taskCn = oEditors.getById["se2Cn"].getIR();
	    $("#taskCn").val(taskCn);
	    console.log("taskCn: " + taskCn);
	
	    // 업로드한 파일 가져오기
	    var files = $("#inputTask")[0].files;
	    console.log("files", files);
	
	    var formData = new FormData();
	
	    // 마감일을 수정했을 때의 처리
	    if (newTaskEndDt != null && newTaskEndDt != "") {
	        formData.append("taskEndDt", newTaskEndDt);
	    };
	
	    // 마감일이 오늘 이전일 때의 처리
	    if (prevToday(newTaskEndDt) == false) {
	        Swal.fire('과제 수정 실패!', '과제 마감일은 오늘 이전의 날짜로 설정할 수 없습니다.', 'error');
	        return;
	    }
	
	    formData.append("taskCode", taskCode);
	    formData.append("clasCode", clasCode);
	    formData.append("taskSj", taskSj);
	    formData.append("taskCn", taskCn);
	    formData.append("taskEndDt", taskEndDt);
	    formData.append("atchFileCode", atchFileCode);
	
	    for (var i = 0; i < files.length; i++) {
	        formData.append("uploadFiles", files[i]);
	    };
	
	    console.log("formData: ", formData);
	
	    $.ajax({
	        url: "/task/taskUpdate",
	        processData: false,
	        contentType: false,
	        type: "POST",
	        data: formData,
	        dataType: "text",
	        beforeSend: function(xhr) {
	            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	        },
	        success: function(res) {
	            console.log("res: ", res);
	            
	            Swal.fire({
	               title: '등록이 완료되었습니다.',
	               text: '',
	               icon: 'success',
	               confirmButtonText: '확인',
	            }).then(result => {
					if (result.isConfirmed) {
			            location.href = "/task/taskDetail?taskCode=" + taskCode;
					}
	            });
	        }
	    });
	});
});
</script>
   
<div id="TaskContainer">
	<h3>
		<img src="/resources/images/classRoom/task/taskCheck.png" style="width:50px; display:inline-block; vertical-align:middel;">
			과제 게시판
		<img src="/resources/images/classRoom/task/pencil.png" style="width:50px; display:inline-block; vertical-align:middel;">      
	</h3>
	<div class="TaskBoardAll" style="width: 1200px; margin: auto; margin-bottom:50px;">
		<div class="TaskTit">
			<input type="text" id="taskSj" value="${taskVO.taskSj}" class="form-control input-sm" style="width:95%;border:none;background: none;height: 50px;font-size: 1.4rem;display: inline-block;vertical-align: middle; margin-bottom:6px;" placeholder="제목을 입력해주세요.">
			<img src="/resources/images/classRoom/freeBrd/line.png" style="position: absolute;left: 0px;top: 14px;z-index: -1;">
		</div>
		<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 task-form">
			<div class="row">
				<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
					<div class="file-upload">
						<div class="input prepend-big-btn">
							<span class="input-group-addon" style="font-weight: bold; border: 1px solid #ccc; border-radius: 5px; width: auto; height: 40px; color: #999; align-content: center; margin-right: 7px;">
								첨부 파일
							</span>
							<input type="text" id="fileName" value="" class="form-control">
							<div class="file-button" style="align-content: center;">
								<label class="input-file-button" for="inputTask" style="width: 85px;">
								<img src="/resources/images/classRoom/freeBrd/freeFile.png" style="width:30px; display:inline-block;">
									파일 선택
								</label>
								<input type="file" value="파일 첨부" id="inputTask" accept=".pdf" multiple>
								<input type="hidden" name="taskFile" id="taskFile" value="">
							</div>
						</div>
					</div>
				</div>
				<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
					<div class="input-group date">
						<span class="input-group-addon" style="font-weight: bold; border: 1px solid #ccc; border-radius: 5px; width: auto; color: #999;">
							과제 마감일
						</span>
						<input type="date" value="${taskVO.taskEndDt}" id="taskEndDt" class="form-control" style='width: 400px'>
					</div>
				</div>
			</div>
		</div>
		<div class="task-cont">
			​​​​​​​​<div id="smarteditor">
				<textarea name="se2Cn" id="se2Cn" style="width: 100%; height: 412px;">${taskVO.taskCn}</textarea>
				<textarea name="taskCn" id="taskCn" style="width: 100%; height: 412px; display: none;"></textarea>
			</div>
		</div>
		<div class="btnContainer" style="">
			​​​​​​​​<input type="button" value="수정" id="updateBtn"/>
			​​​​​​​​<input type="button" value="취소" id="cancelBtn" onclick="location.href='/task/taskList?clasCode=${CLASS_INFO.clasCode}'"/>
		</div>
	</div>
</div>