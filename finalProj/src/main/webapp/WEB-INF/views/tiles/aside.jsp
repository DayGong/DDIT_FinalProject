<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<aside class="main-sidebar sidebar-dark-primary elevation-4" style="background-color:#111;">
	<!-- Brand Logo -->
	<a href="javascript:void(0);" class="brand-link"> 
	<img src="/resources/adminlte/dist/img/AdminLTELogo.png" alt="AdminLTE Logo" class="brand-image img-circle elevation-3" style="opacity: .8"> 
		<span class="brand-text font-weight-light" style="letter-spacing: 1.5px; font-weight:700;" >학습관리시스템</span>
	</a>

	<!-- Sidebar -->
	<div class="sidebar">
		<!-- Sidebar user panel (optional) -->
		<!-- ///// 로그인 안했을 때  시작 //////////// -->
		<sec:authorize access="isAnonymous()">
		<div class="user-panel mt-3 pb-3 mb-3 d-flex">
			<div class="image">
				<img src="/resources/adminlte/dist/img/user2-160x160.jpg"
					class="img-circle elevation-2" alt="User Image">
			</div>
			<div class="info">
				<a href="javascript:void(0);" class="d-block" style="color:#c2c7d0;">Alexander Pierce</a>
			</div>
		</div>
		</sec:authorize>
		<!-- ///// 로그인 안했을 때  끝 //////////// -->
		<!-- ///// 로그인 했을 때(왔어?) 시작 //////////// -->
		<sec:authorize access="isAuthenticated()">
			<sec:authentication property="principal.studVO" var="studVO" />
		<div class="user-panel mt-3 pb-3 mb-3 d-flex">
			<div class="image">
				<img src="/resources/images/hongdg.jpg"
					class="img-circle elevation-2" alt="User Image">
			</div>
			<div class="info">
				<a href="javascript:void(0);" class="d-block">${studVO.studNm}(${studVO.studId})</a>
				<form action="/logout" method="post">
					<button type="submit" class="btn btn-block btn-outline-primary btn-xs">로그아웃</button>
					<sec:csrfInput />
				</form>
			</div>
		</div>
		</sec:authorize>
		<!-- ///// 로그인 했을 때  끝 //////////// -->

		<!-- SidebarSearch Form -->
		<div class="form-inline">
			<div class="input-group" data-widget="sidebar-search">
				<input class="form-control form-control-sidebar" type="search" placeholder="Search" aria-label="Search" style="background-color: #313131; border: 1px solid #56606a;">
				<div class="input-group-append">
					<button class="btn btn-sidebar" style="background-color: #313131; border: 1px solid #56606a; height:39px;">
						<i class="fas fa-search fa-fw"></i>
					</button>
				</div>
			</div>
		</div>

		<!-- Sidebar Menu -->
		<nav class="mt-2">
			<ul class="nav nav-pills nav-sidebar flex-column"
				data-widget="treeview" role="menu" data-accordion="false">
				<!-- Add icons to the links using the .nav-icon class
				with font-awesome or any other icon font library -->
				<li class="nav-item menu-open">
					<a href="javascript:void(0);" class="nav-link"> 
					<i class="nav-icon fas fa-tachometer-alt"></i>
						<p>
							Dashboard <i class="right fas fa-angle-left"></i>
						</p>
				</a>
					<ul class="nav nav-treeview">
						<li class="nav-item">
							<a href="/user/list" class="nav-link"> 
								<i class="far fa-circle nav-icon"></i>
								<p>일반게시판</p>
							</a>
						</li>
						<li class="nav-item"><a href="javascript:void(0);" class="nav-link">
								<i class="far fa-circle nav-icon"></i>
								<p>공지사항</p>
						</a></li>
						<li class="nav-item"><a href="javascript:void(0);" class="nav-link">
								<i class="far fa-circle nav-icon"></i>
								<p>Dashboard v3</p>
						</a></li>
					</ul></li>
				<li class="nav-item"><a href="javascript:void(0);"
					class="nav-link"> <i class="nav-icon fas fa-th"></i>
						<p>
							Widgets <span class="right badge badge-danger">New</span>
						</p>
				</a></li>
				<li class="nav-header">EXAMPLES</li>
				<li class="nav-item"><a href="pages/calendar.html"
					class="nav-link"> <i class="nav-icon far fa-calendar-alt"></i>
						<p>
							Calendar <span class="badge badge-info right">2</span>
						</p>
				</a></li>
				<li class="nav-item"><a href="#" class="nav-link"> <i
						class="nav-icon far fa-envelope"></i>
						<p>
							Mailbox <i class="fas fa-angle-left right"></i>
						</p>
				</a>
					<ul class="nav nav-treeview">
						<li class="nav-item"><a href="pages/mailbox/mailbox.html"
							class="nav-link"> <i class="far fa-circle nav-icon"></i>
								<p>Inbox</p>
						</a></li>
						<li class="nav-item"><a href="pages/mailbox/compose.html"
							class="nav-link"> <i class="far fa-circle nav-icon"></i>
								<p>Compose</p>
						</a></li>
						<li class="nav-item"><a href="pages/mailbox/read-mail.html"
							class="nav-link"> <i class="far fa-circle nav-icon"></i>
								<p>Read</p>
						</a></li>
					</ul></li>
			</ul>
		</nav>
		<!-- /.sidebar-menu -->
	</div>
	<!-- /.sidebar -->
</aside>