const weatherCodes = {
        0: "Clear sky",
        2: "Partly cloudy",
        45: "Fog",
        61: "Light rain",
        65: "Heavy rain",
        71: "Light snow",
        80: "Rain showers",
        95: "Thunderstorm",
      };

      document
        .getElementById("getWeatherBtn")
        .addEventListener("click", async function () {
          const city = document.getElementById("cityInput").value.trim();
          const resultBox = document.getElementById("weatherResult");

          if (!city) {
            resultBox.innerHTML =
              '<p class="error">Please enter a city name.</p>';
            return;
          }

          resultBox.innerHTML =
            '<p class="loading">Fetching weather data...</p>';

          try {
            const geoResponse = await fetch(
              `https://geocoding-api.open-meteo.com/v1/search?name=${encodeURIComponent(
                city
              )}`
            );
            const geoData = await geoResponse.json();

            if (!geoData.results || geoData.results.length === 0) {
              resultBox.innerHTML = `<p class="error">City not found. Please check the name.</p>`;
              return;
            }

            const { latitude, longitude } = geoData.results[0];

            const weatherResponse = await fetch(
              `https://api.open-meteo.com/v1/forecast?latitude=${latitude}&longitude=${longitude}&current_weather=true`
            );
            const weatherData = await weatherResponse.json();
            const weather = weatherData.current_weather;

            resultBox.innerHTML = `
          <p><strong>Temperature:</strong> ${weather.temperature} °C</p>
          <p><strong>Wind Speed:</strong> ${weather.windspeed} km/h</p>
          <p><strong>Weather:</strong> ${
            weatherCodes[weather.weathercode] || "Unknown"
          }</p>
        `;
          } catch (error) {
            console.error("Error fetching weather:", error);
            resultBox.innerHTML = `<p class="error">Failed to fetch weather data. Please try again.</p>`;
          }
        });
