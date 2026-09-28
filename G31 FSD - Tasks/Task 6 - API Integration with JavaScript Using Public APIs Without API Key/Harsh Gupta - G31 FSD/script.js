const weatherDiv = document.getElementById("weather");

async function getWeather() {

    const city = document.getElementById("city").value.trim();

    if (city === "") {
        weatherDiv.style.display = "block";
        weatherDiv.innerHTML = "<p>Please enter a city.</p>";
        return;
    }

    try {

        const geoResponse = await fetch(
            `https://geocoding-api.open-meteo.com/v1/search?name=${city}&count=1`
        );

        const geoData = await geoResponse.json();

        if (!geoData.results) {
            weatherDiv.style.display = "block";
            weatherDiv.innerHTML = "<p>City not found.</p>";
            return;
        }

        const latitude = geoData.results[0].latitude;
        const longitude = geoData.results[0].longitude;
        const cityName = geoData.results[0].name;
        const country = geoData.results[0].country;

        const weatherResponse = await fetch(
            `https://api.open-meteo.com/v1/forecast?latitude=${latitude}&longitude=${longitude}&current=temperature_2m,relative_humidity_2m,wind_speed_10m`
        );

        const weatherData = await weatherResponse.json();
        const current = weatherData.current;

        weatherDiv.style.display = "block";

        weatherDiv.innerHTML = `
            <h2>📍 ${cityName}, ${country}</h2>
            <p>🌡 Temperature: <b>${current.temperature_2m} °C</b></p>
            <p>💧 Humidity: <b>${current.relative_humidity_2m}%</b></p>
            <p>🌬 Wind Speed: <b>${current.wind_speed_10m} km/h</b></p>
        `;

    } catch (error) {

        weatherDiv.style.display = "block";
        weatherDiv.innerHTML = "<p>Unable to fetch weather.</p>";
        console.log(error);

    }
}
