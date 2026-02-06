const btn = document.getElementById("btn");
const tempUI = document.getElementById("temp");
const windUI = document.getElementById("wind");
const codeUI = document.getElementById("code");

const API_URL =
  "https://api.open-meteo.com/v1/forecast?latitude=17.385&longitude=78.4867&current_weather=true";

async function getWeather() {
  try {
    const response = await fetch(API_URL);
    const data = await response.json();
    const w = data.current_weather;

    tempUI.textContent = w.temperature + " °C";
    windUI.textContent = w.windspeed + " km/h";
    codeUI.textContent = w.weathercode;
    
  } catch (err) {
    codeUI.textContent = "Error loading data";
  }
}

btn.addEventListener("click", getWeather);
