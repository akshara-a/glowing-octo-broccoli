// script.js — WeatherAPI Integration
// Uses apiKey.js -> CONFIG.WEATHERAPI_KEY
console.log("CONFIG:", window.CONFIG);

(() => {
  const BASE_URL = "https://api.weatherapi.com/v1/current.json";
  const DEFAULT_CITY = "Kolkata";

  const cityInput = document.getElementById("city-input");
  const getWeatherBtn = document.getElementById("get-weather-btn");
  const weatherResultDiv = document.getElementById("weather-result");

  const WEATHER_KEY =
    window.CONFIG && CONFIG.WEATHERAPI_KEY
      ? CONFIG.WEATHERAPI_KEY
      : null;

  // If API key missing
  if (!WEATHER_KEY) {
    weatherResultDiv.innerHTML =
      `<p class="error">API Key missing. Please add apiKey.js file.</p>`;
    getWeatherBtn.disabled = true;
    return;
  }

  function showLoading(city) {
    weatherResultDiv.innerHTML =
      `<p>Loading weather for <strong>${city}</strong>...</p>`;
    getWeatherBtn.disabled = true;
  }

  function showError(message) {
    weatherResultDiv.innerHTML =
      `<p class="error">${message}</p>`;
  }

  function displayWeather(data) {
    const { location, current } = data;

    weatherResultDiv.innerHTML = `
      <div class="weather-data">
        <p class="city-name">${location.name}, ${location.country}</p>

        <div style="display:flex; align-items:center;">
          <img class="weather-icon"
               src="https:${current.condition.icon}"
               alt="${current.condition.text}">
          <p class="temp-main">${current.temp_c}°C</p>
        </div>

        <p class="description">
          <strong>Condition:</strong> ${current.condition.text}
        </p>
        <p><strong>Feels Like:</strong> ${current.feelslike_c}°C</p>
        <p><strong>Humidity:</strong> ${current.humidity}%</p>
      </div>
    `;
  }

  async function fetchWeather(city) {
    showLoading(city);

    const url = `${BASE_URL}?key=${WEATHER_KEY}&q=${city}&aqi=yes`;

    try {
      const response = await fetch(url);
      const data = await response.json();

      if (data.error) {
        showError(data.error.message);
      } else {
        displayWeather(data);
      }
    } catch (error) {
      showError("Network error. Please try again.");
    } finally {
      getWeatherBtn.disabled = false;
    }
  }

  function handleWeatherRequest() {
    const city = cityInput.value.trim() || DEFAULT_CITY;
    fetchWeather(city);
  }

  getWeatherBtn.addEventListener("click", handleWeatherRequest);

  cityInput.addEventListener("keypress", (e) => {
    if (e.key === "Enter") handleWeatherRequest();
  });

  // Load default city on page load
  document.addEventListener("DOMContentLoaded", () => {
    fetchWeather(DEFAULT_CITY);
  });
})();
