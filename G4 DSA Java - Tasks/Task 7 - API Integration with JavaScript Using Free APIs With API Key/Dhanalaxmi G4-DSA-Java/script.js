const cityInput = document.getElementById("cityInput");
const searchBtn = document.getElementById("searchBtn");
const loading = document.getElementById("loading");
const error = document.getElementById("error");
const weatherCard = document.getElementById("weatherCard");

searchBtn.addEventListener("click", getWeather);

cityInput.addEventListener("keypress", function(event){

    if(event.key==="Enter"){

        getWeather();
    }

});

async function getWeather(){

    const city = cityInput.value.trim();

    weatherCard.innerHTML="";
    error.innerHTML="";

    if(city===""){

        error.innerHTML="Please enter a city name.";

        return;
    }

    loading.innerHTML="Loading...";

    const url=`https://api.openweathermap.org/data/2.5/weather?q=${city}&appid=${API_KEY}&units=metric`;

    try{

        const response=await fetch(url);

        const data=await response.json();

        loading.innerHTML="";

        if(response.status!==200){

            error.innerHTML=data.message;

            return;
        }

        const icon=`https://openweathermap.org/img/wn/${data.weather[0].icon}@2x.png`;

        weatherCard.innerHTML=`

        <div class="card">

        <h2>${data.name}, ${data.sys.country}</h2>

        <img src="${icon}" alt="Weather Icon">

        <p><strong>Temperature:</strong> ${data.main.temp} °C</p>

        <p><strong>Condition:</strong> ${data.weather[0].main}</p>

        <p><strong>Description:</strong> ${data.weather[0].description}</p>

        <p><strong>Humidity:</strong> ${data.main.humidity}%</p>

        <p><strong>Wind Speed:</strong> ${data.wind.speed} m/s</p>

        </div>

        `;

    }

    catch(err){

        loading.innerHTML="";

        error.innerHTML="Unable to fetch weather data.";

    }

}