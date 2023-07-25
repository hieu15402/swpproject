<%-- 
    Document   : index
    Created on : May 29, 2023, 4:31:07 PM
    Author     : MSI AD
--%>


<%@page import="sample.dto.UserDTO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>  

<%@page import="sample.dto.AppointmentDTO"%>
<%@page import="java.util.List"%>
<%@page import="sample.dao.AppointmentDAO"%>
<%@page import="sample.dao.ManagerDao"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

    <!-- Mirrored from dreamguys.co.in/demo/doccure/admin/index.jsp by HTTrack Website Copier/3.x [XR&CO'2014], Sat, 30 Nov 2019 04:12:20 GMT -->

    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">
        <title>thedearbird - Dashboard | Manager</title>
        <link rel="shortcut icon" type="image/x-icon" href="assets/img/logo-icon.png">


        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="assets/css/bootstrap.min.css">

        <!-- Fontawesome CSS -->
        <link rel="stylesheet" href="assets/css/font-awesome.min.css">

        <!-- Feathericon CSS -->
        <link rel="stylesheet" href="assets/css/feathericon.min.css">
        <link rel="stylesheet" href="assets/plugins/morris/morris.css">

        <!-- Datatables CSS -->
        <link rel="stylesheet" href="assets/plugins/datatables/datatables.min.css">

        <!-- Main CSS -->
        <link rel="stylesheet" href="assets/css/style.css">

    </head>

    <body>
        <script src="assets/ckeditor/ckeditor.js"></script>
        <script>


            <%
                HttpSession session1 = request.getSession();
                UserDTO user = (UserDTO) session1.getAttribute("account");
                if (user == null) {
                    response.sendRedirect("../index-2.jsp");
                } else {
                    String role = user.getRole().trim();
                    if (!role.equalsIgnoreCase("1") && !role.equalsIgnoreCase("5")) {
                        response.sendRedirect("../index-2.jsp");
                    }
                }
                String status = (String) session1.getAttribute("status");
            %>

        </script>

        <!-- Main Wrapper -->
        <div  class="main-wrapper">

            <!-- Header -->
            <div class="header">

                <!-- Logo -->
                <div class="header-left">
                    <a href="index.jsp" class="logo">
                        <img src="assets/img/the_logo.png" alt="Logo">
                    </a>
                    <a href="index.jsp" class="logo logo-small">
                        <img src="assets/img/logo-icon.png" alt="Logo" width="30" height="30">
                    </a>
                </div>
                <!-- /Logo -->

                <a href="javascript:void(0);" id="toggle_btn">
                    <i class="fe fe-text-align-left"></i>
                </a>

                <div class="top-nav-search">
                    <form>
                        <input type="text" class="form-control" placeholder="Search here">
                        <button class="btn" type="submit"><i class="fa fa-search"></i></button>
                    </form>
                </div>

                <!-- Mobile Menu Toggle -->
                <a class="mobile_btn" id="mobile_btn">
                    <i class="fa fa-bars"></i>
                </a>
                <!-- /Mobile Menu Toggle -->

                <!-- Header Right Menu -->
                <ul class="nav user-menu">

                    <!-- Notifications -->
                    <li class="nav-item dropdown noti-dropdown">
                        <a href="#" class="dropdown-toggle nav-link" data-toggle="dropdown">
                            <i class="fe fe-bell"></i> <span class="badge badge-pill">3</span>
                        </a>
                        <div class="dropdown-menu notifications">
                            <div class="topnav-dropdown-header">
                                <span class="notification-title">Notifications</span>
                                <a href="javascript:void(0)" class="clear-noti"> Clear All </a>
                            </div>
                            <div class="noti-content">
                                <ul class="notification-list">
                                    <li class="notification-message">
                                        <a href="#">
                                            <div class="media">
                                                <span class="avatar avatar-sm">
                                                    <img class="avatar-img rounded-circle" alt="User Image"
                                                         src="assets/img/doctors/doctor-thumb-01.jpg">
                                                </span>
                                                <div class="media-body">
                                                    <p class="noti-details"><span class="noti-title">Dr. Ruby Perrin</span>
                                                        Schedule <span class="noti-title">her appointment</span></p>
                                                    <p class="noti-time"><span class="notification-time">4 mins ago</span>
                                                    </p>
                                                </div>
                                            </div>
                                        </a>
                                    </li>
                                    <li class="notification-message">
                                        <a href="#">
                                            <div class="media">
                                                <span class="avatar avatar-sm">
                                                    <img class="avatar-img rounded-circle" alt="User Image"
                                                         src="assets/img/patients/patient1.jpg">
                                                </span>
                                                <div class="media-body">
                                                    <p class="noti-details"><span class="noti-title">Charlene Reed</span>
                                                        has booked her appointment to <span class="noti-title">Dr. Ruby
                                                            Perrin</span></p>
                                                    <p class="noti-time"><span class="notification-time">6 mins ago</span>
                                                    </p>
                                                </div>
                                            </div>
                                        </a>
                                    </li>
                                    <li class="notification-message">
                                        <a href="#">
                                            <div class="media">
                                                <span class="avatar avatar-sm">
                                                    <img class="avatar-img rounded-circle" alt="User Image"
                                                         src="assets/img/patients/patient2.jpg">
                                                </span>
                                                <div class="media-body">
                                                    <p class="noti-details"><span class="noti-title">Travis Trimble</span>
                                                        sent a amount of $210 for his <span
                                                            class="noti-title">appointment</span></p>
                                                    <p class="noti-time"><span class="notification-time">8 mins ago</span>
                                                    </p>
                                                </div>
                                            </div>
                                        </a>
                                    </li>
                                    <li class="notification-message">
                                        <a href="#">
                                            <div class="media">
                                                <span class="avatar avatar-sm">
                                                    <img class="avatar-img rounded-circle" alt="User Image"
                                                         src="assets/img/patients/patient3.jpg">
                                                </span>
                                                <div class="media-body">
                                                    <p class="noti-details"><span class="noti-title">Carl Kelly</span> send
                                                        a message <span class="noti-title"> to his doctor</span></p>
                                                    <p class="noti-time"><span class="notification-time">12 mins ago</span>
                                                    </p>
                                                </div>
                                            </div>
                                        </a>
                                    </li>
                                </ul>
                            </div>
                            <div class="topnav-dropdown-footer">
                                <a href="#">View all Notifications</a>
                            </div>
                        </div>
                    </li>
                    <!-- /Notifications -->

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
                                        <c:if test="${fn:containsIgnoreCase(roleName, '5')}">
                                            <p class="text-muted mb-0">Manager</p>
                                        </c:if>
                                    </div>
                                </div>
                                <a class="dropdown-item" href="../MainController?action=logout">Logout</a>
                            </div>
                        </li>
                    </c:if>
                    <!-- /User Menu -->

                </ul>
                <!-- /Header Right Menu -->

            </div>
            <!-- /Header -->

            <!-- Sidebar -->
            <div class="sidebar" id="sidebar">
                <div class="sidebar-inner slimscroll">
                    <div id="sidebar-menu" class="sidebar-menu">
                        <ul>
                            <li class="menu-title">
                                <span>Main</span>
                            </li>
                            <c:if test="${fn:containsIgnoreCase(roleName, '5') || fn:containsIgnoreCase(roleName, '1')}">
                                <li>
                                    <a type="button" onclick="Dashboard_1()"><i class="fe fe-home"></i><span>Dashboard</span></a>
                                </li>
                            </c:if>
                            <c:if test="${fn:containsIgnoreCase(roleName, '5')}">
                                <li>
                                    <a type="button" onclick="Appointments()"><i class="fe fe-layout"></i><span>Appointments</span></a>
                                </li>
                            </c:if>

                            <c:if test="${fn:containsIgnoreCase(roleName, '5')}">
                                <li>
                                    <a type="button" onclick="Services()"><i class="fe fe-users"></i><span>Services</span></a>
                                </li>
                            </c:if>
                            <c:if test="${fn:containsIgnoreCase(roleName, '1')}">
                                <li>
                                    <a type="button" onclick="Staff()"><i class="fe fe-user-plus"></i><span>Staffs</span></a>
                                </li>
                            </c:if> 
                            <c:if test="${fn:containsIgnoreCase(roleName, '1') || fn:containsIgnoreCase(roleName, '5')}">
                                <li>
                                    <a type="button" onclick="Doctors()"><i class="fe fe-users"></i><span>Doctors</span></a>
                                </li>
                                <li>
                                    <a type="button" onclick="Customers()"><i class="fe fe-user-plus"></i><span>Customers</span></a>
                                </li>
                            </c:if>

                            <c:if test="${fn:containsIgnoreCase(roleName, '5')}">
                                <li>
                                    <a type="button" onclick="Blogs()"><i class="fe fe-file-word"></i> <span>Blogs</span></a>
                                </li>
                            </c:if> 

                            <c:if test="${fn:containsIgnoreCase(roleName, '5')}">
                                <!--                                <li>
                                                                    <a type="button" onclick="Reviews()"><i class="fa-solid fa-blog"></i></i> <span>Reviews</span></a>
                                                                </li>-->
                            </c:if>

                            <!---------------------------- -->


                            <!-- <li>w
                                    <a href="transactions-list.jsp"><i class="fe fe-activity"></i>
                                            <span>Transactions</span></a>
                            </li>
                            <li>
                                    <a href="settings.jsp"><i class="fe fe-vector"></i> <span>Settings</span></a>
                            </li>
                            <li class="submenu">
                                    <a href="#"><i class="fe fe-document"></i> <span> Reports</span> <span
                                                    class="menu-arrow"></span></a>
                                    <ul style="display: none;">
                                            <li><a href="invoice-report.jsp">Invoice Reports</a></li>
                                    </ul>
                            </li>
    
                            <li class="menu-title">
                                    <span>Pages</span>
                            </li>
                            <li>
                                    <a href="profile.jsp"><i class="fe fe-user-plus"></i> <span>Profile</span></a>
                            </li>
                            <li class="submenu">
                                    <a href="#"><i class="fe fe-document"></i> <span> Authentication </span> <span
                                                    class="menu-arrow"></span></a>
                                    <ul style="display: none;">
                                            <li><a href="login.jsp"> Login </a></li>
                                            <li><a href="register.jsp"> Register </a></li>
                                            <li><a href="forgot-password.jsp"> Forgot Password </a></li>
                                            <li><a href="lock-screen.jsp"> Lock Screen </a></li>
                                    </ul>
                            </li>
                            <li class="submenu">
                                    <a href="#"><i class="fe fe-warning"></i> <span> Error Pages </span> <span
                                                    class="menu-arrow"></span></a>
                                    <ul style="display: none;">
                                            <li><a href="error-404.jsp">404 Error </a></li>
                                            <li><a href="error-500.jsp">500 Error </a></li>
                                    </ul>
                            </li>
                            <li>
                                    <a href="blank-page.jsp"><i class="fe fe-file"></i> <span>Blank Page</span></a>
                            </li>
                            <li class="menu-title">
                                    <span>UI Interface</span>
                            </li>
                            <li>
                                    <a href="components.jsp"><i class="fe fe-vector"></i> <span>Components</span></a>
                            </li>
                            <li class="submenu">
                                    <a href="#"><i class="fe fe-layout"></i> <span> Forms </span> <span
                                                    class="menu-arrow"></span></a>
                                    <ul style="display: none;">
                                            <li><a href="form-basic-inputs.jsp">Basic Inputs </a></li>
                                            <li><a href="form-input-groups.jsp">Input Groups </a></li>
                                            <li><a href="form-horizontal.jsp">Horizontal Form </a></li>
                                            <li><a href="form-vertical.jsp"> Vertical Form </a></li>
                                            <li><a href="form-mask.jsp"> Form Mask </a></li>
                                            <li><a href="form-validation.jsp"> Form Validation </a></li>
                                    </ul>
                            </li>
                            <li class="submenu">
                                    <a href="#"><i class="fe fe-table"></i> <span> Tables </span> <span
                                                    class="menu-arrow"></span></a>
                                    <ul style="display: none;">
                                            <li><a href="tables-basic.jsp">Basic Tables </a></li>
                                            <li><a href="data-tables.jsp">Data Table </a></li>
                                    </ul>
                            </li>
                            <li class="submenu">
                                    <a href="javascript:void(0);"><i class="fe fe-code"></i> <span>Multi Level</span> <span
                                                    class="menu-arrow"></span></a>
                                    <ul style="display: none;">
                                            <li class="submenu">
                                                    <a href="javascript:void(0);"> <span>Level 1</span> <span
                                                                    class="menu-arrow"></span></a>
                                                    <ul style="display: none;">
                                                            <li><a href="javascript:void(0);"><span>Level 2</span></a></li>
                                                            <li class="submenu">
                                                                    <a href="javascript:void(0);"> <span> Level 2</span> <span
                                                                                    class="menu-arrow"></span></a>
                                                                    <ul style="display: none;">
                                                                            <li><a href="javascript:void(0);">Level 3</a></li>
                                                                            <li><a href="javascript:void(0);">Level 3</a></li>
                                                                    </ul>
                                                            </li>
                                                            <li><a href="javascript:void(0);"> <span>Level 2</span></a></li>
                                                    </ul>
                                            </li>
                                            <li>
                                                    <a href="javascript:void(0);"> <span>Level 1</span></a>
                                            </li>
                                    </ul>
                            </li> -->
                        </ul>
                    </div>
                </div>
            </div>
            <!-- /Sidebar -->


            <!-- Page Wrapper -->
            <div id="main">
                <%
                    String role = user.getRole().trim();
                    if (role.equalsIgnoreCase("1") && status == null) {
                %>
                <script>
                    var xhttp = new XMLHttpRequest();
                    xhttp.onreadystatechange = function () {
                        if (this.readyState === 4 && this.status === 200) {
                            document.getElementById("main").innerHTML = this.responseText;

                            // Create the script element for Chart.js
                            var chartScript = document.createElement("script");
                            chartScript.src = "https://cdn.jsdelivr.net/npm/chart.js@4.3.0/dist/chart.umd.min.js";
                            chartScript.onload = function () {
                                // Once Chart.js is loaded, execute the code in chart_1.js
                                var chart1Script = document.createElement("script");
                                chart1Script.src = "assets/js/chart_1.js";
                                document.head.appendChild(chart1Script);

                            };
                            // Append the Chart.js script to the document's <head> section
                            document.head.appendChild(chartScript);

                        }
                    };
                    xhttp.open("GET", "dashboard.jsp", true);
                    xhttp.send();
                </script>

                <%
                } else if (role.equalsIgnoreCase("5") && status == null) {
                %>
                <script>
                    var xhttp = new XMLHttpRequest();
                    xhttp.onreadystatechange = function () {
                        if (this.readyState === 4 && this.status === 200) {
                            document.getElementById("main").innerHTML = this.responseText;

                            // Create the script element for Chart.js
                            var chartScript = document.createElement("script");
                            chartScript.src = "https://cdn.jsdelivr.net/npm/chart.js@4.3.0/dist/chart.umd.min.js";
                            chartScript.onload = function () {
                                // Once Chart.js is loaded, execute the code in chart_1.js
                                var chart1Script = document.createElement("script");
                                chart1Script.src = "assets/js/chart_1.js";
                                document.head.appendChild(chart1Script);

                            };
                            // Append the Chart.js script to the document's <head> section
                            document.head.appendChild(chartScript);

                        }
                    };
                    xhttp.open("GET", "dashboard.jsp", true);
                    xhttp.send();
                </script>
                <%
                    }
                %>


                <div class="page-wrapper" id="page-wrapper">
                    <div class="content container-fluid">
                        <!-- Page Header -->
                        <div class="page-header" ">
                            <div class="row">
                                <div class="col-sm-12">
                                    <h3 class="page-title">Welcome administrator</h3>
                                    <ul class="breadcrumb">
                                        <li class="breadcrumb-item active">Dashboard</li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <!-- /Page Header -->

                        <div class="row">
                            <div class="col-xl-3 col-sm-6 col-12">
                                <div class="card">
                                    <div class="card-body">
                                        <div class="dash-widget-header">
                                            <span class="dash-widget-icon text-primary border-primary">
                                                <i class="fe fe-users"></i>
                                            </span>
                                            <div class="dash-count"> 
                                                <h3>
                                                    <%
                                                        ManagerDao obj1 = new ManagerDao();
                                                        int result1 = obj1.countDoctors();
                                                    %>
                                                    <%= result1%>
                                                </h3>
                                            </div>
                                        </div>
                                        <div class="dash-widget-info">
                                            <h6 class="text-muted">Doctors</h6>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-3 col-sm-6 col-12">
                                <div class="card">
                                    <div class="card-body">
                                        <div class="dash-widget-header">
                                            <span class="dash-widget-icon text-warning border-warning">
                                                <i class="fe fe-users"></i>
                                            </span>
                                            <div class="dash-count">
                                                <h3>
                                                    <%
                                                        ManagerDao obj2 = new ManagerDao();
                                                        int result2 = obj2.countCustomer();
                                                    %>
                                                    <%= result2%>
                                                </h3>
                                            </div>
                                        </div>
                                        <div class="dash-widget-info">
                                            <h6 class="text-muted">Customers</h6>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-3 col-sm-6 col-12">
                                <div class="card">
                                    <div class="card-body">
                                        <div class="dash-widget-header">
                                            <span class="dash-widget-icon text-warning border-warning">
                                                <i class="fe fe-user"></i>
                                            </span>
                                            <div class="dash-count">
                                                <h3>
                                                    <%

                                                        ManagerDao obj3 = new ManagerDao();
                                                        int result3 = obj3.countStaff();
                                                    %>
                                                    <%= result3%>
                                                </h3>
                                            </div>
                                        </div>
                                        <div class="dash-widget-info">
                                            <h6 class="text-muted">Staffs</h6>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-3 col-sm-6 col-12">
                                <div class="card">
                                    <div class="card-body">
                                        <div class="dash-widget-header">
                                            <span class="dash-widget-icon text-success">
                                                <i class="fe fe-money"></i>
                                            </span>
                                            <div class="dash-count">
                                                <h3><%

                                                    ManagerDao obj4 = new ManagerDao();
                                                    int result4 = obj4.countPatient();
                                                    %>
                                                    <%= result4%>
                                                </h3> 
                                            </div>
                                        </div>
                                        <div class="dash-widget-info">
                                            <h6 class="text-muted">Patient</h6>

                                        </div>
                                    </div>
                                </div>
                            </div>


                            <div class="col-xl-3 col-sm-6 col-12">
                                <div class="card">
                                    <div class="card-body">
                                        <div class="dash-widget-header">
                                            <span class="dash-widget-icon text-danger border-danger">
                                                <i class="fe fe-calendar"></i>
                                            </span>
                                            <div class="dash-count">
                                                <h3>
                                                    <%

                                                        ManagerDao obj5 = new ManagerDao();
                                                        int result5 = obj5.countAppointment();
                                                    %>
                                                    <%= result5%>
                                                </h3>
                                            </div>
                                        </div>
                                        <div class="dash-widget-info">
                                            <h6 class="text-muted">Appointment</h6>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>


                        <!-- <div class="row">
                                <div class="col-md-12 col-lg-6">
                                        Sales Chart 
                                        <div class="card card-chart">
                                                <div class="card-header">
                                                        <h4 class="card-title">Revenue</h4>
                                                </div>
                                                <div class="card-body">
                                                        <div id="morrisArea"></div>
                                                </div>
                                        </div>
                                         Sales Chart 
    
                                </div>
                                <div class="col-md-12 col-lg-6">
                                         Invoice Chart 
                                        <div class="card card-chart">
                                                <div class="card-header">
                                                        <h4 class="card-title">Status</h4>
                                                </div>
                                                <div class="card-body">
                                                        <div id="morrisLine"></div>
                                                </div>
                                        </div>
                                        Invoice Chart 
                                </div>
                        </div>  -->


                        <div class="row">
                            <jsp:useBean id="userDAO" scope="request" class="sample.dao.UserDAO" > 
                            </jsp:useBean>
                            <div class="col-md-6 d-flex">

                                <!-- Recent Orders -->
                                <div class="card card-table flex-fill">
                                    <div class="card-header">
                                        <h4 class="card-title">Doctors List</h4>
                                    </div>
                                    <div class="card-body">
                                        <div class="table-responsive">
                                            <table class="table table-hover table-center mb-0">
                                                <thead>
                                                    <tr>
                                                        <th>Doctor Name</th>
                                                        <th>Speciality</th>
                                                        <th>Phone</th>
                                                        <th class="text-center">Completed</th>
                                                    </tr>
                                                </thead>

                                                <tbody>
                                                    <c:forEach items="${userDAO.get3PopularDoctor()}" var="i">
                                                        <tr>
                                                            <td>
                                                                <h2 class="table-avatar">
                                                                    <a class="avatar avatar-sm mr-2"><img
                                                                            class="avatar-img rounded-circle"
                                                                            src="${i.image}"
                                                                            alt="User Image"></a>
                                                                    <a style="list-style: none;">${i.fullname}</a>
                                                                </h2>
                                                            </td>
                                                            <td>${i.bio}</td>
                                                            <td>${i.phone}</td>
                                                            <td class="text-center">${userDAO.getCount(i.username)}</td>
                                                        </tr>
                                                    </c:forEach>
                                                </tbody>

                                            </table>
                                        </div>
                                    </div>
                                </div>
                                <!-- /Recent Orders -->

                            </div>
                            <div class="col-md-6 d-flex">
                                <!-- Feed Activity -->
                                <div class="card  card-table flex-fill">
                                    <div class="card-header">
                                        <h4 class="card-title">Patients List</h4>
                                    </div>
                                    <div class="card-body">
                                        <div class="table-responsive">
                                            <table class="table table-hover table-center mb-0">
                                                <thead>
                                                    <tr>
                                                        <th>Patient Name</th>
                                                        <th>Phone</th>
                                                        <th>Last Visit</th>
                                                        <th class="text-right">Paid</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach items="${userDAO.get3RecentCustomer()}" var="i">
                                                        <tr>
                                                            <td>
                                                                <h2 class="table-avatar">
                                                                    <a class="avatar avatar-sm mr-2"><img
                                                                            class="avatar-img rounded-circle"
                                                                            src="${i.image}"
                                                                            alt="User Image"></a>
                                                                    <a> ${i.fullname} </a>
                                                                </h2>
                                                            </td>
                                                            <td>${i.phone}</td>
                                                            <td>${userDAO.getDateAndPaidForCustomerList(i.username).get(0)}</td>
                                                            <td class="text-right">${userDAO.getDateAndPaidForCustomerList(i.username).get(1)}</td>
                                                        </tr>
                                                    </c:forEach>

                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                                <!-- /Feed Activity -->

                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">

                                <!-- Recent Orders -->
                                <!---->
                                <div class="card card-table">
                                    <div class="card-header">
                                        <h4 class="card-title">Appointment List</h4>
                                    </div>
                                    <div class="card-body">
                                        <div class="table-responsive">
                                            <table class="table table-hover table-center mb-0">
                                                <thead>
                                                    <tr>
                                                        <th>Doctor Name</th>
                                                        <th>Service</th>
                                                        <th>Patient Name</th>
                                                        <th>Apointment Time</th>
                                                        <th>Status</th>
                                                        <th class="text-right">Amount</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <%
                                                        String img_doctor = "";
                                                        String img_cus = "";
                                                        AppointmentDAO dao = new AppointmentDAO();
                                                        List<AppointmentDTO> list = dao.get_list_appointment();
                                                        for (AppointmentDTO x : list) {
                                                            img_doctor = dao.get_image_doctor(x.getDoctorName());
                                                            img_cus = dao.get_image_cus(x.getCustomerName());
                                                    %>
                                                    <tr>
                                                        <td>
                                                            <h2 class="table-avatar">
                                                                <a class="avatar avatar-sm mr-2"><img
                                                                        class="avatar-img rounded-circle"
                                                                        src="<%= img_doctor%>"
                                                                        alt="User Image"></a>
                                                                <a><%= x.getDoctorName()%></a>
                                                            </h2>
                                                        </td>
                                                        <td><%= x.getService()%></td>

                                                        <td>
                                                            <h2 class="table-avatar">
                                                                <a class="avatar avatar-sm mr-2"><img
                                                                        class="avatar-img rounded-circle"
                                                                        src="<%= img_cus%>"
                                                                        alt="User Image"></a>

                                                                <a><%= x.getCustomerName()%></a>
                                                            </h2>
                                                        </td>
                                                        <td><%= x.getDate_()%> <span class="text-primary d-block"><%= x.getTime()%>                                                                                                                           AM</span></td>
                                                        <td>

                                                            <p><%= x.getStatus()%></p>
                                                        </td>
                                                        <td class="text-right">
                                                            $200.00
                                                        </td>
                                                    </tr>
                                                    <%
                                                        }
                                                    %>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                                <!-- /Recent Orders -->

                            </div>
                        </div>

                    </div>
                </div>
                <!-- /Page Wrapper -->

            </div>
            <!-- /Main Wrapper -->
            <div class="modal fade" id="view_specialities_details_1" aria-hidden="true" role="dialog">
                <div class="modal-dialog modal-dialog-centered" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">View Doctor Profile</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="row form-row">
                                <div class="col-12 col-sm-6">
                                    <div class="form-group">
                                        <label>Updating</label>
                                    </div>
                                </div>
                            </div>				
                        </div>
                    </div>
                </div>
            </div>

            <div class="modal fade" id="view_specialities_details_2" aria-hidden="true" role="dialog">
                <div class="modal-dialog modal-dialog-centered" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">View User Profile</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="row form-row">
                                <div class="col-12 col-sm-6">
                                    <div class="form-group">
                                        <label>   Update    </label>
                                    </div>
                                </div>							
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- /Page Wrapper -->


        </div>
        <!-- /Main Wrapper -->
    </div>
    <%
        if (status == "setStatus") {
    %>     
    <script>
        var xhttp = new XMLHttpRequest();
        xhttp.onreadystatechange = function () {
            if (this.readyState === 4 && this.status === 200) {
                document.getElementById("main").innerHTML = this.responseText;
                var table = $('.datatable').DataTable();
            }
        }
        ;
        xhttp.open("GET", "staff-list.jsp", true);
        xhttp.send();
    </script>
    <%
        }
    %>

    <%
        if (status == "setStatus_1") {
    %>     
    <script>
        var xhttp = new XMLHttpRequest();
        xhttp.onreadystatechange = function () {
            if (this.readyState === 4 && this.status === 200) {
                document.getElementById("main").innerHTML = this.responseText;
                var table = $('.datatable').DataTable();
            }

        }
        ;
        xhttp.open("GET", "doctors.jsp", true);
        xhttp.send();
    </script>
    <%
        }
    %>

    <%
        if (status == "setStatus_2") {
    %>     
    <script>
        var xhttp = new XMLHttpRequest();
        xhttp.onreadystatechange = function () {
            if (this.readyState === 4 && this.status === 200) {
                document.getElementById("main").innerHTML = this.responseText;
                var table = $('.datatable').DataTable();
            }
        }
        ;
        xhttp.open("GET", "customers.jsp", true);
        xhttp.send();
    </script>
    <%
        }
    %>


    <%
        if (status == "setStatus_5") {
    %>     

    <script>

        var xhttp = new XMLHttpRequest();
        xhttp.onreadystatechange = function () {
            if (this.readyState === 4 && this.status === 200) {
                document.getElementById("main").innerHTML = this.responseText;
                var table = $('.datatable').DataTable();
            }
        }
        ;

        xhttp.open("GET", "blogx.jsp", true);
        xhttp.send();
    </script>
    <%
        }
    %>


    <%
        if (status == "Service") {
    %>
    <script>
        var xhttp = new XMLHttpRequest();
        xhttp.onreadystatechange = function () {
            if (this.readyState === 4 && this.status === 200) {
                document.getElementById("main").innerHTML = this.responseText;
                var table = $('.datatable').DataTable();
            }
        };
        xhttp.open("GET", "service.jsp", true);
        xhttp.send();
    </script>
    <%
        }
    %>
    <!-- jQuery -->

    <script src="assets/ckeditor/ckeditor.js"></script>

    <script src="assets/js/load-main.js"></script>


    <script src="assets/js/jquery-3.2.1.min.js"></script>

    <!-- Bootstrap Core JS -->
    <script src="assets/js/popper.min.js"></script>
    <script src="assets/js/bootstrap.min.js"></script>

    <!-- Slimscroll JS -->
    <script src="assets/plugins/slimscroll/jquery.slimscroll.min.js"></script>

    <!-- Datatables JS -->
    <script src="assets/plugins/datatables/jquery.dataTables.min.js"></script>
    <script src="assets/plugins/datatables/datatables.min.js"></script>
    <script src="assets/plugins/raphael/raphael.min.js"></script>


    <!-- Custom JS -->
    <script  src="assets/js/script.js"></script>



</body>

<!-- Mirrored from dreamguys.co.in/demo/doccure/admin/index.jsp by HTTrack Website Copier/3.x [XR&CO'2014], Sat, 30 Nov 2019 04:12:34 GMT -->

</html>
