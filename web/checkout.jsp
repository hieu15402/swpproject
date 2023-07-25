<%-- 
    Document   : checkout
    Created on : May 29, 2023, 4:20:18 PM
    Author     : MSI AD
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="sample.dto.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html> 
<html lang="en">

    <!-- doccure/checkout.jsp  30 Nov 2019 04:12:16 GMT -->
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
        <jsp:useBean id="PatientDAO" scope="request" class="sample.dao.PatientDAO"/>
        <jsp:useBean id="ServiceDAO" scope="request" class="sample.dao.ServiceDAO"/>
        <jsp:useBean id="UserDAO" scope="request" class="sample.dao.UserDAO"/>
        <c:if test="${empty requestScope.selectedDay or empty requestScope.selectedSlot}">
            <c:redirect url="booking.jsp" />
        </c:if>

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
                            <img src="assets/img/logo.png" class="img-fluid" alt="Logo">
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
                                    <li class="breadcrumb-item active" aria-current="page">Checkout</li>
                                </ol>
                            </nav>
                            <h2 class="breadcrumb-title">Checkout</h2>
                        </div>
                    </div>
                </div>
            </div>
            <!-- /Breadcrumb -->

            <!-- Page Content -->
            <div class="content">
                <div class="container">

                    <div class="row">
                        <div class="col-md-12 col-lg-12">
                            <div class="card">
                                <div class="card-body">

                                    <!-- Checkout Form -->
                                    <form action="MainController" method="POST">

                                        <!-- Personal Information -->
                                        <div class="info-widget">
                                            <h4 class="card-title">Personal Information</h4>
                                            <div class="row">
                                                <div class="col-md-6 col-sm-12">
                                                    <div class="form-group card-label">
                                                        <label>Service</label>
                                                        <select name="service" class="form-control">
                                                            <option disabled selected value="">Select your service</option>
                                                            <c:forEach var="service" items="${ServiceDAO.listServiceForBooking}">
                                                                <option value="${service.service_id}">${service.service_name}</option> 
                                                            </c:forEach>                                                           
                                                            <!-- Thêm các lựa chọn khác tại đây -->
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="col-md-6 col-sm-12">
                                                    <div class="form-group card-label">
                                                        <label>Patient</label>
                                                        <select name="patient" class="form-control">
                                                            <option disabled selected value="">Select your patient</option>
                                                            <c:forEach var="patient" items="${PatientDAO.getPatientBird(account.username)}">
                                                                <c:choose>
                                                                    <c:when test="${!PatientDAO.checkValidatePatient(account.username, patient.patient_id, requestScope.selectedDay, requestScope.selectedSlot)}">
                                                                        <option disabled="" style="color: red" value="${patient.patient_id}">${patient.name}</option>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <option value="${patient.patient_id}">${patient.name}</option> 
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </c:forEach>                                                         
                                                            <!-- Thêm các lựa chọn khác tại đây -->
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="col-md-6 col-sm-12">
                                                    <div class="form-group card-label">
                                                        <label>Doctor</label>
                                                        <select name="doctor" class="form-control">
                                                            <option disabled selected value="">Select your doctor</option>
                                                            <c:forEach var="doctor" items="${UserDAO.listDoctor}">
                                                                <c:choose>
                                                                    <c:when test="${!UserDAO.checkValidateBookingDoctor(doctor.username, requestScope.selectedSlot, requestScope.selectedDay)}">
                                                                        <option disabled="" style="color: red" value="">${doctor.fullname}</option>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <option value="${doctor.username}">${doctor.fullname}</option> 
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </c:forEach>                                                         
                                                            <!-- Thêm các lựa chọn khác tại đây -->
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="col-md-6 col-sm-12">
                                                    <div class="form-group card-label">
                                                        <label>Date</label>
                                                        <input readonly="" name="date" value="${requestScope.selectedDay}" class="form-control" type="text">
                                                    </div>
                                                </div>
                                                <div class="col-md-6 col-sm-12">
                                                    <div class="form-group card-label">
                                                        <label>Time</label>
                                                        <input readonly="" name="time_" value="${requestScope.time_slot}" class="form-control" type="text">
                                                        <input type="hidden" name="time" value="${requestScope.selectedSlot}" />
                                                    </div>
                                                </div>
                                            </div>
                                            <!--											<div class="exist-customer">Existing Customer? <a href="#">Click here to login</a></div>-->
                                        </div>
                                        <!-- /Personal Information -->

                                        <div class="payment-widget">
                                            <!--                                            <h4 class="card-title">Payment Method</h4>-->

                                            <!-- Credit Card Payment -->
                                            <!--                                            <div class="payment-list">
                                                                                            <label class="payment-radio credit-card-option">
                                                                                                <input type="radio" name="radio" checked>
                                                                                                <span class="checkmark"></span>
                                                                                                Credit card
                                                                                            </label>
                                                                                            <div class="row">
                                                                                                <div class="col-md-6">
                                                                                                    <div class="form-group card-label">
                                                                                                        <label for="card_name">Name on Card</label>
                                                                                                        <input class="form-control" id="card_name" type="text">
                                                                                                    </div>
                                                                                                </div>
                                                                                                <div class="col-md-6">
                                                                                                    <div class="form-group card-label">
                                                                                                        <label for="card_number">Card Number</label>
                                                                                                        <input class="form-control" id="card_number" placeholder="1234  5678  9876  5432" type="text">
                                                                                                    </div>
                                                                                                </div>
                                                                                                <div class="col-md-4">
                                                                                                    <div class="form-group card-label">
                                                                                                        <label for="expiry_month">Expiry Month</label>
                                                                                                        <input class="form-control" id="expiry_month" placeholder="MM" type="text">
                                                                                                    </div>
                                                                                                </div>
                                                                                                <div class="col-md-4">
                                                                                                    <div class="form-group card-label">
                                                                                                        <label for="expiry_year">Expiry Year</label>
                                                                                                        <input class="form-control" id="expiry_year" placeholder="YY" type="text">
                                                                                                    </div>
                                                                                                </div>
                                                                                                <div class="col-md-4">
                                                                                                    <div class="form-group card-label">
                                                                                                        <label for="cvv">CVV</label>
                                                                                                        <input class="form-control" id="cvv" type="text">
                                                                                                    </div>
                                                                                                </div>
                                                                                            </div>
                                                                                        </div>
                                                                                         /Credit Card Payment 
                                            
                                                                                         Paypal Payment 
                                                                                        <div class="payment-list">
                                                                                            <label class="payment-radio paypal-option">
                                                                                                <input type="radio" name="radio">
                                                                                                <span class="checkmark"></span>
                                                                                                Paypal
                                                                                            </label>
                                                                                        </div>
                                                                                         /Paypal Payment 
                                            
                                                                                         Terms Accept 
                                                                                        <div class="terms-accept">
                                                                                            <div class="custom-checkbox">
                                                                                                <input type="checkbox" id="terms_accept">
                                                                                                <label for="terms_accept">I have read and accept <a href="#">Terms &amp; Conditions</a></label>
                                                                                            </div>
                                                                                        </div>-->
                                            <!-- /Terms Accept -->

                                            <!-- Submit Section -->
                                            <div class="submit-section mt-4">
                                                <button type="submit" class="btn btn-primary submit-btn" name="action" value="CheckoutConfirm">Confirm</button>
                                            </div>
                                            <!-- /Submit Section -->

                                        </div>
                                    </form>
                                    <!-- /Checkout Form -->

                                </div>
                            </div>

                        </div>

                        <!--                        <div class="col-md-0 col-lg-0 theiaStickySidebar">
                        
                                                     Booking Summary 
                                                    <div class="card booking-card">
                                                        <div class="card-header">
                                                            <h4 class="card-title">Booking Summary</h4>
                                                        </div>
                                                        <div class="card-body">
                        
                                                             Booking Doctor Info 
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
                                                                    <div class="clinic-details">
                                                                        <p class="doc-location"><i class="fas fa-map-marker-alt"></i> Newyork, USA</p>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                             Booking Doctor Info 
                        
                                                            <div class="booking-summary">
                                                                <div class="booking-item-wrap">
                                                                    <ul class="booking-date">
                                                                        <li>Date <span>16 Nov 2019</span></li>
                                                                        <li>Time <span>10:00 AM</span></li>
                                                                    </ul>
                                                                    <ul class="booking-fee">
                                                                        <li>Consulting Fee <span>$100</span></li>
                                                                        <li>Booking Fee <span>$10</span></li>
                                                                        <li>Video Call <span>$50</span></li>
                                                                    </ul>
                                                                    <div class="booking-total">
                                                                        <ul class="booking-total-list">
                                                                            <li>
                                                                                <span>Total</span>
                                                                                <span class="total-cost">$160</span>
                                                                            </li>
                                                                        </ul>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                     /Booking Summary 
                        
                                                </div>-->
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

        <!-- jQuery -->
        <script src="assets/js/jquery.min.js"></script>

        <!-- Bootstrap Core JS -->
        <script src="assets/js/popper.min.js"></script>
        <script src="assets/js/bootstrap.min.js"></script>

        <!-- Sticky Sidebar JS -->
        <script src="assets/plugins/theia-sticky-sidebar/ResizeSensor.js"></script>
        <script src="assets/plugins/theia-sticky-sidebar/theia-sticky-sidebar.js"></script>

        <!-- Custom JS -->
        <script src="assets/js/script.js"></script>
        <script>
            // Lấy tham chiếu đến các phần tử cần kiểm tra
            var serviceElement = document.getElementsByName("service")[0];
            var patientElement = document.getElementsByName("patient")[0];
            var submitButton = document.querySelector(".submit-btn");
            submitButton.disabled = true;
// Thêm sự kiện "input" cho các phần tử
            serviceElement.addEventListener("input", toggleSubmitButtonState);
            patientElement.addEventListener("input", toggleSubmitButtonState);

// Kiểm tra và cập nhật trạng thái của nút submit
            function toggleSubmitButtonState() {
                if (serviceElement.value !== "" && patientElement.value !== "") {
                    submitButton.disabled = false; // Enable nút submit
                } else {
                    submitButton.disabled = true; // Disable nút submit
                }
            }

        </script>
    </body>

    <!-- doccure/checkout.jsp  30 Nov 2019 04:12:16 GMT -->
</html>