const cityInput = document.getElementById("city-input");
const checkBtn = document.getElementById("check-weather");
const loadingEl = document.getElementById("loading");
const errorEl = document.getElementById("error");

const cardEl = document.getElementById("weather-card");
const cityNameEl = document.getElementById("city-name");
const descEl = document.getElementById("weather-desc");
const tempEl = document.getElementById("temp");
const feelsEl = document.getElementById("feels-like");
const humidityEl = document.getElementById("humidity");

const BASE_URL = "https://api.openweathermap.org/data/2.5/weather";

function setLoading(isLoading) {
  loadingEl.classList.toggle("hidden", !isLoading);
}

function showError(message) {
  if (!message) {
    errorEl.classList.add("hidden");
    errorEl.textContent = "";
  } else {
    errorEl.classList.remove("hidden");
    errorEl.textContent = message;
  }
}

function showWeather(data) {
  const { name, main, weather } = data;

  cityNameEl.textContent = name;
  descEl.textContent = weather[0]?.description ?? "No description";
  tempEl.textContent = `${main.temp.toFixed(1)} °C`;
  feelsEl.textContent = `${main.feels_like.toFixed(1)} °C`;
  humidityEl.textContent = `${main.humidity} %`;

  cardEl.classList.remove("hidden");
}

async function fetchWeather(city) {
  const url = `${BASE_URL}?q=${encodeURIComponent(
    city
  )}&appid=${OPENWEATHER_API_KEY}&units=metric`;

  setLoading(true);
  showError("");
  cardEl.classList.add("hidden");

  try {
    const res = await fetch(url);

    if (!res.ok) {
      if (res.status === 404) {
        throw new Error("City not found. Please check the name.");
      }
      if (res.status === 401) {
        throw new Error("Invalid API key. Please verify config.js.");
      }
      throw new Error("Something went wrong while fetching weather.");
    }

    const data = await res.json();
    showWeather(data);
  } catch (err) {
    showError(err.message || "Network error. Please try again.");
  } finally {
    setLoading(false);
  }
}

checkBtn.addEventListener("click", () => {
  const city = cityInput.value.trim();

  if (!city) {
    showError("Please enter a city name.");
    cardEl.classList.add("hidden");
    return;
  }

  fetchWeather(city);
});


cityInput.addEventListener("keydown", (e) => {
  if (e.key === "Enter") {
    checkBtn.click();
  }
});
