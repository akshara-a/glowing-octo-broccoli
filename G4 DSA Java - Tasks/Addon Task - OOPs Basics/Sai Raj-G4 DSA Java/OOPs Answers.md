\# Object-Oriented Programming (OOP) Interview Questions



\## 1. What are the four main principles of object-oriented programming? Explain each with an example.



\### Answer



The four main principles of Object-Oriented Programming are:



1\. Abstraction

2\. Encapsulation

3\. Inheritance

4\. Polymorphism



\### Abstraction



Abstraction is the process of hiding implementation details and showing only the essential features.



\*\*Example:\*\*



```java

abstract class Vehicle {

&#x20;   abstract void start();

}

```



\### Encapsulation



Encapsulation is the process of wrapping data and methods into a single unit (class). It protects data from unauthorized access.



\*\*Example:\*\*



```java

class Student {

&#x20;   private String name;



&#x20;   public void setName(String n) {

&#x20;       name = n;

&#x20;   }



&#x20;   public String getName() {

&#x20;       return name;

&#x20;   }

}

```



\### Inheritance



Inheritance is the process where one class acquires the properties and methods of another class. It helps in code reuse.



\*\*Example:\*\*



```java

class Animal {

&#x20;   void sound() {

&#x20;       System.out.println("Animal makes sound");

&#x20;   }

}



class Dog extends Animal {

}

```



\### Polymorphism



Polymorphism is the ability of one method to perform different tasks depending on the object.



\*\*Example:\*\*



```java

class Animal {

&#x20;   void sound() {

&#x20;       System.out.println("Animal sound");

&#x20;   }

}



class Dog extends Animal {

&#x20;   @Override

&#x20;   void sound() {

&#x20;       System.out.println("Bark");

&#x20;   }

}

```



\---



\# 2. What is the difference between a class and an object?



\## Answer



\### Class



\- It is a blueprint for creating objects.

\- It defines properties (variables) and methods.

\- No memory is allocated until an object is created.



\### Object



\- It is a real instance of a class.

\- It uses the properties and methods defined in the class.

\- Memory is allocated when an object is created.



\*\*Example:\*\*



```java

class Car { }



Car c1 = new Car();

```



Here:



\- `Car` → Class

\- `c1` → Object



\---



\# 3. What is encapsulation, and why is it important?



\## Answer



Encapsulation means hiding data by making variables private and accessing them through public methods.



\### Importance



\- Protects data

\- Improves security

\- Makes code easier to maintain



\*\*Example:\*\*



```java

private int age;



public void setAge(int age) {

&#x20;   this.age = age;

}

```



\---



\# 4. What is inheritance? What are its advantages and disadvantages?



\## Answer



Inheritance allows one class to use the properties and methods of another class.



\*\*Example:\*\*



```java

class Animal { }



class Dog extends Animal { }

```



\### Advantages



\- Code reuse

\- Easy maintenance

\- Supports method overriding



\### Disadvantages



\- Can make code complex

\- Changes in the parent class may affect child classes



\---



\# 5. What is polymorphism? Explain compile-time and runtime polymorphism.



\## Answer



Polymorphism means \*\*"many forms."\*\* One method behaves differently in different situations.



\### Compile-Time Polymorphism



Achieved using \*\*method overloading\*\*.



\*\*Example:\*\*



```java

class Math {



&#x20;   int add(int a, int b) {

&#x20;       return a + b;

&#x20;   }



&#x20;   int add(int a, int b, int c) {

&#x20;       return a + b + c;

&#x20;   }

}

```



\### Runtime Polymorphism



Achieved using \*\*method overriding\*\*.



\*\*Example:\*\*



```java

class Animal {



&#x20;   void sound() {

&#x20;       System.out.println("Animal");

&#x20;   }

}



class Dog extends Animal {



&#x20;   @Override

&#x20;   void sound() {

&#x20;       System.out.println("Bark");

&#x20;   }

}

```



\---



\# 6. What is abstraction, and how is it different from encapsulation?



\## Answer



\### Abstraction



\- Hides implementation details.

\- Shows only essential features.



\### Encapsulation



\- Hides data by making variables private.

\- Protects data from direct access.



\---



\# 7. What is the difference between an abstract class and an interface?



\## Answer



| Abstract Class | Interface |

|---------------|-----------|

| Uses `abstract` keyword | Uses `interface` keyword |

| Can have abstract and normal methods | Mostly contains abstract methods |

| Supports constructors | Does not have constructors |

| A class can extend only one abstract class | A class can implement multiple interfaces |



\---



\# 8. What is method overloading, and how is it different from method overriding?



\## Answer



\### Method Overloading



\- Same method name

\- Different parameters

\- Same class

\- Compile-time polymorphism



\*\*Example:\*\*



```java

void add(int a, int b) { }



void add(int a, int b, int c) { }

```



\### Method Overriding



\- Same method name

\- Same parameters

\- Parent and child classes

\- Runtime polymorphism



\*\*Example:\*\*



```java

class Animal {



&#x20;   void sound() { }

}



class Dog extends Animal {



&#x20;   @Override

&#x20;   void sound() { }

}

```



\---



\# 9. What is the difference between composition and inheritance? When should composition be preferred?



\## Answer



\### Inheritance



\- Represents an \*\*"is-a"\*\* relationship.

\- One class inherits another class.



\*\*Example:\*\*



```java

class Animal { }



class Dog extends Animal { }

```



\### Composition



\- Represents a \*\*"has-a"\*\* relationship.

\- One class contains another class as a member.



\*\*Example:\*\*



```java

class Engine { }



class Car {

&#x20;   Engine engine = new Engine();

}

```



\### When should composition be preferred?



\- When classes have a \*\*has-a\*\* relationship.

\- When you want flexible and loosely coupled code.

\- When inheritance is not appropriate.



\---



\# 10. What are access modifiers, and how do they help control access to data and behavior?



\## Answer



Access modifiers define where a class, variable, or method can be accessed.



\### Access Modifiers



| Modifier | Access Level |

|----------|--------------|

| \*\*public\*\* | Accessible from anywhere in the program |

| \*\*private\*\* | Accessible only within the same class |

| \*\*protected\*\* | Accessible within the same package and subclasses |

| \*\*default\*\* | Accessible only within the same package |



\*\*Example:\*\*



```java

public class Student {



&#x20;   private int age;



&#x20;   public void setAge(int age) {

&#x20;       this.age = age;

&#x20;   }

}

```



\### Benefits



\- Protects data

\- Improves security

\- Prevents unauthorized access

\- Makes code easier to maintain





