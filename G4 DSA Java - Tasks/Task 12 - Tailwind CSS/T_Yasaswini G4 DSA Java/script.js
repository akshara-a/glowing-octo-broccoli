// Mobile navigation
const menuButton = document.getElementById("menuButton");
const mobileMenu = document.getElementById("mobileMenu");

menuButton.addEventListener("click", () => {
  mobileMenu.classList.toggle("hidden");
});

// Close mobile menu after clicking a link
document.querySelectorAll(".mobile-link").forEach((link) => {
  link.addEventListener("click", () => {
    mobileMenu.classList.add("hidden");
  });
});


// Dark mode
const themeToggle = document.getElementById("themeToggle");
const mobileThemeToggle = document.getElementById("mobileThemeToggle");

function toggleDarkMode() {
  document.documentElement.classList.toggle("dark");

  const isDark = document.documentElement.classList.contains("dark");

  localStorage.setItem("theme", isDark ? "dark" : "light");
}

themeToggle.addEventListener("click", toggleDarkMode);
mobileThemeToggle.addEventListener("click", toggleDarkMode);


// Remember theme preference
if (localStorage.getItem("theme") === "dark") {
  document.documentElement.classList.add("dark");
}


// Contact form
const contactForm = document.getElementById("contactForm");
const formMessage = document.getElementById("formMessage");

contactForm.addEventListener("submit", (event) => {
  event.preventDefault();

  formMessage.classList.remove("hidden");
  contactForm.reset();

  setTimeout(() => {
    formMessage.classList.add("hidden");
  }, 4000);
});