OOPs Basics – Interview Questions & Answers
1. What are the four main principles of OOP? Explain each with an example.

The four main principles are:

Encapsulation: Keeping data and methods together and controlling access to data.
Inheritance: One class can use the properties and methods of another class.
Polymorphism: The same method can behave differently in different situations.
Abstraction: Hiding unnecessary implementation details and showing only important things.
2. What is the difference between a class and an object?

A class is a blueprint used to create objects.
An object is an instance of a class.

Example:

class Student {
    String name;
}


Student s1 = new Student();

Here, Student is the class and s1 is the object.

3. What is encapsulation, and why is it important?

Encapsulation means protecting data by keeping it private and accessing it through methods.

It is useful for data security and controlled access.

class Student {
    private int marks;
}
4. What is inheritance? What are its advantages and disadvantages?

Inheritance allows a child class to reuse the properties and methods of a parent class.

Advantages: Code reusability and less duplicate code.
Disadvantages: Creates dependency between parent and child classes.

class Animal {
    void eat() {}
}


class Dog extends Animal {
}
5. What is polymorphism? Explain compile-time and runtime polymorphism.

Polymorphism means one name having different forms.

Compile-time: Achieved using method overloading.
Runtime: Achieved using method overriding.

Example of overloading:

add(int a, int b)
add(int a, int b, int c)
6. What is abstraction, and how is it different from encapsulation?

Abstraction hides implementation details and shows only necessary features.

Encapsulation protects the data and controls how it can be accessed.

Example:
Abstraction → showing a start() method without showing its internal working.
Encapsulation → keeping a variable private.

7. What is the difference between an abstract class and an interface?

An abstract class can have both abstract and normal methods.

An interface mainly defines methods that a class must implement.

Also, a class can implement multiple interfaces, but it can extend only one class.

8. What is method overloading, and how is it different from method overriding?

Method overloading: Same method name but different parameters.

Method overriding: Child class gives a new implementation of a parent class method.

// Overloading
add(int a, int b)
add(int a, int b, int c)

Overloading → Compile-time
Overriding → Runtime

9. What is the difference between composition and inheritance? When should composition be preferred?

Inheritance represents an "is-a" relationship.

Example: Dog is an Animal.

Composition represents a "has-a" relationship.

Example: Car has an Engine.

Composition is preferred when we want more flexibility and less dependency between classes.

10. What are access modifiers, and how do they help control access to data and behavior?

Access modifiers control who can access a class, variable, or method.

Java has:

public – accessible everywhere
private – accessible only within the class
protected – accessible in the same package and subclasses
default – accessible within the same package

They help in controlling access and protecting data.