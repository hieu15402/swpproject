<%-- 
    Document   : patient_dashboard
    Created on : Jun 8, 2023, 12:14:21 AM
    Author     : MSI AD
--%>

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
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

        <link rel="stylesheet" href="assets/plugins/datatables/datatables.min.css">


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

        <div  class="card">
            <div class="card-body pt-0">

                <!-- Tab Menu -->
                <nav class="user-tabs mb-4">

                </nav>
                <!-- /Tab Menu -->

                <!-- Tab Content -->


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
                                    <form action="MainController">
                                        <table class="datatable table table-hover table-center mb-0">
                                            <thead style="background-color: #FFEFC1">
                                                <tr>
                                                    <th>User Name</th>
                                                    <th>Bird Name</th>
                                                    <th>Time Slot</th>
                                                    <th >Service</th>
                                                    
                                                    <th></th>

                                                </tr>
                                            </thead>

                                            <tbody>
                                                <%                                                    for (BookingDTO x : list) {
                                                        if (x.getBooking_status() == 1) {
                                                %>
                                                <tr>
                                                    <td>
                                                        <%=dao.customerName(x.getUsername_customer())%>
                                                    </td>
                                            <input type="hidden" name="bookingID" value="<%=x.getBooking_id()%>">
                                            <td><%= dao.getBirdname(x.getPatient_id())%></td>
                                            <td> <%=x.getDate()%><br> <%= dao.getSlotTime(x.getBooking_id())%></td>                                          
                                            <td ><%= dao.getServicename(x.getBooking_id())%></td>                                         
                                            <input type="hidden" value="2" name="status_booking">
                                            
                                            <td><div class="submit-section">
                                                    <a href="MainController?bookingID=<%=x.getBooking_id()%>&status_booking=2&action=Accept" style="background-color: aquamarine;padding:  13.5px; width: 80px; color: black">Accept</a>
                                                    <a href="MainController?bookingID=<%=x.getBooking_id()%>&action=Decline" style="background-color: red;padding:  13.5px; width: 80px; color: white">Decline</a>
                                                </div>
                                            </td>
                                            </tr>


                                            <%
                                                    }
                                                }
                                            %>
                                            </tbody>
                                        </table>
                                    </form>
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

            </div>
        </div>

        <script src="assets/js/jquery.min.js"></script>

        <script src="assets/js/jquery-3.2.1.min.js"></script>
        <script src="assets/plugins/datatables/jquery.dataTables.min.js"></script>
        <script src="assets/plugins/datatables/datatables.min.js"></script>
        <script src="assets/js/popper.min.js"></script>

        <script src="assets/js/bootstrap.min.js"></script>

        <script src="assets/plugins/slimscroll/jquery.slimscroll.min.js"></script>

        <script  src="assets/js/script.js"></script>
        <script src="assets/js/slick.js"></script>



    </body>

</html>
