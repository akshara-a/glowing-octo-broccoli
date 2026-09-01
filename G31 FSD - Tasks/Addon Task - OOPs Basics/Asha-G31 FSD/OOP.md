# Object-Oriented Programming (OOP) Interview Questions and Answers

## Question 1

### Q. What are the four main principles of object-oriented programming? Explain each with an example.

**Answer:**

Object-Oriented Programming (OOP) is a programming paradigm that
organizes software using objects, which contain both data and methods.
The four main principles are **Encapsulation, Abstraction, Inheritance,
and Polymorphism**.

-   **Encapsulation** means bundling data and methods together while
    restricting direct access to the data.\
    **Example:** A bank account keeps the balance private and allows
    access only through methods such as `deposit()` and `withdraw()`.

-   **Abstraction** means hiding implementation details and exposing
    only the essential features.\
    **Example:** When driving a car, we use the steering wheel and
    pedals without needing to know how the engine works internally.

-   **Inheritance** allows one class to acquire the properties and
    methods of another class.\
    **Example:** A `Car` class can inherit common features such as
    `start()` and `stop()` from a `Vehicle` class.

-   **Polymorphism** allows the same method to behave differently for
    different objects.\
    **Example:** Different payment methods like **Credit Card** and
    **UPI** can each implement a common `pay()` method differently.

These principles improve code reusability, security, maintainability,
and flexibility.

------------------------------------------------------------------------

## Question 2

### Q. What is the difference between a class and an object?

**Answer:**

A class is a blueprint or template used to define the properties and
behaviors of objects. It specifies what data an object will store and
what actions it can perform.

An object is an instance of a class, created at runtime, and it occupies
memory. Multiple objects can be created from the same class, each having
its own data while sharing the same structure and behavior.

**Example:** If `Student` is a class, then **Asha**, **Rahul**, and
**Priya** are different objects of the `Student` class. Each student has
different values, such as **name** and **roll number**, but all follow
the same structure defined by the class.

------------------------------------------------------------------------

## Question 3

### Q. What is encapsulation, and why is it important?

**Answer:**

Encapsulation is the process of bundling data and the methods that
operate on that data into a single unit, typically a class. It also
involves restricting direct access to the data using access modifiers
like `private` and providing controlled access through public methods
such as getters and setters.

For example, in a `BankAccount` class, the `balance` variable is kept
private. Users cannot modify it directly but must use methods like
`deposit()` or `withdraw()`. This ensures that the balance cannot be
updated with invalid values.

Encapsulation is important because it improves data security, prevents
unauthorized access, maintains data integrity, and makes code easier to
maintain and modify.

------------------------------------------------------------------------

## Question 4

### Q. What is inheritance? What are its advantages and disadvantages?

**Answer:**

Inheritance is an Object-Oriented Programming (OOP) principle that
allows one class to inherit the properties and methods of another class.
The existing class is called the **parent class** or **superclass**, and
the new class is called the **child class** or **subclass**. This helps
in code reusability and avoids duplication.

For example, if `Vehicle` is a parent class with methods like `start()`
and `stop()`, then a `Car` class can inherit these methods and also
define additional features such as `openSunroof()`.

**Advantages:** - Code reusability - Easier maintenance - Extensibility

**Disadvantages:** - Tight coupling between classes - Reduced
flexibility if inheritance is overused - Increased complexity in deep
inheritance hierarchies

------------------------------------------------------------------------

## Question 5

### Q. What is polymorphism? Explain compile-time and runtime polymorphism.

**Answer:**

Polymorphism is an Object-Oriented Programming (OOP) principle that
allows the same interface or method to behave differently in different
situations. The word **polymorphism** means **"many forms."**

There are two types of polymorphism in Java:

-   **Compile-time polymorphism** is achieved through **method
    overloading**, where multiple methods have the same name but
    different parameter lists. The compiler decides which method to
    call.
-   **Runtime polymorphism** is achieved through **method overriding**,
    where a child class provides its own implementation of a method
    defined in the parent class. The JVM decides which method to execute
    at runtime based on the actual object.

Polymorphism improves flexibility, code reusability, and extensibility.

------------------------------------------------------------------------

## Question 6

### Q. What is abstraction, and how is it different from encapsulation?

**Answer:**

Abstraction is the process of **hiding the implementation details and
showing only the essential functionality** to the user. It focuses on
**what an object does**, not **how it does it**.

For example, when driving a car, I use the steering wheel, accelerator,
and brake without knowing how the engine or transmission works
internally.

Encapsulation is the process of **bundling data and methods into a
single class and restricting direct access to the data** using access
modifiers like `private`. It focuses on **protecting the internal state
of an object**.

For example, in a `BankAccount` class, the `balance` variable is kept
private and accessed through methods like `deposit()` and `withdraw()`.

**Key Difference:** - **Abstraction** hides implementation complexity
(**what** the object does). - **Encapsulation** hides data and controls
access (**how** the data is protected).

In Java, abstraction is achieved using **abstract classes** and
**interfaces**, while encapsulation is achieved using **private fields**
with **public getters and setters**.

------------------------------------------------------------------------

## Question 7

### Q. What is the difference between an abstract class and an interface?

**Answer:**

An **abstract class** is used to provide a common base class with both
implemented and abstract methods. A class can extend only **one abstract
class**.

An **interface** defines a contract that multiple classes can implement.
A class can implement **multiple interfaces**.

**Abstract Class** - Can have abstract and concrete methods. - Can have
constructors and instance variables. - Single inheritance. - Used when
classes share common state and behavior.

**Interface** - Defines a contract. - Supports multiple inheritance
through implementation. - Cannot be instantiated. - Used when unrelated
classes need to provide the same functionality.

**In short:** Use an abstract class for shared implementation and an
interface for a common contract.

------------------------------------------------------------------------

## Question 8

### Q. What is method overloading, and how is it different from method overriding?

**Answer:**

Method overloading is when multiple methods have the same name but
different parameters in the same class. It is **compile-time
polymorphism**.

Method overriding is when a child class provides its own implementation
of a parent class method with the same signature. It is **runtime
polymorphism**.

**Example:** - **Overloading:** A `Calculator` class has multiple
`add()` methods with different parameters. - **Overriding:** A `Dog`
class overrides the `sound()` method of the `Animal` class.

------------------------------------------------------------------------

## Question 9

### Q. What is the difference between composition and inheritance? When should composition be preferred?

**Answer:**

Inheritance represents an **"is-a" relationship**, where a child class
inherits from a parent class.

Composition represents a **"has-a" relationship**, where one class
contains an object of another class.

Inheritance creates a stronger relationship, whereas composition
provides greater flexibility.

Composition should be preferred for **"has-a" relationships** because it
reduces coupling and improves maintainability.

**Examples:** - Inheritance: `Car` is a `Vehicle`. - Composition: `Car`
has an `Engine`.

------------------------------------------------------------------------

## Question 10

### Q. What are access modifiers, and how do they help control access to data and behavior?

**Answer:**

Access modifiers are keywords in Java that control the visibility and
accessibility of classes, variables, methods, and constructors.

Java has four access modifiers: - `public` -- Accessible from
anywhere. - `private` -- Accessible only within the same class. -
`protected` -- Accessible within the same package and by subclasses. -
**Default** -- Accessible only within the same package.

For example, in a `BankAccount` class, the `balance` variable is
declared as `private` and accessed through methods like `deposit()`,
`withdraw()`, or `getBalance()`.

Access modifiers help protect data, prevent unauthorized access, support
encapsulation, and make code more secure and maintainable.
