Py2x vs Py3x – Bitwise Operations
1. Introduction

This document explains the differences between Python 2.x and Python 3.x with a focus on bitwise operations.
While bitwise operators (&, |, ^, ~, <<, >>) remain the same in both versions, their behavior changes due to differences in:

Integer types

Division rules

String and byte handling

2. Key Differences Between Python 2.x and Python 3.x (Bitwise Related)
Difference 1: Integer Types
Feature	Python 2.x	Python 3.x
Integer Types	int (fixed) and long (unlimited)	Only int (unlimited)
Impact on bitwise	Sometimes confusing between int and long	Cleaner and consistent
Why this change?

Python 3 removed long to simplify integer usage.
All integers automatically support large values.

Example
# Python 2.x
a = 10L
b = 12
print(a & b)

# Python 3.x
a = 10
b = 12
print(a & b)

Difference 2: Division and Bitwise Shifts

Python changed the / operator.

In Python 2.x

/ performs integer division when both operands are integers.

5 / 2 → 2

In Python 3.x

/ performs floating-point division.

5 / 2 → 2.5


Since bitwise shifts require integers, Python 3 can throw errors if / is used before shifting.

Example
# Python 2.x
x = 7 / 2      # 3
print(x << 1)  # 6

# Python 3.x
x = 7 / 2      # 3.5
# x << 1 → TypeError (float cannot be shifted)

Correct Python 3 version
x = 7 // 2
print(x << 1)

Difference 3: Strings vs Bytes in Bitwise Operations
Feature	Python 2.x	Python 3.x
Default string type	Byte string	Unicode string
Effect	Some bitwise operations easier with characters	Must use ord() or bytes explicitly
Example – Working with characters

Python 2.x

print(ord("A") & 0b1111)


Python 3.x

print(ord("A") & 0b1111)

Example – Using bytes in Python 3
b = b"A"
print(b[0] & 0b1111)

3. Bitwise Operators (Same in Both Versions)
Operator	Meaning	Example
&	AND	5 & 3 = 1
`	`	OR
^	XOR	5 ^ 3 = 6
~	NOT	~5 = -6
<<	Left Shift	5 << 1 = 10
>>	Right Shift	5 >> 1 = 2
4. Examples Showing Differences Clearly
Example 1 — Bitwise Shift After Division
Python 2.x
x = 10 / 3     # 3
print(x >> 1)  # 1

Python 3.x
x = 10 / 3     # 3.333...
# x >> 1 → ERROR

Correct Python 3 version
x = 10 // 3
print(x >> 1)

Example 2 — Byte Handling
Python 2.x
print("A"[0])         # returns "A"
print(ord("A") | 5)

Python 3.x
print("A"[0])         # returns "A"
print(ord("A") | 5)


Or using bytes:

b = b"A"
print(b[0] | 5)

5. Why These Changes Were Introduced
Change	Reason
Removed long type	Simplify integer logic
/ produces float	Make division mathematically correct
Unicode strings default	Improve global language support
Separate bytes type	Avoid confusion between text and data
Strict integer-only bitwise ops	Prevent errors
6. Summary Table
Topic	Python 2.x	Python 3.x
Integer types	int, long	Only int
/ division	Integer division	Floating division
Unicode support	Not default	Default
Byte handling needed?	Not required	Required for binary ops
Bitwise shifts	Allowed after /	Must use //
7. Conclusion

Bitwise operators did not change, but Python 3 introduced major improvements:

Simpler integer model

Better handling of text and binary data

Safer division behavior

Clearer requirements for bitwise operations

Python 3 provides a more consistent, error-free way to perform bitwise computation.
