const API = config.WEATHER_API_KEY;

async function fetchWeather() {
    const city = document.getElementById("cityInput").value.trim();
    if (!city) return;

    const res = await fetch(
        `https://api.weatherapi.com/v1/current.json?key=${API}&q=${city}&aqi=yes`
    );
    const data = await res.json();

    updateUI(data);
}

function updateUI(data) {
    const loc = data.location;
    const curr = data.current;

    // HERO CONTENT
    document.getElementById("cityName").innerText = `${loc.name}, ${loc.country}`;
    document.getElementById("localTime").innerText = loc.localtime;
    document.getElementById("temperature").innerText = `${curr.temp_c}°C`;
    document.getElementById("conditionText").innerText = curr.condition.text;
    document.getElementById("weatherIcon").src = curr.condition.icon;

    // WEATHER CARDS
    document.getElementById("windCard").innerHTML = `<h3>Wind</h3><p>${curr.wind_kph} kph</p>`;
    document.getElementById("humidityCard").innerHTML = `<h3>Humidity</h3><p>${curr.humidity}%</p>`;
    document.getElementById("pressureCard").innerHTML = `<h3>Pressure</h3><p>${curr.pressure_mb} mb</p>`;
    document.getElementById("visibilityCard").innerHTML = `<h3>Visibility</h3><p>${curr.vis_km} km</p>`;
    document.getElementById("cloudCard").innerHTML = `<h3>Cloud</h3><p>${curr.cloud}%</p>`;
    document.getElementById("feelsCard").innerHTML = `<h3>Feels Like</h3><p>${curr.feelslike_c}°C</p>`;

    // AIR QUALITY
    const aq = curr.air_quality;
    document.getElementById("co").innerHTML = `<h3>CO</h3><p>${aq.co}</p>`;
    document.getElementById("no2").innerHTML = `<h3>NO₂</h3><p>${aq.no2}</p>`;
    document.getElementById("o3").innerHTML = `<h3>O₃</h3><p>${aq.o3}</p>`;
    document.getElementById("so2").innerHTML = `<h3>SO₂</h3><p>${aq.so2}</p>`;
    document.getElementById("pm25").innerHTML = `<h3>PM2.5</h3><p>${aq.pm2_5}</p>`;
    document.getElementById("pm10").innerHTML = `<h3>PM10</h3><p>${aq.pm10}</p>`;

    // BACKGROUND IMAGE SWITCHER
    setBackground(curr.condition.text);
}

function setBackground(condition) {
    let bg = document.getElementById("bgImage");
    condition = condition.toLowerCase();

    if (condition.includes("cloud")) {
        bg.style.backgroundImage = "url('https://images.unsplash.com/photo-1527489377706-5cc1c86c5d48')";
    } else if (condition.includes("rain")) {
        bg.style.backgroundImage = "url('https://images.unsplash.com/photo-1500579812698-4feab1a46a0b')";
    } else if (condition.includes("sunny") || condition.includes("clear")) {
        bg.style.backgroundImage = "url('https://images.unsplash.com/photo-1501973801540-537f08ccae7b')";
    } else if (condition.includes("snow")) {
        bg.style.backgroundImage = "url('https://images.unsplash.com/photo-1608889175123-7d0f495facac')";
    } else {
        bg.style.backgroundImage = "url('https://images.unsplash.com/photo-1503264116251-35a269479413')";
    }
}