const cityInput = document.getElementById('cityInput');
const searchBtn = document.getElementById('searchBtn');
const resultDiv = document.getElementById('result');
const errorDiv = document.getElementById('error');
const locationEl = document.getElementById('location');
const tempEl = document.getElementById('temp');
const condEl = document.getElementById('condition');

searchBtn.addEventListener('click', () => {
  const city = cityInput.value.trim();
  if (!city) {
    showError('Please enter a city name');
    return;
  }
  fetchWeather(city);
});

async function fetchWeather(city) {
  try {
    const url = `https://api.weatherapi.com/v1/current.json?key=${WEATHER_KEY}&q=${encodeURIComponent(city)}`;
    const res = await fetch(url);

    if (!res.ok) throw new Error('City not found or API error');

    const data = await res.json();
    showResult(data);
  } catch (err) {
    showError(err.message || 'Something went wrong');
  }
}

function showResult(data) {
  errorDiv.classList.add('hidden');
  resultDiv.classList.remove('hidden');
  locationEl.textContent = `${data.location.name}, ${data.location.country}`;
  tempEl.textContent = `🌡️ Temperature: ${data.current.temp_c} °C`;
  condEl.textContent = `🌥️ Condition: ${data.current.condition.text}`;
}

function showError(msg) {
  resultDiv.classList.add('hidden');
  errorDiv.classList.remove('hidden');
  errorDiv.textContent = msg;
}
