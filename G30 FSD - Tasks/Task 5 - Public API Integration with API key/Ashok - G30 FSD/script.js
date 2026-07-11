const cityInput = document.getElementById('cityInput');
const getCityWeatherBtn = document.getElementById('getCityWeatherBtn');

const weatherLoading = document.getElementById('weatherLoading');
const weatherError = document.getElementById('weatherError');
const weatherResult = document.getElementById('weatherResult');

const ow_temp = document.getElementById('ow_temp');
const ow_feels = document.getElementById('ow_feels');
const ow_humidity = document.getElementById('ow_humidity');
const ow_desc = document.getElementById('ow_desc');

const textInput = document.getElementById('textInput');
const analyzeBtn = document.getElementById('analyzeBtn');

const sentLoading = document.getElementById('sentLoading');
const sentError = document.getElementById('sentError');
const sentResult = document.getElementById('sentResult');

const sent_overall = document.getElementById('sent_overall');
const sent_confidence = document.getElementById('sent_confidence');
const sent_extra = document.getElementById('sent_extra');

function show(el, yes = true) {
  el.classList.toggle('hidden', !yes);
}

function showError(el, msg) {
  if (!msg) {
    el.textContent = '';
    show(el, false);
    return;
  }
  el.textContent = msg;
  show(el, true);
}

async function fetchCityWeather() {
  const city = cityInput.value.trim();
  if (!city) {
    showError(weatherError, 'Please enter a city name.');
    return;
  }

  showError(weatherError, null);
  show(weatherResult, false);
  show(weatherLoading, true);

  try {
    const resp = await fetch(
      `/api/weather?city=${encodeURIComponent(city)}`,
      { cache: 'no-store' }
    );

    if (!resp.ok) {
      const errText = await resp.text().catch(() => resp.statusText);
      throw new Error(errText || `HTTP ${resp.status}`);
    }

    const data = await resp.json();

    ow_temp.textContent = data.temperature ?? '--';
    ow_feels.textContent = data.feels_like ?? '--';
    ow_humidity.textContent = data.humidity ?? '--';
    ow_desc.textContent = data.description ?? '--';

    show(weatherResult, true);
  } catch (err) {
    console.error('Weather error:', err);
    showError(weatherError, 'Failed to fetch weather: ' + err.message);
  } finally {
    show(weatherLoading, false);
  }
}

async function analyzeSentiment() {
  const text = textInput.value.trim();
  if (!text) {
    showError(sentError, 'Please enter some text to analyze.');
    return;
  }

  showError(sentError, null);
  show(sentResult, false);
  show(sentLoading, true);

  try {
    const resp = await fetch('/api/sentiment', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ text })
    });

    if (!resp.ok) {
      const errText = await resp.text().catch(() => resp.statusText);
      throw new Error(errText || `HTTP ${resp.status}`);
    }

    const json = await resp.json();

    sent_overall.textContent = json.overall ?? '--';
    sent_confidence.textContent = json.confidence ?? '--';
    sent_extra.textContent = json.extra ?? '';

    show(sentResult, true);
  } catch (err) {
    console.error('Sentiment error:', err);
    showError(sentError, 'Failed to analyze sentiment: ' + err.message);
  } finally {
    show(sentLoading, false);
  }
}

getCityWeatherBtn.addEventListener('click', fetchCityWeather);
analyzeBtn.addEventListener('click', analyzeSentiment);

cityInput.addEventListener('keyup', (e) => {
  if (e.key === 'Enter') fetchCityWeather();
});

textInput.addEventListener('keyup', (e) => {
  if (e.key === 'Enter' && (e.ctrlKey || e.metaKey)) {
    analyzeSentiment();
  }
});
