function Dashboard() {
    var xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function () {
        if (this.readyState === 4 && this.status === 200) {
            document.getElementById("dashboard").innerHTML = this.responseText;
            var table = $('.datatable').DataTable();
        }
    };
    xhttp.open("GET", "patient_dashboard.jsp", true);
    xhttp.send();
}
function UserProfile() {
    var xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function () {
        if (this.readyState === 4 && this.status === 200) {
            document.getElementById("dashboard").innerHTML = this.responseText;
            var table = $('.datatable').DataTable();
        }
    };
    xhttp.open("GET", "user-profile.jsp", true);
    xhttp.send();
}
function BirdProfile() {
    var xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function () {
        if (this.readyState === 4 && this.status === 200) {
            document.getElementById("dashboard").innerHTML = this.responseText;
            var table = $('.datatable').DataTable();
        }
    };
    xhttp.open("GET", "bird-profile.jsp", true);
    xhttp.send();
}


var scriptAdded = false; // Biến flag để kiểm tra đã thêm script hay chưa

function ChangePass() {
    var xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function () {
        if (this.readyState === 4 && this.status === 200) {
            document.getElementById("dashboard").innerHTML = this.responseText;

            if (scriptAdded === false) { // Kiểm tra nếu chưa thêm script
                // Tạo phần tử script mới
                var script = document.createElement("script");
                script.src = "assets/js/checkValidate.js";
//                // Thêm phần tử script vào phần head của tài liệu
               document.head.appendChild(script);
//
              scriptAdded = true; // Đánh dấu đã thêm script
            }
        }
    };
    xhttp.open("GET", "user-change-password.jsp", true);
    xhttp.send();
}

function sendOption() {
    var selectElement = document.getElementById("select");
    var selectedValue = selectElement.value;

    var xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function () {
        if (this.readyState === 4 && this.status === 200) {
            document.getElementById("demo").innerHTML = this.responseText;
            var table = $('.datatable').DataTable();
        }
    };
    xhttp.open("GET", "load-bird-info.jsp?selectedOption=" + selectedValue, true);
    xhttp.send();
}

