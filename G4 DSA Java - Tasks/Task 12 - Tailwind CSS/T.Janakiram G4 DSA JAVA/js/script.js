// Mobile navigation toggle logic
const menuBtn = document.getElementById('menu-btn');
const mobileMenu = document.getElementById('mobile-menu');
const mobileLinks = document.querySelectorAll('.mobile-link');

menuBtn.addEventListener('click', () => {
  mobileMenu.classList.toggle('hidden');
});

// Close mobile menu when a nav link is clicked
mobileLinks.forEach((link) => {
  link.addEventListener('click', () => {
    mobileMenu.classList.add('hidden');
  });
});

// Dark Mode Toggle Logic
const themeToggle = document.getElementById('theme-toggle');
const mobileThemeToggle = document.getElementById('mobile-theme-toggle');
const themeIcon = document.getElementById('theme-icon');
const mobileThemeIcon = document.getElementById('mobile-theme-icon');

function updateIcons(isDark) {
  const icon = isDark ? '☀️' : '🌙';
  if (themeIcon) themeIcon.textContent = icon;
  if (mobileThemeIcon) mobileThemeIcon.textContent = icon;
}

function toggleTheme() {
  const isDark = document.documentElement.classList.toggle('dark');
  localStorage.setItem('theme', isDark ? 'dark' : 'light');
  updateIcons(isDark);
}

themeToggle.addEventListener('click', toggleTheme);
mobileThemeToggle.addEventListener('click', toggleTheme);

// Initialize theme on load
(() => {
  const savedTheme = localStorage.getItem('theme');
  const prefersDark = window.matchMedia('(prefers-color-scheme: dark)').matches;
  if (savedTheme === 'dark' || (!savedTheme && prefersDark)) {
    document.documentElement.classList.add('dark');
    updateIcons(true);
  } else {
    document.documentElement.classList.remove('dark');
    updateIcons(false);
  }
})();
