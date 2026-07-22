1. What are the four main principles of object-oriented programming? Explain each with an example.

-   **Encapsulation:** Bundles data and methods together and restricts
    direct access.\
    *Example:* `private balance` in a `BankAccount` class accessed using
    `deposit()`.
-   **Abstraction:** Hides implementation details and shows only
    essential features.\
    *Example:* Calling `car.start()` without knowing the engine logic.
-   **Inheritance:** A class acquires properties and methods of another
    class.\
    *Example:* `Dog` inherits from `Animal`.
-   **Polymorphism:** One interface, many implementations.\
    *Example:* `draw()` behaves differently for `Circle` and
    `Rectangle`.

2. What is the difference between a class and an object?

-   **Class:** Blueprint for creating objects.
-   **Object:** Instance of a class with actual data.

3. What is encapsulation, and why is it important?

Encapsulation wraps data and methods together while restricting direct
access using access modifiers. It improves security, maintainability,
and data integrity.

4. What is inheritance? What are its advantages and disadvantages?

**Inheritance:** A child class inherits properties and methods of a
parent class.

**Advantages:** - Code reuse - Easier maintenance - Extensibility

**Disadvantages:** - Tight coupling - Can make code complex - Changes in
parent may affect child classes

5. What is polymorphism? Explain compile-time and runtime polymorphism.

Polymorphism allows the same method name to have different behaviors. -
**Compile-time polymorphism:** Method overloading. - **Runtime
polymorphism:** Method overriding

6. What is abstraction, and how is it different from encapsulation?

-   **Abstraction:** Hides implementation details.
-   **Encapsulation:** Protects data by restricting access.

7. What is the difference between an abstract class and an interface?

  -----------------------------------------------------------------------
  Abstract Class                      Interface
  ----------------------------------- -----------------------------------
  Can have implemented methods        Contains method declarations (plus
                                      default/static methods in modern
                                      Java)

  Can have constructors               Cannot have constructors

  A class extends one abstract class  A class can implement multiple
                                      interfaces
  -----------------------------------------------------------------------

8. What is method overloading, and how is it different from method overriding?

-   **Method Overloading:** Same method name, different parameters
    (compile-time).
-   **Method Overriding:** Child class provides its own implementation
    of a parent method (runtime).

9. What is the difference between composition and inheritance? When should composition be preferred?

-   **Inheritance:** "is-a" relationship.
-   **Composition:** "has-a" relationship.

Prefer **composition** when flexibility, loose coupling, and code reuse
are required.

10. What are access modifiers, and how do they help control access to data and behavior?

Access modifiers define visibility of class members: - **public:**
Accessible everywhere. - **private:** Accessible only within the
class. - **protected:** Accessible within the package and subclasses. -
**default (package-private):** Accessible only within the same package.
