<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
h3{
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

.form-control {
	text-align: center;
}
</style>
<script>
	const header = "${_csrf.headerName}";
	const token = "${_csrf.token}";
	//const : 상수형 변수(재선언 불가, 데이터 변경 불가)
	var clasCode = "${clasCode}";
	var schulCode = "${schulCode}";
	var currentPage = "${param.currentPage}";
	var size = 10;
	console.log("clasCode",clasCode);
	console.log("schulCode",schulCode);

	window.onload = function() {
		if(currentPage == "") currentPage = "1"; 
		
		fn_search(1);
		
	}//window.onload끝

    //상세정보 가져오는 Ajax 시작//
function stdntDetail(mberId){
	let data = {
		"mberId":mberId
	}
	console.log("mberId",mberId);
	//회원 정보 가져오는 ajax시작
	$.ajax({
		type:"post",
		url:"/class/classMberDetailAjax",
		data:JSON.stringify(data), //얘를 스트링으로 바꿔서 보내면
		dataType:"json",			//컨트롤러가 보내는값이 json
		contentType:"application/json;charset=utf-8", //받는애한테 형식이 제이슨이라고 알려줘
		beforeSend:function(xhr){
						xhr.setRequestHeader(header,token);
					},
		success:function(result){
			console.log("result", result);

			//상세 정보 모달 출력 시작
			document.querySelector("#studMberImage").src = "/upload/profile/"+result.mberImage;
			document.querySelector("#studMberNm").value = result.mberNm;		//이름
			document.querySelector("#studMberId").value = result.mberId;		//아이디
			document.querySelector("#studMberEmail").value = result.mberEmail;	//이메일
			document.querySelector("#studBirthDate").value = result.birthDate;		//생년월일
			document.querySelector("#studMoblphonNo").value = result.moblphonNo;		//핸드폰번호
			document.querySelector("#studZip").value = result.zip;				//우편번호
			document.querySelector("#studMberAdres").value = result.mberAdres;	//상세주소
		},
		error: function (xhr, status, error) {
			console.log("code: " + xhr.status)
			console.log("message: " + xhr.responseText)
			console.log("error: " + error);
		}

	}) //회원 정보 가져오는 ajax끝
}//상세정보 가져오는 Ajax 끝//


//기본조회
function fn_search(page){
//학부모 구성원 목록 불러오는 Ajax(classParentListAjax) 시작//
const classParentListAjax = function(){
			let data = {
					"clasCode":clasCode,
					"currentPage" : currentPage,	// 초기 페이지
					"size" : size	
				}
			console.log("data2",data);

			$.ajax({
				url: "/class/classTParentListAjax",
				contentType:"application/json;charset=utf-8",
				data:JSON.stringify(data),
				type : "post",
				dataType:"json",
				beforeSend:function(xhr){
						xhr.setRequestHeader(header,token);
					},
				success:function(result){				
					const classPrentMemListBody = document.querySelector("#classPrentMemListBody");
					let html = "";
					$.each(result.content, function(idx, chldrnClasVO){
						html += `<tr> 
								<td>\${chldrnClasVO.rnum}</td>
								<td href="#PrimaryModalhdbgcl" data-toggle="modal" data-target="#PrimaryModalhdbgcl" onclick=stdntDetail('\${chldrnClasVO.mberId}') onmouseover="this.style.cursor='pointer'">\${chldrnClasVO.stdnprntNm}</td>
								<td>\${chldrnClasVO.stdntNm}</td>
								<td>\${chldrnClasVO.cmmnDetailNm}</td>
								</tr>`;
					}); //반복문 끝
					classPrentMemListBody.innerHTML = html;
					document.getElementById("divPaging").innerHTML = result.pagingArea;
					}
				}); 
		}//학부모 구성원 목록 불러오는 Ajax(classParentListAjax) 끝//
		classParentListAjax();		//학부모 목록 불러오기

}
</script>


<div class="sparkline8-list">
	<div class="sparkline8-hd">
		<div class="main-sparkline8-hd">
			<h3>
				<img src="/resources/images/classRoom/parent1.png" style="width:50px; display:inline-block; vertical-align:middel;">
					학부모 목록
				<img src="/resources/images/classRoom/parent2.png" style="width:50px; display:inline-block; vertical-align:middel;">
			</h3>
			
		</div>
	</div>
	<div class="sparkline8-graph">
		<div class="static-table-list">
			<table class="table">
				<thead>
					<tr>
						<th>순번</th>
                        <th>학부모 명</th>
                        <th>학생 명</th>
                        <th>가족관계</th>
					</tr>
				</thead>
				<tbody id="classPrentMemListBody">
			</table>
		</div>
	</div>
	<div class="pagination text-center" style="width:100%;" id="divPaging"></div>
</div>

<!-- 상세정보 모달 띄우기 -->
<div id="PrimaryModalhdbgcl" class="modal modal-edu-general default-popup-PrimaryModal fade in" role="dialog" style="display: none; padding-right: 17px;">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header header-color-modal bg-color-1">
				<h4 class="modal-title">학생 정보</h4>
				<div class="modal-close-area modal-close-df">
					<a class="close" data-dismiss="modal" href="#"><i class="fa fa-close"></i></a>
				</div>
			</div>
			<div class="modal-body">
				<div class="row">
					<div class="col-md-12">
						<div class="form-group">
							<img src="" id="studMberImage" name="studMberImage" style="width: 300px; height: 300px;">
						</div>
					</div>
					<div class="col-md-12">
						<div class="form-group" style="width:50%;float:left;">
							<label for="">이름</label> 
							<input type="text" class="form-control is-valid" id="studMberNm" name="studMberNm" readonly />
						</div>
						<div class="form-group" style="width:50%;float:left;">
							<label for="">아이디</label> 
							<input type="text" class="form-control is-valid" id="studMberId" name="studMberId" readonly />
						</div>
					</div>
					<div class="col-md-12">
						<div class="form-group" style="width:50%;float:left;">
							<label for="">이메일</label> 
							<input type="text" class="form-control is-valid" id="studMberEmail" name="studMberEmail" readonly />
						</div>
						<div class="form-group" style="width:50%;float:left;">
							<label for="">생년월일</label> 
							<input type="text" class="form-control is-valid" id="studBirthDate" name="studBirthDate" readonly />
						</div>
					</div>
					<div class="col-md-12">
						<div class="form-group" style="width:50%;float:left;">
							<label for="">전화번호</label> 
							<input type="text" class="form-control is-valid" id="studMoblphonNo" name="studMoblphonNo" readonly />
						</div>
						<div class="form-group" style="width:50%;float:left;">                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
							<label for="">우편번호</label> 
							<input type="text" class="form-control is-valid" id="studZip" name="studZip" readonly />
						</div>
					</div>
					<div class="col-md-12">
						<div class="form-group">                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
							<label for="">상세주소</label> 
							<input type="text" class="form-control is-valid" id="studMberAdres" name="studMberAdres" readonly />
						</div>
					</div>
						<div class="modal-footer">
							<a data-dismiss="modal" href="#">닫기</a>
						</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- 상세정보 모달 띄우기 끝 -->