<%-- 
    Document   : appointments
    Created on : May 29, 2023, 4:18:27 PM
    Author     : MSI AD
--%>

<%@page import="sample.dto.SlotDTO"%>
<%@page import="sample.dto.UserDTO"%>
<%@page import="sample.dto.BookingDTO"%>
<%@page import="java.util.List"%>
<%@page import="sample.dao.BookingDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html> 
<html lang="en">

    <!-- doccure/appointments.jsp  30 Nov 2019 04:12:09 GMT -->
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
            BookingDAO dao = new BookingDAO();
            List<BookingDTO> list = dao.getAllBooking();
            if (list == null) {
        %>
        Don't have  appointment
        <%
        } else {
        %>


        <table style="height: 400px" class="datatable table table-hover table-center mb-0" border="1">
            <thead>
                <tr>
                    <jsp:useBean id="BookingDAO" scope="request" class="sample.dao.BookingDAO"/>
                    <th>Slot/Date</th>
                    <th><span>Mon</span><br>
                        <span class="slot-date">${BookingDAO.getWeekDates().get(0)}</span></th>
                    <th><span>Tue</span><br>
                        <span class="slot-date">${BookingDAO.getWeekDates().get(1)}</span></th>
                    <th><span>Wed</span><br>
                        <span class="slot-date">${BookingDAO.getWeekDates().get(2)}</span></th>
                    <th><span>Thu</span><br>
                        <span class="slot-date">${BookingDAO.getWeekDates().get(3)}</span></th>
                    <th><span>Fri</span><br>
                        <span class="slot-date">${BookingDAO.getWeekDates().get(4)}</span></th>
                    <th><span>Sat</span><br>
                        <span class="slot-date">${BookingDAO.getWeekDates().get(5)}</span></th>
                    <th><span>Sun</span><br>
                        <span class="slot-date">${BookingDAO.getWeekDates().get(6)}</span></th>
                </tr>
            </thead>
            <%
                List<SlotDTO> slot = dao.getSlot();
            %>
            <tbody>
                <%
                    for (int i = 0; i < slot.size(); i++) {
                        String[][] app = dao.slotAppointment(user.getUsername());
                %>
                <tr>
                    <td><%=slot.get(i).getTime_slot()%></td>
                    <td id="Mon-slot1">
                        <%
                            if (app[1][i + 1] == null) {

                            } else {
                                String[] ID = app[1][i + 1].split(" ");
                                for (int j = 0; j < ID.length; j++) {
                                    int status_book = dao.CheckBooking(ID[j]);
                                    if (status_book == 2) {
                        %>
                        <button style="background-color: #9f9f9f"  class="btn btn-primary submit-btn" onclick="Medical('<%=ID[j]%>')"><%= ID[j]%></button>
                        <%
                        } else if (status_book == 4 || status_book == 5 ) {
                        %>
                        <button class="btn btn-primary submit-btn" onclick="Medical_done('<%=ID[j]%>')"><%= ID[j]%></button>
                        <%
                        } else if (status_book == 3) {
                        %>
                        <button style="background-color: blue"  class="btn btn-primary submit-btn" onclick="Medical('<%=ID[j]%>')"><%= ID[j]%></button>
                        <%
                        } else if (status_book == 7) {
                        %>
                        <button class="btn btn-primary submit-btn" style="background-color: blue"  onclick="Medical_done('<%=ID[j]%>')"><%= ID[j]%></button>
                        <%
                        } else if (status_book == 8) {
                        %>
                        <button class="btn btn-primary submit-btn" style="background-color: blue"  onclick="Medical_done('<%=ID[j]%>')"><%= ID[j]%></button>
                        <%
                                    }
                                }
                            }
                        %>

                    </td>
                    <td id="Tue-slot1"> <%
                        if (app[2][i + 1] == null) {

                        } else {
                            String[] ID = app[2][i + 1].split(" ");
                            for (int j = 0; j < ID.length; j++) {
                                int status_book = dao.CheckBooking(ID[j]);
                                if (status_book == 2) {
                        %>
                        <button style="background-color: #9f9f9f"  class="btn btn-primary submit-btn" onclick="Medical('<%=ID[j]%>')"><%= ID[j]%></button>
                        <%
                        } else if (status_book == 4 || status_book == 5) {
                        %>
                        <button class="btn btn-primary submit-btn" onclick="Medical_done('<%=ID[j]%>')"><%= ID[j]%></button>
                        <%
                        } else if (status_book == 3) {
                        %>
                        <button style="background-color: blue"  class="btn btn-primary submit-btn" onclick="Medical('<%=ID[j]%>')"><%= ID[j]%></button>
                        <%
                        } else if (status_book == 7) {
                        %>
                        <button class="btn btn-primary submit-btn" style="background-color: blue"  onclick="Medical_done('<%=ID[j]%>')"><%= ID[j]%></button>
                        <%
                        } else if (status_book == 8) {
                        %>
                        <button class="btn btn-primary submit-btn" style="background-color: blue"  onclick="Medical_done('<%=ID[j]%>')"><%= ID[j]%></button>
                        <%
                                    }
                                }
                            }
                        %>
                    </td>
                    <td id="Wed-slot1"> <%
                        if (app[3][i + 1] == null) {

                        } else {
                            String[] ID = app[3][i + 1].split(" ");
                            for (int j = 0; j < ID.length; j++) {
                                int status_book = dao.CheckBooking(ID[j]);
                                if (status_book == 2) {
                       %>
                        <button style="background-color: #9f9f9f"  class="btn btn-primary submit-btn" onclick="Medical('<%=ID[j]%>')"><%= ID[j]%></button>
                        <%
                        } else if (status_book == 4 || status_book == 5) {
                        %>
                        <button class="btn btn-primary submit-btn" onclick="Medical_done('<%=ID[j]%>')"><%= ID[j]%></button>
                        <%
                        } else if (status_book == 3) {
                        %>
                        <button style="background-color: blue"  class="btn btn-primary submit-btn" onclick="Medical('<%=ID[j]%>')"><%= ID[j]%></button>
                        <%
                        } else if (status_book == 7) {
                        %>
                        <button class="btn btn-primary submit-btn" style="background-color: blue"  onclick="Medical_done('<%=ID[j]%>')"><%= ID[j]%></button>
                        <%
                        } else if (status_book == 8) {
                        %>
                        <button class="btn btn-primary submit-btn" style="background-color: blue"  onclick="Medical_done('<%=ID[j]%>')"><%= ID[j]%></button>
                        <%
                                    }
                                }
                            }
                        %></td>
                    <td id="Thu-slot1"> <%
                        if (app[4][i + 1] == null) {

                        } else {
                            String[] ID = app[4][i + 1].split(" ");
                            for (int j = 0; j < ID.length; j++) {
                                int status_book = dao.CheckBooking(ID[j]);
                                if (status_book == 2) {
                      %>
                        <button style="background-color: #9f9f9f"  class="btn btn-primary submit-btn" onclick="Medical('<%=ID[j]%>')"><%= ID[j]%></button>
                        <%
                        } else if (status_book == 4 || status_book == 5) {
                        %>
                        <button class="btn btn-primary submit-btn" onclick="Medical_done('<%=ID[j]%>')"><%= ID[j]%></button>
                        <%
                        } else if (status_book == 3) {
                        %>
                        <button style="background-color: blue"  class="btn btn-primary submit-btn" onclick="Medical('<%=ID[j]%>')"><%= ID[j]%></button>
                        <%
                        } else if (status_book == 7) {
                        %>
                        <button class="btn btn-primary submit-btn" style="background-color: blue"  onclick="Medical_done('<%=ID[j]%>')"><%= ID[j]%></button>
                        <%
                        } else if (status_book == 8) {
                        %>
                        <button class="btn btn-primary submit-btn" style="background-color: blue"  onclick="Medical_done('<%=ID[j]%>')"><%= ID[j]%></button>
                        <%
                                    }
                                }
                            }
                        %></td>
                    <td id="Fri-slot1"> <%
                        if (app[5][i + 1] == null) {

                        } else {
                            String[] ID = app[5][i + 1].split(" ");
                            for (int j = 0; j < ID.length; j++) {
                                int status_book = dao.CheckBooking(ID[j]);
                                if (status_book == 2) {
                       %>
                        <button style="background-color: #9f9f9f"  class="btn btn-primary submit-btn" onclick="Medical('<%=ID[j]%>')"><%= ID[j]%></button>
                        <%
                        } else if (status_book == 4 || status_book == 5) {
                        %>
                        <button class="btn btn-primary submit-btn" onclick="Medical_done('<%=ID[j]%>')"><%= ID[j]%></button>
                        <%
                        } else if (status_book == 3) {
                        %>
                        <button style="background-color: blue"  class="btn btn-primary submit-btn" onclick="Medical('<%=ID[j]%>')"><%= ID[j]%></button>
                        <%
                        } else if (status_book == 7) {
                        %>
                        <button class="btn btn-primary submit-btn" style="background-color: blue"  onclick="Medical_done('<%=ID[j]%>')"><%= ID[j]%></button>
                        <%
                        } else if (status_book == 8) {
                        %>
                        <button class="btn btn-primary submit-btn" style="background-color: blue" onclick="Medical_done('<%=ID[j]%>')"><%= ID[j]%></button>
                        <%
                                    }
                                }
                            }
                        %></td>
                    <td id="Sat-slot1"> <%
                        if (app[6][i + 1] == null) {

                        } else {
                            String[] ID = app[6][i + 1].split(" ");
                            for (int j = 0; j < ID.length; j++) {
                                int status_book = dao.CheckBooking(ID[j]);
                                if (status_book == 2) {
                       %>
                        <button style="background-color: #9f9f9f"  class="btn btn-primary submit-btn" onclick="Medical('<%=ID[j]%>')"><%= ID[j]%></button>
                        <%
                        } else if (status_book == 4 || status_book == 5) {
                        %>
                        <button class="btn btn-primary submit-btn" onclick="Medical_done('<%=ID[j]%>')"><%= ID[j]%></button>
                        <%
                        } else if (status_book == 3) {
                        %>
                        <button style="background-color: blue"  class="btn btn-primary submit-btn" onclick="Medical('<%=ID[j]%>')"><%= ID[j]%></button>
                        <%
                        } else if (status_book == 7) {
                        %>
                        <button class="btn btn-primary submit-btn" style="background-color: blue" onclick="Medical_done('<%=ID[j]%>')"><%= ID[j]%></button>
                        <%
                        } else if (status_book == 8) {
                        %>
                        <button class="btn btn-primary submit-btn" style="background-color: blue" onclick="Medical_done('<%=ID[j]%>')"><%= ID[j]%></button>
                        <%
                                    }
                                }
                            }
                        %></td>
                    <td id="Sun-slot1"> <%
                        if (app[7][i + 1] == null) {

                        } else {
                            String[] ID = app[7][i + 1].split(" ");
                            for (int j = 0; j < ID.length; j++) {
                                int status_book = dao.CheckBooking(ID[j]);
                                if (status_book == 2) {
                       %>
                        <button style="background-color: #9f9f9f"  class="btn btn-primary submit-btn" onclick="Medical('<%=ID[j]%>')"><%= ID[j]%></button>
                        <%
                        } else if (status_book == 4 || status_book == 5) {
                        %>
                        <button class="btn btn-primary submit-btn" onclick="Medical_done('<%=ID[j]%>')"><%= ID[j]%></button>
                        <%
                        } else if (status_book == 3) {
                        %>
                        <button style="background-color: blue"  class="btn btn-primary submit-btn" onclick="Medical('<%=ID[j]%>')"><%= ID[j]%></button>
                        <%
                        } else if (status_book == 7) {
                        %>
                        <button class="btn btn-primary submit-btn" style="background-color: blue" onclick="Medical_done('<%=ID[j]%>')"><%= ID[j]%></button>
                        <%
                        } else if (status_book == 8) {
                        %>
                        <button class="btn btn-primary submit-btn" style="background-color: blue" onclick="Medical_done('<%=ID[j]%>')"><%= ID[j]%></button>
                        <%
                                    }
                                }
                            }
                        %></td>

                </tr>
                <%
                    }
                %>
                <tr></tr>
            </tbody>
        </table>

        <%
            }
        %>
    </body>


</html>
