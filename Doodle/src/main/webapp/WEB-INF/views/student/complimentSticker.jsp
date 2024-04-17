<%@page import="kr.or.ddit.vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<style>
.stickerIcon{
	width: 60px; object-fit: cover; margin-right: 7.1px; margin-bottom: 9px;
}

.dataSpan {
	font-weight: bold;
	color: #999;
	display: inline-block;
	width: 110px;
}

.school {
	/* 	border-right: 2px solid #eee; */
	margin-right: 10px;
}

.basic-list li {
	padding: 10px 0px 5px;
	border-bottom: 1px solid rgba(120, 130, 140, .13);
	margin-bottom: 10px;
}

.basic-list li:last-child {
	padding: 10px 0px 5px;
	border-bottom: 1px solid rgba(120, 130, 140, .13);
}

#profileImg {
	width: 200px;
	height: 200px;
	border-radius: 70%;
	object-fit: cover;
	position: relative;
}

#profileUploadIcon {
	position: absolute;
	width: 45px;
	top: 228px;
	left: 348px;
	cursor: pointer;
}

#Container h4 {
	font-size: 2.2rem;
	text-align: center;
	margin-top: 60px;
	backdrop-filter: blur(4px);
	background-color: rgba(255, 255, 255, 1);
	border-radius: 50px;
	box-shadow: 35px 35px 68px 0px rgba(145, 192, 255, 0.5), inset -8px -8px
		16px 0px rgba(145, 192, 255, 0.6), inset 0px 11px 28px 0px
		rgb(255, 255, 255);
	width: 370px;
	padding-top: 35px;
	padding-bottom: 35px;
	margin: auto;
	margin-top: 10px;
	margin-bottom: 40px;
}

#Container h5{
/* 	color: #777; */
}

#updateBtn, #cancelBtn {
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

#updateBtn:hover, #cancelBtn:hover {
	background: #ffd77a;
	transition: all 1s ease;
	color: #333;
}

#cancelBtn {
	background: #666;
}

.MyPageAll {
	width: 1200px;
	margin: auto;
	margin-bottom: 50px;
	backdrop-filter: blur(10px);
	background-color: rgba(255, 255, 255, 1);
	border-radius: 50px;
	box-shadow: 0px 35px 68px 0px rgba(145, 192, 255, 0.5), inset 0px -6px 16px 0px rgba(145, 192, 255, 0.6), inset 0px 11px 28px 0px rgb(255, 255, 255);
	padding: 50px 30px 60px 30px;
}

.MyPageAll .free-cont {
	border: 1px solid #ddd;
	border-radius: 10px;
	padding: 10px 20px;
	min-height: 83px;
	margin-top: 50px;
}

.MyPageAll .FreeTit {
	display: flex;
	justify-content: space-between;
	position: relative;
}

.MyPageAll .title {
	font-size: 1.8rem;
	font-weight: 700;
	margin-top: 6px;
}

.myPersonalData input {
	width: 100%;
	height: 40px;
	border: 1px solid #d1d1d1;
	border-radius: 7px;
	padding-left: 12px;
	background-color: white;
}

.myPersonalData input[readonly] {
	background-color: #F0F0F0;
}

.sticker-container {
	border: 1px solid #ddd;
	padding: 30px;
	border-radius: 10px;
/* 	margin: 70px; */
}
</style>
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script type="text/javascript">
// 전역 변수
var complimentStickerCount = "${complimentStickerCount}";

$(function() {
	console.log("${taskResultVOList}");
});
</script>
<div id="Container">
	<h4>
		<img src="/resources/images/member/myPage/happyEmotion.png"
			style="width: 45px; display: inline-block; vertical-align: middel; margin-right: 7px; margin-bottom: 5px;">
		칭찬 스티커 <img src="/resources/images/member/myPage/colorHorse.png"
			style="width: 55px; display: inline-block; vertical-align: middel; margin-bottom: 9px;">
	</h4>
	<div class="MyPageAll">
		<div class="row">
			<div id="myTabContent" class="tab-content custom-product-edit">
				<div class="product-tab-list tab-pane fade active in"
					id="description">
					<div class="row">
						<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
							<div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
								<div style="margin-left: 70px;">
									<h5>칭찬 스티커 판</h5>
								</div>
								<div class="sticker-container" style="margin-left: 70px;">
									<c:forEach var="i" begin="1" end="${complimentStickerCount}">
										<img class="stickerIcon" src="/resources/images/member/myPage/sticker.png" alt="">
									</c:forEach>
									<c:forEach var="i" begin="1" end="${30 - complimentStickerCount}">
										<img class="stickerIcon" src="/resources/images/member/myPage/circle.png" alt="">
									</c:forEach>
								</div>
							</div>
							<div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
								<div style="margin-right: 70px;">
									<h5>칭찬 스티커 받은 날</h5>
								</div>
								<div class="sticker-container" style="margin-right: 70px; height: 406.3px;">
	                                <ul class="basic-list">
	                                	<c:choose>
		                                	<c:when test="${not empty taskResultVOList}">
			                                	<c:forEach var="taskResultVO" items="${taskResultVOList}" varStatus="status">
												    <li>
												        <span class="dataSpan">· 
												            <fmt:formatDate value="${taskResultVO.complimentStickerDate}" pattern="yyyy-MM-dd" />
												        </span>
												        [과제] ${taskResultVO.taskVO.taskSj}
												    </li>
												</c:forEach>
		                                	</c:when>
		                                	<c:otherwise>
		                                		<div style="text-align: center; align-content: center; height: 350px;">
<!-- 													<img class="stickerIcon" src="/resources/images/member/myPage/cry.png" alt=""> -->
			                                		<p style="color: #999">아직 받은 칭찬 스티커가 없습니다.</p>
		                                		</div>
		                                	</c:otherwise>
	                                	</c:choose>
	                                </ul>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

