document.querySelector("#getWeatherBtn").addEventListener("click", function (e) {
    e.preventDefault();
    getWeather();
});

function updateBackground(condition) {
    condition = condition.toLowerCase();
    document.body.className = "";

    if (condition.includes("sun")) {
        document.body.classList.add("sunny");
    }
    else if (condition.includes("cloud")) {
        document.body.classList.add("cloudy");
    }
    else if (condition.includes("rain") || condition.includes("drizzle")) {
        document.body.classList.add("rainy");
    }
    else if (condition.includes("haze") || condition.includes("mist") || condition.includes("fog")) {
        document.body.classList.add("haze");
    }
    else if (condition.includes("clear")) {
        document.body.classList.add("clearsky");
    }
}


async function getWeather() {
    const city = document.getElementById("cityInput").value.trim();

    if (!city) {
        alert("Please enter a city name!");
        return;
    }

    document.getElementById("cityTitle").textContent = "Loading...";
    document.getElementById("description").textContent = "Loading...";

    const url = `https://open-weather13.p.rapidapi.com/city?city=${encodeURIComponent(city)}&lang=EN`;

    try {
        const response = await fetch(url, {
            method: "GET",
            headers: {
                "X-RapidAPI-Key": RAPID_WEATHER_KEY,
                "X-RapidAPI-Host": "open-weather13.p.rapidapi.com"
            }
        });

        if (!response.ok) {
            alert("City not found! Try another city.");
            return;
        }

        const data = await response.json();
        const tempC = ((data.main.temp - 32) * 5 / 9).toFixed(1);
        const feelsLikeC = ((data.main.feels_like - 32) * 5 / 9).toFixed(1);
        const windKmph = (data.wind.speed * 3.6).toFixed(1);
        const sunrise = new Date(data.sys.sunrise * 1000).toLocaleTimeString();
        const sunset = new Date(data.sys.sunset * 1000).toLocaleTimeString();

        document.getElementById("cityTitle").textContent = city;
        document.getElementById("temp").textContent = tempC + "°C";
        document.getElementById("feelsLike").textContent = feelsLikeC + "°C";
        document.getElementById("humidity").textContent = data.main.humidity + "%";
        document.getElementById("wind").textContent = windKmph + " km/h";
        document.getElementById("sunrise").textContent = sunrise;
        document.getElementById("sunset").textContent = sunset;
        document.getElementById("description").textContent = data.weather[0].description;
        updateBackground(data.weather[0].description);
    } catch (err) {
        console.error(err);
        alert("Failed to fetch weather data.");
    }

}
