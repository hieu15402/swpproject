<%-- 
    Document   : headerIndex-2
    Created on : Jun 5, 2023, 5:40:20 PM
    Author     : Minh
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>  
<%@page import="java.util.List"%>
<%@page import="sample.dao.ServiceDAO"%>
<%@page import="sample.dto.ServiceDTO"%>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">
        <title>thedearbird | HomePage</title>

        <!-- Favicons -->
        <link rel="shortcut icon" type="image/x-icon" href="admin/assets/img/logo-icon.png">

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="assets/css/bootstrap.min.css">

        <!-- Fontawesome CSS -->
        <link rel="stylesheet" href="assets/plugins/fontawesome/css/fontawesome.min.css">
        <link rel="stylesheet" href="assets/plugins/fontawesome/css/all.min.css">

        <!-- Main CSS -->
        <link rel="stylesheet" href="assets/css/style.css">

        <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!--[if lt IE 9]>
                        <script src="assets/js/html5shiv.min.js"></script>
                        <script src="assets/js/respond.min.js"></script>
                <![endif]-->
    </head>
    <body>
        <!-- Header -->
        <header class="header">
            <nav class="navbar navbar-expand-lg header-nav">
                <div class="navbar-header">
                    <a id="mobile_btn" href="javascript:void(0);">
                        <span class="bar-icon">
                            <span></span>
                            <span></span>
                            <span></span>
                        </span>
                    </a>

                    <a href="index-2.jsp" class="navbar-brand logo">
                        <img style="object-fit: fill;" src="assets/img/final_logo.png" class="img-fluid" alt="Logo">
                    </a>
                </div>
                <div class="main-menu-wrapper">
                    <div class="menu-header">
                        <a href="index-2.jsp" class="menu-logo">
                            <img src="assets/img/final_logo.png" class="img-fluid" alt="Logo">
                        </a>
                        <a id="menu_close" class="menu-close" href="javascript:void(0);">
                            <i class="fas fa-times"></i>
                        </a>
                    </div>
                    <ul class="main-nav">
                        <li class="active">
                            <a href="index-2.jsp">Home</a>
                        </li>
                        <!-- <li class="has-submenu">
                                <a href="#">Doctors <i class="fas fa-chevron-down"></i></a>
                                <ul class="submenu">
                                        <li><a href="doctor-dashboard.jsp">Doctor Dashboard</a></li>
                                        <li><a href="appointments.jsp">Appointments</a></li>
                                        <li><a href="schedule-timings.jsp">Schedule Timing</a></li>
                                        <li><a href="my-patients.jsp">Patients List</a></li>
                                        <li><a href="patient-profile.jsp">Patients Profile</a></li>
                                        <li><a href="chat-doctor.jsp">Chat</a></li>
                                        <li><a href="invoices.jsp">Invoices</a></li>
                                        <li><a href="doctor-profile-settings.jsp">Profile Settings</a></li>
                                        <li><a href="reviews.jsp">Reviews</a></li>
                                        <li><a href="doctor-register.jsp">Doctor Register</a></li>
                                </ul>
                        </li>
                        <li class="has-submenu">
                                <a href="#">Patients <i class="fas fa-chevron-down"></i></a>
                                <ul class="submenu">
                                        <li><a href="search.jsp">Search Doctor</a></li>
                                        <li><a href="doctor-profile.jsp">Doctor Profile</a></li>
                                        <li><a href="booking.jsp">Booking</a></li>
                                        <li><a href="checkout.jsp">Checkout</a></li>
                                        <li><a href="booking-success.jsp">Booking Success</a></li>
                                        <li><a href="patient-dashboard.jsp">Patient Dashboard</a></li>
                                        <li><a href="favourites.jsp">Favourites</a></li>
                                        <li><a href="chat.jsp">Chat</a></li>
                                        <li><a href="profile-settings.jsp">Profile Settings</a></li>
                                        <li><a href="change-password.jsp">Change Password</a></li>
                                </ul>
                        </li>
                        <li class="has-submenu">
                                <a href="#">Pages <i class="fas fa-chevron-down"></i></a>
                                <ul class="submenu">
                                        <li><a href="voice-call.jsp">Voice Call</a></li>
                                        <li><a href="video-call.jsp">Video Call</a></li>
                                        <li><a href="search.jsp">Search Doctors</a></li>
                                        <li><a href="calendar.jsp">Calendar</a></li>
                                        <li><a href="components.jsp">Components</a></li>
                                        <li class="has-submenu">
                                                <a href="invoices.jsp">Invoices</a>
                                                <ul class="submenu">
                                                        <li><a href="invoices.jsp">Invoices</a></li>
                                                        <li><a href="invoice-view.jsp">Invoice View</a></li>
                                                </ul>
                                        </li>
                                        <li><a href="blank-page.jsp">Starter Page</a></li>
                                        <li><a href="login.jsp">Login</a></li>
                                        <li><a href="register.jsp">Register</a></li>
                                        <li><a href="forgot-password.jsp">Forgot Password</a></li>
                                </ul>
                        </li> -->
                        <li>
                            <a href="" >Blog</a>
                        </li>


                    </ul>
                </div>
                <ul class="nav header-navbar-rht">
                    <li class="nav-item contact-item">
                        <div class="header-contact-img">
                            <i class="far fa-hospital"></i>
                        </div>
                        <div class="header-contact-detail">
                            <p class="contact-header">Contact</p>
                            <p class="contact-info-header"> +1 315 369 5943</p>
                        </div>
                    </li>
                    <c:if test="${sessionScope.account == null}">
                        <li class="nav-item">
                            <a class="nav-link header-login" href="login.jsp">login / Signup </a>
                        </li>
                    </c:if>
                    <c:if test="${sessionScope.account != null}">
                        <li class="nav-item dropdown has-arrow logged-item">
                            <a href="#" class="dropdown-toggle nav-link" data-toggle="dropdown">
                                <span class="user-img">
                                    <img class="rounded-circle" src="assets/img/user.png" width="31" alt="${sessionScope.account.username}">
                                </span>
                            </a>
                            <div class="dropdown-menu dropdown-menu-right">
                                <div class="user-header">
                                    <div class="avatar avatar-sm">
                                        <img src="assets/img/user.png" alt="User Image" class="avatar-img rounded-circle">
                                    </div>
                                    <div class="user-text">
                                        <h6>${sessionScope.account.fullname}</h6>
                                        <c:set var="roleName" value="${sessionScope.account.role}"/>
                                        <c:if test="${fn:containsIgnoreCase(roleName, '1')}">
                                            <p class="text-muted mb-0">Administrator</p>
                                        </c:if>
                                        <c:if test="${fn:containsIgnoreCase(roleName, '2')}">
                                            <p class="text-muted mb-0">Staff</p>
                                        </c:if>
                                        <c:if test="${fn:containsIgnoreCase(roleName, '3')}">
                                            <p class="text-muted mb-0">Doctor</p>
                                        </c:if>
                                        <c:if test="${fn:containsIgnoreCase(roleName, '4')}">
                                            <p class="text-muted mb-0">Customer</p>
                                        </c:if>
                                        <c:if test="${fn:containsIgnoreCase(roleName, '5')}">
                                            <p class="text-muted mb-0">Manager</p>
                                        </c:if>
                                    </div>
                                </div>
                                <a class="dropdown-item" href="#">My Appoinment</a>
                                <a class="dropdown-item" href="#">Profile Settings</a>
                                <a class="dropdown-item" href="MainController?action=logout">Logout</a>
                            </div>
                        </li>
                    </c:if>

                </ul>
            </nav>

        </header>
        <!-- /Header -->
        <!-- jQuery -->
        <script src="assets/js/jquery.min.js"></script>

        <!-- Bootstrap Core JS -->
        <script src="assets/js/popper.min.js"></script>
        <script src="assets/js/bootstrap.min.js"></script>

        <!-- Slick JS -->
        <script src="assets/js/slick.js"></script>

        <!-- Custom JS -->
        <script src="assets/js/script.js"></script>

    </body>
</html>
