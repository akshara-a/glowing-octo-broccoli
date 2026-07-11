const apiKey = "api key";

document.getElementById("getWeatherBtn").addEventListener("click", getWeather);

async function getWeather() {
    const location = document.getElementById("location").value.trim();
    if (!location) {
        alert("Please enter a location");
        return;
    }

    const url = `http://api.weatherapi.com/v1/current.json?key=${apiKey}&q=${location}&aqi=yes`;

    try {
        const response = await fetch(url);
        if (!response.ok) throw new Error("Location not found");

        const data = await response.json();
        const weatherDiv = document.getElementById("weather");

        weatherDiv.innerHTML = `
            <h2>${data.location.name}, ${data.location.country}</h2>
            <img src="${data.current.condition.icon}" alt="Weather icon">
            <p><strong>Condition:</strong> ${data.current.condition.text}</p>
            <p><strong>Temperature:</strong> ${data.current.temp_c}°C / ${data.current.temp_f}°F</p>
            <p><strong>Humidity:</strong> ${data.current.humidity}%</p>
            <p><strong>Wind:</strong> ${data.current.wind_kph} kph</p>
            <p><strong>Air Quality Index:</strong> ${data.current.air_quality?.us_epa_index ?? 'N/A'}</p>
        `;
    } catch (error) {
        alert(error.message);
    }
}
