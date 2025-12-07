// config.js must already have: const WEATHER_KEY = "YOUR_KEY";

// Elements
const cityInput = document.getElementById("cityInput");
const getWeatherBtn = document.getElementById("getWeatherBtn");
const loading = document.getElementById("weatherLoading");
const error = document.getElementById("weatherError");
const result = document.getElementById("weatherResult");
const container = document.querySelector('.container');

getWeatherBtn.addEventListener("click", () => {
  const city = cityInput.value.trim();

  if (!city) {
    error.textContent = "Please enter a city!";
    error.classList.remove("hidden");
    return;
  }

  loading.classList.remove("hidden");
  error.classList.add("hidden");
  result.classList.add("hidden");

  const url = `https://api.weatherapi.com/v1/current.json?key=${WEATHER_KEY}&q=${encodeURIComponent(city)}`;

  fetch(url)
    .then(res => res.json())
    .then(data => {
      loading.classList.add("hidden");

      if (data.error) {
        error.textContent = data.error.message || "City not found!";
        error.classList.remove("hidden");
        return;
      }

      // Populate results
      document.getElementById("city").textContent = data.location.name + ", " + data.location.country;
      document.getElementById("temp").textContent = data.current.temp_c + "°C";
      document.getElementById("humidity").textContent = data.current.humidity + "%";
      document.getElementById("feels").textContent = data.current.feelslike_c + "°C";
      document.getElementById("desc").textContent = data.current.condition.text;

      // Dynamic background
      const condition = data.current.condition.text.toLowerCase();
      if (condition.includes("sun")) {
        container.style.background = "linear-gradient(to bottom, #fceabb, #f8b500)"; // sunny yellow
      } else if (condition.includes("rain")) {
        container.style.background = "linear-gradient(to bottom, #a1c4fd, #c2e9fb)"; // rainy blue
      } else if (condition.includes("cloud")) {
        container.style.background = "linear-gradient(to bottom, #d7d2cc, #304352)"; // cloudy gray
      } else if (condition.includes("snow")) {
        container.style.background = "linear-gradient(to bottom, #e0f7fa, #90caf9)"; // snowy light blue
      } else {
        container.style.background = "#f1f5ff"; // default
      }

      result.classList.remove("hidden");
    })
    .catch(() => {
      loading.classList.add("hidden");
      error.textContent = "Failed to fetch weather!";
      error.classList.remove("hidden");
    });
});
