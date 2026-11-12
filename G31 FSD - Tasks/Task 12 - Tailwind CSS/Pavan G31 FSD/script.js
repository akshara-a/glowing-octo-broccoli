// =========================================
// FINORA - MAIN JAVASCRIPT
// =========================================

document.addEventListener("DOMContentLoaded", () => {

    // =========================================
    // THEME TOGGLE
    // =========================================

    const themeToggle =
        document.getElementById("theme-toggle");

    const sunIcon =
        document.getElementById("sun-icon");

    const moonIcon =
        document.getElementById("moon-icon");


    if (themeToggle && sunIcon && moonIcon) {

        const savedTheme =
            localStorage.getItem("finora-theme") || "light";


        if (savedTheme === "dark") {

            document.documentElement.classList.add("dark");

            sunIcon.classList.add("hidden");
            moonIcon.classList.remove("hidden");

        } else {

            document.documentElement.classList.remove("dark");

            sunIcon.classList.remove("hidden");
            moonIcon.classList.add("hidden");

        }


        themeToggle.addEventListener("click", () => {

            const isDark =
                document.documentElement.classList.toggle("dark");


            if (isDark) {

                localStorage.setItem(
                    "finora-theme",
                    "dark"
                );

                sunIcon.classList.add("hidden");
                moonIcon.classList.remove("hidden");

            } else {

                localStorage.setItem(
                    "finora-theme",
                    "light"
                );

                sunIcon.classList.remove("hidden");
                moonIcon.classList.add("hidden");

            }

        });

    }


    // =========================================
    // MOBILE MENU
    // =========================================

    const menuButton =
        document.getElementById("menu-button");

    const mobileMenu =
        document.getElementById("mobile-menu");


    if (menuButton && mobileMenu) {

        menuButton.addEventListener("click", () => {

            mobileMenu.classList.toggle("hidden");

        });

    }


    // =========================================
    // UNIVERSAL FINORA NOTIFICATION
    // =========================================

    const notification =
        document.getElementById("finora-notification");

    const notificationTitle =
        document.getElementById("notification-title");

    const notificationMessage =
        document.getElementById("notification-message");

    const notificationClose =
        document.getElementById("notification-close");

    const notificationConfirm =
    document.getElementById("notification-confirm");


    let notificationTimer = null;


    function hideNotification() {

        if (!notification) {
            return;
        }


        notification.style.opacity = "0";

        notification.style.transform =
            "translateY(10px)";


        setTimeout(() => {

            notification.classList.add("hidden");

            notification.style.display = "none";

        }, 300);

    }

// =========================================
// STAGE 11 - NOTIFICATION CONTROLS
// =========================================

if (notificationConfirm) {

    notificationConfirm.addEventListener(
        "click",
        () => {

            // Close the notification
            hideNotification();

            // Find pricing section
            const pricingSection =
                document.getElementById("pricing");

            // Smoothly scroll to pricing
            if (pricingSection) {

                pricingSection.scrollIntoView({
                    behavior: "smooth"
                });

            }

        }
    );

}


// =========================================
// CLOSE NOTIFICATION
// =========================================

if (notificationClose) {

    notificationClose.addEventListener(
        "click",
        () => {

            // Cancel automatic timer
            if (notificationTimer) {

                clearTimeout(
                    notificationTimer
                );

                notificationTimer = null;

            }

            // Remove selected pricing card
            document
                .querySelectorAll(".pricing-card")
                .forEach((card) => {

                    card.classList.remove("selected");

                });


            // Reset pricing buttons
            document
                .querySelectorAll(".pricing-card button")
                .forEach((button) => {

                    button.classList.remove(
                        "selected-button"
                    );

                    if (button.dataset.originalText) {

                        button.textContent =
                            button.dataset.originalText;

                    }

                });


            // Close notification
            hideNotification();

        }
    );

}

    function showNotification(title, message) {

        if (
            !notification ||
            !notificationTitle ||
            !notificationMessage
        ) {

            console.error(
                "Finora notification elements are missing."
            );

            return;

        }


        // Cancel previous timer
        if (notificationTimer) {

            clearTimeout(notificationTimer);

        }


        notificationTitle.textContent =
            title;

        notificationMessage.textContent =
            message;


        // Show notification
        notification.classList.remove("hidden");

        notification.style.display =
            "block";

        notification.style.opacity =
            "0";

        notification.style.transform =
            "translateY(10px)";


 requestAnimationFrame(() => {

    notification.style.opacity =
        "1";

    notification.style.transform =
        "translateY(0)";

});


// Hide automatically
notificationTimer =
    setTimeout(() => {

        hideNotification();
        

    }, 4000);

}
    // Close notification manually
    if (notificationClose) {

        notificationClose.addEventListener(
            "click",
            () => {

                if (notificationTimer) {

                    clearTimeout(
                        notificationTimer
                    );

                }

                hideNotification();

            }
        );

    }


    // =========================================
    // STAGE 8 - CONTACT FORM
    // =========================================

    const contactForm =
        document.getElementById("contact-form");

    const nameInput =
        document.getElementById("name");

    const emailInput =
        document.getElementById("email");

    const messageInput =
        document.getElementById("message");


    // =========================================
    // FORM VALIDATION HELPERS
    // =========================================

    function setError(input) {

        if (!input) {
            return;
        }

        input.classList.remove(
            "form-success"
        );

        input.classList.add(
            "form-error"
        );

    }


    function setSuccess(input) {

        if (!input) {
            return;
        }

        input.classList.remove(
            "form-error"
        );

        input.classList.add(
            "form-success"
        );

    }


    function clearValidation(input) {

        if (!input) {
            return;
        }

        input.classList.remove(
            "form-error",
            "form-success"
        );

    }


    // =========================================
    // CONTACT FORM SUBMIT
    // =========================================

    if (
        contactForm &&
        nameInput &&
        emailInput &&
        messageInput
    ) {

        contactForm.addEventListener(
            "submit",
            (event) => {

                event.preventDefault();


                const name =
                    nameInput.value.trim();

                const email =
                    emailInput.value.trim();

                const message =
                    messageInput.value.trim();


                // Clear old validation
                clearValidation(nameInput);
                clearValidation(emailInput);
                clearValidation(messageInput);


                // =========================================
                // NAME VALIDATION
                // =========================================

                if (!name) {

                    setError(nameInput);

                    nameInput.focus();

                    showNotification(
                        "⚠ Name Required",
                        "Please enter your name."
                    );

                    return;

                }


                setSuccess(nameInput);


                // =========================================
                // EMAIL VALIDATION
                // =========================================

                const emailPattern =
                    /^[^\s@]+@[^\s@]+\.[^\s@]+$/;


                if (!emailPattern.test(email)) {

                    setError(emailInput);

                    emailInput.focus();

                    showNotification(
                        "⚠ Invalid Email",
                        "Please enter a valid email address."
                    );

                    return;

                }


                setSuccess(emailInput);


                // =========================================
                // MESSAGE VALIDATION
                // =========================================

                if (!message) {

                    setError(messageInput);

                    messageInput.focus();

                    showNotification(
                        "⚠ Message Required",
                        "Please enter your message."
                    );

                    return;

                }


                setSuccess(messageInput);


                // =========================================
                // SUCCESS
                // =========================================

                showNotification(
                    "✓ Message Sent!",
                    `Thanks ${name}, we'll be in touch soon.`
                );


                // Reset form
                contactForm.reset();


                // Remove success styling
                setTimeout(() => {

                    clearValidation(nameInput);
                    clearValidation(emailInput);
                    clearValidation(messageInput);

                }, 500);

            }
        );


        // =========================================
        // LIVE VALIDATION - NAME
        // =========================================

        nameInput.addEventListener(
            "input",
            () => {

                if (
                    nameInput.value.trim() === ""
                ) {

                    clearValidation(nameInput);

                } else {

                    setSuccess(nameInput);

                }

            }
        );


        // =========================================
        // LIVE VALIDATION - EMAIL
        // =========================================

        emailInput.addEventListener(
            "input",
            () => {

                const email =
                    emailInput.value.trim();


                if (email === "") {

                    clearValidation(emailInput);

                    return;

                }


                const emailPattern =
                    /^[^\s@]+@[^\s@]+\.[^\s@]+$/;


                if (
                    emailPattern.test(email)
                ) {

                    setSuccess(emailInput);

                } else {

                    setError(emailInput);

                }

            }
        );


        // =========================================
        // LIVE VALIDATION - MESSAGE
        // =========================================

        messageInput.addEventListener(
            "input",
            () => {

                if (
                    messageInput.value.trim() === ""
                ) {

                    clearValidation(messageInput);

                } else {

                    setSuccess(messageInput);

                }

            }
        );

    }


    // =========================================
    // STAGE 6 - SCROLL REVEAL
    // =========================================

    const revealElements =
        document.querySelectorAll(".reveal");


    function revealOnScroll() {

        revealElements.forEach((element) => {

            const elementTop =
                element.getBoundingClientRect().top;


            if (
                elementTop <
                window.innerHeight - 100
            ) {

                element.classList.add(
                    "active"
                );

            }

        });

    }


    window.addEventListener(
        "scroll",
        revealOnScroll
    );


    revealOnScroll();


    // =========================================
    // STAGE 6 - ACTIVE NAVIGATION
    // =========================================

    const sections =
        document.querySelectorAll(
            "main section[id]"
        );

    const navLinks =
        document.querySelectorAll(
            ".nav-link"
        );


    function updateActiveNav() {

        let currentSection = "";


        sections.forEach((section) => {

            const sectionTop =
                section.offsetTop - 150;

            const sectionHeight =
                section.offsetHeight;


            if (
                window.scrollY >= sectionTop &&
                window.scrollY <
                sectionTop + sectionHeight
            ) {

                currentSection =
                    section.getAttribute("id");

            }

        });


        navLinks.forEach((link) => {

            link.classList.remove(
                "text-emerald-500",
                "active"
            );


            if (
                link.getAttribute("href") ===
                `#${currentSection}`
            ) {

                link.classList.add(
                    "text-emerald-500",
                    "active"
                );

            }

        });

    }


    window.addEventListener(
        "scroll",
        updateActiveNav
    );


    updateActiveNav();


    // =========================================
    // MOBILE MENU AUTO CLOSE
    // =========================================

    const mobileNavLinks =
        document.querySelectorAll(
            "#mobile-menu a"
        );


    mobileNavLinks.forEach((link) => {

        link.addEventListener(
            "click",
            () => {

                if (mobileMenu) {

                    mobileMenu.classList.add(
                        "hidden"
                    );

                }

            }
        );

    });
    

    // =========================================
// STAGE 12 - GET STARTED BUTTON
// =========================================

const getStartedButtons =
    document.querySelectorAll(".get-started-btn");


getStartedButtons.forEach((button) => {

    button.addEventListener("click", () => {

        const contactSection =
            document.getElementById("contact");

        const nameInput =
            document.getElementById("name");


        // Scroll to Contact
        if (contactSection) {

            contactSection.scrollIntoView({
                behavior: "smooth"
            });

        }


        // Focus Name field after scrolling
        if (nameInput) {

            setTimeout(() => {

                nameInput.focus();

            }, 700);

        }

    });

});

    // =========================================
    // STAGE 7 - PRICING PLAN BUTTONS
    // =========================================

    const starterButton =
        document.getElementById(
            "starter-button"
        );

    const plusButton =
        document.getElementById(
            "plus-button"
        );

    const proButton =
        document.getElementById(
            "pro-button"
        );


   // =========================================
// STAGE 10 - SELECTED PRICING BUTTON
// =========================================

function setSelectedPricingCard(activeButton) {

    // Remove selected state from all cards
    document
        .querySelectorAll(".pricing-card")
        .forEach((card) => {

            card.classList.remove("selected");

        });


    // Reset all pricing buttons
    document
        .querySelectorAll(".pricing-card button")
        .forEach((button) => {

            button.classList.remove("selected-button");

            button.textContent =
                button.dataset.originalText ||
                button.textContent;

        });


    // Find selected card
    const selectedCard =
        activeButton?.closest(".pricing-card");


    if (selectedCard) {

        // Highlight selected card
        selectedCard.classList.add("selected");

    }


    if (activeButton) {

        // Save original button text
        if (!activeButton.dataset.originalText) {

            activeButton.dataset.originalText =
                activeButton.textContent.trim();

        }


        // Highlight button
        activeButton.classList.add(
            "selected-button"
        );


        // Change button text
        activeButton.textContent =
            "✓ Selected";

    }

}


    // Starter
    if (starterButton) {

        starterButton.addEventListener(
            "click",
            () => {

                setSelectedPricingCard(starterButton);

                showNotification(
                    "✓ Starter Plan Selected!",
                    "You've selected the Starter plan. Let's get started!"
                );

            }
        );

    }


    // Plus
    if (plusButton) {

        plusButton.addEventListener(
            "click",
            () => {

                setSelectedPricingCard(plusButton);

                showNotification(
                    "✓ Plus Plan Selected!",
                    "You've selected the Plus plan for ₹299/month."
                );

            }
        );

    }


    // Pro
    if (proButton) {

        proButton.addEventListener(
            "click",
            () => {

                setSelectedPricingCard(proButton);

                showNotification(
                    "✓ Pro Plan Selected!",
                    "You've selected the Pro plan for ₹599/month."
                );

            }
        );

    }

});