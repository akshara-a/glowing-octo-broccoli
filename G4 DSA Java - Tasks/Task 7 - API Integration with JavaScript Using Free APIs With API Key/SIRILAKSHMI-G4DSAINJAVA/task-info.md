# Task: API Integration with JavaScript Using Free APIs With API Key

## Task Title

**Building JavaScript Applications Using APIs With API Key Authentication**

---

## Objective

Students must build a simple frontend web application using **HTML, CSS, and JavaScript** by integrating a free public API that requires an API key.

The objective of this task is to help students learn:

* How API keys are used
* How to call APIs using `fetch()`
* How to pass API keys in API requests
* How to read JSON responses
* How to display API data dynamically
* How to handle loading and error states
* How to protect API keys from being pushed to GitHub

---

## Important API Key Instruction

Students must **not push their API key to GitHub**.

### Do Not Push

* `config.js`
* `.env`
* API key
* Any file containing secret keys

---

## Required GitHub Safety Setup

Students must create a local `config.js` file and store the API key there.

### Example `config.js`

```js
const API_KEY = "your_api_key_here";
```

This file should be used only on the student’s local machine.

---

## Required `.gitignore`

Students must create a `.gitignore` file and add:

```gitignore
config.js
.env
```

---

## Required `config.example.js`

Students should create and push a sample config file without the real key.

```js
const API_KEY = "PASTE_YOUR_API_KEY_HERE";
```

This helps others understand the project setup without exposing the actual API key.

---

## Security Note

For this beginner frontend assignment, `config.js` helps avoid accidentally pushing the API key to GitHub.

However, API keys used directly in browser JavaScript are still visible through browser developer tools. For real production applications, API keys should be handled through a backend server or proxy.

---

# API Options

Students can choose **any one** of the following two options.

| Option   | Project                    | API                | Main Concept                       |
| -------- | -------------------------- | ------------------ | ---------------------------------- |
| Option 1 | Weather Dashboard          | OpenWeatherMap API | Weather data using city search     |
| Option 2 | NASA Astronomy Picture App | NASA APOD API      | Space image and explanation viewer |

---

# Option 1: Weather Dashboard Using OpenWeatherMap API

## API Name

**OpenWeatherMap Current Weather API**

---

## API Key Requirement

This API requires a free API key.

Students must create a free account and generate an API key from OpenWeatherMap.

---

## API Endpoint

```text
https://api.openweathermap.org/data/2.5/weather?q={city_name}&appid={API_KEY}&units=metric
```

---

## Example API URL

```text
https://api.openweathermap.org/data/2.5/weather?q=Chennai&appid=YOUR_API_KEY&units=metric
```

---

## Task Description

Create a weather dashboard where users can enter a city name and view current weather details.

The application should fetch weather data from OpenWeatherMap and display it on the webpage.

---

## Features to Implement

Students must implement:

1. City name input box
2. Search button
3. API call using `fetch()`
4. Display city name and country
5. Display temperature
6. Display weather condition
7. Display humidity
8. Display wind speed
9. Loading message while fetching data
10. Error message for invalid city or API failure

---

## API Response Fields to Use

| Field                    | Description         |
| ------------------------ | ------------------- |
| `name`                   | City name           |
| `sys.country`            | Country code        |
| `main.temp`              | Current temperature |
| `main.humidity`          | Humidity percentage |
| `weather[0].main`        | Weather condition   |
| `weather[0].description` | Weather description |
| `wind.speed`             | Wind speed          |

---

## Expected Output

```text
City: Chennai, IN
Temperature: 31°C
Condition: Clouds
Description: scattered clouds
Humidity: 70%
Wind Speed: 4.5 m/s
```

---

## User Interaction

Students must include:

* City input field
* Search button
* Optional Enter key search
* Error message for invalid city

---

## Validation Requirements

| Scenario         | Expected Behavior                        |
| ---------------- | ---------------------------------------- |
| Empty city input | Show “Please enter a city name”          |
| Valid city       | Display weather details                  |
| Invalid city     | Show “City not found”                    |
| Invalid API key  | Show “Invalid API key or request failed” |
| Network error    | Show “Unable to fetch weather data”      |

---

## Concepts Covered

| Concept          | Purpose                       |
| ---------------- | ----------------------------- |
| API key usage    | To authenticate API requests  |
| Query parameters | To pass city name and API key |
| `fetch()`        | To call the API               |
| `async/await`    | To handle asynchronous code   |
| `try...catch`    | To handle errors              |
| DOM manipulation | To display weather data       |

---

# Option 2: NASA Astronomy Picture of the Day App

## API Name

**NASA APOD API**

APOD stands for **Astronomy Picture of the Day**.

---

## API Key Requirement

NASA provides a free API key through its API portal.

Students must generate their own API key before using the API.

---

## API Endpoint

```text
https://api.nasa.gov/planetary/apod?api_key={API_KEY}
```

---

## Example API URL

```text
https://api.nasa.gov/planetary/apod?api_key=YOUR_API_KEY
```

---

## Task Description

Create a web application that displays NASA’s Astronomy Picture of the Day.

The application should fetch the image, title, date, and explanation from the NASA APOD API and display it on the webpage.

---

## Features to Implement

Students must implement:

1. API call using `fetch()`
2. Display astronomy image or video
3. Display title
4. Display date
5. Display explanation
6. Add date input to view APOD for a selected date
7. Loading message while fetching data
8. Error message if API request fails

---

## API Response Fields to Use

| Field         | Description                              |
| ------------- | ---------------------------------------- |
| `title`       | Title of the astronomy picture           |
| `date`        | Date of the picture                      |
| `explanation` | Description of the image                 |
| `url`         | Image or video URL                       |
| `hdurl`       | High-definition image URL, if available  |
| `media_type`  | Shows whether response is image or video |
| `copyright`   | Copyright owner, if available            |

---

## Expected Output

```text
Title: Astronomy Picture of the Day
Date: 2026-07-03
Image: Displayed on webpage
Explanation: Short astronomy-related description from NASA
Media Type: image
```

---

## User Interaction

Students must include:

* Load today’s astronomy picture
* Date picker input
* Search/View button
* Error message for invalid date or API failure

---

## Validation Requirements

| Scenario             | Expected Behavior                         |
| -------------------- | ----------------------------------------- |
| Page loaded          | Show today’s APOD                         |
| Valid date selected  | Show APOD for selected date               |
| Future date selected | Show “Please select today or a past date” |
| Invalid API key      | Show “Invalid API key or request failed”  |
| Network error        | Show “Unable to fetch NASA data”          |

---

## Concepts Covered

| Concept               | Purpose                          |
| --------------------- | -------------------------------- |
| API key usage         | To authenticate NASA API request |
| Query parameters      | To pass API key and date         |
| `fetch()`             | To call the API                  |
| Conditional rendering | To display image or video        |
| Date input handling   | To fetch data for selected date  |
| Error handling        | To manage failed requests        |

---

# Common Project Requirements

## Technologies Required

Students must use:

* HTML
* CSS
* JavaScript
* API key
* Public API
* `fetch()`

---

## Common Features

Each project must include:

1. API integration using `fetch()`
2. API key stored in `config.js`
3. `config.js` added to `.gitignore`
4. `config.example.js` pushed instead of the real key
5. Display of API response data
6. At least one user interaction
7. Loading message
8. Error handling
9. Clean UI
10. Basic validation

---

## Suggested Folder Structure

```text
api-key-project/
│
├── index.html
├── style.css
├── script.js
├── config.example.js
├── .gitignore
└── README.md
```

Local-only file:

```text
config.js
```

`config.js` must not be pushed to GitHub.

---

# README Instructions

Students must include the following in `README.md`:

````md
## Setup Instructions

1. Clone the repository.
2. Create a `config.js` file in the project root.
3. Add your API key inside `config.js`.

```js
const API_KEY = "your_api_key_here";
````

4. Open `index.html` in the browser.
5. Do not push `config.js` to GitHub.

```

---

# Evaluation Criteria

| Criteria | Marks |
|---|---:|
| API integration using `fetch()` | 20 |
| API key handled using `config.js` | 15 |
| `config.js` added to `.gitignore` | 10 |
| Correct data display in UI | 20 |
| User interaction | 10 |
| Loading and error handling | 10 |
| Code readability | 10 |
| UI design | 5 |
| **Total** | **100** |

---

# Final Deliverables

Students must submit:

1. `index.html`
2. `style.css`
3. `script.js`
4. `config.example.js`
5. `.gitignore`
6. `README.md`
7. Screenshot of output
8. Short explanation of selected API
9. Explanation of API response fields used

---

# Recommended Option for Beginners

## Best Beginner Option

**Option 1: Weather Dashboard Using OpenWeatherMap API**

## Reason

This is beginner-friendly because:

- The API response is easy to understand.
- The UI is simple.
- Students can search by city name.
- It teaches API key usage clearly.
- It is a common real-world frontend project.

---

# Sample Final Task Statement

Build a JavaScript web application using a free public API that requires an API key.

Choose one of the following:

1. Weather Dashboard using OpenWeatherMap API
2. NASA Astronomy Picture of the Day App using NASA APOD API

The application must fetch data using JavaScript `fetch()`, display the response dynamically on the webpage, handle user input, show loading and error states, and store the API key only in a local `config.js` file.

Students must not push `config.js` or the actual API key to GitHub.
```
