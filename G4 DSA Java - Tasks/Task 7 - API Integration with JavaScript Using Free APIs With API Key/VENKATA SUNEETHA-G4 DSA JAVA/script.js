/* ==========================================================================
   Weather Station — script.js
   Fetches current weather from OpenWeatherMap and renders the readout panel.
   Requires config.js to define a global API_KEY (see config.example.js).
   ========================================================================== */

// ---- DOM references ----------------------------------------------------
const form          = document.getElementById('searchForm');
const cityInput     = document.getElementById('cityInput');
const searchButton  = document.getElementById('searchButton');
const errorMsg      = document.getElementById('errorMsg');

const loadingState  = document.getElementById('loadingState');
const emptyState     = document.getElementById('emptyState');
const dataState      = document.getElementById('dataState');

const tempEl        = document.getElementById('temp');
const cityNameEl     = document.getElementById('cityName');
const conditionEl    = document.getElementById('condition');
const humidityEl     = document.getElementById('humidity');
const windEl          = document.getElementById('wind');
const descriptionEl   = document.getElementById('description');
const countryEl       = document.getElementById('country');

const humidityArc     = document.getElementById('humidityArc');
const humidityNeedle   = document.getElementById('humidityNeedle');
const windArc          = document.getElementById('windArc');
const windNeedle       = document.getElementById('windNeedle');

const clockEl = document.getElementById('clock');

// ---- Config check -------------------------------------------------------
// config.js should define: const API_KEY = "your_api_key_here";
const HAS_KEY = typeof API_KEY !== 'undefined' && API_KEY && API_KEY !== 'PASTE_YOUR_API_KEY_HERE';

const BASE_URL = 'https://api.openweathermap.org/data/2.5/weather';

// A gauge maxes out its arc/needle sweep at these values.
const HUMIDITY_MAX = 100; // percent
const WIND_MAX      = 20;  // m/s, generous upper bound for typical readings

// ---- Clock (small ambient detail, purely decorative) --------------------
function tickClock() {
  const now = new Date();
  clockEl.textContent = now.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit', second: '2-digit' });
}
tickClock();
setInterval(tickClock, 1000);

// ---- State helpers -------------------------------------------------------
function showState(state) {
  loadingState.hidden = state !== 'loading';
  emptyState.hidden   = state !== 'empty';
  dataState.hidden    = state !== 'data';
}

function setError(message) {
  errorMsg.textContent = message || '';
}

// ---- Gauge rendering -------------------------------------------------------
// Arc length is 157 (approx. semicircle perimeter for our path geometry).
// Needle sweeps from -90deg (min, pointing left) to +90deg (max, pointing right).
function setGauge(arcEl, needleEl, value, max) {
  const ratio = Math.max(0, Math.min(1, value / max));
  const arcLength = 157;
  arcEl.style.strokeDashoffset = String(arcLength - arcLength * ratio);
  const angle = -90 + ratio * 180;
  needleEl.style.transform = `rotate(${angle}deg)`;
}

// ---- Rendering -------------------------------------------------------
function renderWeather(data) {
  const temp        = Math.round(data.main.temp);
  const humidity     = data.main.humidity;
  const wind          = data.wind.speed;
  const condition     = data.weather[0].main;
  const description    = data.weather[0].description;

  tempEl.textContent        = temp;
  cityNameEl.textContent     = data.name;
  conditionEl.textContent    = condition;
  humidityEl.textContent     = humidity;
  windEl.textContent          = wind;
  descriptionEl.textContent   = description;
  countryEl.textContent       = data.sys && data.sys.country ? data.sys.country : '—';

  setGauge(humidityArc, humidityNeedle, humidity, HUMIDITY_MAX);
  setGauge(windArc, windNeedle, wind, WIND_MAX);

  showState('data');
}

// ---- Fetch logic -------------------------------------------------------
async function fetchWeather(city) {
  setError('');
  showState('loading');
  searchButton.disabled = true;

  try {
    const url = `${BASE_URL}?q=${encodeURIComponent(city)}&appid=${API_KEY}&units=metric`;
    const response = await fetch(url);

    if (response.status === 404) {
      throw new Error('City not found');
    }
    if (response.status === 401) {
      throw new Error('Invalid API key or request failed');
    }
    if (!response.ok) {
      throw new Error('Unable to fetch weather data');
    }

    const data = await response.json();
    renderWeather(data);

  } catch (err) {
    showState('empty');
    if (err instanceof TypeError) {
      // fetch() throws TypeError on network failure (e.g. offline, CORS)
      setError('Unable to fetch weather data');
    } else {
      setError(err.message || 'Unable to fetch weather data');
    }
  } finally {
    searchButton.disabled = false;
  }
}

// ---- Event wiring -------------------------------------------------------
form.addEventListener('submit', (e) => {
  e.preventDefault();

  if (!HAS_KEY) {
    setError('No API key configured — add one to config.js (see README.md)');
    showState('empty');
    return;
  }

  const city = cityInput.value.trim();
  if (!city) {
    setError('Please enter a city name');
    return;
  }

  fetchWeather(city);
});

// Initial state
showState('empty');
if (!HAS_KEY) {
  setError('No API key configured — add one to config.js (see README.md)');
}
