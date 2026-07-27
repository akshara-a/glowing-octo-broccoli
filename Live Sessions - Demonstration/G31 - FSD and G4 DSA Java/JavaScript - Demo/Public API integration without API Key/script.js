async function fetchData() {
    const latitude = document.getElementById("latitude").value;
    const longitude = document.getElementById("longitude").value;

    const uri = `https://api.open-meteo.com/v1/forecast?latitude=${latitude}&longitude=${longitude}`

    try {
        const response = await fetch(uri);
        const data = await response.json();

        document.getElementById("result").innerHTML = 
            `<h3> Information </h3>
            <p> Timezone: ${data.timezone} </p>`
    }
    catch (error) {
        console.error("Error fetching weather information", error)
    }
}