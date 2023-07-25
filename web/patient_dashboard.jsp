<%-- 
    Document   : patient_dashboard
    Created on : Jun 8, 2023, 12:14:21 AM
    Author     : MSI AD
--%>

<%@page import="sample.dao.PatientDAO"%>
<%@page import="sample.dto.PatientDTO"%>
<%@page import="sample.dto.MedicalRecordDTO"%>
<%@page import="sample.dto.UserDTO"%>
<%@page import="sample.dto.AppointmentDTO"%>
<%@page import="java.util.List"%>
<%@page import="sample.dao.AppointmentDAO"%>
<%@page import="sample.dao.MedicalRecordDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        
    </head>
    <body>
        <%
            HttpSession s = request.getSession();
            UserDTO user = (UserDTO) s.getAttribute("account");
            if (user != null) {

            } else {
                response.sendRedirect("login.jsp");
            }
        %>

        <div class="card">
            <div class="card-body pt-0">

                <!-- Tab Menu -->
                <nav class="user-tabs mb-4">
                    <ul class="nav nav-tabs nav-tabs-bottom nav-justified">
                        <li class="nav-item">
                            <a class="nav-link active" href="#pat_appointments" data-toggle="tab">Appointments</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#pat_medical_records" data-toggle="tab"><span class="med-records">Medical Records</span></a>
                        </li>

                    </ul>
                </nav>
                <!-- /Tab Menu -->

                <!-- Tab Content -->

                <div class="tab-content pt-0">
                    <!-- Appointment Tab -->

                    <div id="pat_appointments" class="tab-pane fade show active">
                        <%
                            AppointmentDAO daoApp = new AppointmentDAO();
                            List<AppointmentDTO> ls = daoApp.getAppointmentForUser(user.getUsername());
                            if (ls == null) {
                        %>
                        <h1> Bạn chưa có lịch nào </h1>
                        <%
                        } else {
                        %>
                        <div class="card card-table mb-0">
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="datatable table table-hover table-center mb-0">
                                        <thead>
                                            <tr>
                                                <th style="width: 30%;">Doctor</th>
                                                <th style="width: 12%;">Appt Date</th>
                                                <th style="width: 15%;">Booking Date</th>
                                                <th style="width: 5%;">Amount</th>
                                                <th style="width: 28%;">Service</th>
                                                <th style="width: 10%;">Status</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%  for (AppointmentDTO apt : ls) {
                                            %>
                                            <tr>
                                                <td>
                                                    <h2 class="table-avatar">
                                                        <a href="doctor-profile.jsp" class="avatar avatar-sm mr-2">
                                                            <img class="avatar-img rounded-circle" src="<%= !apt.getImgDoc().equals("") ? apt.getImgDoc() : "assets/img/user_image_default.png"%>" alt="User Image">
                                                        </a>
                                                        <a href="doctor-profile.jsp"><%= apt.getDoctorName()%><span><%= apt.getSpeciality()%></span></a>
                                                    </h2>
                                                </td>
                                                <td><%= apt.getDate()%><span class="d-block text-info"> <% if (apt.getTime().equalsIgnoreCase("1")) { %>
                                                        7:00 - 9:00
                                                        <% } else if (apt.getTime().equalsIgnoreCase("2")) { %>
                                                        9:00 - 11:00
                                                        <% } else if (apt.getTime().equalsIgnoreCase("3")) { %>
                                                        13:00 - 15:00
                                                        <% } else if (apt.getTime().equalsIgnoreCase("4")) { %>
                                                        15:00 - 17:00
                                                        <% }%>
                                                    </span> 
                                                </td> 
                                                <td><%= apt.getDateBooking()%></td>
                                                <td><%= apt.getFee()%></td>
                                                <td><%= apt.getService()%></td>
                                                <td><span class="badge badge-pill"><%= daoApp.getStatusName(apt.getStatus())%> </span></td>
                                                <!-- <td class="text-right">
                                                    <div class="table-action">
                                                        <a href="javascript:void(0);" class="btn btn-sm bg-primary-light">
                                                            <i class="fas fa-print"></i> Print
                                                        </a>
                                                        <a href="javascript:void(0);" class="btn btn-sm bg-info-light">
                                                            <i class="far fa-eye"></i> View
                                                        </a>
                                                    </div>
                                                </td> -->
                                            </tr>
                                            <% }%>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <%
                            }%>
                    </div>


                    <!-- /Appointment Tab -->

                    <!-- Prescription Tab -->

                    <!-- /Prescription Tab -->

                    <!-- Medical Records Tab -->
                    <div id="pat_medical_records" class="tab-pane fade">
                        <%

                            MedicalRecordDAO daoMR = new MedicalRecordDAO();
                            List<MedicalRecordDTO> MR = daoMR.getMR(user.getUsername());

                            if (MR == null) {
                        %>
                        <h1> Bạn chưa có không có ghi nhận nào </h1>
                        <%
                        } else {
                        %>
                        <div class="card card-table mb-0">
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="datatable table table-hover table-center mb-0">
                                        <thead>
                                            <tr>

                                                <th>Date Again </th>
                                                <th>Service</th>
                                                <th>Note</th>
                                                <th>Doctor</th>
                                                <th>Patient(Bird)</th>
                                            </tr>     
                                        </thead>
                                        <tbody>
                                            <%
                                                for (MedicalRecordDTO mrr : MR) {
                                                    int index = MR.indexOf(mrr);
                                                    PatientDAO daoBird = new PatientDAO();
                                                    PatientDTO bird = daoBird.getOneBird(mrr.getPatent_id());
                                            %>
                                            <tr>

                                                <td><%= mrr.getDate_again()%></td>
                                                <td>

                                                    <ul>

                                                        <%
                                                            List<String> moreService = daoMR.getListServiceMore(mrr.getRecord_id());
                                                                for (String ser_id : moreService) {%>

                                                        <li><%=daoMR.getSerNam(ser_id)%></li>


                                                        <% }
                                                        %>

                                                    </ul>
                                                </td>
                                                <td> <%= mrr.getNote()%>  </td>
                                                <td>
                                                    <h2 class="table-avatar">
                                                        <a href="doctor-profile.jsp" class="avatar avatar-sm mr-2">
                                                            <img class="avatar-img rounded-circle" src="<%= daoMR.get_image_doctor(mrr.getDoctorName())%>" >
                                                        </a>
                                                        <a href="doctor-profile.jsp"><%= daoMR.getDocName(mrr.getDoctorName())%><span> <%= daoMR.getSpec(mrr.getDoctorName())%></span></a>
                                                    </h2>
                                                </td>
                                                <td>
                                                    <h2 class="table-avatar">
                                                        <a href="#" class="avatar avatar-sm mr-2">
                                                            <img class="avatar-img rounded-circle" src="<%=bird.getImage()%>" >
                                                        </a>
                                                        <a href="#"><%=bird.getName()%><span> <%= daoBird.getIDSpecies(bird.getSpecies_id())%></span></a>
                                                    </h2>
                                                </td>
                                                <td class="text-right">
                                                    <div class="table-action">
                                                        <a href="javascript:void(0);" class="btn btn-sm bg-primary-light" data-toggle="modal" data-target="#feedback_<%=index%>">
                                                            <i class="fas fa-thumbs-up"></i> Feedback
                                                        </a>
                                                    </div> <br>

                                                    <form action="MainController">
                                                        <div class="table-action">
                                                            <button type="submit" name="action" class="btn btn-sm bg-primary-light" value="dateAgain">
                                                                <input hidden="" name="username_doc" value="<%=mrr.getDoctorName()%>" >
                                                                <input hidden="" name="patient_id" value="<%=bird.getPatient_id()%>" >
                                                                <input hidden="" name="username" value="<%=user.getUsername()%>" >
                                                                <input hidden="" name="service" value="<%=mrr.getSer_id()%>" >
                                                                <input hidden="" name="dateagain" value="<%= mrr.getDate_again()%>" >
                                                                <i class="fas"></i> Booking Again
                                                            </button>
                                                        </div>
                                                    </form>

                                                </td>
                                            </tr>
                                            <% } %>
                                        </tbody>  	
                                    </table>
                                </div>
                            </div>
                        </div>

                        <%
                            }%>
                    </div>
                    <!-- /Medical Records Tab -->

                    <!-- Billing Tab -->

                    <!-- /Billing Tab -->

                </div>
                <!-- Tab Content -->

            </div>
        </div>
    </body>
</html>
