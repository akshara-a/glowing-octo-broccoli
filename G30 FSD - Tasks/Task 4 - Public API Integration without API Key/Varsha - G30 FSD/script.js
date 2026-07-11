const apiUrl =
    "https://api.open-meteo.com/v1/forecast?latitude=17.3850&longitude=78.4867&current_weather=true&hourly=relativehumidity_2m";

const weatherMap = {
    0: "Clear Sky",
    1: "Mainly Clear",
    2: "Partly Cloudy",
    3: "Overcast",
    61: "Rainy",
    80: "Showers",
    95: "Thunderstorm",
    71: "Snowfall",
};

const tempEl = document.getElementById("temperature");
const condEl = document.getElementById("condition");
const windEl = document.getElementById("wind");
const humEl = document.getElementById("humidity");
const timeEl = document.getElementById("time");
const cityTitle = document.getElementById("cityTitle");
const btn = document.getElementById("getWeatherBtn");

async function getWeather() {
    try {
        const response = await fetch(apiUrl);
        const data = await response.json();

        const w = data.current_weather;

        let matchIndex = -1;
        for (let i = 0; i < data.hourly.time.length; i++) {
            if (data.hourly.time[i].startsWith(w.time.slice(0, 13))) {
                matchIndex = i;
                break;
            }
        }

        const humidity =
            matchIndex !== -1
                ? data.hourly.relativehumidity_2m[matchIndex]
                : "N/A";

        tempEl.textContent = `${w.temperature}°C`;
        windEl.textContent = `${w.windspeed} km/h`;
        humEl.textContent = `${humidity}%`;

        condEl.textContent = weatherMap[w.weathercode] || "Unknown";

        const now = new Date();
        timeEl.textContent = now.toLocaleTimeString([], {
            hour: "2-digit",
            minute: "2-digit",
        });

        cityTitle.textContent = "Hyderabad";

    } catch (error) {
        condEl.textContent = "Error fetching weather";
        console.error(error);
    }
}

btn.addEventListener("click", getWeather);
