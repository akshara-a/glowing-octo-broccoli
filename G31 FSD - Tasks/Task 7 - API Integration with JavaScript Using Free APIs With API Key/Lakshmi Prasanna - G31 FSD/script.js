const API_KEY = 'c9dd19f99dc3bd5286ceb202d169dc9f';

const input = document.getElementById('cityInput');
const searchBtn = document.getElementById('searchBtn');
const loading = document.getElementById('loading');
const error = document.getElementById('error');
const result = document.getElementById('result');

searchBtn.addEventListener('click', fetchWeather);
input.addEventListener('keypress', (e) => {
  if (e.key === 'Enter') fetchWeather();
});

async function fetchWeather() {
  const city = input.value.trim();
  if (!city) return;

  loading.textContent = ' Loading...';
  error.textContent = '';
  result.innerHTML = '';

  try {
    const response = await fetch(
      `https://api.openweathermap.org/data/2.5/weather?q=${city}&appid=${API_KEY}&units=metric`
    );
    if (!response.ok) throw new Error('City not found');
    const data = await response.json();

    loading.textContent = '';

    const icon = `https://openweathermap.org/img/wn/${data.weather[0].icon}@2x.png`;

    result.innerHTML = `
      <div class="weather-card">
        <h2>${data.name}, ${data.sys.country}</h2>
        <img src="${icon}" alt="weather icon">
        <h3>${data.weather[0].description.toUpperCase()}</h3>
        <p class="temp">${data.main.temp}°C</p>
        <div class="info-grid">
          <div class="info-item">
            <p>Feels Like</p>
            <p>${data.main.feels_like}°C</p>
          </div>
          <div class="info-item">
            <p>Humidity</p>
            <p>${data.main.humidity}%</p>
          </div>
          <div class="info-item">
            <p>Wind Speed</p>
            <p>${data.wind.speed} m/s</p>
          </div>
          <div class="info-item">
            <p>Pressure</p>
            <p>${data.main.pressure} hPa</p>
          </div>
        </div>
      </div>
    `;

  } catch {
    loading.textContent = '';
    error.textContent = ' City not found! Please try again.';
  }
}
