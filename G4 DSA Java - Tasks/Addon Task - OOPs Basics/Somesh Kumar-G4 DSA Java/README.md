## 1. What are the four main principles of Object-Oriented Programming? Explain each with an example.
Object-Oriented Programming (OOP) is based on four important principles that help developers write organized, reusable, and easy-to-maintain programs. These principles are Encapsulation, Inheritance, Polymorphism, and Abstraction.
1. Encapsulation
Encapsulation is the process of combining data and the methods that work on that data into a single unit, called a class. It also protects the data by restricting direct access and allowing it to be accessed only through controlled methods.
Example:
A bank ATM is a good example of encapsulation. A user can withdraw or deposit money only through the options provided by the ATM. The user cannot directly access or modify the bank's database.
2. Inheritance
Inheritance is a feature that allows one class to inherit the properties and behaviors of another class. This helps in reusing existing code instead of writing the same code again.
Example:
A Car is a type of Vehicle. The car automatically has common features like wheels, engine, and speed from the vehicle, while it can also have its own features such as air conditioning or a music system.
3. Polymorphism
Polymorphism means "many forms." It allows the same action or method to behave differently depending on the object that is using it. This makes programs more flexible and easier to extend.
Example:
The Sound action is different for different animals. A dog barks, a cat meows, and a cow moos. Although the action is called "sound," the output changes based on the animal.
4. Abstraction
Abstraction means showing only the essential details to the user while hiding the complex implementation. It helps users interact with a system without needing to know how everything works internally.
Example:
When driving a car, you use the steering wheel, brake, and accelerator to control it. You do not need to understand how the engine or gearbox works internally to drive the car.
## 2. What is the difference between a class and an object?

A class is a blueprint or template used to create objects. It defines the properties and behaviors that the objects will have. An object is a real instance of a class that can store data and perform actions.

**Example:** Think of a class as the blueprint of a house. Using the same blueprint, many houses can be built. Each house is an object created from that blueprint.

## 3. What is encapsulation, and why is it important?

Encapsulation is the process of keeping data and the methods that work on that data together in one place while protecting the data from direct access. It allows controlled access to the data, making the program more secure and easier to manage.

It is important because it protects important data, reduces accidental changes, makes the code easier to maintain, and improves the overall security of the application.

**Example:** An ATM allows users to withdraw or deposit money using specific options. Users cannot directly access the bank's internal records.

## 4. What is inheritance? What are its advantages and disadvantages?

Inheritance is an OOP feature where one class can use the properties and behaviors of another class. This helps in reusing existing code and reducing duplication.

**Advantages:**
- Promotes code reusability.
- Reduces duplicate code.
- Makes programs easier to maintain.
- Helps organize related classes.

**Disadvantages:**
- Creates dependency between classes.
- A change in the parent class may affect child classes.
- Deep inheritance structures can become difficult to understand.

**Example:** A bike and a car are both types of vehicles. They share common features like wheels and speed but also have their own unique features.

## 5. What is polymorphism? Explain compile-time and runtime polymorphism.

Polymorphism means "many forms." It allows the same action to behave differently depending on the object.

Compile-time polymorphism happens when the same method performs different tasks based on different parameters. The decision is made during compilation.

Runtime polymorphism occurs when a child class provides its own implementation of a method that already exists in the parent class. The decision is made while the program is running.

**Example:** Different animals make different sounds. A dog barks, a cat meows, and a cow moos. The action is the same, but the output depends on the animal.

## 6. What is abstraction, and how is it different from encapsulation?

Abstraction is the process of showing only the necessary features to the user while hiding the internal implementation. It helps reduce complexity. Encapsulation, on the other hand, focuses on protecting data by restricting direct access.

| Abstraction | Encapsulation |
|--------------|---------------|
| Hides implementation details | Hides data |
| Focuses on simplicity | Focuses on security |
| Shows only essential features | Controls access to data |

**Example:** A person can drive a car without knowing how the engine works. This is abstraction.

## 7. What is the difference between an abstract class and an interface?

An abstract class is used when multiple related classes share common features and behavior. It can contain both implemented and unimplemented methods. An interface is used to define a set of rules that different classes must follow. It helps achieve complete abstraction.

**Example:** An abstract class can represent a general Vehicle with some common functionality. An interface can represent a Drivable feature that different vehicles implement in their own way.

## 8. What is method overloading, and how is it different from method overriding?

Method overloading happens when multiple methods have the same name but different parameters within the same class. Method overriding happens when a child class provides a different implementation for a method that already exists in the parent class.

| Method Overloading                                                  |Method Overriding |
|--------------------|-------------------|
| Same method name with different parameters|                          |Same method with a new implementation |
| Happens in the same class |                                         |Happens between parent and child classes |
| Compile-time feature |                                              |Runtime feature |

## 9. What is the difference between composition and inheritance? When should composition be preferred?

Inheritance represents an "is-a" relationship, while composition represents a "has-a" relationship. Composition is generally preferred because it provides more flexibility and reduces dependency between classes.

**Example:** A car has an engine, so this is composition. A car is a vehicle, so this is inheritance.

Composition should be preferred when objects need to work together without creating a strong dependency.

## 10. What are access modifiers, and how do they help control access to data and behavior?

Access modifiers define who can access the members of a class. They help protect data and maintain security in a program.
The four access modifiers in Java are:
- **public** – Accessible from anywhere.
- **protected** – Accessible within the same package and by subclasses.
- **default** – Accessible only within the same package.
- **private** – Accessible only within the same class.
**Example:** A person's mobile phone is protected with a password. Only the owner can access personal information. Similarly, access modifiers prevent unauthorized access to data in a program.