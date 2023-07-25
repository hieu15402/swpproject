<%-- 
    Document   : booking
    Created on : May 29, 2023, 4:19:20 PM
    Author     : MSI AD
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>  
<%@page import="sample.dto.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html> 
<html lang="en">

    <!-- doccure/booking.jsp  30 Nov 2019 04:12:16 GMT -->
    <head>
        <meta charset="utf-8">
        <title>Doccure</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">

        <!-- Favicons -->
        <link href="assets/img/favicon.png" rel="icon">

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
        <%
            HttpSession session1 = request.getSession();
            UserDTO user = (UserDTO) session1.getAttribute("account");
            if (user == null) {
                response.sendRedirect("login.jsp");
            } else {
                String role = user.getRole().trim();
                if (!role.equalsIgnoreCase("4")) {
                    response.sendRedirect("index-2.jsp");
                }
            }
        %>
        <!-- Main Wrapper -->
        <div class="main-wrapper">

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
                            <img src="assets/img/final_logo.png" class="img-fluid" alt="Logo">
                        </a>
                    </div>
                    <div class="main-menu-wrapper">
                        <div class="menu-header">
                            <a href="index-2.jsp" class="menu-logo">
                                <img src="assets/img/logo.png" class="img-fluid" alt="Logo">
                            </a>
                            <a id="menu_close" class="menu-close" href="javascript:void(0);">
                                <i class="fas fa-times"></i>
                            </a>
                        </div>
                        <ul class="main-nav">
                            <li>
                                <a href="index-2.jsp">Home</a>
                            </li>

                            <li class="login-link">
                                <a href="login.jsp">Login / Signup</a>
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
                                        <img class="rounded-circle" src="${sessionScope.account.image}" width="31" alt="${sessionScope.account.username}">
                                    </span>
                                </a>
                                <div class="dropdown-menu dropdown-menu-right">
                                    <div class="user-header">
                                        <div class="avatar avatar-sm">
                                            <img src="${sessionScope.account.image}" alt="User Image" class="avatar-img rounded-circle">
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
                                    <!--                                    <a class="dropdown-item" href="#">My Appoinment</a>-->
                                    <a class="dropdown-item" href="patient-dashboard.jsp">Profile Settings</a>
                                    <a class="dropdown-item" href="MainController?action=logout">Logout</a>
                                </div>
                            </li>
                        </c:if>
                    </ul>

                </nav>
            </header>
            <!-- /Header -->

            <!-- Breadcrumb -->
            <div class="breadcrumb-bar">
                <div class="container-fluid">
                    <div class="row align-items-center">
                        <div class="col-md-12 col-12">
                            <nav aria-label="breadcrumb" class="page-breadcrumb">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="index-2.jsp">Home</a></li>
                                    <li class="breadcrumb-item active" aria-current="page">Booking</li>
                                </ol>
                            </nav>
                            <h2 class="breadcrumb-title">Booking</h2>
                        </div>
                    </div>
                </div>
            </div>
            <!-- /Breadcrumb -->

            <!-- Page Content -->
            <div class="content">
                <div class="container">

                    <div class="row">
                        <div class="col-12">

                            <!--                            <div class="card">
                                                            <div class="card-body">
                                                                <div class="booking-doc-info">
                                                                    <a href="doctor-profile.jsp" class="booking-doc-img">
                                                                        <img src="assets/img/doctors/doctor-thumb-02.jpg" alt="User Image">
                                                                    </a>
                                                                    <div class="booking-info">
                                                                        <h4><a href="doctor-profile.jsp">Dr. Darren Elder</a></h4>
                                                                        <div class="rating">
                                                                            <i class="fas fa-star filled"></i>
                                                                            <i class="fas fa-star filled"></i>
                                                                            <i class="fas fa-star filled"></i>
                                                                            <i class="fas fa-star filled"></i>
                                                                            <i class="fas fa-star"></i>
                                                                            <span class="d-inline-block average-rating">35</span>
                                                                        </div>
                                                                        <p class="text-muted mb-0"><i class="fas fa-map-marker-alt"></i> Newyork, USA</p>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>-->

                            <!-- Schedule Widget -->
                            <form action="MainController" method="POST">
                                <div class="card booking-schedule schedule-widget">

                                    <!-- Schedule Header -->
                                    <div class="schedule-header">
                                        <div class="row">
                                            <div class="col-md-12">
                                                <jsp:useBean id="BookingDAO" scope="request" class="sample.dao.BookingDAO"/>
                                                <!-- Day Slot -->
                                                <div class="day-slot">
                                                    <ul>
                                                        <!--                                                        <li class="left-arrow">
                                                                                                                    <a href="#">
                                                                                                                        <i class="fa fa-chevron-left"></i>
                                                                                                                    </a>
                                                                                                                </li>-->
                                                        <li>
                                                            <span>Mon</span>
                                                            <span class="slot-date">${BookingDAO.getWeekDates().get(0)}</span>
                                                        </li>
                                                        <li>
                                                            <span>Tue</span>
                                                            <span class="slot-date">${BookingDAO.getWeekDates().get(1)}</span>
                                                        </li>
                                                        <li>
                                                            <span>Wed</span>
                                                            <span class="slot-date">${BookingDAO.getWeekDates().get(2)}</span>
                                                        </li>
                                                        <li>
                                                            <span>Thu</span>
                                                            <span class="slot-date">${BookingDAO.getWeekDates().get(3)}</span>
                                                        </li>
                                                        <li>
                                                            <span>Fri</span>
                                                            <span class="slot-date">${BookingDAO.getWeekDates().get(4)}</span>
                                                        </li>
                                                        <li>
                                                            <span>Sat</span>
                                                            <span class="slot-date">${BookingDAO.getWeekDates().get(5)}</span>
                                                        </li>
                                                        <li>
                                                            <span>Sun</span>
                                                            <span class="slot-date">${BookingDAO.getWeekDates().get(6)}</span>
                                                        </li>
                                                        <!--                                                        <li class="right-arrow">
                                                                                                                    <a href="#">
                                                                                                                        <i class="fa fa-chevron-right"></i>
                                                                                                                    </a>
                                                                                                                </li>-->
                                                    </ul>
                                                </div>
                                                <!-- /Day Slot -->
                                            </div>
                                        </div>
                                    </div>
                                    <!-- /Schedule Header -->

                                    <!-- Schedule Content -->
                                    <div class="schedule-cont">
                                        <div class="row">
                                            <div class="col-md-12">

                                                <!-- Time Slot -->
                                                <div class="time-slot">
                                                    <ul class="clearfix">

                                                        <c:forEach begin="0" end="6" step="1" varStatus="loop">
                                                            <li>

                                                                <c:forEach items="${BookingDAO.slot}" var="slot">
                                                                    <c:choose>
                                                                        <c:when test="${BookingDAO.compareDate(BookingDAO.weekDates.get(loop.index), BookingDAO.today)<0}">
                                                                            <a style="" class="timing" href="#">
                                                                                <span>${slot.time_slot}</span>
                                                                            </a>
                                                                        </c:when>
                                                                        <c:when test="${!BookingDAO.checkValidateSlotBooking(BookingDAO.weekDates.get(loop.index), slot.slot_number)}">
                                                                            <a style="" class="timing" href="#">
                                                                                <span>${slot.time_slot}</span>
                                                                            </a>
                                                                        </c:when>
                                                                        <c:when test="${!BookingDAO.checkValidateTime(slot.slot_number, BookingDAO.weekDates.get(loop.index))}">
                                                                            <a style="" class="timing" href="#">
                                                                                <span>${slot.time_slot}</span>
                                                                            </a>
                                                                        </c:when>
                                                                        <c:when test="${!BookingDAO.checkValidateBookingInSlot(sessionScope.account.username, slot.slot_number, BookingDAO.weekDates.get(loop.index))}">
                                                                            <a style="" class="timing" href="#">
                                                                                <span>${slot.time_slot}</span>
                                                                            </a>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <a style="background: #42c0fb; color: white" onclick="Click(this)" class="timing" href="#">
                                                                                <span>${slot.time_slot}</span>
                                                                                <input type="hidden" class="valueBooking" name="" value="${slot.slot_number}" />             
                                                                                <input type="hidden" class="selectedDay" name="" value="${BookingDAO.weekDates.get(loop.index)}" />
                                                                            </a>

                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </c:forEach>

                                                            </li>
                                                        </c:forEach>
                                                    </ul>
                                                </div>
                                                <!-- /Time Slot -->

                                            </div>
                                        </div>
                                    </div>
                                    <!-- /Schedule Content -->

                                </div>
                                <!-- /Schedule Widget -->

                                <!-- Submit Section -->
                                <div class="submit-section proceed-btn text-right">
                                    <input class="btn btn-primary submit-btn" type="submit" name="action" value="Next" />
                                </div>
                            </form>
                            <!-- /Submit Section -->

                        </div>
                    </div>
                </div>

            </div>		
            <!-- /Page Content -->

            <!-- Footer -->
            <footer class="footer">

                <!-- Footer Top -->
                <div class="footer-top">
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-lg-3 col-md-6">

                                <!-- Footer Widget -->
                                <div class="footer-widget footer-about">
                                    <div class="footer-logo">
                                        <img src="assets/img/footer_logo.png" alt="logo">
                                    </div>
                                    <div class="footer-about-content">
                                        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. </p>
                                        <div class="social-icon">
                                            <ul>
                                                <li>
                                                    <a href="#" target="_blank"><i class="fab fa-facebook-f"></i> </a>
                                                </li>
                                                <li>
                                                    <a href="#" target="_blank"><i class="fab fa-twitter"></i> </a>
                                                </li>
                                                <li>
                                                    <a href="#" target="_blank"><i class="fab fa-linkedin-in"></i></a>
                                                </li>
                                                <li>
                                                    <a href="#" target="_blank"><i class="fab fa-instagram"></i></a>
                                                </li>
                                                <li>
                                                    <a href="#" target="_blank"><i class="fab fa-dribbble"></i> </a>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                                <!-- /Footer Widget -->

                            </div>

                            <div class="col-lg-3 col-md-6">

                                <!-- Footer Widget -->
                                <div class="footer-widget footer-menu">
                                    <h2 class="footer-title">For Patients</h2>
                                    <ul>
                                        <li><a href="search.jsp"><i class="fas fa-angle-double-right"></i> Search for Doctors</a></li>
                                        <li><a href="login.jsp"><i class="fas fa-angle-double-right"></i> Login</a></li>
                                        <li><a href="register.jsp"><i class="fas fa-angle-double-right"></i> Register</a></li>
                                        <li><a href="booking.jsp"><i class="fas fa-angle-double-right"></i> Booking</a></li>
                                        <li><a href="patient-dashboard.jsp"><i class="fas fa-angle-double-right"></i> Patient Dashboard</a></li>
                                    </ul>
                                </div>
                                <!-- /Footer Widget -->

                            </div>

                            <div class="col-lg-3 col-md-6">

                                <!-- Footer Widget -->
                                <div class="footer-widget footer-menu">
                                    <h2 class="footer-title">For Doctors</h2>
                                    <ul>
                                        <li><a href="appointments.jsp"><i class="fas fa-angle-double-right"></i> Appointments</a></li>
                                        <li><a href="chat.jsp"><i class="fas fa-angle-double-right"></i> Chat</a></li>
                                        <li><a href="login.jsp"><i class="fas fa-angle-double-right"></i> Login</a></li>
                                        <li><a href="doctor-register.jsp"><i class="fas fa-angle-double-right"></i> Register</a></li>
                                        <li><a href="doctor-dashboard.jsp"><i class="fas fa-angle-double-right"></i> Doctor Dashboard</a></li>
                                    </ul>
                                </div>
                                <!-- /Footer Widget -->

                            </div>

                            <div class="col-lg-3 col-md-6">

                                <!-- Footer Widget -->
                                <div class="footer-widget footer-contact">
                                    <h2 class="footer-title">Contact Us</h2>
                                    <div class="footer-contact-info">
                                        <div class="footer-address">
                                            <span><i class="fas fa-map-marker-alt"></i></span>
                                            <p> 3556  Beech Street, San Francisco,<br> California, CA 94108 </p>
                                        </div>
                                        <p>
                                            <i class="fas fa-phone-alt"></i>
                                            +1 315 369 5943
                                        </p>
                                        <p class="mb-0">
                                            <i class="fas fa-envelope"></i>
                                            doccure@example.com
                                        </p>
                                    </div>
                                </div>
                                <!-- /Footer Widget -->

                            </div>

                        </div>
                    </div>
                </div>
                <!-- /Footer Top -->

                <!-- Footer Bottom -->
                <div class="footer-bottom">
                    <div class="container-fluid">

                        <!-- Copyright -->
                        <div class="copyright">
                            <div class="row">
                                <div class="col-md-6 col-lg-6">
                                    <div class="copyright-text">
                                        <p class="mb-0"><a href="templateshub.net">Templates Hub</a></p>
                                    </div>
                                </div>
                                <div class="col-md-6 col-lg-6">

                                    <!-- Copyright Menu -->
                                    <div class="copyright-menu">
                                        <ul class="policy-menu">
                                            <li><a href="term-condition.jsp">Terms and Conditions</a></li>
                                            <li><a href="privacy-policy.jsp">Policy</a></li>
                                        </ul>
                                    </div>
                                    <!-- /Copyright Menu -->

                                </div>
                            </div>
                        </div>
                        <!-- /Copyright -->

                    </div>
                </div>
                <!-- /Footer Bottom -->

            </footer>
            <!-- /Footer -->

        </div>
        <!-- /Main Wrapper -->
        <script>
            var submitButton = document.querySelector(".submit-section .submit-btn");
            submitButton.disabled = true;
        </script>
        <!-- jQuery -->
        <script src="assets/js/jquery.min.js"></script>

        <!-- Bootstrap Core JS -->
        <script src="assets/js/popper.min.js"></script>
        <script src="assets/js/bootstrap.min.js"></script>

        <!-- Custom JS -->
        <script src="assets/js/script.js"></script>
        <script src="assets/js/bookingSchedule.js"></script>
    </body>

    <!-- doccure/booking.jsp  30 Nov 2019 04:12:16 GMT -->
</html>