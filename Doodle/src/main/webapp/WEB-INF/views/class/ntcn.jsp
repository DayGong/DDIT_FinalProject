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

#ntcnSj{
	width:95%;
	border:none;
	background: none;
	height: 50px;
	font-size: 1.4rem;
	display: inline-block;
	vertical-align: middle;
	margin-bottom:6px;
}

.ntcnImg{
	width: 300px;
	height: 300px;
	object-fit: cover;
}

.ntcnIcon{
	width: 12px;
	margin-top: 3.5px;
	margin-right: 3px;
	vertical-align: top;
	display: inline-block;
}

#fixingIcon{
	position: absolute;
	left: -4px;
	top: -13px;
	z-index: -1;
	width:50px;
}

#ntcnTitle{
	min-height: 255px;
    width: 1200px;
    margin: auto;
}

#ntcnTitle h3{
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

#ntcnContainer{
	min-height: 255px;
}

#ntcnContainer .custom-pagination{
	max-width:302px;
	margin: auto;
}
#ntcnContainer .custom-pagination .pagination {
	 width: max-content;
}
.searchForm{
	height: 40px;
	border: 1px solid #ddd;
	border-radius: 5px;
	padding: 15px 20px;
}

/* 버튼 css 시작 */
#searchBtn,#insertBtn,#goToListBtn{
	background: #333;
	height: 40px;
	border: none;
	padding: 10px 15px;
	border-radius: 10px;
	font-family: 'Pretendard' !important;
	font-weight: 600;
	color: #fff;
}

#searchBtn:hover, #insertBtn:hover, #goToListBtn:hover{
	background: #ffd77a;
	color:#333;
	transition:all 1s;
	font-weight: 700;
}

#goToListBtn{
	background: #666;
}

#updateBtn,#fixBtn,#deleteBtn{
	border: none;
	color: #fff;
	border-radius: 10px;
	padding: 10px 10px;
}

#insertBtn, #updateBtn{
	background: #006DF0;
}

#deleteBtn{
	margin-left: 7px;
	margin-right: 7px;
	background: #666;
}
#fixBtn{
	background: #333;
}
/* 버튼 css 끝 */

#searchCondition{
	height: 40px;
	border: 1px solid #ddd;
	border-radius: 5px;
	padding-left: 10px;
}

.custom-datatable-overright table tbody tr.none-tr td:hover{
	background: #fff!imporant;
}

.ntcnAll{
	width: 1200px;
	margin: auto;
	backdrop-filter: blur(10px);
	background-color: rgba(255, 255, 255, 1);
	border-radius: 50px;
	box-shadow: 0px 35px 68px 0px rgba(145, 192, 255, 0.5), inset 0px -6px 16px 0px rgba(145, 192, 255, 0.6), inset 0px 11px 28px 0px rgb(255, 255, 255);
	padding: 50px 80px;
	margin-bottom:50px;
	min-height:430px;"
}

.ntcnAll .ntcn-cont{
	border: 1px solid #ddd;
	border-radius: 10px;
	padding: 50px;
	min-height: 83px;
	margin-top: 20px;
	margin-bottom: 60px;
}
.ntcnAll .ntcnTit {
	display: flex;
	justify-content: space-between;
	position:relative;
}

.ntcnAll .title{
	font-size: 1.8rem;
	font-weight: 700;
	margin-top: 6px;

}
.ntcnInfo {
	display: flex;
	justify-content: space-between;
	margin-top: 15px;
	font-size: 1rem;
}

/* 알림장 내용 시작 */
#ntcnCn{
	resize: none;
	height: auto;
	border: none;
}

#ntcnCn p{
	font-size: 15px;
}

.__se_tbl{
	width: 100%;
}

.__se_tbl td{
	border: 1px solid rgb(232 232 232);
	padding: 5px;
	font-size: 15px;
}
/* 알림장 내용 끝 */

/* 첨부 파일 시작 */
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
/* 첨부 파일 끝 */
</style>
<script type="text/javascript" src="/resources/js/commonFunction.js"></script>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script type="text/javascript">
// 전역 변수
var keyword = "${keyword}";
var clasCode = "${clasCode}";
var total = "${total}";
var ntcnSj = "";
var str = "";
var length = "" // 알림장 목록의 길이를 담는 변수

function fn_ntcnList(paramPage){
	var data = {
		"clasCode":clasCode,
		"currentPage":paramPage,
		"keyword":keyword
	};
	
	// 알림장 목록 불러오기
	$.ajax({
		url:"/ntcn/ntcnListAjax",
		contentType:"application/json;charset=utf-8",
		data:JSON.stringify(data),
		type:"post",
		dataType:"json",
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success: function(res){
			console.log("ntcnList : ", res);
			length = res.length;
			
			if(length > 0){
				$.each(res, function(idx, ntcnVO){
					str += "<div class='ntcnAll'><div>";
					
					// 로그인한 회원이 담임 교사인 경우, 수정 버튼 추가
					if("${USER_INFO.vwMemberAuthVOList[0].cmmnDetailCode}" == 'ROLE_A14002'){
						str += "<div style='display: flex; justify-content: flex-end;'>";
						str += "<input type='submit' id='updateBtn' value='수정'>";
						str += "<input type='button' id='deleteBtn' value='삭제'>";
						
						var fixBtnValue = (ntcnVO.imprtcNtcnAt == 0) ? "중요 알림 설정" : "중요 알림 해제";
						str += "<input type='button' id='fixBtn' value='"+fixBtnValue+"'></div>";
					}
					
					// 중요 알림인 경우, 고정 아이콘 추가
					if(ntcnVO.imprtcNtcnAt == 1){
						str += "<img id='fixingIcon' src='/resources/images/classRoom/notice/fixing.png'>";
					}
					
					str += "<div class='ntcnTit'>";
					str += "<input type='text' class='form-control input-sm' name='ntcnSj' id='ntcnSj' value='"+ntcnVO.ntcnSj+"' data-ntcnSj='"+ntcnVO.ntcnSj+"' readonly>";
					str += "<input type='hidden' id='ntcnCode' value='"+ntcnVO.ntcnCode+"' readonly>";
					str += "<input type='hidden' id='atchFileCode' value='"+ntcnVO.atchFileCode+"' readonly>";
					str += "<img src='/resources/images/classRoom/freeBrd/line.png' style='position: absolute;left: 0px;top: 14px;z-index: -1;'>";
					str += "</div>";
					
					str += "<div class='ntcnInfo'>";
					str += "<span style='margin-left:12px; font-size: 13px;'>";
					str += "<img class='ntcnIcon' src='/resources/images/classRoom/freeBrd/freePersonIcon.png' alt='알림장 작성자 아이디 아이콘'/>";
					str += "<small style='font-weight: 600;color: #222;font-size: 13px; line-height: 1.75;'>작성자 : </small>";
					str += "<span style='color:#666; font-size: 13px;'>"+ntcnVO.hrtchrVO.mberNm+"</span>";
					str += "</span>";
					str += "<span style='margin-left:12px; font-size: 14px;'>";
					str += "<img class='ntcnIcon' src='/resources/images/classRoom/freeBrd/freeDateIcon.png' alt='알림장 등록일자 아이콘'/>";
					str += "<small style='font-weight: 600;color: #222;font-size: 13px;'>등록일자 : </small>";
					str += "<span style='color:#666; font-size: 13px;'>"+dateFormat(ntcnVO.ntcnWritngDt)+"</span>";
					str += "</span>";
					str += "</div>";
					
					/* 첨부 파일 시작 */
					str += "<div class='mb-3' style='display:flex;margin-top:20px;'>";
					str += "<img src='/resources/images/classRoom/freeBrd/freeFile.png' style='width:40px; display:inline-block;'>";
					str += "<span style='font-size:1.05rem; display: inline-block; vertical-align: middle;line-height: 2.5;'>첨부파일</span> ";
					str += "</div>";
					str += "<div class='uploadList'>";
					str += "<ul>";
					
					// 첨부 파일 있으면 출력
					if(ntcnVO.atchFileVO.length > 0){
						$.each(ntcnVO.atchFileVO, function(i, atchFileVO){
							str += "<li class='fileList'>";
							str += "<img src='/resources/images/classRoom/freeBrd/free-download-solid.png' alt='파일 다운로드' style='width:15px; height: 15px; margin-bottom:3px;'>";
							str += "<a href='/upload/ntcn/"+atchFileVO.atchFileCours+"' download>"+ " " +atchFileVO.atchFileNm+"</a>";
							str += "</li>";
						});
					}else{
						str += "<li>";
						str += "<p style='margin-bottom:0px;'>";
						str += "<img alt='파일이 미존재 시 파일 아이콘 ' src='/resources/images/classRoom/freeBrd/free-file-solid.png' style='width: 13px;margin-right: 2px; margin-bottom: 3px;'>";
						str += " 첨부된 파일이 없습니다.";
						str += "</p>";
						str += "</li>";
					}//end if
					
					str += "</ul>";
					str += "</div>";
					/* 첨부 파일 끝 */
					
					str += "</div>";
					str += "<div class='form-group res-mg-t-15'>";
					str += "<div class='ntcn-cont'>";
					str += "<div id='smarteditor'>";
					str += "<div id='ntcnCnDiv' style='width:100%;' style='border:1px solid #ddd;'>";
					str += "<div id='ntcnCn' name='ntcnCn' readonly>"+ntcnVO.ntcnCn+"</div>"
	
					$("#ntcnCn").html(ntcnVO.ntcnCn);
	
					
					str += "<div id='imgDiv'>";
					
					str += "</div></div></div></div></div></div>";
				});//end each
			}else{
				str += "<p style='text-align: center; font-size: 15px; margin-top: 30px;'>등록된 게시글이 없습니다.</p>";
			}
			
			$("#ntcnContainer").html(str);
		}
	});//end ajax
}//end fn_ntcnList

$(function(){
	var currentPage = 1;
	var isLoading = false;

	// 알림장 목록 불러오기
	fn_ntcnList(1);
	
	// 무한 스크롤
	$(window).on("scroll", function(e){
	    if (isLoading) return; // 페이지 로드 중이면 이벤트를 무시
	
	    var scrollTop = $(window).scrollTop();
	    var windowHeight = $(window).height();
	    var documentHeight = $(document).height();
	    var isBottom = scrollTop + windowHeight + 10 >= documentHeight;
	
	    if(isBottom){
	        // 페이지 로드 시작
	        isLoading = true;
	
	        // 현재 마지막 페이지거나 알림장 리스트가 한 페이지에 출력될 수(5)보다 작은 경우,
	        if(currentPage > (total/5) || length < 5){
	            isLoading = false; // 페이지 로드 종료
	            return;
	        } else {
	            currentPage++;
	            
	            fn_ntcnList(currentPage);
		        isLoading = false; // 페이지 로드 종료
	        }
	    }
	});

	// 알림 등록
	$("#insertBtn").on("click", function(){
		location.href = "/ntcn/ntcnInsertForm?clasCode="+clasCode;
	});
	
	// 알림장 수정 폼 띄우기
	$(document).on("click", "#updateBtn", function(){
		var ntcnCode = $(this).closest('.ntcnAll').find("#ntcnCode").val();
		location.href = "/ntcn/ntcnUpdateForm?ntcnCode=" + ntcnCode;
	});
	
	// 중요 알림 설정/해제
	$(document).on("click", "#fixBtn", function(){
		var fixVal = $(this).closest(".ntcnAll").find("#fixBtn").val();
		var ntcnCode = $(this).closest(".ntcnAll").find("#ntcnCode").val();
		var ntcnSj = $(this).closest(".ntcnAll").find("#ntcnSj").val();
		var imprtcNtcnAt = 1;
 		var title = "";
 		
 		if(fixVal == "중요 알림 해제"){
			imprtcNtcnAt = 0;
			title = "["+ntcnSj+"]의 중요 알림 설정을 해제하시겠습니까?";
		}else{
			title = "["+ntcnSj+"]을/를 \n중요 알림으로 설정하시겠습니까?";
		}
 		
	 	Swal.fire({
			title: title,
			icon: 'warning',
			showCancelButton: true,       	// cancel 버튼 보이기
			confirmButtonText: '설정',       // confirm 버튼 텍스트 지정
			cancelButtonText: '취소',        // cancel 버튼 텍스트 지정
		}).then(result => {
	        if(result.isConfirmed){
            	var data = {
           			"ntcnCode":ntcnCode,
           			"imprtcNtcnAt":imprtcNtcnAt
           		};
           		
           		$.ajax({
           			url:"/ntcn/updateImprtcAt",
           			data: data,
           			dataType: "text",
           			type: "post",
           			beforeSend:function(xhr){
           				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
           			},
           			success: function(res){
           				location.href = "/ntcn/ntcnList?clasCode="+clasCode;
           			}
           		})
			};
		});
	});
	
	// 알림장 게시글 삭제
	$(document).on("click", "#deleteBtn", function(){
		var ntcnCode = $(this).closest(".ntcnAll").find("#ntcnCode").val();
		var atchFileCode = $(this).closest(".ntcnAll").find("#atchFileCode").val();
		
	 	Swal.fire({
			title: "정말 삭제하시겠습니까?",
			icon: 'warning',
			showCancelButton: true,       	// cancel 버튼 보이기
			confirmButtonText: '삭제',       // confirm 버튼 텍스트 지정
			cancelButtonText: '취소',        // cancel 버튼 텍스트 지정
		}).then(result => {
	        if(result.isConfirmed){
	        	
            	var data = {
           			"ntcnCode":ntcnCode,
           			"atchFileCode":atchFileCode
           		};
           		
           		$.ajax({
           			url:"/ntcn/ntcnDelete",
           			data: data,
           			dataType: "text",
           			type: "post",
           			beforeSend:function(xhr){
           				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
           			},
           			success: function(res){
						location.href = "/ntcn/ntcnList?clasCode="+clasCode;
           			}
           		})
			};
		});
	});
})
</script>
<div id="ntcnTitle">
	<div class="sparkline13-list">
		<h3>
			<img src="/resources/images/classRoom/notice/noticeContent.png" style="width:50px; margin-bottom: 5px; display:inline-block; vertical-align:middel;">
				알림장
			<img src="/resources/images/classRoom/notice/star.png" style="width:40px; margin-bottom: 10px; display:inline-block; vertical-align:middel;">		
		</h3>
		<div class="sparkline13-graph">
			<div class="datatable-dashv1-list custom-datatable-overright">
				<div class="bootstrap-table">
					<div class="fixed-table-toolbar">
						<div class="pull-left button">
							<!-- 로그인한 회원이 담임 교사인 경우에만 등록 버튼 활성화 -->
							<c:if test="${USER_INFO.vwMemberAuthVOList[0].cmmnDetailCode == 'ROLE_A14002'}">
								<button type="button" id="insertBtn">알림 등록</button>
							</c:if>
							<button type="button" id="goToListBtn" onclick="location.href='/ntcn/ntcnList?clasCode=${CLASS_INFO.clasCode}'">알림 목록</button>
						</div>
						<div class="pull-right search" style="margin-bottom: 20px;">
							<form action="/ntcn/ntcnList?clasCode=${CLASS_INFO.clasCode}" method="get">
								<input class="searchForm" type="text" placeholder="" id="keyword" name="keyword" value="${keyword}">
								<input class="searchForm" type="hidden" name="clasCode" value="${CLASS_INFO.clasCode}">
								<button type="submit" id="searchBtn">검색</button>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<div id="ntcnContainer"></div>

