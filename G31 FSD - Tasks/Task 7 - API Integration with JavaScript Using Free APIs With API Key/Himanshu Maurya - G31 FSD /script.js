const apiKey = "YOUR_API_KEY";

const result = document.getElementById("result");

async function searchMovie(){

    const movie = document.getElementById("movie").value.trim();

    if(movie===""){
        result.innerHTML="Enter a movie name.";
        return;
    }

    try{

        const response = await fetch(
            `https://www.omdbapi.com/?apikey=${apiKey}&t=${movie}`
        );

        const data = await response.json();

        if(data.Response==="False"){
            result.innerHTML="Movie not found.";
            return;
        }

        result.innerHTML=`
            <img src="${data.Poster}">
            <h2>${data.Title}</h2>
            <p><b>Year:</b> ${data.Year}</p>
            <p><b>Genre:</b> ${data.Genre}</p>
            <p><b>IMDb:</b> ${data.imdbRating}</p>
            <p>${data.Plot}</p>
        `;

    }

    catch(error){

        result.innerHTML="Something went wrong.";

        console.log(error);

    }

}
