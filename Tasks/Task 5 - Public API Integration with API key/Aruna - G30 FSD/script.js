// JS uses the WEATHER_KEY from config.js

// Elements
const cityInput = document.getElementById("cityInput");
const getWeatherBtn = document.getElementById("getWeatherBtn");
const loading = document.getElementById("weatherLoading");
const error = document.getElementById("weatherError");
const result = document.getElementById("weatherResult");

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

  // Build URL dynamically for user-entered city
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

      // Populate the result
      document.getElementById("city").textContent = data.location.name + ", " + data.location.country;
      document.getElementById("temp").textContent = data.current.temp_c + "°C";
      document.getElementById("humidity").textContent = data.current.humidity + "%";
      document.getElementById("feels").textContent = data.current.feelslike_c + "°C";
      document.getElementById("desc").textContent = data.current.condition.text;

      result.classList.remove("hidden");
    })
    .catch(() => {
      loading.classList.add("hidden");
      error.textContent = "Failed to fetch weather!";
      error.classList.remove("hidden");
    });
});
