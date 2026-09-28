const latitude=document.getElementById("latitude");
const longitude=document.getElementById("longitude");
const weatherBtn=document.getElementById("weatherBtn");

const loading=document.getElementById("loading");
const error=document.getElementById("error");

const lat=document.getElementById("lat");
const lon=document.getElementById("lon");
const temp=document.getElementById("temp");
const wind=document.getElementById("wind");
const time=document.getElementById("time");

async function getWeather(){

const latValue=latitude.value.trim();
const lonValue=longitude.value.trim();

error.innerHTML="";
loading.innerHTML="";
    
if(latValue==="" || lonValue===""){
error.innerHTML="Please enter Latitude and Longitude";
return;
}

loading.innerHTML="Loading data...";

try{

const url=`https://api.open-meteo.com/v1/forecast?latitude=${latValue}&longitude=${lonValue}&current=temperature_2m,wind_speed_10m`;

const response=await fetch(url);

if(!response.ok){
throw new Error();
}

const data=await response.json();

loading.innerHTML="";

lat.innerHTML=data.latitude;
lon.innerHTML=data.longitude;
temp.innerHTML=data.current.temperature_2m+" °C";
wind.innerHTML=data.current.wind_speed_10m+" km/h";
time.innerHTML=data.current.time;

}
catch{

loading.innerHTML="";
error.innerHTML="Unable to fetch weather data.";

}

}

weatherBtn.addEventListener("click",getWeather);

document.querySelectorAll(".city").forEach(button=>{

button.addEventListener("click",()=>{

latitude.value=button.dataset.lat;
longitude.value=button.dataset.lon;

getWeather();

});

});

document.addEventListener("keypress",(e)=>{

if(e.key==="Enter"){

getWeather();

}

});