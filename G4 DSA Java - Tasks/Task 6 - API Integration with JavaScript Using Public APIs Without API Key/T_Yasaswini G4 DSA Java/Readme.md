# Weather Dashboard

## Project Description

The Weather Dashboard is a simple frontend web application built using HTML, CSS, and JavaScript. It fetches and displays real-time weather information based on the latitude and longitude entered by the user. The application uses the Open-Meteo Weather API and dynamically displays weather details on the webpage.

---

## Selected API

**API Name:** Open-Meteo Weather API

**API Type:** Public API (No API Key Required)

**API Endpoint:**

https://api.open-meteo.com/v1/forecast

**Example API URL:**

https://api.open-meteo.com/v1/forecast?latitude=13.08&longitude=80.27&current=temperature_2m,wind_speed_10m

---

## Short Explanation of Selected API

The Open-Meteo Weather API is a free public weather API that provides current weather and forecast information without requiring an API key. It allows developers to retrieve weather data by sending latitude and longitude as query parameters.

In this project, JavaScript's `fetch()` method is used to request weather data from the API. The API returns the response in JSON format, which is processed and displayed dynamically on the webpage. Since no authentication is required, it is ideal for beginner frontend projects.

---

## Technologies Used

- HTML5
- CSS3
- JavaScript (ES6)
- Fetch API
- Open-Meteo Weather API

---

## Features

- Fetch current weather using Fetch API
- No API key required
- User input for Latitude and Longitude
- Default city buttons
- Dynamic weather display
- Loading message while fetching data
- Error handling using try...catch
- Empty input validation
- Responsive and clean user interface

---

## API Response Fields Used

| Response Field | Description | Used For |
|---------------|-------------|----------|
| `latitude` | Latitude of the selected location | Display location latitude |
| `longitude` | Longitude of the selected location | Display location longitude |
| `current.time` | Time when weather data was recorded | Display current weather time |
| `current.temperature_2m` | Current temperature (°C) | Display temperature |
| `current.wind_speed_10m` | Current wind speed (km/h) | Display wind speed |

---

## Sample API Response

```json
{
  "latitude": 13.08,
  "longitude": 80.27,
  "current": {
    "time": "2026-07-05T15:30",
    "temperature_2m": 31.4,
    "wind_speed_10m": 12.7
  }
}
```

---

## Folder Structure

```
weather-dashboard/
│
├── index.html
├── style.css
├── script.js
└── README.md
```

---

## How to Run

1. Download all project files.
2. Keep all files in the same folder.
3. Open `index.html` in any modern web browser.
4. Enter Latitude and Longitude or click a default city.
5. Click **Get Weather**.
6. View the current weather details.

---

## Validation

- Displays a validation message if Latitude or Longitude is empty.
- Displays a loading message while data is being fetched.
- Displays an error message if the API request fails.

---

## Expected Output

```
Weather Dashboard

Location
Latitude : 13.08
Longitude : 80.27

Current Weather

Temperature : 31°C
Wind Speed : 12 km/h
Time : 2026-07-05T15:30
```


## Conclusion

This project demonstrates how to integrate a public REST API into a frontend web application using JavaScript. It helps understand API requests, JSON data handling, DOM manipulation, input validation, loading states, and error handling while building a practical weather dashboard.