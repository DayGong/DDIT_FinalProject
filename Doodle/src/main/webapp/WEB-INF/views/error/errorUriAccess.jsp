<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<section class="content">
	<div class="error-page">
		<h2 class="headline text-warning">접근 불가</h2>
		<div class="error-content">
			<h3>
				<i class="fas fa-exclamation-triangle text-warning"></i> Not Access Page
			</h3>
			<p>
				접근할 수 없는 페이지입니다. 만약, 메인으로 이동하고자 하면
				<a href="/main">메인</a> 을 클릭해주세요.
			</p>
			<form class="search-form">
				<div class="input-group">
					<input type="text" name="search" class="form-control"
						placeholder="Search">
					<div class="input-group-append">
						<button type="submit" name="submit" class="btn btn-warning">
							<i class="fas fa-search"></i>
						</button>
					</div>
				</div>

			</form>
		</div>

	</div>

</section>