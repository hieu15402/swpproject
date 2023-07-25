function Click(element) {
    var selectedElements = document.querySelectorAll(".timing.selected");
    var inputElement = element.querySelector("input");
    var selectedDayInput = element.querySelector(".selectedDay");

    if (!element.classList.contains("selected")) {
        // Thêm class "selected" vào thẻ <a> được click và gỡ class "selected" của các thẻ khác
        for (var i = 0; i < selectedElements.length; i++) {
            selectedElements[i].classList.remove("selected");
        }
        element.classList.add("selected");
        // Kiểm tra xem thuộc tính name của thẻ <input> có khác "selectedSlot" hay không
        if (inputElement.getAttribute("name") !== "selectedSlot") {
            // Gỡ thuộc tính name của các thẻ <input> khác
            var allInputElements = document.querySelectorAll("input.valueBooking");
            for (var j = 0; j < allInputElements.length; j++) {
                allInputElements[j].removeAttribute("name");
            }
            // Thêm thuộc tính name="selectedSlot" vào thẻ <input> được click
            inputElement.setAttribute("name", "selectedSlot");
        }
        // Kiểm tra xem thuộc tính name của thẻ <input> có khác "selectedDay" hay không
        if (selectedDayInput.getAttribute("name") !== "selectedDay") {
            // Gỡ thuộc tính name của các thẻ <input> khác
            var allSelectedDayInputs = document.querySelectorAll("input.selectedDay");
            for (var k = 0; k < allSelectedDayInputs.length; k++) {
                allSelectedDayInputs[k].removeAttribute("name");
            }
            // Thêm thuộc tính name="selectedDay" vào thẻ <input> thứ hai được click
            selectedDayInput.setAttribute("name", "selectedDay");
        }
    } else {
        // Xóa class "selected" trong thẻ <a> đã được click
        element.classList.remove("selected");
        // Xóa thuộc tính name trong thẻ <input> được click
        inputElement.removeAttribute("name");
        // Xóa thuộc tính name trong thẻ <input> thứ hai được click
        selectedDayInput.removeAttribute("name");
    }

    if (document.querySelector(".timing.selected")) {
        submitButton.disabled = false; // Enable nút submit
    } else {
        submitButton.disabled = true; // Disable nút submit
    }

}