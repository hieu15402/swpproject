<%-- 
    Document   : patient_dashboard
    Created on : Jun 8, 2023, 12:14:21 AM
    Author     : MSI AD
--%>

<%@page import="sample.dao.ServiceDAO"%>
<%@page import="sample.dto.FeedbackDTO"%>
<%@page import="sample.dao.FeedbackDAO"%>
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
        <style>
            .star-container{
                display: flex;
            }
            .star {
                width: 20px;
                height: 20px;
                background-color: #ffd700;
                clip-path: polygon(
                    50% 0%,
                    61% 35%,
                    98% 35%,
                    68% 57%,
                    79% 91%,
                    50% 70%,
                    21% 91%,
                    32% 57%,
                    2% 35%,
                    39% 35%
                    );
            }
            .star-none {
                width: 20px;
                height: 20px;
                background-color: #6c7689;
                clip-path: polygon(
                    50% 0%,
                    61% 35%,
                    98% 35%,
                    68% 57%,
                    79% 91%,
                    50% 70%,
                    21% 91%,
                    32% 57%,
                    2% 35%,
                    39% 35%
                    );

            }

        </style>

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
            UserDAO udao = new UserDAO();
            BookingDAO sdao = new BookingDAO();
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
                            FeedbackDAO dao = new FeedbackDAO();
                            List<FeedbackDTO> list = dao.getAllFeedbackDoctor(user.getUsername());
                            if (list == null) {
                        %>
                        <h1> Don't have feedback </h1>
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
                                                    <th>Customer</th>
                                                    <th>Service</th>
                                                    <th>Feedback Content</th>
                                                    <th >Rating</th>
                                                    <th >Date</th>
                                                </tr>
                                            </thead>

                                            <tbody>
                                                <%                                                    for (FeedbackDTO x : list) {
                                                %>
                                                <tr>
                                                    <td><%=udao.getUser(x.getUser_name()).getFullname()%></td>
                                                    <td><%=dao.nameSer(x.getService_id())%></td>
                                                    <td><%=x.getFeedback_content()%></td>
                                                    <td> <div class="star-container">
                                                            <%
                                                                int count = 5;
                                                                for (int i = 0; i < x.getRating_star(); i++) {
                                                            %>
                                                            <span><div class="star"></div> </span>
                                                            <%
                                                                }
                                                                for (int i = 0; i < 5 - x.getRating_star(); i++) {
                                                            %>
                                                            <span><div class="star-none"></div> </span>
                                                            <%
                                                                }
                                                            %>
                                                        </div></td>
                                                    <td><%=x.getDate()%></td>

                                                </tr>
                                                <%
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
        <script src="assets/js/jquery-3.2.1.min.js"></script>
        <script src="assets/plugins/datatables/jquery.dataTables.min.js"></script>
        <script src="assets/plugins/datatables/datatables.min.js"></script>
        <script  src="assets/js/script.js"></script>

    </body>
</html>
