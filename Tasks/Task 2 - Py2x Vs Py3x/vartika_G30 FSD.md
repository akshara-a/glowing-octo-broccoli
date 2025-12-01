# Differences Between Python 2 and Python 3


1. Print Statement Difference

In Python 2, print is a statement and does not require parentheses.
In Python 3, print is a function and requires parentheses, which makes formatting easier.

# Python 2
print "Hello World"

# Python 3
print("Hello World")
In Python 3, print() is a function.

2. Division Behavior

In Python 2, dividing two integers results in integer division.
In Python 3,  always performs true division, and performs floor division.

# Python 2
5 / 2      # Output: 2

# Python 3
5 / 2      # Output: 2.5
5 // 2     # Output: 2

3. Unicode and Strings

Python 2 strings are ASCII by default and Unicode must be explicitly defined with u"".
Python 3 strings are Unicode by default.

# Python 2
"text"     # ASCII
u"text"    # Unicode

# Python 3
"text"     # Unicode by default

4. Range and Xrange

In Python 2, range() returns a list and xrange() returns an iterator.
In Python 3, range() returns an iterator and xrange() has been removed.

# Python 2
range(5)    # List
xrange(5)   # Iterator

# Python 3
range(5)    # Iterator

5. Input Functions

In Python 2, raw_input() returns a string and input() evaluates the input as code.
In Python 3, only input() exists and always returns a string.

# Python 2
raw_input()   # Returns string
input()       # Evaluates expression

# Python 3
input()       # Returns string

6. Exception Syntax

In Python 2, exceptions use a comma.
In Python 3, the as keyword is used.

# Python 2
except ValueError, e:

# Python 3
except ValueError as e:

7. Dictionary Methods
Method	Python 2 Output	Python 3 Output
dict.keys()	list	view
dict.values()	list	view
dict.items()	list	view

In Python 3, these return view objects, which are more memory-efficient and dynamic.

8. Library Module Differences

Python 3 reorganized and renamed several standard libraries.
Example:

urllib2 → reorganized into urllib.request, urllib.error, etc.

Queue module renamed to queue

9. Support Status

Support for Python 2 officially ended in January 2020, so new projects should always use Python 3.
