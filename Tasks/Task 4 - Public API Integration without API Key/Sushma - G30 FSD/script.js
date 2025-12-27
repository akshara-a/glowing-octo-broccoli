document.getElementById("getWeatherBtn").addEventListener("click", function () {

    let lat = document.getElementById("latitude").value;
    let lon = document.getElementById("longitude").value;

    if (lat === "" || lon === "") {
        alert("Please enter both latitude and longitude!");
        return;
    }

    // Open-Meteo Current Weather API
    let url = `https://api.open-meteo.com/v1/forecast?latitude=${lat}&longitude=${lon}&current_weather=true`;

    fetch(url)
        .then(response => response.json())
        .then(data => {
            let weather = data.current_weather;

            document.getElementById("temp").textContent = weather.temperature;
            document.getElementById("wind").textContent = weather.windspeed;
            document.getElementById("code").textContent = weather.weathercode;
        })
        .catch(error => {
            console.error("Error fetching weather:", error);
            alert("Failed to fetch weather data!");
        });
});
