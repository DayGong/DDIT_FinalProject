<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- jQuery -->
<script type="text/javascript"
	src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<!-- iamport.payment.js -->
<script type="text/javascript"
	src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>

<script type="text/javascript">
//beforeSend 전역변수 처리
const header="${_csrf.headerName}";
const token ="${_csrf.token}";

window.onload = function(){
	console.log("window.onload 실행되었습니다~");
	// 목록 불러오기
	loadAfterSchoolList();

	//날짜 포맷 생성  함수
	function dateFormat(date) {
		let dateFormat2 = date.getFullYear() +
		'-' + ( (date.getMonth()+1) < 9 ? "0" + (date.getMonth()+1) : (date.getMonth()+1) )+
		'-' + ( (date.getDate()) < 9 ? "0" + (date.getDate()) : (date.getDate()) );
		return dateFormat2;
	}
	
	// 카카오페이 결제
	requestPay = function(){
		var IMP = window.IMP; 
        IMP.init("imp67011510");	// 테스트용 가맹점ID(변경 X)
      
        /* 
       	주문번호 = 같은 값은 사용 불가(결제 할 때마다 새로운 값 필요)
		주문번호 만들 때 "코드" + 현재 시간 등으로 만들기 위한 makemerchantUid
		*/
        var today = new Date();   
        var hours = today.getHours(); // 시
        var minutes = today.getMinutes();  // 분
        var seconds = today.getSeconds();  // 초
        var milliseconds = today.getMilliseconds();
        var makeMerchantUid = hours +  minutes + seconds + milliseconds;
        
        // 데이터 가지고 오기
        let aschaCode = document.querySelector("#aschaCode").innerText; // 방과후코드
        let aschaNm = document.querySelector("#aschaNm").innerText;		// 방과후명
        let aschaAtnlcCt = document.querySelector("#aschaAtnlcCt").innerText;	// 방과후 금액
        let schoolNm = document.querySelector("#schoolNm").innerText;	// 학교이름
        let schoolAdres = document.querySelector("#schooolAdres").innerText;	// 학교 주소
        let schoolTelNo = document.querySelector("#schoolTelNo").innerText;		// 학교 연락처

        IMP.request_pay({
            pg : 'kakaopay', 						// kcp: 미리 등록한 카드로 결제, kakaopay
            pay_method : 'card',
            merchant_uid: aschaCode + makeMerchantUid,  // 주문번호
            name : aschaNm,								// 방과후명
            amount : aschaAtnlcCt,						// 가격(방과후 금액)
            buyer_name : schoolNm, 						// 판매자명(학교이름)
            buyer_tel : schoolTelNo,					// 판매자 전화번호(학교연락처)
            buyer_addr : schoolAdres					// 판매 주소(학교 주소)
           
        }, function (rsp) {
            if (rsp.success) {
                  // 서버 결제 API 성공시 로직
                  console.log(rsp);

                  let paymentInfo =
               	  {
                		"imp_uid" : rsp.imp_uid, 	// 주문번호
      					"amount" : rsp.paid_amount,		// 결제 금액
      					"payDate" :today,				// 결제 날짜
      					"aschaCode" : aschaCode,		// 방과후 코드
      					"mberId" : "${USER_INFO.mberId}"				// 결제자 아이디
               	  };
                 
                  console.log("paymentInfo : ",paymentInfo);
                  afterSchoolLecture(paymentInfo);
            } else {
            	alert(`결제에 실패하였습니다. 에러 내용: ${rsp.error_msg}`);
            }
        });	
	
	}
	
	// 카카오 페이 API로 결제 진행 후 수강정보테이블에 정보 insert
	afterSchoolLecture = function(paymentInfo) 
	{
		// 환불받을 계좌번호를 입력하기
		(async () => {
		    const { value: Acnut } = await Swal.fire({
		        title: '환불받을 계좌번호를 입력하세요.',
		        text: '환불시 해당 계좌번호로 입금됩니다.',
		        input: 'number',
		        inputPlaceholder: '계좌번호',
		        html: `
	                <a href="#" id="btnAuto" style="background: white; border:white;">
		        		<i class="fa fa-pencil-square-o" aria-hidden="true" style="height:25px; width:25px; margin:5px; margin: 20px 10px 0 10px;"></i>
		    		</a>
	            `,
		    });

// 		    document.querySelector('#btnAuto').addEventListener('click', function(event) {
// 		        event.preventDefault(); // 기본 동작 방지
// 		        // Swal input 필드에 값 설정
// 		        $('.swal2-input').val('138247842620');
// 		    });
		    
		    // 이후 처리되는 내용.
		    if (Acnut) {
		    	let data =
				{
					"atnlcReqstCode" : paymentInfo.imp_uid,
					"atnlcSetleAmount" : paymentInfo.amount,
					"atnlcSetleDt" : paymentInfo.payDate,
					"atnlcRefndAcnut" : Acnut,		// 환불받은 계좌번호
					"cmmnDetailCode" : "A10002",
					"aschaCode" : paymentInfo.aschaCode,
					"schulCode" : "${SCHOOL_INFO.schulCode}",
					"stdntId" : "${CLASS_STD_INFO.mberId}",
					"stdnprntId" : "${USER_INFO.mberId}"
				};
				console.log("data : ", data);
				
				$.ajax
				({
					url: "/afterSchool/afterSchoolPayment",
					contentType : "application/json; charset = utf-8",
					data: JSON.stringify(data),
					type: "post",
					dataType: "json",
					beforeSend : function(xhr){
						xhr.setRequestHeader(header,token);
					},
					success: function() 
					{
						Swal.fire(
								"방과후 신청 및 결제가 완료되었습니다.",
								"목록으로 돌아갑니다.",
								"success"
					          )

						console.log("결제 완료됨~!~!");
						$(".modal").modal("hide");
						loadAfterSchoolList();
					},
					
					error: function(xhr) 
					{
						Swal.fire(
								"결제를 실패하였습니다.",
								"다시 시도해주세요.",
								"error"
					          )
						console.log(`신청에 실패하였습니다. 에러 내용: ${xhr.status}`);
					},
					
				}); // ajax끝
		
		    }; // if문 끝
		
		})();// 계좌번호 입력 폼 끝
	};
	
	// 수강신청 버튼 클릭시 이벤트
	document.querySelector("#btnRegist").addEventListener("click", function(){
		Swal.fire({
			   title: '방과후 학교를 신청하시겠습니까?',
			   text: '',
			   icon: 'warning',
			   
			   showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
			   confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
			   cancelButtonColor: '#d33', // cancel 버튼 색깔 지정
			   confirmButtonText: '신청', // confirm 버튼 텍스트 지정
			   cancelButtonText: '취소', // cancel 버튼 텍스트 지정
			   
			   reverseButtons: false, // 버튼 순서 거꾸로
			   
			}).then(result => {
			   // 만약 Promise리턴을 받으면,
			   if (result.isConfirmed) { // 만약 모달창에서 confirm 버튼을 눌렀다면
			   
			      Swal.fire({
					   title: '결제화면으로 이동하시겠습니까?',
					   text: '취소시 미결제 상태로 등록됩니다.',
					   icon: 'warning',
					   
					   showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
					   confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
					   cancelButtonColor: '#d33', // cancel 버튼 색깔 지정
					   confirmButtonText: '이동', // confirm 버튼 텍스트 지정
					   cancelButtonText: '취소', // cancel 버튼 텍스트 지정
					   
					   reverseButtons: false, // 버튼 순서 거꾸로
					   
					}).then((result) => {
					      if (result.isConfirmed) {
					    	  requestPay();
					      }else if(result.dismiss ===Swal.DismissReason.cancel){ // 취소시
					    	  // 취소시 미결제 상태로 등록되는 ajax
					    	  let aschaCode = document.querySelector("#aschaCode").innerText; // 방과후코드
					    	  
					    	  let data =
							  {
					    			"atnlcSetleAmount": "",
					    			"atnlcSetleDt" : "",
									"atnlcRefndAcnut" : "",
									"cmmnDetailCode" : "A10005",
									"aschaCode" : aschaCode,
									"schulCode" : "${SCHOOL_INFO.schulCode}",
									"stdntId" : "${CLASS_STD_INFO.mberId}",
									"stdnprntId" : "${USER_INFO.mberId}"
							   };
					    	  
					    	  $.ajax({
					    		  url:"/afterSchool/afterSchoolPayment",
					    		  contentType:"application/json; charset = utf-8",
					    		  data: JSON.stringify(data),
					    		  type:"post",
					    		  dataType:"json",
					    		  beforeSend : function(xhr){
					    			  xhr.setRequestHeader(header, token);
					    		  },
					    		  success:function(){
							    	  Swal.fire(
								            '방과후 신청이 완료되었습니다.',
								            '추후 결제가 필요합니다.',
								            'info'
									   )
										console.log("신청 완료됨~!~!");
										$(".modal").modal("hide");
										loadAfterSchoolList();
					    		  },
					    		  error: function(xhr) 
									{
										Swal.fire(
												"방과후신청에 실패하였습니다.",
												"다시 시도해주세요.",
												"error"
									          )
										console.log(`신청에 실패하였습니다. 에러 내용: ${xhr.status}`);
									},
		
					    	  });// ajax 끝
					      	} 
					 });
			   } // if문 끝
			});
	}); // 수강신청 버튼클릭 이벤트 끝

	// 모달창 닫기 시작
	$('#btnCancle').on("click",function(){
		$(".modal").modal("hide");
	});
	
	// 상태 선택 조회
	document.querySelector("#cmmnAtnlcNm").addEventListener("change",function(){
		
		var selectStateNm = document.querySelector("#cmmnAtnlcNm").value;
		console.log(selectStateNm);
		// 상태 선택후 방과후 리스트 다시 불러옴.
		loadAfterSchoolList();
	});

	// 방과후 리스트 조회
	function loadAfterSchoolList(){
		let cmmnAtnlcNm =  "";
		let currentPage = "${param.currentPage}";
		if(currentPage =="") currentPage ="1";
// 		keyword = document.getElementById("keyword").value;
		
		
		let data = {
			"currentPage" : currentPage,	
			"keyword" 	  : "",
			"schulCode"	  : "${SCHOOL_INFO.schulCode}",
			"cmmnAtnlcNm" : $("#cmmnAtnlcNm").val()
		};
		
		console.log("data : ",data);
		
		// 방과후 학교 목록
		$.ajax({
			url: "/afterSchool/afterSchoolList",
			contentType : "application/json; charset= utf-8",
			data: JSON.stringify(data),
			type : "post",
			dataType : "json",
			beforeSend : function(xhr){
				xhr.setRequestHeader(header, token);
			},
			success : function(result){
				// result : ArticlePage<AschaVO>
				console.log("result : ", result);
				let str = "";
				let schoolNm = "";
				let total = result.total;
				if(total === 0 ){
					str +=`<tr><td colspan='7'style="text-align: center;">등록된 방과후학교가 없습니다.</td></tr>`; 
				}else{
					
				result.content.forEach(function(aschaVO, idx){
					let aschaAtnlcBgnde = dateFormat(new Date(aschaVO.aschaAtnlcBgnde));
					let aschaAtnlcEndde = dateFormat(new Date(aschaVO.aschaAtnlcEndde));
					// 수용인원 / 총인원 형식으로 출력
					let aschaAceptncPsncpa = aschaVO.totalStdnt + " / " +aschaVO.aschaAceptncPsncpa;
					schoolNm = aschaVO.schulNm;
					schooolAdres = aschaVO.schulAdres;
					schoolTelNo = aschaVO.schulTlphonNo;
				
					str += `
						<tr data-toggle="modal" data-code="code"
							data-aschaCode="\${aschaVO.aschaCode}" data-target="#afterSchoolDetail">
						<td>\${idx+1}</td>
						<td>\${aschaVO.aschaNm}</td>	
						<td>\${aschaAceptncPsncpa}</td>
						<td>\${aschaAtnlcBgnde}</td>
						<td>\${aschaAtnlcEndde}</td>
						<td>\${aschaVO.mberNm}</td>
						<td>`;
						
						if (aschaVO.cmmnAtnlcNm==='신청 진행중'){
							str += `<label style="background: #1F81FF; padding: 5px 8px;
							    border-radius: 10px; color: white; font-size: 15px;">신청 진행중</label>`;
						}else if(aschaVO.cmmnAtnlcNm==='수업 진행중'){
							str += `<label style="background: #ffd34f; padding: 5px 8px;
							    border-radius: 10px; color: white; font-size: 15px;">수업 진행중</label>`;
						}else{
							str += `<label style="background: #df3c3c; padding: 5px 20px;
							    border-radius: 10px; color: white; font-size: 15px;">종강</label>`;
						}							
					str +=`	
						</td>
						</tr>`;
				});
				document.getElementById("divPaging").innerHTML=result.pagingArea;
				document.querySelector("#totalLecture").innerHTML = total;
				document.querySelector("#schoolNm").innerHTML = schoolNm;
				document.querySelector("#schooolAdres").innerHTML = schooolAdres;
				document.querySelector("#schoolTelNo").innerHTML = schoolTelNo;
				
				console.log("str:",str);
				console.log("total : ", total);

				}
				document.querySelector("#listBody").innerHTML = str;
			}
		});
	}
	
	   // 상세보기 모달
		$(document).on("click",'tr[data-code="code"]',function(){
			console.log("상세보기 모달입니다");
			
			var aschaCode = $(this).attr("data-aschaCode");
			console.log("aschaCode :",aschaCode);
			
			let data = {
				"schulCode" : "${SCHOOL_INFO.schulCode}",
				"aschaCode"	: aschaCode
			}
			console.log("data : ",data);
			
			$.ajax({
				url:"/afterSchool/afterSchoolDetail",
				contentType: "application/json; charset=utf-8",
				data: JSON.stringify(data),
				type: "post",
				dataType:"json",
				beforeSend : function(xhr){
					xhr.setRequestHeader(header, token);
				},
				success : function(result){
					console.log("result: ", result);
					
					if(result.length>0){
						let aschaAtnlcBgnde = dateFormat(new Date(result[0].aschaAtnlcBgnde));
						let aschaAtnlcEndde = dateFormat(new Date(result[0].aschaAtnlcEndde));
						// 수강신청한 인원 / 총인원 형식으로 출력
						let aschaAceptncPsncpa = result[0].totalStdnt + "명 / " +result[0].aschaAceptncPsncpa +"명";
						
						// 버튼 클릭시 수용인원이 다 찼을때 수강신청 못하게 하기.
						if(result[0].totalStdnt === result[0].aschaAceptncPsncpa){
							Swal.fire(
									"수강 인원이 마감되었습니다.",
									"다른 강의를 선택하세요.",
									"error"
				          ).then(function(){
						        $("#btnRegist").prop("disabled", true); // 버튼 비활성화  
				          });
						}else{
							$("#btnRegist").prop("disabled", false);// 버튼 활성화
						}
						
						// 종강, 수업진행중일때는 수강신청 버튼 가리기
						if(result[0].cmmnAtnlcNm ==='수업 진행중' || result[0].cmmnAtnlcNm === '종강'){
							$("#btnRegist").prop("disabled", true); // 버튼 비활성화
						}else{
							$("#btnRegist").prop("disabled", false);// 버튼 활성화 
						}
						
						$("#aschaCode").text(result[0].aschaCode);
						$("#aschaNm").text(result[0].aschaNm);
						$("#mberNm").text(result[0].mberNm);
						$("#aschaAtnlcBgnde").text(aschaAtnlcBgnde);
						$("#aschaAtnlcEndde").text(aschaAtnlcEndde);
						$("#aschaAceptncPsncpa").text(aschaAceptncPsncpa);
						$("#aschaDetailCn").text(result[0].aschaDetailCn);
						$("#aschaAtnlcCt").text(result[0].aschaAtnlcCt+"원");
						
						let str = "";
						result.forEach(function(aschaVO, idx){
							aschaVO.aschaWeekPlanVOList.forEach(function(aschaWeekPlanVO,index){
								str +=`
									<tr>
										<td><label>\${aschaWeekPlanVO.aschaWeek}</label></td>
										<td>\${aschaWeekPlanVO.aschaWeekPlanCn}</td>
									</tr>`;
							});
							
						});
						console.log("str : ", str);
						document.querySelector("#weekPlanTable").innerHTML = str;
					}
					
				}
					
			});
		
		});
}

</script>
<style>
.pagination {
	display: inline-flex;
	padding-left: 0;
	margin: 20px 0;
	border-radius: 4px;
}

#AfterSchoolContainer h3 {
	font-size: 2.2rem;
	text-align: center;
	backdrop-filter: blur(4px);
	background-color: rgba(255, 255, 255, 1);
	border-radius: 50px;
	box-shadow: 35px 35px 68px 0px rgba(145, 192, 255, 0.5), inset -8px -8px
		16px 0px rgba(145, 192, 255, 0.6), inset 0px 11px 28px 0px
		rgb(255, 255, 255);
	width: 650px;
	padding-top: 35px;
	padding-bottom: 35px;
	margin: auto;
	margin-bottom: 40px;
}

#AfterSchoolContainer {
	min-height: 790px;
}

#AfterSchoolContainer .custom-pagination {
	max-width: 302px;
	margin: auto;
}

#AfterSchoolContainer .custom-pagination .pagination {
	width: max-content;
}

.searchForm {
	height: 40px;
	border: 1px solid #ddd;
	border-radius: 5px;
	padding: 15px 20px;
}

#searchBtn, #insertBtn {
	background: #333;
	height: 40px;
	border: none;
	padding: 10px 15px;
	border-radius: 10px;
	font-family: 'Pretendard' !important;
	font-weight: 600;
	color: #fff;
}

#searchBtn:hover, #insertBtn:hover {
	background: #ffd77a;
	color: #333;
	transition: all 1s;
	font-weight: 700;
}

#insertBtn {
	background: #006DF0;
}

.searchCondition {
	height: 40px;
	border: 1px solid #ddd;
	border-radius: 5px;
	padding-left: 10px;
}

.custom-datatable-overright table tbody tr.none-tr td:hover {
	background: #fff!imporant;
}

#afterSchoolDetail .modal-dialog table {
    width: 100%;
    border-collapse: collapse;
}

#afterSchoolDetail .modal-dialog table,
#afterSchoolDetail .modal-dialog th,
#afterSchoolDetail .modal-dialog td {
    border: 1px solid lightgray;
    padding: 8px;
    text-align: left;
}

#afterSchoolDetail .form-group {
    margin-top: 20px;
}

#afterSchoolDetail #weekPlanTable {
    width: 100%;
}
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
	margin: 50px;
	margin-bottom: 40px;
}

.divInfo{
	display : inline-flex;
	margin-left: 10px;
    margin-bottom: 5px;
}
.sparkline13-graph {
    float: right;
}
td, th {
	font-size: 16px;
}

</style>

<!-- 방과후학교 목록 검색 -->
<div id="AfterSchoolContainer">
	<div class="container-fluid">
		<div class="row">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="breadcome-list single-page-breadcome">
					<h3>
						<img src="/resources/images/school/aftSchool/aftSchoolIcon1.png"
							style="width: 50px; display: inline-block; vertical-align: middel;">
						<span id="schoolNm"></span> <span>&nbsp;방과후학교</span>
						<img src="/resources/images/school/aftSchool/aftSchoolIcon2.png"
							style="width: 50px; display: inline-block; vertical-align: middel;">
					</h3>
					<div style="display: none;" id="schooolAdres"></div>
					<div style="display: none;" id="schoolTelNo"></div>
					<p>${aschaVO.aschaNm}</p>

					<div class="sparkline13-graph">
						<div class="datatable-dashv1-list custom-datatable-overright">
							<div class="fixed-table-toolbar">
								<div class="pull-right search" style="margin-bottom: 20px;">
									<!-- 검색 셀렉트 -->
									<select class="form-control" id="cmmnAtnlcNm"
										class="searchCondition" style="transform: translate(-200px, 20px);">
										<option value="전체">전체</option>
										<option value="신청 진행중">신청 진행중</option>
										<option value="수업 진행중">수업 진행중</option>
										<option value="종강">종강</option>
									</select>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 방과후학교 목록 검색 끝 -->
	<!-- 방과후학교 목록 -->

	<div class="fixed-table-container" style="padding-bottom: 0px;">
		<div class="divInfo">
			<h4>개설과목 총&nbsp;</h4>
			<h4 id="totalLecture">개설과목</h4>
			<h4>개</h4>
		</div>
		<div class="fixed-table-body">
			<table id="table" class="table table-hover JColResizer" style="padding: 0 30px;">
				<thead>
					<tr style="font-size: 1rem;">
						<th style="width: 5%;" tabindex="0"><div class="th-inner ">번호</div>
							<div class="fht-cell"></div></th>
						<th style="width: 20%;" tabindex="0"><div class="th-inner ">방과후학교
								명</div>
							<div class="fht-cell"></div></th>
						<th style="width: 10%;" tabindex="0"><div class="th-inner ">수용정원(명)</div>
							<div class="fht-cell"></div></th>
						<th style="width: 15%;" tabindex="0"><div class="th-inner ">수강시작일자</div>
							<div class="fht-cell"></div></th>
						<th style="width: 15%;" tabindex="0">
							<div class="th-inner ">수강종료일자</div>
							<div class="fht-cell"></div>
						</th>
						<th style="width: 15%;" tabindex="0">
							<div class="th-inner ">담당선생님</div>
							<div class="fht-cell"></div>
						</th>
						<th style="width: 30%;" tabindex="0">
							<div class="th-inner ">강의상태</div>
							<div class="fht-cell"></div>
						</th>
					</tr>
				</thead>

				<tbody id="listBody">
					<!-- 내용 들어옴 -->
				</tbody>

			</table>
		</div>
	</div>
	<div>
		<div class="pagination text-center" style="width: 100%; transform: translate(350px, -20px);"
			id="divPaging"></div>
	</div>
</div>

<!-- 방과후학교 상세보기 모달 -->
<div id="afterSchoolDetail"
	class="modal modal-edu-general default-popup-PrimaryModal fade in"
	role="dialog" style="display: none;">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header header-color-modal bg-color-1">
				<div class="modal-close-area modal-close-df">
					<a class="close" data-dismiss="modal" href="#"><i
						class="fa fa-close"></i></a>
				</div>
			</div>
			<div class="modal-body">
			<img src="/resources/images/school/aftSchool/aftSchoolImg2.png" style="position: absolute;left: 0px;top: 10px;z-index: -1; transform: translate(0px, -100px);">
				<h1 style="padding: 10px; font-size: 2.2em;">
					<img src="/resources/images/school/aftSchool/aftSchoolIcon4.png"
						style="width: 50px; display: inline-block; vertical-align: middel;">
					<span id="aschaNm" style="background: linear-gradient(to top, #7cb8ff 20%, transparent 20%);">방과후학교 명</span>
				</h1>
				<div id="aschaCode" style="display: none;">방과후 코드</div>
				
				<table>
					<tr>
						<td><label for="">담당 선생님</label></td>
						<td><div id="mberNm"></div></td>
					</tr>
					<tr>
						<td><label for="">수강 기간</label></td>
						<td><span id="aschaAtnlcBgnde"></span> ~
        					<span id="aschaAtnlcEndde"></span>
        				</td>
					</tr>
					<tr>
						<td><label for="">수강 비용</label></td>
						<td><div id="aschaAtnlcCt"></div></td>
					</tr>
					<tr>
						<td><label for="">수용 인원</label></td>
						<td><div id="aschaAceptncPsncpa"></div></td>
					</tr>
					<tr>
						<td><label for="">강의 설명</label></td>
						<td><div id="aschaDetailCn"></div></td>
					</tr>					
					<tr>
						<td colspan='2' style="text-align: center;">
						<label for="" >강의 계획서</label>
						</td>
					</tr>					
				</table>
				<table id="weekPlanTable">
					<tr>
						<td></td>
						<td></td>
					</tr>
				</table>
			</div>
			<div class="modal-footer">
				<!-- 학부모 결제 버튼 -->
				<c:if test="${USER_INFO.vwMemberAuthVOList[0].cmmnDetailCode == 'ROLE_A01003'}">
					<button type="button" id="btnRegist"
						class="btn btn-custon-rounded-four btn-primary">수강 신청</button>
				</c:if>
					<button type="button" id="btnRegist"
						class="btn btn-custon-rounded-four btn-primary" style="display:none;">수강 신청</button>
				<button type="button" id="btnCancle"
					class="btn btn-custon-rounded-four btn-default">닫기</button>
			</div>
		</div>
	</div>
</div>
<!-- 방과후학교 상세보기 모달 끝-->