<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<style>


	@font-face {
	font-family: 'Chosunilbo_myungjo';
	src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_one@1.0/Chosunilbo_myungjo.woff') format('woff');
	font-weight: normal;
	font-style: normal;
	}
	

	
	p{
		margin-bottom:0;
		font-size:0.9rem;
		color:#111;
		word-break: keep-all;
	}
	h1,h2,h3,h4,h5{
		margin:0;
	}
	
	input[type=checkbox], input[type=radio]{
		margin:0;
		vertical-align: middle;
	}
	
	#surveyVoteContainer .surveyVoteBg{
		display:flex;
		justify-content: space-between;
		background: #FFFEFA;
		border: 1px solid #f5f5f5;
		padding: 60px 40px;
		width: 1200px;
		margin: auto;
	}

	#surveyVoteContainer  .surveyVoteBg .bonmun{
			flex: 1;
			padding-left: 90px;
	}
	#surveyVoteContainer .surveyVoteBg .bonmun h3{
		font-size:1.5rem;
		font-weight: 500;
		color:#333;
	}
	
	#surveyVoteContainer .surveyVoteBg .topdiv{
		padding-bottom:10px;
		border-bottom:2px solid #000;
	}
	
	#surveyVoteContainer .surveyVoteBg .topdiv #stat{
		font-size:14.4px;
	}
	#surveyVoteContainer .surveyVoteBg .topcont{
		border: 1px solid #666;
		margin-bottom: 40px;
		line-height: 1.8;
		letter-spacing: -1px;
		padding:20px 30px;
		margin-top:20px;
	}
	#surveyVoteContainer .surveyVoteContent{
		margin-top:30px;
	}
	
	#surveyVoteContainer .surveyVoteContent .question-li{
		border-bottom: 1px solid #333;
		border-top: 2px solid #333;
		font-size: 1.05rem;
		padding-top: 10px;
		padding-bottom: 10px;
		padding-left: 10px;
	}
	
	#surveyVoteContainer .surveyVoteContent .surveyVotebogi{
		margin-top:20px;
		margin-bottom:20px;
		padding-left: 10px;
	}
	
	.s-area{
		resize: none;
		border: 1px solid #ddd;
		border-radius: 5px;
		margin-top: 30px;
		width: 100%;
		height: 80px;
		padding: 15px 20px;
		overflow: auto;
	}
	
	#surveyVoteContainer .btn-zone{
		margin-top:80px;
		text-align: center;
	}
	
	
	.svBtn{
		display:inline-block;
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
		margin-right:15px;
	}
	#surveyVotegoList{
		background:#333;
	}
	
	
	.svBtn:hover{
	background: #ffd77a!important;
	transition: all 1s ease;
	color:#333;
	font-weight:600;
	}
	#surveyVoteContainer .surveyVoteBg .gubun{
		width: fit-content;
		font-family: 'Chosunilbo_myungjo';
		font-size: 1.8rem;
		writing-mode: vertical-rl;
		text-orientation: upright;
		font-weight: 100;
		color: #aaa;
		-moz-animation: fadein 1s;
		-webkit-animation: fadein 1s;
		-o-animation: fadein 1s;
		position: fixed;
	}@keyframes fadein {
	from {
		opacity: 0;
	}
	to {
		opacity: 1;
	}
}
@-moz-keyframes fadein { /* Firefox */
	from {
		opacity: 0;
	}
	to {
		opacity: 1;
	}
}
@-webkit-keyframes fadein { /* Safari and Chrome */
	from {
		opacity: 0;
	}
	to {
		opacity: 1;
	}
}
@-o-keyframes fadein { /* Opera */
	from {
		opacity: 0;
	}
	to {
		opacity: 1;
	}
</style>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script>
$(function(){
	
		$(".autoStdBtn").on("click",function(){
			$("input[name='voteDetailIemCn1']").eq('1').prop("checked",true);
			$("textarea[name='voteDetailIemCn2']").val("담임 선생님이 친절해서 좋습니다.");
			$("input[name='voteDetailIemCn3']").eq('1').prop("checked",true);
			$("input[name='voteDetailIemCn4']").eq('2').prop("checked",true);
			$("input[name='voteDetailIemCn5']").eq('3').prop("checked",true);
			$("textarea[name='voteDetailIemCn6']").val("서로 이해하고 배려심을 갖고 행동해야 할 것 같습니다.");
			$("input[name='voteDetailIemCn7']").eq('1').prop("checked",true);
			$("input[name='voteDetailIemCn8']").eq('5').prop("checked",true);
			$("input[name='voteDetailIemCn9']").eq('1').prop("checked",true);
			$("input[name='voteDetailIemCn10']").eq('1').prop("checked",true);
			$("textarea[name='voteDetailIemCn11']").val("방과후 수업이 너무 일찍 끝나서 아쉽습니다. 시간이 늘어났으면 좋겠어요.");
			$("textarea[name='voteDetailIemCn12']").val("선생님 사랑해요.");
		});
		$("#studentFreeBoardLi").css("display", "block");
		$("#teacherFreeBoardLi").css("display", "block");
		$("#parentFreeBoardLi").css("display", "block");
		
		var startDt = new Date("${voteQustnrBeginDt}");
		var endDt = new Date("${voteQustnrEndDt}");
		var todayDt = new Date();
		var qustnrSttus = '';
		

		
		if(startDt > todayDt) {
			qustnrSttus = '예정';
			$("#stat").text(qustnrSttus);
			$(".statIcon").html("<i class='fa-solid fa-hourglass-start' style='color:#666;'></i>");
		}else if(startDt <= todayDt && todayDt <= endDt) {
			qustnrSttus = '진행중';
			$("#stat").text(qustnrSttus);
			$(".statIcon").html("<i class='fa-solid fa-face-smile' style='color:#666;'></i>");
		}else {
			qustnrSttus = '마감';
			$("#stat").text(qustnrSttus);
			$(".statIcon").html("<i class='fa-solid fa-face-frown' style='color:#666;'></i>");
		}
		
		
		$("#stat").text(qustnrSttus);
// 		A22001 -1학년
// 		A22002 -2학년
// 		A22003 -3학년
// 		A22004 -4학년
// 		A22005 -5학년
// 		A22006 -6학년
		
		if("${clasVO.cmmnGrade}"=="A22001"){
			$(".grade").text("1");
		}else if("${clasVO.cmmnGrade}"=="A22002"){
			$(".grade").text("2");
		}else if("${clasVO.cmmnGrade}"=="A22003"){
			$(".grade").text("3");
		}else if("${clasVO.cmmnGrade}"=="A22004"){
			$(".grade").text("4");
		}else if("${clasVO.cmmnGrade}"=="A22005"){
			$(".grade").text("5");
		}else if("${clasVO.cmmnGrade}"=="A22006"){
			$(".grade").text("6");
		}
		
		
		
		
		$("#surveyVoteSubmitBtn").on("click",function(){
			var data = {"voteQustnrCode": "${voteNdQustnrVO.voteQustnrCode}"};
			var QVList = [];
			$("input[data-target='data']:checked").each(function(idx, item) {
				var temp = {
							"voteIemSn" : $(item).data("voteIemSn")
							,"voteDetailIemCn" :$(item).val()
				};
				QVList.push(temp);
				data.QVList = QVList;
			});
			console.log("--------------------------------------------------------------")
			$("textarea[data-target='data']").each(function(idx, item) {
				var temp = {
						"voteIemSn" : $(item).data("voteIemSn")
						,"voteDetailIemCn" :$(item).val()
						};
				QVList.push(temp);
				data.QVList = QVList;
			});
				
			console.log(data);
			
			//응답 null체크
			var nullchk = true;
			
			$(".surveyVotebogi").each(function(idx, item) {
				if($(item).find("input[data-target='data']:checked").length != 1) {
					alertError("필수입력값입니다.");
					nullchk = false;
					return false;
				}
			});
			//객관식 결과가 통과되었으면 타는 구문
			if(nullchk){
				$("textarea[data-target='data']").each(function(idx, item) {
					if($(item).val()==null || $(item).val()==''){
						alertError("필수입력값입니다.");
						nullchk = false;
						return false;
					}
				});
			}
			
			//둘다 통과하지 못하면 return
			if(!nullchk){
				return;
			}
			
			$.ajax({
				url:"/freeBoard/surbeyRegistrationAjax",
				contentType:"application/json;charset=utf-8",
				data:JSON.stringify(data),
				type:"post",
				dataType:"json",
				beforeSend:function(xhr){
					xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
				},
				success:function(result){
					if(result==1){
						resultAlert2(result, '설문 응답 ', '리스트로 이동합니다.', '/freeBoard/surveyList');
					}else{
						alertError("설문 응답이 실패하였습니다.");
						return;
					}
				}
			});
		});
		
	});
</script>
<%-- ${voteNdQustnrVO} --%>
<div id="surveyVoteContainer">
	<div class="surveyVoteBg">
		<div class="gubun">
			${clasVO.schulNm} <span class="grade"></span>학년 ${clasVO.clasNm} 설문조사
		</div>
		<div class="bonmun">
			<div class="topdiv">
				
				<h3>${voteNdQustnrVO.voteQustnrNm}
					<button type="button" class="autoStdBtn" style="float:right;">자동입력</button>
				</h3>
				<p style="justify-content: space-between; display:flex;margin-top: 20px;margin-bottom: 10px;line-height: 1.8;letter-spacing: -1px;padding-bottom: 0px;">
					<span>
						<img src="/resources/images/classRoom/freeBrd/freeDateIcon.png" alt="투표 일자 아이콘" style="width: 12px;margin-top: 5px;vertical-align: top;display: inline-block;"/>
						설문 시작일 : <fmt:formatDate value="${voteNdQustnrVO.voteQustnrBeginDt}" pattern="yyyy-MM-dd" />
						<span> ~ </span>
						설문 마감일 : <fmt:formatDate value="${voteNdQustnrVO.voteQustnrEndDt}" pattern="yyyy-MM-dd" />
					</span>
					<span>
						<img src="/resources/images/classRoom/freeBrd/freePersonIcon.png" alt="게시글 작성자 아이디 아이콘" style="width: 12px;margin-top: 6px;vertical-align: top;display: inline-block;"/>
						작성자 : ${voteNdQustnrVO.mberId} | 
						<i class="fa-solid fa-pen-nib" style= "color:#666;"></i>
						설문 작성일 : <fmt:formatDate value="${voteNdQustnrVO.writngDt}" pattern="yyyy-MM-dd" /> | 
						<span class="statIcon"></span>
						설문 진행 상태 : <small id="stat"></small>
					</span>
				</p>
			</div>
			<div class="topcont">
				<p>
					${voteNdQustnrVO.voteQustnrCn}
				</p>
			</div>
			<c:forEach var="item" items="${voteNdQustnrVO.voteQustnrIemVOList}" varStatus="status">
				<ul class="surveyVoteContent">
					<li class="question-li">
						<h4 style="display:inline-block;">
							${item.voteIemSn}.
						</h4>
						${item.voteIemCn}
					</li>
					<c:if test="${item.voteQustnrType=='M'}">
						<li>
							<ul class="surveyVotebogi">
								<c:forEach var="item2" items="${voteNdQustnrVO.voteQustnrDetailIemVOList}" varStatus="idx">
									<c:if test="${item.voteIemSn == item2.voteIemSn}">
										<li style="margin-bottom:15px;">
											<label>
												<input type="radio" class="voteDetailIemCn" name="voteDetailIemCn${status.count}" value="${item2.voteDetailIemCn}" data-target="data" data-vote-iem-sn="${item.voteIemSn}">
												<span class="cntext" style="vertical-align: middle; font-size: 0.95rem; margin-left:5px; font-weight: 500;">
													${item2.voteDetailIemCn}
												</span>
											</label>
										</li>	
									</c:if>
								</c:forEach>
							</ul>
						</li>
					</c:if>
					<c:if test="${item.voteQustnrType=='S'}">
						<li>
							<textarea rows="" cols="" style="resize:none" name="voteDetailIemCn${status.count}" class="s-area" data-target="data" data-vote-iem-sn="${item.voteIemSn}"></textarea>
						</li>
					</c:if>
				</ul>
			</c:forEach>
			<div class="btn-zone">
				<button type="button" id="surveyVoteSubmitBtn" class="svBtn">등록</button>
				<button type="button" id="surveyVotegoList" class="svBtn" onclick="location.href='/freeBoard/surveyList'">목록</button>
			</div>
		</div>
	</div>
</div>