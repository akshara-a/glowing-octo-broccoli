# Connecting the Dots (5 Minutes)

We've looked at building a desktop user interface (Swing) and a backend web server (Spring Boot). Now, how do they actually talk to each other in a real-world scenario?

## 1. The Big Picture (Client-Server Architecture)

In modern applications, you rarely put all your code in one place. Instead, you separate the concerns:

*   **The Client (Swing):** Runs on the user's computer. Its only job is to display information and capture user input (clicks, typing).
*   **The Server (Spring Boot):** Runs on a remote machine (or locally during development). It handles the heavy lifting, database connections, and business logic.

**The Flow:**
1. The user clicks the "Say Hello" button in the **Swing** app.
2. The Swing app makes an HTTP Request over the internet to your **Spring Boot** API (e.g., `http://localhost:8080/api/hello?name=Alice`).
3. The Spring Boot API processes the request and sends back a response (e.g., the text "Hello, Alice!").
4. The Swing app receives this response and updates the `JLabel` on the screen.

## 2. Making the Connection (Java 11+ HttpClient)

To make your Swing app call your Spring Boot API, you can use Java's built-in `HttpClient`. Inside your Swing button's `ActionListener`, you would add code similar to this:

```java
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;

// ... inside your Swing action listener ...
try {
    // 1. Create a client
    HttpClient client = HttpClient.newHttpClient();
    
    // 2. Build the request pointing to your Spring Boot API
    HttpRequest request = HttpRequest.newBuilder()
            .uri(URI.create("http://localhost:8080/api/hello?name=Alice"))
            .build();
            
    // 3. Send the request and get the response
    HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());
    
    // 4. Update the Swing GUI with the result from the server
    resultLabel.setText(response.body()); 
    
} catch (Exception ex) {
    ex.printStackTrace();
}
```

## 3. Build Tools: Maven and Gradle

As your projects grow, compiling code manually and downloading libraries (like Spring Boot) becomes impossible. This is where **Build Tools** come in. The two industry standards in Java are **Maven** and **Gradle**.

What they do:
*   **Dependency Management:** You write a list of the libraries you need in a single file (like `pom.xml` for Maven). The build tool automatically downloads them from the internet and adds them to your project.
*   **Building & Packaging:** With one command (e.g., `mvn clean install`), the tool compiles all your Java files, runs your automated tests, and packages everything into a single, runnable `.jar` file.

By using Maven or Gradle, you ensure that another developer can download your code and run it instantly without manually hunting for the right library files.
