async function fetchData() {

    const city = document.getElementById("cityInput").value;

    const uri = `https://api.openweathermap.org/data/2.5/weather?q=${city}&appid=${CONFIG.OPENWEATHER_API_KEY}&units=metric`;

    try {
        const response = await fetch(uri);
        const data = await response.json();

        document.getElementById("lon").innerHTML = data.coord.lon;
        document.getElementById("lat").innerHTML = data.coord.lat;
        document.getElementById("temp").innerHTML = data.main.temp;
        document.getElementById("humidity").innerHTML = data.main.humidity;
        document.getElementById("city").innerHTML = data.name;
    }
    catch (error) {
        console.error("Error fetching weather information", error)
    }
}