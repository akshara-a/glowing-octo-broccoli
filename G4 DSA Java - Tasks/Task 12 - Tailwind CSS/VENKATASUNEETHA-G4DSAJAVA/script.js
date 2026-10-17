// Initialize Lucide icons
lucide.createIcons();


// ================= MOBILE MENU =================

const menuButton = document.getElementById("menu-btn");
const mobileMenu = document.getElementById("mobile-menu");

menuButton.addEventListener("click", () => {

    mobileMenu.classList.toggle("hidden");

});


// Close mobile menu when a link is clicked

const mobileLinks = mobileMenu.querySelectorAll("a");

mobileLinks.forEach(link => {

    link.addEventListener("click", () => {

        mobileMenu.classList.add("hidden");

    });

});


// ================= DARK MODE =================

function toggleDarkMode() {

    document.documentElement.classList.toggle("dark");

    const isDark =
        document.documentElement.classList.contains("dark");

    localStorage.setItem("darkMode", isDark);

}


// Load saved dark mode preference

if (localStorage.getItem("darkMode") === "true") {

    document.documentElement.classList.add("dark");

}


// ================= CONTACT FORM =================

const contactForm =
    document.getElementById("contact-form");

contactForm.addEventListener("submit", function(event) {

    event.preventDefault();

    alert("Thank you! Your message has been submitted.");

    contactForm.reset();

});