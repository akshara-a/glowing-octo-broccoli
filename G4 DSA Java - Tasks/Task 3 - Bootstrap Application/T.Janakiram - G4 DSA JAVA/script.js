document.addEventListener("DOMContentLoaded", () => {
    
    // --- Bonus 1: Light / Dark Mode Toggle Mechanism ---
    const darkModeToggle = document.getElementById("darkModeToggle");
    if (darkModeToggle) {
        darkModeToggle.addEventListener("click", () => {
            document.body.classList.toggle("dark-mode");
        });
    }

    // --- Bonus 2: Client Form Interception & Form Validation Alert Responses ---
    const enforceValidationAction = (formId, successNotificationText) => {
        const structuralForm = document.getElementById(formId);
        if (!structuralForm) return;

        structuralForm.addEventListener("submit", (event) => {
            if (!structuralForm.checkValidity()) {
                event.preventDefault();
                event.stopPropagation();
            } else {
                event.preventDefault(); // Lock form submission default reload loop
                alert(`[Database Server Payload Dispatch]\n\n${successNotificationText}`);
                structuralForm.reset();
                structuralForm.classList.remove("was-validated");
                return false;
            }
            structuralForm.classList.add("was-validated");
        }, false);
    };

    enforceValidationAction("loginForm", "Identity token authorized! Loading user workspace parameters context.");
    enforceValidationAction("registerForm", "Account record processed! Transmitting confirmation hash to validation email.");
    enforceValidationAction("contactForm", "Help ticket generated completely! Support node grid entry allocated.");

    // --- Bonus 3: Table Row Search Filter Array Engine ---
    const tableQueryInput = document.getElementById("tableSearchInput");
    const structuralTableRows = document.querySelectorAll("#employeeTable tbody tr");

    if (tableQueryInput) {
        tableQueryInput.addEventListener("input", (event) => {
            const rawQuery = event.target.value.toLowerCase().trim();

            structuralTableRows.forEach((row) => {
                const innerRowContent = row.textContent.toLowerCase();
                if (innerRowContent.includes(rawQuery)) {
                    row.style.display = ""; // Render row standard visibility
                } else {
                    row.style.display = "none"; // Hide row elements on mismatch
                }
            });
        });
    }

    // --- Use Case 13: JavaScript Bootstrap Modal Action Handler ---
    const saveChangesModalBtn = document.getElementById("saveChangesModalBtn");
    if (saveChangesModalBtn) {
        saveChangesModalBtn.addEventListener("click", () => {
            alert("Administrative variables committed cleanly into memory buffers.");
            
            // Programmatically hide the modal popup overlay
            const overlayTargetNode = document.getElementById("demoModal");
            const activeBootstrapInstance = bootstrap.Modal.getInstance(overlayTargetNode);
            if (activeBootstrapInstance) {
                activeBootstrapInstance.hide();
            }
        });
    }

    // --- Bonus 4: Sidebar Highlighting Active Selection State ---
    const contextSidebarLinks = document.querySelectorAll(".dashboard-sidebar-nav .nav-link");
    contextSidebarLinks.forEach((linkItem) => {
        linkItem.addEventListener("click", () => {
            contextSidebarLinks.forEach((item) => item.classList.remove("active", "fw-bold"));
            linkItem.classList.add("active", "fw-bold");
        });
    });
});
