const cityInput = document.getElementById("cityInput");

const searchBtn = document.getElementById("searchBtn");

const loading = document.getElementById("loading");

const error = document.getElementById("error");

const weatherCard = document.getElementById("weatherResult");

async function getWeather() {

    const city = cityInput.value.trim();

    error.textContent = "";

    weatherCard.style.display = "none";

    if(city===""){

        error.textContent="Please enter a city name";

        return;
    }

    loading.textContent="Loading...";

    try{

        const response=await fetch(
`https://api.openweathermap.org/data/2.5/weather?q=${city}&appid=${API_KEY}&units=metric`
        );

        if(response.status===401){

            throw new Error("Invalid API key or request failed");
        }

        if(response.status===404){

            throw new Error("City not found");
        }

        if(!response.ok){

            throw new Error("Unable to fetch weather data");
        }

        const data=await response.json();

        loading.textContent="";

        document.getElementById("city").textContent=
        `${data.name}, ${data.sys.country}`;

        document.getElementById("temp").textContent=
        `Temperature : ${data.main.temp} °C`;

        document.getElementById("condition").textContent=
        `Condition : ${data.weather[0].main}`;

        document.getElementById("description").textContent=
        `Description : ${data.weather[0].description}`;

        document.getElementById("humidity").textContent=
        `Humidity : ${data.main.humidity}%`;

        document.getElementById("wind").textContent=
        `Wind Speed : ${data.wind.speed} m/s`;

        weatherCard.style.display="block";

    }

    catch(err){

        loading.textContent="";

        error.textContent=err.message;

    }

}

searchBtn.addEventListener("click",getWeather);

cityInput.addEventListener("keypress",function(e){

    if(e.key==="Enter"){

        getWeather();

    }

});