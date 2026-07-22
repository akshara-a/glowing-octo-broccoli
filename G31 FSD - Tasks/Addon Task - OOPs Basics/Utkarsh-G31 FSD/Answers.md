1. What are the four main principles of object-oriented programming? Explain each with an example.
The four main principles are Encapsulation, Inheritance, Polymorphism, and Abstraction.
Encapsulation: Wrapping data and methods together in one class. For example, a BankAccount class keeps the balance private and provides methods like deposit() and withdraw().
Inheritance: One class can inherit properties and methods from another. For example, Car inherits from Vehicle.
Polymorphism: The same method can behave differently depending on the object. For example, different classes can have their own version of a sound() method.
Abstraction: Showing only the required details and hiding the implementation. For example, we use a car without knowing how the engine works internally.


2. What is the difference between a class and an object?
A class is like a blueprint, while an object is the actual instance created from that blueprint.ex. Car is a class, and my own car is an object.


3. What is encapsulation, and why is it important?
Encapsulation means keeping data and methods together in one class while restricting direct access to the data. It is important because it improves security and prevents unwanted changes to the data.


4. What is inheritance? What are its advantages and disadvantages?
Inheritance allows one class to use the properties and methods of another class.
Advantages:
Reusability of code
Less code duplication
Easier maintenance
Disadvantages:
Creates tight dependency between classes
Deep inheritance can make code harder to understand


5. What is polymorphism? Explain compile-time and runtime polymorphism.
Polymorphism means one method can have different behaviors.
Compile-time polymorphism: Achieved using method overloading.
Runtime polymorphism: Achieved using method overriding.


6. What is abstraction, and how is it different from encapsulation?
Abstraction hides the implementation details and shows only the necessary features. Encapsulation protects the data by restricting direct access. So, abstraction focuses on what to show, while encapsulation focuses on how to protect the data.


7. What is the difference between an abstract class and an interface?
An abstract class can have both abstract and normal methods, while an interface mainly contains method declarations that implementing classes must define. A class can implement multiple interfaces but can extend only one abstract class.


8. What is method overloading, and how is it different from method overriding?
Method overloading means having multiple methods with the same name but different parameters in the same class. It is compile-time polymorphism.
Method overriding means redefining a parent class method in the child class. It is runtime polymorphism.


9. What is the difference between composition and inheritance? When should composition be preferred?
Inheritance represents an "is-a" relationship, while composition represents a "has-a" relationship.
Composition should be preferred when classes need flexibility and loose coupling because it is easier to maintain and modify.


10. What are access modifiers, and how do they help control access to data and behavior?
Access modifiers control the visibility of classes, methods, and variables.
Public: Accessible from anywhere.
Private: Accessible only within the same class.
Protected: Accessible within the same package and subclasses.
Default: Accessible only within the same package.
They help improve security and control access to data.