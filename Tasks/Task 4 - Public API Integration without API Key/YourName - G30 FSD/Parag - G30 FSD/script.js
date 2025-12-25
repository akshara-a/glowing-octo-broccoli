// ✅ STATIC WEATHER DATA (ALWAYS SAME)
const staticWeather = {
  city: "Hyderabad",
  temperature: 32,
  feelsLike: 35,
  humidity: 58,
  wind: 12,
  condition: "Partly Cloudy"
};


const cityEl = document.getElementById("city");
const tempEl = document.getElementById("temp");
const condEl = document.getElementById("condition");
const windEl = document.getElementById("wind");
const humEl = document.getElementById("humidity");
const feelsEl = document.getElementById("feels");
const timeEl = document.getElementById("time");
const btn = document.getElementById("btn");


function showWeather() {
  cityEl.textContent = staticWeather.city;
  tempEl.textContent = staticWeather.temperature;
  feelsEl.textContent = `${staticWeather.feelsLike}°C`;
  humEl.textContent = `${staticWeather.humidity}%`;
  windEl.textContent = `${staticWeather.wind} km/h`;
  condEl.textContent = staticWeather.condition;

  timeEl.textContent = new Date().toLocaleTimeString([], {
    hour: "2-digit",
    minute: "2-digit"
  });
}


showWeather();


btn.addEventListener("click", showWeather);
