// Select button and result div
const button = document.getElementById("getWeatherBtn");
const weatherResult = document.getElementById("weatherResult");

// Jaipur coordinates (you can change this)
const latitude = 26.9124;
const longitude = 75.7873;

// Button click event
button.addEventListener("click", getWeather);

// Fetch weather data from Open-Meteo
function getWeather() {

    // Open-Meteo API URL (no API key required)
    const url = `https://api.open-meteo.com/v1/forecast?latitude=${latitude}&longitude=${longitude}&current_weather=true`;

    fetch(url)
        .then(response => response.json())
        .then(data => {
            const weather = data.current_weather;

            // Display weather data
            weatherResult.innerHTML = `
                <p><strong>Temperature:</strong> ${weather.temperature} °C</p>
                <p><strong>Wind Speed:</strong> ${weather.windspeed} km/h</p>
                <p><strong>Weather Code:</strong> ${weather.weathercode}</p>
            `;
        })
        .catch(error => {
            weatherResult.innerHTML = "<p>Error fetching weather data.</p>";
            console.error(error);
        });
}
