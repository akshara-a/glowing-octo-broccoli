const $ = id => document.getElementById(id);

const cityInput = $('city-input');
const getWeatherBtn = $('get-weather');
const weatherLoading = $('weather-loading');
const weatherError = $('weather-error');
const weatherResult = $('weather-result');
const tempEl = $('temp');
const feelsEl = $('feels');
const humidityEl = $('humidity');
const descEl = $('description');

const textInput = $('text-input');
const analyzeBtn = $('analyze');
const sentimentLoading = $('sentiment-loading');
const sentimentError = $('sentiment-error');
const sentimentResult = $('sentiment-result');
const sentimentEl = $('sentiment');
const confidenceEl = $('confidence');
const scoreTagEl = $('score_tag');

function show(el) { el.classList.remove('hidden'); }
function hide(el) { el.classList.add('hidden'); }

function handleError(container, message) {
  container.textContent = message;
  show(container);
  setTimeout(() => hide(container), 6000);
}

async function fetchWeather(city) {
  hide(weatherResult);
  weatherError.textContent = '';
  show(weatherLoading);
  try {
    if (typeof OPENWEATHER_KEY === 'undefined' || !OPENWEATHER_KEY) {
      throw new Error('OpenWeather API key not found in config.js');
    }

    const url = `https://api.openweathermap.org/data/2.5/weather?q=${encodeURIComponent(city)}&appid=${OPENWEATHER_KEY}&units=metric`;
    const resp = await fetch(url);
    if (!resp.ok) {
      if (resp.status === 404) throw new Error('City not found. Check spelling.');
      throw new Error(`Weather API error: ${resp.status} ${resp.statusText}`);
    }
    const data = await resp.json();

    tempEl.textContent = data.main.temp.toFixed(1);
    feelsEl.textContent = data.main.feels_like.toFixed(1);
    humidityEl.textContent = data.main.humidity;
    descEl.textContent = data.weather && data.weather[0] ? data.weather[0].description : 'N/A';
    show(weatherResult);
  } catch (err) {
    handleError(weatherError, err.message);
  } finally {
    hide(weatherLoading);
  }
}

getWeatherBtn.addEventListener('click', () => {
  const city = cityInput.value.trim();
  if (!city) {
    handleError(weatherError, 'Please enter a city name.');
    return;
  }
  fetchWeather(city);
});

async function analyzeSentiment(text) {
  hide(sentimentResult);
  sentimentError.textContent = '';
  show(sentimentLoading);
  try {
    if (typeof MEANINGCLOUD_KEY === 'undefined' || !MEANINGCLOUD_KEY) {
      throw new Error('MeaningCloud API key not found in config.js');
    }
    if (!text.trim()) {
      throw new Error('Please enter some text to analyze.');
    }

    const payload = new URLSearchParams();
    payload.append('key', MEANINGCLOUD_KEY);
    payload.append('txt', text);
    payload.append('lang', 'en');

    const resp = await fetch('https://api.meaningcloud.com/sentiment-2.1', {
      method: 'POST',
      headers: { 'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8' },
      body: payload.toString()
    });

    if (!resp.ok) {
      throw new Error(`MeaningCloud API error: ${resp.status} ${resp.statusText}`);
    }

    const result = await resp.json();
    const scoreTag = result.score_tag || 'NONE';
    const confidence = result.confidence || 0;

    let overall = 'Neutral';
    if (scoreTag.startsWith('P')) overall = 'Positive';
    else if (scoreTag.startsWith('N')) overall = 'Negative';
    else if (scoreTag === 'NEU' || scoreTag === 'NONE') overall = 'Neutral';

    sentimentEl.textContent = overall;
    confidenceEl.textContent = confidence;
    scoreTagEl.textContent = scoreTag;

    show(sentimentResult);
  } catch (err) {
    handleError(sentimentError, err.message);
  } finally {
    hide(sentimentLoading);
  }
}

analyzeBtn.addEventListener('click', () => {
  analyzeSentiment(textInput.value);
});
