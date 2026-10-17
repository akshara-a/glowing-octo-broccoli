const cityInput = document.getElementById("city");
const searchBtn = document.getElementById("searchBtn");
const message = document.getElementById("message");

const weatherCard = document.getElementById("weatherCard");

searchBtn.addEventListener("click", getWeather);

cityInput.addEventListener("keypress", function(e){
    if(e.key==="Enter"){
        getWeather();
    }
});

async function getWeather(){

    const city = cityInput.value.trim();

    if(city===""){
        message.innerHTML="Please enter a city name";
        weatherCard.style.display="none";
        return;
    }

    message.innerHTML="Loading...";
    weatherCard.style.display="none";

    const url=`https://api.openweathermap.org/data/2.5/weather?q=${city}&appid=${API_KEY}&units=metric`;

    try{

        const response=await fetch(url);

        if(!response.ok){
            throw new Error("City not found");
        }

        const data=await response.json();

        document.getElementById("location").innerHTML=`${data.name}, ${data.sys.country}`;
        document.getElementById("temperature").innerHTML=`🌡 Temperature : ${data.main.temp} °C`;
        document.getElementById("condition").innerHTML=`☁ Condition : ${data.weather[0].main}`;
        document.getElementById("description").innerHTML=`📝 Description : ${data.weather[0].description}`;
        document.getElementById("humidity").innerHTML=`💧 Humidity : ${data.main.humidity}%`;
        document.getElementById("wind").innerHTML=`🌬 Wind Speed : ${data.wind.speed} m/s`;

        weatherCard.style.display="block";
        message.innerHTML="";

    }
    catch(error){
        message.innerHTML=error.message;
        weatherCard.style.display="none";
    }

}