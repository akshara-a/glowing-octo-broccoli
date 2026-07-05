const apiKey = "YOUR_API_KEY";

const result = document.getElementById("result");

async function searchMovie(){

    const movie = document.getElementById("movie").value.trim();

    if(movie===""){
        result.style.display="block";
        result.innerHTML="<h3>🎬 Enter a movie name.</h3>";
        return;
    }

    try{

        const response = await fetch(
            `https://www.omdbapi.com/?apikey=${apiKey}&t=${movie}`
        );

        const data = await response.json();

        if(data.Response==="False"){
            result.style.display="block";
            result.innerHTML="<h3>❌ Movie not found.</h3>";
            return;
        }

        result.style.display="block";

        result.innerHTML=`
            <img src="${data.Poster}" alt="${data.Title}">
            <h2>${data.Title}</h2>

            <p>📅 <b>Year:</b> ${data.Year}</p>

            <p>🎭 <b>Genre:</b> ${data.Genre}</p>

            <p>⭐ <b>IMDb Rating:</b> ${data.imdbRating}</p>

            <p>🎬 <b>Director:</b> ${data.Director}</p>

            <p>📝 ${data.Plot}</p>
        `;

    }

    catch(error){

        result.style.display="block";
        result.innerHTML="<h3>⚠️ Something went wrong.</h3>";

        console.log(error);

    }

}
