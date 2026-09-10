// ================= MOBILE MENU =================

const menuBtn = document.getElementById("menuBtn");
const mobileMenu = document.getElementById("mobileMenu");

menuBtn.addEventListener("click", () => {
    mobileMenu.classList.toggle("hidden");
});


// ================= DARK MODE =================

const darkModeBtn = document.getElementById("darkModeBtn");
const mobileDarkModeBtn = document.getElementById("mobileDarkModeBtn");

function toggleDarkMode() {
    document.documentElement.classList.toggle("dark");

    const isDark = document.documentElement.classList.contains("dark");

    localStorage.setItem("darkMode", isDark);
}

darkModeBtn.addEventListener("click", toggleDarkMode);
mobileDarkModeBtn.addEventListener("click", toggleDarkMode);


// Load saved dark mode

const savedDarkMode = localStorage.getItem("darkMode");

if (savedDarkMode === "true") {
    document.documentElement.classList.add("dark");
}


// ================= CONTACT FORM =================

const contactForm = document.getElementById("contactForm");
const formMessage = document.getElementById("formMessage");

contactForm.addEventListener("submit", function (event) {

    event.preventDefault();

    formMessage.textContent =
        "Thank you! Your message has been received.";

    contactForm.reset();

    setTimeout(() => {
        formMessage.textContent = "";
    }, 4000);
});