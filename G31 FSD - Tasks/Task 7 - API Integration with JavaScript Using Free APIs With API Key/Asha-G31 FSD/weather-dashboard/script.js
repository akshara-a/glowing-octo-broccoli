const cityInput = document.getElementById("cityInput");
const searchBtn = document.getElementById("searchBtn");
const message = document.getElementById("message");
const weatherResult = document.getElementById("weatherResult");

searchBtn.addEventListener("click", () => {

    const city = cityInput.value.trim();

    if(city === ""){
        message.textContent = "Please enter a city name";
        weatherResult.innerHTML = "";
        return;
    }

    getWeather(city);

});

cityInput.addEventListener("keypress", function(event){

    if(event.key === "Enter"){
        searchBtn.click();
    }

});

async function getWeather(city){

    message.textContent = "Loading...";
    weatherResult.innerHTML = "";

    const url =
    `https://api.openweathermap.org/data/2.5/weather?q=${city}&appid=${API_KEY}&units=metric`;

    try{

        const response = await fetch(url);

        const data = await response.json();

        if(data.cod != 200){
            message.textContent = "City not found";
            return;
        }

        message.textContent = "";

        weatherResult.innerHTML = `
            <h2>${data.name}, ${data.sys.country}</h2>

            <h3>${data.main.temp} °C</h3>

            <p><strong>Condition:</strong> ${data.weather[0].main}</p>

            <p><strong>Description:</strong> ${data.weather[0].description}</p>

            <p><strong>Humidity:</strong> ${data.main.humidity}%</p>

            <p><strong>Wind Speed:</strong> ${data.wind.speed} m/s</p>
        `;

    }
    catch(error){

        message.textContent = "Unable to fetch weather data.";

    }

}