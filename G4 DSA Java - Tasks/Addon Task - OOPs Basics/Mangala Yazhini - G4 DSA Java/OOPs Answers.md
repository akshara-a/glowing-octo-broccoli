# OOPs Answers 

# 1. What are the four main principles of object-oriented programming? Explain each with an example.

1) Inhertiance 
2) Abstraction
3) Polymorphism
4) Encapsulation

1) Inheritance: The mechanism of extending the features of super class to sub class is called Inheritance

```
  public class Employee {
    int id; 
    String name; 
    String companyName; 

    public void work(){
      System.out.println("Employee is working");
    }
  }

  class Manager extends Employee {
    
    // Inherited attributes 
    // int id 
    // Stirng name 
    // String companyName 

    // Overriden Method  
    public void work(){
      System.out.println( name + " is a Manager of " + companyName);
    }
  }


```

2. Abstraction: The policy of exposing the essential components and hiding the internal implementation of a system is called abstraction 

```
  public abstract Computer{

    public abstract void program(); 
    public abstract void playGame(); 

  }

  // The class which is extending the abstract class is responsible for implementing the declared methods   
  public class Mobile extends Computer{

    public abstract void program(){

      System.out.println("Program is being executed ...");

    }

    public abstract void playGame(){
      
      System.out.println("Play and Enjoy your favourite Game !");

    } 


  }
```

3. Polymorphism: This feature enables a system to act different based on the current situation enabling dynamic adaption to that senario. 

```
  class Calculator{
    public int add(int num1, int num2){
      return num1 + num2; 
    }

    public int add(int num1, int num2, int num3){
      return num1 + num2 + num3; 
    }
  }

  public class CalculatorRunner{
    public static void main(String[] args){
      Calculator cal = new Calculator(); 

      cal.add(5,10);  // calls add(int, int)

      cal.add(5,10,15);  // calls add(int, int, int)
    }
  }
```

4. Encapsulation: This is a process of protecting the attributes of a class be restricting its access from outside its own class for security and privacy. 

```
  public class Account{
    private String accNo; 
    private double accountBalance;

    public void setAccNo(String accNo){
      this.accNo = accNo; 
    } 

    public void setAccountBalance(double accountBalance){
      this.accountBalance = accountBalance; 
    } 

    public String getAccNo(){
      return accNo; 
    } 

    public double getAccountBalance(){
      return accountBalance; 
    } 

   public class BankAccountRunner{
    public static void main(String[] args){
      Account accoun1 = new Account(); 
      account.setAccNo("45504859920"); 
      account.setAccountBalance(10000.0);


      System.out.println("Account No : " + account1.getAccNo());
      System.out.println("Account Balance : " + account1.getAccountBalance());
    }
  }

  }
```

2. What is the difference between a class and an object?

Class : A Class is an overview or layout of the object structure which does not hold space in memory and gives only the outline view of the real object. 

Object : It is the actual entity that is built using the Class layout

3. What is encapsulation, and why is it important?

Encapsulation is necessary concept in OOP that protects the attributes and methods from being accessed by unauthorized classes, thus preventing privacy and security. 

4. What is inheritance? What are its advantages and disadvantages?

Inheritance provides the ability to extends the common features of one class to another and provides the flexibility of code reusability.

5. What is polymorphism? Explain compile-time and runtime polymorphism.
This feature enables a system to act different based on the current situation enabling dynamic adaption to that senario. 

```
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

```
```
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

```

6. What is abstraction, and how is it different from encapsulation?

Abstraction is the process of hiding the internal working of a method by showing only the outer user friendly part, whereas encapsulation is about protecting data and method being accessed by unauthorized classes to ensure the privacy 

7. What is the difference between an abstract class and an interface?

The abstract class are the ones that contain the method declartion and hides the implementation which is similar to interfaces but can have any other methods with complete implementation and variables, but interfaces can only contain final variables and only abstract methods. 

8. What is method overloading, and how is it different from method overriding?
Overloading: It has the same method name, but differs in the parameters passed onto the function in a same class. 

Overriding: The super class method with exact name and parameters is redefined in subclass is called overloading. 

9. What is the difference between composition and inheritance? When should composition be preferred?
Composition: It is the way of having an object of class in another class since it is a composition for that class. 

```
  class Bag{
    String companyName; 
    int price; 
    Book book;  // Composition
  }

  class Book{
    String name; 
    String author; 
  }
```

Inheritance: It is the process of extending the features of a generic type to its sub types. 
```
class Bag{
    String companyName; 
    int price; 
    Book book;
}

class SchoolBag extends Bag{
  String color;  
}
```
10. What are access modifiers, and how do they help control access to data and behavior?

Access modifiers are used to restrict the ability of class to control other classes to maintain proper integrity and privacy. 

  - public    
  - private
  - protected
  - default
  - final




