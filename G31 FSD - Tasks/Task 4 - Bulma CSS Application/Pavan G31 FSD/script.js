// Popular City Buttons

const cityButtons=document.querySelectorAll(".buttons .button");

cityButtons.forEach(function(button){

button.addEventListener("click",function(){

const city=this.innerText;

alert("Showing weather for "+city);

});

});


// Search Button

const searchButton=document.querySelector(".button.is-primary");

searchButton.addEventListener("click",function(){

const city=document.querySelector("input").value;

if(city===""){

alert("Please enter a city.");

}
else{

alert("Searching weather for "+city);

}

});


// Current Date

const today=new Date();

console.log(today.toDateString());


// Future Weather API

function getWeather(city){

console.log("Weather API will fetch data for:",city);

}