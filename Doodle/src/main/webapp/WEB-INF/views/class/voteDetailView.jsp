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
	
	label{
		display: inline-block;
		max-width: 100%;
		font-weight: 700;
		padding: 10px 15px;
		margin-bottom:0px;
	}
	#surveyVoteContainer .surveyVoteBg{
		display:flex;
		justify-content: space-between;
		background: #f7f7f7;
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
		font-size:2rem;
		font-weight: 600;
		text-align:center;
		color:#333;
		font-family: 'Chosunilbo_myungjo';
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
	
	.cntext{
		padding: 10px 15px;
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
	$(".click-li").on("click",function(){
		$(this).find($("input:radio")).attr("checked",true);
	});
	
	
	
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
//		A22001 -1학년
//		A22002 -2학년
//		A22003 -3학년
//		A22004 -4학년
//		A22005 -5학년
//		A22006 -6학년
	
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
		console.log("data->", data);
		console.log("QVList->", QVList);
		
		var nullchk = true;
		if($("input[data-target='data']:checked").length != 1){
			alertError("필수입력값입니다.");
			nullchk = false;
			return false;
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
					resultAlert2(result, '투표 수정 ', '리스트로 이동합니다.', '/freeBoard/voteList');
				}else{
					alertError("투표 응답이 실패하였습니다.");
					return;
				}
			}
		});
	});
	
});
</script>
<div id="surveyVoteContainer">
	<div class="surveyVoteBg">
		<div class="gubun">
			${clasVO.schulNm} <span class="grade"></span>학년 ${clasVO.clasNm} 투표
		</div>
		<div class="bonmun">
			<div class="topdiv">
				
				<h3>[ ${voteNdQustnrVO.voteQustnrNm} ]</h3>
				<p style="justify-content: space-between; display:flex;margin-top: 20px;margin-bottom: 10px;line-height: 1.8;letter-spacing: -1px;padding-bottom: 0px;">
					<span>
						<img src="/resources/images/classRoom/freeBrd/freeDateIcon.png" alt="투표 일자 아이콘" style="width: 12px;margin-top: 5px;vertical-align: top;display: inline-block;"/>
						투표 시작일 : <fmt:formatDate value="${voteNdQustnrVO.voteQustnrBeginDt}" pattern="yyyy-MM-dd" />
						<span> ~ </span>
						투표 마감일 : <fmt:formatDate value="${voteNdQustnrVO.voteQustnrEndDt}" pattern="yyyy-MM-dd" />
					</span>
					<span>
						<img src="/resources/images/classRoom/freeBrd/freePersonIcon.png" alt="게시글 작성자 아이디 아이콘" style="width: 12px;margin-top: 6px;vertical-align: top;display: inline-block;"/>
						작성자 : ${voteNdQustnrVO.mberId} | 
						<span class="statIcon"></span>
						투표 진행 상태 : <small id="stat"></small>
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
							${item.voteIemCn}
						</h4>
						
					</li>
					<c:if test="${item.voteQustnrType=='V'}">
						<li>
							<ul class="surveyVotebogi">
								<c:forEach var="item2" items="${voteNdQustnrVO.voteQustnrDetailIemVOList}" varStatus="idx">
									<c:if test="${item.voteIemSn == item2.voteIemSn}">
										<li class="click-li" style="margin-bottom:15px;margin-bottom:15px;border: 1px solid #999;" >
											<label for="voteDetailIemCn${idx.count}" style="width: 100%;">
												<input type="radio" class="voteDetailIemCn${idx.count}"  id="voteDetailIemCn${idx.count}"  name="voteDetailIemCn" value="${item2.voteDetailIemCn}" data-target="data" data-vote-iem-sn="${item.voteIemSn}">
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
				</ul>
			</c:forEach>
			<div class="btn-zone">
				<button type="button" id="surveyVoteSubmitBtn" class="svBtn">등록</button>
				<button type="button" id="surveyVotegoList" class="svBtn" onclick="location.href='/freeBoard/voteList'">목록</button>
			</div>
		</div>
	</div>
</div>