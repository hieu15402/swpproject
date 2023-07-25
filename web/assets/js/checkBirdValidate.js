jQuery(document).ready(function () {
    var isBirdnameAvailable = false;
    var isBirdImgAvailable = true;

    function enableSubmitButton() {
        if (isBirdnameAvailable === true && isBirdImgAvailable === true) {
            $('#submit').prop('disabled', false);
        } else if (isBirdnameAvailable === true && isBirdImgAvailable === false) {
            $('#submit').prop('disabled', true);
        } else {
            $('#submit').prop('disabled', true);
        }
    }
    $('#birdname').change(function () {
        var birdname = $('#birdname').val();
        var username = $('#username').val();
        $.ajax({
            type: 'POST',
            data: {birdname: birdname, username: username},
            url: 'BirdnameCheckController',
            success: function (result) {
                $('#result').html(result);

                if (result === 'Birdname is available to use') {
                    $('#result').removeClass().addClass('available');
                    isBirdnameAvailable = true;
                } else if (result === 'This birdname has been taken, try another') {
                    $('#result').removeClass().addClass('already-exists');
                    isBirdnameAvailable = false;
                }
                enableSubmitButton();
            }
        });
    });

    $('#imgbird').change(function () {
        var imgbird = $('#imgbird').val();
        $.ajax({
            type: 'POST',
            data: {imgbird: imgbird},
            url: 'ImageBirdController',
            success: function (result_1) {
                $('#result_1').html(result_1);
                if (result_1 === 'Image is available to use') {
                    $('#result_1').removeClass().addClass('available');
                    isBirdImgAvailable = true;
                } else if (result_1 === 'Allowed JPG, or PNG, try another') {
                    $('#result_1').removeClass().addClass('already-exists');
                    isBirdImgAvailable = false;
                }
                enableSubmitButton();
            }
        });
    });
});
  function Gender() {
       
            $('#update').prop('disabled', false);
       
    }
    function Age() {
       
            $('#update').prop('disabled', false);
       
    }

