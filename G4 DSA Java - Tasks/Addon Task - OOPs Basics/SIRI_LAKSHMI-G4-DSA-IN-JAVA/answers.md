Object-Oriented Programming (OOP) Assignment

1. What are the four main principles of Object-Oriented Programming? Explain each with an example.

The four main principles of OOP are:

a) Encapsulation:
Encapsulation is the process of combining data and methods into a single unit (class) and restricting direct access to the data.

Example:
A Bank Account class keeps the account balance private and allows access only through deposit() and withdraw() methods.

b) Inheritance:
Inheritance allows one class to acquire the properties and methods of another class.

Example:
A Dog class inherits from an Animal class. The Dog class can use the methods of Animal and also have its own features.

c) Polymorphism:
Polymorphism means "many forms." The same method can perform different tasks depending on the object.

Example:
A draw() method behaves differently for Circle and Rectangle classes.

d) Abstraction:
Abstraction means showing only the essential details while hiding the internal implementation.

Example:
When we drive a car, we use the steering wheel and pedals without knowing how the engine works.

2. What is the difference between a class and an object?

A class is a blueprint or template used to create objects. It defines the properties and methods.

An object is an instance of a class. It represents a real-world entity and occupies memory.

Example:
Class: Student
Objects: Student1, Student2

3. What is encapsulation, and why is it important?

Encapsulation is the process of wrapping data and methods together in one class and protecting the data from direct access using access modifiers.

Importance:

Protects data from unauthorized access.
Improves security.
Makes the code easier to maintain.
Helps in data hiding.

4. What is inheritance? What are its advantages and disadvantages?

Inheritance allows one class to inherit the properties and methods of another class.

Advantages:

Code reusability.
Reduces code duplication.
Easy to maintain.
Supports hierarchical relationships.

Disadvantages:

Creates tight dependency between classes.
Changes in the parent class may affect child classes.
Can make programs more complex if used excessively.

5. What is polymorphism? Explain compile-time and runtime polymorphism.

Polymorphism allows one method to perform different tasks based on the situation.

Compile-time Polymorphism:
It is achieved through method overloading. The method name is the same, but the parameters are different.

Example:
add(int a, int b)
add(int a, int b, int c)

Runtime Polymorphism:
It is achieved through method overriding. The child class provides its own implementation of the parent class method.

Example:
Animal has a method sound(). Dog overrides sound() and prints "Bark".

6. What is abstraction, and how is it different from encapsulation?

Abstraction hides implementation details and shows only the required functionality.

Encapsulation hides data by restricting direct access and protects it within a class.

Difference:

Abstraction focuses on hiding implementation.
Encapsulation focuses on hiding data and providing controlled access.

7. What is the difference between an abstract class and an interface?

Abstract Class:

Can have both abstract and normal methods.
Can have constructors and instance variables.
A class can extend only one abstract class.

Interface:

Contains method declarations (and default/static methods in modern Java).
Used to achieve complete abstraction.
A class can implement multiple interfaces.

8. What is method overloading, and how is it different from method overriding?

Method Overloading:

Same method name with different parameters.
Happens in the same class.
Compile-time polymorphism.

Method Overriding:

Child class provides a new implementation of a parent class method.
Runtime polymorphism.

9. What is the difference between composition and inheritance? When should composition be preferred?

Inheritance represents an "is-a" relationship.

Example:
Dog is an Animal.

Composition represents a "has-a" relationship.

Example:
A Car has an Engine.

Composition should be preferred when we want flexibility, low coupling, and better code reuse without creating a strong dependency between classes.

10. What are access modifiers, and how do they help control access to data and behavior?

Access modifiers control the visibility of classes, variables, and methods.

The four access modifiers are:

Public: Accessible from anywhere.
Private: Accessible only within the same class.
Protected: Accessible within the same package and by subclasses.
Default: Accessible only within the same package.

They help improve security, support data hiding, and prevent unauthorized access to program data.