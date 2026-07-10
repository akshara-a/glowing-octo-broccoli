# OOP Interview Questions — Explained My Way

Okay so before placements/interviews, everyone mugs up OOP definitions from GeeksforGeeks and then freezes when the interviewer asks "give me an example" in a follow-up. So I'm writing this the way I'd actually explain it to my roommate at 1 AM before an interview — in plain language, with examples that actually make sense, not textbook lines.

---

## 1. Four Pillars of OOP

Okay so basically OOP stands on 4 legs. If even one is missing, the interviewer will catch you. Here's how I remember them:

**a) Encapsulation** — Wrapping data and the functions that work on that data into one single unit (a class), and hiding the internal details from the outside world. Basically like a capsule medicine — you don't see what's inside, you just take it and it works.

Example: In a `BankAccount` class, `balance` is private. You can't just do `account.balance = 999999`. You have to go through a `deposit()` or `withdraw()` method, which can check things like "hey balance can't go negative."

**b) Abstraction** — Showing only the important stuff to the user and hiding the complicated implementation. Like when you drive a car, you just use the steering wheel and accelerator — you don't need to know how the engine's combustion cycle works.

Example: When you call `list.sort()` in Python, you don't care whether it's using merge sort or Tim sort internally. You just care that it sorts.

**c) Inheritance** — One class can inherit properties and methods from another class, so you don't have to write the same code again and again. It's basically the "parent-child" relationship.

Example: `Vehicle` class has `speed` and `move()`. `Car` and `Bike` classes extend `Vehicle` and automatically get those things without rewriting them.

**d) Polymorphism** — Same function name, different behavior depending on the object or the inputs. "Poly" = many, "morph" = forms. One interface, many implementations.

Example: `Shape` class has a `draw()` method. `Circle.draw()` draws a circle, `Square.draw()` draws a square. Same method name, different output depending on which object is calling it.

**Quick way to remember for viva:** A-P-I-E or E-A-P-I, doesn't matter the order, just make sure you say all 4 with one real example each and you're golden.

---

## 2. Class vs Object

This is the most basic one but somehow people still fumble it live.

**Class** = the blueprint/template. It doesn't exist physically in memory (no memory allocated for a class by itself, other than metadata). It just defines what properties and behaviors something will have.

**Object** = the actual real-world thing created from that blueprint. Memory IS allocated when you create an object.

My go-to analogy: think of `class Student` as the *idea* of a student — it says every student will have a `name`, `rollNumber`, `branch`, and a method `attendClass()`. Now when I write `Student s1 = new Student("Rahul", 21, "CSE")`, that's an actual object — a real, specific student sitting in memory with real values.

One class → many objects. Like one `Car` class can give you `car1` (Swift), `car2` (Creta), `car3` (Nexon) — same blueprint, different actual cars with different colors/models.

---

## 3. Encapsulation — What and Why

Encapsulation basically means: bundle the data (variables) and the code that operates on that data (methods) together, and don't let outsiders directly poke at the data. You interact only through defined methods (getters/setters or specific action methods).

**Why it matters (this is the part people forget to mention):**

- **Data protection** — nobody can set your `age = -5` or `cgpa = 15` by mistake because you control access through methods that can validate input.
- **Flexibility to change internal implementation** — if tomorrow you change how `balance` is stored internally (say, from `int` to `BigDecimal`), the outside code calling `getBalance()` doesn't need to change at all. You've hidden the internal mess.
- **Reduces bugs from other teams messing with your class** — in a big project, if fields are public, literally anyone on the team can mutate them randomly and break stuff. Private fields + controlled methods = less chaos.

Real example: In Java, we make instance variables `private` and expose `public` getter/setter methods. That's encapsulation in action — the classic "make fields private, provide get/set."

---

## 4. Inheritance — Advantages and Disadvantages

Inheritance = a class (child/subclass) acquires the properties and methods of another class (parent/superclass), using something like `extends` in Java or `:` in C++.

Example: `Employee` class has `name`, `salary`, `calculateSalary()`. Now `Manager` and `Developer` can extend `Employee` and add their own extra stuff like `teamSize` for Manager or `techStack` for Developer, without rewriting the common stuff.

**Advantages:**
- **Code reusability** — don't repeat the same fields/methods in every class.
- **Easy to maintain** — fix a bug once in the parent, it's fixed everywhere for all children.
- **Achieves runtime polymorphism** — because child classes can override parent methods, and calls get resolved at runtime.
- Logical hierarchy makes the design cleaner and mirrors real-world relationships (is-a relationship).

**Disadvantages (interviewers LOVE asking this part):**
- **Tight coupling** — child class becomes dependent on the parent. If you change something in the parent, it can break the child unexpectedly. This is called the "fragile base class problem."
- **Multiple inheritance issues** — languages like Java don't allow multiple inheritance with classes because of the Diamond Problem (if two parent classes have the same method, which one does the child inherit?). That's why Java uses interfaces to get around this.
- **Increases complexity** — deep inheritance chains (like A → B → C → D → E) become really hard to debug and trace.
- Can lead to unnecessary features being inherited that the child doesn't even need (bad design smell).

---

## 5. Polymorphism — Compile-time vs Runtime

Polymorphism just means "many forms" — same method name behaving differently.

**Compile-time Polymorphism (a.k.a. Static Binding / Method Overloading)**
The compiler decides which method to call at compile time itself, based on the method signature (number/type of parameters).

Example:
```java
void add(int a, int b) { }
void add(int a, int b, int c) { }
void add(double a, double b) { }
```
Same method name `add`, but different parameter lists. Compiler figures out which one to call just by looking at how you're calling it — before the program even runs.

**Runtime Polymorphism (a.k.a. Dynamic Binding / Method Overriding)**
Here, which method actually gets executed is decided at runtime, based on the actual object type, not the reference type. This happens through inheritance + method overriding.

Example:
```java
Shape s = new Circle();
s.draw();  // calls Circle's draw(), decided at runtime
```
Even though `s` is declared as type `Shape`, JVM checks at runtime what the actual object is (`Circle`) and calls that version of `draw()`. This is achieved through something called **dynamic method dispatch**.

**Simple way to remember:** Overloading = same class, same name, different parameters, decided at compile time. Overriding = parent-child classes, same name, same parameters, decided at runtime.

---

## 6. Abstraction vs Encapsulation

People genuinely confuse these two in interviews so let me break it down clean.

**Abstraction** is about *hiding complexity* — focusing on WHAT an object does rather than HOW it does it. It's a design-level concept, achieved using abstract classes and interfaces.

**Encapsulation** is about *hiding data* — bundling data and methods together and restricting direct access to the data. It's an implementation-level concept, achieved using access modifiers like `private`.

The way I explain it to myself: Abstraction is about hiding the *implementation logic* (the "how"), Encapsulation is about hiding the *actual data* (the "what's inside").

Analogy: Think of an ATM machine.
- **Abstraction** = you just see buttons like "Withdraw," "Check Balance." You don't know what happens internally — network calls to the bank server, database checks, etc. That complexity is abstracted away from you.
- **Encapsulation** = the actual cash, your account balance, the internal wiring — all locked inside the machine. You can't touch it directly; you can only interact through the buttons (methods).

So abstraction is more about *design* (what to show), encapsulation is more about *security/implementation* (how to protect it).

---

## 7. Abstract Class vs Interface

This is a classic "explain the difference" question, especially in Java context.

**Abstract Class:**
- Can have both abstract methods (no body) and concrete methods (with body).
- Can have instance variables, constructors.
- A class can extend only ONE abstract class (single inheritance).
- Use when classes share a common base and some common functionality/state.

**Interface:**
- Traditionally, all methods were abstract (no body) — though from Java 8 onwards, interfaces can have `default` and `static` methods with a body.
- Cannot have instance variables (only `public static final` constants).
- A class can implement MULTIPLE interfaces — this is how Java gets around the multiple inheritance problem.
- Use when unrelated classes need to guarantee the same behavior/contract, without sharing implementation.

**Example to make it click:** Think `Animal` as an abstract class — it can have a concrete method like `breathe()` (all animals breathe the same way) but an abstract method `makeSound()` (because a Dog barks, Cat meows — different implementations).

Now think `Flyable` and `Swimmable` as interfaces. A `Duck` can implement BOTH `Flyable` and `Swimmable` because in Java, you can only extend one class but implement many interfaces.

**One-liner for interview:** "Abstract class is for 'is-a' relationship with shared code, interface is for 'can-do' capability contracts across unrelated classes."

---

## 8. Method Overloading vs Method Overriding

Both sound similar but are completely different concepts.

**Method Overloading (Compile-time polymorphism):**
- Happens within the SAME class.
- Same method name, but different parameters (number, type, or order).
- Return type can be different too, but parameters MUST differ.
- Resolved at compile time (also called static/early binding).

```java
class Calculator {
    int add(int a, int b) { return a + b; }
    double add(double a, double b) { return a + b; }
}
```

**Method Overriding (Runtime polymorphism):**
- Happens between PARENT and CHILD class (needs inheritance).
- Same method name, SAME parameters, SAME return type (or covariant).
- Child class provides its own specific implementation of a method already defined in the parent.
- Resolved at runtime (dynamic/late binding).

```java
class Animal {
    void sound() { System.out.println("Some sound"); }
}
class Dog extends Animal {
    @Override
    void sound() { System.out.println("Bark"); }
}
```

**Quick table version for last-minute revision:**

| Point | Overloading | Overriding |
|---|---|---|
| Where | Same class | Parent-child classes |
| Parameters | Must differ | Must be same |
| Binding | Compile-time | Runtime |
| Inheritance needed? | No | Yes |
| Also called | Static polymorphism | Dynamic polymorphism |

---

## 9. Composition vs Inheritance

This is a slightly more "senior" level question but interviewers love it because it shows if you actually understand design, not just syntax.

**Inheritance** = "is-a" relationship. `Dog is-a Animal`. Child class gets everything from parent, including stuff it might not even need.

**Composition** = "has-a" relationship. Instead of inheriting from a class, you just include an object of that class as a field inside your class and use its functionality.

```java
// Inheritance
class Car extends Engine { }  // weird, a Car "is-a" Engine? doesn't make sense

// Composition (better)
class Car {
    private Engine engine;  // Car "has-a" Engine — makes more sense
}
```

**When to prefer composition over inheritance:**
- When the relationship is really "has-a" and not "is-a" (like above — a Car has an Engine, it's not a type of Engine).
- When you want to avoid tight coupling — with composition, you can swap out the `Engine` object at runtime with a different implementation (`PetrolEngine`, `ElectricEngine`) without breaking anything. With inheritance, you're locked into that hierarchy at compile time.
- When you want to avoid the fragile base class problem I mentioned in Q4 — changing the parent class doesn't ripple down and break child behavior.
- When you need functionality from multiple sources — Java doesn't allow multiple class inheritance, but you can compose multiple objects inside one class easily.

There's literally a famous design principle: **"Favor composition over inheritance."** It comes from the Gang of Four design patterns book. It's not saying never use inheritance, just that composition is usually more flexible and leads to better, more maintainable design in real-world large systems.

---

## 10. Access Modifiers

Access modifiers control WHO can see/use a class's variables and methods. It's basically the gatekeeping mechanism for encapsulation.

In Java, there are 4 levels:

**a) private** — Only accessible within the SAME class. Most restrictive. This is what we use for encapsulation (hiding data), so we make fields private and expose them via getters/setters.

**b) default (no modifier / package-private)** — Accessible only within the same package. If you don't write any modifier, this is what you get by default.

**c) protected** — Accessible within the same package AND by subclasses (even if the subclass is in a different package). This is mainly used when you want child classes to access parent stuff, but not literally everyone.

**d) public** — Accessible from anywhere, any class, any package. Least restrictive.

**Why they matter (how I'd explain the "why" part):**
- They enforce **encapsulation** — you decide exactly what part of your class is exposed to the outside world and what stays hidden/internal.
- They give you **control over your API** — as a class designer, you decide what other developers using your class SHOULD touch (public methods) and what they SHOULDN'T touch directly (private fields).
- They help in **security** — sensitive data (like passwords, balance, internal counters) stays protected from accidental or malicious modification from outside code.
- They support proper **inheritance design** — using `protected`, you allow child classes to access/extend behavior without exposing it to the whole world.

**Simple order to remember (most to least restrictive):**
`private → default → protected → public`

---