// Elements
const cityInput = document.getElementById('cityInput');
const searchBtn = document.getElementById('searchBtn');
const weatherDisplay = document.getElementById('weatherDisplay');
const errorMessage = document.getElementById('errorMessage');
const errorText = document.getElementById('errorText');
const loader = document.getElementById('loader');

// Data Elements
const cityNameEl = document.getElementById('cityName');
const tempEl = document.getElementById('temp');
const descEl = document.getElementById('desc');
const humidityEl = document.getElementById('humidity');
const feelsLikeEl = document.getElementById('feelsLike');
const iconEl = document.getElementById('weatherIcon');

// Helper: Toggle Visibility
const toggleElement = (el, show) => {
    show ? el.classList.remove('hidden') : el.classList.add('hidden');
};

// Event Listeners
searchBtn.addEventListener('click', handleSearch);
cityInput.addEventListener('keypress', (e) => {
    if (e.key === 'Enter') handleSearch();
});

async function handleSearch() {
    const city = cityInput.value.trim();
    if (!city) return;

    // Reset UI state
    toggleElement(errorMessage, false);
    toggleElement(weatherDisplay, false);
    toggleElement(loader, true); 

    try {
        if (typeof CONFIG === 'undefined' || !CONFIG.API_KEY) {
            throw new Error("API Key missing in config.js");
        }

        const url = `https://api.openweathermap.org/data/2.5/weather?q=${city}&appid=${CONFIG.API_KEY}&units=metric`;
        const response = await fetch(url);

        if (!response.ok) {
            throw new Error('City not found. Try again!');
        }

        const data = await response.json();
        updateUI(data);

    } catch (error) {
        errorText.textContent = error.message;
        toggleElement(errorMessage, true);
    } finally {
        toggleElement(loader, false); // Hide Loader
    }
}

function updateUI(data) {
    cityNameEl.textContent = `${data.name}, ${data.sys.country}`;
    tempEl.textContent = `${Math.round(data.main.temp)}°`;
    descEl.textContent = data.weather[0].description;
    humidityEl.textContent = `${data.main.humidity}%`;
    feelsLikeEl.textContent = `${Math.round(data.main.feels_like)}°`;

    // Get the icon code from API (e.g., '10d') and set URL
    const iconCode = data.weather[0].icon;
    iconEl.src = `https://openweathermap.org/img/wn/${iconCode}@2x.png`;

    toggleElement(weatherDisplay, true);
}