Q1. What are the four main principles of object-oriented programming? Explain each with an
example.
A:
• Encapsulation – hiding data inside a class. Example: bank account balance is private, changed
only via deposit/withdraw methods.
• Abstraction – showing only important details, hiding complexity. Example: driving a car without
knowing engine details.
• Inheritance – one class reuses another class's features. Example: Dog and Cat classes inherit
from Animal class.
• Polymorphism – same method behaves differently. Example: speak() gives bark for Dog, meow
for Cat.
Q2. What is the difference between a class and an object?
A: A class is a blueprint. An object is a real thing made from that blueprint. Example: Car is a class,
myCar is an object.
Q3. What is encapsulation, and why is it important?
A: Encapsulation means keeping data and related methods together and hiding data from outside
access. It's important because it protects data and keeps code safe and easy to maintain.
Q4. What is inheritance? What are its advantages and disadvantages?
A: Inheritance means a child class gets properties and methods of a parent class.
• Advantages: code reuse, easy maintenance.
• Disadvantages: tight coupling, changes in parent can break child classes.
Q5. What is polymorphism? Explain compile-time and runtime polymorphism.
A: Polymorphism means one thing can take many forms.
• Compile-time polymorphism = method overloading (same name, different parameters, decided at
compile time).
• Runtime polymorphism = method overriding (child class changes parent method, decided at
runtime).
Q6. What is abstraction, and how is it different from encapsulation?
A: Abstraction hides complexity and shows only needed features. Encapsulation hides data using private
variables. Abstraction = hiding logic. Encapsulation = hiding data.
Q7. What is the difference between an abstract class and an interface?
A: Abstract class can have both complete and incomplete methods, and can have constructors. Interface
only has method declarations (mostly), no constructors. A class can extend only one abstract class but
implement many interfaces.
Q8. What is method overloading, and how is it different from method overriding?
A:
• Overloading – same method name, different parameters, same class.
• Overriding – child class redefines parent class method with same name and parameters.
• Overloading = compile-time, Overriding = runtime.
Q9. What is the difference between composition and inheritance? When should composition
be preferred?
A: Inheritance = "is-a" relationship (Dog is an Animal). Composition = "has-a" relationship (Car has an
Engine). Composition is preferred when we want flexibility and less tight coupling, instead of forcing a
parent-child relationship.
Q10. What are access modifiers, and how do they help control access to data and behavior?
A: Access modifiers control who can use a class, method, or variable.
• private – only inside class
• default – only in same package
• protected – package + subclasses
• public – accessible everywhere
• They help protect data and control what other parts of code can access
