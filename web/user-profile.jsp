<%-- 
    Document   : user-profile
    Created on : Jun 8, 2023, 12:18:08 AM
    Author     : MSI AD
--%>

<%@page import="sample.dao.UserDAO"%>
<%@page import="sample.dto.UserDTO"%>
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
            UserDAO daoUs = new UserDAO();
            UserDTO userNew = daoUs.getUser(user.getUsername());
        %>

        <div class="card">
            <div class="card-body">

                <!-- Profile Settings Form -->
                <form action="MainController" method="post" enctype= multipart/form-data>
                    <div class="row form-row">
                        <div class="col-12 col-md-12">
                            <div class="form-group">
                                <div class="change-avatar">
                                    <div class="form-group">
                                        <label> CHANGE AVATAR </label>
                                        <input type="file" class="form-control" name="avatar" accept="image/jpeg, image/png, image/jpg" onchange="checkImage()" id="bird_image_dash" >
                                        <input type="text" value=" <%= userNew.getUsername()%>" hidden="" name="username">
                                        <input type="text" value="<%= userNew.getImage()%>" hidden="" name="avatarnone">
                                     <span id="result_3" style="margin-left: 10px;color: red"></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-md-12">
                            <div class="form-group">
                                <label>Full Name</label>
                                <input type="text" class="form-control" value="<%= userNew.getFullname()%>" name="fullname">
                            </div>
                        </div>
                        <div class="col-12 col-md-6">
                            <div class="form-group">
                                <label>Date of Birth</label>
                                <div>
                                    <input type="date" class="form-control" value="<%= userNew.getDate_of_birth()%>" name="dateofbirth">
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-md-6">
                            <div class="form-group">
                                <label>Gender</label>
                                <select class="form-control select" name="gender">
                                    <option  <% if (userNew.getGender().trim().equalsIgnoreCase("male")) { %> selected <% } %>>Male</option>
                                    <option  <% if (userNew.getGender().trim().equalsIgnoreCase("female")) { %> selected <% }%>>Female</option>
                                </select>

                            </div>
                        </div>
                        <div class="col-12 col-md-6">
                            <div class="form-group">
                                <label>Email ID</label>
                                <input id="emailAddress" type="email" required class="form-control" value="<%= userNew.getEmail()%>" name="email" readonly="">
                            </div>
                        </div>
                        <div class="col-12 col-md-6">
                            <div class="form-group">
                                <label>Mobile</label>
                                <input type="text" value="<%= userNew.getPhone()%>" class="form-control" name="phone" pattern="0\d{9}" title="Vui lòng nhập số điện thoại hợp lệ (bắt đầu bằng số 0 và có 10 chữ số)">
                            </div>
                        </div>
                    </div>
                    <div class="submit-section">
                        <button id="update" type="submit" class="btn btn-primary submit-btn" name="action" value="updateProfileUser">Save Changes</button>
                    </div>
                </form>
                <!-- /Profile Settings Form -->

            </div>
        </div>
    </body>
    <script src="assets/js/checkUpdateValidate.js"></script>
    
    
</html>
