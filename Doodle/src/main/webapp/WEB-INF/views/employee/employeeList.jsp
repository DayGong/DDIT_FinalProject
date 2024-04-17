<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<style>
#empContainer h3 {
	font-size: 2.2rem;
	text-align: center;
	margin-top: 60px;
	backdrop-filter: blur(4px);
	background-color: rgba(255, 255, 255, 1);
	border-radius: 50px;
	box-shadow: 35px 35px 68px 0px rgba(145, 192, 255, 0.5), inset -8px -8px 16px 0px rgba(145, 192, 255, 0.6), inset 0px 11px 28px 0px rgb(255, 255, 255);
	width: 470px;
	padding-top: 25px;
	padding-bottom: 35px;
	margin: auto;
	margin-top: 10px;
	margin-bottom: 25px;
}

#empContainer {
	min-height: 824px;
}

#empContainer .custom-pagination {
	max-width:302px;
	margin: auto;
}

#empContainer .custom-pagination .pagination {
	 width: max-content;
}

.searchForm {
	height: 40px;
	border: 1px solid #ddd;
	border-radius: 5px;
	padding: 15px 20px;
}

#search, #insertBtn, #excelBtn, #cancelBtn {
	background: #333;
	height: 40px;
	border: none;
	padding: 10px 15px;
	border-radius: 10px;
	font-family: 'Pretendard' !important;
	font-weight: 600;
	color: #fff;
}

#search:hover, #insertBtn:hover, #excelBtn:hover, #cancelBtn:hover {
	background: #ffd77a;
	color:#333;
	transition:all 1s;
	font-weight: 700;
}

#insertBtn {
	background: #006DF0;
	margin-top: 10px;
	margin-right: -15px;
}

#cancelBtn{
	display: none;
	width: 100px;
	background: #ddd;
	margin-top: 10px;
}

#excelBtn {
	background: #006DF0;
	margin-top: 10px;
}

#searchCondition {
	height: 40px;
	border: 1px solid #ddd;
	border-radius: 5px;
	padding-left: 10px;
}

.custom-datatable-overright table tbody tr.none-tr td:hover {
	background: #fff!imporant;
}

.singleline-ellipsis {
	width: 423.86px;
	overflow:hidden; 
	text-overflow:ellipsis; 
		white-space:nowrap; 
		cursor: pointer;
}

#btn-Zone{
    margin-left: auto;
/* 	position: absolute; */
	display: flex;
	justify-content: space-evenly;
	z-index: 5;
	right: 73px;
	bottom: 50px;
	width: 483px;
}

.excelUpload{
	border: 1px solid #ddd;
	border-radius: 0px;
	border-bottom-left-radius: 5px;
	border-top-left-radius: 5px;
	border-right: 0px;
}

#fileBtn{
	margin-right: -56px;
	border: none;
	border-radius: 0;
	border-bottom-right-radius: 5px;
	border-top-right-radius: 5px;
	padding: 5px 7px;
	font-weight: 600;
	background: #666;
	color: #fff;
}

#excelContainer{
/* 	display: none; */
	margin-top:10px;
	display: flex;
	justify-content: space-evenly;
/* 	z-index: 5; */
	right: 73px;
	bottom: 50px;
	width: 220px;
	height: 40px;
}

#upload{
	padding: 9px;
}	
</style>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script type="text/javascript">
//전역 변수
var currentPage = "${param.currentPage}";
var keyword = "";
var schulCode = "${param.schulCode}";

function fn_search(page) {
    var keyword = $("#keyword").val();
    
    var data = {
        "schulCode": schulCode,
        "currentPage": page, // page 매개변수 사용
        "keyword": keyword
    }


    $.ajax({
        url: "/employee/employeeListAjax",
        type: "post",
        data: JSON.stringify(data),
        contentType: "application/json;charset=utf-8",
        dataType: "json",
        beforeSend: function(xhr) {
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
        },
        success: function(result) {

            if (result.total == 0) {
                $("#keyword").val('');

                var str = "<tr>";
                str += "<td colspan='7' style='text-align: center;font-size: 2.0rem;'>" + keyword + "에 대한 검색 결과가 없습니다</td>";
                str += "</tr>";

                $("#employeeBody").html(str);
            } else {
                var str = ""; // 결과를 누적하기 위해 빈 문자열로 초기화

                $.each(result.content, function(idx, schulVO) {
                    $.each(schulVO.schulPsitnMberVOList, function(idx2, schulPsitnMberVO) {
                    	<sec:authorize access = "hasAnyRole('A01000','A14001','A14003')" >
                        	str += "<tr onclick='location.href=\"/employee/employeeDetail?schulCode=" + schulPsitnMberVO.schulCode + "&mberId=" + schulPsitnMberVO.mberId + "\"' style='cursor: pointer;'>";
                        </sec:authorize>
                        
                    	<sec:authorize access = "hasAnyRole('A01001','A01003','A14002','A14004','A14005')" >
                        	str += "<tr>";
                        </sec:authorize>
                        
                        str += "<td>" + schulPsitnMberVO.rnum + "</td>";
                        str += "<td>" + schulPsitnMberVO.mberId + "</td>";
                        str += "<td>" + schulPsitnMberVO.memberVO.mberNm + "</td>";
                        str += "<td>" + schulPsitnMberVO.memberVO.moblphonNo + "</td>";
                        str += "<td>" + schulPsitnMberVO.memberVO.mberEmail + "</td>";
                        str += "<td>" + schulPsitnMberVO.cmmnEmpClsf + "</td>";
                        str += "<td>" + schulPsitnMberVO.cmmnSchulPsitnSttus + "</td>";
                        str += "</tr>";
                    });
                });

                $("#employeeBody").html(str);
            }

            $("#divPaging").html(result.pagingArea);
        },
        error: function(xhr, status, error) {
            console.error(status, error);
        }
    });
}

function resultSAlert(result, actTitle, reloadPage) {
	let res = "성공";
	let icon = "success";
	
	if (result != 2) { res = "실패"; icon = "error"; }
	
	Swal.fire({
      title: actTitle + " " + res + '하였습니다.',
      text: reloadPage,
      icon: icon
	}).then(result => { location.href = "/employee/employeeList?schulCode="+schulCode; });
}

$(function(){
	fn_search(1);
	
	
	//input태그에서 엔터시 검색버튼누르기
	var input = $("#keyword");

	  input.on("keypress", function(event) {
	      if (event.key === "Enter") {
	          event.preventDefault();
	          $("#search").click();
	      }
	  });

	// 교직원 검색
	$("#search").on("click",function(){
		fn_search(1);
	});
	
	//교직원 추가
	$("#insertBtn").on("click",function(){
		location.href="/employee/employeeCreate?schulCode="+schulCode
	});
	
	//파일올리기 버튼보이기
	$("#excelBtn").on("click",function(){
		$("#excelBtn").css("display","none");
		$("#cancelBtn").css("display","block");
		$("#excelContainer").css("display","flex");
	});
	
	//파일올리기 버튼없애기
	$("#cancelBtn").on("click",function(){
		$("#excelBtn").css("display","block");
		$("#cancelBtn").css("display","none");
		$("#excelContainer").css("display","none");
	});
	
	//엑셀로 등록
	$("#fileBtn").on("click",function(){
		//직원 등록 완료의 수
		var ajaxCount = 0;
		
		//vo의 수
		var voCount = 0;
		
		var fm = document.empFrm;
		var fnm = fm.upload;
		var filePath = fnm.value;
		var fileBtnChk = true;
		
		if(filePath==null || filePath == ''){
			fileBtnChk = false;
		}
		
		if(!fileBtnChk){
			alertError("파일을 선택하고 눌러주세요!");
			return;
		}
		
		if(filePath.substr(filePath.length - 4) == 'xlsx' || filePath == null || filePath == ''){
			var excelFrm = new FormData($("#empFrm")[0]);
			
			/* 엑셀 ajax 시작 */
			$.ajax({
				url : "/employee/excelResgistration",
				processData:false,
				contentType:false,
				data:excelFrm,
				dataType:"text",
				type:"post",
				beforeSend:function(xhr){
					xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
				},
				success:function(result){
					
					//text -> json
					const obj = JSON.parse(result);
					var voCount = obj.length; // vo의 수 설정
					
					
					//JSON.stringify : json->text
					
					$.each(obj,function(idx,vo){
						//{"0":"7.58109211004E11","1":"java","2":"박민수","3":"000000-0000003","4":"010-3698-1472",
						//"5":"park@example.com","6":"24680.0","7":"서울시 강북구","8":"재직","9":"교사"}
						//ex) vo[0] : 7.58109211004E11 / vo[6] : 24680.0
						let mberId = vo[0];
						let password = vo[1];
						let mberNm = vo[2];
						let ihidnum= vo[3];
						let moblphonNo = vo[4];
						let mberEmail = vo[5];
						let zip = vo[6];
						let mberAdres = vo[7];
						let cmmnSchulPsitnSttus = vo[8];
						let cmmnEmpClsf = vo[9];
						let mberImage = "";
						let cmmnDetailCode = "ROLE_A01002";
						
						if(cmmnSchulPsitnSttus=="재직"){
							cmmnSchulPsitnSttus = "A02104"
						}else if(cmmnSchulPsitnSttus=="휴직"){
							cmmnSchulPsitnSttus = "A02105"
						}else if(cmmnSchulPsitnSttus=="이직"){
							cmmnSchulPsitnSttus = "A02106"
						}else{// 퇴직
							cmmnSchulPsitnSttus = "A02109"
						}
						
						if(cmmnEmpClsf=="교장"){
							cmmnEmpClsf = "ROLE_A14001"
						}else if(cmmnEmpClsf=="교사"){
							cmmnEmpClsf = "ROLE_A14002"
						}else if(cmmnEmpClsf=="행정"){
							cmmnEmpClsf = "ROLE_A14003"
						}else if(cmmnEmpClsf=="영양사"){
							cmmnEmpClsf = "ROLE_A14004"
						}else{// 교감
							cmmnEmpClsf = "ROLE_A14005"
						}
						
						var frm = new FormData();
						frm.append("schulCode",schulCode);
						frm.append("mberId",mberId);
						frm.append("password",password);
						frm.append("mberNm",mberNm);
						frm.append("ihidnum",ihidnum);
						frm.append("moblphonNo",moblphonNo);
						frm.append("mberEmail",mberEmail);
						frm.append("zip",zip);
						frm.append("mberAdres",mberAdres);
						frm.append("mberImage",mberImage);
						frm.append("cmmnSchulPsitnSttus",cmmnSchulPsitnSttus);
						frm.append("cmmnEmpClsf",cmmnEmpClsf);
						frm.append("cmmnDetailCode",cmmnDetailCode);
						
						/* 직원 등록 ajax 시작 */
						$.ajax({
							url:"/employee/employeeCreateAjax",
							processData:false,
							contentType:false,
							data:frm,
							type:"post",
							dataType:"text",
							beforeSend:function(xhr){
								xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
							},
							success:function(result){
								ajaxCount++; // Ajax 요청이 완료되면 증가
								
 								if (ajaxCount === voCount) {
 									 resultSAlert(2, '교직원 등록을', '교직원 목록으로 이동합니다.');
                                }
							}
						});
						/* 직원 등록 ajax 끝 */
					});
				}
			});
			/* 엑셀 ajax 끝 */
		}
	});
})
</script>

<div id="empContainer">
	<div class="sparkline13-list">
		<h3>
			<img src="/resources/images/employee/emp1.png" style="width:50px; display:inline-block; vertical-align:middel;">
				교직원 목록
			<img src="/resources/images/employee/emp2.png" style="width:50px; display:inline-block; vertical-align:middel;">		
		</h3>
		<div class="sparkline13-graph">
			<div class="datatable-dashv1-list custom-datatable-overright">
				<div class="bootstrap-table" style="position:relative;">
				<!-- 검색 조건 시작 -->
					<div class="fixed-table-toolbar" style="margin-bottom: 70px;">
						<div style="text-align: right; right: 0; top:50px; width: 1572px;">
							<input type="text" placeholder="Search..." class="searchForm"  id="keyword" name="keyword">
							<button type="button" id="search">검색</button>
						</div>
				<!-- 검색 조건 끝 -->
				<!-- 등록 버튼 시작 -->
				<sec:authorize access = "hasRole('A14003')" >
					<div class="col-md-10 text-right pull-right">
						<div id="btn-Zone">
							<!-- 엑셀파일 업로드  -->
							<div id="excelContainer">
								<div class="excelUpload">
								<form id="empFrm" name="empFrm">
									<input type="file"  accept=".xlsx" id="upload" name="upload" style="width: 195px;"/>
								</form>
								</div>
								<button type="button" id="fileBtn">엑셀로 등록</button>
							</div>
							<!-- 엑셀파일 업로드  끝 -->
							<!-- text-right를 사용하여 오른쪽 정렬 -->
							<button type="button" id="insertBtn" class="btn btn-custon-rounded-two btn-primary">교직원 추가</button>
						</div>
					</div>
				</sec:authorize>
				<!-- 등록 버튼 끝 -->
					</div>
					<div class="fixed-table-container" id="fixed-table-container" style="padding-bottom: 0px;">
						<div class="fixed-table-body">
							<table id="table" data-toggle="table" data-pagination="true"
								data-search="true" data-show-columns="true"
								data-show-pagination-switch="true" data-show-refresh="true"
								data-key-events="true" data-show-toggle="true"
								data-resizable="true" data-cookie="true"
								data-cookie-id-table="saveId" data-show-export="true"
								data-click-to-select="true" data-toolbar="#toolbar"
								class="table table-hover JColResizer">
								<thead>
									<tr style="font-size:1rem;">
										<th style="width: 10%;">
											<div class="th-inner ">번호</div>
											<div class="fht-cell"></div>
										</th>
										<th style="width: 10%;">
											<div class="th-inner ">교직원 아이디</div>
											<div class="fht-cell"></div>
										</th>
										<th style="width: 10%;">
											<div class="th-inner ">교직원 이름</div>
											<div class="fht-cell" ></div>
										</th>
										<th style="width: 20%;">
											<div class="th-inner ">교직원 전화번호</div>
											<div class="fht-cell"></div>
										</th>
										<th style="width: 30%;">
											<div class="th-inner ">교직원 이메일</div>
											<div class="fht-cell"></div>
										</th>
										<th style="width: 10%;">
											<div class="th-inner ">교직원 구분</div>
											<div class="fht-cell"></div>
										</th>
										<th style="width: 10%;">
											<div class="th-inner ">교직원 상태</div>
											<div class="fht-cell"></div>
										</th>
									</tr>
								</thead>
								<tbody id="employeeBody" style="vertical-align: middle;">
							
								</tbody>
							</table>
						</div>
						<!-- 페이징 -->
						<div class="custom-pagination" id="divPaging"></div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>