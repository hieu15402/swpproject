<%-- 
    Document   : medical_doctor
    Created on : Jun 28, 2023, 11:11:48 AM
    Author     : MSI AD
--%>

<%@page import="sample.dto.PatientDTO"%>
<%@page import="sample.dao.PatientDAO"%>
<%@page import="sample.dto.UserDTO"%>
<%@page import="sample.dto.MedicalRecordDTO"%>
<%@page import="java.util.List"%>
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
            MedicalRecordDAO daoMR = new MedicalRecordDAO();
            List<MedicalRecordDTO> MR = daoMR.getMRDoctor(user.getUsername());

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
                                <th>ID</th>
                                <th>Date Again </th>
                                <th>Service</th>
                                <th>Note</th>
                                <th>User</th>
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
                                <td><%=mrr.getBooking_id() %></td>
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
                                        <a class="avatar avatar-sm mr-2">
                                            <img class="avatar-img rounded-circle" src="<%= daoMR.get_image_doctor(mrr.getDoctorName())%>" >
                                        </a>
                                        <a ><%= daoMR.getDocName(mrr.getDoctorName())%></a>
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
                            </tr>
                            <% }%>
                        </tbody>  	
                    </table>
                </div>
            </div>
        </div>
        <%
            }
        %>
    </body>
</html>
