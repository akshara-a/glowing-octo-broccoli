#  METHOD OVRRIDING 

#   Method overloading is the concept of having multiple methods with the same name but different parameters
#  (different number or type of arguments). It allows a method to perform different tasks based on the arguments passed.


# OVERRIDING

class Animal:
    def sound(self):
        print("Animal makes a sound")

class Dog(Animal):
    def sound(self):
        print("Dog barks")

d = Dog()
d.sound()


#  Method Overloading → Same class + Different parameters
#Method Overriding → Parent & Child class + Same method + Inheritance
