// Selecting HTML elements
const temperatureElement = document.getElementById("temperature");
const windElement = document.getElementById("wind");
const conditionElement = document.getElementById("condition");
const button = document.getElementById("getWeatherBtn");

// Default location (New Delhi)
const latitude = 28.6139;
const longitude = 77.2090;

// Open-Meteo API Endpoint
const apiUrl = `https://api.open-meteo.com/v1/forecast?latitude=${latitude}&longitude=${longitude}&current_weather=true`;

// Function to fetch weather data
function getWeather() {
    fetch(apiUrl)
        .then(response => response.json())
        .then(data => {
            const weather = data.current_weather;

            // Displaying values in UI
            temperatureElement.textContent = weather.temperature;
            windElement.textContent = weather.windspeed;
            conditionElement.textContent = weather.weathercode;
        })
        .catch(error => {
            console.error("Error fetching weather data:", error);
        });
}

// Button Click Event
button.addEventListener("click", getWeather);
