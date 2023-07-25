<%-- 
    Document   : patient_dashboard
    Created on : Jun 8, 2023, 12:14:21 AM
    Author     : MSI AD
--%>

<%@page import="java.sql.Time"%>
<%@page import="java.time.LocalTime"%>
<%@page import="java.time.LocalDate"%>
<%@page import="sample.dao.UserDAO"%>
<%@page import="sample.dao.BookingDAO"%>
<%@page import="sample.dto.BookingDTO"%>
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
            UserDAO udao = new UserDAO();
            List<UserDTO> doctor = udao.doctorList();
        %>

        <div class="card">
            <div class="card-body pt-0">

                <!-- Tab Menu -->
                <nav class="user-tabs mb-4">
                    <ul class="nav nav-tabs nav-tabs-bottom nav-justified">
                        <li class="nav-item">

                        </li>
                    </ul>
                </nav>
                <!-- /Tab Menu -->

                <!-- Tab Content -->

                <form action="MainController">
                    <div class="tab-content pt-0">
                        <!-- Appointment Tab -->

                        <div id="pat_appointments" class="tab-pane fade show active">
                            <%
                                BookingDAO dao = new BookingDAO();
                                List<BookingDTO> list = dao.getAllBooking();
                                if (list == null) {
                            %>
                            <h1> Hiện chưa có lịch nào </h1>
                            <%
                            } else {

                            %>
                            <div class="card card-table mb-0">
                                <div class="card-body">
                                    <div class="table-responsive">
                                        <table class="datatable table table-hover table-center mb-0">
                                            <thead style="background-color: #FFEFC1">
                                                <tr>
                                                    <th>User Name</th>
                                                    <th>Bird Name</th>
                                                    <th>Time Slot</th>
                                                    <th >Service</th>
                                                    <th>Doctor</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <%                                                    for (BookingDTO x : list) {
                                                        if (x.getBooking_status() == 3) {
                                                %>
                                                <tr>
                                                    <td>
                                                        <%=dao.customerName(x.getUsername_customer())%>
                                                    </td>
                                            <input type="hidden" name="bookingID" value=" <%=x.getBooking_id()%>">
                                            <td><%= dao.getBirdname(x.getPatient_id())%></td>
                                            <td> <%=x.getDate()%><br> <%= dao.getSlotTime(x.getBooking_id())%></td>
                                            <td><%= dao.getServicename(x.getBooking_id())%></td>
                                            <td>
                                                <%=dao.doctorName(x.getUsername_doctor())%>
                                            </td>
                                            <input type="hidden" value="4" name="status_booking">

                                            <%
                                                    }
                                                }
                                            %>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                            <%
                                }
                            %>
                        </div>


                        <!-- /Appointment Tab -->

                        <!-- Prescription Tab -->

                        <!-- /Prescription Tab -->

                        <!-- Medical Records Tab -->

                        <!-- /Medical Records Tab -->

                        <!-- Billing Tab -->

                        <!-- /Billing Tab -->

                    </div>
                    <!-- Tab Content -->
                </form>
            </div>
        </div>
    </body>
</html>
