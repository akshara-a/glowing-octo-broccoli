document.getElementById("btn").addEventListener("click", getWeather);

function getWeather() {
    const city = document.getElementById("city").value;

    if (!city) {
        alert("Please enter city name");
        return;
    }

    const url = `https://api.weatherapi.com/v1/current.json?key=${WEATHER_KEY}&q=${encodeURIComponent(city)}`;

    document.getElementById("weather-result").innerHTML = "Loading...";

    fetch(url)
        .then(res => res.json())
        .then(data => {
            if (data.error) {
                document.getElementById("weather-result").innerHTML = "Invalid City!";
                return;
            }

            const result = `
                <p>Temperature: ${data.current.temp_c} °C</p>
                <p>Humidity: ${data.current.humidity}</p>
                <p>Feels Like: ${data.current.feelslike_c} °C</p>
                <p>Weather: ${data.current.condition.text}</p>
            `;
            document.getElementById("weather-result").innerHTML = result;
        })
        .catch(err => {
            document.getElementById("weather-result").innerHTML = "Error fetching data";
        });
}