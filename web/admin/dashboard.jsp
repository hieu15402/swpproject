<%-- 
    Document   : dashboard
    Created on : Jun 6, 2023, 4:11:00 PM
    Author     : MSI AD
--%>
<%@page import="sample.dao.ServiceDAO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>  
<%@ page import="java.util.Calendar" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@page import="sample.dto.AppointmentDTO"%>
<%@page import="java.util.List"%>
<%@page import="sample.dao.AppointmentDAO"%>
<%@page import="sample.dao.ManagerDao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="shortcut icon" type="image/x-icon" href="assets/img/logo-icon.png">

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="assets/css/bootstrap.min.css">

        <!-- Fontawesome CSS -->
        <link rel="stylesheet" href="assets/css/font-awesome.min.css">

        <!-- Feathericon CSS -->
        <link rel="stylesheet" href="assets/css/feathericon.min.css">

        <link rel="stylesheet" href="assets/plugins/morris/morris.css">

        <!-- Main CSS -->
        <link rel="stylesheet" href="assets/css/style.css">
        <link rel="stylesheet" href="assets/css/style_1.css">
    </head>
    <body>

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
                <c:set var="roleName" value="${sessionScope.account.role}"/>
                <c:if test="${fn:containsIgnoreCase(roleName, '5')}">
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
                                        <h6 class="text-muted">Patients</h6>

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
                                                                    src="../<%=img_doctor%>"
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
                </c:if>

                <c:if test="${fn:containsIgnoreCase(roleName, '1')}">
                    <div class="row">
                        <div class="col-xl-3 col-sm-6 col-12">
                            <div class="card">
                                <div class="card-body">
                                    <div class="dash-widget-header">
                                        <span class="dash-widget-icon text-warning border-warning">
                                            <i class="fe fe-folder"></i>
                                        </span>
                                        <div class="dash-count">
                                            <% ServiceDAO dao_2 = new ServiceDAO();%>
                                            <h3>$<%=dao_2.getTotalRevenue()%> </h3>
                                        </div>
                                    </div>
                                    <div class="dash-widget-info">

                                        <h6 class="text-muted">Revenue</h6>
                                        <div class="progress progress-sm">
                                            <div class="progress-bar bg-warning w-50"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>     
                        <div class="col-xl-3 col-sm-6 col-12">
                            <div class="card">
                                <div class="card-body">
                                    <div class="dash-widget-header">
                                        <span class="dash-widget-icon text-warning border-warning">
                                            <i class="fe fe-folder"></i>
                                        </span>
                                        <div class="dash-count">
                                            <h3>$<%=dao_2.getTotalRevenue()%> </h3>
                                        </div>
                                    </div>
                                    <div class="dash-widget-info">

                                        <h6 class="text-muted">Revenue</h6>
                                        <div class="progress progress-sm">
                                            <div class="progress-bar bg-warning w-50"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div> 
                        <div class="col-xl-3 col-sm-6 col-12">
                            <div class="card">
                                <div class="card-body">
                                    <div class="dash-widget-header">
                                        <span class="dash-widget-icon text-warning border-warning">
                                            <i class="fe fe-folder"></i>
                                        </span>
                                        <div class="dash-count">
                                            <h3>$<%=dao_2.getTotalRevenue()%> </h3>
                                        </div>
                                    </div>
                                    <div class="dash-widget-info">

                                        <h6 class="text-muted">Revenue</h6>
                                        <div class="progress progress-sm">
                                            <div class="progress-bar bg-warning w-50"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-3 col-sm-6 col-12">
                            <div class="card">
                                <div class="card-body">
                                    <div class="dash-widget-header">
                                        <span class="dash-widget-icon text-warning border-warning">
                                            <i class="fe fe-folder"></i>
                                        </span>
                                        <div class="dash-count">
                                            <h3>$<%=dao_2.getTotalRevenue()%> </h3>
                                        </div>
                                    </div>
                                    <div class="dash-widget-info">

                                        <h6 class="text-muted">Revenue</h6>
                                        <div class="progress progress-sm">
                                            <div class="progress-bar bg-warning w-50"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>



                    <!--CHARTTTTT-->
                    <div class="row">
                        <%
                            Calendar calendar = Calendar.getInstance();
                            calendar.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);
                            SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
                            String firstDayOfWeek = dateFormat.format(calendar.getTime());
                            calendar.add(Calendar.DATE, 6);
                            String lastDayOfWeek = dateFormat.format(calendar.getTime());
                        %>
                        <div class="col-sm-6 col-md-7" >
                            <div class="card card-chart">
                                <div class="card-header">
                                    <h4 class="card-title">Weekly Income from <%=firstDayOfWeek%> to <%=lastDayOfWeek%></h4>
                                </div>
                                <div class="card-body">
                                    <canvas id="myChart_3"></canvas>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6 col-md-5">
                            <div class="card card-chart">
                                <div class="card-header">
                                    <h4 class="card-title">Customer satisfaction</h4>
                                </div>
                                <div class="card-body">
                                    <canvas id="myChart_2"></canvas>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-sm-6 col-md-7" style="top: -100px;">
                            <div class="card card-chart">
                                <div class="card-header">
                                    <h4 class="card-title">Revenue by Month in 2023</h4>
                                </div>
                                <div class="card-body">
                                    <canvas id="myChart"></canvas>
                                </div>
                            </div>
                        </div>


                    </div>

                </c:if>
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

    <script src="assets/js/jquery-3.2.1.min.js"></script>

    <!-- Bootstrap Core JS -->
    <script src="assets/js/popper.min.js"></script>
    <script src="assets/js/bootstrap.min.js"></script>

    <!-- Slimscroll JS -->
    <script src="assets/plugins/slimscroll/jquery.slimscroll.min.js"></script>


    <!-- Custom JS -->


</body>
</html>
