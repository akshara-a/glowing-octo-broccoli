const weatherDiv = document.getElementById("weather");

async function getWeather() {

    const city = document.getElementById("city").value.trim();

    if(city===""){
        weatherDiv.innerHTML="Please enter a city.";
        return;
    }

    try{

        // Step 1: Get city coordinates
        const geoResponse = await fetch(
            `https://geocoding-api.open-meteo.com/v1/search?name=${city}&count=1`
        );

        const geoData = await geoResponse.json();

        if(!geoData.results){
            weatherDiv.innerHTML="City not found.";
            return;
        }

        const latitude = geoData.results[0].latitude;
        const longitude = geoData.results[0].longitude;
        const cityName = geoData.results[0].name;
        const country = geoData.results[0].country;

        // Step 2: Get weather
        const weatherResponse = await fetch(
            `https://api.open-meteo.com/v1/forecast?latitude=${latitude}&longitude=${longitude}&current=temperature_2m,relative_humidity_2m,wind_speed_10m`
        );

        const weatherData = await weatherResponse.json();

        const current = weatherData.current;

        weatherDiv.innerHTML = `
            <h2>${cityName}, ${country}</h2>

            <p>🌡 Temperature : ${current.temperature_2m} °C</p>

            <p>💧 Humidity : ${current.relative_humidity_2m}%</p>

            <p>🌬 Wind Speed : ${current.wind_speed_10m} km/h</p>
        `;

    }
    catch(error){

        weatherDiv.innerHTML="Unable to fetch weather.";

        console.log(error);

    }

}
