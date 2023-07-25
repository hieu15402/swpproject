<%-- 
    Document   : my-patients
    Created on : May 29, 2023, 5:11:47 PM
    Author     : MSI AD
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html> 
<html lang="en">

    <!-- doccure/my-patients.jsp  30 Nov 2019 04:12:09 GMT -->
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
        <jsp:useBean id="PatientDAO" scope="request" class="sample.dao.PatientDAO"/>
        <jsp:useBean id="UserDAO" scope="request" class="sample.dao.UserDAO"/>

        <div class="row row-grid">
            <c:forEach items="${PatientDAO.viewPatientListByDoctorID(sessionScope.account.username)}" var="i">
                <div class="col-md-6 col-lg-4 col-xl-3">
                    <div class="card widget-profile pat-widget-profile">
                        <div class="card-body">
                            <div class="pro-widget-content">
                                <div class="profile-info-widget">
                                    <a href="patient-profile.jsp" class="booking-doc-img">
                                        <img src="${i.image}" alt="User Image">
                                    </a>
                                    <div class="profile-det-info">
                                        <h3><a href="patient-profile.jsp">${i.name}</a></h3>

                                        <div class="patient-details">
                                            <h5><b>Patient ID :</b> ${i.patient_id}</h5>
                                            <!--<h5 class="mb-0"><i class="fas fa-map-marker-alt"></i> Alabama, USA</h5>-->
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="patient-info">
                                <ul>
                                    <li>Owner <span>${UserDAO.viewCustomerByPatientID(i.patient_id).fullname}</span></li>
                                    <li>Gender <span>${UserDAO.viewCustomerByPatientID(i.patient_id).gender}</span></li>
                                    <li>Phone <span>${UserDAO.viewCustomerByPatientID(i.patient_id).phone}</span></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>

            <%--	<div class="col-md-6 col-lg-4 col-xl-3">
                            <div class="card widget-profile pat-widget-profile">
                                    <div class="card-body">
                                            <div class="pro-widget-content">
                                                    <div class="profile-info-widget">
                                                            <a href="patient-profile.jsp" class="booking-doc-img">
                                                                    <img src="assets/img/patients/patient1.jpg" alt="User Image">
                                                            </a>
                                                            <div class="profile-det-info">
                                                                    <h3><a href="patient-profile.jsp">Charlene Reed</a></h3>
                                                                    
                                                                    <div class="patient-details">
                                                                            <h5><b>Patient ID :</b> P0001</h5>
                                                                            <h5 class="mb-0"><i class="fas fa-map-marker-alt"></i> North Carolina, USA</h5>
                                                                    </div>
                                                            </div>
                                                    </div>
                                            </div>
                                            <div class="patient-info">
                                                    <ul>
                                                            <li>Phone <span>+1 828 632 9170</span></li>
                                                            <li>Age <span>29 Years, Female</span></li>
                                                            <li>Blood Group <span>O+</span></li>
                                                    </ul>
                                            </div>
                                    </div>
                            </div>
                    </div>
                    
                    <div class="col-md-6 col-lg-4 col-xl-3">
                            <div class="card widget-profile pat-widget-profile">
                                    <div class="card-body">
                                            <div class="pro-widget-content">
                                                    <div class="profile-info-widget">
                                                            <a href="#" class="booking-doc-img">
                                                                    <img src="assets/img/patients/patient2.jpg" alt="User Image">
                                                            </a>
                                                            <div class="profile-det-info">
                                                                    <h3>Travis Trimble </h3>
                                                                    <div class="patient-details">
                                                                            <h5><b>Patient ID :</b> PT0002</h5>
                                                                            <h5 class="mb-0"><i class="fas fa-map-marker-alt"></i> Maine, USA</h5>
                                                                    </div>
                                                            </div>
                                                    </div>
                                            </div>
                                            <div class="patient-info">
                                                    <ul>
                                                            <li>Phone <span>+1 207 729 9974</span></li>
                                                            <li>Age <span>23 Years, Male</span></li>
                                                            <li>Blood Group <span>B+</span></li>
                                                    </ul>
                                            </div>
                                    </div>
                            </div>
                    </div>
                    
                    <div class="col-md-6 col-lg-4 col-xl-3">
                            <div class="card widget-profile pat-widget-profile">
                                    <div class="card-body">
                                            <div class="pro-widget-content">
                                                    <div class="profile-info-widget">
                                                            <a href="#" class="booking-doc-img">
                                                                    <img src="assets/img/patients/patient3.jpg" alt="User Image">
                                                            </a>
                                                            <div class="profile-det-info">
                                                                    <h3>Carl Kelly</h3>
                                                                    <div class="patient-details">
                                                                            <h5><b>Patient ID :</b> PT0003</h5>
                                                                            <h5 class="mb-0"><i class="fas fa-map-marker-alt"></i> Indiana, USA</h5>
                                                                    </div>
                                                            </div>
                                                    </div>
                                            </div>
                                            <div class="patient-info">
                                                    <ul>
                                                            <li>Phone <span>+1 260 724 7769</span></li>
                                                            <li>Age <span>32 Years, Male</span></li>
                                                            <li>Blood Group <span>A+</span></li>
                                                    </ul>
                                            </div>
                                    </div>
                            </div>
                    </div>
                    
                    <div class="col-md-6 col-lg-4 col-xl-3">
                            <div class="card widget-profile pat-widget-profile">
                                    <div class="card-body">
                                            <div class="pro-widget-content">
                                                    <div class="profile-info-widget">
                                                            <a href="#" class="booking-doc-img">
                                                                    <img src="assets/img/patients/patient4.jpg" alt="User Image">
                                                            </a>
                                                            <div class="profile-det-info">
                                                                    <h3>Michelle Fairfax</h3>
                                                                    <div class="patient-details">
                                                                            <h5><b>Patient ID :</b> PT0004</h5>
                                                                            <h5 class="mb-0"><i class="fas fa-map-marker-alt"></i> Indiana, USA</h5>
                                                                    </div>
                                                            </div>
                                                    </div>
                                            </div>
                                            <div class="patient-info">
                                                    <ul>
                                                            <li>Phone <span>+1 504 368 6874</span></li>
                                                            <li>Age <span>25 Years, Female</span></li>
                                                            <li>Blood Group <span>B+</span></li>
                                                    </ul>
                                            </div>
                                    </div>
                            </div>
                    </div>
                    
                    <div class="col-md-6 col-lg-4 col-xl-3">
                            <div class="card widget-profile pat-widget-profile">
                                    <div class="card-body">
                                            <div class="pro-widget-content">
                                                    <div class="profile-info-widget">
                                                            <a href="#" class="booking-doc-img">
                                                                    <img src="assets/img/patients/patient5.jpg" alt="User Image">
                                                            </a>
                                                            <div class="profile-det-info">
                                                                    <h3>Gina Moore</h3>
                                                                    <div class="patient-details">
                                                                            <h5><b>Patient ID :</b> PT0005</h5>
                                                                            <h5 class="mb-0"><i class="fas fa-map-marker-alt"></i> Florida, USA</h5>
                                                                    </div>
                                                            </div>
                                                    </div>
                                            </div>
                                            <div class="patient-info">
                                                    <ul>
                                                            <li>Phone <span>+1 954 820 7887</span></li>
                                                            <li>Age <span>25 Years, Female</span></li>
                                                            <li>Blood Group <span>AB-</span></li>
                                                    </ul>
                                            </div>
                                    </div>
                            </div>
                    </div>
                    
                    <div class="col-md-6 col-lg-4 col-xl-3">
                            <div class="card widget-profile pat-widget-profile">
                                    <div class="card-body">
                                            <div class="pro-widget-content">
                                                    <div class="profile-info-widget">
                                                            <a href="#" class="booking-doc-img">
                                                                    <img src="assets/img/patients/patient6.jpg" alt="User Image">
                                                            </a>
                                                            <div class="profile-det-info">
                                                                    <h3>Elsie Gilley</h3>
                                                                    <div class="patient-details">
                                                                            <h5><b>Patient ID :</b> PT0006</h5>
                                                                            <h5 class="mb-0"><i class="fas fa-map-marker-alt"></i> Kentucky, USA</h5>
                                                                    </div>
                                                            </div>
                                                    </div>
                                            </div>
                                            <div class="patient-info">
                                                    <ul>
                                                            <li>Phone <span>+1 315 384 4562</span></li>
                                                            <li>Age <span>14 Years, Female</span></li>
                                                            <li>Blood Group <span>O-</span></li>
                                                    </ul>
                                            </div>
                                    </div>
                            </div>
                    </div>
                    
                    <div class="col-md-6 col-lg-4 col-xl-3">
                            <div class="card widget-profile pat-widget-profile">
                                    <div class="card-body">
                                            <div class="pro-widget-content">
                                                    <div class="profile-info-widget">
                                                            <a href="#" class="booking-doc-img">
                                                                    <img src="assets/img/patients/patient7.jpg" alt="User Image">
                                                            </a>
                                                            <div class="profile-det-info">
                                                                    <h3>Joan Gardner</h3>
                                                                    <div class="patient-details">
                                                                            <h5><b>Patient ID :</b> PT0007</h5>
                                                                            <h5 class="mb-0"><i class="fas fa-map-marker-alt"></i> California, USA</h5>
                                                                    </div>
                                                            </div>
                                                    </div>
                                            </div>
                                            <div class="patient-info">
                                                    <ul>
                                                            <li>Phone <span>+1 707 2202 603</span></li>
                                                            <li>Age <span>25 Years, Female</span></li>
                                                            <li>Blood Group <span>A-</span></li>
                                                    </ul>
                                            </div>
                                    </div>
                            </div>
                    </div>
                    
                    <div class="col-md-6 col-lg-4 col-xl-3">
                            <div class="card widget-profile pat-widget-profile">
                                    <div class="card-body">
                                            <div class="pro-widget-content">
                                                    <div class="profile-info-widget">
                                                            <a href="#" class="booking-doc-img">
                                                                    <img src="assets/img/patients/patient8.jpg" alt="User Image">
                                                            </a>
                                                            <div class="profile-det-info">
                                                                    <h3>Daniel Griffing</h3>
                                                                    <div class="patient-details">
                                                                            <h5><b>Patient ID :</b> PT0007</h5>
                                                                            <h5 class="mb-0"><i class="fas fa-map-marker-alt"></i> New Jersey, USA</h5>
                                                                    </div>
                                                            </div>
                                                    </div>
                                            </div>
                                            <div class="patient-info">
                                                    <ul>
                                                            <li>Phone <span>+1 973 773 9497</span></li>
                                                            <li>Age <span>28 Years, Male</span></li>
                                                            <li>Blood Group <span>O+</span></li>
                                                    </ul>
                                            </div>
                                    </div>
                            </div>
                    </div>
                    
                    <div class="col-md-6 col-lg-4 col-xl-3">
                            <div class="card widget-profile pat-widget-profile">
                                    <div class="card-body">
                                            <div class="pro-widget-content">
                                                    <div class="profile-info-widget">
                                                            <a href="#" class="booking-doc-img">
                                                                    <img src="assets/img/patients/patient9.jpg" alt="User Image">
                                                            </a>
                                                            <div class="profile-det-info">
                                                                    <h3>Walter Roberson</h3>
                                                                    <div class="patient-details">
                                                                            <h5><b>Patient ID :</b> PT0009</h5>
                                                                            <h5 class="mb-0"><i class="fas fa-map-marker-alt"></i> Florida, USA</h5>
                                                                    </div>
                                                            </div>
                                                    </div>
                                            </div>
                                            <div class="patient-info">
                                                    <ul>
                                                            <li>Phone <span>+1 850 358 4445</span></li>
                                                            <li>Age <span>28 Years, Male</span></li>
                                                            <li>Blood Group <span>A+</span></li>
                                                    </ul>
                                            </div>
                                    </div>
                            </div>
                    </div>
                    
                    <div class="col-md-6 col-lg-4 col-xl-3">
                            <div class="card widget-profile pat-widget-profile">
                                    <div class="card-body">
                                            <div class="pro-widget-content">
                                                    <div class="profile-info-widget">
                                                            <a href="#" class="booking-doc-img">
                                                                    <img src="assets/img/patients/patient10.jpg" alt="User Image">
                                                            </a>
                                                            <div class="profile-det-info">
                                                                    <h3>Robert Rhodes</h3>
                                                                    <div class="patient-details">
                                                                            <h5><b>Patient ID :</b> PT0010</h5>
                                                                            <h5 class="mb-0"><i class="fas fa-map-marker-alt"></i> California, USA</h5>
                                                                    </div>
                                                            </div>
                                                    </div>
                                            </div>
                                            <div class="patient-info">
                                                    <ul>
                                                            <li>Phone <span>+1 858 259 5285</span></li>
                                                            <li>Age <span>19 Years, Male</span></li>
                                                            <li>Blood Group <span>B+</span></li>
                                                    </ul>
                                            </div>
                                    </div>
                            </div>
                    </div>
                    
                    <div class="col-md-6 col-lg-4 col-xl-3">
                            <div class="card widget-profile pat-widget-profile">
                                    <div class="card-body">
                                            <div class="pro-widget-content">
                                                    <div class="profile-info-widget">
                                                            <a href="#" class="booking-doc-img">
                                                                    <img src="assets/img/patients/patient11.jpg" alt="User Image">
                                                            </a>
                                                            <div class="profile-det-info">
                                                                    <h3>Harry Williams</h3>
                                                                    <div class="patient-details">
                                                                            <h5><b>Patient ID :</b> PT0011</h5>
                                                                            <h5 class="mb-0"><i class="fas fa-map-marker-alt"></i> Colorado, USA</h5>
                                                                    </div>
                                                            </div>
                                                    </div>
                                            </div>
                                            <div class="patient-info">
                                                    <ul>
                                                            <li>Phone <span>+1 303 607 7075</span></li>
                                                            <li>Age <span>9 Years, Male</span></li>
                                                            <li>Blood Group <span>A-</span></li>
                                                    </ul>
                                            </div>
                                    </div>
                            </div>
                    </div> --%>

        </div>
    </body>

    <!-- doccure/my-patients.jsp  30 Nov 2019 04:12:09 GMT -->
</html>
