<%-- 
    Document   : patient-dashboard
    Created on : May 29, 2023, 5:13:28 PM
    Author     : MSI AD
--%>

<%@page import="sample.dto.FeedbackDTO"%>
<%@page import="sample.dao.FeedbackDAO"%>
<%@page import="sample.dto.AppointmentDTO"%>
<%@page import="sample.dao.AppointmentDAO"%>
<%@page import="sample.dto.MedicalRecordDTO"%>
<%@page import="java.util.List"%>
<%@page import="sample.dao.MedicalRecordDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="sample.dao.PatientDAO"%>
<%@page import="sample.dto.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>  
<!DOCTYPE html> 
<html lang="en">

    <!-- doccure/patient-dashboard.jsp  30 Nov 2019 04:12:16 GMT -->
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

        <link rel="stylesheet" href="admin/assets/plugins/datatables/datatables.min.css">
        <!-- Main CSS -->
        <link rel="stylesheet" href="assets/css/style.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />

        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!--[if lt IE 9]>
                <script src="assets/js/html5shiv.min.js"></script>
                <script src="assets/js/respond.min.js"></script>
        <![endif]-->


    </head>
    <body>




        <%
            HttpSession s = request.getSession();
            UserDTO user = (UserDTO) s.getAttribute("account");
            if (user != null) {

            } else {
                response.sendRedirect("login.jsp");
            }
            String role = user.getRole().trim();
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
                            <img style="object-fit: fill;" src="assets/img/final_logo.png" class="img-fluid" alt="Logo">
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
                                <a href="index_logged.jsp">Home</a>
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
                            <li class="has-submenu active">
                                    <a href="#">Patients <i class="fas fa-chevron-down"></i></a>
                                    <ul class="submenu">
                                            <li><a href="search.jsp">Search Doctor</a></li>
                                            <li><a href="doctor-profile.jsp">Doctor Profile</a></li>
                                            <li><a href="booking.jsp">Booking</a></li>
                                            <li><a href="checkout.jsp">Checkout</a></li>
                                            <li><a href="booking-success.jsp">Booking Success</a></li>
                                            <li class="active"><a href="patient-dashboard.jsp">Patient Dashboard</a></li>
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
                                <a href="blank-page.jsp" target="_blank">Blog</a>
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

                        <!-- User Menu -->
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
                                    <a class="dropdown-item" href="#">Profile Settings</a>
                                    <a class="dropdown-item" href="MainController?action=logout">Logout</a>
                                </div>
                            </li>
                        </c:if>
                        <!-- /User Menu -->

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
                                    <li class="breadcrumb-item active" aria-current="page">My Appoinment</li>
                                </ol>
                            </nav>
                            <h2 class="breadcrumb-title">My Appoinment</h2>
                        </div>
                    </div>
                </div>
            </div>
            <!-- /Breadcrumb -->

            <!-- Page Content -->
            <div class="content">
                <div class="container-fluid">

                    <div class="row">

                        <!-- Profile Sidebar -->
                        <div class="col-md-5 col-lg-4 col-xl-3 theiaStickySidebar">
                            <div class="profile-sidebar">
                                <div class="widget-profile pro-widget-content">
                                    <div class="profile-info-widget">
                                        <c:if test="${sessionScope.account != null}">
                                            <a href="#" class="booking-doc-img">
                                                <img src="${sessionScope.account.image}" alt="User Image">
                                            </a>
                                            <div class="profile-det-info">
                                                <h3>${sessionScope.account.fullname}</h3>

                                            </div>
                                        </c:if>
                                    </div>
                                </div>
                                <div class="dashboard-widget">
                                    <nav class="dashboard-menu">
                                        <ul>
                                            <%
                                                if (role.equalsIgnoreCase("4")) {
                                            %>
                                            <li class="active">
                                                <a type="button" onclick="Dashboard()">
                                                    <i class="fas fa-columns"></i>
                                                    <span>My Appoinment</span>
                                                </a>
                                            </li>

                                            <li>
                                                <a type="button" onclick="UserProfile()">
                                                    <i class="fas fa-user-cog"></i>
                                                    <span>Profile Settings</span>
                                                </a>
                                            </li>
                                            <li>
                                                <a type="button" onclick="BirdProfile()">
                                                    <i class="fas fa-crow" style="color: #6c7689;"></i>
                                                    <span>Bird Settings</span>
                                                </a>
                                            </li>
                                            <li>
                                                <a type="button" onclick="ChangePass()">
                                                    <i class="fas fa-lock"></i>
                                                    <span>Change Password</span>
                                                </a>
                                            </li>
                                            <li>
                                                <a href="MainController?action=logout">
                                                    <i class="fas fa-sign-out-alt"></i>
                                                    <span>Logout</span>
                                                </a>
                                            </li>
                                            <%
                                            } else {
                                            %>
                                           

                                            <li>
                                                <a type="button" onclick="UserProfile()">
                                                    <i class="fas fa-user-cog"></i>
                                                    <span>Profile Settings</span>
                                                </a>
                                            </li>
                                           
                                            <li>
                                                <a type="button" onclick="ChangePass()">
                                                    <i class="fas fa-lock"></i>
                                                    <span>Change Password</span>
                                                </a>
                                            </li>
                                            <li>
                                                <a href="MainController?action=logout">
                                                    <i class="fas fa-sign-out-alt"></i>
                                                    <span>Logout</span>
                                                </a>
                                            </li>
                                            <%
                                                }
                                            %>

                                        </ul>
                                    </nav>
                                </div>

                            </div>
                        </div>

                        <%
                            String status = (String) s.getAttribute("status");
                            if (status == null) {
                        %>
                        <script>
                            var xhttp = new XMLHttpRequest();
                            xhttp.onreadystatechange = function () {
                                if (this.readyState === 4 && this.status === 200) {
                                    document.getElementById("dashboard").innerHTML = this.responseText;
                                    var table = $('.datatable').DataTable();
                                }
                            };
                            xhttp.open("GET", "patient_dashboard.jsp", true);
                            xhttp.send();

                        </script>
                        <%
                            }
                        %>



                        <!-- / Profile Sidebar -->

                        <div id="dashboard" class="col-md-7 col-lg-8 col-xl-9">

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

                    </div>
                </div>
                <!-- /Footer Bottom -->

            </footer>
            <!-- /Footer -->

        </div>
        <div class="modal fade" id="Add_Specialities_details" aria-hidden="true" role="dialog">
            <div class="modal-dialog modal-dialog-centered" role="document">


                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Details bird </h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form action="MainController" method="POST" enctype="multipart/form-data">
                            <input type="hidden" id="username" name="user_name" value="<%= user.getUsername()%>">
                            <div class="row form-row">
                                <div class="col-12 col-sm-6">
                                    <div class="form-group">
                                        <label>Bird Image</label>
                                        <input id="imgbird"  name="bird_image" type="file" class="form-control">
                                        <span id="result_1" style="margin-left: 10px;color: red"></span>
                                    </div>
                                </div>
                            </div>
                            <div class="row form-row">
                                <div class="col-12 col-sm-6">
                                    <div class="form-group">
                                        <label>Bird Name</label>
                                        <input id="birdname"  style="width: 350px;" type="text" class="form-control" name="bird_name" required="">
                                        <span  id="result" style="margin-left: 10px; color: red"></span>
                                    </div>
                                </div>
                            </div>

                            <div class="row form-row">
                                <div class="col-12 col-sm-6">
                                    <div class="form-group">
                                        <label>Species</label>
                                        <select  name="species">
                                            <%
                                                PatientDAO dao = new PatientDAO();
                                                ArrayList<String> list = dao.getListSpecies();
                                                for (String x : list) {
                                            %>
                                            <option value="<%=x%>"><%=x%></option>
                                            <%
                                                }
                                            %>
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <div class="row form-row">
                                <div class="col-12 col-sm-6">
                                    <div class="form-group">
                                        <label>Age</label>
                                        <input type="number" class="form-control" name="age" required="">
                                    </div>
                                </div>
                            </div>

                            <div class="row form-row">
                                <div class="col-12 col-sm-6">
                                    <div class="form-group">
                                        <label>Gender</label>
                                        <select name="gender">
                                            <option value="Male">Male</option>
                                            <option value="Female">Female</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <input disabled="true" id="submit" type="submit" name="action" value="Add Bird" >
                        </form>
                    </div>
                </div>


            </div>
        </div>


        <%
            MedicalRecordDAO daoMR = new MedicalRecordDAO();
            List<MedicalRecordDTO> MR = daoMR.getMR(user.getUsername());
            FeedbackDAO daoFB = new FeedbackDAO();

            for (MedicalRecordDTO mrr : MR) {
                int index = MR.indexOf(mrr);
        %>
        <div class="modal fade" id="feedback_<%=index%>" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true" data-backdrop="false">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLongTitle">FEEDBACK</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>

                    <div class="modal-body">
                        <%
                            FeedbackDTO fb = daoFB.getFeedback(mrr.getRecord_id());
                        %>

                        <div class="row">
                            <div class="col-md-12">


                                <form action="MainController" method="POST">

                                    <input hidden="" name="mr_id" value="<%= mrr.getRecord_id()%>">
                                    <input hidden="" name="ser_id" value="<%= mrr.getSer_id()%>">
                                    <input hidden="" name="username" value="<%= user.getUsername()%>">

                                    <label>
                                        <input type="radio" name="stars" value="1" <% if (fb.getRating_star() == 1) { %> checked="checked" <% } %> required=""/>
                                        <span class="icon"style="color: #00FFFF">★</span> 
                                    </label>
                                    <label>
                                        <input type="radio" name="stars" value="2" <% if (fb.getRating_star() == 2) { %> checked="checked" <% } %> required=""/>
                                        <span class="icon" style="color: #00FFFF">★</span>
                                        <span class="icon" style="color: #00FFFF">★</span>
                                    </label>
                                    <label>
                                        <input type="radio" name="stars" value="3" <% if (fb.getRating_star() == 3) { %> checked="checked" <% } %> required=""/>
                                        <span class="icon" style="color: #00FFFF">★</span>
                                        <span class="icon" style="color: #00FFFF">★</span>
                                        <span class="icon" style="color: #00FFFF">★</span>   
                                    </label>
                                    <label>
                                        <input type="radio" name="stars" value="4" <% if (fb.getRating_star() == 4) { %> checked="checked" <% } %> required=""/>
                                        <span class="icon" style="color: #00FFFF">★</span>
                                        <span class="icon" style="color: #00FFFF">★</span>
                                        <span class="icon" style="color: #00FFFF">★</span>
                                        <span class="icon" style="color: #00FFFF">★</span>
                                    </label>
                                    <label>
                                        <input type="radio" name="stars" value="5" <% if (fb.getRating_star() == 5) { %> checked="checked" <% }%> required=""/>
                                        <span class="icon" style="color: #00FFFF">★</span>
                                        <span class="icon" style="color: #00FFFF">★</span>
                                        <span class="icon" style="color: #00FFFF">★</span>
                                        <span class="icon" style="color: #00FFFF">★</span>
                                        <span class="icon" style="color: #00FFFF">★</span>
                                    </label>



                                    <textarea class="form-control animated" cols="50" id="new-review" name="comment" placeholder="Enter your review here..." rows="5" required=""><% if (fb.getFeedback_content() != null) {%> <%=fb.getFeedback_content()%> <%}%> </textarea> <br>
                                    <!--                                    <div class="modal-footer">-->
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                    <%if (fb.getRating_star() == 0) { %> 

                                    <button type="submit" class="btn btn-primary" name="action" value="feedback">Give Feedback</button>

                                    <%} else {%>
                                    <button type="submit" class="btn btn-primary" name="action" value="updateFeedback">Update Feedback</button>
                                    <%
                                        }
                                    %>

                                    <!--                                    </div>-->
                                </form>

                            </div>
                        </div>

                    </div>

                </div>
            </div>
        </div>
        <%
            }
        %>


        <%
            if (status == "AddBirdSucces") {
        %>
        <script>
            var xhttp = new XMLHttpRequest();
            xhttp.onreadystatechange = function () {
                if (this.readyState === 4 && this.status === 200) {
                    document.getElementById("dashboard").innerHTML = this.responseText;
                    var table = $('.datatable').DataTable();
                }
            };
            xhttp.open("GET", "bird-profile.jsp", true);
            xhttp.send();

        </script>
        <%
            }
        %>

        <%
            if (status
                    == "changePassword") {
        %>        
        <script>
            var xhttp = new XMLHttpRequest();
            xhttp.onreadystatechange = function () {
                if (this.readyState === 4 && this.status === 200) {
                    document.getElementById("dashboard").innerHTML = this.responseText;
                    var table = $('.datatable').DataTable();
                }
            };
            xhttp.open("GET", "user-change-password.jsp", true);
            xhttp.send();
        </script>
        <%
            }
        %>



        <script src="assets/js/checkBirdValidate.js"></script>
        <script src="assets/js/checkUpdateValidate.js"></script>
        <!-- /Main Wrapper -->

        <script src="assets/js/user_dashboard.js"></script>
        <!-- jQuery -->
        <script src="assets/js/jquery.min.js"></script>

        <!-- Bootstrap Core JS -->
        <script src="assets/js/popper.min.js"></script>
        <script src="assets/js/bootstrap.min.js"></script>
        <script src="admin/assets/plugins/datatables/jquery.dataTables.min.js"></script>
        <script src="admin/assets/plugins/datatables/datatables.min.js"></script>

        <!-- Sticky Sidebar JS -->
        <script src="assets/plugins/theia-sticky-sidebar/ResizeSensor.js"></script>
        <script src="assets/plugins/theia-sticky-sidebar/theia-sticky-sidebar.js"></script>

        <script src="admin/assets/plugins/datatables/jquery.dataTables.min.js"></script>
        <script src="admin/assets/plugins/datatables/datatables.min.js"></script>
        <!-- Custom JS -->
        <script src="assets/js/script.js"></script>


    </body>

    <!-- doccure/patient-dashboard.jsp  30 Nov 2019 04:12:16 GMT -->
</html>
