// Default Coordinates: Kolkata, India
const DEFAULT_LAT = 22.57;
const DEFAULT_LON = 88.36;
const DEFAULT_CITY_NAME = "Kolkata, India";

// Open-Meteo API Endpoints
const GEOCODING_API_BASE = 'https://geocoding-api.open-meteo.com/v1/search?name=';
const WEATHER_API_BASE = 'https://api.open-meteo.com/v1/forecast?current=temperature_2m,wind_speed_10m,weather_code&temperature_unit=celsius&wind_speed_unit=kmh&timezone=auto&forecast_days=1&';

const cityInput = document.getElementById('city-input'); 
const weatherDisplay = document.getElementById('weather-display');
const getWeatherButton = document.getElementById('get-weather-btn');

// --- Utility Functions ---

// Weather condition mapping
function getWeatherCondition(code) {
    if (code === 0) return 'Clear sky ☀️';
    if (code >= 1 && code <= 3) return 'Mainly clear to Overcast ☁️';
    if (code >= 45 && code <= 48) return 'Fog and Rime Fog 🌫️';
    if (code >= 51 && code <= 55) return 'Drizzle: Light, Moderate, and Dense 🌧️';
    if (code >= 61 && code <= 65) return 'Rain: Slight, Moderate, and Heavy 🌧️';
    if (code >= 71 && code <= 75) return 'Snow fall: Slight, Moderate, and Heavy ❄️';
    if (code === 77) return 'Snow grains 🌨️';
    if (code >= 80 && code <= 82) return 'Rain showers: Slight, Moderate, and Violent ☔';
    if (code >= 85 && code <= 86) return 'Snow showers 🌨️';
    if (code >= 95 && code <= 99) return 'Thunderstorm: Slight or Moderate ⛈️';
    return 'Unknown Condition';
}

function displayWeather(data, units, locationName) {
    // Extract required data
    const temperature = data.temperature_2m;
    const windSpeed = data.wind_speed_10m;
    const weatherCode = data.weather_code;

    // Get units and condition text
    const conditionText = getWeatherCondition(weatherCode);
    const tempUnit = units.temperature_2m;
    const windUnit = units.wind_speed_10m;

    // Construct the HTML to display, including the location name
    weatherDisplay.innerHTML = `
        <p class="city-name">${locationName}</p>
        <p class="temperature">${temperature} ${tempUnit}</p>
        <p class="condition">Condition: ${conditionText}</p>
        <p class="wind-speed">Wind Speed: ${windSpeed} ${windUnit}</p>
        <p><small>Weather Code: ${weatherCode}</small></p>
    `;
}

// Fetch Weather Data function
async function fetchWeatherData(lat, lon, locationName) {
    const fullUrl = `${WEATHER_API_BASE}latitude=${lat}&longitude=${lon}`;

    try {
        const response = await fetch(fullUrl);
        if (!response.ok) {
            throw new Error(`Weather API HTTP error! Status: ${response.status}`);
        }
        const data = await response.json();

        if (data.current && data.current_units) {
            displayWeather(data.current, data.current_units, locationName);
        } else {
            weatherDisplay.innerHTML = '<p class="error">Error: Weather data is not available for this location.</p>';
        }
    } catch (error) {
        console.error('Failed to fetch weather data:', error);
        weatherDisplay.innerHTML = `<p class="error">Failed to fetch weather: ${error.message}.</p>`;
    }
}

async function getCityWeather(city) {
    // Show loading state and disable button
    weatherDisplay.innerHTML = `<p>Searching for ${city}...</p>`;
    getWeatherButton.disabled = true;

    try {
        // Fetch Coordinates (Geocoding)
        const geocodingUrl = `${GEOCODING_API_BASE}${encodeURIComponent(city)}&count=1&language=en&format=json`;
        const geoResponse = await fetch(geocodingUrl);
        
        if (!geoResponse.ok) {
            throw new Error(`Geocoding failed! Status: ${geoResponse.status}`);
        }
        
        const geoData = await geoResponse.json();

        // Check if any results were found
        if (geoData.results && geoData.results.length > 0) {
            const firstResult = geoData.results[0];
            const lat = firstResult.latitude;
            const lon = firstResult.longitude;

            // Construct a cleaner display name (e.g., "Kolkata, India")
            const displayLocationName = firstResult.name + (firstResult.country ? `, ${firstResult.country}` : '');

            // Fetch Weather using coordinates
            await fetchWeatherData(lat, lon, displayLocationName);
        } else {
            weatherDisplay.innerHTML = `<p class="error">Location not found: **${city}**</p>`;
        }

    } catch (error) {
        console.error('Operation failed:', error);
        weatherDisplay.innerHTML = `<p class="error">An unexpected error occurred: ${error.message}</p>`;
    } finally {

        // Re-enable the button
        getWeatherButton.disabled = false;
    }
}

// Main function to initiate weather fetch.
async function handleWeatherRequest() {
    const cityName = cityInput.value.trim();

    if (cityName === '') {
        // If input is empty, fetch the default location
        await fetchWeatherData(DEFAULT_LAT, DEFAULT_LON, DEFAULT_CITY_NAME);
    } else {
        // If input is present, use the geocoding process
        await getCityWeather(cityName);
    }
}

// Attach the main function to the button click
getWeatherButton.addEventListener('click', handleWeatherRequest);

// Allow pressing Enter key in the input field
cityInput.addEventListener('keypress', function (e) {
    if (e.key === 'Enter') {
        e.preventDefault(); 
        handleWeatherRequest();
    }
});

// Fetch default weather on page load
document.addEventListener('DOMContentLoaded', handleWeatherRequest);