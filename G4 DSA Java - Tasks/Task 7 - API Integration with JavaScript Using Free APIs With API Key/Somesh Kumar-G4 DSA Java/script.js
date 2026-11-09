const cityInput = document.getElementById("cityInput");
const searchBtn = document.getElementById("searchBtn");

const loading = document.getElementById("loading");
const error = document.getElementById("error");
const weatherResult = document.getElementById("weatherResult");

const cityName = document.getElementById("cityName");
const temperature = document.getElementById("temperature");
const condition = document.getElementById("condition");
const description = document.getElementById("description");
const humidity = document.getElementById("humidity");
const windSpeed = document.getElementById("windSpeed");

async function getWeather() {

    const city = cityInput.value.trim();

    error.textContent = "";
    weatherResult.style.display = "none";

    if (city === "") {
        error.textContent = "Please enter a city name";
        return;
    }

    loading.style.display = "block";

    try {

        const url =
            `https://api.openweathermap.org/data/2.5/weather?q=${encodeURIComponent(city)}&appid=${API_KEY}&units=metric`;

        const response = await fetch(url);

        if (response.status === 404) {
            throw new Error("City not found");
        }

        if (response.status === 401) {
            throw new Error("Invalid API key");
        }

        if (!response.ok) {
            throw new Error("Request failed");
        }

        const data = await response.json();

        cityName.textContent =
            `${data.name}, ${data.sys.country}`;

        temperature.textContent =
            `${Math.round(data.main.temp)}°C`;

        condition.textContent =
            data.weather[0].main;

        description.textContent =
            data.weather[0].description;

        humidity.textContent =
            `${data.main.humidity}%`;

        windSpeed.textContent =
            `${data.wind.speed} m/s`;

        weatherResult.style.display = "block";

    } catch (err) {

        if (err.message === "City not found") {
            error.textContent = "City not found";
        } else if (err.message === "Invalid API key") {
            error.textContent = "Invalid API key or request failed";
        } else {
            error.textContent = "Unable to fetch weather data";
        }

    } finally {
        loading.style.display = "none";
    }
}

searchBtn.addEventListener("click", getWeather);

cityInput.addEventListener("keydown", function(event) {
    if (event.key === "Enter") {
        getWeather();
    }
});