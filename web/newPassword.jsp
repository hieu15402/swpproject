<%-- 
    Document   : register
    Created on : May 29, 2023, 5:08:35 PM
    Author     : MSI AD
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html> 
<html lang="vn">
    <!-- doccure/register.jsp  30 Nov 2019 04:12:20 GMT -->
    <head>
        <meta http–equiv="Content-Type" content="text/html; charset=UTF-8">
              <title>thedearbird | Register</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">

        <!-- Favicons -->
        <link rel="shortcut icon" type="image/x-icon" href="admin/assets/img/logo-icon.png">

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="assets/css/bootstrap.min.css">

        <!-- Fontawesome CSS -->
        <link rel="stylesheet" href="assets/plugins/fontawesome/css/fontawesome.min.css">
        <link rel="stylesheet" href="assets/plugins/fontawesome/css/all.min.css">

        <!-- Main CSS -->
        <link rel="stylesheet" href="assets/css/style.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!--[if lt IE 9]>
                <script src="assets/js/html5shiv.min.js"></script>
                <script src="assets/js/respond.min.js"></script>
        <![endif]-->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    </head>
    <body class="account-page">

        <%
            HttpSession sess = request.getSession();
            String status = (String) sess.getAttribute("status");
            if (status != "success") {
                response.sendRedirect("forgot-password.jsp");
            }
        %>
        <!-- Main Wrapper -->
        <div class="main-wrapper">

            <!-- Header -->
            <header class="header">
                <nav class="navbar navbar-expand-lg header-nav">
                    <div class="navbar-header">
                        <a id="mobile_btn" href="javascript:void(0);">
                            <span class="bar-icon">
                                <span></span>
                                <span></span>
                                <span></span>
                            </span>
                        </a>
                        <a href="index-2.jsp" class="navbar-brand logo">
                            <img src="assets/img/final_logo.png" class="img-fluid" alt="Logo">
                        </a>
                    </div>
                    <div class="main-menu-wrapper">
                        <div class="menu-header">
                            <a href="index-2.jsp" class="menu-logo">
                                <img src="assets/img/final_logo.png" class="img-fluid" alt="Logo">
                            </a>
                            <a id="menu_close" class="menu-close" href="javascript:void(0);">
                                <i class="fas fa-times"></i>
                            </a>
                        </div>
                        <ul class="main-nav">
                            <li>
                                <a href="index-2.jsp">Home</a>
                            </li>
                            <!--							<li class="has-submenu">
                                                                                            <a href="#">Doctors <i class="fas fa-chevron-down"></i></a>
                                                                                            <ul class="submenu">
                                                                                                    <li><a href="doctor-dashboard.jsp">Doctor Dashboard</a></li>
                                                                                                    <li><a href="appointments.jsp">Appointments</a></li>
                                                                                                    <li><a href="schedule-timings.jsp">Schedule Timing</a></li>
                                                                                                    <li><a href="my-patients.jsp">Patients List</a></li>
                                                                                                    <li><a href="patient-profile.jsp">Patients Profile</a></li>
                                                                                                    <li><a href="chat-doctor.jsp">Chat</a></li>
                                                                                                    <li><a href="invoices.jsp">Invoices</a></li>
                                                                                                    <li><a href="doctor-profile-settings.jsp">Profile Settings</a></li>
                                                                                                    <li><a href="reviews.jsp">Reviews</a></li>
                                                                                                    <li><a href="doctor-register.jsp">Doctor Register</a></li>
                                                                                            </ul>
                                                                                    </li>	
                                                                                    <li class="has-submenu">
                                                                                            <a href="#">Patients <i class="fas fa-chevron-down"></i></a>
                                                                                            <ul class="submenu">
                                                                                                    <li><a href="search.jsp">Search Doctor</a></li>
                                                                                                    <li><a href="doctor-profile.jsp">Doctor Profile</a></li>
                                                                                                    <li><a href="booking.jsp">Booking</a></li>
                                                                                                    <li><a href="checkout.jsp">Checkout</a></li>
                                                                                                    <li><a href="booking-success.jsp">Booking Success</a></li>
                                                                                                    <li><a href="patient-dashboard.jsp">Patient Dashboard</a></li>
                                                                                                    <li><a href="favourites.jsp">Favourites</a></li>
                                                                                                    <li><a href="chat.jsp">Chat</a></li>
                                                                                                    <li><a href="profile-settings.jsp">Profile Settings</a></li>
                                                                                                    <li><a href="change-password.jsp">Change Password</a></li>
                                                                                            </ul>
                                                                                    </li>	
                                                                                    <li class="has-submenu active">
                                                                                            <a href="#">Pages <i class="fas fa-chevron-down"></i></a>
                                                                                            <ul class="submenu">
                                                                                                    <li><a href="voice-call.jsp">Voice Call</a></li>
                                                                                                    <li><a href="video-call.jsp">Video Call</a></li>
                                                                                                    <li><a href="search.jsp">Search Doctors</a></li>
                                                                                                    <li><a href="calendar.jsp">Calendar</a></li>
                                                                                                    <li><a href="components.jsp">Components</a></li>
                                                                                                    <li class="has-submenu">
                                                                                                            <a href="invoices.jsp">Invoices</a>
                                                                                                            <ul class="submenu">
                                                                                                                    <li><a href="invoices.jsp">Invoices</a></li>
                                                                                                                    <li><a href="invoice-view.jsp">Invoice View</a></li>
                                                                                                            </ul>
                                                                                                    </li>
                                                                                                    <li><a href="blank-page.jsp">Starter Page</a></li>
                                                                                                    <li><a href="login.jsp">Login</a></li>
                                                                                                    <li class="active"><a href="register.jsp">Register</a></li>
                                                                                                    <li><a href="forgot-password.jsp">Forgot Password</a></li>
                                                                                            </ul>
                                                                                    </li>-->
                            <li>
                                <a href="blank-page.jsp" >Blog</a>
                            </li>
                            <li class="login-link">
                                <a href="login.jsp">Login / Signup</a>
                            </li>
                        </ul>
                    </div>		 
                    <ul class="nav header-navbar-rht">
                        <li class="nav-item contact-item">
                            <div class="header-contact-img">
                                <i class="far fa-hospital"></i>							
                            </div>
                            <div class="header-contact-detail">
                                <p class="contact-header">Contact</p>
                                <p class="contact-info-header"> +1 315 369 5943</p>
                            </div>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link header-login" href="login.jsp">login / Signup </a>
                        </li>
                    </ul>
                </nav>
            </header>
            <!-- /Header -->

            <!-- Page Content -->
            <div class="content">
                <div class="container-fluid">

                    <div class="row">
                        <div class="col-md-8 offset-md-2">

                            <!-- Register Content -->
                            <div class="account-content">
                                <div class="row align-items-center justify-content-center">
                                    <div class="col-md-7 col-lg-6 login-left">
                                        <img src="assets/img/register.jpg" class="img-fluid" alt="Doccure Register">	
                                    </div>
                                    <div class="col-md-12 col-lg-6 login-right">
                                        <div class="login-header">
                                            <h3>Reset Password</h3>
                                        </div>

                                        <!-- Register Form -->
                                        <form id="myform" action="ResetPasswordController" method="POST" accept-charset="UTF-8">
                                            <div class="box">
                                                <div class="form-group form-focus inputBox">
                                                    <input name="emailUser" value="${email}" type="hidden">
                                                    <input name="password" type="password" class="form-control floating" 
                                                           id="pass_1" onkeyup="validatePassword(this.value); checkPassword(this.value)" 
                                                           required="">
                                                    <span id="toggleBtn"></span>
                                                    <script>
                                                        toggleBtn.onclick = function () {
                                                            if (pass_1.type === 'password') {
                                                                pass_1.setAttribute('type', 'text');
                                                                toggleBtn.classList.add('hide');
                                                            } else {
                                                                pass_1.setAttribute('type', 'password');
                                                                toggleBtn.classList.remove('hide');

                                                            }
                                                        }
                                                    </script>
                                                    <label class="focus-label">New Password</label>   
                                                </div>
                                                <div class="validation" id="validation">
                                                    <ul>
                                                        <li id="lower">At least one lowercase character</li>
                                                        <li id="upper">At least one upper character</li>
                                                        <li id="number">At least one number</li>
                                                        <li id="special">At least one special character</li>
                                                        <li id="length">At least 8 character</li>
                                                    </ul>
                                                </div>
                                            </div>

                                            <style>
                                                .box {
                                                    position: relative;
                                                }
                                                .box .inputBox input{
                                                    position: relative;
                                                    outline: none;
                                                }
                                                .box .inputBox #toggleBtn{
                                                    position: absolute;
                                                    width: 35px;
                                                    height: 35px;
                                                    background: rgba(0,0,0,0.09);
                                                    top: 7px;
                                                    right: 10px;
                                                    border-radius: 50%;
                                                    cursor: pointer;
                                                    display: flex;
                                                    justify-content: center;
                                                    align-items: center;
                                                }
                                                .box .inputBox #toggleBtn::before {
                                                    content: '\f06e';
                                                    font-family: fontAwesome;
                                                }

                                                .box .inputBox #toggleBtn.hide::before  {
                                                    content: '\f070';
                                                }

                                                .error {
                                                    background: #f5f6f7;
                                                    padding-top: 15px;
                                                    border-radius: 7px;
                                                    padding-bottom: 3px;
                                                    margin-bottom: 20px;
                                                    width: 70%;
                                                }
                                                .validation {
                                                    display: none;
                                                    background: #f5f6f7;
                                                    padding-top: 15px;
                                                    border-radius: 7px;
                                                    padding-bottom: 3px;
                                                    margin-bottom: 20px;
                                                    width: 70%;
                                                }

                                                .validation ul {
                                                    position: relative;
                                                    display: flex;
                                                    flex-direction: column;
                                                    gap: 8px;
                                                    padding-inline-start: 10px;                                           
                                                }

                                                .validation ul li {
                                                    position: relative;
                                                    list-style: none;
                                                    color: #be4b49;
                                                    font-size: 0.9375rem;
                                                    transition: 0.5s;
                                                }
                                                .validation ul li.valid{

                                                    color: rgba(19,87,54,0.18);
                                                }
                                                .validation ul li::before {
                                                    content: '\f00d';
                                                    width: 20px;
                                                    height: 10px;
                                                    font-family: fontAwesome;
                                                    display: inline-flex;
                                                }
                                                .validation ul li.valid::before{
                                                    content:'\f00c';
                                                    color: rgba(19,87,54,0.18);
                                                }
                                            </style>



                                            <div style="margin-bottom: 40px;" class="form-group form-focus">
                                                <input id="myconpass_1" name="confirm_password" type="password" class="form-control floating" onchange="checkPassConfirm()">
                                                <label class="focus-label">Confirm New Password</label>
                                                <p id="resultss" class="available" style="margin-left: 10px;">${correctPass}</p>
                                                <p id="resultsss" class="already-exists" style="margin-left: 10px;">${incorrectPass}</p>
                                                <p id="resultsss" class="already-exists" style="margin-left: 10px;">${dupPass}</p>

                                                <style>
                                                    #resultsss {
                                                        margin-top: 5px;
                                                        margin-bottom: 10px;
                                                        width: 60%;
                                                    }

                                                    #resultss {
                                                        margin-top: 5px;
                                                        margin-bottom: 10px;
                                                        width: 55%;
                                                    }
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
                                            </div>
                                            <script>

                                            </script>
                                            <button class="btn btn-primary btn-block btn-lg login-btn" type="submit" 
                                                    id="submit">Save</button>
                                        </form>
                                        <!-- /Register Form -->

                                    </div>
                                </div>
                            </div>
                            <!-- /Register Content -->

                        </div>
                    </div>

                </div>

            </div>		
            <!-- /Page Content -->

            <!-- Footer -->
            <footer class="footer">

                <!-- Footer Top -->
                <div class="footer-top">
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-lg-3 col-md-6">

                                <!-- Footer Widget -->
                                <div class="footer-widget footer-about">
                                    <div class="footer-logo">
                                        <img src="assets/img/footer_logo.png" alt="logo">
                                    </div>

                                    <div class="footer-about-content">
                                        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor
                                            incididunt ut labore et dolore magna aliqua. </p>
                                        <div class="social-icon">
                                            <ul>
                                                <li>
                                                    <a href="#" target="_blank"><i class="fab fa-facebook-f"></i> </a>
                                                </li>
                                                <li>
                                                    <a href="#" target="_blank"><i class="fab fa-twitter"></i> </a>
                                                </li>
                                                <li>
                                                    <a href="#" target="_blank"><i class="fab fa-linkedin-in"></i></a>
                                                </li>
                                                <li>
                                                    <a href="#" target="_blank"><i class="fab fa-instagram"></i></a>
                                                </li>
                                                <li>
                                                    <a href="#" target="_blank"><i class="fab fa-dribbble"></i> </a>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                                <!-- /Footer Widget -->

                            </div>

                            <div class="col-lg-3 col-md-6">

                                <!-- Footer Widget -->
                                <div class="footer-widget footer-menu">
                                    <h2 class="footer-title">For Patients</h2>
                                    <ul>
                                        <li><a href="search.jsp"><i class="fas fa-angle-double-right"></i> Search for
                                                Doctors</a></li>
                                        <li><a href="login.jsp"><i class="fas fa-angle-double-right"></i> Login</a></li>
                                        <li><a href="register.jsp"><i class="fas fa-angle-double-right"></i> Register</a>
                                        </li>
                                        <li><a href="booking.jsp"><i class="fas fa-angle-double-right"></i> Booking</a>
                                        </li>
                                        <li><a href="patient-dashboard.jsp"><i class="fas fa-angle-double-right"></i>
                                                Patient Dashboard</a></li>
                                    </ul>
                                </div>
                                <!-- /Footer Widget -->

                            </div>

                            <div class="col-lg-3 col-md-6">

                                <!-- Footer Widget -->
                                <div class="footer-widget footer-menu">
                                    <h2 class="footer-title">For Doctors</h2>
                                    <ul>
                                        <li><a href="appointments.jsp"><i class="fas fa-angle-double-right"></i>
                                                Appointments</a></li>
                                        <li><a href="chat.jsp"><i class="fas fa-angle-double-right"></i> Chat</a></li>
                                        <li><a href="login.jsp"><i class="fas fa-angle-double-right"></i> Login</a></li>
                                        <li><a href="doctor-register.jsp"><i class="fas fa-angle-double-right"></i>
                                                Register</a></li>
                                        <li><a href="doctor-dashboard.jsp"><i class="fas fa-angle-double-right"></i> Doctor
                                                Dashboard</a></li>
                                    </ul>
                                </div>
                                <!-- /Footer Widget -->

                            </div>

                            <div class="col-lg-3 col-md-6">

                                <!-- Footer Widget -->
                                <div class="footer-widget footer-contact">
                                    <h2 class="footer-title">Contact Us</h2>
                                    <div class="footer-contact-info">
                                        <div class="footer-address">
                                            <span><i class="fas fa-map-marker-alt"></i></span>
                                            <p> 3556 Beech Street, San Francisco,<br> California, CA 94108 </p>
                                        </div>
                                        <p>
                                            <i class="fas fa-phone-alt"></i>
                                            +1 315 369 5943
                                        </p>
                                        <p class="mb-0">
                                            <i class="fas fa-envelope"></i>
                                            doccure@example.com
                                        </p>
                                    </div>
                                </div>
                                <!-- /Footer Widget -->

                            </div>

                        </div>
                    </div>
                </div>
                <!-- /Footer Top -->
            </footer>
            <!-- /Footer -->

        </div>
        <!-- /Main Wrapper -->

        <!-- jQuery -->
        <script src="assets/js/checkValidate.js"></script>
        <script src="assets/js/jquery.min.js"></script>

        <!-- Bootstrap Core JS -->
        <script src="assets/js/popper.min.js"></script>
        <script src="assets/js/bootstrap.min.js"></script>

        <!-- Custom JS -->
        <script src="assets/js/script.js"></script>

    </body>

    <!-- doccure/register.jsp  30 Nov 2019 04:12:20 GMT -->
</html>
