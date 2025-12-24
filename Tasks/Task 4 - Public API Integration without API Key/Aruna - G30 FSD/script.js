const cities = [
  { name: "Hyderabad", lat: 17.385, lon: 78.4867 },
  { name: "Mumbai", lat: 19.076, lon: 72.8777 },
  { name: "Delhi", lat: 28.7041, lon: 77.1025 },
];

let index = 0;
document.getElementById("getWeatherBtn").addEventListener("click", () => {
  let city = cities[index];

  let url = `https://api.open-meteo.com/v1/forecast?latitude=${city.lat}&longitude=${city.lon}&current_weather=true`;

  fetch(url)
    .then((res) => res.json())
    .then((data) => {
      document.getElementById("city").textContent = city.name;
      document.getElementById("temp").textContent =
        data.current_weather.temperature + "°C";
      document.getElementById("wind").textContent =
        data.current_weather.windspeed + " km/h";
      document.getElementById("code").textContent =
        data.current_weather.weathercode;
    })
    .catch((error) => {
      console.error("Error:", error);
      alert("Failed to fetch weather data.");
    });
  index = (index + 1) % cities.length;
});
