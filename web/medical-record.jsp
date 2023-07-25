<%-- 
    Document   : medical-record
    Created on : Jun 22, 2023, 1:04:23 PM
    Author     : MSI AD
--%>

<%@page import="sample.dao.UserDAO"%>
<%@page import="sample.dao.PatientDAO"%>
<%@page import="sample.dto.BookingDTO"%>
<%@page import="sample.dao.BookingDAO"%>
<%@page import="java.util.List"%>
<%@page import="sample.dto.ServiceDTO"%>
<%@page import="sample.dao.ServiceDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="assets/img/favicon.png" rel="icon">

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="assets/css/bootstrap.min.css">

        <!-- Fontawesome CSS -->
        <link rel="stylesheet" href="assets/plugins/fontawesome/css/fontawesome.min.css">
        <link rel="stylesheet" href="assets/plugins/fontawesome/css/all.min.css">

        <!-- Select2 CSS -->
        <link rel="stylesheet" href="assets/plugins/select2/css/select2.min.css">

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="assets/plugins/bootstrap-tagsinput/css/bootstrap-tagsinput.css">

        <link rel="stylesheet" href="assets/plugins/dropzone/dropzone.min.css">

        <!-- Main CSS -->
        <link rel="stylesheet" href="assets/css/style.css">

        <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!--[if lt IE 9]>
                <script src="assets/js/html5shiv.min.js"></script>
                <script src="assets/js/respond.min.js"></script>
        <![endif]-->
        <script>

        </script>
    </head>
    <body>

        <%
            String booking_id = request.getParameter("Booking_id");
            BookingDAO dao = new BookingDAO();
            List<BookingDTO> list = dao.getAllBooking();
            PatientDAO pDao = new PatientDAO();
            ServiceDAO sdao = new ServiceDAO();
            List<ServiceDTO> list_service = sdao.getListServiceV2();
            int index = list_service.size();
            int count = 0;
            UserDAO uDao = new UserDAO();
            for (ServiceDTO x : list_service) {
                count++;
        %>
        <input hidden="" id="service_name_<%=count%>" value="<%=x.getService_name()%>">
        <input hidden="" id="service_id_<%=count%>" value="<%=x.getService_id()%>">
        <input hidden="" id="service_fee_<%=count%>" value="<%=x.getFee()%>">
        <%
            }
        %>
        <input hidden="" id="index" value="<%=index%>">
        <%
            int status_booking = 0;
            for (BookingDTO x : list) {
                String Id = x.getBooking_id().trim();
                if (Id.equalsIgnoreCase(booking_id)) {
                    status_booking = x.getBooking_status();
        %>
        <button onclick="Appointments()" class="btn btn-primary submit-btn" >Back</button>
        <form action="MainController">
            <div class="card">
                <div class="row">
                    <div class="card-body">
                        <h4 class="card-title">Pet Information</h4>
                        <div class="row form-row">
                            <div class="col-md-12">
                                <div class="form-group">

                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label>Pet Name <span class="text-danger"></span></label>
                                    <input type="text" class="form-control" value="<%= dao.getBirdname(x.getPatient_id())%>" disabled="">
                                    <label>Species <span class="text-danger"></span></label>
                                    <input type="email" class="form-control" value="<%= pDao.getSpecies(pDao.getBirdByID(x.getPatient_id()).getSpecies_id())%>" disabled="">
                                </div>
                            </div>
                            <input name="patient_id" value="<%=x.getPatient_id()%>" hidden="">
                            <input name="booking_id" value="<%=booking_id%>" hidden="">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label>Age <span class="text-danger"></span></label>
                                    <input disabled="" type="text" name="fullname" class="form-control" value="<%= pDao.getBirdByID(x.getPatient_id()).getAge()%>" >
                                    <label>Gender <span class="text-danger"></span></label>
                                    <input disabled="" type="text" class="form-control" value="<%= pDao.getBirdByID(x.getPatient_id()).getGender()%>">
                                </div>
                            </div>

                        </div>
                    </div>
                    <div class="card-body">
                        <h4 class="card-title">Owner Information</h4>
                        <div class="row form-row">
                            <div class="col-md-12">
                                <div class="form-group">

                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>Full Name <span class="text-danger"></span></label>
                                    <input type="text" class="form-control" value="<%=uDao.getUser(x.getUsername_customer()).getFullname()%>" disabled="">
                                    <label>Phone <span class="text-danger"></span></label>
                                    <input type="text" name="phone" class="form-control" value="<%=uDao.getUser(x.getUsername_customer()).getPhone()%>" readonly="">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- /Basic Information -->
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title">Medical Details</h4>
                    <div class="row form-row">
                        <div class="col-md-12">
                            <div class="form-group">

                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Doctor's Name <span class="text-danger"></span></label>
                                <input type="text" class="form-control" value="<%=uDao.getUser(x.getUsername_doctor()).getFullname()%>" disabled="">
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">

                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Date again <span class="text-danger"></span></label>
                                <input name="date_again" type="date" class="form-control"  >
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div  class="form-group">
                                <label>Service <span class="text-danger"></span></label>
                                <div id="service">
<!--                                    <input id="service_0" type="text"   name="service_1" style="color: black; background-color:#09e5ab; border: #09e5ab;"  readonly="" value="<%=dao.getServiceFeeByName(dao.getServicename(x.getBooking_id()))%>-<%= dao.getServicename(x.getBooking_id())%>">-->
                                </div>
                                <input type="button" value="+" onclick="Add()">
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div  class="form-group">
                                <label>Notes <span class="text-danger"></span></label>
                                <textarea name="note" class="form-control"></textarea>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div  class="form-group">
                                <label>Total Fee:<span class="text-danger"></span></label>
                                <input id="Total" class="form-control" name="total_fee"  value="<%=dao.getServiceFeeByName(dao.getServicename(x.getBooking_id()))%>" readonly>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- About Me -->
            <%
                    }
                }
            %>
            <!-- /About Me -->
            <input onchange="disable_done()" hidden="" id="myInput" name="number_service" value="0" readonly>

            <%
                String index_ = request.getParameter("number_service");
            %>

            <!-- Registrations -->
            <div class="submit-section submit-btn-bottom">
                <%
                    if (status_booking == 2) {
                %>
                <input disabled="" type="submit" name="action" value="Save" class="btn btn-primary submit-btn" >
                <input disabled="" type="submit" name="action" value="Done Medical" class="btn btn-primary submit-btn" >
                <%
                } else if (status_booking == 3) {
                %>
                <input type="submit" name="action" value="Save" class="btn btn-primary submit-btn" >
                <input  type="submit" id="Done" name="action" value="Done Medical" class="btn btn-primary submit-btn" >
                <%
                    }
                %>

            </div>

        </form>
        <!-- jQuery -->
        <script src="assets/js/doctor-dashboard.js"></script>
        <script src="assets/js/jquery.min.js"></script>

        <!-- Bootstrap Core JS -->
        <script src="assets/js/popper.min.js"></script>
        <script src="assets/js/bootstrap.min.js"></script>

        <!-- Sticky Sidebar JS -->
        <script src="assets/plugins/theia-sticky-sidebar/ResizeSensor.js"></script>
        <script src="assets/plugins/theia-sticky-sidebar/theia-sticky-sidebar.js"></script>

        <!-- Select2 JS -->
        <script src="assets/plugins/select2/js/select2.min.js"></script>

        <!-- Dropzone JS -->
        <script src="assets/plugins/dropzone/dropzone.min.js"></script>

        <!-- Bootstrap Tagsinput JS -->
        <script src="assets/plugins/bootstrap-tagsinput/js/bootstrap-tagsinput.js"></script>

        <!-- Profile Settings JS -->
        <script src="assets/js/profile-settings.js"></script>

        <!-- Custom JS -->
        <script src="assets/js/script.js"></script>
        <script src="assets/js/checkValidate.js"></script>

    </body>
</html>
