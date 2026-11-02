const cityInput = document.getElementById("city");
const searchBtn = document.getElementById("searchBtn");
const result = document.getElementById("result");
const loading = document.getElementById("loading");
const error = document.getElementById("error");

searchBtn.addEventListener("click", getWeather);

async function getWeather() {

    const city = cityInput.value.trim();

    if (!city) {
        error.textContent = "Please enter a city name";
        result.innerHTML = "";
        return;
    }

    loading.textContent = "Loading...";
    error.textContent = "";
    result.innerHTML = "";

    try {

        const response = await fetch(
            `https://api.openweathermap.org/data/2.5/weather?q=${city}&appid=${}&units=metric`
        );

        const data = await response.json();

        if (data.cod != 200) {
            throw new Error("City not found");
        }

        result.innerHTML = `
            <h3>${data.name}, ${data.sys.country}</h3>
            <p>Temperature: ${data.main.temp} °C</p>
            <p>Condition: ${data.weather[0].main}</p>
            <p>Description: ${data.weather[0].description}</p>
            <p>Humidity: ${data.main.humidity}%</p>
            <p>Wind Speed: ${data.wind.speed} m/s</p>
        `;

    } catch (err) {
        error.textContent = err.message;
    }

    loading.textContent = "";
}