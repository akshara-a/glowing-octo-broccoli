# abstraction = the process of hiding implementation details and showing only the essential features of an object.

from abc import ABC, abstractmethod

# Abstract Class
class Animal(ABC):

    @abstractmethod
    def sound(self):
        pass

# Child Class
class Dog(Animal):
    def sound(self):
        print("Dog barks")

d = Dog()
d.sound()

# ENCAPSULATION = the process of wrapping data (variables) and methods (functions) into a single class and restricting direct access to the data.

class Student:
    def __init__(self):
        self.__marks = 90   # Private variable

    def show_marks(self):
        print(self.__marks)

s = Student()
s.show_marks()



#Abstraction = Hide the Implementation (How it works).
#Encapsulation = Hide the Data (Protect the data).