const cityInput = document.getElementById("cityInput");
const searchBtn = document.getElementById("searchBtn");
const weatherCard = document.getElementById("weatherCard");
const loading = document.getElementById("loading");
const error = document.getElementById("error");

searchBtn.addEventListener("click", getWeather);

cityInput.addEventListener("keypress", function(event){
    if(event.key === "Enter"){
        getWeather();
    }
});

async function getWeather(){

    const city = cityInput.value.trim();

    weatherCard.style.display = "none";
    weatherCard.innerHTML = "";
    loading.textContent = "";
    error.textContent = "";

    if(city === ""){
        error.textContent = "Please enter a city name.";
        return;
    }

    loading.textContent = "Loading weather data...";

    try{

        const url = `https://api.openweathermap.org/data/2.5/weather?q=${city}&appid=${API_KEY}&units=metric`;

        const response = await fetch(url);

        if(!response.ok){
            throw new Error("City not found");
        }

        const data = await response.json();

        loading.textContent = "";

        weatherCard.style.display = "block";

        weatherCard.innerHTML = `
            <img src="https://openweathermap.org/img/wn/${data.weather[0].icon}@2x.png" alt="Weather Icon">

            <h2>${data.name}, ${data.sys.country}</h2>

            <div class="weather-details">

                <div class="detail-row">
                    <span>🌡 Temperature</span>
                    <span>${Math.round(data.main.temp)}°C</span>
                </div>

                <div class="detail-row">
                    <span>☁ Condition</span>
                    <span>${data.weather[0].main}</span>
                </div>

                <div class="detail-row">
                    <span>📝 Description</span>
                    <span>${data.weather[0].description.replace(/\b\w/g, c => c.toUpperCase())}</span>
                </div>

                <div class="detail-row">
                    <span>💧 Humidity</span>
                    <span>${data.main.humidity}%</span>
                </div>

                <div class="detail-row">
                    <span>💨 Wind Speed</span>
                    <span>${data.wind.speed} m/s</span>
                </div>

            </div>
        `;

    }
    catch(err){

        loading.textContent = "";
        weatherCard.style.display = "none";

        if(err.message === "City not found"){
            error.textContent = "City not found.";
        }
        else{
            error.textContent = "Unable to fetch weather data.";
        }

    }

}