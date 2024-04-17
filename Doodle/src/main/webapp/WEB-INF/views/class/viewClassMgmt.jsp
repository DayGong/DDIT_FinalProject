<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script>
const header = "${_csrf.headerName}";
const token = "${_csrf.token}";
// var schulCode = "${clasVO.schulCode}";              //학교 코드
var clasCode = "${clasVO.clasCode}";                //반 코드
// var cmmnGrade = "${clasVO.cmmnGrade}";              //기존 학년
var cmmnClasSttus = "${clasVO.cmmnClasSttus}";      //기존 상태
// var selectedGradeValue = "";                        //변경 학년
var selectedStateValue = "";                        //변경 상태
var beginTm = "${clasVO.beginTm}";                  //기존 등교 시간
var endTm = "${clasVO.endTm}";                      //기존 하교 시간
var selectBeginTime = "";                           //변경 등교 시간
var selectEndTime = "";                             //변경 하교 시간

window.onload = function(){
    // let selectGradeElement = document.getElementById("grade"); //학년의 select요소 가져오기
    /* 
    // cmmnGrade(반 학년) 값과 같은 옵션 선택하기 - 초기화면
    for (let i = 0; i < selectGradeElement.options.length; i++) {
        if (selectGradeElement.options[i].value === cmmnGrade) {
            selectGradeElement.selectedIndex = i; // 해당 옵션 선택
            break;
        }
    } */

    let selectStateElement = document.getElementById("classState"); //반 상태 select요소 가져오기
    // cmmnClasSttus(반 상태) 값과 같은 옵션 선택하기 - 초기화면
    for (let i = 0; i < selectStateElement.options.length; i++) {
        if (selectStateElement.options[i].value === cmmnClasSttus) {
            selectStateElement.selectedIndex = i; // 해당 옵션 선택
            break;
        }
    }

    /* // 선택 학년이 변경
    selectGradeElement.addEventListener('change', function() {
        selectedGradeValue = selectGradeElement.value;          //변경을 위한 선택한 학년
        console.log("현재 선택된 학년 값:", selectedGradeValue);
    }); */

    // 선택 상태가 변경
    selectStateElement.addEventListener('change', function() {
        selectedStateValue = selectStateElement.value;          //변경을 위한 선택한 상태
        console.log("현재 선택된 상태 값:", selectedStateValue);
    });

    var beginTimeInput = document.getElementById("beginTm");    //기존 등교 시간 요소 가져오기
    var endTimeInput = document.getElementById("endTm");        //기존 하교 시간 요소 가져오기

    // console.log("등교시간",beginTime);
    // console.log("하교시간",endTime);

    // 등교 시간이 변경
    beginTimeInput.addEventListener('change',function(){
        selectBeginTime = beginTimeInput.value;
        console.log("변경 후 등교시간",selectBeginTime);
    }); 

    // 하교 시간이 변경
    endTimeInput.addEventListener('change', function(){
        selectEndTime = endTimeInput.value;
        console.log("변경 후 하교시간", selectEndTime);
    });
};

//---------------------------클래스 수정 버튼 시작-----------------------------
function updateBtn(){
    //등교 시간이 변경되지 않았다면 초기값으로 사용
    if(!selectBeginTime){
        selectBeginTime = beginTm;
    } 

    //하교 시간이 변경되지 않았다면 초기값으로 사용
    if(!selectEndTime){
        selectEndTime = endTm;
    } 

   /*  //학년 값이 변경되지 않았다면 초기값으로 사용
    if (!selectedGradeValue) {
        selectedGradeValue = cmmnGrade;
    } */

    //상태 값이 변경되지 않았다면 초기값으로 사용
    if (!selectedStateValue){
        selectedStateValue = cmmnClasSttus;
    }
    //console.log("상태 값:", selectedStateValue);

    let clasYear = document.getElementById("clasYear").value; //반 연도 가져오기
    let clasNm = document.getElementById("clasNm").value; //반 이름 가져오기

    let data = {
        /* "schulCode":schulCode,                     //학교코드
        "clasYear":clasYear,                         //연도
        "clasNm":clasNm,                             //반이름
        "cmmnGrade":selectedGradeValue,              //학년 */
        "clasCode":clasCode,                         //반코드
        "cmmnClasSttus":selectedStateValue,          //상태
        "beginTm":selectBeginTime,                   //등교시간
        "endTm":selectEndTime                        //하교시간
    }
    console.log("data",data);

    //클래스 변경 Ajax시작
    $.ajax({
        type:"post",
        url:"/class/classUpdateAjax",
        contentType:"application/json;charset=utf-8",
        data:JSON.stringify(data),
        dataType:"json",
        beforeSend:function(xhr){
			xhr.setRequestHeader(header,token);
			},
        success:function(result){
            if(result>0){
                Swal.fire({
				  icon : "success",
			      title: "수정이 완료되었습니다."
			    }).then(result => {
                        if (result.isConfirmed) { // 모달창에서 confirm 버튼을 눌렀다면
                            window.close();
                            window.opener.location.reload(); // 부모 창 새로고침
                        }
				    });
            }
        }
    }); //클래스 변경 Ajax끝
}
//---------------------------클래스 수정 버튼 끄읕-----------------------------

//---------------------------클래스 삭제 버튼 시작-----------------------------
function deleteBtn(){

    Swal.fire({
                icon : "warning",
                title: "삭제하시겠습니까?",
                showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
                confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
                cancelButtonColor: '#d33', // cancel 버튼 색깔 지정
                confirmButtonText: '삭제', // confirm 버튼 텍스트 지정
                cancelButtonText: '취소', // cancel 버튼 텍스트 지정
            }).then(result => {
                        if (result.isConfirmed) { // 모달창에서 confirm 버튼을 눌렀다면
    let data = {
        "clasCode":clasCode
    }
    console.log("data",data);
    //정말삭제하시겠습ㄴ까? 추가하기

    $.ajax({
        type:"post",
        url:"/class/classDeleteAjax",
        contentType:"application/json;charset=utf-8",
        data:JSON.stringify(data),
        dataType:"json",
        beforeSend:function(xhr){
			xhr.setRequestHeader(header,token);
			},
        success:function(result){
            if(result>0){
                Swal.fire({
				  icon : "success",
			      title: "삭제가 완료되었습니다 !"
			    }).then(result => {
                        if (result.isConfirmed) { // 모달창에서 confirm 버튼을 눌렀다면
                            window.close();
                            window.opener.location.href = '/school/main'; //클래스 삭제 후 학교메인으로 이동
                        }
				    });
            }else{
                Swal.fire({
				  icon : "error",
			      title: "삭제를 실패했습니다 !"
			    });
            }
        }
    }); //클래스 변경 Ajax끝
}
				    });
}

//---------------------------클래스 삭제 버튼 시작-----------------------------

//---------------------------클래스 닫기 버튼 시작-----------------------------
function cancelBtn(){
    window.close();
}
//---------------------------클래스 닫기 버튼 끝-----------------------------
</script>
<style>
.modal-body {
	text-align: center;
	backdrop-filter: blur(4px);
	background-color: rgba(255, 255, 255, 1);
	border-radius: 50px;
	box-shadow: 35px 35px 68px 0px rgba(99, 117, 141, 0.5), inset -8px -8px
		16px 0px rgba(99, 117, 141, 0.6), inset 0px 11px 28px 0px
		rgb(255, 255, 255);
	padding-top: 35px;
	padding-bottom: 35px;
	margin-bottom: 40px;
	padding: 15%;
}

.divInfo{
	display : inline-flex;
	margin-left: 10px;
    margin-bottom: 5px;
}
.sparkline13-graph {
    float: right;
}

label{
	width: 50px;
}

.col-md-12{
    text-align: left;
}

</style>
<div class="modal-body">
    <h1 style="padding: 10px; font-size: 2.2em;">
        <span id="aschaNm" style="background: linear-gradient(to top, #7cb8ff 20%, transparent 20%);">클래스 정보</span>
    </h1>
    <div class="row">
		<div class="col-md-12">
			<div class="form-group">
				<label>학교명</label>
        		<input type="text" class="form-control" name="schulNm" value="${schulVO.schulNm}" disabled /> <!--접속중인 학교 세션 -->
			</div>
			<div class="form-group">
				<label>연도</label>
       			<input type="number" id="clasYear" name="clasYear" value="${clasVO.clasYear}" class="form-control" disabled />
			</div>
			<div class="form-group" style="width:50%;float:left;">
				<label>학년</label>
                <select class="form-control" id="grade" disabled>
                      <option value="A22001">1학년</option>
                      <option value="A22002">2학년</option>
                      <option value="A22003">3학년</option>
                      <option value="A22004">4학년</option>
                      <option value="A22005">5학년</option>
                      <option value="A22006">6학년</option>
                </select>
			</div>
			<div class="form-group" style="width:50%;float:left;">
				<label>반</label>
       					<input type="text" id="clasNm" name="clasNm" value="${clasVO.clasNm}" class="form-control" disabled />
			</div>
			<div class="form-group">  
				 <label>상태</label>
		           <!--  <select class="form-control" id="classState" disabled>
		                <option value="A16001">운영</option>
		                <option value="A16002">중지</option>
		                <option value="A16003">종료</option>
		            </select> -->
                    <c:choose>
                        <c:when test="${USER_INFO.vwMemberAuthVOList[0].cmmnDetailCode == 'ROLE_A14002'}"> <!-- 교사만 선택가능 -->
                            <select class="form-control" id="classState">
                                <option value="A16001">운영</option>
                                <option value="A16002">중지</option>
                                <option value="A16003">종료</option>
                            </select>
                        </c:when>
                        <c:otherwise>
                            <select class="form-control" id="classState" disabled><!-- 나머지 권한들은 disabled -->
                                <option value="A16001">운영</option>
                                <option value="A16002">중지</option>
                                <option value="A16003">종료</option>
                            </select>
                        </c:otherwise>
                    </c:choose>
			</div>
			<div class="form-group" style="width:50%;float:left;">                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
				 <label>등교시간</label>
                 <c:choose>
                    <c:when test="${USER_INFO.vwMemberAuthVOList[0].cmmnDetailCode == 'ROLE_A14002'}"><!-- 교사만 수정가능 -->
                        <input type="time" id="beginTm" name="beginTm" value="${clasVO.beginTm}" class="form-control" />
                    </c:when>
                    <c:otherwise>
                        <input type="time" id="beginTm" name="beginTm" value="${clasVO.beginTm}" class="form-control" disabled /><!-- 나머지 권한들은 disabled -->
                    </c:otherwise>
                </c:choose>   
            </div>
            <div class="form-group" style="width:50%;float:left;">        
                 <label>하교시간</label>
                 <c:choose>
                    <c:when test="${USER_INFO.vwMemberAuthVOList[0].cmmnDetailCode == 'ROLE_A14002'}"> <!-- 교사만 수정가능 -->
                        <input type="time" id="endTm" name="endTm" value="${clasVO.endTm}" class="form-control" />
                    </c:when>
                    <c:otherwise>
                        <input type="time" id="endTm" name="endTm" value="${clasVO.endTm}" class="form-control" disabled /><!-- 나머지 권한들은 disabled -->
                    </c:otherwise>
                </c:choose>   
			</div>
		</div>
	</div>
    <div class="btn-zone">
        <c:if test="${USER_INFO.vwMemberAuthVOList[0].cmmnDetailCode == 'ROLE_A14002'}">			
            <button type="button" class="d-btn-blue" id="updateBtn" onclick="updateBtn()">수정</button>
            <button type="button" class="d-btn-red" id="deleteBtn" onclick="deleteBtn()">삭제</button>
         </c:if>
        <button type="button" class="d-btn-green" id="cancelBtn" onclick="cancelBtn()">닫기</button>
    </div>
</div>
			