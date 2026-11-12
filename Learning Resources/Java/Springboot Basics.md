# Spring Boot Basics (20 Minutes)

While Swing is for desktop apps, **Spring Boot** is the industry standard for building Java web applications and backend REST APIs. It is an "opinionated" framework, meaning it makes a lot of configuration decisions for you so you can start coding your business logic immediately.

## 1. Core Concepts: IoC and Dependency Injection

Before writing code, you need to understand how Spring manages objects.

* **Inversion of Control (IoC):** In standard Java, you control the creation of objects (using the `new` keyword). In Spring, you hand that control over to the Spring framework. Spring becomes a "container" that holds all your objects.
* **Dependency Injection (DI):** If Class A needs Class B to function, you don't write `ClassB b = new ClassB();` inside Class A. Instead, you tell Spring, "Hey, I need a Class B," and Spring *injects* it for you. This makes your code much easier to test and maintain.

## 2. The Magic of Annotations

Spring Boot relies heavily on **Annotations** (words starting with `@`). These are instructions to the Spring compiler that handle massive amounts of boilerplate code behind the scenes.

* `@SpringBootApplication`: Put this on your main class. It tells Spring to auto-configure the project and scan for other components.
* `@RestController`: Tells Spring that this class will handle incoming web requests (HTTP) and return data (usually in JSON format) rather than a web page.
* `@GetMapping("/path")`: Maps an HTTP GET request to a specific method.

## 3. A Complete REST API Example

Here is what a minimal Spring Boot application looks like. If you run this and go to `http://localhost:8080/api/hello` in your web browser, you will see the message.

```java
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

// 1. Tell Spring this is the starting point of the application
@SpringBootApplication
public class MyBackendApplication {

    public static void main(String[] args) {
        // Starts the embedded web server (Tomcat by default)
        SpringApplication.run(MyBackendApplication.class, args);
    }
}

// 2. Create a Controller to handle web requests
@RestController
class GreetingController {

    // 3. Map a URL to this method
    @GetMapping("/api/hello")
    public String sayHello(@RequestParam(defaultValue = "World") String name) {
        // If the user visits /api/hello?name=Java, it returns "Hello, Java!"
        return "Hello, " + name + "!";
    }
}
```

## 4. How to Bootstrap a Project

You rarely create a Spring Boot project from absolute scratch. Instead, developers use **Spring Initializr** (start.spring.io). 

1. Go to start.spring.io.
2. Choose your build tool (**Maven** or **Gradle**).
3. Add dependencies (e.g., **Spring Web** for REST APIs).
4. Click "Generate" to download a ready-to-run ZIP file.

## Summary

Spring Boot takes the heavy lifting out of Java web development. By using annotations like `@RestController` and `@GetMapping`, you can expose your Java methods to the internet in just a few lines of code!
