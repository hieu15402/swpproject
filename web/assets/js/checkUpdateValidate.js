var isBirdnameAvailable = false;
var isBirdImgAvailable = false;

function checkUsername() {
    var birdname_dash = $('#birdname_dash').val();
    var username = $('#username').val();
    $.ajax({
        type: 'POST',
        data: {birdname_dash: birdname_dash, username: username},
        url: 'BirdnameCheckUpdateController',
        success: function (result) {
            $('#result_4').html(result);
            if (result === 'Birdname is available to use') {
                $('#result_4').removeClass().addClass('available');
                isBirdnameAvailable = true;
            } else if (result === 'This birdname has been taken, try another') {
                $('#result_4').removeClass().addClass('already-exists');
                isBirdnameAvailable = false;
            }
            if (isBirdnameAvailable === true) {
                $('#update').prop('disabled', false);
            } else {
                $('#update').prop('disabled', true);
            }
        }
    });
}
function checkImage() {
    var myemail = $('#bird_image_dash').val();
    $.ajax({
        type: 'POST',
        data: {bird_image_dash: myemail},
        url: 'ImageUpdateBirdController',
        success: function (result_1) {
            $('#result_3').html(result_1);

            if (result_1 === 'Image is available to use') {
                $('#result_3').removeClass().addClass('available');
                isBirdImgAvailable = true;
            } else if (result_1 === 'Allowed JPG, GIF or PNG., try another') {
                $('#result_3').removeClass().addClass('already-exists');
                isBirdImgAvailable = false;
            }
             if (isBirdImgAvailable === true) {
                $('#update').prop('disabled', false);
            } else {
                $('#update').prop('disabled', true);
            }
        }
    });
}


function checkImage2() {
    var myemail = $('#bird_image_dash2').val();
    $.ajax({
        type: 'POST',
        data: {bird_image_dash: myemail},
        url: 'ImageUpdateBirdController',
        success: function (result_1) {
            $('#result_3').html(result_1);

            if (result_1 === 'Image is available to use') {
                $('#result_4').removeClass().addClass('available');
                isBirdImgAvailable = true;
            } else if (result_1 === 'Allowed JPG, GIF or PNG., try another') {
                $('#result_3').removeClass().addClass('already-exists');
                isBirdImgAvailable = false;
            }
             if (isBirdImgAvailable === true) {
                $('#update').prop('disabled', false);
            } else {
                $('#update').prop('disabled', true);
            }
        }
    });
}