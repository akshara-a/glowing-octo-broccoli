# Python 2 vs Python 3
1. Print Functionality

In Python 2, print works as a statement.
In Python 3, print() is a function, so parentheses are required.

# Python 2
print "Hello World"

# Python 3
print("Hello World")

2. Division Operation

Python 2 performs integer-based division when both values are integers.
Python 3 performs true (floating) division using /, and uses // for floor division.

# Python 2
7 / 3      # Output: 2

# Python 3
7 / 3      # Output: 2.3333333
7 // 3     # Output: 2

3. String & Unicode Support

Python 2 treats standard strings as ASCII. Unicode strings require the prefix u"".
In Python 3, Unicode is the default string format.

# Python 2
"text"        # ASCII
u"text"       # Unicode

# Python 3
"text"        # Unicode by default

4. Iteration (range vs xrange)

range() and xrange() behave differently in Python 2.
Python 3 removes xrange() and optimizes range() to act as an iterator.

# Python 2
range(4)     # Returns a list
xrange(4)    # Returns an iterator

# Python 3
range(4)     # Efficient iterator

5. Input Handling

Python 2 has two input options:

raw_input() → always returns a string

input() → evaluates input as Python code

Python 3 simplifies this behavior by providing just input().

# Python 2
raw_input()     # Output: string
input()         # Evaluates expression

# Python 3
input()         # Always returns a string

6. Exception Handling

Syntax for catching exceptions has been updated for better readability.

# Python 2
except KeyError, err:

# Python 3
except KeyError as err:

7. Dictionary Method Returns
Method	Python 2 Result	Python 3 Result
dict.keys()	list	view object
dict.values()	list	view object
dict.items()	list	view object

View objects use less memory and reflect real-time dictionary updates.

8. Standard Library Reorganization

Many libraries were restructured for clarity in Python 3. Examples:

Python 2	Python 3 Equivalent
urllib2	urllib.request, urllib.error
Queue	queue
9. Lifecycle & Support

Official support for Python 2 ended on January 1, 2020

No further maintenance or security fixes

Python 3 is recommended for all new development

# Key Takeaways
Feature	Python 2	Python 3
Print	Statement	Function
Division	Integer division	True division
Strings	ASCII default	Unicode default
Iteration	range & xrange	Single improved range
Input	raw_input & input	Only input()
Dictionary methods	Return lists	Return views
Support	Discontinued	Actively supported
# Why Python 3 is Better

Faster and more memory-efficient

Cleaner and more consistent syntax

Better support for globalization

Regular updates and security patches
