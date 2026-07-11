async function getWeather(){

const city=document.getElementById("city").value;

const loading=document.getElementById("loading");
const error=document.getElementById("error");
const weather=document.getElementById("weather");

loading.innerHTML="";
error.innerHTML="";
weather.innerHTML="";

if(city===""){
error.innerHTML="Please enter a city.";
return;
}

loading.innerHTML="Loading...";

const url=`https://api.openweathermap.org/data/2.5/weather?q=${city}&appid=${API_KEY}&units=metric`;

try{

const response=await fetch(url);

if(!response.ok){
throw new Error();
}

const data=await response.json();

loading.innerHTML="";

weather.innerHTML=`
<h3>${data.name}</h3>

<p><strong>Temperature:</strong> ${data.main.temp} °C</p>

<p><strong>Humidity:</strong> ${data.main.humidity}%</p>

<p><strong>Weather:</strong> ${data.weather[0].description}</p>

<p><strong>Wind Speed:</strong> ${data.wind.speed} m/s</p>
`;

}
catch{

loading.innerHTML="";
error.innerHTML="Unable to fetch weather.";

}

}
