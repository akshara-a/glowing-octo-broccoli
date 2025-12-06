// When button is clicked, run getWeather function
document.getElementById("getWeatherBtn").addEventListener("click", getWeather);

function getWeather() {

    // Open-Meteo API URL (No API Key needed)
    let apiURL = "https://api.open-meteo.com/v1/forecast?latitude=12.97&longitude=77.59&current_weather=true";

    // Fetch data from the API
    fetch(apiURL)
    .then(response => response.json())
    .then(data => {

        // Get weather data
        let weather = data.current_weather;

        // Display data on page
        document.getElementById("temp").innerText = weather.temperature;
        document.getElementById("wind").innerText = weather.windspeed;
        document.getElementById("code").innerText = weather.weathercode;
    })
    .catch(error => {
        console.log("Something went wrong!", error);
    });
}
