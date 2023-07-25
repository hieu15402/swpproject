<%-- 
    Document   : doctor_dashboard
    Created on : Jun 18, 2023, 7:04:23 PM
    Author     : MSI AD
--%>

<%@page import="java.time.LocalDate"%>
<%@page import="java.sql.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="sample.dto.BookingDTO"%>
<%@page import="sample.dao.BookingDAO"%>
<%@page import="sample.dto.UserDTO"%>
<%@page import="sample.dto.AppointmentDTO"%>
<%@page import="java.util.List"%>
<%@page import="sample.dao.UserDAO"%>
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
            BookingDAO dao = new BookingDAO();
            List<BookingDTO> list = dao.getAllBooking();
            String[] date = dao.getTodayString();
            double count = dao.countPatient(user.getUsername());
        %>
        <div class="row">
            <div class="col-md-12">
                <div class="card dash-card">
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-12 col-lg-4">
                                <div class="dash-widget dct-border-rht">
                                    <div class="circle-bar circle-bar1">
                                        <div class="progress-bar">
                                            <div class="progress" style="width: 75%;"></div>

                                        </div>

                                        <style>
                                            .progress-bar {
                                                width: 200px;
                                                height: 20px;
                                                background-color: #f2f2f2;
                                                border-radius: 5px;
                                                overflow: hidden;
                                            }

                                            .progress {
                                                height: 100%;
                                                background-color: #4CAF50;
                                            }

                                        </style>
                                    </div>
                                    <%
                                        double count_today = 0;
                                        double count_up = 0;
                                        for (BookingDTO x : list) {
                                            String doc = x.getUsername_doctor();
                                            if (x.getBooking_status() >= 2 && user.getUsername().equals(doc) && x.getBooking_status() <= 3) {
                                                Date dateBook = x.getDate();
                                                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd");
                                                String formattedDate = dateFormat.format(dateBook);
                                                String[] date2 = formattedDate.split("/");
                                                String statusDay = dao.compareDateDoctor(date, date2);
                                                if (statusDay == "Today") {
                                                    count_today++;
                                                } else {
                                                    count_up++;
                                                }
                                            }
                                        }
                                        double total_today = (count_today / count) * 100;
                                    %>

                                    <div class="dash-widget-info">
                                        <h6>Total Patient</h6>
                                        <p><%=(int) count%> Patients</p>                                      
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-12 col-lg-4">
                                <div class="dash-widget dct-border-rht">
                                    <div class="circle-bar circle-bar2">
                                        <div class="progress-bar">
                                            <div class="progress" style="width:<%=total_today%>%;"></div>

                                        </div>
                                    </div>
                                    <div class="dash-widget-info">
                                        <h6>Today Patient</h6>
                                        <p><%=(int) count_today%> Patients</p>  

                                        </p>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-12 col-lg-4">
                                <div class="dash-widget">
                                    <div class="circle-bar circle-bar3">
                                        <div class="progress-bar">
                                            <div class="progress" style="width: 75%;"></div>

                                        </div>
                                    </div>
                                    <div class="dash-widget-info">
                                        <h6>Appointment</h6>
                                        <p><%=(int) count%> Appointment</p>  
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-md-12">
                <h4 class="mb-4">Appoinment</h4>
                <div class="appointment-tab">

                    <!-- Appointment Tab -->
                    <ul class="nav nav-tabs nav-tabs-solid nav-tabs-rounded">
                        <li class="nav-item">
                            <a class="nav-link active" href="#today-appointments"
                               data-toggle="tab">Today</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#upcoming-appointments" data-toggle="tab">Upcoming</a>
                        </li>
                    </ul>
                    <!-- /Appointment Tab -->

                    <div class="tab-content">

                        <!-- Upcoming Appointment Tab -->                                            
                        <%                            if (list == null) {
                        %>
                        Don't have appointment today
                        <%
                        } else {

                        %>

                        <div class="tab-pane show active" id="upcoming-appointments">
                            <div class="card card-table mb-0">
                                <div class="card-body">
                                    <div class="table-responsive">
                                        <table class="table table-hover table-center mb-0">
                                            <thead>
                                                <tr>
                                                    <th>User Name</th>
                                                    <th>Bird Name</th>
                                                    <th>Time Slot</th>
                                                    <th style="width: 250px">Service</th>
                                                    <th>Status</th>
                                                </tr>
                                            </thead>

                                            <tbody> 
                                                <%                                                    for (BookingDTO x : list) {
                                                        String doc = x.getUsername_doctor();
                                                        if (x.getBooking_status() >= 2 && user.getUsername().equals(doc) && x.getBooking_status() <= 3) {
                                                            Date dateBook = x.getDate();
                                                            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd");
                                                            String formattedDate = dateFormat.format(dateBook);
                                                            String[] date2 = formattedDate.split("/");
                                                            String statusDay = dao.compareDateDoctor(date, date2);
                                                            if (statusDay == "Upcoming") {
                                                %>

                                                <tr>
                                                    <td>
                                                        <%=dao.customerName(x.getUsername_customer())%>
                                                    </td>

                                                    <td><%= dao.getBirdname(x.getPatient_id())%> </td>
                                                    <td> <%=x.getDate()%><br> <%= dao.getSlotTime(x.getBooking_id())%></td>
                                                    <td style="width: 250px"><%= dao.getServicename(x.getBooking_id())%></td>

                                                    <td> <%=dao.getBookingStatus(x.getBooking_id())%></td>
                                                </tr>     
                                                <%
                                                            }
                                                        }
                                                    }
                                                %>
                                            </tbody>

                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <%    }
                        %>
                        <!-- /Upcoming Appointment Tab -->

                        <!-- Today Appointment Tab -->    

                        <div class="tab-pane" id="today-appointments">
                            <div class="card card-table mb-0">
                                <div class="card-body">
                                    <div class="table-responsive">
                                        <table class="table table-hover table-center mb-0">
                                            <thead>
                                                <tr>
                                                    <th>User Name</th>
                                                    <th>Bird Name</th>
                                                    <th>Time Slot</th>
                                                    <th style="width: 250px">Service</th>
                                                    <th>Status</th>
                                                </tr>
                                            </thead>

                                            <tbody> 
                                                <%
                                                    for (BookingDTO x : list) {
                                                        String doc = x.getUsername_doctor();
                                                        if (x.getBooking_status() >= 2 && user.getUsername().equals(doc) && x.getBooking_status() <= 3) {
                                                            Date dateBook = x.getDate();
                                                            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd");
                                                            String formattedDate = dateFormat.format(dateBook);
                                                            String[] date2 = formattedDate.split("/");
                                                            String statusDay = dao.compareDateDoctor(date, date2);
                                                            if (statusDay == "Today") {
                                                %>

                                                <tr>
                                                    <td>
                                                        <%=dao.customerName(x.getUsername_customer())%>
                                                    </td>

                                                    <td><%= dao.getBirdname(x.getPatient_id())%> </td>
                                                    <td> <%=x.getDate()%><br> <%= dao.getSlotTime(x.getBooking_id())%></td>
                                                    <td style="width: 250px"><%= dao.getServicename(x.getBooking_id())%></td>

                                                    <td> <%=dao.getBookingStatus(x.getBooking_id())%></td>
                                                </tr>     
                                                <%
                                                            }
                                                        }
                                                    }
                                                %>
                                            </tbody>

                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- /Today Appointment Tab -->

                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
