# Object-Oriented Programming Interview Questions

## 1. What are the four main principles of Object-Oriented Programming? Explain each with an example.

Object-Oriented Programming (OOP) is based on four main principles:

### a) Encapsulation
Encapsulation is the process of wrapping data (variables) and methods (functions) into a single unit called a class. It also protects data by making variables private and providing public getter and setter methods.

**Example:**
```java
class Student {
    private String name;

    public void setName(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }
}
```

### b) Inheritance
Inheritance allows one class to inherit the properties and methods of another class. It promotes code reusability.

**Example:**
```java
class Animal {
    void sound() {
        System.out.println("Animal makes sound");
    }
}

class Dog extends Animal {
    void bark() {
        System.out.println("Dog barks");
    }
}
```

### c) Polymorphism
Polymorphism means "many forms." It allows the same method to perform different tasks depending on the object.

**Example:**
```java
class Animal {
    void sound() {
        System.out.println("Animal sound");
    }
}

class Dog extends Animal {
    @Override
    void sound() {
        System.out.println("Dog barks");
    }
}
```

### d) Abstraction
Abstraction hides implementation details and exposes only the essential functionality.

**Example:**
```java
abstract class Vehicle {
    abstract void start();
}

class Car extends Vehicle {
    void start() {
        System.out.println("Car starts with key");
    }
}
```

---

# 2. What is the difference between a class and an object?

| Class | Object |
|--------|--------|
| A blueprint or template for creating objects. | An instance of a class. |
| Defines properties and methods. | Uses the properties and methods defined in the class. |
| Does not occupy memory until objects are created. | Occupies memory when created. |

**Example:**
```java
class Car {
    String color;
}

Car car1 = new Car();
```

---

# 3. What is encapsulation, and why is it important?

Encapsulation is the process of hiding data by declaring variables as private and allowing access through public methods.

### Importance
- Protects data from unauthorized access.
- Improves security.
- Makes the code easier to maintain.
- Supports data validation.

**Example:**
```java
class BankAccount {
    private double balance;

    public void setBalance(double balance) {
        this.balance = balance;
    }

    public double getBalance() {
        return balance;
    }
}
```

---

# 4. What is inheritance? What are its advantages and disadvantages?

Inheritance allows one class to inherit the properties and methods of another class.

**Example:**
```java
class Animal {
    void eat() {
        System.out.println("Eating");
    }
}

class Dog extends Animal {
    void bark() {
        System.out.println("Barking");
    }
}
```

### Advantages
- Promotes code reusability.
- Reduces duplicate code.
- Makes maintenance easier.
- Supports method overriding.

### Disadvantages
- Creates tight coupling between classes.
- Changes in the parent class may affect child classes.
- Deep inheritance can make code difficult to understand.

---

# 5. What is polymorphism? Explain compile-time and runtime polymorphism.

Polymorphism allows one interface to have multiple implementations.

### Compile-time Polymorphism (Method Overloading)

Method overloading occurs when multiple methods have the same name but different parameters.

**Example:**
```java
class Calculator {
    int add(int a, int b) {
        return a + b;
    }

    int add(int a, int b, int c) {
        return a + b + c;
    }
}
```

### Runtime Polymorphism (Method Overriding)

Method overriding occurs when a child class provides its own implementation of a parent class method.

**Example:**
```java
class Animal {
    void sound() {
        System.out.println("Animal sound");
    }
}

class Dog extends Animal {
    @Override
    void sound() {
        System.out.println("Dog barks");
    }
}
```

---

# 6. What is abstraction, and how is it different from encapsulation?

Abstraction hides implementation details and exposes only the necessary functionality to the user.

**Example:**
```java
abstract class Shape {
    abstract void draw();
}
```

### Difference

| Abstraction | Encapsulation |
|-------------|---------------|
| Hides implementation details. | Hides data from unauthorized access. |
| Achieved using abstract classes and interfaces. | Achieved using private variables and public methods. |
| Focuses on what an object does. | Focuses on how data is protected. |

---

# 7. What is the difference between an abstract class and an interface?

| Abstract Class | Interface |
|----------------|-----------|
| Can have abstract and concrete methods. | Mainly contains abstract methods (can also have default and static methods in modern Java). |
| Can have constructors. | Cannot have constructors. |
| Supports instance variables. | Only constants (`public static final`). |
| A class extends only one abstract class. | A class can implement multiple interfaces. |

---

# 8. What is method overloading, and how is it different from method overriding?

### Method Overloading
- Same method name.
- Different parameters.
- Occurs in the same class.
- Compile-time polymorphism.

**Example:**
```java
class Test {
    void display() {}

    void display(int a) {}
}
```

### Method Overriding
- Same method name.
- Same parameters.
- Occurs in parent and child classes.
- Runtime polymorphism.

**Example:**
```java
class Animal {
    void sound() {
        System.out.println("Animal");
    }
}

class Dog extends Animal {
    @Override
    void sound() {
        System.out.println("Bark");
    }
}
```

### Difference

| Overloading | Overriding |
|--------------|------------|
| Same class | Parent and child classes |
| Different parameters | Same parameters |
| Compile-time | Runtime |
| Increases readability | Enables runtime polymorphism |

---

# 9. What is the difference between composition and inheritance? When should composition be preferred?

### Inheritance
Inheritance represents an **"is-a"** relationship.

**Example:**
```java
class Animal {}

class Dog extends Animal {}
```

### Composition
Composition represents a **"has-a"** relationship.

**Example:**
```java
class Engine {}

class Car {
    Engine engine = new Engine();
}
```

### Difference

| Inheritance | Composition |
|--------------|-------------|
| IS-A relationship | HAS-A relationship |
| Tight coupling | Loose coupling |
| Uses `extends` | Uses objects as members |
| Less flexible | More flexible |

### Composition should be preferred when:
- Loose coupling is required.
- Flexibility is important.
- There is no natural "is-a" relationship.
- Code should be easy to modify and maintain.

---

# 10. What are access modifiers, and how do they help control access to data and behavior?

Access modifiers define the visibility of classes, methods, and variables.

| Modifier | Same Class | Same Package | Subclass | Other Packages |
|----------|------------|--------------|----------|----------------|
| `public` | Yes | Yes | Yes | Yes |
| `protected` | Yes | Yes | Yes | No* |
| Default | Yes | Yes | No | No |
| `private` | Yes | No | No | No |

*Accessible in other packages only through inheritance.

### Example:
```java
class Student {
    private int marks;

    public void setMarks(int marks) {
        this.marks = marks;
    }

    public int getMarks() {
        return marks;
    }
}
```

### Importance of Access Modifiers
- Protect sensitive data.
- Improve security.
- Support encapsulation.
- Control access to class members.
- Make code easier to maintain and manage.