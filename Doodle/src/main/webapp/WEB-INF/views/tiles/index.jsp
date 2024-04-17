<%@page import="kr.or.ddit.util.etc.AuthManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!doctype html>
<html class="no-js" lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>Doodle</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- favicon ============================================ -->
    <link rel="shortcut icon" type="image/x-icon" href="/resources/kiaalap/img/favicon.ico">
    <!-- Google Fonts ============================================ -->
    <link href="https://fonts.googleapis.com/css?family=Roboto:100,300,400,700,900" rel="stylesheet">
    <!-- Bootstrap CSS ============================================ -->
    <link rel="stylesheet" href="/resources/kiaalap/css/bootstrap.min.css">
    <!-- Bootstrap CSS ============================================ -->
    <link rel="stylesheet" href="/resources/kiaalap/css/font-awesome.min.css">
    <!-- owl.carousel CSS ============================================ -->
    <link rel="stylesheet" href="/resources/kiaalap/css/owl.carousel.css">
    <link rel="stylesheet" href="/resources/kiaalap/css/owl.theme.css">
    <link rel="stylesheet" href="/resources/kiaalap/css/owl.transitions.css">
    <!-- animate CSS ============================================ -->
    <link rel="stylesheet" href="/resources/kiaalap/css/animate.css">
    <!-- normalize CSS ============================================ -->
    <link rel="stylesheet" href="/resources/kiaalap/css/normalize.css">
    <!-- meanmenu icon CSS ============================================ -->
    <link rel="stylesheet" href="/resources/kiaalap/css/meanmenu.min.css">
    <!-- main CSS ============================================ -->
    <link rel="stylesheet" href="/resources/kiaalap/css/main.css">
    <!-- educate icon CSS ============================================ -->
    <link rel="stylesheet" href="/resources/kiaalap/css/educate-custon-icon.css">
    <!-- morrisjs CSS ============================================ -->
    <link rel="stylesheet" href="/resources/kiaalap/css/morrisjs/morris.css">
    <!-- mCustomScrollbar CSS ============================================ -->
    <link rel="stylesheet" href="/resources/kiaalap/css/scrollbar/jquery.mCustomScrollbar.min.css">
    <!-- metisMenu CSS ============================================ -->
    <link rel="stylesheet" href="/resources/kiaalap/css/metisMenu/metisMenu.min.css">
    <link rel="stylesheet" href="/resources/kiaalap/css/metisMenu/metisMenu-vertical.css">
    <!-- calendar CSS ============================================ -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.css">
    <!-- style CSS ============================================ -->
    <link rel="stylesheet" href="/resources/kiaalap/style.css">
    <!-- responsive CSS ============================================ -->
    <link rel="stylesheet" href="/resources/kiaalap/css/responsive.css">
    <!-- modernizr JS ============================================ -->
    <script src="/resources/kiaalap/js/vendor/modernizr-2.8.3.min.js"></script>
    <!-- modal CSS ============================================ -->
    <link rel="stylesheet" href="/resources/kiaalap/css/modals.css">
    <!-- 폰트 -->
    <link rel="stylesheet" href="/resources/css/webfonts.css">
    <!-- 아이콘 -->
    <script src="https://kit.fontawesome.com/6a3d44fa80.js" crossorigin="anonymous"></script>
	<!-- sweetAlert2 ============================================ -->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
	<!-- 두들 권한 체크 함수 -->
	<jsp:include page="../util/secCheck.jsp" flush="false"/>
	<jsp:include page="../util/secSession.jsp" flush="false"/>
	<!-- 두들 CSS -->
	<link rel="stylesheet" href="/resources/css/commonCss.css">
	<!-- 두들 공통 함수 -->
	<script type="text/javascript" src="/resources/js/websocket.js"></script>  
	<script type="text/javascript" src="/resources/js/commonFunction.js"></script>  
	<script type="text/javascript" src="/resources/js/cjh.js"></script>  
	
</head>
<style>
	body{
		font-family: "Pretendard";
	
	}
</style>
<body>

    <!--[if lt IE 8]>
		<p class="browserupgrade">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p>
	<![endif]-->
    <!-- Start Left menu area -->
    <div class="left-sidebar-pro">
        <!-- aside 시작 -->
        	<tiles:insertAttribute name="aside" />
        <!-- aside 끝 -->
    </div>
    <!-- End Left menu area -->
    <!-- Start Welcome area -->
    <div class="all-content-wrapper">
        <div class="container-fluid">
            <div class="row">
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                    <div class="logo-pro">
<!--                         <a href="/resources/kiaalap/index.html"><img class="main-logo" src="/resources/kiaalap/img/logo/logo.png" alt="" /></a> -->
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Header 시작 ============================================-->
        <tiles:insertAttribute name="header" />
        <!-- Header 끝    ============================================ -->
        
        <!-- Body 시작 ============================================ -->
        <div class="analytics-sparkle-area" style="min-height: 849px; padding-top:100px;">
            <div class="container-fluid">
                <tiles:insertAttribute name="body" />
            </div>
        </div>
        <!-- Body 끝    ============================================ -->
        
        <!-- footer 시작 ============================================ -->
        <tiles:insertAttribute name="footer" />
        <!-- footer 끝    ============================================ -->
    </div>

    <!-- jquery	============================================ -->
    <script src="/resources/kiaalap/js/vendor/jquery-1.12.4.min.js"></script>
    <!-- bootstrap JS ============================================ -->
    <script src="/resources/kiaalap/js/bootstrap.min.js"></script>
    <!-- wow JS	============================================ -->
    <script src="/resources/kiaalap/js/wow.min.js"></script>
    <!-- price-slider JS ============================================ -->
    <script src="/resources/kiaalap/js/jquery-price-slider.js"></script>
    <!-- meanmenu JS ============================================ -->
    <script src="/resources/kiaalap/js/jquery.meanmenu.js"></script>
    <!-- owl.carousel JS ============================================ -->
    <script src="/resources/kiaalap/js/owl.carousel.min.js"></script>
    <!-- sticky JS ============================================ -->
    <script src="/resources/kiaalap/js/jquery.sticky.js"></script>
    <!-- scrollUp JS ============================================ -->
    <script src="/resources/kiaalap/js/jquery.scrollUp.min.js"></script>
    <!-- counterup JS ============================================ -->
    <script src="/resources/kiaalap/js/counterup/jquery.counterup.min.js"></script>
    <script src="/resources/kiaalap/js/counterup/waypoints.min.js"></script>
    <script src="/resources/kiaalap/js/counterup/counterup-active.js"></script>
    <!-- mCustomScrollbar JS ============================================ -->
    <script src="/resources/kiaalap/js/scrollbar/jquery.mCustomScrollbar.concat.min.js"></script>
    <script src="/resources/kiaalap/js/scrollbar/mCustomScrollbar-active.js"></script>
    <!-- metisMenu JS ============================================ -->
    <script src="/resources/kiaalap/js/metisMenu/metisMenu.min.js"></script>
    <script src="/resources/kiaalap/js/metisMenu/metisMenu-active.js"></script>
    <!-- morrisjs JS ============================================ -->
    <script src="/resources/kiaalap/js/morrisjs/raphael-min.js"></script>
    <script src="/resources/kiaalap/js/morrisjs/morris.js"></script>
    <script src="/resources/kiaalap/js/morrisjs/morris-active.js"></script>
    <!-- morrisjs JS ============================================ -->
    <script src="/resources/kiaalap/js/sparkline/jquery.sparkline.min.js"></script>
    <script src="/resources/kiaalap/js/sparkline/jquery.charts-sparkline.js"></script>
    <script src="/resources/kiaalap/js/sparkline/sparkline-active.js"></script>
    <!-- calendar JS ============================================ -->
    <script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.1/moment.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/locales-all.js"></script>
    <!-- plugins JS ============================================ -->
    <script src="/resources/kiaalap/js/plugins.js"></script>
    <!-- main JS ============================================ -->
    <script src="/resources/kiaalap/js/main.js"></script>
    <!-- tawk chat JS ============================================ -->
<!--     <script src="/resources/kiaalap/js/tawk-chat.js"></script> -->
    <script type="text/javascript">
    	$('#logoutBtn').on('click', function() {
			$('#logoutFrm').submit();
		});
    </script>
</body>

</html>