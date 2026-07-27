

## 1. Four Main Principles of OOP

### a) Encapsulation
Encapsulation is the technique of **bundling data (attributes) and the methods that operate on that data into a single unit (a class)**, while restricting direct access to some of the object's components. This is usually done using access modifiers (`private`, `protected`, `public`).

**Why it matters:** It prevents external code from directly manipulating internal state in unsafe ways, and lets the internal implementation change without breaking code that depends on the class.

**Example (Java-style):**
```java
class BankAccount {
    private double balance; // hidden from outside

    public void deposit(double amount) {
        if (amount > 0) balance += amount;
    }

    public void withdraw(double amount) {
        if (amount > 0 && amount <= balance) balance -= amount;
    }

    public double getBalance() {
        return balance;
    }
}
```
Here, `balance` cannot be modified directly (`account.balance = -500` is not allowed); it can only be changed through controlled methods that enforce rules.

---

### b) Abstraction
Abstraction means **exposing only the essential features of an object while hiding the internal implementation details**. It focuses on *what* an object does, not *how* it does it.

**Example:**
```java
abstract class Vehicle {
    abstract void start();
}

class Car extends Vehicle {
    void start() {
        System.out.println("Car starts using ignition and fuel injection");
    }
}
```
The user of `Car` just calls `start()` — they don't need to know about ignition timing, fuel injection, or engine mechanics. The complexity is hidden behind a simple interface.

---

### c) Inheritance
Inheritance allows a class (child/subclass) to **acquire the properties and behaviors of another class (parent/superclass)**, promoting code reuse and establishing an "is-a" relationship.

**Example:**
```java
class Animal {
    void eat() {
        System.out.println("This animal eats food");
    }
}

class Dog extends Animal {
    void bark() {
        System.out.println("Dog barks");
    }
}
```
`Dog` automatically has access to `eat()` without rewriting it, and adds its own behavior `bark()`.

---

### d) Polymorphism
Polymorphism means **"many forms"** — the same method name or interface behaves differently depending on the object or input.

**Example:**
```java
class Animal {
    void sound() {
        System.out.println("Some generic sound");
    }
}

class Dog extends Animal {
    void sound() {
        System.out.println("Woof");
    }
}

class Cat extends Animal {
    void sound() {
        System.out.println("Meow");
    }
}
```
Calling `sound()` on an `Animal` reference produces different output depending on whether it actually points to a `Dog` or `Cat` object at runtime.

---

## 2. Class vs Object

| Aspect | Class | Object |
|---|---|---|
| Definition | A blueprint/template that defines attributes and behaviors | A concrete instance created from a class |
| Memory | No memory allocated until an object is created | Memory is allocated when the object is instantiated |
| Existence | Logical/conceptual entity | Physical/runtime entity |
| Example | `class Car { String color; void drive(){} }` | `Car myCar = new Car(); myCar.color = "Red";` |

**Analogy:** A class is like an architectural blueprint of a house. An object is an actual house built from that blueprint. You can build many houses (objects) from one blueprint (class), each with different paint colors or furniture (different attribute values) but the same structural design.

---

## 3. Encapsulation and Its Importance

**Definition:** Encapsulation is the bundling of data and the methods that act on that data within a single unit (class), combined with restricting direct access to some of the object's internal components using access modifiers.

**How it's implemented:**
- Declare fields as `private`
- Provide `public` getter/setter methods to access or modify them (with validation logic if needed)

**Why it's important:**
1. **Data protection** — prevents unauthorized or accidental modification of internal state (e.g., stopping someone from setting a negative age or balance).
2. **Flexibility to change implementation** — you can change how data is stored internally without affecting the code that uses the class, as long as the public interface stays the same.
3. **Improved maintainability** — bugs related to unexpected data changes are easier to trace since access is centralized through defined methods.
4. **Validation and control** — setters can enforce business rules before allowing changes (e.g., balance can't go negative).
5. **Reduces complexity for the user** — the consumer of the class only needs to know the public methods, not the internal workings.

---

## 4. Inheritance — Advantages and Disadvantages

**Definition:** Inheritance is a mechanism where a new class (subclass/child) derives attributes and behaviors from an existing class (superclass/parent), representing an **"is-a" relationship** (e.g., `Truck is a Vehicle`).

**Types:** Single, multilevel, hierarchical, and (in languages that support it) multiple inheritance.

### Advantages
- **Code reusability** — common logic is written once in the parent class and reused by all children.
- **Easier maintenance** — updating shared logic in the parent automatically applies to all subclasses.
- **Supports polymorphism** — enables method overriding and dynamic behavior.
- **Logical hierarchy** — models real-world relationships naturally (Animal → Dog → Puppy).

### Disadvantages
- **Tight coupling** — subclasses become dependent on the parent's implementation; changes in the parent can unexpectedly break child classes (the "fragile base class" problem).
- **Reduced flexibility** — a subclass inherits *everything* from the parent, even behavior it doesn't need, which can lead to unnecessary or awkward code.
- **Deep hierarchies become hard to maintain** — tracing behavior through many levels of inheritance can get confusing.
- **No multiple inheritance in many languages** — Java and C# don't allow a class to extend more than one class directly (to avoid ambiguity, the "diamond problem"), so interfaces are needed for that kind of design.

---

## 5. Polymorphism — Compile-Time vs Runtime

**Definition:** Polymorphism allows objects of different classes to be treated through a common interface, with the specific behavior depending on the actual object.

### Compile-Time (Static) Polymorphism
- Resolved **during compilation**, based on method signature (name + parameter types/number).
- Achieved through **method overloading** or **operator overloading**.
- Also called **early binding**.

**Example:**
```java
class Calculator {
    int add(int a, int b) {
        return a + b;
    }
    double add(double a, double b) {
        return a + b;
    }
}
```
The compiler decides which `add()` to call based on the argument types passed.

### Runtime (Dynamic) Polymorphism
- Resolved **during program execution**, based on the actual object type (not the reference type).
- Achieved through **method overriding** combined with inheritance and virtual method dispatch.
- Also called **late binding**.

**Example:**
```java
Animal a = new Dog();
a.sound(); // Calls Dog's sound(), decided at runtime
```
Even though `a` is declared as type `Animal`, the JVM checks the actual object (`Dog`) at runtime and calls its overridden method.

**Key difference:** Compile-time polymorphism is about *which method* is called (decided by the compiler based on signatures); runtime polymorphism is about *which implementation* runs (decided by the actual object type at runtime).

---

## 6. Abstraction vs Encapsulation

Though related, these are distinct concepts often confused with each other:

| Aspect | Abstraction | Encapsulation |
|---|---|---|
| Focus | Hides **complexity/implementation details** | Hides **data** and controls access to it |
| Level | Design-level concept — *what* an object does | Implementation-level concept — *how* data is protected |
| Achieved via | Abstract classes, interfaces | Access modifiers (private, protected, public) with getters/setters |
| Goal | Simplify interaction by exposing only relevant details | Protect internal state from unauthorized access/modification |
| Example | A car's steering wheel hides the mechanics of turning wheels | A private `balance` field accessible only via `deposit()`/`withdraw()` |

**Simplest way to remember:** Abstraction is about *design* — showing only essential features. Encapsulation is about *protection* — restricting access to internal data. Abstraction answers "what should be exposed?", encapsulation answers "how do we secure what's not exposed?"

---

## 7. Abstract Class vs Interface

| Aspect | Abstract Class | Interface |
|---|---|---|
| Method implementation | Can have both abstract (unimplemented) and concrete (implemented) methods | Traditionally only method declarations; modern languages (Java 8+) allow default/static methods |
| Fields/Variables | Can have instance variables with any access modifier | Fields are implicitly `public static final` (constants) |
| Constructors | Can have constructors | Cannot have constructors |
| Multiple inheritance | A class can extend only **one** abstract class | A class can implement **multiple** interfaces |
| Access modifiers on methods | Can have private, protected, public methods | Methods are implicitly public (unless default/private in newer versions) |
| When to use | When classes share a strong "is-a" relationship and some common implemented behavior | When unrelated classes need to guarantee a certain capability/contract, regardless of hierarchy |

**Example use case:**
- Use an **abstract class** when multiple related classes (e.g., `Car`, `Bike`, `Truck` — all `Vehicle`) share common code like `startEngine()`.
- Use an **interface** when unrelated classes need to guarantee some behavior — e.g., `Flyable` interface implemented by both `Bird` and `Airplane`, which are otherwise unrelated classes.

---

## 8. Method Overloading vs Method Overriding

### Method Overloading
- Same method **name**, but **different parameter list** (number, type, or order of parameters).
- Occurs **within the same class**.
- Resolved at **compile time** (compile-time polymorphism).
- Return type alone cannot differentiate overloaded methods.

```java
class Printer {
    void print(String text) { }
    void print(String text, int copies) { }
    void print(int number) { }
}
```

### Method Overriding
- Subclass provides its **own implementation** of a method that is **already defined in its parent class**, with the **same method signature** (same name, parameters, return type).
- Occurs **between parent and child classes** (requires inheritance).
- Resolved at **runtime** (runtime polymorphism).
- Requires the method in the parent to not be `final`, `static`, or `private`.

```java
class Animal {
    void sound() { System.out.println("Generic sound"); }
}
class Dog extends Animal {
    @Override
    void sound() { System.out.println("Woof"); }
}
```


---

## 9. Composition vs Inheritance

### Inheritance
- Represents an **"is-a" relationship**.
- A subclass extends a parent class and inherits its behavior directly.
- Example: `Car extends Vehicle` — a Car *is a* Vehicle.

### Composition
- Represents a **"has-a" relationship**.
- A class contains an instance of another class as a field, and delegates work to it, rather than inheriting behavior.
- Example: `Car` *has an* `Engine`.

```java
class Engine {
    void start() { System.out.println("Engine starting"); }
}

class Car {
    private Engine engine = new Engine(); // composition

    void start() {
        engine.start(); // delegate to the engine object
        System.out.println("Car is ready to drive");
    }
}
```

### When to Prefer Composition
1. **When the relationship isn't truly hierarchical** — a `Car` is not a *type of* `Engine`, so inheritance would misrepresent the relationship.
2. **When you need flexibility at runtime** — with composition, you can swap out the `Engine` object for a different implementation (e.g., electric vs petrol engine) without changing the `Car` class structure.
3. **To avoid fragile, deep inheritance hierarchies** — inheritance chains can become brittle; composition keeps classes more independent and loosely coupled.
4. **To avoid inheriting unwanted behavior** — inheritance forces a subclass to take on everything from the parent, even behavior it doesn't need; composition lets you pick only what's needed.
5. **Better testability** — composed components can be mocked/replaced easily in unit tests.

**Design principle:** *"Favor composition over inheritance"* — this is a widely respected guideline in software design (popularized by the Gang of Four's *Design Patterns* book) because composition generally leads to more modular, maintainable, and flexible code.

---

## 10. Access Modifiers

Access modifiers define the **visibility/accessibility** of classes, methods, and variables, and are key to enforcing encapsulation.


- **Private** — Accessible only within the same class. Used to hide implementation details completely (e.g., internal fields).
- **Default/Package-private** — Accessible only within the same package. Used when classes within a module need to cooperate but should be hidden from outside code.
- **Protected** — Accessible within the same package and by subclasses (even in different packages). Used when subclasses need access to inherited members but outside code shouldn't.
- **Public** — Accessible from anywhere. Used for the parts of a class meant to be the public API/interface.

### How They Help Control Access
1. **Enforce encapsulation** — by keeping fields `private` and exposing only necessary methods as `public`, you control exactly how external code interacts with an object's state.
2. **Prevent misuse** — restricting access reduces the risk of other parts of the program modifying internal data in unintended ways.
3. **Support abstraction** — `protected`/`private` members hide implementation details, while `public` methods expose only the essential functionality.
4. **Enable safe inheritance** — `protected` allows a controlled way for subclasses to access parent members without exposing them to the entire application.
5. **Improve maintainability** — since access is restricted and controlled, the internal implementation of a class can be changed freely as long as the public contract doesn't change, minimizing the ripple effect of changes throughout a codebase.

