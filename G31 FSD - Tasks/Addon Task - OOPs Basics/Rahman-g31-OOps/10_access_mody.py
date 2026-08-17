
# ACCESS MODIFIERS

#  used to control the visibility and accessibility of data (variables) and methods (functions) in a class.
#  They help protect data from unauthorized access and support the principle of encapsulation.

#  Public Access Modifier

class Student:
    def __init__(self):
        self.name = "Ali"

s = Student()
print(s.name)

#Protected Access Modifier 

class Student:
    def __init__(self):
        self._marks = 85

class Result(Student):
    def display(self):
        print(self._marks)

r = Result()
r.display()

# Private Access Modifier

class Student:
    def __init__(self):
        self.__marks = 90

    def show(self):
        print(self.__marks)

s = Student()
s.show()


# Public → Everyone can access.
#Protected → Class + Child class can access.
#Private → Only the same class can access.