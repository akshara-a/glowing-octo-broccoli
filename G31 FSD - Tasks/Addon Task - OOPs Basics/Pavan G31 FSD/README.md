# 1. What are the four main principles of Object-Oriented Programming? Explain each with an example.

## Answer

Object-Oriented Programming (OOP) is a programming approach that organizes code using **objects**. An object contains **properties (data)** and **methods (functions)**. The four main principles (pillars) of OOP are:

1. Encapsulation
2. Abstraction
3. Inheritance
4. Polymorphism

These four principles help make programs more organized, reusable, maintainable, and easier to understand.

## 1. Encapsulation

### Definition

Encapsulation means **keeping data (properties) and methods (functions) together inside a single class or object**.

### Why is it important?

- Keeps related data and methods together.
- Makes the code more organized.
- Improves code maintenance.
- Protects data from accidental modification.

### Example

```javascript
class BankAccount {
    constructor(balance) {
        this.balance = balance;
    }

    deposit(amount) {
        this.balance += amount;
    }
}

const account = new BankAccount(5000);
account.deposit(1000);

console.log(account.balance);
```

### Output

```
6000
```

Here, the `balance` data and the `deposit()` method are kept together inside the `BankAccount` class.

## 2. Abstraction

### Definition

Abstraction means **hiding the internal implementation details and showing only the required functionality to the user**.

### Why is it important?

- Hides unnecessary implementation details.
- Makes programs easier to use.
- Allows users to focus only on what they need.

### Example

```javascript
CoffeeMachine.start();
```

The user simply calls the `start()` method. The internal process of heating water, grinding coffee, and preparing the drink is hidden.

---

## 3. Inheritance

### Definition

Inheritance allows one class (child class) to **inherit the properties and methods of another class (parent class)**.

### Why is it important?

- Promotes code reusability.
- Reduces duplicate code.
- Makes programs easier to extend.

### Example

```javascript
class Animal {
    eat() {
        console.log("Eating");
    }
}

class Dog extends Animal {
}

const dog = new Dog();
dog.eat();
```

### Output

```
Eating
```

The `Dog` class inherits the `eat()` method from the `Animal` class.

## 4. Polymorphism

### Definition

Polymorphism means **the same method name can have different behaviors depending on the object that uses it**.

### Why is it important?

- Makes code more flexible.
- Allows different objects to perform the same action in different ways.
- Improves code reusability.

### Example

```javascript
class Dog {
    sound() {
        console.log("Bark");
    }
}

class Cat {
    sound() {
        console.log("Meow");
    }
}

const dog = new Dog();
const cat = new Cat();

dog.sound();
cat.sound();
```

### Output

```
Bark
Meow
```

# 2. What is the difference between a class and an object?

## Answer

A **class** is a **blueprint or template** used to create objects. It defines the properties (data) and methods (functions) that an object will have.

An **object** is a **real instance** of a class. It is created from the class and contains actual values for the properties defined in the class.

## Difference Between Class and Object

| Class | Object |
|--------|--------|
| A blueprint or template for creating objects. | A real instance created from a class. |
| Defines properties and methods. | Contains actual data and can use the methods defined by the class. |
| Declared using the `class` keyword. | Created using the `new` keyword. |
| One class can create multiple objects. | Each object has its own data. |

---
# 3. What is encapsulation, and why is it important?

## Answer

**Encapsulation** is one of the four main principles of Object-Oriented Programming (OOP). It means **keeping data (properties) and methods (functions) together inside a single class or object**.

Encapsulation helps organize code by grouping related data and behavior into one unit.

---
# 4. What is inheritance? What are its advantages and disadvantages?

## Answer

**Inheritance** is one of the four main principles of Object-Oriented Programming (OOP). It allows a **child class** to inherit the properties and methods of a **parent class**. This enables code reuse and helps build relationships between classes.

## Advantages of Inheritance

- Promotes code reusability.
- Reduces duplicate code.
- Makes programs easier to extend.
- Improves code maintainability.
- Supports hierarchical relationships between classes.

## Disadvantages of Inheritance

- Creates dependency between parent and child classes.
- Changes in the parent class may affect child classes.
- Deep inheritance hierarchies can make code difficult to understand and maintain.
- Can reduce flexibility if not designed properly.

---
# 5. What is polymorphism? Explain compile-time and runtime polymorphism.

## Answer

**Polymorphism** is one of the four main principles of Object-Oriented Programming (OOP). It means **the same method or interface can perform different behaviors depending on the object that uses it**.

Polymorphism increases flexibility and allows different objects to respond differently to the same method call.

## Types of Polymorphism

### 1. Compile-Time Polymorphism

Compile-time polymorphism is achieved through **method overloading**. In method overloading, multiple methods have the same name but different parameters. The method to execute is determined during compilation.

### 2. Runtime Polymorphism

Runtime polymorphism is achieved through **method overriding**. A child class provides its own implementation of a method that is already defined in the parent class. The appropriate method is selected during program execution.

## Difference Between Compile-Time and Runtime Polymorphism

| Compile-Time Polymorphism | Runtime Polymorphism |
|----------------------------|----------------------|
| Achieved using method overloading. | Achieved using method overriding. |
| Resolved during compilation. | Resolved during program execution. |
| Faster execution. | Slightly slower because it is resolved at runtime. |

---
# 6. What is abstraction, and how is it different from encapsulation?

## Answer

**Abstraction** is one of the four main principles of Object-Oriented Programming (OOP). It means **hiding the internal implementation details of an object and exposing only the necessary functionality to the user**.

The user interacts with the object without needing to know how it performs its internal operations.

## Difference Between Abstraction and Encapsulation

| Abstraction | Encapsulation |
|-------------|---------------|
| Hides the internal implementation details. | Keeps data and methods together inside a class or object. |
| Focuses on **what** an object does. | Focuses on **how** data and methods are organized and protected. |
| Improves simplicity by exposing only essential features. | Improves organization and data protection. |

---

# 7. What is the difference between an abstract class and an interface?

## Answer

This concept is **not directly applicable to JavaScript** because JavaScript does not support **abstract classes** or **interfaces** as built-in language features like Java or C#.

However, JavaScript supports **classes**, **inheritance**, and **abstraction** through ES6 class syntax. Developers can simulate abstract classes by preventing direct object creation or by throwing errors inside methods that must be overridden by child classes.

Similarly, JavaScript does not have interfaces. Instead, developers follow a common structure or contract by implementing methods with the same names in different classes (also known as "duck typing").

## Key Difference

| Abstract Class | Interface |
|----------------|-----------|
| Not directly supported in JavaScript. | Not supported in JavaScript. |
| Can be simulated using ES6 classes. | Usually implemented through coding conventions (duck typing). |

---

# 8. What is method overloading, and how is it different from method overriding?

## Answer

### Method Overloading

Method overloading means creating multiple methods with the **same name** but **different parameters**.

**JavaScript does not support true method overloading** like Java or C++. If multiple methods with the same name are declared, the **last method overrides the previous ones**.

### Method Overriding

Method overriding occurs when a **child class provides its own implementation of a method that already exists in the parent class**.

JavaScript supports method overriding using **class inheritance**.

## Difference Between Method Overloading and Method Overriding

| Method Overloading | Method Overriding |
|--------------------|-------------------|
| Same method name with different parameters. | Child class redefines a parent class method. |
| Not supported in JavaScript. | Supported in JavaScript using inheritance. |
| Resolved at compile time in languages like Java. | Resolved at runtime. |

---

# 9. What is the difference between composition and inheritance? When should composition be preferred?

## Answer

### Inheritance

Inheritance is a relationship where a **child class inherits the properties and methods of a parent class**.

It represents an **"is-a" relationship**.

Example:

- Dog **is an** Animal.
- Car **is a** Vehicle.

---

### Composition

Composition is a relationship where one object **contains or uses another object** to achieve functionality.

It represents a **"has-a" relationship**.

Example:

- Car **has an** Engine.
- Computer **has a** Keyboard.

---

## Difference Between Composition and Inheritance

| Inheritance | Composition |
|--------------|-------------|
| Represents an **is-a** relationship. | Represents a **has-a** relationship. |
| Achieved using the `extends` keyword. | Achieved by creating objects inside other objects. |
| Creates a strong relationship between classes. | Creates a loose relationship between objects. |
| Reuses code through inheritance. | Reuses code by combining objects. |


## When Should Composition Be Preferred?

Composition should be preferred when:

- Flexibility is required.
- Multiple objects need to work together.
- You want to avoid deep inheritance hierarchies.
- Different behaviors need to be changed independently.

---

# 10. What are access modifiers, and how do they help control access to data and behavior?

## Answer

Access modifiers define **who can access the properties and methods of a class**. They help protect data and control how class members are used.

Unlike Java or C++, JavaScript has limited built-in access control.

## Access Modifiers

### 1. Public

- Accessible from anywhere.
- This is the default access level in JavaScript.

### 2. Private

- Accessible only within the same class.
- Declared using the `#` symbol.

### 3. Protected

- JavaScript does **not** have a built-in `protected` access modifier.
- It is usually implemented through coding conventions or by using TypeScript.

## Difference Between Access Modifiers

| Access Modifier | Accessible Inside Class | Accessible Outside Class | Supported in JavaScript |
|-----------------|-------------------------|--------------------------|-------------------------|
| Public | ✅ Yes | ✅ Yes | ✅ Yes (Default) |
| Private | ✅ Yes | ❌ No | ✅ Yes (`#`) |
| Protected | ✅ Yes | ❌ No | ❌ Not Built-in |

## Why Are Access Modifiers Important?

- Protect sensitive data.
- Improve security.
- Prevent accidental modification.
- Help implement encapsulation.
- Improve code maintainability.

---
