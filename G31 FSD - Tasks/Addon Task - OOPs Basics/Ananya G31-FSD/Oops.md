# Assignment: Object-Oriented Programming (OOP) Interview Questions

## 1. What are the four main principles of Object-Oriented Programming? Explain each with an example.

Object-Oriented Programming (OOP) is a programming paradigm that
organizes programs using objects and classes. It is based on four
fundamental principles:

### a) Encapsulation

Encapsulation is the process of combining data (variables) and the
methods (functions) that operate on that data into a single unit called
a **class**. It also restricts direct access to the data using access
modifiers such as `private`, `protected`, and `public`.

**Advantages:** - Protects data from unauthorized access. - Improves
security. - Makes the code easier to maintain. - Reduces accidental
modification of data.

**Example:** In a `BankAccount` class, the `balance` variable is private
and can only be modified using methods such as `deposit()` and
`withdraw()`.

### b) Inheritance

Inheritance allows one class (child class) to inherit the properties and
methods of another class (parent class). It promotes code reusability
and reduces duplication.

**Advantages:** - Code reusability. - Easier maintenance. - Reduces
duplicate code.

**Example:** A `Car` class inherits common features like `start()` and
`stop()` from a `Vehicle` class.

### c) Polymorphism

Polymorphism means **"many forms."** It allows the same method or
interface to behave differently depending on the object.

**Example:** A `draw()` method can draw a circle for a `Circle` object
and a rectangle for a `Rectangle` object.

### d) Abstraction

Abstraction hides unnecessary implementation details and shows only the
essential features required by the user.

**Advantages:** - Reduces complexity. - Improves readability. - Makes
programs easier to maintain.

**Example:** A user can drive a car without knowing the internal working
of the engine.

------------------------------------------------------------------------

## 2. What is the difference between a class and an object?

A **class** is a blueprint or template used to create objects. An
**object** is an instance of a class that contains actual values and
occupies memory.

  Class                                              Object
  -------------------------------------------------- ---------------------
  Blueprint or template                              Instance of a class
  Logical entity                                     Physical entity
  Does not occupy memory until objects are created   Occupies memory
  Example: `Student`                                 Example: `student1`

------------------------------------------------------------------------

## 3. What is encapsulation, and why is it important?

Encapsulation is the process of wrapping data and methods into a single
unit and restricting direct access to data using access modifiers.

### Importance

-   Protects sensitive data.
-   Prevents unauthorized access.
-   Improves maintainability.
-   Makes debugging easier.
-   Supports data hiding.

**Example:** In a banking application, the account balance is private
and can only be accessed using methods like `deposit()` and
`withdraw()`.

------------------------------------------------------------------------

## 4. What is inheritance? What are its advantages and disadvantages?

Inheritance allows one class to inherit the properties and methods of
another class.

### Advantages

-   Promotes code reusability.
-   Reduces code duplication.
-   Makes maintenance easier.
-   Supports runtime polymorphism.

### Disadvantages

-   Creates tight coupling.
-   Changes in the parent class may affect child classes.
-   Deep inheritance hierarchies can make programs difficult to
    understand.

------------------------------------------------------------------------

## 5. What is polymorphism? Explain compile-time and runtime polymorphism.

Polymorphism enables a single interface to represent different forms.

### Compile-Time Polymorphism (Method Overloading)

-   Achieved through method overloading.
-   Same method name with different parameters.
-   Resolved by the compiler.

**Example**

``` cpp
add(int a, int b)
add(float a, float b)
```

### Runtime Polymorphism (Method Overriding)

-   Achieved through method overriding.
-   Child class provides its own implementation of a parent class
    method.
-   Resolved during program execution.

**Example:** A `Dog` class overrides the `sound()` method of the
`Animal` class.

------------------------------------------------------------------------

## 6. What is abstraction, and how is it different from encapsulation?

**Abstraction** hides implementation details and focuses on what an
object does.

**Encapsulation** hides data and protects it from unauthorized access.

  -----------------------------------------------------------------------
  Abstraction                      Encapsulation
  -------------------------------- --------------------------------------
  Hides implementation             Hides data

  Focuses on functionality         Focuses on data security

  Achieved using abstract classes  Achieved using access modifiers
  and interfaces                   
  -----------------------------------------------------------------------

------------------------------------------------------------------------

## 7. What is the difference between an abstract class and an interface?

  -----------------------------------------------------------------------
  Abstract Class                             Interface
  ------------------------------------------ ----------------------------
  Can contain both abstract and concrete     Mainly contains method
  methods                                    declarations (depends on
                                             language)

  Can have constructors                      Cannot have constructors

  Can contain instance variables             Usually contains constants

  Used for shared implementation             Used to define a common
                                             contract
  -----------------------------------------------------------------------

------------------------------------------------------------------------

## 8. What is method overloading, and how is it different from method overriding?

### Method Overloading

-   Same method name.
-   Different parameter list.
-   Occurs within the same class.
-   Compile-time polymorphism.

### Method Overriding

-   Same method name and parameters.
-   Occurs in parent and child classes.
-   Runtime polymorphism.

  Method Overloading     Method Overriding
  ---------------------- --------------------------
  Same class             Parent and child classes
  Different parameters   Same parameters
  Compile time           Runtime

------------------------------------------------------------------------

## 9. What is the difference between composition and inheritance? When should composition be preferred?

### Inheritance

Represents an **"is-a"** relationship.

**Example:** A `Dog` is an `Animal`.

### Composition

Represents a **"has-a"** relationship.

**Example:** A `Car` has an `Engine`.

### Composition should be preferred when:

-   Loose coupling is required.
-   Objects need to be reused independently.
-   Relationships may change over time.
-   Greater flexibility is needed than inheritance provides.

------------------------------------------------------------------------

## 10. What are access modifiers, and how do they help control access to data and behavior?

Access modifiers determine the visibility of variables and methods.

  Access Modifier      Description
  -------------------- ------------------------------------------------
  **public**           Accessible from anywhere
  **private**          Accessible only within the same class
  **protected**        Accessible within the class and its subclasses
  **default (Java)**   Accessible only within the same package

### Benefits

-   Protects sensitive information.
-   Prevents unauthorized access.
-   Supports encapsulation.
-   Improves program security and maintainability.

------------------------------------------------------------------------
