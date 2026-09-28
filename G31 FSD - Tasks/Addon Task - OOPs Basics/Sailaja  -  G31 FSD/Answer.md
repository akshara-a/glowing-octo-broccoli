1. What are the four main principles of Object-Oriented Programming (OOP)? Explain each with an example.
a) Encapsulation

Encapsulation means wrapping data and methods into a single class and protecting the data from direct access.

Example:

class Student {
    private String name;

    public void setName(String n) {
        name = n;
    }

    public String getName() {
        return name;
    }
}

Example: An ATM machine hides its internal process. You only use the buttons.

b) Inheritance

Inheritance means one class can use the properties and methods of another class.

Example:

class Animal {
    void eat() {
        System.out.println("Eating");
    }
}

class Dog extends Animal {
}

Example: A child inherits qualities from parents.

c) Polymorphism

Polymorphism means one method can have different behaviors.

Example:

class Animal {
    void sound() {
        System.out.println("Animal sound");
    }
}

class Dog extends Animal {
    void sound() {
        System.out.println("Dog barks");
    }
}

Example: A person can be a student at college and an employee at work.

d) Abstraction

Abstraction means showing only the important details and hiding the internal implementation.

Example:

abstract class Vehicle {
    abstract void start();
}

Example: You drive a car without knowing how the engine works.

2. What is the difference between a class and an object?
Class

A class is a blueprint used to create objects.

Object

An object is a real instance of a class.

Example:

class Car {
}

Car c = new Car();

Here:

Car → Class
c → Object

Example: A building plan is a class, and the constructed house is an object.

3. What is encapsulation, and why is it important?

Encapsulation means keeping data and methods together in one class and protecting the data using private access.

Importance
Protects data
Improves security
Makes code easier to maintain

Example:

private int salary;

Example: A bank account balance cannot be changed directly by anyone.

4. What is inheritance? What are its advantages and disadvantages?

Inheritance allows a child class to reuse the properties and methods of a parent class.

Example:

class Animal {
    void eat() {
        System.out.println("Eating");
    }
}

class Dog extends Animal {
}
Advantages
Code reusability
Reduces duplicate code
Easy maintenance
Disadvantages
Parent class changes may affect child classes
Can make programs more complex

Example: A son inherits family properties.

5. What is polymorphism? Explain compile-time and runtime polymorphism.

Polymorphism means one interface, many forms.

Compile-time Polymorphism (Method Overloading)

Same method name with different parameters.

class Add {
    int sum(int a, int b) {
        return a + b;
    }

    int sum(int a, int b, int c) {
        return a + b + c;
    }
}
Runtime Polymorphism (Method Overriding)

Child class changes the parent class method.

class Animal {
    void sound() {
        System.out.println("Animal sound");
    }
}

class Dog extends Animal {
    void sound() {
        System.out.println("Dog barks");
    }
}

Example: The same person behaves differently at home and at work.

6. What is abstraction, and how is it different from encapsulation?
Abstraction

Shows only the necessary details and hides implementation.

Encapsulation

Protects data by restricting direct access.

Abstraction	Encapsulation
Hides implementation	Hides data
Focuses on what to do	Focuses on protecting data

Example:

Abstraction: Using a TV remote without knowing its internal circuit.
Encapsulation: Keeping money safely inside a wallet.
7. What is the difference between an abstract class and an interface?
Abstract Class	Interface
Can have abstract and normal methods	Mainly contains abstract methods
Can have constructors	Cannot have constructors
Extended using extends	Implemented using implements

 Example:

Abstract class: A general vehicle with some common features.
Interface: A contract like "Playable" for music players.
8. What is method overloading, and how is it different from method overriding?
Method Overloading

Same method name with different parameters.

class Add {
    int sum(int a, int b) {
        return a + b;
    }

    int sum(int a, int b, int c) {
        return a + b + c;
    }
}
Method Overriding

Child class provides its own version of the parent method.

class Animal {
    void sound() {
        System.out.println("Animal sound");
    }
}

class Dog extends Animal {
    void sound() {
        System.out.println("Dog barks");
    }
}
Overloading	Overriding
Same class	Parent and child class
Different parameters	Same parameters
Compile time	Runtime
9. What is the difference between composition and inheritance? When should composition be preferred?
Inheritance

Represents an "is-a" relationship.

class Dog extends Animal {
}

Dog is an Animal.

Composition

Represents a "has-a" relationship.

class Engine {
}

class Car {
    Engine engine = new Engine();
}

Car has an Engine.

When to use composition?
Use composition when one object contains another object and you want more flexibility.

Example:

Inheritance: A dog is an animal.
Composition: A car has an engine.
10. What are access modifiers, and how do they help control access to data and behavior?

Access modifiers decide who can access variables, methods, and classes.

Modifier	Access
public	Accessible from anywhere
private	Accessible only within the same class
protected	Accessible within the same package and subclasses
Default	Accessible within the same package

Example:

class Student {
    private int marks;

    public void setMarks(int m) {
        marks = m;
    }

    public int getMarks() {
        return marks;
    }
}