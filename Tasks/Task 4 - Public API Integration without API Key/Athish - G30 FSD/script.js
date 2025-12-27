// Function to call Open-Meteo API and update UI
async function getWeatherData() {
    const lat = document.getElementById("lat").value;
    const lon = document.getElementById("lon").value;

    if (!lat || !lon) {
        alert("Please enter latitude and longitude!");
        return;
    }

    const url = `https://api.open-meteo.com/v1/forecast?latitude=${lat}&longitude=${lon}&current_weather=true&hourly=relative_humidity_2m`;

    try {
        const response = await fetch(url);
        const data = await response.json();

        const weather = data.current_weather;
        const code = weather.weathercode;

        // Update UI
        document.querySelector(".temp").innerText = weather.temperature + " °C";
        document.querySelector(".air").innerText = weather.windspeed + " km/h";
        document.querySelector(".location").innerText = `Lat: ${lat} | Lon: ${lon}`;
        document.querySelector(".humidity").innerText =
            data.hourly.relative_humidity_2m[0] + " %";

        setBackground(code);

    } catch (error) {
        console.error("Error fetching data:", error);
        alert("Unable to fetch weather data!");
    }
}

function setBackground(code) {
    const icon = document.querySelector(".weather-icon");
    const body = document.body;

    if (code === 0 || code === 1) {
        icon.src = "./images/clear.png";
        
    }
    else if (code === 2 || code === 3) {
        icon.src = "./images/cloudy.png";
        
    }
    else {
        icon.src = "./images/rain.png";
        
    }
}

// Button event
document.getElementById("getWeather").addEventListener("click", getWeatherData);
