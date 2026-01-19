document.getElementById("weatherForm").addEventListener("submit", async e => {
    e.preventDefault();

    const city = document.getElementById("cityInput").value.trim();
    if (!city) {
        alert("Enter city name");
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
            `https://api.open-meteo.com/v1/forecast?latitude=${latitude}&longitude=${longitude}&current_weather=true`
        );
        const weatherData = await weatherRes.json();

        document.getElementById("cityName").textContent = name;
        document.getElementById("temperature").textContent =
            weatherData.current_weather.temperature + "°C";
        document.getElementById("condition").textContent =
            "Wind " + weatherData.current_weather.windspeed + " km/h";

        document.querySelector(".weather-card").classList.remove("hidden");

    } catch (error) {
        alert("Error fetching weather");
        console.error(error);
    }
});
