# Core Java Essentials (15 Minutes)

Java is a high-level, class-based, object-oriented programming language designed to have as few implementation dependencies as possible (Write Once, Run Anywhere).

## 1. The Anatomy of a Java Program
Every Java application starts with a class and a `main` method.

```java
public class HelloWorld {
    // The main method is the entry point of any Java application
    public static void main(String[] args) {
        System.out.println("Hello, World!");
    }
}
```

## 2. Variables & Data Types
Java is statically typed, meaning you must declare the type of a variable before you use it.

*   **Primitives:** Basic values (stored directly in memory).
    *   `int` (integers): `int age = 25;`
    *   `double` (decimals): `double price = 19.99;`
    *   `boolean` (true/false): `boolean isActive = true;`
    *   `char` (single character): `char grade = 'A';`
*   **Reference Types:** Objects (pointers to memory locations).
    *   `String` (text): `String name = "Alice";`

## 3. Control Flow
Control flow dictates how your program makes decisions and repeats actions.

**If/Else Statements:**
```java
int score = 85;
if (score >= 90) {
    System.out.println("Grade: A");
} else if (score >= 80) {
    System.out.println("Grade: B");
} else {
    System.out.println("Grade: C");
}
```

**Loops (For & While):**
```java
// For loop (used when you know how many times to loop)
for (int i = 0; i < 5; i++) {
    System.out.println("Iteration: " + i);
}

// While loop (used when looping until a condition changes)
int count = 0;
while (count < 3) {
    System.out.println("Count is " + count);
    count++;
}
```

## 4. Object-Oriented Programming (OOP) Basics
Java is deeply object-oriented. You model your program using Classes (blueprints) and Objects (instances of those blueprints).

```java
// 1. Class (Blueprint)
class Dog {
    String name; // Attribute
    
    // Constructor (sets up the object)
    Dog(String dogName) {
        name = dogName;
    }
    
    // Method (behavior)
    void bark() {
        System.out.println(name + " says Woof!");
    }
}

public class Main {
    public static void main(String[] args) {
        // 2. Object (Instance)
        Dog myDog = new Dog("Buddy");
        myDog.bark(); // Output: Buddy says Woof!
    }
}
```
*Key OOP Pillars to remember:* Inheritance, Polymorphism, Encapsulation, and Abstraction.

## 5. Collections (Lists & Maps)
Arrays in Java have a fixed size. The Collections framework provides dynamic data structures.

**ArrayList (Dynamic Array):**
```java
import java.util.ArrayList;
import java.util.List;

List<String> names = new ArrayList<>();
names.add("Alice");
names.add("Bob");
System.out.println(names.get(0)); // Output: Alice
```

**HashMap (Key-Value Pairs):**
```java
import java.util.HashMap;
import java.util.Map;

Map<String, Integer> ages = new HashMap<>();
ages.put("Alice", 25);
ages.put("Bob", 30);
System.out.println("Alice is " + ages.get("Alice")); // Output: Alice is 25
```
