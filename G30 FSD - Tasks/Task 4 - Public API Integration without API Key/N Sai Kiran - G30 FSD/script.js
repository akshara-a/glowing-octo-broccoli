const latInput = document.getElementById('lat');
const lonInput = document.getElementById('lon');
const btn = document.getElementById('getWeatherBtn');

const tempEl = document.getElementById('temp');
const windEl = document.getElementById('wind');
const condEl = document.getElementById('condition');

const loadingEl = document.getElementById('loading');
const errorEl = document.getElementById('error');
const resultSection = document.getElementById('result');
const metaText = document.getElementById('metaText');

const weatherCodeMap = {
  0: 'Clear sky',
  1: 'Mainly clear',
  2: 'Partly cloudy',
  3: 'Overcast',
  45: 'Fog',
  48: 'Depositing rime fog',
  51: 'Light drizzle',
  53: 'Moderate drizzle',
  55: 'Dense drizzle',
  61: 'Slight rain',
  63: 'Moderate rain',
  65: 'Heavy rain',
  71: 'Slight snow fall',
  73: 'Moderate snow fall',
  75: 'Heavy snow fall',
  80: 'Rain showers',
  81: 'Moderate rain showers',
  82: 'Violent rain showers',
  95: 'Thunderstorm',
  96: 'Thunderstorm with slight hail',
  99: 'Thunderstorm with heavy hail'
};

function showLoading(show = true) {
  loadingEl.classList.toggle('hidden', !show);
}

function showError(msg) {
  if (!msg) {
    errorEl.classList.add('hidden');
    errorEl.textContent = '';
    return;
  }
  errorEl.textContent = msg;
  errorEl.classList.remove('hidden');
}

function renderWeather(current, latitude, longitude) {
  if (!current) return;

  const temp = current.temperature;            
  const wind = current.windspeed;              
  const code = current.weathercode;            
  const time = current.time;                   

  tempEl.textContent = `${temp} °C`;
  windEl.textContent = `${wind} km/h`;
  condEl.textContent = weatherCodeMap[code] || `Code ${code}`;

  metaText.textContent = `As of ${time} • Lat ${latitude}, Lon ${longitude}`;
  resultSection.classList.remove('hidden');
}

function buildApiUrl(latitude, longitude) {
  const base = 'https://api.open-meteo.com/v1/forecast';
  const params = new URLSearchParams({
    latitude: latitude,
    longitude: longitude,
    current_weather: 'true'
  });
  return `${base}?${params.toString()}`;
}

async function fetchWeather() {
  const latitude = parseFloat(latInput.value);
  const longitude = parseFloat(lonInput.value);

  if (Number.isNaN(latitude) || Number.isNaN(longitude)) {
    showError('Please enter valid numeric latitude and longitude.');
    return;
  }

  showError(null);
  showLoading(true);

  const url = buildApiUrl(latitude, longitude);

  try {
    const res = await fetch(url, { cache: 'no-store' });
    if (!res.ok) {
      throw new Error`(Network response was not OK (${res.status}))`;
    }

    const data = await res.json();

    if (!data || !data.current_weather) {
      throw new Error('Unexpected API response: missing current_weather');
    }

    renderWeather(data.current_weather, latitude, longitude);
  } catch (err) {
    console.error('Fetch error:', err);
    showError('Failed to fetch weather data. ' + (err.message || ''));
  } finally {
    showLoading(false);
  }
}

btn.addEventListener('click', fetchWeather);