// WEATHER
document.getElementById("weatherBtn").addEventListener("click", getWeather);

async function getWeather() {
  const city = document.getElementById("cityInput").value.trim();
  if (!city) return showWeatherError("Enter a city name");

  toggleWeatherLoading(true);

  try {
    const url = `https://api.openweathermap.org/data/2.5/weather?q=${city}&appid=${OPENWEATHER_API_KEY}&units=metric`;
    const res = await fetch(url);
    const data = await res.json();

    if (data.cod !== 200) throw new Error("City not found");

    document.getElementById("temp").innerText = `Temperature: ${data.main.temp} °C`;
    document.getElementById("humidity").innerText = `Humidity: ${data.main.humidity}%`;
    document.getElementById("feelsLike").innerText = `Feels Like: ${data.main.feels_like} °C`;
    document.getElementById("description").innerText = `Weather: ${data.weather[0].description}`;

    document.getElementById("weatherResult").classList.remove("hidden");
    document.getElementById("weatherError").classList.add("hidden");
  } catch (err) {
    showWeatherError(err.message);
  }

  toggleWeatherLoading(false);
}

function toggleWeatherLoading(show) {
  document.getElementById("weatherLoading").classList.toggle("hidden", !show);
}

function showWeatherError(msg) {
  document.getElementById("weatherError").innerText = msg;
  document.getElementById("weatherError").classList.remove("hidden");
}

// SENTIMENT
document.getElementById("sentimentBtn").addEventListener("click", analyzeSentiment);

async function analyzeSentiment() {
  const text = document.getElementById("textInput").value.trim();
  if (!text) return showSentimentError("Enter some text");

  toggleSentimentLoading(true);

  try {
    const formData = new FormData();
    formData.append("key", MEANINGCLOUD_API_KEY);
    formData.append("txt", text);
    formData.append("lang", "en");

    const res = await fetch("https://api.meaningcloud.com/sentiment-2.1", {
      method: "POST",
      body: formData
    });

    const data = await res.json();
    if (!data.score_tag) throw new Error("Analysis failed");

    let sentiment = "Neutral";
    if (["P", "P+"].includes(data.score_tag)) sentiment = "Positive";
    if (["N", "N+"].includes(data.score_tag)) sentiment = "Negative";

    document.getElementById("sentiment").innerText = `Sentiment: ${sentiment}`;
    document.getElementById("confidence").innerText = `Confidence: ${data.confidence}`;

    document.getElementById("sentimentResult").classList.remove("hidden");
    document.getElementById("sentimentError").classList.add("hidden");
  } catch (err) {
    showSentimentError(err.message);
  }

  toggleSentimentLoading(false);
}

function toggleSentimentLoading(show) {
  document.getElementById("sentimentLoading").classList.toggle("hidden", !show);
}

function showSentimentError(msg) {
  document.getElementById("sentimentError").innerText = msg;
  document.getElementById("sentimentError").classList.remove("hidden");
}