# Python 2 vs Python 3 — Comparison Notes
# 1.Print Usage

# Python 2:
print "Hello World"
# Python 3:
print("Hello World")
Python 3 uses print() as a function, giving more consistency and formatting options.

# 2.Division Behaviour
# Python 2:
5 / 2   # 2 (integer division)
# Python 3:
5 / 2   # 2.5 (true division)
5 // 2  # 2 (floor division)
Python 3 gives floating-point output by default.

# 3.String and Unicode Handling

# Python 2:
"text" is ASCII
u"text" is Unicode
# Python 3:
"text" is Unicode by default
This improves text processing and international language support.

# 4.range() vs xrange()

# Python 2:
range() returns a list
xrange() returns an iterator
# Python 3:
Only range() exists
It behaves like xrange() and is memory efficient

# 5.Input Function

# Python 2:
raw_input() → returns string
input() → evaluates the input (unsafe)
# Python 3:
input() → always returns string
raw_input() removed

# 6.Exception Syntax

# Python 2:
except ValueError, e:
# Python 3:
except ValueError as e:
Python 3 uses a cleaner and more readable syntax.

# 7.Dictionary Methods

Python 2 returns lists for keys, values, and items.
Python 3 returns dynamic views, which update automatically when the dictionary changes.

# 8.Standard Library Reorganization

Some modules were renamed for clarity.
Examples:
urllib2 → urllib.request
Queue → queue

# 9.End of Python 2 Support

Python 2 ended officially in January 2020
Python 3 is the supported and recommended version

# 10.Bitwise Operation Differences (Important)

Bitwise operators (&, |, ^, ~, <<, >>) are the same in both versions, but behavior changes due to integer and division differences.

# Integer Types
# Python 2:
Has int (fixed size) and long (unlimited)
# Python 3:
Only int (automatically unlimited)
Division Before Bitwise Shift
example:
Python 2:
x = 7 / 2   # 3
print(x << 1)   # 6
Python 3:
x = 7 / 2   # 3.5
# shifting this causes TypeError
Correct Python 3 version:
x = 7 // 2
print(x << 1)

# Strings vs Bytes in Bitwise

# Python 2:
Strings are byte-like, so bitwise ops work easily.
# Python 3:
Use bytes explicitly:
b = b"A"
print(b[0] & 0b1111)