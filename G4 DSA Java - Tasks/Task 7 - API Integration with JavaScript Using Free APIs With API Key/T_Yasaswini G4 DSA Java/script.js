const cityInput = document.getElementById("cityInput");
const searchBtn = document.getElementById("searchBtn");
const message = document.getElementById("message");
const weatherCard = document.getElementById("weatherCard");

searchBtn.addEventListener("click", getWeather);

cityInput.addEventListener("keypress", function(e){
    if(e.key === "Enter"){
        getWeather();
    }
});

async function getWeather(){

    const city = cityInput.value.trim();

    if(city === ""){
        message.textContent = "Please enter a city name";
        weatherCard.style.display = "none";
        return;
    }

    message.textContent = "Loading...";

    try{

        const url =
        `https://api.openweathermap.org/data/2.5/weather?q=${city}&appid=${API_KEY}&units=metric`;

        const response = await fetch(url);

        const data = await response.json();

        if(response.status === 401){
            message.textContent = "Invalid API key or request failed";
            weatherCard.style.display = "none";
            return;
        }

        if(response.status === 404){
            message.textContent = "City not found";
            weatherCard.style.display = "none";
            return;
        }

        document.getElementById("city").textContent =
        `${data.name}, ${data.sys.country}`;

        document.getElementById("temp").textContent =
        `${data.main.temp} °C`;

        document.getElementById("condition").textContent =
        data.weather[0].main;

        document.getElementById("description").textContent =
        data.weather[0].description;

        document.getElementById("humidity").textContent =
        `${data.main.humidity}%`;

        document.getElementById("wind").textContent =
        `${data.wind.speed} m/s`;

        message.textContent = "";
        weatherCard.style.display = "block";

    }
    catch(error){
        message.textContent = "Unable to fetch weather data";
        weatherCard.style.display = "none";
    }

}