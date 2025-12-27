const weatherMap = {
    0: { text: "Clear Sky", icon: "https://cdn-icons-png.flaticon.com/512/1163/1163661.png" },
    1: { text: "Mostly Clear", icon: "https://cdn-icons-png.flaticon.com/512/3222/3222800.png" },
    2: { text: "Partly Cloudy", icon: "https://cdn-icons-png.flaticon.com/512/3222/3222691.png" },
    3: { text: "Overcast", icon: "https://cdn-icons-png.flaticon.com/512/414/414825.png" },

    45: { text: "Foggy", icon: "https://cdn-icons-png.flaticon.com/512/4005/4005901.png" },
    48: { text: "Rime Fog", icon: "https://cdn-icons-png.flaticon.com/512/4005/4005901.png" },

    51: { text: "Light Drizzle", icon: "https://cdn-icons-png.flaticon.com/512/3076/3076129.png" },
    61: { text: "Rainy", icon: "https://cdn-icons-png.flaticon.com/512/1163/1163624.png" },
    80: { text: "Rain Showers", icon: "https://cdn-icons-png.flaticon.com/512/1163/1163624.png" },

    71: { text: "Snowfall", icon: "https://cdn-icons-png.flaticon.com/512/642/642102.png" },

    95: { text: "Thunderstorm", icon: "https://cdn-icons-png.flaticon.com/512/1146/1146869.png" }
};

async function getWeather() {
    const lat = document.getElementById("latInput").value;
    const lon = document.getElementById("lonInput").value;

    if (!lat || !lon) {
        alert("Please enter valid latitude & longitude");
        return;
    }

    const url = `https://api.open-meteo.com/v1/forecast?latitude=${lat}&longitude=${lon}&current_weather=true&hourly=relativehumidity_2m,pressure_msl,apparent_temperature`;

    const response = await fetch(url);
    const data = await response.json();

    const weather = data.current_weather;
    const code = weather.weathercode;

    // Show weather section
    document.getElementById("weatherResult").style.display = "block";

    // Meaning + Icon
    document.getElementById("weatherMeaning").textContent =
        weatherMap[code]?.text || "Unknown";

    document.getElementById("weatherIcon").src =
        weatherMap[code]?.icon || "";

    // Basic data
    document.getElementById("temperature").textContent = weather.temperature;
    document.getElementById("windSpeed").textContent = weather.windspeed;
    document.getElementById("weatherCode").textContent = code;

    // Additional Data
    document.getElementById("feelsLike").textContent =
        data.hourly.apparent_temperature[0] || "--";

    document.getElementById("humidity").textContent =
        data.hourly.relativehumidity_2m[0] || "--";

    document.getElementById("pressure").textContent =
        data.hourly.pressure_msl[0] || "--";
}

document.getElementById("getWeatherBtn").addEventListener("click", getWeather);
