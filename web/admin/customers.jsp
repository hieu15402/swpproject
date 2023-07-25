<%-- 
    Document   : customers
    Created on : Jun 6, 2023, 5:45:42 PM
    Author     : MSI AD
--%>

<%@page import="sample.dto.PatientDTO"%>
<%@page import="sample.dao.PatientDAO"%>
<%@page import="sample.dto.UserDTO"%>
<%@page import="java.util.List"%>
<%@page import="sample.dao.UserDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<!DOCTYPE html>

<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">
        <title>thedearbird - Doctors | Manager</title>


        <!-- Favicon -->
        <link rel="shortcut icon" type="image/x-icon" href="assets/img/logo-icon.png">


        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="assets/css/bootstrap.min.css">

        <!-- Fontawesome CSS -->
        <link rel="stylesheet" href="assets/css/font-awesome.min.css">

        <!-- Feathericon CSS -->
        <link rel="stylesheet" href="assets/css/feathericon.min.css">

        <!-- Datatables CSS -->
        <link rel="stylesheet" href="assets/plugins/datatables/datatables.min.css">

        <!-- Main CSS -->
        <link rel="stylesheet" href="assets/css/style.css">

        <!--[if lt IE 9]>
                <script src="assets/js/html5shiv.min.js"></script>
                <script src="assets/js/respond.min.js"></script>
        <![endif]-->
    </head>
    <body>

        <div class="page-wrapper">
            <div class="content container-fluid">

                <!-- Page Header -->
                <div class="page-header">
                    <div class="row">
                        <div class="col-sm-7">
                            <h3 class="page-title">List of Customer</h3>
                            <ul class="breadcrumb">
                                <li class="breadcrumb-item"><a href="javascript:(0);">Admin</a></li>
                                <li class="breadcrumb-item active">Customer</li>
                            </ul>
                        </div>
<!--                        <div class="col-sm-5 col">
                            <a href="#Add_Specialities_details" data-toggle="modal"
                               class="btn btn-primary float-right mt-2">Add</a>
                        </div>-->

                    </div>



                </div>
                <!-- /Page Header -->

                <div class="row">
                    <div class="col-sm-12">
                        <div class="card">
                            <div class="card-body">
                                <div class="table-responsive">
                                    <div class="table-responsive">
                                        <table class="datatable table table-hover table-center mb-0">
                                            <thead>
                                                <tr>
                                                    <th>Username</th>
                                                    <th>Customer Name</th>
                                                    <th>Gender</th>
                                                    <th>Email</th>
                                                    <th>Phone</th>
                                                    <th>Date Of Birth</th>
                                                    <th class="text-right">Account Status</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <%
                                                    int rowCounter = 1;
                                                    UserDAO dao = new UserDAO();
                                                    List<UserDTO> list = dao.getListCustomer();

                                                    for (UserDTO user : list) {
                                                        int index = list.indexOf(user);

                                                %>
                                                <tr>                                                    
                                                    <td><%=user.getUsername()%></td>
                                                    <td>
                                                        <h2 class="table-avatar">
                                                            <a  class="avatar avatar-sm mr-2"><img class="avatar-img rounded-circle" src="../<%=user.getImage()%>" alt="User Image"></a>
                                                            <a href="#view_specialities_details_<%=index%>" data-toggle="modal"><%=user.getFullname()%></a>
                                                        </h2>
                                                    </td>
                                                    <td><%=user.getGender()%></td>
                                                    <td><%=user.getEmail()%></td>
                                                    <td><%=user.getPhone()%></td>
                                                    <td><%=user.getDate_of_birth()%></td>

                                                    <td class="text-right">
                                                        <%
                                                            boolean isStatus = user.isStatus();
                                                        %>
                                                        <form id="statusForm<%=rowCounter%>" action="../SetStatusController" method="POST">
                                                            <label class="switch">
                                                                <input name="username" value="<%=user.getUsername()%>" type="hidden">                                                       
                                                                <input name="statusName" value="<%=isStatus%>" type="hidden">
                                                                <input type="checkbox" onchange="document.getElementById('statusForm<%= rowCounter%>').submit()" <%= isStatus ? "checked" : "unchecked"%>>
                                                                <span class="slider round"></span>
                                                            </label>
                                                        </form>
                                                        <style>
                                                            .switch {
                                                                margin-left: 10px;
                                                                position: relative;
                                                                display: inline-block;
                                                                width: 60px;
                                                                height: 34px;
                                                            }

                                                            /* Hide default HTML checkbox */
                                                            .switch input {
                                                                opacity: 0;
                                                                width: 0;
                                                                height: 0;
                                                            }

                                                            /* The slider */
                                                            .slider {
                                                                position: absolute;
                                                                cursor: pointer;
                                                                top: 0;
                                                                left: 0;
                                                                right: 0;
                                                                bottom: 0;
                                                                background-color: #ccc;
                                                                -webkit-transition: .4s;
                                                                transition: .4s;
                                                            }

                                                            .slider:before {
                                                                position: absolute;
                                                                content: "";
                                                                height: 26px;
                                                                width: 26px;
                                                                left: 4px;
                                                                bottom: 4px;
                                                                background-color: white;
                                                                -webkit-transition: .4s;
                                                                transition: .4s;
                                                            }

                                                            input:checked + .slider {
                                                                background-color: #6EC531;
                                                            }

                                                            input:focus + .slider {
                                                                box-shadow: 0 0 1px #6EC531;
                                                            }

                                                            input:checked + .slider:before {
                                                                -webkit-transform: translateX(26px);
                                                                -ms-transform: translateX(26px);
                                                                transform: translateX(26px);
                                                            }

                                                            /* Rounded sliders */
                                                            .slider.round {
                                                                border-radius: 34px;
                                                            }

                                                            .slider.round:before {
                                                                border-radius: 50%;
                                                            }

                                                        </style>
                                                    </td>                                                    
                                                </tr>
                                                <%
                                                        rowCounter++;
                                                    }
                                                %>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>			
                </div>

            </div>			
        </div>
        <!-- /Page Wrapper -->

    </div>
    <!-- /Main Wrapper -->
    <!-- View Details Modal -->
    <%
        for (UserDTO doc : list) {
            int index = list.indexOf(doc);
    %>
    <div class="modal fade" id="view_specialities_details_<%=index%>" aria-hidden="true" role="dialog">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">View Customer Information</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="row form-row">
                        <div class="col-12 col-sm-6" 
                             style="
                             border: 1px solid #c2c3c4;
                             border-radius: 5px;
                             padding: 5px;
                             height: 300px;">
                            <div class="form-group">
                                <img style="width: 100%;" src="../<%=doc.getImage()%>">
                                <label style="display: flex; justify-content: center; align-items: center; margin-top: 10px;"><i>Customer's image</i></label>
                            </div>
                        </div>
                        <div class="col-12 col-sm-6" 
                             style="
                             border-width: 1px;
                             border-color: #c2c3c4;
                             border-radius: 2px;
                             padding: 5px;">
                            <div class="form-group">
                                <label style="display: flex; justify-content: center; align-items: center; border-bottom: 1px solid #c2c3c4; font-size: 20px;"><b><i>Customer's information</i></b></label>
                            </div>
                            <div class="form-group">
                                <p><b><i>Fullname</i></b> : <%=doc.getFullname()%></p> 
                                <p><b><i>Gender</i></b> : <%=doc.getGender()%></p> 

                                <p><b><i>Phone</i></b> : <%=doc.getPhone()%></p>
                                <p style="word-wrap: break-word;"><b><i>Email</i></b> : <%=doc.getEmail()%></p>
                                <p><b><i>Date of bird</i></b> : <%=doc.getDate_of_birth()%></p>                           
                            </div>
                        </div>
                    </div>

                    <div class="row form-row" style="margin-top: 5px;">
                        <%
                            String genderName = "";
                            if (doc.getGender().trim().equalsIgnoreCase("Female")) {
                                genderName = "Her";
                            } else {
                                genderName = "His";
                            }
                        %>
                        <label style="display: flex; justify-content: center; align-items: center; border-bottom: 1px solid #c2c3c4; font-size: 20px;"><b><i><%=genderName%> list birds</i></b></label>
                        <div class="col-12">
                            <div class="form-group">
                                <div class="table-responsive" >

                                    <table class="datatable table table-hover table-center mb-0" style="width: 100%;">
                                        <thead>
                                        <th>Name</th>
                                        <th>Species</th>
                                        <th>Age</th>
                                        </thead>
                                        <%                                        PatientDAO dao_p = new PatientDAO();
                                            List<PatientDTO> p = dao_p.getPatientBird(doc.getUsername());
                                            for (PatientDTO patient : p) {
                                        %>
                                        <tbody>
                                        <td  data-toggle="modal"><%=patient.getName().trim()%></td>
                                        <td><%=dao_p.getSpecies(patient.getSpecies_id())%></td>
                                        <td><%=patient.getAge()%></td>
                                        </tbody>
                                        <% }%>
                                    </table>

                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
    <%}%>
</body>
</html>
