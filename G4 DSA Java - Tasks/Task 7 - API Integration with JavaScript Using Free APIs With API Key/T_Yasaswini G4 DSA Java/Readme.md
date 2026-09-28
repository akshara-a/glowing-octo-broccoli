# Weather Dashboard

A simple Weather Dashboard built using **HTML, CSS, and JavaScript** that fetches real-time weather information using the **OpenWeatherMap Current Weather API** with API Key Authentication.

---

## Features

* Search weather by city name
* Display city and country
* Display temperature
* Display weather condition
* Display weather description
* Display humidity
* Display wind speed
* Loading message while fetching data
* Error handling for invalid city, invalid API key, and network errors
* Responsive and user-friendly interface

---

## Technologies Used

* HTML5
* CSS3
* JavaScript (ES6)
* Fetch API
* OpenWeatherMap API

---

## Setup Instructions

1. Clone the repository.
2. Create a `config.js` file in the project root.
3. Add your API key inside `config.js`.

```javascript
const API_KEY = "your_api_key_here";
```

4. Open `index.html` in your browser.
5. Do not push `config.js` to GitHub.

---

## Project Structure

```text
api-key-project/
│── index.html
│── style.css
│── script.js
│── config.example.js
│── .gitignore
│── README.md
└── config.js (Local only)
```

---

## API Endpoint

```text
https://api.openweathermap.org/data/2.5/weather?q={city_name}&appid={API_KEY}&units=metric
```

---

## Short Explanation of Selected API

This project uses the **OpenWeatherMap Current Weather API** to retrieve real-time weather information for a user-entered city. The application sends the city name and API key using the `fetch()` method and receives weather data in JSON format, which is displayed dynamically on the webpage.

---

## API Response Fields Used

| Field                    | Description                                 |
| ------------------------ | ------------------------------------------- |
| `name`                   | Name of the city                            |
| `sys.country`            | Country code of the city                    |
| `main.temp`              | Current temperature in Celsius              |
| `main.humidity`          | Humidity percentage                         |
| `weather[0].main`        | Main weather condition (e.g., Clouds, Rain) |
| `weather[0].description` | Detailed weather description                |
| `wind.speed`             | Wind speed in meters per second (m/s)       |

---

## Explanation of API Response Fields Used

* **name** – Displays the city name.
* **sys.country** – Displays the country code.
* **main.temp** – Shows the current temperature in °C.
* **main.humidity** – Shows the humidity percentage.
* **weather[0].main** – Displays the main weather condition.
* **weather[0].description** – Displays a detailed description of the weather.
* **wind.speed** – Displays the wind speed in meters per second (m/s).

---

## Security Note

* Store your API key only in `config.js`.
* Add `config.js` and `.env` to `.gitignore`.
* Push only `config.example.js` to GitHub.
* Never upload your real API key to a public repository.

---



