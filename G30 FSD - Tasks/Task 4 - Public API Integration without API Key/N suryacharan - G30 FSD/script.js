
const btn = document.getElementById("getWeatherBtn");
const result = document.getElementById("weatherResult");

btn.addEventListener("click", () => {
    const apiURL = "https://api.open-meteo.com/v1/forecast?latitude=14.4673&longitude=78.8242&current_weather=true";

    fetch(apiURL)
        .then(res => res.json())
        .then(data => {
            const w = data.current_weather;
            result.innerHTML = `
                <p>Temperature: ${w.temperature}°C</p>
                <p>Wind Speed: ${w.windspeed} km/h</p>
                <p>Weather Code: ${w.weathercode}</p>
            `;
        })
        .catch(() => result.innerHTML = "Error loading weather");
});
