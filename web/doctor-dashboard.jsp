

<%@page import="sample.dto.BookingDTO"%>
<%@page import="sample.dao.BookingDAO"%>
<%@page import="sample.dto.PatientDTO"%>
<%@page import="sample.dao.PatientDAO"%>
<%-- 
    Document   : doctor-dashboard
    Created on : May 29, 2023, 4:20:44 PM
    Author     : MSI AD
--%>



<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="sample.dto.AppointmentDTO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="sample.dto.UserDTO"%>
<%@page import="sample.dao.UserDAO"%>
<%@ page import="java.sql.*" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <!-- doccure/doctor-dashboard.jsp  30 Nov 2019 04:12:03 GMT -->

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

        <link rel="stylesheet" href="admin/assets/plugins/datatables/datatables.min.css">
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
                String role = user.getRole().trim();
                if (role.equalsIgnoreCase("3")) {
                } else {
                    response.sendRedirect("index-2.jsp");
                }
            } else {
                response.sendRedirect("login.jsp");
            }
            String status = (String) s.getAttribute("status");
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

                        <!-- User Menu -->
                        <li class="nav-item dropdown has-arrow logged-item">
                            <a href="#" class="dropdown-toggle nav-link" data-toggle="dropdown">
                                <span class="user-img">
                                    <img class="rounded-circle" src="assets/img/doctors/doctor-thumb-02.jpg" width="31"
                                         alt="Darren Elder">
                                </span>
                            </a>
                            <div class="dropdown-menu dropdown-menu-right">
                                <div class="user-header">
                                    <div class="avatar avatar-sm">
                                        <img src="assets/img/doctors/doctor-thumb-02.jpg" alt="User Image"
                                             class="avatar-img rounded-circle">
                                    </div>
                                    <div class="user-text">
                                        <h6>Darren Elder</h6>
                                        <p class="text-muted mb-0">Doctor</p>
                                    </div>
                                </div>
                                <a class="dropdown-item" href="doctor-dashboard.jsp">Dashboard</a>
                                <a class="dropdown-item" href="doctor-profile-settings.jsp">Profile Settings</a>
                                <a class="dropdown-item" href="MainController?action=logout">Logout</a>
                            </div>
                        </li>
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
                                    <li class="breadcrumb-item active" aria-current="page">Dashboard</li>
                                </ol>
                            </nav>
                            <h2 class="breadcrumb-title">Dashboard</h2>
                        </div>
                    </div>
                </div>
            </div>
            <!-- /Breadcrumb -->

            <!-- Page Content -->

            <div class="content">
                <div class="container-fluid">

                    <div class="row">
                        <div class="col-md-5 col-lg-4 col-xl-3 theiaStickySidebar">

                            <!-- Profile Sidebar -->
                            <div class="profile-sidebar">
                                <div class="widget-profile pro-widget-content">
                                    <div class="profile-info-widget">
                                        <a href="#" class="booking-doc-img">
                                            <img src=""
                                                 alt="User Image">
                                        </a>
                                        <div class="profile-det-info">
                                            <h3><%
                                                String doctorUsername = user.getUsername();
                                                String doctorFullName = user.getFullname();
                                                out.println(doctorFullName);
                                                %>
                                            </h3>

                                            <div class="patient-details">
                                                <h5 class="mb-0"></h5>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="dashboard-widget">
                                    <nav class="dashboard-menu">
                                        <ul>
                                            <li class="active">
                                                <a type="button" onclick="Dashboard()">
                                                    <i class="fas fa-columns"></i>
                                                    <span>Dashboard</span>
                                                </a>
                                            </li>
                                            <li>
                                                <a type="button" onclick="Appointments()">
                                                    <i class="fas fa-calendar-check"></i>
                                                    <span>Appointments</span>
                                                </a>
                                            </li>
                                            <li>
                                                <a type="button" onclick="Patients()">
                                                    <i class="fas fa-user-injured"></i>
                                                    <span>My Patients</span>
                                                </a>
                                            </li>
                                            <li>
                                                <a type="button" onclick="Profile()">
                                                    <i class="fas fa-user-cog"></i>
                                                    <span>Profile Settings</span>
                                                </a>
                                            </li>
                                            <li>
                                                <a type="button" onclick="MedicalRecord()">
                                                    <i class="fas fa-columns"></i>
                                                    <span>Medical Record</span>
                                                </a>
                                            </li>
                                            <script>
                                                function MedicalRecord() {
                                                    var xhttp = new XMLHttpRequest();
                                                    xhttp.onreadystatechange = function () {
                                                        if (this.readyState === 4 && this.status === 200) {
                                                            document.getElementById("doctor").innerHTML = this.responseText;
                                                            var table = $('.datatable').DataTable();
                                                        }
                                                    };
                                                    xhttp.open("GET", "medical_doctor.jsp", true);
                                                    xhttp.send();
                                                }

                                            </script>
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
                            <!-- /Profile Sidebar -->

                        </div>
                        <%
                            if (status == null) {
                        %>
                        <script>
                            var xhttp = new XMLHttpRequest();
                            xhttp.onreadystatechange = function () {
                                if (this.readyState === 4 && this.status === 200) {
                                    document.getElementById("doctor").innerHTML = this.responseText;
                                }
                            };
                            xhttp.open("GET", "doctor_dashboard.jsp", true);
                            xhttp.send();
                        </script>
                        <%
                        } else if (status == "doctor-profile") {
                        %>
                        <script>
                            var xhttp = new XMLHttpRequest();
                            xhttp.onreadystatechange = function () {
                                if (this.readyState === 4 && this.status === 200) {
                                    document.getElementById("doctor").innerHTML = this.responseText;
                                }
                            };
                            xhttp.open("GET", "doctor-profile-settings.jsp", true);
                            xhttp.send();
                        </script>
                        <%
                        } else if (status == "medical") {
                        %>
                        <script>
                            var xhttp = new XMLHttpRequest();
                            xhttp.onreadystatechange = function () {
                                if (this.readyState === 4 && this.status === 200) {
                                    document.getElementById("doctor").innerHTML = this.responseText;
                                }
                            };
                            xhttp.open("GET", "appointments.jsp", true);
                            xhttp.send();
                        </script>
                        <%
                            }
                        %>

                        <div id="doctor" class="col-md-7 col-lg-8 col-xl-9">
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
                                        <img src="assets/img/footer-logo.png" alt="logo">
                                    </div>
                                    <div class="footer-about-content">
                                        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor
                                            incididunt ut labore et dolore magna aliqua. </p>
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
                                        <li><a href="search.jsp"><i class="fas fa-angle-double-right"></i> Search for
                                                Doctors</a></li>
                                        <li><a href="login.jsp"><i class="fas fa-angle-double-right"></i> Login</a></li>
                                        <li><a href="register.jsp"><i class="fas fa-angle-double-right"></i> Register</a>
                                        </li>
                                        <li><a href="booking.jsp"><i class="fas fa-angle-double-right"></i> Booking</a>
                                        </li>
                                        <li><a href="patient-dashboard.jsp"><i class="fas fa-angle-double-right"></i>
                                                Patient Dashboard</a></li>
                                    </ul>
                                </div>
                                <!-- /Footer Widget -->

                            </div>

                            <div class="col-lg-3 col-md-6">

                                <!-- Footer Widget -->
                                <div class="footer-widget footer-menu">
                                    <h2 class="footer-title">For Doctors</h2>
                                    <ul>
                                        <li><a href="appointments.jsp"><i class="fas fa-angle-double-right"></i>
                                                Appointments</a></li>
                                        <li><a href="chat.jsp"><i class="fas fa-angle-double-right"></i> Chat</a></li>
                                        <li><a href="login.jsp"><i class="fas fa-angle-double-right"></i> Login</a></li>
                                        <li><a href="doctor-register.jsp"><i class="fas fa-angle-double-right"></i>
                                                Register</a></li>
                                        <li><a href="doctor-dashboard.jsp"><i class="fas fa-angle-double-right"></i> Doctor
                                                Dashboard</a></li>
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
                                            <p> 3556 Beech Street, San Francisco,<br> California, CA 94108 </p>
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
        <%
            BookingDAO dao = new BookingDAO();
            List<BookingDTO> list = dao.getAllBooking();
            PatientDAO pdao = new PatientDAO();
            for (BookingDTO x : list) {
                if (x.getBooking_status() >= 2) {
                    int index = list.indexOf(x);
        %>

        <div class="modal fade" id="Medical-record_<%=index%>" aria-hidden="true" role="dialog">

            <div class="modal-dialog modal-dialog-centered" role="document">
                <div style="width: 250%; max-height: 100%"  class="card">

                    <div  class="card-body">
                        <!-- Profile Settings Form -->
                        <form action="MainController">
                            <div class="row form-row">

                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title">Medical Record </h5>
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                    </div>
                                    <%PatientDTO p = pdao.getBirdByID(x.getPatient_id());
                                    %>
                                    <input id="index" type="hidden" value="<%=index%>">
                                    <div class="modal-body">
                                        <div class="col-12 col-md-6">
                                            <div class="form-group">
                                                <label>Name:</label>
                                                <input readonly="" style="width: 200%; border: 0px none; border-bottom: 1px dotted; padding: 0px; min-height:5px;height: 15px" value="<%= dao.getFullNameUserByBookingID(x.getBooking_id())%>"  type="text" class="form-control" >
                                            </div>
                                        </div>
                                        <div class="col-12 col-md-6">
                                            <div class="form-group">
                                                <label>Bird Name:</label>
                                                <input readonly="" style="width: 200%; border: 0px none; border-bottom: 1px dotted; padding: 0px; min-height:5px;height: 15px" value="<%=p.getName()%>"  type="text" class="form-control" >
                                            </div>
                                        </div>
                                        <div class="col-12 col-md-6">
                                            <div class="form-group">
                                                <label>Species:</label>
                                                <input readonly="" style="width: 200%; border: 0px none; border-bottom: 1px dotted; padding: 0px; min-height:5px;height: 15px" value="<%=pdao.getSpecies(p.getSpecies_id())%>" type="text" class="form-control" >
                                            </div>
                                        </div>
                                        <div class="col-12 col-md-6">
                                            <div class="form-group">
                                                <label>Age:</label>
                                                <input readonly="" style="width: 200%; border: 0px none; border-bottom: 1px dotted; padding: 0px; min-height:5px;height: 15px" value="<%=p.getAge()%>" type="text" class="form-control" >
                                            </div>
                                        </div>
                                        <div class="col-12 col-md-6">
                                            <div class="form-group">
                                                <label>Gender:</label>
                                                <input readonly="" style="width: 200%; border: 0px none; border-bottom: 1px dotted; padding: 0px; min-height:5px;height: 15px" value="<%=p.getGender()%>" type="text" class="form-control" >
                                            </div>
                                        </div>
                                        <div class="col-12 col-md-6">
                                            <div class="form-group">
                                                <label>Date again:</label>
                                                <input  name="date_again" style="width: 200%; border: 0px none; border-bottom: 1px dotted; padding: 0px; min-height:5px;height: 15px"  type="date" class="form-control" >
                                            </div>
                                        </div>
                                        <div class="col-12 col-md-6">
                                            <div class="form-group">
                                                <label>Phone:</label>
                                                <input readonly="" name="phone" style="width: 200%; border: 0px none; border-bottom: 1px dotted; padding: 0px; min-height:5px;height: 15px"  type="text" class="form-control" >
                                            </div>
                                        </div>

                                        <div id="service_<%=index%>" class="col-12 col-md-6">
                                            <div  class="form-group">
                                                <label>Service:</label>
                                                <button disabled=""  name="" value="<%= dao.getServicename(x.getBooking_id())%>"><%= dao.getServicename(x.getBooking_id())%></button>
                                                <input type="button" value="+" onclick="Add()">

                                            </div>
                                        </div>
                                        <div class="col-12 col-md-6">
                                            <div class="form-group">
                                                <label>Fee:</label>
                                                <input name="total_fee" readonly=""value="<%= dao.getServiceFee(x.getBooking_id())%>" style="width: 200%; border: 0px none; border-bottom: 1px dotted; padding: 0px; min-height:5px;height: 15px"  type="text" class="form-control" >
                                            </div>
                                        </div>
                                        <div class="col-12 col-md-6">
                                            <div class="form-group">
                                                <label>Note:</label>
                                                <textarea name="note" style="width: 200%;"></textarea>

                                            </div>
                                        </div>
                                        <input type="hidden" name="patient_id" value="<%=x.getPatient_id()%>">
                                        <input type="hidden" name="booking_id" value="<%=x.getBooking_id()%>">
                                        <input type="hidden" name="service_id" value="<%=x.getService_id()%>">
                                        <input name="action" type="submit" value="Done" class="btn btn-primary submit-btn">
                                    </div>


                                </div>


                            </div> 
                        </form>


                    </div>


                </div>
            </div>
        </div>
        <%
                }
            }

        %>

        <!-- jQuery -->
        <script src="assets/js/jquery.min.js"></script>
        <script src="assets/js/doctor-dashboard.js"></script>
        <!-- Bootstrap Core JS -->
        <script src="assets/js/popper.min.js"></script>
        <script src="assets/js/bootstrap.min.js"></script>

        <!-- Sticky Sidebar JS -->
        <script src="assets/plugins/theia-sticky-sidebar/ResizeSensor.js"></script>
        <script src="assets/plugins/theia-sticky-sidebar/theia-sticky-sidebar.js"></script>

        <!-- Circle Progress JS -->
        <script src="assets/js/circle-progress.min.js"></script>

        <!-- Custom JS -->
        <script src="assets/js/script.js"></script>
        <script src="admin/assets/plugins/datatables/jquery.dataTables.min.js"></script>
        <script src="admin/assets/plugins/datatables/datatables.min.js"></script>
    </body>

    <!-- doccure/doctor-dashboard.jsp  30 Nov 2019 04:12:09 GMT -->

</html>