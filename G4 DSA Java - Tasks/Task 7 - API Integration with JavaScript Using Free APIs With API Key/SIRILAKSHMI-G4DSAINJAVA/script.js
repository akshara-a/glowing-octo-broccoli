const cityInput = document.getElementById("cityInput");
const searchBtn = document.getElementById("searchBtn");
const loading = document.getElementById("loading");
const error = document.getElementById("error");
const weatherResult = document.getElementById("weatherResult");

searchBtn.addEventListener("click", getWeather);

cityInput.addEventListener("keydown", function (event) {
    if (event.key === "Enter") {
        getWeather();
    }
});

async function getWeather() {

    const city = cityInput.value.trim();

    weatherResult.innerHTML = "";
    error.textContent = "";
    loading.textContent = "";

    if (city === "") {
        error.textContent = "Please enter a city name.";
        return;
    }

    loading.textContent = "Loading weather data...";

    const url = `https://api.openweathermap.org/data/2.5/weather?q=${city}&appid=${API_KEY}&units=metric`;

    try {

        const response = await fetch(url);

        if (!response.ok) {
            throw new Error("City not found or invalid API key.");
        }

        const data = await response.json();

        loading.textContent = "";

        weatherResult.innerHTML = `
            <div class="weather-card">

                <h2>${data.name}, ${data.sys.country}</h2>

                <img src="https://openweathermap.org/img/wn/${data.weather[0].icon}@2x.png" alt="Weather Icon">

                <p><strong>Temperature:</strong> ${data.main.temp} °C</p>

                <p><strong>Weather:</strong> ${data.weather[0].main}</p>

                <p><strong>Description:</strong> ${data.weather[0].description}</p>

                <p><strong>Humidity:</strong> ${data.main.humidity}%</p>

                <p><strong>Wind Speed:</strong> ${data.wind.speed} m/s</p>

            </div>
        `;

    } catch (err) {

        loading.textContent = "";
        weatherResult.innerHTML = "";
        error.textContent = err.message;

    }

}