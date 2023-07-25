jQuery(document).ready(function () {
       var isPhoneAvailable = false;

    function enableSubmitButton() {
        if (isPhoneAvailable) {
            $('#submit').prop('disabled', false);
        } else {
            $('#submit').prop('disabled', true);
        }
    }  
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
});


