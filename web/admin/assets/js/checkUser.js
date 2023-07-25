jQuery(document).ready(function () {
    var isUsernameAvailable = false;
    var isEmailAvailable = false;
    var isPhoneAvailable = false;
    var isEmailAvailable_1 = false;

    function enableSubmitButton() {
        if (isUsernameAvailable && isEmailAvailable && isPhoneAvailable && isEmailAvailable_1) {
            $('#submit').prop('disabled', false);
        } else {
            $('#submit').prop('disabled', true);
        }
    }

    $('#myuser').change(function () {
        var myuser = $('#myuser').val();
        $.ajax({
            type: 'POST',
            data: {myuser: myuser},
            url: '../UsernameCheckController',
            success: function (result) {
                $('#result').html(result);

                if (result === 'Username is available to use !') {
                    $('#result').removeClass().addClass('available');
                    isUsernameAvailable = true;
                } else if (result === 'This username has been taken, try another !' || result === 'Username must at least 8 characters !') {
                    $('#result').removeClass().addClass('already-exists');
                    isUsernameAvailable = false;
                }

                enableSubmitButton();
            }
        });
    });

    $('#myemail').change(function () {
        var myemail = $('#myemail').val();
        $.ajax({
            type: 'POST',
            data: {myemail: myemail},
            url: 'EmailCheckController',
            success: function (result_1) {
                $('#result_1').html(result_1);

                if (result_1 === 'Email is available to use !') {
                    $('#result_1').removeClass().addClass('available');
                    isEmailAvailable = true;
                } else if (result_1 === 'This email has been taken, try another !' || result_1 === 'It looks like you may have entered an incorrect email!') {
                    $('#result_1').removeClass().addClass('already-exists');
                    isEmailAvailable = false;
                }

                enableSubmitButton();
            }
        });
    });

    $('#myemail_1').change(function () {
        var myemail_1 = $('#myemail_1').val();
        $.ajax({
            type: 'POST',
            data: {myemail_1: myemail_1},
            url: 'EmailCheckControllerReverse',
            success: function (result_11) {
                $('#result_11').html(result_11);

                if (result_11 === 'Email is available to reset password !') {
                    $('#result_11').removeClass().addClass('available');
                    isEmailAvailable_1 = true;
                } else if (result_11 === 'Your entered email does not match any account !' || result_11 === 'It looks like you may have entered an incorrect email!') {
                    $('#result_11').removeClass().addClass('already-exists');
                    isEmailAvailable_1 = false;
                }

                enableSubmitButton();
            }
        });
    });

    $('#myphone').change(function () {
        var myphone = $('#myphone').val();
        $.ajax({
            type: 'POST',
            data: {myphone: myphone},
            url: 'PhoneCheckController',
            success: function (result_2) {
                $('#result_2').html(result_2);

                if (result_2 === 'Phone is available to use !') {
                    $('#result_2').removeClass().addClass('available');
                    isPhoneAvailable = true;
                } else if (result_2 === 'This phone has been taken, try another !' || result_2 === 'It looks like you may have entered an incorrect phone!') {
                    $('#result_2').removeClass().addClass('already-exists');
                    isPhoneAvailable = false;
                }

                enableSubmitButton();
            }
        });
    });

    $('#myphone_').change(function () {
        var myphone = $('#myphone_').val();
        $.ajax({
            type: 'POST',
            data: {myphone: myphone},
            url: 'PhoneCheckController',
            success: function (result_2) {
                if (result_2 === 'It looks like you may have entered an incorrect phone!') {
                    $('#result_2').html(result_2);
                    $('#result_2').css('color', 'red');
                } else {
                    $('#result_2').html('Phone is available to use !');
                    $('#result_2').css('color', 'green');
                }

                if (result_2 === 'It looks like you may have entered an incorrect phone!') {
                    $('#result_2').removeClass().addClass('already-exists');
                    isPhoneAvailable = false;
                } else {
                    $('#result_2').removeClass().addClass('available');
                    isPhoneAvailable = true;
                }

                enableSubmitButton();
            }
        });
    });



    function enableSubmitButton() {
        if (isPhoneAvailable) {
            $('#submit').prop('disabled', false);
        } else {
            $('#submit').prop('disabled', true);
        }
    }

});

function enableSubmitButton() {
    if (isUsernameAvailable && isEmailAvailable && isPhoneAvailable) {
        $('#submit').prop('disabled', false);
    } else {
        $('#submit').prop('disabled', true);
    }
}

var isPassAvailable = false;


function checkPassDup() {
    var mypass = $('#mypass').val();
    var myusername = $('#myusername').val();
    $.ajax({
        type: 'POST',
        data: {mypass: mypass, myusername: myusername},
        url: 'CheckPasswordController',
        success: function (result) {
            $('#resultss').html(result);
            if (result === 'Your password correct!') {
                $('#resultss').removeClass().addClass('available');
                isPassAvailable = true;
            } else if (result === 'Your password incorrect!') {
                $('#resultss').removeClass().addClass('already-exists');
                isPassAvailable = false;
            }
            if (isPassAvailable) {
                $('#submit').prop('disabled', false);
            } else {
                $('#submit').prop('disabled', true);
            }
        }
    });
}


var isPassAvailable_2 = false;
function checkPassConfirm() {
    var mynewpass = $('#pass').val();
    var myconpass = $('#myconpass').val();
    $.ajax({
        success: function () {
            if (mynewpass === myconpass) {
                $('#resultsss').html('Your password matched');
                $('#resultsss').removeClass().addClass('available');
                isPassAvailable_2 = true;
            } else {
                $('#resultsss').html('Your password not match');
                $('#resultsss').removeClass().addClass('already-exists');
                isPassAvailable_2 = false;
            }
            if (isPassAvailable_2) {
                $('#submit').prop('disabled', false);
            } else {
                $('#submit').prop('disabled', true);
            }

        }
    });
}


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





