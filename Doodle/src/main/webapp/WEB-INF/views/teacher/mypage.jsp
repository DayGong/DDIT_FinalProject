<%@page import="kr.or.ddit.vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<style>
.dataSpan{
	font-weight: bold;
    color: #999;
    display: inline-block;
    width: 65px;
}

.school{
/* 	border-right: 2px solid #eee; */
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

#profileImg{
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

#FreeBoardContainer h4{
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
   margin-top: 10px;
   margin-bottom: 40px;
}

#updateBtn, #resetBtn{
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

#updateBtn:hover, #resetBtn:hover{
	background: #ffd77a;
	transition: all 1s ease;
	color:#333;
}

#resetBtn{
	background: #666;
	padding: 15px 24px;
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
.myPersonalData input[readonly]{
   background-color: #F0F0F0;
}
</style>
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<script type="text/javascript" src="/resources/js/jquery.min.js" ></script>
<script type="text/javascript">

$(function(){
// 	console.log("${myClassList}");

	// 업로드한 사진 반영하기
    $("#inputImage").on("input", function() {
    	// 업로드한 파일 가져오기
        var file = $(this)[0].files[0]
        console.log("uploadFile: " + file);
        
        // 파일 이름 추출하기
        var fileName = file.name;
        console.log("fileName: " + fileName);

        var imgSrc = "/resources/images/member/profile/" + fileName;
		
		$("#profileImg").attr("src", imgSrc);        	
    });

    // 정보 수정
    $("#updateBtn").on("click", function(){
    	var mberId = "${memVO.mberId}";
    	var mberNm = $("#mberNm").val();
    	var moblphonNo = $("#moblphonNo").val();
    	var mberEmail = $("#mberEmail").val();
    	var mberAdres = $("#mberAdres").val();
    	
        // 업로드한 사진이 있으면 가져오기
        var file = $("#inputImage")[0].files[0];
        console.log("file", file);
        
        // 수정된 정보가 없을 시 alert
        if(mberNm == "${memVO.mberNm}" &&
           moblphonNo == "${memVO.moblphonNo}" &&
           mberEmail == "${memVO.mberEmail}" &&
           mberAdres == "${memVO.mberAdres}" &&
           file == null){
        	Swal.fire('수정된 정보가 없습니다.', '', 'info');
        	return;
        }
    	
    	Swal.fire({
			title: '해당 내용으로 정보를 수정하시겠습니까?',
			text: '',
			icon: 'warning',
			showCancelButton: true,       	// cancel 버튼 보이기
			confirmButtonText: '수정',       // confirm 버튼 텍스트 지정
			cancelButtonText: '취소',        // cancel 버튼 텍스트 지정
		}).then(result => {
	        if(result.isConfirmed){
		    	var formData = new FormData();
		    	
		    	formData.append("mberId", mberId);
		    	formData.append("mberNm", mberNm);
		    	formData.append("moblphonNo", moblphonNo);
		    	formData.append("mberEmail", mberEmail);
		    	formData.append("mberAdres", mberAdres);
		    	
	            if(file != null){
		            formData.append("uploadFile", $("#inputImage")[0].files[0]);
	            }
		    	
		    	$.ajax({
		    		url: "/teacher/updateInfo",
		    		processData: false,
		    		contentType: false,
		    		type:"post",
		    		data:formData,
		    		dataType:"json",
		    		beforeSend:function(xhr){
						xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
					},
		    		success: function(res){
						Swal.fire('수정이 완료되었습니다.', '', 'success');
						
						// 새 프로필 사진이 있을 경우 적용
						if(res.mberImage != null){
		                    var imgSrc = "/upload/profile/" + res.mberImage;
		                    $("#profileImg").attr("src", imgSrc);
						}
		    		}
		    	});
	        }
	    })
    });
    
    // 주소 찾기
    $("#searchAddrBtn").on("click", function(){
		new daum.Postcode({
			//다음 창에서 검색이 완료되면
			oncomplete : function(data) {
		        $("#mberAdres").val(data.address + data.zonecode + " ");
		        $("#mberAdres").focus();
			}
		}).open();
	});
    
	// 프로필 사진 업로드 아이콘을 클릭하면 파일 업로드 버튼 클릭한 것과 같게 함
    $("#profileUploadIcon").on("click", function(){
    	$("#inputImage").trigger("click");
    })
    
	// 초기화 버튼 클릭 이벤트
    $("#resetBtn").on("click", function(){
    	// 업로드한 사진이 있으면 가져오기
        var file = $("#inputImage")[0].files[0];
    	var mberImage = "${memVO.mberImage}";
    	var imgSrc = "";
    	
    	if(file != null){
    		$("#inputImage").val('');
    		
    		// 기존 프로필 사진이 있으면 출력
    		if(mberImage != ""){
	            imgSrc = "/upload/profile/" + mberImage;
    		// 기존 프로필 사진 없으면 기본 사진 출력
    		}else{
    			imgSrc = "/resources/images/member/profile/user_l.png";
    		}
    		
    		$("#profileImg").attr("src", imgSrc); 
    	}
    })
});
</script>
<%-- <p>교사 정보: ${memVO}</p> --%>
<%-- <p>학교 정보: ${mySchulList}</p> --%>
<%-- <p>클래스 정보: ${myClassList}</p> --%>
<%-- <p>회원 이미지: ${memVO.mberImage}</p> --%>
<div id="FreeBoardContainer">
   <h4>
      <img src="/resources/images/member/myPage/happyEmotion.png" style="width:45px; display:inline-block; vertical-align:middel; margin-right: 7px; margin-bottom: 5px;">      
      	마이 페이지
      <img src="/resources/images/member/myPage/colorHorse.png" style="width:55px; display:inline-block; vertical-align:middel; margin-bottom: 9px;">
   </h4>
   <div class="MyPageAll">
      <div class="row">
         <div id="myTabContent" class="tab-content custom-product-edit">
            <div class="product-tab-list tab-pane fade active in" id="description">
               <form action="/student/updateInfo" method="post" enctype="multipart/form-data">
                  <div class="row">
                     <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                        <div class="container-fluid">
                           <div class="row">
                              <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                 <ul id="myTabedu1" class="tab-review-design" style="padding-left: 30px; padding-top: 10px;">
                                    <li class="active"><a href="#description">내 정보</a></li>
                                 </ul>
                                 <div class="single-cards-item" style="margin-top: 20px;">
                                    <div class="profile-img" style="text-align: center;">
                                       <c:choose>
                                           <%-- 프로필이 있는 경우 --%>
                                           <c:when test="${memVO.getMberImage() != null}">
                                               <img src="/upload/profile/${memVO.getMberImage()}" alt="" id="profileImg" />
                                           </c:when>
                                           <%-- 프로필이 없는 경우 --%>
                                           <c:otherwise>
                                               <img src="/resources/images/member/profile/user_l.png" alt="" id="profileImg"/>
                                           </c:otherwise>
                                       </c:choose>
                                       <img id="profileUploadIcon" src="/resources/images/member/myPage/camera.png" alt="">
                                    </div>
                                    <div class="profile-details-hr">
                                       <div class="row" style="text-align: center;"></div>
                                    </div>
                                    <div class="myPersonalData" style="padding: 0px 20px 20px 30px;">
                                       <div class="devit-card-custom">
                                          <div class="form-group">
                                             <p>
                                                <span class="dataSpan">아이디</span>
                                                <input id="mberId" type="text" value="${memVO.mberId}" readonly>
                                             </p>
                                             <p>
                                                <span class="dataSpan">이름</span>
                                                <input id="mberNm" name="mberNm" type="text" class="myDataInputBox" value="${memVO.mberNm}">
                                             </p>
                                          </div>
                                          <div class="form-group">
                                             <p>
                                                <span class="dataSpan">핸드폰번호</span>
                                                <input id="moblphonNo" name="moblphonNo" type="text" class="myDataInputBox" value="${memVO.moblphonNo}">
                                             </p>
                                          </div>
                                          <div class="form-group">
                                             <p>
                                                <span class="dataSpan">이메일</span>
                                                <input id="mberEmail" name="mberEmail" type="text" class="myDataInputBox" value="${memVO.mberEmail}">
                                             </p>
                                          </div>
                                          <div class="form-group">
                                             <div id="addrDiv">
                                                <span class="dataSpan">주소</span>
                                                <p style="display: flex; justify-content:space-between;">
                                                   <input id="mberAdres" name="mberAdres" type="text" class="myDataInputBox mberAdresBox" value="${memVO.mberAdres}">
                                                   <input id="searchAddrBtn" type="button" value="주소 찾기" style="width: 20%; margin-left: 7px; background-color: #f5f5f5; padding-left: 9px;">
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
                                       <li><span class="dataSpan school">· 학교이름 </span>${mySchulList[0].schulVOList[0].schulNm}</li>
                                       <li><span class="dataSpan school">· 학교주소 </span>${mySchulList[0].schulVOList[0].schulAdres}</li>
                                       <li><span class="dataSpan school">· 전화번호 </span>${mySchulList[0].schulVOList[0].schulTlphonNo}</li>
                                       <li><span class="dataSpan school">· 소속상태 </span>${mySchulList[0].schulPsitnSttusNm}</li>
                                       <li><span class="dataSpan school">· 교내직급 </span>${mySchulList[0].cmmnEmpClsfNm}</li>
                                    </ul>
                                 </div>
                                 <br>
                                 <ul id="myTabedu1" class="tab-review-design" style="padding-left: 30px; padding-top: 10px;">
                                    <li class="active"><a href="#description">소속 학급 정보</a></li>
                                 </ul>
                                 <div class="white-box" style="padding: 20px 30px 20px 30px;">
                                    <ul class="basic-list">
                                       <c:choose>
                                           <%-- 운영 중인 클래스가 있는 경우 --%>
                                           <c:when test="${myClassList != null}">
		                                       <li><span class="dataSpan school">· 학급이름</span> ${myClassList[0].clasVOList[0].clasNm}</li>
		                                       <li><span class="dataSpan school">· 생성연도</span> ${myClassList[0].clasVOList[0].clasYear}</li>
		                                       <li><span class="dataSpan school">· 운영상태</span> ${myClassList[0].clasVOList[0].cmmnClasSttusNm}</li>
                                           </c:when>
                                           <%-- 운영 중인 클래스가 없는 경우 --%>
                                           <c:otherwise>
                                           	   <p style="font-weight: bold; color: #999;">운영 중인 학급 클래스가 없습니다.</p>
                                           </c:otherwise>
                                       </c:choose>
                                    </ul>
                                 </div>
                              </div>
                           </div>
                        </div>
                     </div>
                  </div>
                  <div class="row btn-zone">
                     <div class="col-lg-12" style="display: flex; justify-content: center;">
                        <label for="inputImage" id="updateLabel" style="display: none;" class="btn btn-primary waves-effect waves-light">
                           <input type="file" accept="image/*" name="uploadFile" id="inputImage" class="hide" />
                           	사진 업로드
                        </label>
                        <input type="hidden" name="mberImage" id="mberImage" value="">
                        <input type="button" id="updateBtn" class="btn btn-primary waves-effect waves-light" value="수정">
                        <input type="reset" id="resetBtn" class="btn btn-primary waves-effect waves-light" value="초기화">
                     </div>
                  </div>
               </form>
            </div>
         </div>
      </div>
   </div>
</div>

<!-- 비밀번호 변경 모달 -->
<form id="updatePasswordForm" action="/student/updatePassword" method="post">
	<div id="UpdatePasswordModal"
		class="modal modal-edu-general default-popup-PrimaryModal fade"
		role="dialog">

		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-close-area modal-close-df">
					<a class="close" data-dismiss="modal" href="#"> <i
						class="fa fa-close"></i></a>
				</div>
				<div class="modal-body">
					<div>
					<h2>비밀번호 변경</h2>
					<span id="firstPwChk" style="display: none;">*최초 1회 비밀번호 변경이 필요합니다.</span>
					</div>
					<br>
					<div id="pwChk" class="alert alert-danger alert-mg-b" role="alert" style="display: none;">
						
					</div>
					<div id="UpdatePasswordContainer">
						<ul class="InputPassword">
							<li><span>비밀번호</span> <input type="password" name="password"
								id="password1" class="form-control"> <small
								data-chk="dataChk">특수기호/영문가능</small></li>
							<br>
							<li><span>비밀번호 확인</span> <input type="password"
								name="password2" id="password2" class="form-control"> <small
								data-chk="dataChk">동일한 비밀번호를 입력해주세요</small></li>
						</ul>
					</div>
				</div>
				<div class="modal-footer">
					<a id="UpdatePasswordBtn" href="#">수정</a>
					<a data-dismiss="modal" href="#">취소</a>
				</div>
			</div>
		</div>
	</div>
</form>