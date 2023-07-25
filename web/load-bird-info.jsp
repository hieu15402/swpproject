<%-- 
    Document   : load-bird-info
    Created on : Jun 8, 2023, 12:12:35 PM
    Author     : MSI AD
--%>

<%@page import="sample.dto.PatientDTO"%>
<%@page import="java.util.List"%>
<%@page import="sample.dao.PatientDAO"%>
<%@page import="sample.dto.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">

        <!-- Favicons -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    </head>
    <body>

        <form action="MainController" method="post" enctype="multipart/form-data">
             <div class="submit-section">
                            <a  href="#Add_Specialities_details" data-toggle="modal"
                                class="btn btn-primary submit-btn">Add</a>
                            <!-- /Profile Settings Form -->
                        </div>
            <br>
            <div class="row form-row">



                <%
                    HttpSession s = request.getSession();
                    UserDTO user = (UserDTO) s.getAttribute("account");
                    PatientDAO dao = new PatientDAO();
                    String selectedOption = request.getParameter("selectedOption");
                    List<PatientDTO> listBird = dao.getBird(user.getUsername());
                    for (PatientDTO list : listBird) {
                        if (list.getName().equalsIgnoreCase(selectedOption)) {
                %>

                <div class="col-12 col-md-12">
                    <div class="form-group">
                        <div class="change-avatar">
                            <div class="profile-img">
                                <img  src="<%= list.getImage()%>" alt="Patient Image">
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
                <input type="hidden" name="patient_id" value="<%= list.getPatient_id()%>">
                <input type="hidden" name="species_id" value="<%= list.getSpecies_id()%>" required="">
                <div class="col-12 col-md-6">
                    <div class="form-group">
                        <label>Name</label>
                        <input onchange="checkUsername()" id="birdname_dash" name="birdname" type="text" class="form-control" value="<%= list.getName()%>" required="">
                        <span id="result_4" style="margin-left: 10px;color: red"></span>
                    </div>
                </div>
                <div class="col-12 col-md-6">
                    <div class="form-group">
                        <label>Species</label>
                        <input name="species" type="text" class="form-control" value="<%= dao.getSpecies(list.getSpecies_id())%>" readonly="">
                    </div>
                </div>
                <div class="col-12 col-md-6">
                    <div class="form-group">
                        <label>Age</label>
                        <div>
                            <input onchange="Age()" name="age" type="number" class="form-control datetimepicker" value="<%= list.getAge()%>">
                        </div>
                    </div>
                </div>
                <div class="col-12 col-md-6">
                    <div class="form-group">
                        <label>Gender</label>
                        <input onchange="Gender()" name="gender" type="text" class="form-control datetimepicker" value="<%= list.getGender()%>">
                    </div>
                </div>

                <div class="submit-section">
                    <button disabled="true" id="update" name="action" value="Update" type="submit" class="btn btn-primary submit-btn">Update</button>
                    <button name="action" value="Delete" type="submit" class="btn btn-primary submit-btn">Delete</button>

                </div>


                <%
                        }
                    }
                %>
                
                <!-- /Profile Settings Form -->
            </div>
        </form>
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
