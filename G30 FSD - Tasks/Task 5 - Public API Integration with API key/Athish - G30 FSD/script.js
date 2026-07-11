const apiKey = "your_api_key"; 
const apiUrl = "https://api.openweathermap.org/data/2.5/weather?units=metric&q=";

const searchBox = document.querySelector(".search input");
const searchBtn = document.querySelector(".search button");
const weatherIcon = document.querySelector(".weather-icon");

async function getWeather(city) {
    const response = await fetch(apiUrl + city + `&appid=${apiKey}`);

    if (response.status == 404) {
        alert("City not found! Please enter a valid city name.");
        return;
    }

    let data = await response.json();

    document.querySelector(".city").innerHTML = data.name;
    document.querySelector(".temp").innerHTML = Math.round(data.main.temp) + "°C";
    document.querySelector(".humidity").innerHTML = data.main.humidity + "%";
    document.querySelector(".air").innerHTML = data.wind.speed + " km/h";

    
    if (data.weather[0].main == "Clouds") {
        weatherIcon.src = "./images/white-cloud.png";
    } else if (data.weather[0].main == "Clear") {
        weatherIcon.src = "./images/clear.png";
    } else if (data.weather[0].main == "Rain") {
        weatherIcon.src = "./images/rainingcloud.png";
    } else if (data.weather[0].main == "Drizzle") {
        weatherIcon.src = "./images/drizzle.png";
    } else if (data.weather[0].main == "Mist") {
        weatherIcon.src = "./images/mist.png";
    }
}

searchBtn.addEventListener("click", () => {
    const city = searchBox.value.trim();
    if (city !== "") {
        getWeather(city);
    } else {
        alert("Please enter a city name!");
    }
});
