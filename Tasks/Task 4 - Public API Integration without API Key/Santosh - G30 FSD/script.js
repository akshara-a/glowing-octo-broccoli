document.getElementById("getWeatherBtn").addEventListener("click", getWeather);

function getWeather() {
    
    let apiURL = "https://api.open-meteo.com/v1/forecast?latitude=12.97&longitude=77.59&current_weather=true";

    fetch(apiURL)
    .then(response => response.json())
    .then(data => {

        let weather = data.current_weather;

        document.getElementById("temp").innerText = weather.temperature;
        document.getElementById("wind").innerText = weather.windspeed;
        document.getElementById("code").innerText = weather.weathercode;
    })
    .catch(error => {
        console.log("Something went wrong!", error);
    });
}