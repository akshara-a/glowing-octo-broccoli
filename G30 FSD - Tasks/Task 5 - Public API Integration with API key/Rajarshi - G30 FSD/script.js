// const apiKey = (CONFIG.API_KEY); 

console.log(CONFIG.API_KEY);
document.getElementById("searchBtn").addEventListener("click", getWeather);

async function getWeather() {
    const city = document.getElementById("cityInput").value;
    if(city.trim()==="") return;

    document.getElementById("loader").classList.remove("hide");

    try{
        const url=`https://api.openweathermap.org/data/2.5/weather?q=${city}&units=metric&appid=${CONFIG.API_KEY}`;
        let res=await fetch(url);
        let data=await res.json();

        if(data.cod !== 200) throw data.message;

        document.getElementById("loader").classList.add("hide");
        document.getElementById("weatherDisplay").classList.remove("hide");
        
        document.getElementById("temp").innerText = Math.round(data.main.temp)+"°C";
        document.getElementById("cityName").innerText = data.name;
        document.getElementById("desc").innerText = data.weather[0].description;

        document.getElementById("humidity").innerText = data.main.humidity+"%";
        document.getElementById("feelsLike").innerText = Math.round(data.main.feels_like)+"°C";

        let iconId=data.weather[0].icon;
        document.getElementById("weatherIcon").src=`https://openweathermap.org/img/wn/${iconId}@2x.png`;

        changeBackground(data.weather[0].main.toLowerCase());

    }catch(err){
        document.getElementById("loader").classList.add("hide");
        showError("City not found!");
    }
}

function showError(msg){
    const box=document.getElementById("errorMessage");
    box.textContent=msg;
    box.classList.remove("hide");
    setTimeout(()=>box.classList.add("hide"),2000);
}

// LIVE BACKGROUND CHANGER
function changeBackground(weather){
    const bg=document.getElementById("appBg");

    if(weather.includes("cloud")) bg.className="cloudy";
    else if(weather.includes("rain")) bg.className="rainy";
    else if(weather.includes("clear")) bg.className="sunny";
    else if(weather.includes("snow")) bg.className="snow";
    else if(weather.includes("mist")||weather.includes("fog")||weather.includes("haze")) bg.className="fog";
    else bg.className="defaultBG";
}
