<%-- 
    Document   : bird-profile
    Created on : Jun 8, 2023, 12:24:27 AM
    Author     : MSI AD
--%>

<%@page import="sample.dto.UserDTO"%>
<%@page import="java.util.List"%>
<%@page import="sample.dto.PatientDTO"%>
<%@page import="sample.dao.PatientDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    </head>
    <body>
        <%
            HttpSession s = request.getSession();
            UserDTO user = (UserDTO) s.getAttribute("account");
            PatientDAO dao = new PatientDAO();
            int count = 0;
            List<PatientDTO> listBird = dao.getBird(user.getUsername());
        %>

        <select id="select" onchange="sendOption()">
            <%
                for (PatientDTO x : listBird) {
            %>
            <option value="<%= x.getName()%>"> <%= x.getName()%></option>    
            <%
                }
            %>
        </select>

        <div  class="card">

            <div id="demo" class="card-body">
                <!-- Profile Settings Form -->
                <form name="formUpdate" action="MainController" method="post" enctype="multipart/form-data">
                    <div class="submit-section">
                        <a  href="#Add_Specialities_details" data-toggle="modal"
                            class="btn btn-primary submit-btn">Add</a>
                        <!-- /Profile Settings Form -->
                    </div>
                    <br>
                    <div class="row form-row">
                        <%
                            for (PatientDTO x : listBird) {
                                count++;
                                String species = dao.getSpecies(x.getSpecies_id());
                        %>
                        <div class="col-12 col-md-12">
                            <div class="form-group">
                                <div class="change-avatar">
                                    <div class="profile-img">
                                        <img  src="<%= x.getImage()%>" alt="Patient Image">
                                    </div>
                                    <div class="upload-img">
                                        <div class="change-photo-btn">
                                            <span><i class="fa fa-upload"></i> Upload Photo</span>
                                            <input onchange="checkImage()" id="bird_image_dash" name="image_bird" type="file" class="upload">
                                        </div>
                                        <small class="form-text text-muted">Allowed JPG, PNG. Max size of 2MB</small>
                                    </div>

                                </div>
                            </div>
                            <span id="result_3" style="margin-left: 10px;color: red"></span>
                        </div>
                        <input type="hidden" name="patient_id" value="<%= x.getPatient_id()%>">
                        <input type="hidden" name="species_id" value="<%= x.getSpecies_id()%>" readonly="">
                        <input type="hidden" id="username" name="user_name" value="<%= user.getUsername()%>">
                        <div class="col-12 col-md-6">
                            <div class="form-group">
                                <label>Name</label>
                                <input onchange="checkUsername()" id="birdname_dash" name="birdname" type="text" class="form-control" value="<%= x.getName()%>" required="">
                                <span id="result_4" style="margin-left: 10px;color: red"></span>
                            </div>
                        </div>
                        <div class="col-12 col-md-6">
                            <div class="form-group">
                                <label>Species</label>
                                <input name="species" type="text" class="form-control" value="<%= dao.getSpecies(x.getSpecies_id())%>" readonly="">
                            </div>
                        </div>
                        <div class="col-12 col-md-6">
                            <div class="form-group">
                                <label>Age</label>
                                <div>
                                    <input onchange="Age()" name="age" type="number" class="form-control datetimepicker" value="<%= x.getAge()%>">
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-md-6">
                            <div class="form-group">
                                <label>Gender</label>
                                <input onchange="Gender()" name="gender" type="text" class="form-control datetimepicker" value="<%= x.getGender()%>">
                            </div>
                        </div>

                        <div class="submit-section">
                            <button disabled="true"  id="update" name="action" value="Update" type="submit" class="btn btn-primary submit-btn">Update</button>
                            <button name="action" value="Delete" type="submit" class="btn btn-primary submit-btn">Delete</button>
                        </div>

                        <%
                                if (count == 1) {
                                    break;
                                }
                            }
                        %>

                    </div>
                </form>
            </div>
        </div>
        <script src="assets/js/jquery.min.js"></script>
        <script src="assets/js/checkUpdateValidate.js"></script>

        <!-- Bootstrap Core JS -->
        <script src="assets/js/popper.min.js"></script>
        <script src="assets/js/bootstrap.min.js"></script>

        <!-- Sticky Sidebar JS -->
        <script src="assets/plugins/theia-sticky-sidebar/ResizeSensor.js"></script>
        <script src="assets/plugins/theia-sticky-sidebar/theia-sticky-sidebar.js"></script>

        <!-- Custom JS -->
        <script src="assets/js/script.js"></script>
    </body>
</html>
