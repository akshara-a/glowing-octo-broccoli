async function getWeather() {
    const city = document.getElementById("cityInput").value;
    const result = document.getElementById("result");

    if (!city) {
        result.innerHTML = "<p class='error'>Enter a city</p>";
        return;
    }

    result.innerHTML = "<p>Loading...</p>";

    const url = `https://api.openweathermap.org/data/2.5/weather?q=${city}&appid=${API_KEY}&units=metric`;

    try {
        const response = await fetch(url);
        const data = await response.json();

        if (data.cod === "404") {
            result.innerHTML = "<p class='error'>City not found</p>";
            return;
        }

        result.innerHTML = `
            <div class="card">
                <h2>${data.name}</h2>
                <img src="https://openweathermap.org/img/wn/${data.weather[0].icon}@2x.png">
                <p>Description: ${data.weather[0].description}</p>
                <p>Temperature: ${data.main.temp}°C</p>
                <p>Feels Like: ${data.main.feels_like}°C</p>
                <p>Humidity: ${data.main.humidity}%</p>
            </div>
        `;
    } catch (err) {
        result.innerHTML = "<p class='error'>API Error</p>";
    }
}
