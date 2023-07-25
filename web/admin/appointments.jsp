<%-- 
    Document   : appointments
    Created on : Jun 6, 2023, 4:19:52 PM
    Author     : MSI AD
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>  
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
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

        <!-- Datatables CSS -->
        <link rel="stylesheet" href="assets/plugins/datatables/datatables.min.css">

        <!-- Main CSS -->
        <link rel="stylesheet" href="assets/css/style.css">

    </head>
    <body>
         <jsp:useBean id="appointmentDAO" scope="request" class="sample.dao.AppointmentDAO"/>
        <div class="page-wrapper">
            <div class="content container-fluid">

                <!-- Page Header -->
                <div class="page-header">
                    <div class="row">
                        <div class="col-sm-12">
                            <h3 class="page-title">Appointments</h3>
                            <ul class="breadcrumb">
                                <li class="breadcrumb-item"><a href="index.jsp">Dashboard</a></li>
                                <li class="breadcrumb-item active">Appointments</li>
                            </ul>
                        </div>
                    </div>
                </div>
                <!-- /Page Header -->
                <div class="row">
                    <div class="col-md-12">

                        <!-- Recent Orders -->
                        <div class="card">
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="datatable table table-hover table-center mb-0">
                                        <thead>
                                            <tr>
                                                <th>Doctor Name</th>
                                                <th>Speciality</th>
                                                <th>Customer Name</th>
                                                <th>Apointment Time</th>
                                                <th>Status</th>
                                                <th class="text-right">Amount</th>
                                                <th class="text-right">Details</th>

                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${appointmentDAO.appointment}" var="i">
                                                <tr>
                                                    <td>
                                                        <h2 class="table-avatar">
                                                            <a class="avatar avatar-sm mr-2"><img class="avatar-img rounded-circle" src="${i.imgDoc}" alt="User Image"></a>
                                                            <a href="#view_specialities_details_1" data-toggle="modal">${i.doctorName}</a>
                                                        </h2>
                                                    </td>
                                                    <td>${i.speciality }</td>
                                                    <td>
                                                        <h2 class="table-avatar">
                                                            <a class="avatar avatar-sm mr-2"><img class="avatar-img rounded-circle" src="${i.imgCus}" alt="User Image"></a>
                                                            <a href="#view_specialities_details_2" data-toggle="modal">${i.customerName}</a>
                                                        </h2>
                                                    </td>
                                                    <td>${i.date}<span class="text-primary d-block">${i.time}</span></td>
                                                    <td>
                                                        <p>${i.status}</p>
                                                    </td>
                                                    <td class="text-right">
                                                        ${i.fee}
                                                    </td>
                                                    <td class="text-right">
                                                        Updating
                                                    </td>
                                                </tr>
                                                <%--<tr>
                                                    <td>
                                                        <h2 class="table-avatar">
                                                            <a class="avatar avatar-sm mr-2"><img class="avatar-img rounded-circle" src="assets/img/doctors/doctor-thumb-02.jpg" alt="User Image"></a>
                                                            <a href="#view_specialities_details_1" data-toggle="modal">Dr. Darren Elder</a>
                                                        </h2>
                                                    </td>
                                                    <td>Dental</td>
                                                    <td>
                                                        <h2 class="table-avatar">
                                                            <a  class="avatar avatar-sm mr-2"><img class="avatar-img rounded-circle" src="assets/img/patients/patient2.jpg" alt="User Image"></a>
                                                            <a href="#view_specialities_details_2" data-toggle="modal">username </a>
                                                        </h2>
                                                    </td>

                                                        <td>5 Nov 2019 <span class="text-primary d-block">11.00 AM - 11.35 AM</span></td>
                                                        <td>
                                                            <p>Pending</p>
                                                        </td>
                                                        <td class="text-right">
                                                            $200.00
                                                        </td>
                                                        <td class="text-right">
                                                            Updating
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <h2 class="table-avatar">
                                                                <a class="avatar avatar-sm mr-2"><img class="avatar-img rounded-circle" src="assets/img/doctors/doctor-thumb-03.jpg" alt="User Image"></a>
                                                                <a href="#view_specialities_details_1" data-toggle="modal">Dr. Deborah Angel</a>
                                                            </h2>
                                                        </td>
                                                        <td>Cardiology</td>
                                                        <td>
                                                            <h2 class="table-avatar">
                                                                <a href="profile.jsp" class="avatar avatar-sm mr-2"><img class="avatar-img rounded-circle" src="assets/img/patients/patient3.jpg" alt="User Image"></a>
                                                                <a href="#view_specialities_details_2" data-toggle="modal">Carl Kelly</a>
                                                            </h2>
                                                        </td>
                                                        <td>11 Nov 2019 <span class="text-primary d-block">12.00 PM - 12.15 PM</span></td>
                                                        <td>
                                                            <p>Pending</p>
                                                        </td>
                                                        <td class="text-right">
                                                            $200.00
                                                        </td>
                                                        <td class="text-right">
                                                            Updating
                                                        </td>
                                                    </tr>	--%>
                                            </c:forEach>							
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


        <!-- /Main Wrapper -->

        <!-- View Details Modal -->
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

        <!-- Datatables JS -->
        <script src="assets/plugins/datatables/jquery.dataTables.min.js"></script>
        <script src="assets/plugins/datatables/datatables.min.js"></script>

        <!-- Custom JS -->
        <script  src="assets/js/script.js"></script>
    </body>
</html>
