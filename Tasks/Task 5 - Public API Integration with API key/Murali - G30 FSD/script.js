// DOM references
const cityInput = document.getElementById('cityInput');
const searchBtn = document.getElementById('searchBtn');
const resultDiv = document.getElementById('result');
const errorDiv = document.getElementById('error');
const locationEl = document.getElementById('location');
const tempEl = document.getElementById('temp');
const condEl = document.getElementById('condition');
const iconEl = document.getElementById('icon');

// Event: click search
searchBtn.addEventListener('click', () => {
  const city = cityInput.value.trim();
  if (!city) {
    showError('Please enter a city name');
    return;
  }
  fetchWeather(city);
});

// Optional: allow Enter key to search
cityInput.addEventListener('keypress', (e) => {
  if (e.key === 'Enter') searchBtn.click();
});

async function fetchWeather(city) {
  try {
    // Build URL for WeatherAPI (current weather)
    const url = `https://api.weatherapi.com/v1/current.json?key=${WEATHER_KEY}&q=${encodeURIComponent(city)}&aqi=no`;

    // Fetch data
    const res = await fetch(url);

    // Handle HTTP errors
    if (!res.ok) {
      if (res.status === 400 || res.status === 401 || res.status === 403 || res.status === 404) {
        // Provide user-friendly message from WeatherAPI if possible
        const errData = await res.json().catch(() => ({}));
        const message = errData.error && errData.error.message ? errData.error.message : 'City not found or API error';
        throw new Error(message);
      } else {
        throw new Error('Network response was not ok');
      }
    }

    const data = await res.json();
    showResult(data);
  } catch (err) {
    showError(err.message || 'Something went wrong');
    console.error('Fetch error:', err);
  }
}

function showResult(data) {
  // Hide error
  errorDiv.classList.add('hidden');

  // Fill UI
  const name = data.location.name;
  const country = data.location.country;
  const tempC = data.current.temp_c;
  const conditionText = data.current.condition.text;
  const iconUrl = data.current.condition.icon; // may be like "//cdn.weatherapi.com/..."
  const localTime = data.location.localtime;

  locationEl.textContent = `${name}, ${country} — local: ${localTime}`;
  tempEl.textContent = `Temperature: ${tempC} °C`;
  condEl.textContent = `Condition: ${conditionText}`;

  // Show and load icon properly (add protocol if needed)
  if (iconUrl) {
    iconEl.style.display = 'inline-block';
    iconEl.src = iconUrl.startsWith('//') ? 'https:' + iconUrl : iconUrl;
    iconEl.alt = conditionText;
  } else {
    iconEl.style.display = 'none';
  }

  // Show result container
  resultDiv.classList.remove('hidden');
}

function showError(msg) {
  // Hide result
  resultDiv.classList.add('hidden');

  // Show error
  errorDiv.classList.remove('hidden');
  errorDiv.textContent = msg;
}
