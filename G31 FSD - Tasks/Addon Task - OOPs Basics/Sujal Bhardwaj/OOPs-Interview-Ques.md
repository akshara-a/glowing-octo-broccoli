
# Object-Oriented Programming (OOP) Interview Questions

## 1. What are the four main principles of Object-Oriented Programming? Explain each with an example.

Object-Oriented Programming (OOP) is a programming paradigm that organizes software using **objects** and **classes**. The four fundamental principles of OOP are:

1. Encapsulation
2. Abstraction
3. Inheritance
4. Polymorphism

---

## 1. Encapsulation

### Definition
Encapsulation is the process of **wrapping data (variables)** and **methods (functions)** into a single unit called a **class**. It also protects the data by restricting direct access using access modifiers such as `private`, `protected`, and `public`.

### Example (Java)

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

public class Main {
    public static void main(String[] args) {
        Student s = new Student();
        s.setName("Sujal");
        System.out.println(s.getName());
    }
}
```

### Real-Life Example
An **ATM machine** hides its internal processes. Users only interact through options like withdrawing money or checking balance.

### Advantages
- Protects data from unauthorized access.
- Improves security.
- Makes code easier to maintain.

---

## 2. Abstraction

### Definition
Abstraction means **showing only the essential details** while **hiding the implementation details** from the user.

### Example (Java)

```java
abstract class Vehicle {
    abstract void start();
}

class Car extends Vehicle {
    void start() {
        System.out.println("Car starts using a key.");
    }
}

public class Main {
    public static void main(String[] args) {
        Vehicle v = new Car();
        v.start();
    }
}
```

### Real-Life Example
When driving a **car**, you use the steering wheel, brake, and accelerator without knowing how the engine works internally.

### Advantages
- Reduces complexity.
- Improves code readability.
- Enhances security by hiding implementation.

---

## 3. Inheritance

### Definition
Inheritance allows one class (**child class**) to acquire the properties and methods of another class (**parent class**). It promotes **code reusability**.

### Example (Java)

```java
class Animal {
    void sound() {
        System.out.println("Animal makes a sound");
    }
}

class Dog extends Animal {
    void bark() {
        System.out.println("Dog barks");
    }
}

public class Main {
    public static void main(String[] args) {
        Dog d = new Dog();
        d.sound();
        d.bark();
    }
}
```

### Real-Life Example
A **Dog** is an **Animal**. It inherits common characteristics such as eating and breathing while having its own behavior like barking.

### Advantages
- Encourages code reuse.
- Reduces duplication.
- Makes programs easier to extend.

---

## 4. Polymorphism

### Definition
Polymorphism means **"many forms."** The same method or function can behave differently depending on the object or parameters.

There are two types:
- Compile-time Polymorphism (Method Overloading)
- Run-time Polymorphism (Method Overriding)

### Example (Method Overriding)

```java
class Animal {
    void sound() {
        System.out.println("Animal makes a sound");
    }
}

class Dog extends Animal {
    @Override
    void sound() {
        System.out.println("Dog barks");
    }
}

public class Main {
    public static void main(String[] args) {
        Animal a = new Dog();
        a.sound();
    }
}
```

### Real-Life Example
A person can have different roles:
- Teacher in a classroom
- Parent at home
- Customer in a shop

The same person behaves differently depending on the situation.

### Advantages
- Improves flexibility.
- Makes code reusable.
- Simplifies maintenance and extension.

---

# Summary Table

| Principle | Definition | Example |
|-----------|------------|---------|
| Encapsulation | Wraps data and methods together while protecting data | ATM Machine |
| Abstraction | Hides implementation details and shows only essential features | Car Driving |
| Inheritance | Child class acquires properties of parent class | Dog inherits Animal |
| Polymorphism | One interface, many implementations | Method Overriding |

---

# Conclusion

The four pillars of Object-Oriented Programming are:

- **Encapsulation** – Protects data by restricting direct access.
- **Abstraction** – Hides unnecessary implementation details.
- **Inheritance** – Enables code reuse by inheriting properties and methods.
- **Polymorphism** – Allows the same interface or method to perform different actions.

These principles help developers create software that is **modular, reusable, maintainable, secure, and scalable**.
````
````



# 2. What is the Difference Between a Class and an Object?

## Definition

A **Class** is a blueprint or template used to create objects. It defines the properties (data members) and behaviors (methods) that the objects will have.

An **Object** is a real-world instance of a class. It occupies memory and can access the properties and methods defined in the class.

---

## Class vs Object Diagram

```text
              Class (Blueprint)
          +----------------------+
          |      Student         |
          +----------------------+
          | - name               |
          | - rollNo             |
          +----------------------+
          | + study()            |
          | + display()          |
          +----------------------+
                     |
          Creates Objects
                     ↓
      +---------------------+
      | Student s1          |
      | Name : Sujal        |
      | Roll : 101          |
      +---------------------+

      +---------------------+
      | Student s2          |
      | Name : Rahul        |
      | Roll : 102          |
      +---------------------+
```

---

## Java Example

```java
// Class
class Student {
    String name;
    int rollNo;

    void display() {
        System.out.println(name + " " + rollNo);
    }
}

public class Main {
    public static void main(String[] args) {

        // Objects
        Student s1 = new Student();
        Student s2 = new Student();

        s1.name = "Sujal";
        s1.rollNo = 101;

        s2.name = "Rahul";
        s2.rollNo = 102;

        s1.display();
        s2.display();
    }
}
```

### Output

```
Sujal 101
Rahul 102
```

---

## Real-Life Example

### 🏠 Class = House Blueprint

A blueprint contains the design of a house, including the number of rooms, doors, and windows.

### 🏡 Object = Actual House

The actual house is built using the blueprint. Many houses can be built from the same blueprint.

---

## Difference Between Class and Object

| Class | Object |
|--------|---------|
| A blueprint or template. | An instance of a class. |
| Logical entity. | Physical entity. |
| Does not occupy memory when declared. | Occupies memory when created. |
| Used to define variables and methods. | Used to access class members. |
| Created using the `class` keyword. | Created using the `new` keyword. |
| One class can create many objects. | Each object has its own state (data). |

---

## Key Points

- A class defines **what an object will contain**.
- An object represents **a real entity created from the class**.
- Multiple objects can be created from a single class.
- Objects can have different values for the same attributes.

---

## Conclusion

- **Class** → Blueprint or template used to define data and behavior.
- **Object** → A real instance of the class that occupies memory and performs actions.

In simple words:

> **Class is the design, while Object is the real thing created from that design.**
````
````


# 3. What is Encapsulation, and Why is it Important?

## What is Encapsulation?

1. **Encapsulation** is one of the four main principles of Object-Oriented Programming (OOP).
2. It is the process of **combining data (variables) and methods (functions)** into a single unit called a **class**.
3. It **protects data** by restricting direct access using access modifiers like `private`, `public`, and `protected`.
4. Data is accessed or modified through **getter** and **setter** methods.
5. Encapsulation helps in **data hiding** and **controlled access**.

### Example

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

---

## Why is Encapsulation Important?

1. **Protects Data** – Prevents unauthorized or direct access to data.
2. **Provides Data Hiding** – Hides the internal implementation details from users.
3. **Ensures Controlled Access** – Data can only be accessed or modified through getter and setter methods.
4. **Improves Security** – Prevents accidental or unauthorized modification of data.
5. **Makes Code Easy to Maintain** – Internal changes do not affect other parts of the program.
6. **Increases Code Reusability** – Encapsulated classes can be reused in different applications.
7. **Improves Flexibility** – Validation can be added before updating data using setter methods.
8. **Reduces Complexity** – Keeps related data and methods together in one class.
9. **Supports Modular Programming** – Organizes code into independent and manageable classes.
10. **Enhances Reliability** – Prevents invalid data from entering the system, reducing errors.

---

## Real-Life Example

**ATM Machine**

- Users can withdraw money, deposit money, and check their balance.
- They cannot directly access or modify the bank's internal data.
- This is an example of **Encapsulation**.

---

## Conclusion

- **Encapsulation** means wrapping data and methods into a single class while protecting the data from direct access.
- It improves **security, maintainability, flexibility, reusability, and reliability** of a program.
````
````



# 4. What is Inheritance? What are its Advantages and Disadvantages?

## What is Inheritance?

1. **Inheritance** is one of the four main principles of Object-Oriented Programming (OOP).
2. It is the process by which one class (**child/subclass**) acquires the properties and methods of another class (**parent/superclass**).
3. It promotes **code reusability** by allowing existing classes to be extended.
4. The child class can use the members of the parent class and also add its own features.
5. In Java, inheritance is implemented using the `extends` keyword.

---

## Java Example

```java
// Parent Class
class Animal {
    void eat() {
        System.out.println("Animal is eating");
    }
}

// Child Class
class Dog extends Animal {
    void bark() {
        System.out.println("Dog is barking");
    }
}

public class Main {
    public static void main(String[] args) {
        Dog d = new Dog();

        d.eat();   // Inherited method
        d.bark();  // Child class method
    }
}
```

### Output

```
Animal is eating
Dog is barking
```

---

## Advantages of Inheritance

1. **Code Reusability** – Reuses existing code from the parent class.
2. **Reduces Code Duplication** – Eliminates the need to write the same code multiple times.
3. **Easy Maintenance** – Changes made in the parent class are automatically available to child classes.
4. **Supports Code Extension** – New features can be added without modifying existing code.
5. **Improves Readability** – Creates a clear hierarchical relationship between classes.
6. **Supports Polymorphism** – Enables method overriding and runtime polymorphism.

---

## Disadvantages of Inheritance

1. **Tight Coupling** – Child classes depend on the parent class, making changes more complex.
2. **Reduced Flexibility** – Changes in the parent class may unintentionally affect child classes.
3. **Increased Complexity** – Deep inheritance hierarchies can make programs difficult to understand.
4. **Code Misuse** – Incorrect inheritance relationships can lead to poor software design.
5. **Maintenance Issues** – Large inheritance trees become difficult to maintain and debug.

---

## Real-Life Example

### Vehicle Example

- **Parent Class:** Vehicle
- **Child Classes:** Car, Bike, Bus

All vehicles share common features like **start()** and **stop()**, while each child class can have its own unique features.

---

## Conclusion

- **Inheritance** allows one class to inherit the properties and methods of another class.
- It improves **code reusability, maintainability, and extensibility**, but excessive or improper use can increase complexity and reduce flexibility.
````
````

# 5. What is Polymorphism? Explain Compile-Time and Runtime Polymorphism.

## What is Polymorphism?

1. **Polymorphism** is one of the four main principles of Object-Oriented Programming (OOP).
2. The word **Polymorphism** means **"many forms."**
3. It allows the **same method or interface to perform different tasks** depending on the object or parameters.
4. Polymorphism increases **code flexibility, reusability, and maintainability**.
5. In Java, polymorphism is of **two types**:
   - **Compile-Time Polymorphism (Method Overloading)**
   - **Runtime Polymorphism (Method Overriding)**

---

# (a). Compile-Time Polymorphism (Method Overloading)

## Definition

1. Compile-time polymorphism is achieved through **Method Overloading**.
2. In method overloading, **multiple methods have the same name but different parameters**.
3. The method to be executed is decided by the **compiler** during compilation.
4. It is also known as **Static Polymorphism** or **Early Binding**.

### Java Example

```java
class Calculator {

    int add(int a, int b) {
        return a + b;
    }

    int add(int a, int b, int c) {
        return a + b + c;
    }
}

public class Main {
    public static void main(String[] args) {
        Calculator c = new Calculator();

        System.out.println(c.add(10, 20));
        System.out.println(c.add(10, 20, 30));
    }
}
```

### Output

```
30
60
```

### Advantages

- Faster execution.
- Improves code readability.
- Increases code reusability.

---

# (b). Runtime Polymorphism (Method Overriding)

## Definition

1. Runtime polymorphism is achieved through **Method Overriding**.
2. A child class provides its own implementation of a method already defined in the parent class.
3. The method to execute is decided **at runtime**.
4. It is also known as **Dynamic Polymorphism** or **Late Binding**.

### Java Example

```java
class Animal {
    void sound() {
        System.out.println("Animal makes a sound");
    }
}

class Dog extends Animal {
    @Override
    void sound() {
        System.out.println("Dog barks");
    }
}

public class Main {
    public static void main(String[] args) {
        Animal a = new Dog();
        a.sound();
    }
}
```

### Output

```
Dog barks
```

### Advantages

- Provides flexibility.
- Supports method overriding.
- Makes programs easier to extend and maintain.

---

# Difference Between Compile-Time and Runtime Polymorphism

| **Compile-Time Polymorphism** | **Runtime Polymorphism** |
|-------------------------------|--------------------------|
| Achieved using **Method Overloading**. | Achieved using **Method Overriding**. |
| Method is selected during **compilation**. | Method is selected during **execution (runtime)**. |
| Also called **Static Polymorphism**. | Also called **Dynamic Polymorphism**. |
| Inheritance is **not required**. | Inheritance is **required**. |
| Faster execution. | Slightly slower due to dynamic method dispatch. |

---

## Real-Life Example

**Person Example**

A person behaves differently in different situations:

- 👨‍🏫 Teacher in a classroom.
- 👨‍👩‍👧 Parent at home.
- 🛒 Customer in a supermarket.

The **same person** performs **different roles**, illustrating **polymorphism**.

---

## Conclusion

- **Polymorphism** means **"one interface, many forms."**
- **Compile-Time Polymorphism** is achieved through **Method Overloading**, where the compiler decides which method to call.
- **Runtime Polymorphism** is achieved through **Method Overriding**, where the JVM decides which method to execute during runtime.
- Polymorphism improves **flexibility, code reuse, and maintainability** in Object-Oriented Programming.

````
````


# 6. What is Abstraction, and How is it Different from Encapsulation?

## What is Abstraction?

1. **Abstraction** is one of the four main principles of Object-Oriented Programming (OOP).
2. It is the process of **hiding implementation details** and showing only the essential features to the user.
3. It allows users to focus on **what an object does** instead of **how it does it**.
4. In Java, abstraction is achieved using:
   - **Abstract Classes**
   - **Interfaces**
5. Abstraction helps reduce complexity and improves code maintainability.

---

## Java Example

```java
abstract class Vehicle {

    abstract void start();
}

class Car extends Vehicle {

    @Override
    void start() {
        System.out.println("Car starts using a key.");
    }
}

public class Main {
    public static void main(String[] args) {
        Vehicle v = new Car();
        v.start();
    }
}
```

### Output

```
Car starts using a key.
```

---

## Advantages of Abstraction

1. Hides unnecessary implementation details.
2. Reduces program complexity.
3. Improves code readability.
4. Enhances security by exposing only essential features.
5. Makes code easier to maintain and extend.

---

# Difference Between Abstraction and Encapsulation

| **Basis** | **Abstraction** | **Encapsulation** |
|------------|-----------------|-------------------|
| **Definition** | Hides the implementation details and shows only the essential features. | Wraps data and methods into a single unit and protects the data from direct access. |
| **Focus** | Focuses on **what** an object does. | Focuses on **how** data is protected. |
| **Purpose** | Reduces complexity by hiding unnecessary details. | Protects data and ensures controlled access. |
| **Achieved By** | Abstract classes and interfaces. | Classes, private variables, and getter/setter methods. |
| **Data Hiding** | Hides implementation details. | Hides the actual data from unauthorized access. |
| **Security** | Provides less emphasis on data security. | Provides high data security through access control. |
| **Access** | Users interact only with essential functionalities. | Users access data through public methods (getters/setters). |
| **Main Benefit** | Simplifies the design and usage of a program. | Improves data security and maintainability. |
| **Example** | Driving a car without knowing how the engine works. | Using an ATM without accessing the bank's internal data. |
| **Keyword in Java** | `abstract`, `interface` | `private`, `public`, `protected` |

## Conclusion

- **Abstraction** hides **implementation details** to reduce complexity.
- **Encapsulation** hides **data** to protect it from unauthorized access.
- **Abstraction focuses on "What to do?"**, whereas **Encapsulation focuses on "How to protect data?"**.


---

## Real-Life Example

### 🚗 Abstraction

When driving a car, you use the **steering wheel, accelerator, and brake** without knowing how the engine works internally.

### 🏧 Encapsulation

In an ATM, you can **withdraw money, deposit money, and check your balance**, but you cannot directly access or modify the bank's internal data.

---

## Conclusion

- **Abstraction** hides the **implementation details** and shows only the essential features to the user.
- **Encapsulation** hides the **data** and protects it from unauthorized access.
- While **abstraction** focuses on **simplicity**, **encapsulation** focuses on **security and data protection**.
````
````
# 7. Difference Between an Abstract Class and an Interface

| **Basis** | **Abstract Class** | **Interface** |
|------------|--------------------|---------------|
| **Definition** | An abstract class is a class that cannot be instantiated and may contain both abstract and concrete methods. | An interface is a blueprint that defines a set of methods that a class must implement. |
| **Purpose** | Used to provide a common base class with shared code and behavior. | Used to define a contract that multiple classes must follow. |
| **Methods** | Can have both **abstract** and **non-abstract (concrete)** methods. | Can have **abstract methods** (and may also include `default` and `static` methods in Java 8+). |
| **Variables** | Can have instance variables, static variables, and final variables. | Variables are **public, static, and final** by default (constants). |
| **Constructors** | Can have constructors. | Cannot have constructors. |
| **Access Modifiers** | Methods and variables can use any access modifier (`private`, `protected`, `public`). | Interface methods are **public** by default. |
| **Inheritance** | A class can extend **only one** abstract class. | A class can implement **multiple interfaces**. |
| **Keyword Used** | `extends` | `implements` |
| **Multiple Inheritance** | Does **not** support multiple inheritance of classes. | Supports multiple inheritance through interfaces. |
| **When to Use** | When classes share common code and state. | When unrelated classes need to follow the same set of rules or behavior. |
| **Example** | `abstract class Vehicle` | `interface Vehicle` |

---

## Key Points

### Abstract Class

1. Cannot be instantiated (objects cannot be created directly).
2. Can contain both abstract and concrete methods.
3. Can have constructors.
4. Can contain instance variables and methods.
5. Supports code reuse through inheritance.
6. A class can extend only one abstract class.

---

### Interface

1. Cannot be instantiated.
2. Defines a contract that implementing classes must follow.
3. Contains abstract methods (and can also have `default` and `static` methods in Java 8+).
4. Variables are constants (`public static final`).
5. Does not have constructors.
6. A class can implement multiple interfaces.

---

## Conclusion

- **Abstract Class** is used when classes share common **state and behavior**.
- **Interface** is used when different classes need to follow the same **contract or functionality**.
- Use an **abstract class** for code sharing and partial implementation.
- Use an **interface** for achieving abstraction and multiple inheritance.
```
````
# 8. What is Method Overloading, and How is it Different from Method Overriding?

## What is Method Overloading?

1. **Method Overloading** is a feature in which **multiple methods have the same name but different parameters** (different number, type, or order of parameters).
2. It is an example of **Compile-Time Polymorphism (Static Polymorphism)**.
3. The compiler decides which method to call during compilation.
4. It improves code readability and reusability.

### Example

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

---

## What is Method Overriding?

1. **Method Overriding** occurs when a **child class provides its own implementation** of a method already defined in the parent class.
2. It is an example of **Runtime Polymorphism (Dynamic Polymorphism)**.
3. The method to execute is determined at runtime.
4. It allows child classes to provide specific behavior while keeping the same method signature.

### Example

```java
class Animal {
    void sound() {
        System.out.println("Animal makes a sound");
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

# Difference Between Method Overloading and Method Overriding

| **Basis** | **Method Overloading** | **Method Overriding** |
|------------|------------------------|-----------------------|
| **Definition** | Same method name with different parameters in the same class. | Child class provides a new implementation of a parent class method. |
| **Polymorphism Type** | Compile-Time (Static) Polymorphism. | Runtime (Dynamic) Polymorphism. |
| **Inheritance Required** | No. | Yes. |
| **Method Signature** | Must be different (different parameters). | Must be the same as the parent class method. |
| **Return Type** | May be different (if parameters differ). | Must be the same or covariant. |
| **Decision Time** | Decided by the compiler during compilation. | Decided by the JVM during runtime. |
| **Purpose** | Increases method flexibility. | Changes the behavior of an inherited method. |
| **Keyword Used** | No special keyword required. | `@Override` annotation is commonly used. |
| **Class Requirement** | Occurs within the same class. | Requires a parent and a child class. |
| **Example** | `add(int, int)` and `add(int, int, int)` | `Animal.sound()` overridden by `Dog.sound()` |

---

## Key Points

### Method Overloading

1. Same method name.
2. Different parameters.
3. No inheritance required.
4. Compile-time polymorphism.
5. Improves code readability.

### Method Overriding

1. Same method name and same parameters.
2. Requires inheritance.
3. Runtime polymorphism.
4. Changes the behavior of the parent class method.
5. Supports dynamic method dispatch.

---

## Conclusion

- **Method Overloading** allows multiple methods with the **same name but different parameters** and is resolved at **compile time**.
- **Method Overriding** allows a child class to **redefine a parent class method** with the same signature and is resolved at **runtime**.
- Both are important features of **polymorphism** in Java.
````
````
# 9. What is the Difference Between Composition and Inheritance? When Should Composition Be Preferred?

## What is Inheritance?

1. **Inheritance** is an OOP concept where a **child class inherits the properties and methods of a parent class**.
2. It represents an **"IS-A" relationship**.
3. It promotes **code reusability** by extending an existing class.
4. In Java, inheritance is implemented using the `extends` keyword.

### Example

```java
class Animal {
    void eat() {
        System.out.println("Animal is eating");
    }
}

class Dog extends Animal {
    void bark() {
        System.out.println("Dog is barking");
    }
}
```

---

## What is Composition?

1. **Composition** is an OOP concept where one class **contains an object of another class**.
2. It represents a **"HAS-A" relationship**.
3. It allows one class to use the functionality of another class without inheriting it.
4. Composition provides better flexibility and reduces dependency between classes.

### Example

```java
class Engine {
    void start() {
        System.out.println("Engine Started");
    }
}

class Car {
    Engine engine = new Engine();   // HAS-A relationship

    void startCar() {
        engine.start();
        System.out.println("Car Started");
    }
}
```

---

# Difference Between Composition and Inheritance

| **Basis** | **Composition** | **Inheritance** |
|------------|-----------------|-----------------|
| **Relationship** | HAS-A relationship | IS-A relationship |
| **Definition** | A class contains an object of another class. | A child class inherits from a parent class. |
| **Keyword Used** | No special keyword (object creation). | `extends` keyword. |
| **Code Reuse** | Achieved by using objects of other classes. | Achieved by inheriting a parent class. |
| **Coupling** | Loosely coupled (less dependent). | Tightly coupled (more dependent). |
| **Flexibility** | More flexible because objects can be changed easily. | Less flexible because the child depends on the parent. |
| **Inheritance Required** | No. | Yes. |
| **Maintenance** | Easier to maintain. | Can become difficult with deep inheritance hierarchies. |
| **Example** | Car **has an** Engine. | Dog **is an** Animal. |

---

# When Should Composition Be Preferred?

Composition should be preferred when:

1. You want a **HAS-A** relationship between classes.
2. You need **greater flexibility** in your program.
3. You want to **reduce dependency** between classes.
4. You want to avoid the complexity of deep inheritance hierarchies.
5. You need to change or replace the functionality of one class without affecting others.
6. You want better **code maintainability** and **reusability**.
7. Multiple classes need to use the same functionality without becoming subclasses.

---

## Real-Life Examples

### Inheritance (IS-A)

- Dog **is an** Animal.
- Car **is a** Vehicle.

### Composition (HAS-A)

- Car **has an** Engine.
- Computer **has a** CPU.
- House **has a** Room.

---

## Conclusion

- **Inheritance** represents an **IS-A** relationship and is used when one class is a specialized version of another.
- **Composition** represents a **HAS-A** relationship and is used when one class contains or uses another class.
- **Composition is generally preferred** because it provides **greater flexibility, lower coupling, easier maintenance, and better code reusability**.
````
````

# 10. What are Access Modifiers, and How Do They Help Control Access to Data and Behavior?

## What are Access Modifiers?

1. **Access Modifiers** are keywords in Java that control the **visibility (accessibility)** of classes, variables, methods, and constructors.
2. They determine **who can access** the data and methods of a class.
3. Access modifiers help implement **Encapsulation** by restricting unauthorized access.
4. Java provides **four access modifiers**:
   - `public`
   - `private`
   - `protected`
   - `default` (no modifier)

---

## Types of Access Modifiers

### 1. Public (`public`)

- Accessible from **any class** in any package.
- Provides the **widest level of access**.

**Example**

```java
public class Student {
    public String name = "Sujal";
}
```

---

### 2. Private (`private`)

- Accessible **only within the same class**.
- Cannot be accessed directly from outside the class.
- Commonly used to protect data.

**Example**

```java
class Student {
    private int age = 20;
}
```

---

### 3. Protected (`protected`)

- Accessible within the **same package** and by **subclasses** in other packages.
- Mainly used in inheritance.

**Example**

```java
class Animal {
    protected void sound() {
        System.out.println("Animal Sound");
    }
}
```

---

### 4. Default (No Modifier)

- Accessible only within the **same package**.
- If no access modifier is specified, Java automatically uses the **default** access level.

**Example**

```java
class Student {
    String college = "ABC College";
}
```

---

# Difference Between Access Modifiers

| **Access Modifier** | **Same Class** | **Same Package** | **Subclass (Different Package)** | **Different Package** |
|---------------------|:--------------:|:----------------:|:--------------------------------:|:---------------------:|
| **public** | ✅ Yes | ✅ Yes | ✅ Yes | ✅ Yes |
| **protected** | ✅ Yes | ✅ Yes | ✅ Yes | ❌ No |
| **default** | ✅ Yes | ✅ Yes | ❌ No | ❌ No |
| **private** | ✅ Yes | ❌ No | ❌ No | ❌ No |

---

# How Do Access Modifiers Help Control Access?

1. **Protect Sensitive Data** – Prevent unauthorized access to variables and methods.
2. **Support Encapsulation** – Keep data private and provide controlled access through getter and setter methods.
3. **Improve Security** – Prevent accidental or unauthorized modification of data.
4. **Control Visibility** – Allow developers to decide which members are accessible from outside the class.
5. **Improve Maintainability** – Restrict unnecessary access, making code easier to manage.
6. **Promote Modular Programming** – Keep implementation details hidden while exposing only required functionality.
7. **Support Inheritance** – `protected` members allow subclasses to access parent class members.

---

## Real-Life Example

### 🏦 Bank Account

- **private** → Account balance (only the bank can modify it).
- **public** → Deposit and withdraw methods (available to customers).
- **protected** → Accessible by specialized bank account classes.
- **default** → Accessible only within the bank's internal package.

---

## Conclusion

- **Access Modifiers** control the visibility and accessibility of classes, methods, and variables.
- They improve **security, encapsulation, maintainability, and controlled access**.
- Choosing the appropriate access modifier helps create **safe, reusable, and well-structured Java programs**.

