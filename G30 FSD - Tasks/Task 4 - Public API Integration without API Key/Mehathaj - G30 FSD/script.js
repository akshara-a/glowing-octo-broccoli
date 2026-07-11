async function fetchWeather() {
    const city = document.getElementById("searchInput").value.trim();

    if (city === "") {
        alert("Please enter a city name.");
        return;
    }

    try {
        // ---- Step 1: Get latitude & longitude ----
        const geoURL = `https://geocoding-api.open-meteo.com/v1/search?name=${city}`;
        const geoRes = await fetch(geoURL);
        const geoData = await geoRes.json();

        if (!geoData.results || geoData.results.length === 0) {
            alert("City not found. Try another name.");
            return;
        }

        const location = geoData.results[0];
        const lat = location.latitude;
        const lon = location.longitude;

        // ---- Step 2: Fetch Weather Data ----
        const weatherURL = `
            https://api.open-meteo.com/v1/forecast?
            latitude=${lat}&longitude=${lon}
            &current=temperature_2m,relative_humidity_2m,wind_speed_10m,
            wind_direction_10m,cloud_cover,pressure_msl,visibility,
            uv_index,apparent_temperature
            &hourly=pm10,pm2_5,carbon_monoxide,nitrogen_dioxide,sulphur_dioxide,ozone
            &timezone=auto
        `.replace(/\s+/g, "");

        const weatherRes = await fetch(weatherURL);
        const weatherData = await weatherRes.json();

        updateUI(location, weatherData);

    } catch (error) {
        console.error("Weather Fetch Error:", error);
        alert("Something went wrong. Please try again.");
    }
}

function updateUI(location, weather) {

    const current = weather.current;

    // ---- HERO SECTION ----
    document.getElementById("cityName").innerText =
        `${location.name}, ${location.country}`;

    document.getElementById("localtime").innerText = "Local Time";

    document.getElementById("temperature").innerText = current.temperature_2m + "° C";
    document.getElementById("conditionText").innerText = "Weather Information";

    // Static placeholder icon
    document.getElementById("weatherIcon").src =
        "https://cdn-icons-png.flaticon.com/512/1163/1163661.png";

    // ---- WEATHER CARDS ----
    document.getElementById("humidity").innerText = current.relative_humidity_2m + "%";
    document.getElementById("wind").innerText = current.wind_speed_10m + " km/h";
    document.getElementById("pressure").innerText = current.pressure_msl + " mb";
    document.getElementById("visibility").innerText = current.visibility + " m";
    document.getElementById("cloud").innerText = current.cloud_cover + "%";
    document.getElementById("feelslike").innerText = current.apparent_temperature + "° C";
    document.getElementById("uv").innerText = current.uv_index;

    // ---- AIR QUALITY ---- (Some cities have missing data → FIXED)
    const aq = weather.hourly;

    document.getElementById("pm25").innerText = aq.pm2_5?.[0] ?? "N/A";
    document.getElementById("pm10").innerText = aq.pm10?.[0] ?? "N/A";
    document.getElementById("o3").innerText = aq.ozone?.[0] ?? "N/A";
    document.getElementById("no2").innerText = aq.nitrogen_dioxide?.[0] ?? "N/A";
    document.getElementById("so2").innerText = aq.sulphur_dioxide?.[0] ?? "N/A";
    document.getElementById("co").innerText = aq.carbon_monoxide?.[0] ?? "N/A";
}
