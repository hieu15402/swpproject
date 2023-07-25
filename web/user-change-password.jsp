<%-- 
    Document   : user-change-password
    Created on : Jun 8, 2023, 12:26:40 AM
    Author     : MSI AD
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />

    </head>
    <body>
        <div class="card">
            <div class="card-body">
                <div class="row">
                    <div class="col-md-12 col-lg-6">

                        <!-- Change Password Form -->
                        <form id="myform" action="MainController" method="POST">
                            <div class="form-group">
                                <label>Current Password</label>
                                <input id="myusername" name="username" value="${sessionScope.account.username}" type="hidden" >
                                <input id="mypass" name="password" type="password" class="form-control" required="" onchange="checkPassDup()">
                                <p id="resultss" style="margin-left: 10px;"></p>
                                <style>
                                    #resultss {
                                        margin-top: 5px;
                                        width: 45%;
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
                            <div class="box">
                                <div class="form-group">
                                    <label>New Password</label>

                                    <input name="newPass" type="password" class="form-control floating" 
                                           id="pass" onkeyup="validatePassword(this.value); checkPassword(this.value)" 
                                           required="">

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
                            <!--                            <script>
                                                            let pass = document.getElementById('pass');
                                                            let toggleBtn = document.getElementById('toggleBtn');
                            
                                                            let lowerCase = document.getElementById('lower');
                                                            let upperCase = document.getElementById('upper');
                                                            let digit = document.getElementById('number');
                                                            let specialChar = document.getElementById('special');
                                                            let minLength = document.getElementById('length');
                            
                            
                                                            function checkPassword(data) {
                                                                const lower = new RegExp('(?=.*[a-z])');
                                                                const upper = new RegExp('(?=.*[A-Z])');
                                                                const number = new RegExp('(?=.*[0-9])');
                                                                const special = new RegExp('(?=.*[!@#\$%\^&\*])');
                                                                const length = new RegExp('(?=.{8,})');
                                                                //lower case check
                                                                if (lower.test(data)) {
                                                                    lowerCase.classList.add('valid');
                                                                } else {
                                                                    lowerCase.classList.remove('valid');
                                                                }
                                                                //check upper case
                                                                if (upper.test(data)) {
                                                                    upperCase.classList.add('valid');
                                                                } else {
                                                                    upperCase.classList.remove('valid');
                                                                }
                                                                //check number
                                                                if (number.test(data)) {
                                                                    digit.classList.add('valid');
                                                                } else {
                                                                    digit.classList.remove('valid');
                                                                }
                                                                //check specialChar
                                                                if (special.test(data)) {
                                                                    specialChar.classList.add('valid');
                                                                } else {
                                                                    specialChar.classList.remove('valid');
                                                                }
                                                                //check min length
                                                                if (length.test(data)) {
                                                                    minLength.classList.add('valid');
                                                                } else {
                                                                    minLength.classList.remove('valid');
                                                                }
                                                            }
                            
                                                            toggleBtn.onclick = function () {
                                                                if (pass.type === 'password') {
                                                                    pass.setAttribute('type', 'text');
                                                                    toggleBtn.classList.add('hide');
                                                                } else {
                                                                    pass.setAttribute('type', 'password');
                                                                    toggleBtn.classList.remove('hide');
                                                                }
                                                            }
                            
                            
                                                            function validatePassword(value) {
                                                                var validationDiv = document.getElementById("validation");
                                                                if (value.length > 0) {
                                                                    validationDiv.style.display = "block";
                                                                } else {
                                                                    validationDiv.style.display = "none";
                                                                }
                                                            }
                            
                                                            function validateForm() {
                                                                var password = document.getElementById("pass").value;
                            
                                                                if (password.length < 8 || !/[a-z]/.test(password) || !/[A-Z]/.test(password) || !/[0-9]/.test(password) || !/[!@#$%^&+=]/.test(password)) {
                                                                    return false;
                                                                }
                                                            }
                                                        </script>-->
                            <div class="form-group">
                                <label>Confirm Password</label>
                                <input id="myconpass" name="newConPass" type="password"  required="" class="form-control" onchange="checkPassConfirm()">
                                <p id="resultsss" style="margin-left: 10px;"></p>
                                <style>
                                    #resultsss {
                                        margin-top: 5px;
                                        width: 45%;
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
                            <div class="submit-section">
                                <button id="submit" name="action" value="changepass" type="submit" class="btn btn-primary submit-btn" disabled = "true">Save Change</button>
                            </div>
                            <p id="results" style="margin-left: 10px;">${correctPass}</p>
                            <style>


                            </style>

                        </form>
                        <!-- /Change Password Form -->

                    </div>
                </div>
            </div>
        </div>
    </body>


</html>
