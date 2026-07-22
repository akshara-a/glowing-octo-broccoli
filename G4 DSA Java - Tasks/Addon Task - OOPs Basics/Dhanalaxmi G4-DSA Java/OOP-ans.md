# Object-Oriented Programming Interview Questions

1. What are the four main principles of object-oriented programming? Explain each with an example.
    i. Inheritance
    ii.Abstraction
    iii.Polymorphism
    iV. Encapsulation

    Examples of each
    i. Inheritance :: The mechanism where the features of super(parent) class is aquired by the sub(child)

    '''
    class
        class vechile
        {
            start()
            {
                console.log("vechile is started")
            }
        }
        class car extends vechile
        {
            name()
            {
                console.log("i'am a vechile")
            }
        }
            const v = new car();
            v.start();
'''
    ## java
'''
        class vechile
        {
            void start()
            {
                System.out.println("vechile started");
            }
        }
        calss car extends car
        {

            void name()
            {
                System.out.print("i'am a car vechile");
            }
            public static void main(String args[])
            {
            car c =new car();
            c.start();
            c.name();
        }
        }

 '''    
    ii. Abstraction :: is a policy of showing important details and hiding the internal implementation

    '''
        abstarct class TVremote
        {
           abstract void button();
        } 

        class pressed extends TVremote
        {
            void button()
            {
                System.out.println("button pressed");
            }
        }

        publlic class main()
        {
            public static void main(String args[])
            {
                pressed p = new pressed();
                p.button();
            }
        }
    '''

    iii. Polymorphism :: Polymorphism means the same method behaves differently for different objects.
    '''
        class Animal {
           sound() {
              console.log("Animal makes sound");
            }
        }

        class Dog extends Animal {
             sound() {
                 console.log("Dog Barks");
                    }
                }

        class Cat extends Animal {
             sound() {
                console.log("Cat Meows");
            }
            }

    const dog = new Dog();
    const cat = new Cat();

    dog.sound();
    cat.sound();
'''

    iv.Encapsulation :: Encapsulation means keeping data and functions together inside an object and controlling access to the data.

'''
    class Student {
    private int marks;

    public void setMarks(int m) {
        marks = m;
    }

    public int getMarks() {
        return marks;
    }
}
'''
2. What is the difference between a class and an object?
 -class ::

    * A calss is a template / layout/blueprint for creating objects.
    * It encapsulates the properties and methods.
    * It doesn't occupy any kind of memory and can create n no'of objects.

 -object ::

    * An object is an instance of a class,is used to access the data of a class
    *  can use the methods,properties defined in the class.
    * It occupy the memory when it is created.
    * each object has it's own memory and values.

3. What is encapsulation, and why is it important?

    Encapsulation :: 
    Encapsulation means keeping data and functions together inside an class and controlling access to the data from public.

Improtance :
 
    It provides security and privacy to the data from public / unauthorized access.

4. What is inheritance? What are its advantages and disadvantages?

    It is simply allowing the other(sub) class to extend it's features from super class 

    adv :
    The main is Code Reuseability,Extensibilty/scalability.
    disv :
    Improves complexity when the process of inheriting goes deeper.

5. What is polymorphism? Explain compile-time and runtime polymorphism.

This performs diffent actions on the current situation enabling dynamic adpotion to that senario

runtime time 

'''
  public class Calculator{

    public int add(int num1, int num2){
        return num1 + num2; 
      }

      public int add(int num1, int num2, int num3){
        return num1 + num2 + num3; 
      }

      public void display(){
        System.out.println("This is a simple Calculator");
      }

      public void cal(){
        System.out.println("This Calculator can perform basic math operations");
      }

  }

  class AdvCalculator extends Calculator{
      public void display(){
        System.out.println("This is a Advanced Calculator");
      }

      public void advCal(){
        System.out.println("This Calculator can perform basic and advanced math operations");
      }
  }
'''
compile time
'''
  public class MathRunner{
    public static void main(String[] args){
      Calculator simpleCal = new Calculator(); 

      // Compile time polymorphism as the result is know before execution
      simpleCal.add(5,10); 
      simpleCal.add(5,10,15); 

      Calculator smartCal = new AdvCalculator(); 


      // Runtime polymorphism
      smartCal.display(); // calls the display() method of advCalculator 
      smartCal.cal();     // calls the cal() method in Calculator
      smartCal.advCal();  // raise exception as the scope of smartCal of type Calculator cannot be extended to advCalculator scope 

    }
  }
'''
6. What is abstraction, and how is it different from encapsulation?

Abstraction → Hides how something works and shows only the necessary features.
Encapsulation → Hides the data and allows access only through methods,provides security for the data.

7. What is the difference between an abstract class and an interface?

Abstract Class

An abstract class is a class that cannot be used to create objects directly. It is meant to be extended by other classes and can contain both implemented methods.
only implemented in child class,a class can extend only one abstract class.
'''
class Animal {
    sound() {
        throw new Error("Method 'sound()' must be implemented.");
    }
}

class Dog extends Animal {
    sound() {
        console.log("Dog barks");
    }
}

const dog = new Dog();
dog.sound();
'''
Interface

An interface defines what methods a class should have, but it does not provide their implementation.
only contains method declarations, can follow multiple interfaces
'''
class Bird {
    fly() {
        console.log("Bird flies");
    }
}

class Eagle extends Bird {
    fly() {
        console.log("Eagle flies high");
    }
}

const eagle = new Eagle();
eagle.fly();
'''
8. What is method overloading, and how is it different from method overriding?

Method overloading : means having multiple methods with the same name but different parameters.

Is also called as runtime polymorphism.

Method overriding : means a child class provides its own implementation of a method that already exists in the parent class.

9. What is the difference between composition and inheritance? When should composition be preferred?

 Composition: It is the way of having an object of class in another class since it is a composition for that class.
  class Bag{
    String companyName; 
    int price; 
    Book book;  // Composition
  }

  class Book{
    String name; 
    String author; 
  }
Inheritance: It is the process of extending the features of a generic type to its sub types.

class Bag{ String companyName; int price; Book book; }

class SchoolBag extends Bag{ String color;
}

10. What are access modifiers, and how do they help control access to data and behavior?
Access modifiers are used to restrict the ability of class to control other classes to maintain proper integrity and privacy.

public
private
protected
default
final