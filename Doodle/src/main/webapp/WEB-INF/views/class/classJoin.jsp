<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<div class="sparkline12-list mt-b-30">
	<div class="sparkline12-hd">
		<div class="main-sparkline12-hd">
			<h1>클래스 가입</h1>
		</div>
	</div>
	<div class="sparkline12-graph">
		<div class="input-knob-dial-wrap">
			<div class="row">
				<div class="col-lg-2 col-md-2 col-sm-2 col-xs-12">
					<div class="input-mask-title">
						<label>학교 명</label>
					</div>
				</div>
				
				<div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">
					<div class="input-mark-inner mg-b-22">
						<input type="text" class="form-control" value="옥산초등학교" readonly="">
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-2 col-md-2 col-sm-2 col-xs-12">
					<div class="input-mask-title">
						<label>연도</label>
					</div>
				</div>
				<div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">
					<div class="input-mark-inner mg-b-22">
						<input type="number" id="clasYear" class="form-control" placeholder="숫자만 입력하세요">
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-2 col-md-2 col-sm-2 col-xs-12">
					<div class="input-mask-title">
						<label>학년</label>
					</div>
				</div>
				<div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">
					<div class="input-mark-inner mg-b-22">
						<select class="form-control" id="grade">
							  <option disabled="" selected="" hidden="">선택</option>
							  <option value="1">1학년</option>
							  <option value="2">2학년</option>
							  <option value="3">3학년</option>
							  <option value="4">4학년</option>
							  <option value="5">5학년</option>
							  <option value="6">6학년</option>
						</select>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-2 col-md-2 col-sm-2 col-xs-12">
					<div class="input-mask-title">
						<label>반</label>
					</div>
				</div>
				<div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">
					<div class="input-mark-inner mg-b-22">
						<input type="text" id="clasNm" class="form-control" placeholder="숫자만 입력하세요" required="">
					</div>
				</div>
			</div>
			<div class="col-md-10 text-right">
				<button type="button" id="createBtn" class="btn btn-custon-rounded-two btn-primary">등록</button>
			</div>

		</div>
	</div>
</div>