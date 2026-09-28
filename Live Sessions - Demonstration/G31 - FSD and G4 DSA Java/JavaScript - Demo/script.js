function func() {
    var child = document.createElement("p")
    child.textContent = "Hello World!"

    document.getElementById("container").appendChild(child)
}