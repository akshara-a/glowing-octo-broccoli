const codes = {0:'Clear',1:'Mainly clear',2:'Partly cloudy',3:'Overcast',45:'Foggy',61:'Rainy',71:'Snowy',95:'Thunderstorm'};

// Function 1: current location ka weather
function getWeather() {
  document.getElementById('place').textContent = 'Getting location…';

  navigator.geolocation.getCurrentPosition(async (pos) => {
    const { latitude, longitude } = pos.coords;
    const res = await fetch(`https://api.open-meteo.com/v1/forecast?latitude=${latitude}&longitude=${longitude}&current_weather=true`);
    const data = await res.json();
    const w = data.current_weather;

    document.getElementById('place').textContent = `Lat ${latitude.toFixed(2)}, Lon ${longitude.toFixed(2)}`;
    document.getElementById('temp').textContent = w.temperature + '°C';
    document.getElementById('condition-text').textContent = codes[w.weathercode] || 'Unknown';
    document.getElementById('wind').textContent = w.windspeed + ' km/h';
  }, () => {
    document.getElementById('status').textContent = 'Location permission denied.';
  });
}

// Function 2: city name daal ke uski humidity
async function getHumidity() {
  const city = document.getElementById('city').value;

  const geo = await fetch(`https://geocoding-api.open-meteo.com/v1/search?name=${city}`);
  const geoData = await geo.json();
  const { latitude, longitude } = geoData.results[0];

  const res = await fetch(`https://api.open-meteo.com/v1/forecast?latitude=${latitude}&longitude=${longitude}&current=relative_humidity_2m`);
  const data = await res.json();

  document.getElementById('result').textContent = data.current.relative_humidity_2m + '% humidity';
}

getWeather();
document.getElementById('refresh-btn').addEventListener('click', getWeather);