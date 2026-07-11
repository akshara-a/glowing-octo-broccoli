async function getWeather() {
    const city = document.getElementById("cityInput").value;
    const resultDiv = document.getElementById("result");

    if (!city) {
        resultDiv.style.display = "block";
        resultDiv.innerHTML = "⚠️ Please enter a city name.";
        return;
    }

    try {
        // Step 1: Convert city → latitude + longitude
        const geoRes = await fetch(
            `https://geocoding-api.open-meteo.com/v1/search?name=${city}`
        );
        const geoData = await geoRes.json();

        if (!geoData.results || geoData.results.length === 0) {
            resultDiv.style.display = "block";
            resultDiv.innerHTML = "❌ City not found!";
            return;
        }

        const { latitude, longitude, name, country } = geoData.results[0];

        // Step 2: Fetch current weather
        const weatherRes = await fetch(
            `https://api.open-meteo.com/v1/forecast?latitude=${latitude}&longitude=${longitude}&current_weather=true`
        );
        const weatherData = await weatherRes.json();

        const { temperature, windspeed, weathercode } = weatherData.current_weather;

        // Step 3: Show results
        resultDiv.style.display = "block";
        resultDiv.innerHTML = `
            <h3>${name}, ${country}</h3>
            <p><strong>Temperature:</strong> ${temperature} °C</p>
            <p><strong>Wind Speed:</strong> ${windspeed} km/h</p>
            <p><strong>Weather Code:</strong> ${weathercode}</p>
        `;
    } catch (error) {
        resultDiv.style.display = "block";
        resultDiv.innerHTML = "⚠️ Error fetching weather data.";
        console.error(error);
    }
}
