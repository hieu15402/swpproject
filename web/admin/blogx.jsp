<%-- 
    Document   : doctors
    Created on : Jun 6, 2023, 5:43:09 PM
    Author     : MSI AD
--%>
<%@page import="org.jsoup.Jsoup"%>
<%@page import="org.jsoup.nodes.Document"%>
<%@page import="sample.dto.BlogDTO"%>
<%@page import="sample.dao.BlogDAO"%>
<%@page import="sample.dao.UserDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.sun.javafx.scene.control.skin.VirtualFlow.ArrayLinkedList"%>
<%@page import="java.util.List"%>
<%@page import="sample.dto.UserDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
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
        <script src="assets/ckeditor/ckeditor.js"></script>

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
                        <div class="col-sm-7 col-auto">
                            <h3 class="page-title">List of Blogs</h3>
                            <ul class="breadcrumb">
                                <!--                                <li class="breadcrumb-item"><a href="index.jsp">Dashboard</a></li>-->
                                <li class="breadcrumb-item"><a href="javascript:(0);">Admin</a></li>
                                <li class="breadcrumb-item active">Blog</li>
                            </ul>
                        </div>
                        <!--                            PHẦN ADD THÊM BÁC SĨ-->
                        <!--                        <div class="col-sm-5 col">
                                                    <a href="#Add_Specialities_details" data-toggle="modal"
                                                       class="btn btn-primary float-right mt-2">Add Blog</a>
                                                </div>-->
                    </div>

                </div>
                <!-- /Page Header -->

                <div class="row">
                    <div class="col-sm-12">
                        <div class="card">
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="datatable table table-hover table-center mb-0">
                                        <thead>
                                            <tr>
                                                <th>ID</th>
                                                <th>Title</th>
                                                <th>Content</th>
                                                <th>Category</th>
                                                <th>Author</th>
                                                <th>Blog Status</th>

                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                int rowCounter = 1;
                                                List<BlogDTO> ls = new ArrayList<BlogDTO>();
                                                BlogDAO dao = new BlogDAO();
                                                ls = dao.getListBlog();
                                                for (BlogDTO b : ls) {

                                            %>

                                            <tr style="height: 100px !important;">
                                                <td><%=b.getBlog_id()%></td>
                                                <td>
                                                    <h2 class="table-avatar">
                                                        <a href="#view_specialities_details" data-toggle="modal"><%=b.getTitle()%></a>
                                                    </h2>
                                                </td>
                                                <%
                                                    String htmlContent = b.getDetails();
                                                    Document doc = Jsoup.parse(htmlContent);
                                                    String plainText = doc.text();
                                                %>
                                                <td><%=plainText.substring(0, 50) + "..."%></td>
                                                <td><%=b.getCategories_blog_name()%></td>

                                                <td><%=b.getAuthor()%></td>

                                                <td>

                                                    <%
                                                        boolean isStatus = b.isStatus();
                                                    %>
                                                    <form id="statusForm<%= rowCounter%>" action="../SetStatusBlogController" method="POST">
                                                        <label class="switch">
                                                            <input name="blogID" value="<%=b.getBlog_id()%>" type="hidden">
                                                            <input name="statusName" value="<%= isStatus%>" type="hidden">
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

                <div class="page-header">
                    <div class="row">
                        <div class="col-sm-7 col-auto">
                            <h3 class="page-title">Add new Blogs</h3>
                        </div>
                    </div>
                </div>


                <div class="row" style="border: 1px solid #f0f0f0; background: #fff; border-radius: 3px;">
                    <form style="width: 100%; margin-bottom: 20px;" action="../MainController" method="post">
                        <div class="col-auto" style="margin-bottom: 15px; margin-top: 10px;">
                            <label style="display: block; margin-bottom: 5px; " for="inputTitle">Title *</label>
                            <input id="inputTitle" name="title" placeholder="this content will be displayed in the TITLE of blog *">
                            <style>
                                input {
                                    background-color: #fff;
                                    padding: 10px;
                                    border: 1px solid #ccc;
                                    font-size: 15px;
                                    color: #333;
                                    width: 100%;
                                }
                                #inputTitle::placeholder {
                                    color: #b2b2b2; /* Màu chữ nhạt hơn */
                                }
                            </style>
                        </div>

                        <div class="col-auto" style="width: 100%;height: 100px; margin-bottom: 10px; display: flex;">
                            <div class="upload-img" style="width: 30%;">
                                <div class="change-photo-btn" style="width: 100%;">
                                    <span style="display: block;"><i class="fa fa-upload"></i> Upload Photo</span>
                                    <input id="bird_image_dash" name="image_bird" type="file" class="upload" style="width: 70%;">
                                    <small class="form-text text-muted">Allowed JPG, PNG. Max size of 2MB</small>
                                </div>
                            </div>
                            <div style="width: 70%; height: 100%;">
                                <div class="change-photo-btn" style="width: 100%;">
                                    <span style="display: block;">Select Category</span>

                                    <select name="category_id">
                                        <%
                                            List lists = dao.getList();
                                            for (Object elem : lists) {
                                        %>
                                        <option value="<%=elem%>"><%=elem%></option>
                                        <% }%>
                                    </select>

                                </div>
                            </div>
                        </div>
                        <div class="col-auto" style="margin-bottom: 10px;">
                            <label style="display: block; margin-bottom: 5px;" for="inputDescription">Content of Blog *</label>
                            <textarea id="inputDescription" name="content" cols="30" rows="10" style="width: 100%;" placeholder=""></textarea>
                        </div>
                        <div class="col-auto" style="margin-bottom: 10px;">
                            <label style="display: block; margin-bottom: 5px;" for="authorname">Author name of Blog *</label>
                            <input style="width: 50%;" id="authorname" type="text" name="authors">
                        </div>

                        <div class="col-auto">
                            <button type="submit" name="action" value="addblog">Add new</button>
                        </div>
                    </form>
                </div>

            </div>			
        </div>
        <!-- /Page Wrapper -->




        <!-- Add Modal -->

        <script>
            CKEDITOR.replace('content');
        </script>



        <!-- /ADD Modal -->


        <!-- /ADD Modal -->
    </div>

    <!-- View Details Modal -->
    <div class="modal fade" id="view_specialities_details" aria-hidden="true" role="dialog">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">View Specialities</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="row form-row">
                        <div class="col-12 col-sm-6">
                            <div class="form-group">

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="assets/js/jquery-3.2.1.min.js"></script>
    <script src="assets/ckeditor/ckeditor.js"></script>

    <!-- Bootstrap Core JS -->
    <script src="assets/js/popper.min.js"></script>
    <script src="assets/js/bootstrap.min.js"></script>

    <!-- Slimscroll JS -->
    <script src="assets/plugins/slimscroll/jquery.slimscroll.min.js"></script>

    <!-- Datatables JS -->
    <script src="assets/plugins/datatables/jquery.dataTables.min.js"></script>
    <script src="assets/plugins/datatables/datatables.min.js"></script>

    <!-- Custom JS -->
    <script  src="assets/js/script.js"></script>
</body>
</html>
