<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>  
<nav id="sidebar" class="">
    <div class="sidebar-header">
        <a href="index.html"><img class="main-logo" src="/resources/kiaalap/img/logo/logo.png" alt="" /></a>
        <strong><a href="index.html"><img src="/resources/kiaalap/img/logo/logosn.png" alt="" /></a></strong>
    </div>
    <div class="left-custom-menu-adp-wrap comment-scrollbar">
        <nav class="sidebar-nav left-sidebar-menu-pro">
            <ul class="metismenu" id="menu1">
                <li class="active">
                    <a class="has-arrow" href="index.html">
   <span class="educate-icon educate-home icon-wrap"></span>
   <span class="mini-click-non">Education</span>
</a>
                    <ul class="submenu-angle" aria-expanded="true">
                        <li><a title="Dashboard v.1" href="/resources/kiaalap/index.html"><span class="mini-sub-pro">Dashboard v.1</span></a></li>
                        <li><a title="Dashboard v.2" href="/resources/kiaalap/index-1.html"><span class="mini-sub-pro">Dashboard v.2</span></a></li>
                        <li><a title="Dashboard v.3" href="/resources/kiaalap/index-2.html"><span class="mini-sub-pro">Dashboard v.3</span></a></li>
                        <li><a title="Analytics" href="/resources/kiaalap/analytics.html"><span class="mini-sub-pro">Analytics</span></a></li>
                        <li><a title="Widgets" href="/resources/kiaalap/widgets.html"><span class="mini-sub-pro">Widgets</span></a></li>
                    </ul>
                </li>
                <li>
                    <a title="Landing Page" href="/resources/kiaalap/events.html" aria-expanded="false"><span class="educate-icon educate-event icon-wrap sub-icon-mg" aria-hidden="true"></span> <span class="mini-click-non">Event</span></a>
                </li>
                <li>
                    <a class="has-arrow" href="all-professors.html" aria-expanded="false"><span class="educate-icon educate-professor icon-wrap"></span> <span class="mini-click-non">Professors</span></a>
                    <ul class="submenu-angle" aria-expanded="false">
                        <li><a title="All Professors" href="/resources/kiaalap/all-professors.html"><span class="mini-sub-pro">All Professors</span></a></li>
                        <li><a title="Add Professor" href="/resources/kiaalap/add-professor.html"><span class="mini-sub-pro">Add Professor</span></a></li>
                        <li><a title="Edit Professor" href="/resources/kiaalap/edit-professor.html"><span class="mini-sub-pro">Edit Professor</span></a></li>
                        <li><a title="Professor Profile" href="/resources/kiaalap/professor-profile.html"><span class="mini-sub-pro">Professor Profile</span></a></li>
                    </ul>
                </li>
                <li>
                    <a class="has-arrow" href="/resources/kiaalap/all-students.html" aria-expanded="false"><span class="educate-icon educate-student icon-wrap"></span> <span class="mini-click-non">Students</span></a>
                    <ul class="submenu-angle" aria-expanded="false">
                        <li><a title="All Students" href="/resources/kiaalap/all-students.html"><span class="mini-sub-pro">All Students</span></a></li>
                        <li><a title="Add Students" href="/resources/kiaalap/add-student.html"><span class="mini-sub-pro">Add Student</span></a></li>
                        <li><a title="Edit Students" href="/resources/kiaalap/edit-student.html"><span class="mini-sub-pro">Edit Student</span></a></li>
                        <li><a title="Students Profile" href="/resources/kiaalap/student-profile.html"><span class="mini-sub-pro">Student Profile</span></a></li>
                    </ul>
                </li>
                <li>
                    <a class="has-arrow" href="/resources/kiaalap/all-courses.html" aria-expanded="false"><span class="educate-icon educate-course icon-wrap"></span> <span class="mini-click-non">Courses</span></a>
                    <ul class="submenu-angle" aria-expanded="false">
                        <li><a title="All Courses" href="/resources/kiaalap/all-courses.html"><span class="mini-sub-pro">All Courses</span></a></li>
                        <li><a title="Add Courses" href="/resources/kiaalap/add-course.html"><span class="mini-sub-pro">Add Course</span></a></li>
                        <li><a title="Edit Courses" href="/resources/kiaalap/edit-course.html"><span class="mini-sub-pro">Edit Course</span></a></li>
                        <li><a title="Courses Profile" href="/resources/kiaalap/course-info.html"><span class="mini-sub-pro">Courses Info</span></a></li>
                        <li><a title="Product Payment" href="/resources/kiaalap/course-payment.html"><span class="mini-sub-pro">Courses Payment</span></a></li>
                    </ul>
                </li>
                <li>
                    <a class="has-arrow" href="/resources/kiaalap/all-courses.html" aria-expanded="false"><span class="educate-icon educate-library icon-wrap"></span> <span class="mini-click-non">Library</span></a>
                    <ul class="submenu-angle" aria-expanded="false">
                        <li><a title="All Library" href="/resources/kiaalap/library-assets.html"><span class="mini-sub-pro">Library Assets</span></a></li>
                        <li><a title="Add Library" href="/resources/kiaalap/add-library-assets.html"><span class="mini-sub-pro">Add Library Asset</span></a></li>
                        <li><a title="Edit Library" href="/resources/kiaalap/edit-library-assets.html"><span class="mini-sub-pro">Edit Library Asset</span></a></li>
                    </ul>
                </li>
                <li>
                    <a class="has-arrow" href="/resources/kiaalap/all-courses.html" aria-expanded="false"><span class="educate-icon educate-department icon-wrap"></span> <span class="mini-click-non">Departments</span></a>
                    <ul class="submenu-angle" aria-expanded="false">
                        <li><a title="Departments List" href="/resources/kiaalap/departments.html"><span class="mini-sub-pro">Departments List</span></a></li>
                        <li><a title="Add Departments" href="/resources/kiaalap/add-department.html"><span class="mini-sub-pro">Add Departments</span></a></li>
                        <li><a title="Edit Departments" href="/resources/kiaalap/edit-department.html"><span class="mini-sub-pro">Edit Departments</span></a></li>
                    </ul>
                </li>
                <li>
                    <a class="has-arrow" href="resources/kiaalap/mailbox.html" aria-expanded="false"><span class="educate-icon educate-message icon-wrap"></span> <span class="mini-click-non">Mailbox</span></a>
                    <ul class="submenu-angle" aria-expanded="false">
                        <li><a title="Inbox" href="/resources/kiaalap/mailbox.html"><span class="mini-sub-pro">Inbox</span></a></li>
                        <li><a title="View Mail" href="/resources/kiaalap/mailbox-view.html"><span class="mini-sub-pro">View Mail</span></a></li>
                        <li><a title="Compose Mail" href="/resources/kiaalap/mailbox-compose.html"><span class="mini-sub-pro">Compose Mail</span></a></li>
                    </ul>
                </li>
                <li>
                    <a class="has-arrow" href="/resources/kiaalap/mailbox.html" aria-expanded="false"><span class="educate-icon educate-interface icon-wrap"></span> <span class="mini-click-non">Interface</span></a>
                    <ul class="submenu-angle interface-mini-nb-dp" aria-expanded="false">
                        <li><a title="Google Map" href="/resources/kiaalap/google-map.html"><span class="mini-sub-pro">Google Map</span></a></li>
                        <li><a title="Data Maps" href="/resources/kiaalap/data-maps.html"><span class="mini-sub-pro">Data Maps</span></a></li>
                        <li><a title="Pdf Viewer" href="/resources/kiaalap/pdf-viewer.html"><span class="mini-sub-pro">Pdf Viewer</span></a></li>
                        <li><a title="X-Editable" href="/resources/kiaalap/x-editable.html"><span class="mini-sub-pro">X-Editable</span></a></li>
                        <li><a title="Code Editor" href="/resources/kiaalap/code-editor.html"><span class="mini-sub-pro">Code Editor</span></a></li>
                        <li><a title="Tree View" href="/resources/kiaalap/tree-view.html"><span class="mini-sub-pro">Tree View</span></a></li>
                        <li><a title="Preloader" href="/resources/kiaalap/preloader.html"><span class="mini-sub-pro">Preloader</span></a></li>
                        <li><a title="Images Cropper" href="/resources/kiaalap/images-cropper.html"><span class="mini-sub-pro">Images Cropper</span></a></li>
                    </ul>
                </li>
                <li>
                    <a class="has-arrow" href="/resources/kiaalap/mailbox.html" aria-expanded="false"><span class="educate-icon educate-charts icon-wrap"></span> <span class="mini-click-non">Charts</span></a>
                    <ul class="submenu-angle chart-mini-nb-dp" aria-expanded="false">
                        <li><a title="Bar Charts" href="/resources/kiaalap/bar-charts.html"><span class="mini-sub-pro">Bar Charts</span></a></li>
                        <li><a title="Line Charts" href="/resources/kiaalap/line-charts.html"><span class="mini-sub-pro">Line Charts</span></a></li>
                        <li><a title="Area Charts" href="/resources/kiaalap/area-charts.html"><span class="mini-sub-pro">Area Charts</span></a></li>
                        <li><a title="Rounded Charts" href="/resources/kiaalap/rounded-chart.html"><span class="mini-sub-pro">Rounded Charts</span></a></li>
                        <li><a title="C3 Charts" href="/resources/kiaalap/c3.html"><span class="mini-sub-pro">C3 Charts</span></a></li>
                        <li><a title="Sparkline Charts" href="/resources/kiaalap/sparkline.html"><span class="mini-sub-pro">Sparkline Charts</span></a></li>
                        <li><a title="Peity Charts" href="/resources/kiaalap/peity.html"><span class="mini-sub-pro">Peity Charts</span></a></li>
                    </ul>
                </li>
                <li>
                    <a class="has-arrow" href="/resources/kiaalap/mailbox.html" aria-expanded="false"><span class="educate-icon educate-data-table icon-wrap"></span> <span class="mini-click-non">Data Tables</span></a>
                    <ul class="submenu-angle" aria-expanded="false">
                        <li><a title="Peity Charts" href="/resources/kiaalap/static-table.html"><span class="mini-sub-pro">Static Table</span></a></li>
                        <li><a title="Data Table" href="/resources/kiaalap/data-table.html"><span class="mini-sub-pro">Data Table</span></a></li>
                    </ul>
                </li>
                <li>
                    <a class="has-arrow" href="/resources/kiaalap/mailbox.html" aria-expanded="false"><span class="educate-icon educate-form icon-wrap"></span> <span class="mini-click-non">Forms Elements</span></a>
                    <ul class="submenu-angle form-mini-nb-dp" aria-expanded="false">
                        <li><a title="Basic Form Elements" href="/resources/kiaalap/basic-form-element.html"><span class="mini-sub-pro">Bc Form Elements</span></a></li>
                        <li><a title="Advance Form Elements" href="/resources/kiaalap/advance-form-element.html"><span class="mini-sub-pro">Ad Form Elements</span></a></li>
                        <li><a title="Password Meter" href="/resources/kiaalap/password-meter.html"><span class="mini-sub-pro">Password Meter</span></a></li>
                        <li><a title="Multi Upload" href="/resources/kiaalap/multi-upload.html"><span class="mini-sub-pro">Multi Upload</span></a></li>
                        <li><a title="Text Editor" href="/resources/kiaalap/tinymc.html"><span class="mini-sub-pro">Text Editor</span></a></li>
                        <li><a title="Dual List Box" href="/resources/kiaalap/dual-list-box.html"><span class="mini-sub-pro">Dual List Box</span></a></li>
                    </ul>
                </li>
                <li>
                    <a class="has-arrow" href="/resources/kiaalap/mailbox.html" aria-expanded="false"><span class="educate-icon educate-apps icon-wrap"></span> <span class="mini-click-non">App views</span></a>
                    <ul class="submenu-angle app-mini-nb-dp" aria-expanded="false">
                        <li><a title="Notifications" href="/resources/kiaalap/notifications.html"><span class="mini-sub-pro">Notifications</span></a></li>
                        <li><a title="Alerts" href="/resources/kiaalap/alerts.html"><span class="mini-sub-pro">Alerts</span></a></li>
                        <li><a title="Modals" href="/resources/kiaalap/modals.html"><span class="mini-sub-pro">Modals</span></a></li>
                        <li><a title="Buttons" href="/resources/kiaalap/buttons.html"><span class="mini-sub-pro">Buttons</span></a></li>
                        <li><a title="Tabs" href="/resources/kiaalap/tabs.html"><span class="mini-sub-pro">Tabs</span></a></li>
                        <li><a title="Accordion" href="/resources/kiaalap/accordion.html"><span class="mini-sub-pro">Accordion</span></a></li>
                    </ul>
                </li>
                <li id="removable">
                    <a class="has-arrow" href="#" aria-expanded="false"><span class="educate-icon educate-pages icon-wrap"></span> <span class="mini-click-non">Pages</span></a>
                    <ul class="submenu-angle page-mini-nb-dp" aria-expanded="false">
                        <li><a title="Login" href="/resources/kiaalap/login.html"><span class="mini-sub-pro">Login</span></a></li>
                        <li><a title="Register" href="/resources/kiaalap/register.html"><span class="mini-sub-pro">Register</span></a></li>
                        <li><a title="Lock" href="/resources/kiaalap/lock.html"><span class="mini-sub-pro">Lock</span></a></li>
                        <li><a title="Password Recovery" href="/resources/kiaalap/password-recovery.html"><span class="mini-sub-pro">Password Recovery</span></a></li>
                        <li><a title="404 Page" href="/resources/kiaalap/404.html"><span class="mini-sub-pro">404 Page</span></a></li>
                        <li><a title="500 Page" href="/resources/kiaalap/500.html"><span class="mini-sub-pro">500 Page</span></a></li>
                    </ul>
                </li>
            </ul>
        </nav>
    </div>
</nav>