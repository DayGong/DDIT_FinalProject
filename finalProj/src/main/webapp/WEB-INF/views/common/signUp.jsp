<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
.col-12{
	padding-bottom:20px;
}
.col-md-3, .col-md-6{
	padding-left:0px;
}
input[type="text"], input[type="file"]{
	width:800px!important;
}
</style>
<div class="row g-5">
	<div class="col-md-7 col-lg-8">
		<h4 class="mb-3" style="padding-left: 10px;">회원가입</h4>
		<form class="needs-validation" novalidate="" style="padding-left: 25px;" enctype="multipart">
			<div class="row g-3">
				<div class="col-12">
					<label for="username" class="form-label">이름</label>
					<div class="input-group has-validation">
						<input type="text" class="form-control" id="mberNm" name="mberNm" placeholder="이름을 입력해주세요." required="">
					</div>
				</div>
				<div class="col-12">
					<label for="username" class="form-label">아이디</label>
					<div class="input-group has-validation">
						<input type="text" class="form-control" id="mberId" name="mberId" placeholder="사용하실 아이디를 입력해주세요." required="">
					</div>
				</div>
				<div class="col-12">
					<label for="email" class="form-label">이메일</label>
					<input type="text" class="form-control" id="mberEmail" name="mberEmail" placeholder="이메일을 입력해주세요.">
				</div>
				<div class="col-12">
					<label for="ihidnum" class="form-label">주민번호</label>
					<input type="text" class="form-control" id="ihidnum" name="ihidnum" placeholder="주민번호">
				</div>
				<div class="col-12">
					<label for="mberEmail" class="form-label">전화번호</label>
					<input type="text" class="form-control" id="mberEmail" name="mberEmail" placeholder="전화번호">
				</div>
				<div class="col-12">
					<label for="zip" class="form-label">우편번호</label>
					<input type="text" class="form-control" id="zip" name="zip" placeholder="우편번호" required="">
				</div>

				<div class="col-12">
					<label for="mberAdres" class="form-label">상세주소</label>
					<input type="text" class="form-control" id="mberAdres" name="mberAdres" placeholder="상세주소">
				</div>
				<div class="col-12">
					<label for="uploadFile" class="form-label">프로필이미지</label>
					<div class="input-group mb-3">
						<input type="file" class="form-control" id="uploadFile" name="uploadFile">
					</div>
				</div>
			</div>

<!-- 			<hr class="my-4"> -->

<!-- 			<div class="form-check"> -->
<!-- 				<input type="checkbox" class="form-check-input" id="same-address"> -->
<!-- 				<label class="form-check-label" for="same-address">Shipping address is the same as my billing address</label> -->
<!-- 			</div> -->

<!-- 			<div class="form-check"> -->
<!-- 				<input type="checkbox" class="form-check-input" id="save-info"> -->
<!-- 				<label class="form-check-label" for="save-info">Save this information for next time</label> -->
<!-- 			</div> -->

<!-- 			<hr class="my-4"> -->

<!-- 			<div class="my-3"> -->
<!-- 				<div class="form-check"> -->
<!-- 					<input id="credit" name="paymentMethod" type="radio" class="form-check-input" checked="" required=""> -->
<!-- 					<label class="form-check-label" for="credit">Credit card</label> -->
<!-- 				</div> -->
<!-- 				<div class="form-check"> -->
<!-- 					<input id="debit" name="paymentMethod" type="radio" class="form-check-input" required=""> -->
<!-- 					<label class="form-check-label" for="debit">Debit card</label> -->
<!-- 				</div> -->
<!-- 				<div class="form-check"> -->
<!-- 					<input id="paypal" name="paymentMethod" type="radio" class="form-check-input" required=""> -->
<!-- 					<label class="form-check-label" for="paypal">PayPal</label> -->
<!-- 				</div> -->
<!-- 			</div> -->

<!-- 			<div class="row gy-3"> -->
<!-- 				<div class="col-md-6"> -->
<!-- 					<label for="cc-name" class="form-label">Name on card</label> -->
<!-- 					<input type="text" class="form-control" id="cc-name" placeholder="" required=""> -->
<!-- 				</div> -->

<!-- 				<div class="col-md-6"> -->
<!-- 					<label for="cc-number" class="form-label">Credit card number</label> -->
<!-- 					<input type="text" class="form-control" id="cc-number" placeholder="" required=""> -->
<!-- 				</div> -->

<!-- 				<div class="col-md-3"> -->
<!-- 					<label for="cc-expiration" class="form-label">Expiration</label> -->
<!-- 					<input type="text" class="form-control" id="cc-expiration" placeholder="" required=""> -->
<!-- 				</div> -->

<!-- 				<div class="col-md-3"> -->
<!-- 					<label for="cc-cvv" class="form-label">CVV</label> -->
<!-- 					<input type="text" class="form-control" id="cc-cvv" placeholder="" required=""> -->
<!-- 				</div> -->
<!-- 			</div> -->

<!-- 			<hr class="my-4"> -->

			<button type="submit" class="btn btn-primary waves-effect waves-light" id="insertBtn">가입</button>
		</form>
	</div>
</div>