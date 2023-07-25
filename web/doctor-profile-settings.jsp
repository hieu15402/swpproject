<%-- 
    Document   : doctor-profile-settings
    Created on : May 29, 2023, 4:20:52 PM
    Author     : MSI AD
--%>

<%@page import="sample.dto.UserDTO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html> 
<html lang="en">

    <!-- doccure/doctor-profile-settings.jsp  30 Nov 2019 04:12:14 GMT -->
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

        <!-- Select2 CSS -->
        <link rel="stylesheet" href="assets/plugins/select2/css/select2.min.css">

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="assets/plugins/bootstrap-tagsinput/css/bootstrap-tagsinput.css">

        <link rel="stylesheet" href="assets/plugins/dropzone/dropzone.min.css">

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
            HttpSession session1 = request.getSession();
            UserDTO user = (UserDTO) session1.getAttribute("account");
            if (user == null) {
                response.sendRedirect("index-2.jsp");
            } else {
                String role = user.getRole().trim();
                if (!role.equalsIgnoreCase("3")) {
                    response.sendRedirect("index-2.jsp");
                }
            }
        %>
        <jsp:useBean id="UserDAO" scope="request" class="sample.dao.UserDAO" />
        <c:set var="username" value="${sessionScope.account.username}" />
        <c:set var="doctor" value="${UserDAO.getDoctorByID(username)}" />
        <form method="POST" action="MainController" enctype="multipart/form-data" >
            <input type="hidden" name="username" value="${sessionScope.account.username}" />
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title">Basic Information</h4>
                    <div class="row form-row">
                        <div class="col-md-12">
                            <div class="form-group">
                                <div class="change-avatar">
                                    <div class="profile-img">
                                        <img src="${doctor.image}" alt="User Image">
                                    </div>
                                    <div class="upload-img">
                                        <div class="change-photo-btn">
                                            <span><i class="fa fa-upload"></i> Upload Photo</span>
                                            <input type="file" name="file" class="upload">
                                        </div>
                                        <small class="form-text text-muted"> Allowed JPG, GIF or PNG. Max size of 2MB</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Username <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" value="${doctor.username}" readonly>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Email <span class="text-danger">*</span></label>
                                <input type="email" class="form-control" value="${doctor.email}" readonly>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Full name <span class="text-danger">*</span></label>
                                <input type="text" name="fullname" class="form-control" value="${doctor.fullname}" >
                            </div>
                        </div>
                        <!--										<div class="col-md-6">
                                                                                                                <div class="form-group">
                                                                                                                        <label>Last Name <span class="text-danger">*</span></label>
                                                                                                                        <input type="text" class="form-control">
                                                                                                                </div>
                                                                                                        </div>-->
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Phone Number</label>
                                <input id="myphone_" type="text" name="phone" class="form-control" value="${doctor.phone}">
                                <span id="result_2" class="status_2" style="margin-left: 10px;" ></span>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Gender</label>
                                <select class="form-control select" name="gender">
                                    <c:set var="trimmedGender" value="${doctor.gender.trim()}" />
                                    <c:choose>
                                        <c:when test="${trimmedGender eq 'Male'}">
                                            <option value="Male" selected>Male</option>
                                            <option value="Female">Female</option>
                                        </c:when>
                                        <c:when test="${trimmedGender eq 'Female'}">
                                            <option value="Male">Male</option>
                                            <option value="Female" selected>Female</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="Male">Male</option>
                                            <option value="Female">Female</option>
                                        </c:otherwise>
                                    </c:choose>
                                </select>

                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group mb-0">
                                <label>Date of Birth</label>
                                <input type="date" class="form-control" name="date_of_birth" value="${doctor.date_of_birth}">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- /Basic Information -->

            <!-- About Me -->
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title">About Me</h4>
                    <div class="form-group mb-0">
                        <label>Biography</label>
                        <textarea class="form-control" name="bio" rows="5">${doctor.bio}</textarea>
                    </div>
                </div>
            </div>

            <!-- /About Me -->


            <!-- Registrations -->
            <div class="submit-section submit-btn-bottom">
                <button id="submit" type="submit" name="action" value="update-doctor-profile-setting" class="btn btn-primary submit-btn">Save Changes</button>
            </div>
        </form>
        <style>
            .available {
                color: #006400;
                background: #E5FFE5;
                padding-left: 3px;
                padding-right: 3px;
                border-radius: 3px;
            }

            .already-exists, .not-enough-length {
                padding-left: 3px;
                padding-right: 3px;
                border-radius: 3px;
                background: #F8ECEC;
                color: #be4b49;
            }

        </style>
        <!-- jQuery -->
        <script src="assets/js/jquery.min.js"></script>

        <!-- Bootstrap Core JS -->
        <script src="assets/js/popper.min.js"></script>
        <script src="assets/js/bootstrap.min.js"></script>

        <!-- Sticky Sidebar JS -->
        <script src="assets/plugins/theia-sticky-sidebar/ResizeSensor.js"></script>
        <script src="assets/plugins/theia-sticky-sidebar/theia-sticky-sidebar.js"></script>

        <!-- Select2 JS -->
        <script src="assets/plugins/select2/js/select2.min.js"></script>

        <!-- Dropzone JS -->
        <script src="assets/plugins/dropzone/dropzone.min.js"></script>

        <!-- Bootstrap Tagsinput JS -->
        <script src="assets/plugins/bootstrap-tagsinput/js/bootstrap-tagsinput.js"></script>

        <!-- Profile Settings JS -->
        <script src="assets/js/profile-settings.js"></script>

        <!-- Custom JS -->
        <script src="assets/js/script.js"></script>
        <script src="assets/js/checkValidate.js"></script>
    </body>

    <!-- doccure/doctor-profile-settings.jsp  30 Nov 2019 04:12:15 GMT -->
</html>