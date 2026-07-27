function validateLogin(event) {
    if (event) {
        event.preventDefault();
    }

    const email = document.getElementById("loginEmail").value.trim();
    const password = document.getElementById("loginPassword").value.trim();

    if (!email || !password) {
        alert("Please fill in both login fields.");
        return false;
    }

    alert("Login form is ready.");
    return false;
}

function validateRegister(event) {
    if (event) {
        event.preventDefault();
    }

    const name = document.getElementById("registerName").value.trim();
    const email = document.getElementById("registerEmail").value.trim();
    const password = document.getElementById("registerPassword").value.trim();
    const confirmPassword = document.getElementById("registerConfirm").value.trim();
    const termsChecked = document.getElementById("termsCheck").checked;

    if (!name || !email || !password || !confirmPassword) {
        alert("Please fill in all registration fields.");
        return false;
    }

    if (password !== confirmPassword) {
        alert("Passwords do not match.");
        return false;
    }

    if (!termsChecked) {
        alert("Please accept the terms and conditions.");
        return false;
    }

    alert("Registration form is ready.");
    return false;
}

function submitContact(event) {
    if (event) {
        event.preventDefault();
    }

    const name = document.getElementById("contactName").value.trim();
    const email = document.getElementById("contactEmail").value.trim();
    const subject = document.getElementById("contactSubject").value.trim();
    const message = document.getElementById("contactMessage").value.trim();

    if (!name || !email || !subject || !message) {
        alert("Please complete the contact form.");
        return false;
    }

    alert("Thank you for contacting us.");
    return false;
}

function searchEmployee() {
    const input = document.getElementById("searchInput");
    const filter = input.value.toUpperCase();
    const rows = document.querySelectorAll("#employeeTable tbody tr");

    rows.forEach(function (row) {
        const nameCell = row.getElementsByTagName("td")[1];

        if (!nameCell) {
            return;
        }

        const text = nameCell.textContent || nameCell.innerText;
        row.style.display = text.toUpperCase().indexOf(filter) > -1 ? "" : "none";
    });
}