async function getWeather(){

    const latitude=document.getElementById("latitude").value;
    const longitude=document.getElementById("longitude").value;

    const loading=document.getElementById("loading");
    const error=document.getElementById("error");
    const weather=document.getElementById("weather");

    weather.innerHTML="";
    error.innerHTML="";

    if(latitude==="" || longitude===""){
        error.innerHTML="Please enter latitude and longitude.";
        return;
    }

    loading.innerHTML="Loading...";

    const url=`https://api.open-meteo.com/v1/forecast?latitude=${latitude}&longitude=${longitude}&current=temperature_2m,wind_speed_10m`;

    try{

        const response=await fetch(url);

        if(!response.ok){
            throw new Error("Failed");
        }

        const data=await response.json();

        loading.innerHTML="";

        weather.innerHTML=`
            <h3>Current Weather</h3>
            <p><strong>Latitude:</strong> ${data.latitude}</p>
            <p><strong>Longitude:</strong> ${data.longitude}</p>
            <p><strong>Temperature:</strong> ${data.current.temperature_2m} °C</p>
            <p><strong>Wind Speed:</strong> ${data.current.wind_speed_10m} km/h</p>
            <p><strong>Time:</strong> ${data.current.time}</p>
        `;

    }
    catch(err){

        loading.innerHTML="";
        error.innerHTML="Unable to fetch weather data.";

    }

}
