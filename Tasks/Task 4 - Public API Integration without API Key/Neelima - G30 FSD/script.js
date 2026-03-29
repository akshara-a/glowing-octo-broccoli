// ===============================
// Open-Meteo Weather Fetch Script
// ===============================

// Select DOM elements
const getWeatherBtn = document.getElementById("getWeatherBtn");
const resultBox = document.getElementById("resultBox");
const statusMsg = document.getElementById("statusMsg");

// Add click event listener to button
getWeatherBtn.addEventListener("click", async () => {
    // Get user input for latitude and longitude
    const lat = document.getElementById("latitude").value;
    const lon = document.getElementById("longitude").value;

    // Simple validation
    if (!lat || !lon) {
        statusMsg.textContent = "⚠ Please enter both latitude and longitude.";
        return;
    }

    // Show loading message
    statusMsg.textContent = "Fetching weather data...";
    resultBox.innerHTML = "";

    // Build Open-Meteo API endpoint
    const url = `https://api.open-meteo.com/v1/forecast?latitude=${lat}&longitude=${lon}&current_weather=true`;

    try {
        // Fetch data from API
        const response = await fetch(url);

        // If something goes wrong (bad response)
        if (!response.ok) {
            throw new Error("Unable to fetch weather data");
        }

        const data = await response.json();

        // Get current weather info
        const weather = data.current_weather;

        // Clear status message
        statusMsg.textContent = "";

        // Display data nicely on screen
        resultBox.innerHTML = `
            <p><strong>Temperature:</strong> ${weather.temperature}°C</p>
            <p><strong>Wind Speed:</strong> ${weather.windspeed} km/h</p>
            <p><strong>Weather Code:</strong> ${weather.weathercode}</p>
        `;
    } 
    catch (error) {
        // Show error on screen
        statusMsg.textContent = "❌ Error: " + error.message;
    }
});
