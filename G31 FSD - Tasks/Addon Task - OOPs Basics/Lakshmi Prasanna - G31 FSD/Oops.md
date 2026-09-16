1 . What are the four main principles of Object-Oriented Programming?Explain each with an example.
    The four main Principles of OOP are:
      1.Encapsulation:
        Wrapping data and methods into a single class.
        Example:A Bank Account class keeps the balance private and allows access through methods.
      2.Inheritance:
        One class accquires the properties and methods of another class.
        Example:Dog inherits from Animal.
      3.Polymorphism:
        One method can perform different tasks depending on the object.
        Example:A draw() method behaves differently for circle and Rectangle.
      4.Abstraction:
        Hides implemetation details and shows only essential features.
        Example:Driving a car without knowing how the engine works.


2 . What is the difference between a class and an Object?
    Class:
      Blueprint,no memory allocated,Defines properties and methods
    object:
      Intsance of a class,Memory allocated,Uses these Properties and methods.
    Example:
    class Student{
      string name;
    }
    Student s1=new Student();

3 . What is encapsulation,and why is it important?
    Encapsulation is the process of hiding data by making variables private and accessing them through getter and setter methods.
    Importance:
      Proyects data.
      Improves security.
      Makes code easier to maintain.


4 . What is Inheritance? What are its advantages and disadvantages?
    Inheritance allows one class to inherit properties and methods from another class.
    Advantages:
      Code reusability
      Reduces duplication
      Easy maintenance
    Disadvantages:
      Tight coupling 
      Can make programs more complex
      Change in parent class may affect child classes


5 . What is Polymorphism? Explain compile-time and runtime polymorphism.
    Polymorphism means "many forms."
    Compile-time Polymorphism:
      Acheived by methods overloading.
        Example:
          add(int a,int b)
          add(double a,double b)
    Runtime Polymorphism:
      Acheived by method overriding.
        Example:
          Animal a = new Dog();
          a.sound();



6 . What is abstraction,and how is it difficult from encapsulation?
    Abstraction hides implemetation details and shows only neccesary information.
    Encapsulation hides data using access modifiers.
    Abstarction:                                       Encapsulation:
      Hides implementation.                               Hides data
      Uses abstract class/interface                       Uses Private variables
      Focuses on functionality                            Focuses on security


7 . What is the differences between an abstarct class and an interface?
    Abstarct Class:                                     Interface
      Can have abstract and normal methods.                Mainly conatins abstarct methods
      Uses extends                                         Uses implements
      Can have constructors                                Cannot have constructors



8 . What is the method Overloading, and how is it different from method overriding?
    Method Overlaoding:
       Same method name
       Different parameters
       Compile-time polymorphism
    Method Overriding:
      Same method name
      Same parameters
      Runtime polymorphism


9 . What is the difference between composition and inheritance? When should compostion be preferred?
    Inheritance:
      Represents an "is-a" relationship.
      Example:Dog is an Animal.
    Composition:
      Represents a "has-a" relationship.
      Example:Car has an Engine.
    Composition should be preferred when one class conatins another class and code flexibilty is needed.
    
    
10 . What are access modifers, and how do they help control access to data and behavior?
     Modifier          Access
      1.Public `         Accesible everywhere
      2.private          Accessible only within the same class
      3.protected        Accessible within the package and subclasses
      4.default          Accessible only within the same package
    Access modifiers improve security and prevent Unauthorized access to data.
