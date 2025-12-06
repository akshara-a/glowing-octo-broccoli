Python has two major versions — Python 2.x and Python 3.x. Python 3 is now the standard version with better features and modern syntax. Support for Python 2 officially ended in 2020.

🔹 Key Differences Table
Feature	Python 2.x	Python 3.x
Release Year	2000	2008
Support	Ended in 2020	Active and updated
Print	Statement	Function
Division	Integer division by default	True division
Unicode	Not by default	Default Unicode
Input	raw_input() used	input() only
Range	range() & xrange()	Only range()
Libraries	Many outdated	Full modern support
🧪 Differences with Examples
✔️ 1. Print Statement

Python 2

print "Hello"


Python 3

print("Hello")

✔️ 2. Division Behavior

Python 2

print 5/2   # Output: 2


Python 3

print(5/2)  # Output: 2.5

✔️ 3. String and Unicode

Python 2

s = "Hello"      # ASCII
u = u"नमस्ते"    # Unicode


Python 3

s = "नमस्ते"     # Unicode by default

✔️ 4. range() Function

Python 2

for i in xrange(3):
    print i


Python 3

for i in range(3):
    print(i)

✔️ 5. Input Method

Python 2

name = raw_input("Enter name: ")


Python 3

name = input("Enter name: ")

✔️ 6. Exception Handling

Python 2

try:
    x = 1/0
except Exception, e:
    print e


Python 3

try:
    x = 1/0
except Exception as e:
    print(e)
