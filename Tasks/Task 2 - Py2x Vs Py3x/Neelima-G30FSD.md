Python 2 vs Python 3 

1. Print Statement


Python 2 uses print as a statement

Python 3 uses print() as a function

code:
Python 2

print "Hello Python 2"

Python 3

print("Hello Python 3")




2. Integer Division



Python 2: / does integer division if both are integers

Python 3: / always does float division


 Code

Python 2

print 5 / 2   # Output: 2

Python 3

print(5 / 2)  # Output: 2.5
print(5 // 2) # Output: 2  (force integer division)


---

3. Unicode Strings


Python 2: Strings = ASCII

Python 3: Strings = Unicode by default

 Code

Python 2

s = "hello"      # ASCII
u = u"hello"     # Unicode

Python 3

s = "hello"      # Unicode by default



4. Input Function


Python 2:
raw_input() → string
input() → evaluates as code

Python 3:
input() → always returns string

 Code

Python 2

name = raw_input("Enter name: ")

Python 3

name = input("Enter name: ")



5. xrange() vs range()



Python 2: range() makes list, xrange() is memory-efficient

Python 3: range() acts like xrange()


 Code

Python 2

for i in xrange(5):
    print i

Python 3

for i in range(5):
    print(i)



6. Exception Handling Syntax


Python 2 uses comma

Python 3 uses as keyword


 Code

Python 2

try:
    x = 10 / 0
except ZeroDivisionError, e:
    print "Error:", e

Python 3

try:
    x = 10 / 0
except ZeroDivisionError as e:
    print("Error:", e)



7. Library Support


Python 2 ended support in 2020

Python 3 receives updates, all new libraries support Python 3 only


(No code needed)


8. String Formatting


Python 2: % formatting

Python 3: f-strings (fast & simple)


 Code

Python 2

x = 10
print "Value is %d" % x

Python 3

x = 10
print(f"Value is {x}")