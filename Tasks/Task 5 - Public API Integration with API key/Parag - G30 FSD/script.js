const form = document.getElementById("weatherForm");
const card = document.querySelector(".weather-card");

form.addEventListener("submit", async (e) => {
    e.preventDefault();

    const city = document.getElementById("cityInput").value.trim();
    if (!city) {
        alert("Please enter a city name");
        return;
    }

    try {
        
        const geoRes = await fetch(
            `https://geocoding-api.open-meteo.com/v1/search?name=${city}&count=1`
        );
        const geoData = await geoRes.json();

        if (!geoData.results) {
            alert("City not found");
            return;
        }

        const { latitude, longitude, name } = geoData.results[0];

      
        const weatherRes = await fetch(
            `https://api.open-meteo.com/v1/forecast?latitude=${latitude}&longitude=${longitude}&current_weather=true&hourly=relativehumidity_2m,pressure_msl,apparent_temperature`
        );
        const weatherData = await weatherRes.json();

        const current = weatherData.current_weather;
        const hourly = weatherData.hourly;

      
        card.classList.remove("hidden");

        document.getElementById("cityName").textContent = name;
        document.getElementById("condition").textContent =
            `Wind ${current.windspeed} km/h`;

        document.getElementById("temperature").textContent =
            current.temperature + "°C";

      
        document.getElementById("feelsLike").textContent =
            hourly.apparent_temperature[0] + "°C";

        document.getElementById("humidity").textContent =
            hourly.relativehumidity_2m[0] + "%";

        document.getElementById("wind").textContent =
            current.windspeed + " km/h";

        document.getElementById("pressure").textContent =
            hourly.pressure_msl[0] + " hPa";

    } catch (error) {
        alert("Error fetching weather data");
        console.error(error);
    }
});
