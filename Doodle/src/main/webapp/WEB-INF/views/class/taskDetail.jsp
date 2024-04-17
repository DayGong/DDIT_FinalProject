<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<style>
p{
	margin: 0px;
}

#file-upload-button{
	border: none;
}
/* 과제 제출 현황 시작*/
.inputTaskDetailTitle{
	display: flex;
	justify-content: center;
}
.inputTaskDetailTitle h3{
	background: linear-gradient(to top, #7cb8ff 20%, transparent 20%);
    width: 160px;
}

.inputTaskList::-webkit-scrollbar {
	width: 5px;
}
.inputTaskList::-webkit-scrollbar-thumb {
	background-color: #e6e6e6;
	border-radius: 5px;
}
.inputTaskList::-webkit-scrollbar-track {
	border-radius: 5px;
	background-color: #f5f5f5;
}
.product-status-wrap table th{
	padding: 10px 5px;
	border-top: none;
}

.product-status-wrap.drp-lst table td{
   padding: 10px 7px;
}

.product-status-wrap .pd-setting {
   padding: 5px 0px 5px 0px;
}

.pd-setting{
   display: inline-block;
   width: 65px;
   text-align: center;
}
/* 과제 제출 현황 끝*/

/* 칭찬 스티커 */
#complimentStickerIcon{
	width: 70px;
	height: 70px;
	position: absolute;
	opacity: 85%;
	left: 6px;
	top: 5px;
}

/* 게시판 */
#TaskContainer h3 {
   font-size: 2.2rem;
   text-align: center;
   margin-top: 60px;
   backdrop-filter: blur(4px);
   background-color: rgba(255, 255, 255, 1);
   border-radius: 50px;
   box-shadow: 35px 35px 68px 0px rgba(145, 192, 255, 0.5), inset -8px -8px 15px 0px rgba(145, 192, 255, 0.6), inset 0px 11px 28px 0px rgb(255, 255, 255);
   width: 370px;
   padding-top: 35px;
   padding-bottom: 35px;
   margin: auto;
   margin-top: 15px;
   margin-bottom: 40px;
}

.inputTaskAll {
   width: 1200px;
   margin: auto;
   backdrop-filter: blur(10px);
   background-color: rgba(255, 255, 255, 1);
   border-radius: 15px;
   padding: 40px 60px;
   border: 1px solid #ddd;
}

.TaskAll {
   width: 1200px;
   margin: auto;
   backdrop-filter: blur(10px);
   background-color: rgba(255, 255, 255, 1);
   border-radius: 50px;
   box-shadow: 0px 35px 68px 0px rgba(145, 192, 255, 0.5), inset 0px -6px
      15px 0px rgba(145, 192, 255, 0.6), inset 0px 11px 28px 0px
      rgb(255, 255, 255);
   padding: 50px 80px;
}

.TaskAll .task-cont {
   border: 1px solid #ddd;
   border-radius: 10px;
   padding: 10px 20px;
   min-height: 83px;
   margin-top: 50px;
}

.TaskAll .TaskTitle {
   display: flex;
   justify-content: space-between;
   position: relative;
}

.TaskAll .title {
   font-size: 1.8rem;
   font-weight: 700;
   margin-top: 6px;
}

.inputTaskContainer{
   text-align: center;
   width: 100%;
   border: none;
   background: none;
   height: 50px;
   font-size: 1.4rem;
   font-weight: bold;
   display: inline-block;
   vertical-align: middle;
   margin-bottom: 6px;
}

.inputTaskDetailContainer{
   font-size: 15px;
   margin-top: 20px;
   display: flex;
   justify-content: flex-end;
   padding-right: 10px;
}

#goToTaskList, #taskSubmitBtn, #inputTaskBtn, #deleteBtn, #updateBtn{
   display: inline-block;
   text-align: center;
   background: #006DF0;
   padding: 15px 30px;
   font-size: 15px;
   border: none;
   color: #fff;
   font-weight: 700;
   border-radius: 5px;
   margin-top: 30px;
   margin-bottom: 40px;
   margin-right: 15px;
}

#inputTaskBtn{
   padding: 15px 15px;
}

#deleteBtn {
   background: #111;
   color: #fff;
}

#updateBtn {
   background: #666;
   color: #fff;
}

#goToTaskList:hover, #updateBtn:hover, deleteBtn:hover {
   background: #ffd77a;
   transition: all 1s ease;
   color: #333;
}

.uploadList {
   background: rgb(178 202 255/ 25%);
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
   margin-bottom: 5px;
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

.taskInfo {
   margin-top: 10px;
   font-size: 1rem;
}

#feedbackContent {
   background: rgb(255 204 051/ 15%);
   width: 100%;
   padding: 20px;
   border-radius: 10px;
}

#feedbackIcon {
   width: 25px;
   height: 30px;
   margin-bottom: 3px;
}

#taskIcon{
	    width: 23px;
    height: 24px;
    margin-top: 0px;
    margin-right: 5px;
}

/* 피드백 등록, 피드백 수정, 피드백 삭제, 과제 제출, 과제 제출 현황 버튼 */
#inputFeedbackBtn, #showUpdateFdbckModalBtn, #deleteFeedbackBtn, #myTaskDeleteBtn, #inputTaskDetailBtn{
   border: none;
   color: white;
   background: black;
   padding: 4.5px 6px;
   border-radius: 5px;
   font-size: 14px;
   float: right;
   margin-left: 5px;
}

/* 참 잘했어요! 버튼 */
#complimentStickerBtn{
   border: 1px solid #777;
   color: #666;
   background: #fff;
   font-weight: bold;
   padding: 2px 6px;
   border-radius: 5px;
   font-size: 14px;
   float: right;
   margin-left: 5px;
}

#inputFeedbackBtn{
   background: #006DF0;
}

#myTaskDeleteBtn{
   background: #666;
}

#showUpdateFdbckModalBtn{
   background: #666;
}

#inputTaskDetailBtn{
   background: #fff;
   color: #666;
   border: 1px solid #b5b5b5;
   margin-left: 5px;
   padding: 3px 6px;
   margin-top: 1px;
}

#noTaskList{
   border: 1px solid lightgray;
   border-radius: 10px;
   padding: 40px;
   text-align: center;
   color: #999;
   margin-top: 50px;
}

/* 피드백 모달 */
.feedbackTitle{
	display: flex;
	justify-content: center;
}

.feedbackTitle h3{
	background: linear-gradient(to top, #7cb8ff 20%, transparent 20%);
    width: 140px;
}

</style>
<link rel="stylesheet" href="/resources/css/sweetalert2.min.css">
<script src="/resources/css/sweetalert2.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script type="text/javascript" src="/resources/js/cjh.js"></script>
<script type="text/javascript" src="/resources/js/commonFunction.js"></script>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script type="text/javascript">
// 전역 변수
var taskCode = "${taskVO.taskCode}";
var taskSj = "${taskVO.taskSj}";
var clasCode = "${taskVO.clasCode}";
var atchFileCode = "${taskVO.atchFileCode}";
var schulCode = "${taskVO.hrtchrVO.schulCode}";
var childList = "${childList}";
var inputTaskCount = "${inputTaskCount}";
var taskEndDt = cjh.modelDateFormat("${taskVO.taskEndDt}");

window.onload = function() {
	// 수정 버튼을 클릭했을 때 발생하는 이벤트
	document.querySelector("#updateBtn").addEventListener("click", () => {
	   location.href = "/task/taskUpdateForm?taskCode="+taskCode+"&clasCode="+clasCode;
	});
};

$(function(){
	// 소켓 객체 생성
	var soc = new SockJS("/alram");
	
	var data = {
	   "taskCode":taskCode,
	   "clasCode":clasCode,
	   "mberId":"${USER_INFO.mberId}"
	};
   
	// 제출된 과제 리스트 출력
	$.ajax({
	    url: "/task/inputTaskList",
	    contentType: "application/json;charset=utf-8",
	    data: JSON.stringify(data),
	    type: "post",
	    dataType: "json",
	    beforeSend: function (xhr) {
	        xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	    },
	    success: function (res) {
	        console.log("clasStdntVOList", res);
	        var auth = "${USER_INFO.vwMemberAuthVOList[0].cmmnDetailCode}";
	        var str = "";
         
	        // 제출된 과제가 없는 경우
	        if(inputTaskCount == 0){
		        // 학생이 아닌 경우
		        if(auth != "ROLE_A01001"){
		           str += "<div id='noTaskList'>제출된 과제가 없습니다.</div>";
		           $("#inputTaskContainer").html(str);
		        // 학생인 경우
		        }else{
		           $(".stdntTaskAll").attr("style", "height: 405px; margin-bottom:50px;");
		        }
	        }else{
	            // 학생 권한(본인이 등록한 과제만 출력)
	            if(auth == "ROLE_A01001") {
	                var item = res[0];
	                
	                // 이미 제출한 과제가 있는 경우 파일 첨부란 안 보이게 하기
	                if(item.taskVO.taskResultVO.taskResultCode != null){
						$("#inputTaskDiv").attr("style", "display: none;");
	                }else{
	                	$(".stdntTaskAll").attr("style", "height: 405px; margin-bottom:50px;");
	                }
	                
	                str += "<div class='inputTaskAll' style='width: auto; margin: auto; margin-bottom:50px; margin-top: 40px; padding: 40px 65px;'>";
					
	                // 칭찬 스티커가 있는 경우 칭찬 스티커 출력
	                if(item.taskVO.taskResultVO.complimentSticker == 1){
		                str += "<img id='complimentStickerIcon' src='/resources/images/classRoom/task/sticker.png' style='width: 55px; height: 55px;'>";
	                }

	                // 마감일이 지나지 않은 경우 과제 삭제 버튼 활성화
					var curDate = new Date(); // 지금 날짜
	                if(taskEndDt > dateFormat(curDate)){
		                str += "<input type='button' id='myTaskDeleteBtn' value='삭제'>";
	                }
	                
	                str += "<p style='font-size:15px;'><a href='/task/pdfView?atchFileCode=" + item.taskVO.atchFileCode + "&atchFileSn=" + item.taskVO.atchFileVOList[0].atchFileSn + "'>" + item.taskVO.atchFileVOList[0].atchFileNm + "</a></p>";
	                str += "<p>" + item.mberNm + "</p>";
	                str += "<p>" + dateToMinFormat(item.taskVO.taskResultVO.taskPresentnDate) + "</p>";
	                str += "<input type='hidden' class='taskResultCode' value='" + item.taskVO.taskResultVO.taskResultCode + "'>";
	                str += "<input type='hidden' class='stdntId' value='" + item.mberId + "'>";
	                str += "<input type='hidden' id='stdntNm' value='" + item.mberNm + "'>";
	                str += "<input type='hidden' id='fdbck' value='" + item.taskVO.taskResultVO.fdbck + "'>";
	
	    
	                // 등록된 피드백이 있으면 피드백 출력
	                if(item.taskVO.taskResultVO.fdbck != null) {
	                    str += "<hr>";
	                    str += "<p><img src='/resources/images/classRoom/task/great.png' id='feedbackIcon' style='margin-right: 5px;'>담임 선생님의 피드백";
	                    str += "<img src='/resources/images/classRoom/task/great.png' id='feedbackIcon' style='margin-left: 5px;'></p>";
	                    str += "<div id='feedbackContent'>" + item.taskVO.taskResultVO.fdbck + "</div>";
	                }
	                
	             	str += "</div>";
	             
				// 교사 권한(모든 과제 모두 출력)
				}else if(auth == "ROLE_A14002") {
					var taskStr = "";
					var index = 1;
					
					// 과제 제출 현황
					str += "<div class='inputTaskDetailContainer'>";
					str += "<img id='taskIcon' src='/resources/images/classRoom/task/classStudent.png'>";
					str += "<p style='margin: 0px; align-content: center;'>과제 제출 현황: " + inputTaskCount + " / " + res.length + "(명)</p>";
					str += "<input type='button' id='inputTaskDetailBtn' value='상세 보기'>";
					str += "</div>";
		             
		            taskStr += "<tr>";
		            taskStr += "<th>반 번호</th>";
		            taskStr += "<th>학생 명</th>";
		            taskStr += "<th style='width: 30%;'>제출 상태</th>";
		            taskStr += "</tr>";
		             
					$.each(res, function (idx, item) {
		            	var taskVO = item.taskVO;
		                
		                // 과제 제출 현황
		                taskStr += "<tr>";
		                taskStr += "<td>" + item.clasInNo + "</td>";
		                taskStr += "<td>" + item.mberNm + "</td>";
		                taskStr += "<td>";
		                
		                // 제출/미제출 표기
		                if (taskVO.taskResultVO.taskResultCode == null) {
		                    taskStr += "<span class='pd-setting' style='background: #666;'>미제출</span>";
		                }else {
		                    taskStr += "<span class='pd-setting'>제출</span>";
		                }
		                
		                taskStr += "</td>";
		                taskStr += "</span></td>";
		                taskStr += "</tr>";
		                
		                $("#inputTaskDetailTbody").html(taskStr);
                
						// 제출된 과제 리스트
						if (taskVO && taskVO.atchFileVOList && taskVO.atchFileVOList.length > 0) {
							str += "<div class='inputTaskAll' style='width: auto; margin: auto; margin-bottom:50px; margin-top: 40px; padding: 40px 65px;'>";
							
							// 칭찬 스티커가 있는 경우 칭찬 스티커 출력
			                if(taskVO.taskResultVO.complimentSticker == 1){
				                str += "<img id='complimentStickerIcon' src='/resources/images/classRoom/task/sticker.png' style='width: 55px; height: 55px;'>";
			                }
							
							str += "<p style='font-size: 15px;'>" + (index++) + ". ";
		                    str += "<a href='/task/pdfView?atchFileCode=" + taskVO.atchFileCode + "&atchFileSn=" + taskVO.atchFileVOList[0].atchFileSn + "'>" + taskVO.atchFileVOList[0].atchFileNm + " </a></p>";
		                    str += "<p style='color: #999;'>" + item.mberNm + " | ";
		                    str += dateToMinFormat(taskVO.taskResultVO.taskPresentnDate);
		                    str += "<input type='hidden' class='taskResultCode' value='" + taskVO.taskResultVO.taskResultCode + "'>";
		                    str += "<input type='hidden' class='mberId' value='" + item.mberId + "'>";
		                    str += "<input type='hidden' id='stdntNm' value='" + item.mberNm + "'>";
		                    str += "<input type='hidden' id='fdbck' value='" + taskVO.taskResultVO.fdbck + "'>";
			                
		                    // 칭찬 스티커 주기 버튼 활성화
			                if(taskVO.taskResultVO.complimentSticker == 0){
				                str += "<button id='complimentStickerBtn'><img src='/resources/images/classRoom/task/sticker.png' style='width: 18px; height: 18px; margin-bottom: 2px; margin-right: 3px;'>칭찬 스티커 주기</button>";
			                }
		                    
			                // 본인이 등록한 피드백 출력
			                if (taskVO.taskResultVO.fdbck == null) {
		                    	str += "<input type='button' id='inputFeedbackBtn' value='피드백 등록'></p>";
							}else{
								str += "";
								str += "<hr>";
								str += "<input type='button' id='showUpdateFdbckModalBtn' value='피드백 수정'>";
								str += "<input type='button' id='deleteFeedbackBtn' value='피드백 삭제'>";
								str += "<p style='margin-bottom: 7px; font-size: 15px;'>";
								str += "<img src='/resources/images/classRoom/task/great.png' id='feedbackIcon' style='margin-right: 5px;'>담임 선생님의 피드백";
								str += "<img src='/resources/images/classRoom/task/great.png' id='feedbackIcon' style='margin-left: 5px;'></p>";
								str += "<div id='feedbackContent'>" + taskVO.taskResultVO.fdbck + "</div>";
							}
						}
				
                		str += "</div>";
					});
				// 학부모 권한(자녀 과제만 출력)
				}else{
					$.each(res, function (idx, item) {
						var taskVO = item.taskVO;
	                
						// 자녀가 제출한 과제가 있으면 출력
		                if (taskVO && taskVO.atchFileVOList && taskVO.atchFileVOList.length > 0) {
		                 	str += "<div class='inputTaskAll' style='width: auto; margin: auto; margin-bottom:50px; margin-top: 40px; padding: 40px 65px;'>";
							
		                 	// 칭찬 스티커가 있는 경우 칭찬 스티커 출력
			                if(taskVO.taskResultVO.complimentSticker == 1){
				                str += "<img id='complimentStickerIcon' src='/resources/images/classRoom/task/sticker.png' style='width: 55px; height: 55px;'>";
			                }

							str += (idx + 1) + ". ";
		                    str += "<a href='/task/pdfView?atchFileCode=" + taskVO.atchFileCode + "&atchFileSn=" + taskVO.atchFileVOList[0].atchFileSn + "'>" + taskVO.atchFileVOList[0].atchFileNm + " </a>";
		                    str += item.mberNm + " ";
		                    str += dateToMinFormat(taskVO.taskResultVO.taskPresentnDate) + " ";
		                    str += "<input type='hidden' class='taskResultCode' value='" + taskVO.taskResultVO.taskResultCode + "'>";
		                    str += "<input type='hidden' class='mberId' value='" + item.mberId + "'>";
		                    str += "<input type='hidden' id='stdntNm' value='" + item.mberNm + "'>";
		                    str += "<input type='hidden' id='fdbck' value='" + taskVO.taskResultVO.fdbck + "'>";
							
		                    
							// 등록된 피드백이 있으면 피드백 출력
							if (taskVO.taskResultVO.fdbck != null) {
		                        str += "<hr>";
		                        str += "<p style='margin-bottom: 7px; font-size: 15px;'>";
		                        str += "<img src='/resources/images/classRoom/task/great.png' id='feedbackIcon' style='margin-right: 5px;'>담임 선생님의 피드백";
		                        str += "<img src='/resources/images/classRoom/task/great.png' id='feedbackIcon' style='margin-left: 5px;'></p>";
		                        str += "<div id='feedbackContent'>" + taskVO.taskResultVO.fdbck + "</div>";
							}
	                	}
	                    
                		str += "</div>";
					}); // end each
				} // end if 학생/학부모/선생님 권한
			} // end if 제출된 과제
         
			$("#inputTaskContainer").html(str);
		} // end success
	}); // end ajax

	/* 학생 권한 시작 */
	// 과제 제출하기
	$("#taskSubmitBtn").on("click", function(){
	    var stdntId = $('.stdntId').val();
	    var mberId = "${USER_INFO.mberId}";
      
	    // 업로드한 파일 가져오기
	    var file = $("#inputTask")[0].files[0];
	    
	    var formData = new FormData();
	    
	    formData.append("taskCode", taskCode);
	    formData.append("uploadFile", file);
	
	    // 과제 마감일이 지난 경우 return
	    if(prevToday(dateFormat(taskEndDt)) == false){
	       Swal.fire('과제 제출 실패!', '이미 마감일이 지난 과제입니다.', 'error');
	       return;
		}
       
		// 과제를 업로드하지 않은  경우 alert
		if(file == null){
	       Swal.fire('과제 제출 실패!', '파일을 업로드해 주세요.', 'error');
	       return;
		}
      
		// 과제 insert
		$.ajax({
		    url: "/task/inputTask",
		    processData: false,
		    contentType: false,
		    data: formData,
		    dataType: "json",
		    type: "post",
		    beforeSend: function(xhr) {
		        xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		    },
		    success: function(res) {
		        Swal.fire({
		            title: '과제 제출 완료!',
		            text: '',
		            icon: 'success',
		            confirmButtonText: '확인',
		        }).then(result => {
		            if (result.isConfirmed) {
		                location.href = "/task/taskDetail?taskCode=" + taskCode + "&clasCode=" + clasCode;
		            }
		        });
		    }
		});
	});
   
    // 파일 선택 버튼을 클릭했을 때 inputTask 버튼을 클릭한 것과 같은 동작을 수행하도록 설정
    $("#inputTaskBtn").on("click", function(){
	    $("#inputTask").trigger("click");
    })
    
	// 제출한 과제 삭제
	$(document).on("click", "#myTaskDeleteBtn", function(){
	    var taskResultCode = $(this).closest('.inputTaskAll').find('.taskResultCode').val();
	    console.log("taskResultCode: " + taskResultCode);
       
		Swal.fire({
           title: '제출한 과제를 삭제하시겠습니까?',
           text: '',
           icon: 'warning',
           showCancelButton: true,         // cancel 버튼 보이기
           confirmButtonText: '삭제',       // confirm 버튼 텍스트 지정
           cancelButtonText: '취소',        // cancel 버튼 텍스트 지정
		}).then(result => {
			if(result.isConfirmed){
	            var data = {
	               "taskResultCode":taskResultCode
	            };
               
	            $.ajax({
		            url: "/task/myTaskDelete",
		            contentType: "application/json;charset=utf-8",
		            data: JSON.stringify(data),
		            type: "post",
		            dataType: "json",
		            beforeSend:function(xhr){
		            	xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		            },
		            success: function(res){
		            	location.href = "/task/taskDetail?taskCode="+taskCode+"&clasCode="+clasCode;
		            }
				});
			};
		});
	});
	/* 학생 권한 끝 */
    
	/* 선생님 권한 시작 */
	// 피드백 등록 모달 띄우기
	$(document).on("click", "#inputFeedbackBtn", function(){
		var taskResultCode = $(this).closest('.inputTaskAll').find('.taskResultCode').val();
		var stdntId = $(this).closest('.inputTaskAll').find('.mberId').val();
		var stdntNm = $(this).closest('.inputTaskAll').find('#stdntNm').val();
		var fdbck = $(this).closest('.inputTaskAll').find('#fdbck').val();
	   
	    $("#feedbackInsertModal").modal("show");
	    
	    $(".stdntNm").html(stdntNm + " 학생에게 피드백하기");
	   
		// 기존 데이터에 피드백이 있으면 textarea에 출력 
	    if(fdbck == "null" || fdbck == null){
			$("#fdbckArea").val("");
	    }else{
			$("#fdbckArea").val(fdbck);
	    }
	
		// 모달 창이 열릴 때 textarea에 포커스 주는 이벤트
		$("#feedbackInsertModal").on("shown.bs.modal", function(){
		    $("#fdbckArea").focus();
		});
		 
		// 피드백 insert 버튼에 속성 추가
		$("#feedbackInsertBtn").attr("data-taskResultCode", taskResultCode);
		$("#feedbackInsertBtn").attr("data-stdntId", stdntId);
	});
   
	// 피드백 insert + 알림 테이블 insert
	$(document).on("click", "#feedbackInsertBtn", function(){
	    var fdbck = $("#fdbckArea").val();
	    var taskResultCode = $(this).attr("data-taskResultCode");
	    var stdntId = $(this).attr("data-stdntId");
	
	    taskSj = "[과제] " + taskSj;
	
	    var data = {
	       "taskCode": taskCode,
	       "noticeSj": taskSj,
	       "taskResultCode": taskResultCode,
	       "fdbck": fdbck,
	       "schulCode": schulCode,
	       "noticeRcvId": stdntId
	    };

       // 아무 내용도 입력하지 않을 경우
       if (fdbck == null || fdbck == "") {
          Swal.fire('피드백 등록 실패!', '내용을 입력하지 않았습니다.', 'error');
          return;
       }

		$.ajax({
			url: "/task/feedbackInsert",
			contentType: "application/json;charset=utf-8",
			type: "post",
			data: JSON.stringify(data),
			dataType: "json",
			beforeSend: function(xhr) {
				xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
			success: function(res) {
				console.log("noticeVO", res);
	            Swal.fire({
	               title: '피드백이 등록되었습니다.',
	               text: '',
	               icon: 'success',
	               confirmButtonText: '확인',       // confirm 버튼 텍스트 지정
	            }).then(result => {
					if (result.isConfirmed) {
	                    var noticeSj = res.noticeSj;
	                    var noticeCn = res.noticeCn;
	                    var noticeTrnsmitDt = res.noticeTrnsmitDt;
	
	                    // 소켓 객체 생성
	                    var soc = new SockJS("/alram");
	
	                    var str = "";
	                    str += "<div class='single-review-st-text'>";
	                    str += "<input id='noticeCheckBox0' class='noticeCheckBox' type='checkbox'>";
	                    str += "<img src='/resources/images/header/letter.png' alt='' style='margin-left: 12px; margin-top: 6px; width: 33px; height: 33px;'>";
	                    str += "<div class='review-ctn-hf' style='margin-left: 13px;'>";
	                    str += "<a id='readNotice' href='/task/taskDetail?taskCode=" + taskCode + "&clasCode=" + clasCode + "'>";
	                    str += "<h3 style='font-size: 15px;'>" + taskSj + "</h3>";
	                    str += "<p>" + noticeCn + "</p>";
	                    str += "</a>";
	                    str += "</div>";
	
	                    var msg = str + "," + stdntId + ",toStdnt";

	                    soc.onopen = function() {
	                        soc.send(msg);
	                    };

						location.href = "/task/taskDetail?taskCode=" + taskCode + "&clasCode=" + clasCode;
					}
				});
			}
		});
	});
   
	// 피드백 수정 모달 띄우기
	$(document).on("click", "#showUpdateFdbckModalBtn", function(){
		var taskResultCode = $(this).closest('.inputTaskAll').find('.taskResultCode').val();
		var stdntId = $(this).closest('.inputTaskAll').find('.mberId').val();
		var fdbck = $(this).closest('.inputTaskAll').find('#fdbck').val();
		var stdntNm = $(this).closest('.inputTaskAll').find('#stdntNm').val();
   
		$("#feedbackUpdateModal").modal("show");
		
		$(".stdntNm").html(stdntNm + " 학생에게 피드백하기");
		
		// 모달 창이 열릴 때 textarea에 포커스 주는 이벤트
		$("#feedbackUpdateModal").on("shown.bs.modal", function(){
		    $("#updateFdbckArea").focus();
		});

		// 기존 데이터에 피드백이 있으면 textarea에 출력 
		if(fdbck == "null" || fdbck == null){
		   $("#updateFdbckArea").val("");
		}else{
		   $("#updateFdbckArea").val(fdbck);
		}
  
		$("#feedbackUpdateBtn").attr("data-taskResultCode", taskResultCode);
		$("#feedbackUpdateBtn").attr("data-stdntId", stdntId);
	});
   
	// 피드백 수정
    $(document).on("click", "#feedbackUpdateBtn", function(){
	    var fdbck = $("#updateFdbckArea").val();
	    var taskResultCode = $(this).attr("data-taskResultCode");
	
	    var data = {
			"taskCode":taskCode,
	        "taskResultCode":taskResultCode,
	        "fdbck":fdbck,
	    };

		// 아무 내용도 입력하지 않을 경우
		if(fdbck == null || fdbck == ""){
		   Swal.fire('피드백 수정 실패!', '내용을 입력하지 않았습니다.', 'error');
		   return;
		}
      
		$.ajax({
		    url: "/task/feedbackUpdate",
		    contentType: "application/json;charset=utf-8",
		    type: "post",
		    data: JSON.stringify(data),
		    dataType: "json",
		    beforeSend:function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		    },
		    success: function(res){
		    	Swal.fire({
	               title: '피드백이 수정되었습니다.',
	               text: '',
	               icon: 'success',
	               confirmButtonText: '확인',       // confirm 버튼 텍스트 지정
	            }).then(result => {
					if (result.isConfirmed) {
						location.href = "/task/taskDetail?taskCode="+taskCode+"&clasCode="+clasCode;
					}
	            })
		    }
		});
	});
      
	// 피드백 삭제
	$(document).on("click", "#deleteFeedbackBtn", function(){
	    var taskResultCode = $(this).closest('.inputTaskAll').find('.taskResultCode').val();
	    var stdntId = $(this).closest('.inputTaskAll').find('.mberId').val();
	    var fdbck = "";

	    var data = {
	        "taskCode":taskCode,
	        "taskResultCode":taskResultCode,
	        "fdbck":fdbck,
	        "noticeRcvId":stdntId
	    };

		Swal.fire({
	        title: '피드백을 삭제하시겠습니까?',
	        text: '',
	        icon: 'warning',
	        showCancelButton: true,			// cancel 버튼 보이기
	        confirmButtonText: '삭제',		// confirm 버튼 텍스트 지정
	        cancelButtonText: '취소',			// cancel 버튼 텍스트 지정
		}).then(result => {
			if(result.isConfirmed){
				$.ajax({
	                url: "/task/feedbackDelete",
	                contentType: "application/json;charset=utf-8",
	                type: "post",
	                data: JSON.stringify(data),
	                dataType: "json",
	                beforeSend:function(xhr){
						xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
	                },
					success: function(res){
						location.href = "/task/taskDetail?taskCode="+taskCode+"&clasCode="+clasCode;
	                }
				});
			};
		});
	});
   
	// 게시글 삭제
	$("#deleteBtn").on("click", function(){
		var data = {
	        "taskCode":taskCode,
	        "atchFileCode":atchFileCode
		};
		
		Swal.fire({
	        title: '등록한 과제를 삭제하시겠습니까?',
	        text: '',
	        icon: 'warning',
	        
	        showCancelButton: true,         // cancel 버튼 보이기
	        confirmButtonText: '삭제',       // confirm 버튼 텍스트 지정
	        cancelButtonText: '취소',        // cancel 버튼 텍스트 지정
		}).then(result => {
			if(result.isConfirmed){
				$.ajax({
					url:"/task/taskDelete",
					contentType:"application/json;charset=utf-8",
					data:JSON.stringify(data),
					type:"post",
					dataType:"json",
					beforeSend:function(xhr){
					      xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
					},
					success: function(res){
				         location.href = "/task/taskList?clasCode="+clasCode;
					}
				});
			}
		});
	});
   
	// 과제 제출 현황 상세 보기
	$(document).on("click", "#inputTaskDetailBtn", function(){
		$("#inputTaskDetailModal").modal("show");
	});
   
	// 칭찬 스티커 주기
	$(document).on("click", "#complimentStickerBtn", function(){
		var taskResultCode = $(this).closest('.inputTaskAll').find('.taskResultCode').val();
		var stdntNm = $(this).closest('.inputTaskAll').find('#stdntNm').val();
		var title = stdntNm + ' 학생에게 칭찬 스티커를 주시겠습니까?';
		
		Swal.fire({
           title: title,
           text: '',
           icon: 'info',
           showCancelButton: true,         // cancel 버튼 보이기
           confirmButtonText: '확인',       // confirm 버튼 텍스트 지정
           cancelButtonText: '취소',        // cancel 버튼 텍스트 지정
		}).then(result => {
			if(result.isConfirmed){
	            $.ajax({
		            url: "/task/complimentStickerUpdate",
		            data: {taskResultCode:taskResultCode},
		            type: "post",
		            dataType: "text",
		            beforeSend:function(xhr){
		            	xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		            },
		            success: function(res){
		            	location.href = "/task/taskDetail?taskCode="+taskCode+"&clasCode="+clasCode;
		            }
				});
			};
		});
	});
   /* 선생님 권한 끝 */
   
   // 자동 완성 이벤트
   $("#autoBtn").on("click", function(){
	   $("#fdbckArea").val("정말 잘했어요!");
   });
});
</script>
<div id="TaskContainer">
   <h3>
      <img src="/resources/images/classRoom/task/taskCheck.png" style="width:50px; display:inline-block; vertical-align:middel;">
      	과제 게시판
      <img src="/resources/images/classRoom/task/pencil.png" style="width:50px; display:inline-block; vertical-align:middel;">      
   </h3>
      <div class="TaskAll" style="margin: auto; margin-bottom:50px; min-height:530px;">
         <div class="TaskTitle">
            <input type="text" class="form-control input-sm" style="width:95%;border:none;background: none;height: 50px;font-size: 1.4rem;display: inline-block;vertical-align: middle; margin-bottom:6px;" 
            name="taskSj" id="taskSj" value="${taskVO.taskSj}" readonly>
            <img src="/resources/images/classRoom/freeBrd/line.png" style="position: absolute;left: 0px;top: 14px;z-index: -1;">
         </div>
         <div class="taskInfo">
           <span style="font-size: 14px; margin-left: 12px;">
            <img src="/resources/images/classRoom/freeBrd/freeDateIcon.png" alt="게시글 등록일자 아이콘" style="width: 12px;margin-top: 4px;vertical-align: top;display: inline-block;"/>
               <small style="font-weight: 600;color: #222;font-size: 13px;">등록일: </small>
            <span style="color:#666; font-size: 13px;">
               <fmt:formatDate value="${taskVO.taskBeginDt}" pattern="yyyy-MM-dd" /> &nbsp;|&nbsp;
            </span>
         </span>
           <span style="font-size: 14px;">
               <small style="font-weight: 600;color: #222;font-size: 13px;">마감일: </small>
            <span style="color:#666; font-size: 13px;">
               <fmt:formatDate value="${taskVO.taskEndDt}" pattern="yyyy-MM-dd" />
            </span>
         </span>
         <span style="margin-right: 8px; font-size: 13px; float: right;">
            <img src="/resources/images/classRoom/freeBrd/freePersonIcon.png" alt="게시글 작성자 아이디 아이콘" style="width: 12px;margin-top: 5px;vertical-align: top;display: inline-block;"/>
               <small style="font-weight: 600;color: #222;font-size: 13px; line-height: 1.75;">작성자 : </small>
            <span style="color:#666; font-size: 13px;">${taskVO.hrtchrVO.memberVO.mberNm}</span>
         </span>
         </div>
         <div class="mb-3" style="display:flex;margin-top:20px;">
            <img src="/resources/images/classRoom/freeBrd/freeFile.png" style="width:40px; display:inline-block;">
            <span style="font-size:1.05rem; display: inline-block; vertical-align: middle;line-height: 2.5;">첨부파일</span> 
            <c:if test="${fn:length(atchFileVOList) > 0}">
            </c:if>
         </div>
         <div class="uploadList">
            <ul>
               <c:choose>
                  <c:when test="${fn:length(atchFileList) > 0}">
                     <c:forEach var="atchFileVO" items="${atchFileList}" varStatus="status">
                           <li class="fileList" data-atch-file-code ="${atchVO.atchFileCode}" 
                           data-atch-file-sn="${atchFileVO.atchFileSn}" data-atch-file-nm="${atchFileVO.atchFileNm}">
                              <img alt="${atchFileVO.atchFileNm}파일 다운로드" src="/resources/images/classRoom/freeBrd/free-download-solid.png" style="width:15px; height: 15px; margin-bottom:3px;"> 
                              <a href="/task/pdfView?atchFileCode=${atchFileVO.atchFileCode}&atchFileSn=${atchFileVO.atchFileSn}">${atchFileVO.atchFileNm}</a>
                           </li>
                     </c:forEach>
                  </c:when>
                  <c:otherwise>
                     <li>
                        <p style="margin-bottom:0px;">
                           <img alt="파일이 미존재 시 파일 아이콘 " src="/resources/images/classRoom/freeBrd/free-file-solid.png" 
                           style="width: 13px;margin-right: 2px; margin-bottom: 3px;">
							첨부된 파일이 없습니다.
                        </p>
                     </li>
                  </c:otherwise>
               </c:choose>
            </ul>
		</div>
    <div class="task-cont">
		<div id="smarteditor">
			<div id="taskCn" style="width:100%; font-size: 15px;">
				${taskVO.taskCn}
			</div>
		</div>
    </div>
	<div class="btn-zone">
		​​​​​​​​<input type="button" value="목록" id="goToTaskList" onclick="location.href='/task/taskList?clasCode=${taskVO.clasCode}'"/>
		<!-- 교사 권한일 경우, 수정/삭제 버튼 활성화 -->
		<c:if test="${USER_INFO.mberId == taskVO.hrtchrVO.mberId || USER_INFO.vwMemberAuthVOList[0].cmmnDetailCode == 'ROLE_A14002'}">
			​​​​​​​​<input type="button" value="수정" id="updateBtn"/> 
			​​​​​​​​<input type="button" value="삭제" id="deleteBtn"/>
		</c:if>
	</div>
</div>

<div id="TaskContainer">
   <div class="TaskAll stdntTaskAll" style="margin: auto; margin-bottom:50px;">
      <div class="TaskTitle">
          <p class="form-control input-sm inputTaskContainer">과제 제출란</p>
       </div>
       <hr>
       <div id="inputTaskDiv">
           <!-- 학생 권한일 경우, 과제 제출란 출력 -->
           <c:if test="${USER_INFO.vwMemberAuthVOList[0].cmmnDetailCode == 'ROLE_A01001'}">
              <div class="mb-3" style="display:flex;margin-top:20px;">
                 <img src="/resources/images/classRoom/freeBrd/freeFile.png" style="width:40px; display:inline-block;">
                 <span style="font-size:1.05rem; display: inline-block; vertical-align: middle;line-height: 2.5;">첨부파일</span> 
              </div>
              <form action="/task/inputTask" method="post">
                 <div class="uploadList">
                    <input type="file" id="inputTask" name="inputTask" accept=".pdf">
                 </div>
                 <div style="display:flex; justify-content: center; padding: 20px;">
                    <input type="button" value="파일 선택" id="inputTaskBtn">
                    <input type="button" value="제출" id="taskSubmitBtn">
                 </div>
              </form>
           </c:if>
      </div>
      <div id="inputTaskContainer" style="margin-bottom: 50px;"></div>
      </div>
   </div>
</div>

<!-- Modal 시작 -->
<!-- 피드백을 등록하는 모달 -->
<div id="feedbackInsertModal"
   class="modal modal-edu-general default-popup-PrimaryModal fade"
   role="dialog" style="align-content: center;">
   <div class="modal-dialog">
      <div class="modal-content">
         <div class="modal-close-area modal-close-df">
            <a class="close" data-dismiss="modal" href="#">
            <i class="fa fa-close"></i></a>
         </div>
         <div class="modal-body" style="padding: 40px 60px 30px 60px;">
         	<div class="feedbackTitle">
            	<h3>피드백 등록</h3>
            </div>
            <div class="form-group res-mg-t-15">
               <p class="stdntNm" style="margin-top: 20px;"></p>
					<textarea id="fdbckArea" name="fdbckArea" placeholder="내용을 입력해 주세요" style="resize: none; height: 220px;"></textarea>
			</div>
			<div class="modal-footer" style="text-align: center;">
				<a id="feedbackInsertBtn" href="#">등록</a>
				<a data-dismiss="modal" href="#" style="margin-left: 10px; background: #666;">취소</a>
				<a id="autoBtn" style="cursor: pointer; margin-left: 10px; background: black; width: 92px;">자동 완성</a>
			</div>
		</div>
      </div>
   </div>
</div>

<!-- 피드백을 수정하는 모달 -->
<div id="feedbackUpdateModal"
   class="modal modal-edu-general default-popup-PrimaryModal fade"
   role="dialog" style="align-content: center;">
   <div class="modal-dialog">
      <div class="modal-content">
         <div class="modal-close-area modal-close-df">
            <a class="close" data-dismiss="modal" href="#">
            <i class="fa fa-close"></i></a>
         </div>
         <div class="modal-body" style="padding: 40px 60px 30px 60px;">
         	<div class="feedbackTitle">
            	<h3>피드백 수정</h3>
            </div>
            <div class="form-group res-mg-t-15">
				<p class="stdntNm" style="margin-top: 20px;"></p>
					<textarea id="updateFdbckArea" name="updateFdbckArea" placeholder="내용을 입력해 주세요" style="resize: none; height: 220px;"></textarea>
            </div>
            <div class="modal-footer" style="text-align: center;">
		         <a id="feedbackUpdateBtn" href="#">수정</a>
		         <a data-dismiss="modal" href="#" style="margin-left: 10px; background: #666;">취소</a>
         	</div>
         </div>
      </div>
   </div>
</div>

<!-- 과제 제출 현황을 볼 수 있는 모달 -->
<div id="inputTaskDetailModal" class="modal modal-edu-general default-popup-PrimaryModal fade" role="dialog" style="align-content: center;">
   <div class="modal-dialog" style="width: 450px;">
      <div class="modal-content inputTaskDetailModalContent">
         <div class="modal-close-area modal-close-df">
            <a class="close" data-dismiss="modal" href="#">
               <i class="fa fa-close"></i>
            </a>
         </div>
         <div class="modal-body" style="padding: 40px 60px 40px 65px;">
            <div class="inputTaskDetailTitle">
            	<h3>과제 제출 현황</h3>
            </div>
            <div class="form-group res-mg-t-15" style="margin-top: 20px;">
               <div class="product-status-wrap drp-lst inputTaskList" style="padding: 0px 20px 0px 10px; height: 350px; overflow: auto;">
                  <div class="asset-inner">
                        <table>
                            <tbody id="inputTaskDetailTbody"></tbody>
                        </table>
                    </div>
                 </div>
            </div>
            <div class="modal-footer" style="text-align: center; padding: 15px 0px 0px 0px;">
				<a data-dismiss="modal" href="#" style="background: black;">닫기</a>
			</div>
         </div>
      </div>
   </div>
</div>
<!-- Modal 끝 -->