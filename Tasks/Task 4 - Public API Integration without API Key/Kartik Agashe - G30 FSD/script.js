// When button is clicked → call API
document.getElementById("getWeatherBtn").addEventListener("click", getWeather);

function getWeather() {
    // Example coordinates: Mumbai (latitude, longitude)
    const latitude = 19.0760;
    const longitude = 72.8777;

    const url = `https://api.open-meteo.com/v1/forecast?latitude=${latitude}&longitude=${longitude}&current_weather=true`;

    // Fetch weather data
    fetch(url)
        .then(response => response.json())
        .then(data => {
            console.log(data);

            const weather = data.current_weather;

            document.getElementById("temperature").textContent = weather.temperature;
            document.getElementById("windSpeed").textContent = weather.windspeed;
            document.getElementById("weatherCode").textContent = weather.weathercode;
        })
        .catch(error => {
            console.error("Error fetching weather:", error);
            alert("Failed to fetch weather data.");
        });
}
