<%-- 
    Document   : login
    Created on : May 29, 2023, 5:06:25 PM
    Author     : MSI AD
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!DOCTYPE html>
<html lang="en">

    <!-- doccure/login.jsp  30 Nov 2019 04:12:20 GMT -->

    <head>
        <meta charset="utf-8">
        <title>thedearbird | Login</title>

        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">

        <!-- Favicons -->
        <link rel="shortcut icon" type="image/x-icon" href="admin/assets/img/logo-icon.png">

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="assets/css/bootstrap.min.css">

        <!-- Fontawesome CSS -->
        <link rel="stylesheet" href="assets/plugins/fontawesome/css/fontawesome.min.css">
        <link rel="stylesheet" href="assets/plugins/fontawesome/css/all.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />

        <!-- Main CSS -->
        <link rel="stylesheet" href="assets/css/style.css">

        <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!--[if lt IE 9]>
                        <script src="assets/js/html5shiv.min.js"></script>
                        <script src="assets/js/respond.min.js"></script>
                <![endif]-->

    </head>

    <body class="account-page">

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
                            <img style="object-fit: fill;" src="assets/img/final_logo.png" class="img-fluid" alt="Logo">
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
                            <li class="active">
                                <a href="index-2.jsp">Home</a>
                            </li>
                            
                            <!-- 12312 <li class="has-submenu">
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
                            <li class="has-submenu">
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
                                            <li><a href="register.jsp">Register</a></li>
                                            <li><a href="forgot-password.jsp">Forgot Password</a></li>
                                    </ul>
                            </li> -->
                            <li>
                                <a href="blog.jsp" >Blog</a>
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

                            <!-- Login Tab Content -->
                            <div class="account-content">
                                <div class="row align-items-center justify-content-center">
                                    <div class="col-md-7 col-lg-6 login-left">
                                        <img src="assets/img/login-banner-1.png" class="img-fluid" alt="thedearbird Login">
                                    </div>
                                    <div class="col-md-12 col-lg-6 login-right">
                                        <div class="login-header">
                                            <h3>Login to thedearbird</h3>
                                        </div>
                                        <form action="MainController" method="post">
                                            <div class="form-group form-focus">
                                                <input name="username" type="text" class="form-control floating">
                                                <label class="focus-label">Username</label>
                                            </div>

                                            <div class="box">
                                                <div class="form-group form-focus inputBox">
                                                    <input name="password" type="password" id="pass" class="form-control floating">
                                                    <label class="focus-label">Password</label>                                       
                                                    <span id="toggleBtn"></span>
                                                    <p style="
                                                       margin-top: 5px;
                                                       width: 280px;
                                                       padding-left: 3px;
                                                       padding-right: 3px;
                                                       border-radius: 3px;
                                                       background: #F8ECEC;
                                                       color: #be4b49;">${errorLogin}</p>
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
                                                    background: rgba(0,0,0,0.05);
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
                                            </style>

                                            <script>
                                                let pass = document.getElementById('pass');
                                                let toggleBtn = document.getElementById('toggleBtn');

                                                toggleBtn.onclick = function () {
                                                    if (pass.type === 'password') {
                                                        pass.setAttribute('type', 'text');
                                                        toggleBtn.classList.add('hide');
                                                    } else {
                                                        pass.setAttribute('type', 'password');
                                                        toggleBtn.classList.remove('hide');

                                                    }
                                                }
                                            </script>
                                            <div class="text-right">
                                                <a class="forgot-link" href="forgot-password.jsp">Forgot Password ?</a>
                                            </div>

                                            <button name="action" value="login" class="btn btn-primary btn-block btn-lg login-btn"
                                                    type="submit">Login</button>
                                            <div class="login-or">
                                                <span class="or-line"></span>
                                                <span class="span-or">or</span>
                                            </div>
                                            <div class="row form-row social-login">
                                                <div style="margin-left: auto; margin-right: auto;" class="col-6">
                                                    <a href="https://accounts.google.com/o/oauth2/auth?scope=email&redirect_uri=http://localhost:8080/bird-clinic-system/LoginGoogleController&response_type=code
                                                       &client_id=682520957809-oqj4srno5ntcptc8d15nts7il0iae4k4.apps.googleusercontent.com&approval_prompt=force" class="btn btn-google btn-block"><i
                                                            class="fab fa-google mr-1"></i>Login</a>
                                                </div>
                                            </div>
                                            <div class="text-center dont-have">Don’t have an account? <a
                                                    href="register.jsp">Register</a></div>
                                            <p style="color: green; margin-left: 10px;">${successSignUp}</p>
                                        </form>
                                    </div>
                                </div>
                            </div>
                            <!-- /Login Tab Content -->

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
        <script src="assets/js/jquery.min.js"></script>

        <!-- Bootstrap Core JS -->
        <script src="assets/js/popper.min.js"></script>
        <script src="assets/js/bootstrap.min.js"></script>

        <!-- Custom JS -->
        <script src="assets/js/script.js"></script>

    </body>

    <!-- doccure/login.jsp  30 Nov 2019 04:12:20 GMT -->

</html>