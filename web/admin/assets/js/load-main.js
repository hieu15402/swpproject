

var links = document.querySelectorAll("#sidebar-menu a");
for (var i = 0; i < links.length; i++) {
    links[i].addEventListener("click", handleClick);
}

// Set the second <li> element as active by default
var defaultActiveItem = document.querySelector("#sidebar-menu li:nth-child(2)");
defaultActiveItem.classList.add("active");

function handleClick(event) {
    var listItems = document.querySelectorAll("#sidebar-menu li");
    for (var i = 0; i < listItems.length; i++) {
        listItems[i].classList.remove("active");
    }

    var clickedLink = event.target;
    clickedLink.closest("li").classList.add("active");

    // Prevent the default behavior of the link (e.g., navigating to a new page)
    event.preventDefault();
}


function Dashboard_1() {
    var xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function () {
        if (this.readyState === 4 && this.status === 200) {
            document.getElementById("main").innerHTML = this.responseText;

            // Create the script element for Chart.js
            var chartScript = document.createElement("script");
            chartScript.src = "https://cdn.jsdelivr.net/npm/chart.js@4.3.0/dist/chart.umd.min.js";
            chartScript.onload = function () {
                // Once Chart.js is loaded, execute the code in chart_1.js
                var chart1Script = document.createElement("script");
                chart1Script.src = "assets/js/chart_1.js";
                document.head.appendChild(chart1Script);

            };
            // Append the Chart.js script to the document's <head> section
            document.head.appendChild(chartScript);

        }
    };
    xhttp.open("GET", "dashboard.jsp", true);
    xhttp.send();
}





function Appointments() {
    var xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function () {
        if (this.readyState === 4 && this.status === 200) {
            document.getElementById("main").innerHTML = this.responseText;
            var table = $('.datatable').DataTable();
        }
    };
    xhttp.open("GET", "appointments.jsp", true);
    xhttp.send();
}
function OnclickAppointments() {
    removeActiveClassFromAllItems();
    document.getElementById("appointmentsLink").classList.add("active");
}
function Services() {
    var xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function () {
        if (this.readyState === 4 && this.status === 200) {
            document.getElementById("main").innerHTML = this.responseText;
            var table = $('.datatable').DataTable();
        }
    };
    xhttp.open("GET", "service.jsp", true);
    xhttp.send();
}
function Doctors() {
    var xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function () {
        if (this.readyState === 4 && this.status === 200) {
            document.getElementById("main").innerHTML = this.responseText;
            var table = $('.datatable').DataTable();
              var script = document.createElement("script");
                script.src = "./assets/js/checkUser.js";
//                // Thêm phần tử script vào phần head của tài liệu
               document.head.appendChild(script);
//
              scriptAdded = true; // Đánh dấu đã thêm script
        }
    };
    xhttp.open("GET", "doctors.jsp", true);
    xhttp.send();
}
function Customers() {
    var xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function () {
        if (this.readyState === 4 && this.status === 200) {
            document.getElementById("main").innerHTML = this.responseText;
            var table = $('.datatable').DataTable();
        }
    };
    xhttp.open("GET", "customers.jsp", true);
    xhttp.send();
}
function Reviews() {
    var xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function () {
        if (this.readyState === 4 && this.status === 200) {
            document.getElementById("main").innerHTML = this.responseText;
            var table = $('.datatable').DataTable();
        }
    }
    ;
    xhttp.open("GET", "reviews.jsp", true);
    xhttp.send();
}
function Staff() {
    var xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function () {
        if (this.readyState === 4 && this.status === 200) {
            document.getElementById("main").innerHTML = this.responseText;
            var table = $('.datatable').DataTable();
        }
    }
    ;
    xhttp.open("GET", "staff-list.jsp", true);
    xhttp.send();
}


function Blogs() {
    var xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function () {
        if (this.readyState === 4 && this.status === 200) {
            document.getElementById("main").innerHTML = this.responseText;
            var table = $('.datatable').DataTable();
            var ckeditorScript = document.createElement('script');
            ckeditorScript.src = 'assets/ckeditor/ckeditor.js';
            ckeditorScript.onload = function () {
                CKEDITOR.replace('content');
            };
            document.head.appendChild(ckeditorScript);
        }
    }
    ;
    xhttp.open("GET", "blogx.jsp", true);
    xhttp.send();
}