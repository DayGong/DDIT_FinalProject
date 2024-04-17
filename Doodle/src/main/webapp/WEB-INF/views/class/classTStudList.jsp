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

.btnZone{
	background: #006DF0;
    height: 40px;
    border: none;
    padding: 10px 15px;
    border-radius: 10px;
    font-family: 'Pretendard' !important;
    font-weight: 600;
    color: #fff;
}

</style>
<script>
	const header = "${_csrf.headerName}";
	const token = "${_csrf.token}";
	var clasCode = "${clasCode}";
	var schulCode = "${schulCode}";
	var currentPage = "${param.currentPage}";
	var size = 10;					// 한 번에 불러오는 데이터 갯수
//var currentPage = "${param.currentPage}";
	window.onload = function() {
		
		//학생 구성원 목록 불러오는 Ajax(classStudListAjax) 시작//
		const classStudListAjax = function(){
			if(currentPage == "") currentPage = "1"; 
			let data = {
				"schulCode":schulCode,
				"clasCode":clasCode,
				"currentPage" : currentPage,	// 초기 페이지
				"size" : size	
				}
			console.log("data",data);

			$.ajax({
					url: "/class/classTStudListAjax",
					contentType:"application/json;charset=utf-8",
					data:JSON.stringify(data),
					type : "post",
					dataType:"json",
					beforeSend:function(xhr){
							xhr.setRequestHeader(header,token);
						},
					success:function(result){				
						const classStudMemListBody = document.querySelector("#classStudMemListBody");
						let html = "";
						$.each(result.content, function(idx, clasStdntVO){
							html += `<tr> 
									<td><input type="checkbox" class="individual-checkbox" onchange="updateSelectAll()" value="\${clasStdntVO.mberId}" style="display:none;" /></td>
									<td>\${clasStdntVO.rnum}</td>
									<td href="#PrimaryModalhdbgcl" data-toggle="modal" data-target="#PrimaryModalhdbgcl" onclick=stdntDetail('\${clasStdntVO.mberId}') onmouseover="this.style.cursor='pointer'">\${clasStdntVO.mberNm}</td>
									<td id="classInNoCell" data-mber-id="\${clasStdntVO.mberId}">\${clasStdntVO.clasInNo}</td>
									<td id="classclsfNmCell" data-mber-id="\${clasStdntVO.mberId}">\${clasStdntVO.cmmnStdntClsfNm}`;
									if(clasStdntVO.cmmnStdntClsf ==="A19001"){
										html += `<img src="/resources/images/classRoom/clsf1.png" style="width:20px; display:inline-block; vertical-align:middle;">`;
									}else if(clasStdntVO.cmmnStdntClsf ==="A19002"){
										html += `<img src="/resources/images/classRoom/clsf2.png" style="width:20px; display:inline-block; vertical-align:middle;">`;
									}
									html +=`</td><td id="classSttusCell" >\${clasStdntVO.cmmnClasPsitnSttusNm}</td>
									<td>\${dateFormat(clasStdntVO.clasStdntJoinDate)}</td>
									</tr>`;
						}); //반복문 끝
						classStudMemListBody.innerHTML = html;
						document.getElementById("divPaging").innerHTML = result.pagingArea;
					}
				}); //학생 구성원 목록 불러오는 Ajax(classStudListAjax) 끝//
		}
		classStudListAjax();		//학생 목록 불러오기

		// 체크된 체크박스의 ID 값을 가져오는 함수
		function getSelectedIds() {
				var mberIds = [];
				// 모든 체크박스 요소에 대해 반복
				var checkboxes = document.querySelectorAll(".individual-checkbox:checked");
				console.log("체킁:",checkboxes);
				for(let i=0; i< checkboxes.length; i++){
					mberIds.push(checkboxes[i].value);
				}
				return mberIds;
			}

		// 초대버튼 클릭 시 체크박스 보이기
		document.getElementById("sendMailChkBtn").addEventListener("click", function() {
				// 모든 숨겨진 체크박스 요소를 가져옴
				document.getElementById("sendMailChkBtn").style.display="none";											 //초대하기 버튼 가리기
				document.getElementById("sendMailBtn").style.display="inline";											 //전송버튼 보이기
				document.getElementById("sendCancleBtn").style.display="inline";										 //취소하기 버튼 보이기
				document.getElementById("selectAll").style.display = "inline";											 //tr요소 보이기
				document.getElementById("updateBtn").style.display="none";											    //수정하기 버튼 가리기
				document.querySelectorAll('.individual-checkbox').forEach(checkbox => checkbox.style.display = "block"); //td요소 보이기
			});
		
		// 초대버튼 -> 취소버튼
		document.getElementById("sendCancleBtn").addEventListener("click", function() {
			document.getElementById("sendMailBtn").style.display="none";											 //전송버튼 가리기
			document.getElementById("sendCancleBtn").style.display="none";											 //취소하기 버튼 가리기
			document.getElementById("sendMailChkBtn").style.display="inline";										 //초대하기 버튼 보이기
			document.getElementById("updateBtn").style.display="inline";											     //수정하기 버튼 보이기
			document.getElementById("selectAll").style.display = "none";											 //tr요소 가리기
			document.querySelectorAll('.individual-checkbox').forEach(checkbox => checkbox.style.display = "none"); //td요소 가리기
		});
			

		// 초대코드 메일 보내기! (버튼)
		document.getElementById("sendMailBtn").addEventListener("click", function() {
				var mberIds = getSelectedIds();

				if(mberIds == "" || mberIds == null || !mberIds){
					Swal.fire({
						icon : "warning",
						title: "초대할 학부모의 자녀를 선택해주세요."
					});
					return;
				}
				let data = {
					"mberIds":mberIds,
					"clasCode":clasCode
					}
					console.log("data::",data);

				//초대코드 보내기 Ajax 시작
				$.ajax({
					type:"post",
					url:"/class/classMailSend",
					data:JSON.stringify(data),
					contentType:"application/json;charset=utf-8",
					dataType:"text",
					beforeSend:function(xhr){
								xhr.setRequestHeader(header,token);
							},
					success:function(result){
						console.log("result",result);
						Swal.fire({
						icon : "success",
						title: "전송이 완료됐습니다."
						});
					}			
				});//초대코드 보내기 Ajax 끝
				document.getElementById("sendMailChkBtn").style.display="inline";		//초대하기 버튼 보이기
				document.getElementById("updateBtn").style.display="inline";			//수정하기 버튼 보이기
				document.getElementById("sendMailBtn").style.display="none";			//전송버튼 가리기
				document.getElementById("sendCancleBtn").style.display="none";			//취소하기 버튼 가리기
				document.getElementById("selectAll").style.display = "none";			//tr요소 가리기
				document.querySelectorAll('.individual-checkbox').forEach(checkbox => checkbox.style.display = "none"); //td요소 가리기
			}); //초대코드 메일보내기 끝


		// 수정 버튼 시작
		document.getElementById("updateBtn").addEventListener("click", function() {

			 // 수정모드에서 모달제거 - td 요소의 속성 제거
			 document.querySelectorAll("td").forEach(function(td) {
				td.removeAttribute("data-toggle");
				td.removeAttribute("onmouseover");
			});

			document.getElementById("updateOKBtn").style.display="inline";		//수정완료 버튼 보이기
			document.getElementById("updateCancleBtn").style.display="inline";	//수정취소 버튼 보이기
			document.getElementById("sendMailChkBtn").style.display="none";		//초대하기 버튼 가리기
			document.getElementById("updateBtn").style.display="none";			//수정하기 버튼 가리기
					
			 //학급번호 변경
			document.querySelectorAll("#classInNoCell").forEach(function(classInNoCell) {
				const classInNoArray = [];
				// 기존 텍스트 가져오기
				const classInNoText = classInNoCell.textContent.trim();
				classInNoArray.push(classInNoText);
				// input 요소 생성
				const input = document.createElement("input");
				input.type = "number";
				input.name = "clasInNo";
				input.value = classInNoText; // 기존 텍스트를 value로 설정

				// 기존 텍스트를 input 요소로 대체
				classInNoCell.innerHTML = ''; // 기존 콘텐츠 지우기
				classInNoCell.appendChild(input);
			});//학급번호 변경 끝
 			
			//임원 변경
			const classclsfNmSelect = document.createElement("select");
			document.querySelectorAll("#classclsfNmCell").forEach(function(classclsfNmCell) {
				// 기존 텍스트 가져오기
				const cmmnStdntClsfNm = classclsfNmCell.textContent.trim();
				
				// classclsfNmSelect 복제
				const selectClone = classclsfNmSelect.cloneNode(true);

				// 텍스트를 옵션으로 추가
                // DB에서 읽어온다면 추후 변경할 것;
				let optList = ["학생","반장","부반장"];

				for(let i=0; i<optList.length; i++){
					const textOption = document.createElement("option");
					textOption.value = optList[i];					
					textOption.text = optList[i];
					selectClone.appendChild(textOption);
				}
				let cmmnStdntClasNm1 = "";

				// 선택된 값 설정
				selectClone.value = cmmnStdntClsfNm;

				console.log("cmmnStdntClasNm1!",cmmnStdntClasNm1);

				// 셀 업데이트
				classclsfNmCell.textContent = ''; // 기존 콘텐츠 지우기
				selectClone.name = "cmmnStdntClsfNm";
				classclsfNmCell.appendChild(selectClone);
			});//임원변경 끝
			
			//상태변경
			const classSttusSelect = document.createElement("select");	//select요소 생성
			document.querySelectorAll("#classSttusCell").forEach(function(classSttusCell) {

				const classSttusNm = classSttusCell.textContent.trim(); // 기존 텍스트 가져오기
				
				const selectClone = classSttusSelect.cloneNode(true); // classclsfNmSelect 복제
				
				// 옵션으로 사용할 목록
                // DB에서 읽어온다면 추후 변경할 것;
				let optList = ["활동", "정지"];

				for(let i=0; i<optList.length; i++){
					const textOption = document.createElement("option");
					textOption.value = optList[i];					
					textOption.text = optList[i];
					selectClone.appendChild(textOption);
				}

				// 선택된 값 설정
				selectClone.value = classSttusNm;
				selectClone.name = "cmmnClasPsitnSttusNm";

				classSttusCell.textContent = ''; // 기존 td요소 내용 비우기
				classSttusCell.appendChild(selectClone); //새로운 요소 td에 추가
			});//상태변경 끝

		});//수정버튼 끝

		//수정완료 버튼 시작
		document.getElementById("updateOKBtn").addEventListener("click", function() {

			const updatedStudentInfo = []; // 변경된 학생 정보를 저장할 배열
			
			let formData = new FormData();
			
			formData.append("schulCode",schulCode);
			formData.append("clasCode",clasCode);

			// 학급번호 변경
			document.querySelectorAll("#classInNoCell input").forEach(function(input) {
				const mberId = input.parentElement.dataset.mberId;
				const newClassInNo = input.value.trim();
				updatedStudentInfo.push({ mberId: mberId, classInNo: newClassInNo });
				formData.append("mberId",mberId);
				formData.append("clasInNo",newClassInNo)
			});

			// 임원 변경
			document.querySelectorAll("#classclsfNmCell select").forEach(function(select) {
				const mberId = select.parentElement.dataset.mberId;
				const newClassclsfNm = select.value.trim();
				let cmmnStdntClasNm = "";
				if(newClassclsfNm === "반장"){
					cmmnStdntClasNm = "A19001";
				}else if(newClassclsfNm == "부반장"){
					cmmnStdntClasNm = "A19002";
				}else if(newClassclsfNm == "학생"){
					cmmnStdntClasNm = "A19003";
				}
				updatedStudentInfo.push({ mberId: mberId, classclsfNm: cmmnStdntClasNm });
				formData.append("cmmnStdntClsfNm",cmmnStdntClasNm);
			});

			// 상태 변경
			document.querySelectorAll("#classSttusCell select").forEach(function(select) {
				const mberId = select.parentElement.dataset.mberId;
				const newClassSttusNm = select.value.trim();
				let classSttusNm = "";
				if(newClassSttusNm === "활동"){
					classSttusNm = "A03101";
				}else if(newClassSttusNm === "정지"){
					classSttusNm = "A03102";
				}
				updatedStudentInfo.push({ mberId: mberId, classSttusNm: classSttusNm });
				formData.append("cmmnClasPsitnSttusNm",classSttusNm);
			});


			console.log(updatedStudentInfo); // 변경된 학생 정보 배열 출력 또는 다른 작업 수행
			//구성원(학생) 수정 Ajax 시작
			$.ajax({
				url:"/class/classStudUpdateAjax",
				processData:false,
				contentType:false,
				data:formData,
				type:"post",
				dataType:"json",
				beforeSend:function(xhr){
					xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
				},
				success:function(result){
					console.log("result : ", result);
					window.location.href = `/class/classTStudList`;
				}
			});//구성원(학생) 수정 Ajax 끝
		});//수정완료 버튼 끝
	}//window.onload끝


//수정 취소 버튼 시작
function updateCancleBtn(){
	window.location.href = `/class/classTStudList`;
}
//수정 취소 버튼 끝

	

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
    

//타임스탬프 값 바꾸기
function dateFormat(date){
	   var selectDate = new Date(date);
	   var d = selectDate.getDate();
	   var m = selectDate.getMonth() + 1;
	   var y = selectDate.getFullYear();
	   
	   if(m < 10) m = "0" + m;
	   if(d < 10) d = "0" + d;
	   
	   return y + "-" + m + "-" + d; 
	} 

// 체크박스 전체 선택
function selectAll(selectAll) {
  const checkboxes = document.querySelectorAll('.individual-checkbox');	//개별 체크박스 요소 모두 선택
  checkboxes.forEach(checkbox => {										// 선택된걸로 변경
    checkbox.checked = selectAll.checked;
  });
}

// 체크박스 개별 선택
function updateSelectAll() {
  const checkboxes = document.querySelectorAll('.individual-checkbox'); //개별 체크박스 요소 모두 선택
  const selectAllCheckbox = document.getElementById('selectAll');		//전체 선택 체크박스 요소 가져오기
  
  let allChecked = true;												//체크박스 선택되었나 확인 초기값true
  checkboxes.forEach(checkbox => {										//모든 개별 체크박스 상태 확인
    if (!checkbox.checked) {											//선택 안 한 체크박스 상태 false로 변경
      allChecked = false;
    }
  });
  
  selectAllCheckbox.checked = allChecked;	//상태 업데이트
}



</script>


<div class="sparkline8-list">
	<div class="sparkline8-hd">
		<div class="main-sparkline8-hd">
			<h3>
				<img src="/resources/images/classRoom/stdent1.png" style="width:50px; display:inline-block; vertical-align:middel;">
					학생 목록
				<img src="/resources/images/classRoom/stdent2.png" style="width:50px; display:inline-block; vertical-align:middel;">
			</h3>
			
		</div>
	</div>
	<div class="row">
		<!--버튼 시작-->
		<div class="col-md-10">
			<button type="button" id="sendMailChkBtn" class="btn btn-custon-rounded-two btn-primary btnZone">초대하기</button>
			<button type="button" id="sendMailBtn" class="btn btn-custon-rounded-two btn-primary btnZone" style="display:none;">메일발송</button>
			<button type="button" id="sendCancleBtn" class="btn btn-custon-rounded-two btn-primary btnZone" style="display:none;">취소</button>
			<button type="button" id="updateBtn" class="btn btn-custon-rounded-two btn-primary btnZone">수정</button>
			<button type="button" id="updateOKBtn" class="btn btn-custon-rounded-two btn-primary btnZone" style="display:none;">저장</button>
			<button type="button" id="updateCancleBtn" onclick="updateCancleBtn()" class="btn btn-custon-rounded-two btn-primary btnZone" style="display:none;">취소</button>
		</div>
		<!--버튼 끝-->
	</div>
	<div class="sparkline8-graph">
		<div class="static-table-list">
			<table class="table">
				<thead>
					<tr>
						<th><input type="checkbox" id="selectAll" onclick="selectAll(this)" style="display: none;"/></th>
						<th>순번</th>
						<th>이름</th>
						<th>학급번호</th>
						<th>임원</th>
						<th>상태</th>
						<th>가입일</th>
						<th></th>
					</tr>
				</thead>
				<tbody id="classStudMemListBody">
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
<!--상세정보 모달 띄우기 끝 -->