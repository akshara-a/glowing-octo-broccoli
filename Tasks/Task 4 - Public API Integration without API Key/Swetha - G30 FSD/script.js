const WEATHER_CODES = {
  0: "Clear sky",
  1: "Mainly clear",
  2: "Partly cloudy",
  3: "Overcast",
  45: "Fog",
  48: "Depositing rime fog",
  51: "Light drizzle",
  53: "Moderate drizzle",
  55: "Dense drizzle",
  61: "Slight rain",
  63: "Moderate rain",
  65: "Heavy rain",
  71: "Slight snowfall",
  73: "Moderate snowfall",
  75: "Heavy snowfall",
  80: "Rain showers",
  81: "Heavy rain showers",
  95: "Thunderstorm",
  96: "Thunderstorm with slight hail",
  99: "Thunderstorm with heavy hail"
};

const form = document.getElementById("weather-form");
const statusEl = document.getElementById("status");
const resultCard = document.getElementById("result-card");
const tempValue = document.getElementById("temp-value");
const windValue = document.getElementById("wind-value");
const conditionValue = document.getElementById("condition-value");

form.addEventListener("submit", async (event) => {
  event.preventDefault();

  const lat = document.getElementById("lat").value.trim();
  const lon = document.getElementById("lon").value.trim();

  if (!lat || !lon) {
    statusEl.textContent = "Please enter both latitude and longitude.";
    resultCard.classList.add("hidden");
    return;
  }

  const apiUrl = `https://api.open-meteo.com/v1/forecast?latitude=${lat}&longitude=${lon}&current_weather=true`;

  statusEl.textContent = "Fetching weather data...";
  resultCard.classList.add("hidden");

  try {
    const response = await fetch(apiUrl);

    if (!response.ok) {
      throw new Error("API error");
    }

    const data = await response.json();
    const current = data.current_weather;

    if (!current) {
      throw new Error("No current weather data.");
    }

    const temperature = current.temperature;
    const windspeed = current.windspeed;
    const code = current.weathercode;

    const conditionText =
      WEATHER_CODES[code] !== undefined
        ? `${WEATHER_CODES[code]} (code ${code})`
        : `Unknown (code ${code})`;

    tempValue.textContent = temperature;
    windValue.textContent = windspeed;
    conditionValue.textContent = conditionText;

    statusEl.textContent = "Weather data updated.";
    resultCard.classList.remove("hidden");
  } catch (error) {
    statusEl.textContent = "Failed to fetch weather. Please try again.";
    resultCard.classList.add("hidden");
  }
});
