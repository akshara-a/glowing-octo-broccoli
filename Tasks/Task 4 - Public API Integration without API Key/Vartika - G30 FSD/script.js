// Weather code to description mapping
function getWeatherText(code) {
    const codes = {
        0: "Clear sky",
        1: "Mainly clear",
        2: "Partly cloudy",
        3: "Overcast",
        45: "Fog",
        48: "Rime fog",
        51: "Light drizzle",
        53: "Moderate drizzle",
        55: "Dense drizzle",
        61: "Light rain",
        63: "Moderate rain",
        65: "Heavy rain",
        71: "Light snowfall",
        73: "Moderate snowfall",
        75: "Heavy snowfall",
        80: "Light rain showers",
        81: "Moderate rain showers",
        82: "Heavy rain showers",
        95: "Thunderstorm",
        96: "Thunderstorm (slight hail)",
        99: "Thunderstorm (heavy hail)"
    };

    return codes[code] || "Unknown (" + code + ")";
}

// elements
const cityInput = document.getElementById("city");
const latInput = document.getElementById("latitude");
const lonInput = document.getElementById("longitude");
const getWeatherBtn = document.getElementById("getWeatherBtn");

const errorText = document.getElementById("error");
const weatherCard = document.getElementById("weatherCard");

const tempText = document.getElementById("temperature");
const windText = document.getElementById("windSpeed");
const codeText = document.getElementById("weatherCode");
const timeText = document.getElementById("updatedAt");
const locationNameText = document.getElementById("locationName");
const coordsText = document.getElementById("coords");

// error helpers
function showError(msg) {
    errorText.textContent = msg;
    weatherCard.classList.add("hide");
}

function clearError() {
    errorText.textContent = "";
}

// Open-Meteo geocoding API use
async function getCityCoordinates(cityName) {
    const url =
        "https://geocoding-api.open-meteo.com/v1/search?name=" +
        encodeURIComponent(cityName) +
        "&count=1&language=en&format=json";

    const res = await fetch(url);

    if (!res.ok) {
        throw new Error("Failed to fetch location. Status: " + res.status);
    }

    const data = await res.json();

    if (!data.results || data.results.length === 0) {
        throw new Error("City not found. Try a different name.");
    }

    const first = data.results[0];
    const latitude = first.latitude;
    const longitude = first.longitude;
    const name = first.name;
    const country = first.country;
    // fill lat/lon inputs
    latInput.value = latitude;
    lonInput.value = longitude;

    return {
        latitude: latitude,
        longitude: longitude,
        displayName: country ? name + ", " + country : name
    };
}


// Open-Meteo forecast API, current_weather=true
async function getCurrentWeather(latitude, longitude) {
    const url =
        "https://api.open-meteo.com/v1/forecast?latitude=" +
        latitude +
        "&longitude=" +
        longitude +
        "&current_weather=true";

    const res = await fetch(url);

    if (!res.ok) {
        throw new Error("Failed to fetch weather. Status: " + res.status);
    }

    const data = await res.json();

    if (!data.current_weather) {
        throw new Error("Current weather data not available.");
    }

    return data.current_weather;
}

getWeatherBtn.addEventListener("click", async function () {
    clearError();

    const city = cityInput.value.trim();
    let latitude;
    let longitude;
    let displayName;

    try {
        if (city !== "") {
            
            const info = await getCityCoordinates(city);
            latitude = info.latitude;
            longitude = info.longitude;
            displayName = info.displayName;
        } else {
           
            const latValue = parseFloat(latInput.value);
            const lonValue = parseFloat(lonInput.value);

            if (isNaN(latValue) || isNaN(lonValue)) {
                throw new Error(
                    "Please enter a city name or valid latitude and longitude."
                );
            }

            latitude = latValue;
            longitude = lonValue;
            displayName = "Custom coordinates";
        }

        // weather data
        const current = await getCurrentWeather(latitude, longitude);

        // UI update
        tempText.textContent = current.temperature + " °C";
        windText.textContent = current.windspeed + " km/h";
        codeText.textContent = getWeatherText(current.weathercode);
        timeText.textContent = "Last updated: " + current.time + " (UTC)";

        locationNameText.textContent = displayName;
        coordsText.textContent =
            "Lat: " + latitude.toFixed(4) + ", Lon: " + longitude.toFixed(4);

        weatherCard.classList.remove("hide");
    } catch (err) {
        console.error(err);
        showError(err.message || "Something went wrong.");
    }
});
