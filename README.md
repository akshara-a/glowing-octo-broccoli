# Weather Dashboard

A small web page where you type a city name and see its current temperature, condition, humidity, and wind speed.

## API Used

OpenWeatherMap Current Weather API. Requires a free API key.

Get a key here: https://openweathermap.org/api

## Setup Instructions

1. Download or clone this project folder.
2. Open `config.js` in the project root.
3. Replace the placeholder text with your real API key:

```
const API_KEY = "your_actual_key_here";
```

4. Open `index.html` in the browser, or run it through VS Code Live Server.
5. Do not push `config.js` to GitHub. It is already listed in `.gitignore`.
6. If you're sharing this project, push `config.example.js` instead, so others know what to fill in.

## Files

- `index.html` — page layout
- `style.css` — visual styling
- `script.js` — search logic and API calls
- `config.js` — holds your real API key (kept out of GitHub)
- `config.example.js` — sample file showing the expected format
- `.gitignore` — tells Git to skip `config.js`