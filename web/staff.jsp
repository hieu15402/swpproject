<%-- 
    Document   : patient-dashboard
    Created on : May 29, 2023, 5:13:28 PM
    Author     : MSI AD
--%>

<%@page import="sample.dao.UserDAO"%>
<%@page import="sample.dto.BookingDTO"%>
<%@page import="sample.dao.BookingDAO"%>
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

        <!-- Main CSS -->
        <link rel="stylesheet" href="assets/css/style.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />

        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!--[if lt IE 9]>
                <script src="assets/js/html5shiv.min.js"></script>
                <script src="assets/js/respond.min.js"></script>
        <![endif]-->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

        <link rel="stylesheet" href="admin/assets/plugins/datatables/datatables.min.css">

    </head>
    <body>




        <%
            HttpSession s = request.getSession();
            UserDTO user = (UserDTO) s.getAttribute("account");
            if (user != null) {
                String role = user.getRole().trim();
                if (role.equalsIgnoreCase("2")) {
                } else {
                    response.sendRedirect("index-2.jsp");
                }
            } else {
                response.sendRedirect("login.jsp");
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
                                            <li class="active">
                                                <a type="button" onclick="Pending()">
                                                    <i class="fas fa-columns"></i>
                                                    <span>Pending</span>
                                                </a>
                                            </li>
                                            <li>
                                                <a type="button" onclick="Assign()">
                                                    <i class="fas fa-columns"></i>
                                                    <span>Assign</span>
                                                </a>
                                            </li>
                                            <li>
                                                <a type="button" onclick="CheckIn()">
                                                    <i class="fas fa-columns"></i>
                                                    <span>Check In</span>
                                                </a>
                                            </li>
                                            <li>
                                                <a type="button" onclick="CheckOut()">
                                                    <i class="fas fa-columns"></i>
                                                    <span>Check Out</span>
                                                </a>
                                            </li>
                                            <li>
                                                <a type="button" onclick="Feedback()">
                                                    <i class="fas fa-columns"></i>
                                                    <span>Feedback</span>
                                                </a>
                                            </li>
                                            <li>
                                                <a href="MainController?action=logout">
                                                    <i class="fas fa-sign-out-alt"></i>
                                                    <span>Logout</span>
                                                </a>
                                            </li>

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
                            xhttp.open("GET", "pending.jsp", true);
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
        <%
            BookingDAO dao = new BookingDAO();
            int count = 0;
            UserDAO udao = new UserDAO();
            PatientDAO pdao = new PatientDAO();
            MedicalRecordDAO mdao = new MedicalRecordDAO();
            List<BookingDTO> list = dao.getAllBooking();
            for (BookingDTO x : list) {
                if (x.getBooking_status() == 4 || x.getBooking_status() == 7 || x.getBooking_status() == 8) {
                    count++;

        %>
        <form action="MainController">
            <div class="modal fade" id="invoice_<%=count%>" aria-hidden="true" role="dialog">

                <div class="modal-dialog modal-dialog-centered" role="document">
                    <div style="padding: 0px 10px; max-height: 100%"  class="card">

                        <div class="page-wrapper">

                            <div class="content container-fluid">

                                <!-- Invoice Container -->
                                <div class="invoice-container">

                                    <div class="row">
                                        <div class="col-sm-6 m-b-20">
                                            <img alt="Logo" class="inv-logo img-fluid" src="assets/img/final_logo.png">
                                        </div>
                                        <div class="col-sm-6 m-b-20">
                                            <div class="invoice-details">
                                                <h3 class="text-uppercase">Invoice #<%=x.getBooking_id()%></h3>
                                                <ul class="list-unstyled mb-0">
                                                    <li>Date: <span><%=x.getDate()%></span></li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-12 m-b-20">
                                            <ul class="list-unstyled mb-0">
                                                <li>The dear bird Hospital</li>
                                                <li>Doctor: <%=udao.getUser(x.getUsername_doctor()).getFullname()%></li>
                                                <li>Time slot: <%= dao.getSlotTime(x.getBooking_id())%></li>
                                                <br>
                                            </ul>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-6 col-lg-7 col-xl-8 m-b-20">
                                            <h3>Invoice to</h3>
                                            <ul class="list-unstyled mb-0">
                                                <li><h5 class="mb-0"><strong><%=dao.customerName(x.getUsername_customer())%></strong></h5></li>
                                                <li><%=udao.getUser(x.getUsername_customer()).getPhone()%></li>
                                                <li><%=udao.getUser(x.getUsername_customer()).getEmail()%></li>
                                                <br>
                                                <br>
                                            </ul>
                                        </div>
                                        <div class="col-sm-6 col-lg-5 col-xl-4 m-b-20">
                                            <h3>Patient Details</h3>
                                            <ul class="list-unstyled invoice-payment-details mb-0">
                                                <li><h5>Name: <span class="text-right"><%=dao.getBirdname(x.getPatient_id())%></span></h5></li>
                                                <li>Species: <%=pdao.getSpecies(pdao.getBirdByID(x.getPatient_id()).getSpecies_id())%> <span></span></li>
                                                <br>
                                                <br>
                                            </ul>
                                        </div>
                                    </div>
                                    <div class="table-responsive">
                                        <table class="table">
                                            <thead>
                                                <tr>
                                                    <th>#</th>
                                                    <th>SERVICE</th>
                                                    <th class="d-none d-sm-table-cell"></th>
                                                    <th class="text-nowrap"></th>
                                                    <th ></th>
                                                    <th>PRICE</th>
                                                </tr>
                                            </thead>
                                            <tbody>

                                                <%
                                                    List<String> list_ser = mdao.getListServiceMore(mdao.getMRByBookingID(x.getBooking_id()).getRecord_id());
                                                    int number_ser = 0;
                                                    int total = 0;
                                                    for (String ls : list_ser) {
                                                        number_ser++;
                                                        total += mdao.getFeeSer(ls);
                                                %>
                                                <tr>
                                                    <td><%=number_ser%></td>
                                                    <td><%=mdao.getSerNam(ls)%></td>
                                                    <td class="d-none d-sm-table-cell"></td>
                                                    <td></td>
                                                    <td></td>
                                                    <td><%=mdao.getFeeSer(ls)%></td>
                                                </tr>
                                                <%    }
                                                %>

                                            </tbody>
                                        </table>
                                    </div>

                                    <div>
                                        <div class="row invoice-payment">
                                            <div class="col-sm-7">
                                            </div>
                                            <div class="col-sm-5">
                                                <div class="m-b-20">
                                                    <h3>Total due</h3>
                                                    <div class="table-responsive no-border">
                                                        <table class="table mb-0">
                                                            <tbody>
                                                                <tr>
                                                                    <th>Total:</th>
                                                                    <td class="text-right text-primary"><h5><%=total%></h5></td>
                                                                </tr>
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="invoice-info">
                                            <h5>Note</h5>
                                            <p class="text-muted mb-0"><%=mdao.getMRByBookingID(x.getBooking_id()).getNote()%></p>
                                        </div>

                                    </div>

                                </div>
                                <!-- /Invoice Container -->

                            </div>

                        </div>


                    </div>
                </div>

            </div>

        </form>

        <%
                }
            }
        %>

        <%
            int count2 = 0;

            for (BookingDTO x : list) {
                if (x.getBooking_status() == 2) {
                    count2++;
        %>

        <div class="modal fade" id="check_<%=count2%>" aria-hidden="true" role="dialog">

            <div class="modal-dialog modal-dialog-centered" role="document">
                <div style="padding: 0px 10px; max-height: 100%"  class="card">

                    <div class="page-wrapper">

                        <div class="content container-fluid">

                            <!-- Invoice Container -->
                            <div class="invoice-container">

                                <div class="row">
                                    <div class="col-sm-6 m-b-20">
                                        <img alt="Logo" class="inv-logo img-fluid" src="assets/img/final_logo.png">
                                    </div>
                                    <div class="col-sm-6 m-b-20">
                                        <div class="invoice-details">
                                            <h3 class="text-uppercase">Invoice #<%=x.getBooking_id()%></h3>
                                            <ul class="list-unstyled mb-0">
                                                <li>Date: <span><%=x.getDate()%></span></li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-sm-12 m-b-20">
                                        <ul class="list-unstyled mb-0">
                                            <li>The dear bird Hospital</li>
                                            <li>Doctor: <%=udao.getUser(x.getUsername_doctor()).getFullname()%></li>
                                            <li>Time slot: <%= dao.getSlotTime(x.getBooking_id())%></li>
                                            <br>
                                        </ul>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-sm-6 col-lg-7 col-xl-8 m-b-20">
                                        <h3>Invoice to</h3>
                                        <ul class="list-unstyled mb-0">
                                            <li><h5 class="mb-0"><strong><%=dao.customerName(x.getUsername_customer())%></strong></h5></li>
                                            <li><%=udao.getUser(x.getUsername_customer()).getPhone()%></li>
                                            <li><%=udao.getUser(x.getUsername_customer()).getEmail()%></li>
                                            <br>
                                            <br>
                                        </ul>
                                    </div>
                                    <div class="col-sm-6 col-lg-5 col-xl-4 m-b-20">
                                        <h3>Patient Details</h3>
                                        <ul class="list-unstyled invoice-payment-details mb-0">
                                            <li><h5>Name: <span class="text-right"><%=dao.getBirdname(x.getPatient_id())%></span></h5></li>
                                            <li>Species: <%=pdao.getSpecies(pdao.getBirdByID(x.getPatient_id()).getSpecies_id())%> <span></span></li>
                                            <br>
                                            <br>
                                        </ul>
                                    </div>
                                </div>
                                <div class="table-responsive">
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th>#</th>
                                                <th>SERVICE</th>
                                                <th class="d-none d-sm-table-cell"></th>
                                                <th class="text-nowrap"></th>
                                                <th ></th>
                                                <th>PRICE</th>
                                            </tr>
                                        </thead>
                                        <tbody>

                                            <%
                                                String ser_name = dao.getServicename(x.getBooking_id());
                                            %>
                                            <tr>
                                                <td>1</td>
                                                <td><%=ser_name%></td>
                                                <td class="d-none d-sm-table-cell"></td>
                                                <td></td>
                                                <td></td>
                                                <td><%=dao.getServiceFeeByName(ser_name) %></td>
                                            </tr>
                                            <%    
                                            %>

                                        </tbody>
                                    </table>
                                </div>

                                <div>
                                    <div class="row invoice-payment">
                                        <div class="col-sm-7">
                                        </div>
                                        <div class="col-sm-5">
                                            <div class="m-b-20">
                                                <h3>Total due</h3>
                                                <div class="table-responsive no-border">
                                                    <table class="table mb-0">
                                                        <tbody>
                                                            <tr>
                                                                <th>Total:</th>
                                                                <td class="text-right text-primary"><h5><%=dao.getServiceFeeByName(ser_name)%></h5></td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                  

                                </div>

                            </div>
                            <!-- /Invoice Container -->

                        </div>

                    </div>


                </div>
            </div>

        </div>
        <%
                }
            }
        %>
        <%
            if (status == "Pending") {
        %>
        <script>
            var xhttp = new XMLHttpRequest();
            xhttp.onreadystatechange = function () {
                if (this.readyState === 4 && this.status === 200) {
                    document.getElementById("dashboard").innerHTML = this.responseText;
                    var table = $('.datatable').DataTable();
                }
            };
            xhttp.open("GET", "pending.jsp", true);
            xhttp.send();

        </script>
        <%
        } else if (status == "Assign") {
        %>        
        <script>
            var xhttp = new XMLHttpRequest();
            xhttp.onreadystatechange = function () {
                if (this.readyState === 4 && this.status === 200) {
                    document.getElementById("dashboard").innerHTML = this.responseText;
                    var table = $('.datatable').DataTable();
                }
            };
            xhttp.open("GET", "assign.jsp", true);
            xhttp.send();
        </script>
        <%
        } else if (status == "CheckIn") {
        %>        
        <script>
            var xhttp = new XMLHttpRequest();
            xhttp.onreadystatechange = function () {
                if (this.readyState === 4 && this.status === 200) {
                    document.getElementById("dashboard").innerHTML = this.responseText;
                    var table = $('.datatable').DataTable();
                }
            };
            xhttp.open("GET", "check-in.jsp", true);
            xhttp.send();
        </script>
        <%
        } else if (status == "CheckOut") {
        %>        
        <script>
            var xhttp = new XMLHttpRequest();
            xhttp.onreadystatechange = function () {
                if (this.readyState === 4 && this.status === 200) {
                    document.getElementById("dashboard").innerHTML = this.responseText;
                    var table = $('.datatable').DataTable();
                }
            };
            xhttp.open("GET", "check-out.jsp", true);
            xhttp.send();
        </script>
        <%
            }
        %>



        <!-- /Main Wrapper -->

        <script src="assets/js/staff.js"></script>
        <!-- jQuery -->
        <script src="assets/js/jquery.min.js"></script>

        <!-- Bootstrap Core JS -->
        <script src="assets/js/popper.min.js"></script>
        <script src="assets/js/bootstrap.min.js"></script>

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
