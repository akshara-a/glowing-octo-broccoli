document.getElementById("weatherBtn").addEventListener("click", getWeather);

async function getWeather() {
  const city = document.getElementById("cityInput").value.trim();
  const resultDiv = document.getElementById("weatherResult");

  resultDiv.innerHTML = "";

  if (!city) {
    resultDiv.innerHTML = "<p class='error'>Please enter a city name.</p>";
    return;
  }

  const API_KEY = CONFIG.OPENWEATHER_KEY;


  resultDiv.innerHTML = "<p>Loading...</p>";

  try {
    const res = await fetch(
      `https://api.openweathermap.org/data/2.5/weather?q=${city}&units=metric&appid=${API_KEY}`
    );

    if (!res.ok) throw new Error("Invalid city name");

    const data = await res.json();

    resultDiv.innerHTML = `
      <h3>${data.name}</h3>
      <p><strong>Temperature:</strong> ${data.main.temp}°C</p>
      <p><strong>Feels Like:</strong> ${data.main.feels_like}°C</p>
      <p><strong>Humidity:</strong> ${data.main.humidity}%</p>
      <p><strong>Description:</strong> ${data.weather[0].description}</p>
    `;

  } catch (err) {
    resultDiv.innerHTML = `<p class='error'>${err.message}</p>`;
  }
}
