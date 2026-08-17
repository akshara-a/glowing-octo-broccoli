# Object-Oriented Programming (OOP) -- Questions & Answers

## 1. What are the four main principles of object-oriented programming? Explain each with an example.

The four main principles of OOP are **Encapsulation, Inheritance,
Polymorphism, and Abstraction**.

-   **Encapsulation** means keeping data and the methods that work on it
    inside the same class while restricting direct access to the data.
    -   **Example:** In a `BankAccount` class, the `balance` variable is
        private and can only be changed using `deposit()` or
        `withdraw()`.
-   **Inheritance** allows one class to reuse the properties and methods
    of another class.
    -   **Example:** A `Dog` class inherits common features like `name`
        and `eat()` from an `Animal` class.
-   **Polymorphism** means the same method can behave differently for
    different objects.
    -   **Example:** A `draw()` method draws different shapes for
        `Circle` and `Rectangle`.
-   **Abstraction** hides unnecessary implementation details and shows
    only the required functionality.
    -   **Example:** Calling `car.start()` without knowing how the
        engine starts.

------------------------------------------------------------------------

## 2. What is the difference between a class and an object?

A **class** is a blueprint used to create objects. It defines the
properties and methods an object will have.

An **object** is an actual instance of a class. It contains real data
and occupies memory.

**Example:** `Car` is a class, while `myCar` created from it is an
object.

------------------------------------------------------------------------

## 3. What is encapsulation, and why is it important?

Encapsulation means combining data and methods into a single class and
protecting the data from direct access using access modifiers.

**Importance:** - Protects sensitive data. - Prevents invalid changes. -
Makes code easier to maintain and debug.

**Example:** A bank account's balance is private and can only be
modified through methods.

------------------------------------------------------------------------

## 4. What is inheritance? What are its advantages and disadvantages?

Inheritance allows a child class to use the properties and methods of a
parent class.

**Advantages** - Reduces code duplication. - Makes programs easier to
extend. - Promotes code reuse.

**Disadvantages** - Creates tight coupling. - Changes in the parent
class may affect child classes. - Deep inheritance can make code
difficult to understand.

------------------------------------------------------------------------

## 5. What is polymorphism? Explain compile-time and runtime polymorphism.

Polymorphism means **one interface, many forms**.

-   **Compile-time polymorphism:** Achieved using **method
    overloading**, where methods have the same name but different
    parameters.
-   **Runtime polymorphism:** Achieved using **method overriding**,
    where a child class provides its own implementation of a parent
    method.

------------------------------------------------------------------------

## 6. What is abstraction, and how is it different from encapsulation?

Abstraction hides implementation details and shows only essential
features.

Encapsulation protects data by restricting direct access to it.

**Difference:** Abstraction focuses on **what** an object does, while
encapsulation focuses on **how the data is protected**.

------------------------------------------------------------------------

## 7. What is the difference between an abstract class and an interface?

  -----------------------------------------------------------------------
  Abstract Class                      Interface
  ----------------------------------- -----------------------------------
  Can have both abstract and normal   Mainly contains abstract methods
  methods.                            (can also have default/static
                                      methods in Java).

  Can have constructors and instance  Cannot have constructors.
  variables.                          

  A class can extend only one         A class can implement multiple
  abstract class.                     interfaces.
  -----------------------------------------------------------------------

------------------------------------------------------------------------

## 8. What is method overloading, and how is it different from method overriding?

**Method Overloading** - Same method name, different parameter list. -
Happens in the same class. - Compile-time polymorphism.

**Method Overriding** - Child class provides a new implementation of a
parent method. - Requires inheritance. - Runtime polymorphism.

------------------------------------------------------------------------

## 9. What is the difference between composition and inheritance? When should composition be preferred?

**Inheritance** represents an **is-a** relationship.

**Composition** represents a **has-a** relationship.

Composition should be preferred when you want flexible, loosely coupled
code because it is easier to modify and reuse.

**Example:** A `Car` has an `Engine` (composition), instead of a `Car`
being an `Engine`.

------------------------------------------------------------------------

## 10. What are access modifiers, and how do they help control access to data and behavior?

Access modifiers decide who can access the members of a class.

-   **public:** Accessible from anywhere.
-   **private:** Accessible only within the same class.
-   **protected:** Accessible within the same package and subclasses.
-   **default (package-private):** Accessible only within the same
    package.

Using access modifiers improves security, protects data, and prevents
unauthorized access.
