<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<style>
.dataSpan{
	font-weight: bold;
    color: #999;
    display: inline-block;
    width: 65px;
}

.school{
    margin-right: 14px;
}

.basic-list li:last-child {
	padding: 17px 0px 5px;
	border-bottom: 1px solid rgba(120, 130, 140, .13);
}

.basic-list li{
	padding: 17px 0px 5px;
    border-bottom: 1px solid rgba(120, 130, 140, .13);
    margin-bottom: 10px;
}

#thum{
   width: 200px; height: 200px;
   border-radius: 70%;
   object-fit: cover;
   position: relative;
}

#profileUploadIcon{
    position: absolute;
	width: 45px;
    top: 228px;
    left: 348px;
    cursor: pointer;
}

#studentContainer h4{
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

#updateBtn, #saveBtn, #cancelBtn, #listBtn, #deleteBtn{
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
    margin-top: 20px;
    margin-bottom: 35px;
}

#updateBtn:hover, #cancelBtn:hover, #saveBtn:hover, #listBtn:hover, #deleteBtn:hover {
	background: #ffd77a;
	transition: all 1s ease;
	color:#333;
}

#cancelBtn, #listBtn {
	background: #666;
}

#deleteBtn {
	background-color: #333;
}

.MyPageAll{
   width: 1200px;
   margin: auto;
   margin-bottom: 140px;
   backdrop-filter: blur(10px);
   background-color: rgba(255, 255, 255, 1);
   border-radius: 50px;
   box-shadow: 0px 35px 68px 0px rgba(145, 192, 255, 0.5), inset 0px -6px 16px 0px rgba(145, 192, 255, 0.6), inset 0px 11px 28px 0px rgb(255, 255, 255);
   padding: 30px;
}

.MyPageAll .free-cont{
   border: 1px solid #ddd;
   border-radius: 10px;
   padding: 10px 20px;
   min-height: 83px;
   margin-top: 50px;
}
.MyPageAll .FreeTit {
   display: flex;
   justify-content: space-between;
   position:relative;
}

.MyPageAll .title{
   font-size: 1.8rem;
   font-weight: 700;
   margin-top: 6px;
}

.myPersonalData input{
   width: 100%;
   height: 40px;
   border: 1px solid #d1d1d1;
   border-radius: 7px;
   padding-left: 12px; 
   background-color: white;
}
.myPersonalData input[disabled]{
   background-color: #F0F0F0;
}
</style>
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script type="text/javascript">
function resultSAlert(result, actTitle, reloadPage) {
	let res = "성공";
	let icon = "success";
	
	if (result < 2) { res = "실패"; icon = "error"; }
	
	Swal.fire({
      title: actTitle + " " + res + '하였습니다.',
      text: reloadPage,
      icon: icon
	}).then(result => { location.reload(); }); 
}
function resultDAlert(result, actTitle, reloadPage) {
	let res = "성공";
	let icon = "success";
	
	if (result < 2) { res = "실패"; icon = "error"; }
	
	Swal.fire({
      title: actTitle + " " + res + '하였습니다.',
      text: reloadPage,
      icon: icon
	}).then(result => { location.href="/employee/studentList?schulCode=${param.schulCode}" }); 
}
$(function(){
	// cmmnSchulPsitnSttus와 cmmnEmpClsf 값 설정
    var cmmnSchulPsitnSttusValue = '${schulVO.schulPsitnMberVOList[0].cmmnSchulPsitnSttus}'; 
    var cmmnGradeValue = '${schulVO.schulPsitnMberVOList[0].cmmnGrade}';
    
    // cmmnSchulPsitnSttus 요소의 값을 선택
    $('#cmmnSchulPsitnSttus').val(cmmnSchulPsitnSttusValue);
    
    // cmmnEmpClsf 요소의 값을 선택
    $('#cmmnGrade').val(cmmnGradeValue);
    
    let schulCode = $("#schulCode").val();
	let mberId = $("#mberId").val();
	let mberNm = $("#mberNm").val();
	let moblphonNo = $("#moblphonNo").val();
	let mberEmail = $("#mberEmail").val();
	let zip = $("#zip").val();
	let mberAdres = $("#mberAdres").val();
	
	
	/* 학생 삭제 시작 */
	$("#deleteBtn").on("click",function(){
		if(!confirm("삭제하시겠습니까?")){
			alert("삭제가 취소되었습니다.");
			return;
		}
		let schulCode = $("#schulCode").val();
		let mberId = $("#mberId").val();
		
		let data = {
				"mberId":mberId,
				"schulCode":schulCode
		};
		
		
		$.ajax({
			url:"/employee/studentDeleteAjax",
			contentType:"application/json;charset=utf-8",
			data:JSON.stringify(data),
			type:"post",
			dataType:"text",
			beforeSend:function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			},
			success:function(result){
				if(result == 2){
				resultDAlert(result, '학생 삭제를', '학생 목록으로 이동합니다.');
				}else{
					alertError('학생 삭제를 실패하였습니다.', ' ');
				}
			}
		});
	}); /* 학생 삭제 끝 */

	/* 저장 버튼 시작 */
	$("#saveBtn").on("click",function(){
		let cmmnSchulPsitnSttus = $("#cmmnSchulPsitnSttus option:selected").val();
		let cmmnGrade = $("#cmmnGrade option:selected").val();
		

		// 가상 폼 <form></form>
		var frm = new FormData($("#frm")[0]);
		frm.append("mberId",mberId);
		
		$.ajax({
			url:"/employee/studentUpdateAjax",
			processData:false,
			contentType:false,
			data:frm,
			type:"post",
			dataType:"json",
			beforeSend:function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			},
			success:function(result){
				//성공 : 2
				if(result == 2){
				resultSAlert(result, '정보 수정을', '학생 상세 화면으로 이동합니다.');
				}else{
					alertError('정보 수정을 실패하였습니다.', ' ');
				}
			}
		});
	});
	/* 저장 버튼 끝 */
	
	/* 수정 버튼 시작 */
	$("#updateBtn").on("click",function(){
		
		$('#mberNm').removeAttr('disabled');
		$("#moblphonNo").removeAttr('disabled');
		$("#mberEmail").removeAttr('disabled');
		$("#mberAdres").removeAttr('disabled');
		$("#cmmnSchulPsitnSttus").removeAttr('disabled');
		$("#cmmnGrade").removeAttr('disabled');
		$("#searchAddrBtn").css("display","block");
		
		$("#updateBtn").css("display","none");
		$("#listBtn").css("display","none");
		$("#saveBtn").css("display","block");
		$("#cancelBtn").css("display","block");
		$("#profileUploadIcon").css("display","block");
		
		
	}); /* 수정 버튼 끝 */
	
	/* 취소버튼 시작 */
	$("#cancelBtn").on("click",function(){
		$('#mberNm').attr('disabled', true);
		$("#moblphonNo").attr('disabled', true);
		$("#mberEmail").attr('disabled', true);
		$("#mberAdres").attr('disabled', true);
		$("#cmmnSchulPsitnSttus").attr('disabled', true);
		$("#cmmnGrade").attr('disabled', true);
		$("#searchAddrBtn").css("display","none");
		
		$("#updateBtn").css("display","block");
		$("#listBtn").css("display","block");
		$("#saveBtn").css("display","none");
		$("#cancelBtn").css("display","none");
		$("#profileUploadIcon").css("display","none");
	});
	/* 취소버튼 끝 */
	
	/* 주소 찾기 시작 */
    $("#searchAddrBtn").on("click", function(){
		new daum.Postcode({
			//다음 창에서 검색이 완료되면
			oncomplete : function(data) {
				$("#zip").val(data.zonecode);//우편번호
		        $("#mberAdres").val(data.address + " ");
		        $("#mberAdres").focus();
			}
		}).open();
	});
    /* 주소 찾기 끝 */
	
	/* 썸네일 시작 */
	$("#inputImg").on("change",handleImg);
	
	//e : onchange 이벤트 객체
	function handleImg(e){
		//e.target : <input type="file"..
		let files = e.target.files;
		//이미지 오브젝트 배열		
		let fileArr = Array.prototype.slice.call(files);
		//초기화
		$(".profile-img").html("");
		//fileArr : {"개똥이.jpg객체","홍길동.jpg객체"}
		//f :각각의 이미지 파일
		fileArr.forEach(function(f){
			//f.type : MIME타입
			if(!f.type.match("image.*")){
				alertError('이미지 파일만 가능합니다.', ' ');
			}
			//이미지를 읽어보자
			let reader = new FileReader();
			
			//e : reader가 이미지를 읽을 때 그 이벤트
			reader.onload = function(e){
				//e.target : 이미지 객체
				let img = "<img src="+e.target.result+" id='thum' />";
				$(".profile-img").append(img);
			}
			
			reader.readAsDataURL(f);
		});
	}/* 썸네일 끝 */
	
	
	
	/* 목록 버튼 시작 */
	$("#listBtn").on("click",function(){
		location.href = "/employee/studentList?schulCode="+schulCode;
	});/* 목록 버튼 끝 */
	
	/* 이미지 업로드 아이콘 클릭 시작 */
	$("#profileUploadIcon").on("click", function(){
    	$("#inputImg").trigger("click");
    })
	/* 이미지 업로드 아이콘 클릭 끝 */
});

</script>
<div id="studentContainer">
   <h4>
      <img src="/resources/images/student/student2.png" style="width:45px; display:inline-block; vertical-align:middel; margin-right: 7px; margin-bottom: 5px;">      
      	학생 상세
      <img src="/resources/images/student/student1.png" style="width:55px; display:inline-block; vertical-align:middel; margin-bottom: 9px;">
   </h4>
   <div class="MyPageAll">
      <div class="row">
         <div id="myTabContent" class="tab-content custom-product-edit">
            <div class="product-tab-list tab-pane fade active in" id="description">
               <form id="frm" action="" method="post" enctype="multipart/form-data">
                  <div class="row">
                     <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                        <div class="container-fluid">
                           <div class="row">
                              <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                 <ul id="myTabedu1" class="tab-review-design" style="padding-left: 30px; padding-top: 10px;">
                                    <li class="active"><a href="#description">학생 정보</a></li>
                                 </ul>
                                 <div class="single-cards-item" style="margin-top: 20px;">
                                    <div class="profile-img" style="text-align: center;">
                                       <c:choose>
                                           <%-- 프로필이 있는 경우 --%>
                                           <c:when test="${schulVO.schulPsitnMberVOList[0].memberVO.mberImage != null}">
                                               <img src="/upload/profile/${schulVO.schulPsitnMberVOList[0].memberVO.mberImage}" alt="" id="thum" />
                                           </c:when>
                                           <%-- 프로필이 없는 경우 --%>
                                           <c:otherwise>
                                               <img src="/resources/images/member/profile/user_l.png" alt="" id="thum"/>
                                           </c:otherwise>
                                       </c:choose>
                                       <img id="profileUploadIcon" src="/resources/images/member/myPage/camera.png" alt="" style="display: none">
                                    </div>
                                    <div class="profile-details-hr">
                                       <div class="row" style="text-align: center;"></div>
                                    </div>
                                    <div class="myPersonalData" style="padding: 0px 20px 20px 30px;">
                                       <div class="devit-card-custom">
                                          <div class="form-group">
                                             <p>
                                                <span class="dataSpan">아이디</span>
                                                <input id="schulCode" type="text" value="${schulVO.schulCode}" style="display: none">
                                                <input id="mberId" type="text" value="${schulVO.schulPsitnMberVOList[0].memberVO.mberId}" disabled>
                                             </p>
                                             <p>
                                                <span class="dataSpan">이름</span>
                                                <input id="mberNm" name="mberNm" type="text" class="myDataInputBox" value="${schulVO.schulPsitnMberVOList[0].memberVO.mberNm}" disabled>
                                             </p>
                                          </div>
                                          <div class="form-group">
                                             <p>
                                                <span class="dataSpan">핸드폰번호</span>
                                                <input id="moblphonNo" name="moblphonNo" type="text" class="myDataInputBox" value="${schulVO.schulPsitnMberVOList[0].memberVO.moblphonNo}" disabled>
                                             </p>
                                          </div>
                                          <div class="form-group">
                                             <p>
                                                <span class="dataSpan">이메일</span>
                                                <input id="mberEmail" name="mberEmail" type="text" class="myDataInputBox" value="${schulVO.schulPsitnMberVOList[0].memberVO.mberEmail}" disabled>
                                             </p>
                                          </div>
                                          <div class="form-group">
                                             <div id="addrDiv">
                                                <span class="dataSpan">주소</span>
                                                <p style="display: flex; justify-content:space-between;">
                                                   <input type="text" class="form-control is-warning" id="zip" name="zip" placeholder="우편 번호" style="display: none;" value="${schulVO.schulPsitnMberVOList[0].memberVO.zip}" /> 
                                                   <input id="mberAdres" name="mberAdres" type="text" class="myDataInputBox mberAdresBox" value="${schulVO.schulPsitnMberVOList[0].memberVO.mberAdres}" disabled>
                                                   <input id="searchAddrBtn" type="button" value="주소 찾기" style="width: 20%; margin-left: 7px; background-color: #f5f5f5; padding-left: 9px; display: none">
                                                </p>
                                             </div>
                                          </div>
                                       </div>
                                    </div>
                                 </div>
                              </div>
                              <!-- 소속 학교 정보 시작 -->
                              <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                 <ul id="myTabedu1" class="tab-review-design" style="padding-left: 30px; padding-top: 10px;">
                                    <li class="active"><a href="#description">소속 학교 정보</a></li>
                                 </ul>
                                 <div class="white-box" style="padding: 20px 30px 20px 30px;">
                                    <ul class="basic-list">
                                       <li><span class="dataSpan school">· 학교이름 </span>${schulVO.schulNm}</li>
                                       <li><span class="dataSpan school">· 학교주소 </span>${schulVO.schulAdres}</li>
                                       <li><span class="dataSpan school">· 전화번호 </span>${schulVO.schulTlphonNo}</li>
                                       <li>
	                                       	<span class="dataSpan school">· 
	                                       		<label class="col-form-label" for="cmmnSchulPsitnSttus">소속 상태</label>
	                                       	</span>
											<select name="cmmnSchulPsitnSttus" id="cmmnSchulPsitnSttus" disabled>
												<option disabled>상태를 선택하세요</option>
												<option value="A02101">재학</option>
												<option value="A02102">휴학</option>
												<option value="A02103">전학</option>
												<option value="A02107">졸업</option>
												<option value="A02108">자퇴</option>
											</select>
                                       </li>
                                       <li>
	                                       <span class="dataSpan school">·
	                                       		<label class="col-form-label" for="cmmnGrade">학년</label>
	                                       </span>
											<select name="cmmnGrade" id="cmmnGrade" disabled>
												<option disabled>학년을 선택하세요</option>
												<option value="A22001">1</option>
												<option value="A22002">2</option>
												<option value="A22003">3</option>
												<option value="A22004">4</option>
												<option value="A22005">5</option>
												<option value="A22006">6</option>
											</select>	
                                       </li>
                                    </ul>
                                 </div>
                                 <br>
                                 <ul id="myTabedu1" class="tab-review-design" style="padding-left: 30px; padding-top: 10px;">
                                    <li class="active"><a href="#description">소속 학급 정보</a></li>
                                 </ul>
                                 <div class="white-box" style="padding: 20px 30px 20px 30px;">
                                 	<p style="font-weight: bold; color: #999;">소속된 학급 클래스는 확인할 수 없습니다.</p>
                                 </div>
                              </div>
                           </div>
                        </div>
                     </div>
                  </div>
                  <div class="row btn-zone">
                     <div class="col-lg-12" style="display: flex; justify-content: center;">
                        <label for="inputImg" id="updateLabel" style="display: none;" class="btn btn-primary waves-effect waves-light">
                           <input type="file" accept="image/*" name="uploadFile" id="inputImg" class="hide" />
                           	사진 업로드
                        </label>
                        <input type="hidden" name="mberImage" id="mberImage" value="">
                        <sec:authorize access = "hasAnyRole('A14001','A14003')" >
	                        <input type="button" id="updateBtn" class="btn btn-primary waves-effect waves-light" value="수정">
	                        <input type="button" id="saveBtn" class="btn btn-primary waves-effect waves-light" value="저장" style="display: none">
	                        <input type="reset" id="cancelBtn" class="btn btn-primary waves-effect waves-light" value="취소" style="display: none">
                        </sec:authorize>
                        <input type="button" id="listBtn" class="btn btn-primary waves-effect waves-light" value="목록" >
                        <sec:authorize access = "hasAnyRole('A14001','A14003')" >
                        	<input type="button" id="deleteBtn" class="btn btn-primary waves-effect waves-light" value="삭제" >
                        </sec:authorize>
                     </div>
                  </div>
               </form>
            </div>
         </div>
      </div>
   </div>
</div>