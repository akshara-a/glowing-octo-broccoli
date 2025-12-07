// --- API Endpoint and Defaults ---
const OPENWEATHER_BASE_URL = 'https://api.openweathermap.org/data/2.5/weather';
const DEFAULT_CITY = 'Kolkata, India';

const cityInput = document.getElementById('city-input');
const getWeatherBtn = document.getElementById('get-weather-btn');
const weatherResultDiv = document.getElementById('weather-result');

// Function to display weather data
function displayWeather(data) {
    const main = data.main;
    const weather = data.weather[0];
    const city = data.name;

    // Convert Kelvin to Celsius and fix to one decimal place
    const tempC = (main.temp - 273.15).toFixed(1); 
    const feelsLikeC = (main.feels_like - 273.15).toFixed(1);

    weatherResultDiv.innerHTML = `
        <div class="weather-data">
            <p class="city-name">${city}, ${data.sys.country}</p>
            <p class="temp-main">${tempC}°C</p>
            <p class="description"><strong>Condition:</strong> ${weather.description.toUpperCase()}</p>
            <p><strong>Feels Like:</strong> ${feelsLikeC}°C</p>
            <p><strong>Humidity:</strong> ${main.humidity}%</p>
        </div>
    `;
}

// Function to fetch weather data
async function fetchWeather(city) {
    // Show loading state
    weatherResultDiv.innerHTML = `<p>Loading weather data for ${city}...</p>`;
    getWeatherBtn.disabled = true;

    // Construct the URL using the city name
    const url = `${OPENWEATHER_BASE_URL}?q=${encodeURIComponent(city)}&appid=${CONFIG.API_KEY}`;

    try {
        const response = await fetch(url);
        const data = await response.json();

        if (response.ok) {
            displayWeather(data);
        } else {
            // Error handling for invalid city or API key
            const errorMessage = data.message || 'Unknown error occurred.';
            weatherResultDiv.innerHTML = `<p class="error">Error: ${errorMessage}. Please check the city name</p>`;
        }

    } catch (error) {
        console.error('Weather Fetch Failed:', error);
        weatherResultDiv.innerHTML = `<p class="error">Network error. Please try again.</p>`;
    } finally {
        getWeatherBtn.disabled = false;
    }
}

// Function to handle weather request
function handleWeatherRequest() {
    const city = cityInput.value.trim();
    if (!city) {
        // If input is empty, fetch the default city
        fetchWeather(DEFAULT_CITY);
    } else {
        // Fetch the city entered by the user
        fetchWeather(city);
    }
}

// Function to fetch default weather
function fetchKolkataDefault() {
    // Set input value to default and initiate fetch
    // cityInput.value = DEFAULT_CITY;
    fetchWeather(DEFAULT_CITY);
}

getWeatherBtn.addEventListener('click', handleWeatherRequest);

// Allow Enter key press in the city input field
cityInput.addEventListener('keypress', function (e) {
    if (e.key === 'Enter') {
        e.preventDefault(); 
        handleWeatherRequest();
    }
});

// Fetch default weather on page load
document.addEventListener('DOMContentLoaded', fetchKolkataDefault);