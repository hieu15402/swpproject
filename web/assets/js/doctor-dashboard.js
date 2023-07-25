function Dashboard() {
    var xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function () {
        if (this.readyState === 4 && this.status === 200) {
            document.getElementById("doctor").innerHTML = this.responseText;
        }
    };
    xhttp.open("GET", "doctor_dashboard.jsp", true);
    xhttp.send();
}

function Appointments() {
    var xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function () {
        if (this.readyState === 4 && this.status === 200) {
            document.getElementById("doctor").innerHTML = this.responseText;
        }
    };
    xhttp.open("GET", "appointments.jsp", true);
    xhttp.send();
}
function Patients() {
    var xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function () {
        if (this.readyState === 4 && this.status === 200) {
            document.getElementById("doctor").innerHTML = this.responseText;
        }
    };
    xhttp.open("GET", "my-patients.jsp", true);
    xhttp.send();
}
function Profile() {
    var xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function () {
        if (this.readyState === 4 && this.status === 200) {
            document.getElementById("doctor").innerHTML = this.responseText;
        }
    };
    xhttp.open("GET", "doctor-profile-settings.jsp", true);
    xhttp.send();
}
function Feedback() {
    var xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function () {
        if (this.readyState === 4 && this.status === 200) {
            document.getElementById("doctor").innerHTML = this.responseText;
        }
    };
    xhttp.open("GET", "feedback-doctor.jsp", true);
    xhttp.send();
}
function Add() {
    // Tạo thẻ select
    var divElement = document.getElementById("service");
    var selectElement = document.createElement("select");
    selectElement.id = "mySelect";
    var index = document.getElementById("index").value;
    var input = document.getElementById("myInput");
    var currentValue = parseInt(input.value);
    var total = document.getElementById("Total");
    var currentTotal = parseFloat(total.value);

    for (var i = 0; i < index; i++) {

        var option = document.createElement("option");
        var ser_name = document.getElementById("service_name_" + (index - i).toString()).value;
        var ser_id = document.getElementById("service_id_" + (index - i).toString()).value;
        var ser_fee = document.getElementById("service_fee_" + (index - i).toString()).value;
        option.action = ser_fee.toString() + "-" + ser_name.toString();
        option.value = ser_fee.toString();
        option.text = ser_fee.toString() + "-" + ser_name.toString();
        selectElement.appendChild(option);
    }

// Thêm select vào vị trí mong muốn trong tài liệu (ví dụ: body)
    divElement.appendChild(selectElement);
// Tạo nút Add
    var addButton = document.createElement("button");
    addButton.innerText = "Add";
    var addCancel = document.createElement("button");
    addCancel.innerText = "Cancel";
    // Sự kiện click cho nút Add
    addCancel.addEventListener("click", function () {
        // Lấy giá trị được chọn trong select
        selectElement.remove();
        addButton.remove();
        // Tạo button mới
        addCancel.remove();

    });


    // Sự kiện click cho nút Add
    addButton.addEventListener("click", function (event) {
        // Lấy giá trị được chọn trong select
        var checkExist = false;
        var selectedOption = selectElement.options[selectElement.selectedIndex];
        for (var i = 1; i <= currentValue; i++) {
            var check = document.getElementById("service_" + i.toString());
            if (check.value === selectedOption.text) {
                checkExist = true;
                break;
            }
        }
        if (checkExist === true) {
            alert("Dịch vụ này đã có!!!")
        } else {
            selectElement.remove();
            addButton.remove();
            addCancel.remove();
            // Tạo button mới
            input.value = currentValue + 1;

            total.value = currentTotal + parseInt(selectedOption.value);
            var newButton = document.createElement("input");
            newButton.innerText = selectedOption.action;
            newButton.value = selectedOption.action;
            newButton.readOnly = true;
            newButton.name = "service_" + input.value.toString();
            newButton.id = "service_" + input.value.toString();
            newButton.style = "color:black;background-color:red; border: red";
            var doneBtn = document.getElementById("Done");
            doneBtn.disabled = true;
            // Thêm button mới vào vị trí mong muốn trong tài liệu (ví dụ: body)
            divElement.appendChild(newButton);
        }
        event.preventDefault();
    });
// Thêm nút Add vào vị trí mong muốn trong tài liệu (ví dụ: body)
    divElement.appendChild(addButton);
    divElement.appendChild(addCancel);
// Xóa các option trong select
}

function AddMore() {
    // Tạo thẻ select
    var divElement = document.getElementById("service");
    var selectElement = document.createElement("select");
    selectElement.id = "mySelect";
    var index = document.getElementById("index").value;
    var input = document.getElementById("myInput");
    var currentValue = parseInt(input.value);
    var total = document.getElementById("Total");
    var currentTotal = parseFloat(total.value);

    for (var i = 0; i < index; i++) {

        var option = document.createElement("option");
        var ser_name = document.getElementById("service_name_" + (index - i).toString()).value;
        var ser_id = document.getElementById("service_id_" + (index - i).toString()).value;
        var ser_fee = document.getElementById("service_fee_" + (index - i).toString()).value;
        option.action = ser_fee.toString() + "-" + ser_name.toString();
        option.value = ser_fee.toString();
        option.text = ser_fee.toString() + "-" + ser_name.toString();
        selectElement.appendChild(option);
    }

// Thêm select vào vị trí mong muốn trong tài liệu (ví dụ: body)
    divElement.appendChild(selectElement);
// Tạo nút Add
    var addButton = document.createElement("button");
    addButton.innerText = "Add";
    var addCancel = document.createElement("button");
    addCancel.innerText = "Cancel";
    // Sự kiện click cho nút Add
    addCancel.addEventListener("click", function () {
        // Lấy giá trị được chọn trong select
        selectElement.remove();
        addButton.remove();
        // Tạo button mới
        addCancel.remove();

    });


    // Sự kiện click cho nút Add
    addButton.addEventListener("click", function (event) {
        // Lấy giá trị được chọn trong select
        var checkExist = false;
        var selectedOption = selectElement.options[selectElement.selectedIndex];
        for (var i = 1; i <= currentValue; i++) {
            var check = document.getElementById("service_" + i.toString());
            if (check.value === selectedOption.text) { //Fix
                checkExist = true;
                break;
            }
        }
        if (checkExist === true) {
            alert("Dịch vụ này đã có!!!")

        } else {
            selectElement.remove();
            addButton.remove();
            addCancel.remove();
            // Tạo button mới
            input.value = currentValue + 1;

            total.value = currentTotal + parseInt(selectedOption.value);
            var newButton = document.createElement("input");
            newButton.innerText = selectedOption.action;
            newButton.value = selectedOption.action;
            newButton.readOnly = true;
            newButton.name = "service_" + input.value.toString();
            newButton.id = "service_" + input.value.toString();
            newButton.style = "color:black;background-color:red; border: red";
            var doneBtn = document.getElementById("Done");
            doneBtn.disabled = true;
            // Thêm button mới vào vị trí mong muốn trong tài liệu (ví dụ: body)
            divElement.appendChild(newButton);
        }
        event.preventDefault();
    });
// Thêm nút Add vào vị trí mong muốn trong tài liệu (ví dụ: body)
    divElement.appendChild(addButton);
    divElement.appendChild(addCancel);

// Xóa các option trong select
}
function Medical(id) {
    var xhttp = new XMLHttpRequest();

    xhttp.onreadystatechange = function () {
        if (this.readyState === 4 && this.status === 200) {
            document.getElementById("doctor").innerHTML = this.responseText;
        }
    };
    xhttp.open("GET", "medical-record.jsp?Booking_id=" + id, true);
    xhttp.send();
}
function Medical_done(id) {
    var xhttp = new XMLHttpRequest();

    xhttp.onreadystatechange = function () {
        if (this.readyState === 4 && this.status === 200) {
            document.getElementById("doctor").innerHTML = this.responseText;
        }
    };
    xhttp.open("GET", "medical-record-done.jsp?Booking_id=" + id, true);
    xhttp.send();
}

