const url = 'https://weather-api167.p.rapidapi.com/api/weather/forecast?place=London%2CGB&cnt=3&units=standard&type=three_hour&mode=json&lang=en';
const options = {
	method: 'GET',
	headers: {
		'x-rapidapi-key': API_KEY,
		'x-rapidapi-host': 'weather-api167.p.rapidapi.com',
		'Content-Type': 'application/json',
		Accept: 'application/json'
	}
};

async function getWeather() {
	try {
		const response = await fetch(url, options);
		const result = await response.text();
		console.log(result);
	} catch (error) {
		console.error(error);
	}
}

getWeather();