// script.js
import { OPENWEATHER_API_KEY } from "./config.js";

document.addEventListener('DOMContentLoaded', () => {
  const cityInput = document.getElementById('cityInput');
  const getCityWeatherBtn = document.getElementById('getCityWeatherBtn');

  const weatherLoading = document.getElementById('weatherLoading');
  const weatherError = document.getElementById('weatherError');
  const weatherResult = document.getElementById('weatherResult');

  const ow_temp = document.getElementById('ow_temp');
  const ow_feels = document.getElementById('ow_feels');
  const ow_humidity = document.getElementById('ow_humidity');
  const ow_desc = document.getElementById('ow_desc');

  function show(el, yes = true) { el.classList.toggle('hidden', !yes); }
  function showError(el, msg) {
    if (!msg) return show(el, false);
    el.textContent = msg; show(el, true);
  }

  async function fetchCityWeather() {
    const city = (cityInput.value || '').trim();
    if (!city) { showError(weatherError, 'Please enter a city name.'); return; }

    showError(weatherError, null);
    show(weatherResult, false);
    show(weatherLoading, true);

    try {
      // build a valid OpenWeather "current weather" URL (units=metric)
      const url = `https://api.openweathermap.org/data/2.5/weather?q=${encodeURIComponent(city)}&appid=${OPENWEATHER_API_KEY}&units=metric`;

      console.log('Fetching URL:', url); // helpful when debugging locally
      const resp = await fetch(url, { cache: 'no-store' });

      if (!resp.ok) {
        // try to read text error for clearer message
        const errText = await resp.text().catch(() => resp.statusText);
        throw new Error(errText || `HTTP ${resp.status}`);
      }

      const data = await resp.json();
      console.log('OpenWeather response:', data);

      // map values (works for OpenWeather current weather structure)
      ow_temp.textContent = (data.main?.temp ?? '--');
      ow_feels.textContent = (data.main?.feels_like ?? '--');
      ow_humidity.textContent = (data.main?.humidity ?? '--');
      ow_desc.textContent = (data.weather?.[0]?.description ?? '--');

      show(weatherResult, true);
    } catch (err) {
      console.error('Weather error', err);
      // show a short, user-friendly message; include err.message for debugging
      showError(weatherError, 'Failed to fetch weather: ' + (err.message || 'Unknown'));
    } finally {
      show(weatherLoading, false);
    }
  }

  getCityWeatherBtn.addEventListener('click', fetchCityWeather);
  cityInput.addEventListener('keyup', (e) => { if (e.key === 'Enter') fetchCityWeather(); });

  console.log('script.js module loaded — ready');
});
