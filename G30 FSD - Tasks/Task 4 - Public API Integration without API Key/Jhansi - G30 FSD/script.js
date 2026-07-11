// Function to fetch weather data from Open-Meteo API
async function getWeather() {
    // Visakhapatnam coordinates (example)
    const latitude = 17.6868;
    const longitude = 83.2185;

    const url = `https://api.open-meteo.com/v1/forecast?latitude=${latitude}&longitude=${longitude}&current_weather=true`;

    try {
        const response = await fetch(url);
        const data = await response.json();

        // Extracting required data
        const temperature = data.current_weather.temperature;
        const windSpeed = data.current_weather.windspeed;
        const weatherCode = data.current_weather.weathercode;

        // Display in UI
        document.getElementById("weatherResult").innerHTML = `
            <p><strong>Temperature:</strong> ${temperature} °C</p>
            <p><strong>Wind Speed:</strong> ${windSpeed} km/h</p>
            <p><strong>Weather Code:</strong> ${weatherCode}</p>
        `;

    } catch (error) {
        document.getElementById("weatherResult").innerHTML =
            "<p>Error fetching weather data.</p>";
        console.error("Error:", error);
    }
}

// Button click event
document.getElementById("getWeatherBtn").addEventListener("click", getWeather);

