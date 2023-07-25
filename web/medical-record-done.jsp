<%-- 
    Document   : medical-record
    Created on : Jun 22, 2023, 1:04:23 PM
    Author     : MSI AD
--%>

<%@page import="sample.dto.MedicalRecordDTO"%>
<%@page import="sample.dao.MedicalRecordDAO"%>
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
            BookingDTO booking = null;
            for (BookingDTO x : list) {
                String bookingID = x.getBooking_id().trim();
                if (bookingID.equalsIgnoreCase(booking_id)) {
                    booking = x;
                }
            }
            PatientDAO pDao = new PatientDAO();
            ServiceDAO sdao = new ServiceDAO();
            List<ServiceDTO> list_service = sdao.getListServiceV2();
            int index = list_service.size();
            int count = 0;
            UserDAO uDao = new UserDAO();
            MedicalRecordDAO mdao = new MedicalRecordDAO();
            MedicalRecordDTO list_mr = mdao.getMRByBookingID(booking_id);
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
        <button onclick="Appointments()" class="btn btn-primary submit-btn" >Back</button>
        <form action="MainController">
            <div class="card">
                <div class="row"> 
                    <div class="card-body" style="width: 200px" >
                        <h4 class="card-title">Pet Information</h4>
                        <div class="row form-row">
                            <div class="col-md-12">
                                <div class="form-group">
                                </div>
                            </div>
                            <input name="patient_id" value="<%=list_mr.getPatent_id()%>" hidden="">
                            <input name="booking_id" value="<%=booking_id%>" hidden="">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label>Pet Name <span class="text-danger"></span></label>
                                    <input type="text" class="form-control" value="<%=dao.getBirdname(list_mr.getPatent_id())%>" disabled="">
                                    <label>Species <span class="text-danger"></span></label>
                                    <input type="email" class="form-control" value="<%= pDao.getSpecies(pDao.getBirdByID(booking.getPatient_id()).getSpecies_id())%>" disabled="">
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label>Age <span class="text-danger"></span></label>
                                    <input disabled="" type="text" name="fullname" class="form-control" value="<%= pDao.getBirdByID(booking.getPatient_id()).getAge()%>" >
                                    <label>Gender <span class="text-danger"></span></label>
                                    <input disabled="" type="text" class="form-control" value="<%= pDao.getBirdByID(booking.getPatient_id()).getGender()%>">
                                </div>
                            </div>
                        </div>

                    </div>
                    <div class="card-body" >
                        <h4 class="card-title">Owner Information</h4>
                        <div class="row form-row">
                            <div class="col-md-12">
                                <div class="form-group">

                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>Full Name <span class="text-danger"></span></label>
                                    <input type="text" class="form-control" value="<%=uDao.getUser(booking.getUsername_customer()).getFullname()%>" disabled="">
                                    <label>Phone <span class="text-danger"></span></label>
                                    <input type="text" name="phone" class="form-control" value="<%=uDao.getUser(booking.getUsername_customer()).getPhone()%>" readonly="">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
            <!-- /Basic Information -->
            <div class="card">

            </div>
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
                                <input type="text" class="form-control" value="<%=uDao.getUser(booking.getUsername_doctor()).getFullname()%>" disabled="">
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">

                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Date again <span class="text-danger"></span></label>
                                    <%
                                        if (booking.getBooking_status() == 4) {
                                    %>
                                <input name="date_again" type="date" readonly="" value="<%=list_mr.getDate_again()%>" class="form-control">
                                <%
                                } else {
                                %>
                                <input name="date_again" type="date"  value="<%=list_mr.getDate_again()%>" class="form-control">
                                <%
                                    }
                                %>

                            </div>
                        </div>
                        <div class="col-md-6">
                            <div  class="form-group">
                                <label>Service <span class="text-danger"></span></label>
                                    <%
                                        List<String> list_ser = mdao.getListServiceMore(list_mr.getRecord_id());
                                        int sum = 0;
                                        for (String ser : list_ser) {

                                            boolean checkVip = "Vip".equals(mdao.getSerNam(ser));
                                            boolean checkNormal = "Normal".equals(mdao.getSerNam(ser));
                                            if (checkVip == false && checkNormal == false) {
                                                sum++;
                                                boolean statusSer = mdao.getStatusService(list_mr.getRecord_id(), ser.trim());
                                                if (statusSer == true) {
                                    %>
                                <input id="service_<%=sum%>" disabled="" style="background-color:#09e5ab; border: #09e5ab;" value="<%=dao.getServiceFeeByName(mdao.getSerNam(ser))%>-<%=mdao.getSerNam(ser)%>" readonly>
                                <%
                                } else {
                                %>
                                <input id="service_<%=sum%>" disabled="" style="background-color:red; border: red;" value="<%=dao.getServiceFeeByName(mdao.getSerNam(ser))%>-<%=mdao.getSerNam(ser)%>" readonly>
                                <%
                                            }
                                        }
                                    }
                                %>
                                <div id="service">

                                </div>
                                <%
                                    if (booking.getBooking_status() == 8) {
                                %>
                                <input type="button" value="+" onclick="AddMore()">
                                <%
                                    }%>

                            </div>
                        </div>
                        <div class="col-md-6">
                            <div  class="form-group">
                                <label>Notes <span class="text-danger"></span></label>
                                    <%
                                        if (booking.getBooking_status() == 4) {
                                    %>
                                <textarea name="note" readonly="" class="form-control"><%=list_mr.getNote()%></textarea>
                                <%
                                } else {
                                %>
                                <textarea name="note"  class="form-control"><%=list_mr.getNote()%></textarea>
                                <%
                                    }
                                %>

                            </div>
                        </div>
                        <div class="col-md-2">
                            <div  class="form-group">
                                <label>Total Fee:<span class="text-danger"></span></label>
                                <input id="Total" class="form-control" name="total_fee"  value="<%=list_mr.getTotal_fee()%>" readonly>
                            </div>
                        </div>
                    </div>
                </div>

                <input name="booking_id" value="<%=booking_id%>" hidden="">
                <input name="record_id" value="<%=list_mr.getRecord_id()%>" hidden="">
                <input  hidden="" id="myInput" name="number_service" value="<%=sum%>" readonly >
                <%
                    String index_ = request.getParameter("number_service");
                %>
                <div class="submit-section submit-btn-bottom">
                    <%
                        if (booking.getBooking_status() == 8) {
                    %>
                    <input type="submit" name="action" value="Save" class="btn btn-primary submit-btn" >
                    <input value="Done" id="Done" name="action" type="submit" class="btn btn-primary submit-btn">
                    <%
                    } else if (booking.getBooking_status() == 7) {
                    %>
                    <input disabled="" type="submit" name="action" value="Save" class="btn btn-primary submit-btn" >
                    <input value="Done" disabled="" name="action" type="submit" class="btn btn-primary submit-btn">
                    <%
                    } else {
                    %>
                    <input value="Done" hidden="" name="action" type="submit" class="btn btn-primary submit-btn">

                    <%
                        }
                    %>
                </div>
        </form>
        <!-- /About Me -->



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
