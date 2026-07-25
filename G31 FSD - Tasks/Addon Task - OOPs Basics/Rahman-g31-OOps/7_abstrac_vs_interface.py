
# Difference Between an Abstract Class and an Interface

#     An abstract class is a class that cannot be instantiated and can contain both abstract methods (methods without a body) 
# and concrete methods (methods with a body). It can also have constructors, variables, and implemented methods.
#  An interface, on the other hand, is used to define a contract that a class must follow. It mainly contains abstract methods
#  (in Python, this is usually represented using abstract base classes). An interface focuses on what a class should do,
#  while an abstract class can define both what a class should do and how some tasks are performed.


# ABSTRACTION

from abc import ABC, abstractmethod

class Animal(ABC):

    @abstractmethod
    def sound(self):
        pass

    def sleep(self):
        print("Animal is sleeping")

class Dog(Animal):
    def sound(self):
        print("Dog barks")

d = Dog()
d.sound()
d.sleep()

#  INTERFACE

from abc import ABC, abstractmethod

class Shape(ABC):

    @abstractmethod
    def area(self):
        pass

class Circle(Shape):
    def area(self):
        print("Area of Circle")

c = Circle()
c.area()


#  Abstract Class = "What to do + How to do some of it."
#Interface = "Only What to do (Rules/Contract)."
 