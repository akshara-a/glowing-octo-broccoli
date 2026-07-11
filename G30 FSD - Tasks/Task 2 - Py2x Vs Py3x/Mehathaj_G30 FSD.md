
# Python 2x vs Python 3x

### 1. Print Statement vs Print Function
---
### Python 2.x
print "Welcome to Python"
print "Value =", 10

### Python 3.x
print("Welcome to Python")
print("Value =", 10)
print("Hello", "World", sep=" - ")

### 2. Division Behavior
---
### Python 2.x
7 / 3      # 2
7 / 3.0    # 2.3333333

### Python 3.x
7 / 3      # 2.3333333
7 // 3     # 2

### 3. Unicode Handling
---
### Python 2.x
s1 = "hello"     # ASCII
s2 = u"hello"    # Unicode
print type(s1), type(s2)

### Python 3.x
s1 = "hello"      # Unicode by default
b1 = b"hello"     # Bytes
print(type(s1), type(b1))

### 4. Iteration (range vs xrange)
---
### Python 2.x
range(5)   # list
xrange(5)  # iterator

### Python 3.x
range(5)   # iterator

### 5. Input Function
---
### Python 2.x
name = raw_input("Enter name:")
num = input("Enter number:")

### Python 3.x
name = input("Enter name:")
num = int(input("Enter number:"))

### 6. Exception Syntax
---
### Python 2.x
except ValueError, e:

### Python 3.x
except ValueError as e:

### 7. Dictionary Methods
---
| Method      | Python 2.x | Python 3.x |
|-------------|------------|------------|
| keys()      | list       | view       |
| values()    | list       | view       |
| items()     | list       | view       |

### 8. Standard Library Changes
---
Python 2.x	Python 3.x
urllib2	urllib.request
Tkinter	tkinter
ConfigParser	configparser

### 9. End of Life
---
Python 2 → Ended in 2020
Python 3 → Actively supported
