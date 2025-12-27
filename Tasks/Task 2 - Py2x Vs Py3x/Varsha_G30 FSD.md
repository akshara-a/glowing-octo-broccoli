# Python 2 vs Python 3 by Varsha G30 - FSD

## 1. Print Usage

Python 2: print works like a standalone statement.\
Python 3: print() is a function, allowing parameters like sep, end, and file handling.

```python
#Python 2
print "Hi there"

# Python 3
print("Hi there")
```



## 2. Division Rules
Python 2 truncates integer division by default.\
Python 3 always performs floating-point division unless // is used.
```python
# Python 2
7 / 3   # Output: 2 (integer division)

# Python 3
7 / 3   # Output: 2.333...
7 // 3  # Output: 2
```



## 3. String & Unicode

Python 3 treats every string as Unicode, avoiding the ASCII/Unicode confusion seen in Python 2.

```python
# Python 2
"hello"   # bytes
u"hello"  # unicode

# Python 3
"hello"   # unicode (default)
```



## 4. Iteration & Ranges
xrange was removed in Python 3 because range() became memory-efficient and iterable.

```python
# Python 2
range(4)    # produces a list
xrange(4)   # produces a generator-like object

# Python 3
range(4)    # lazy sequence (like old xrange)
```



## 5. Input Handling
Python 3 removed the unsafe input() behavior from Python 2.

```python
# Python 2
raw_input()   # returns string
input()       # evaluates input as Python code

# Python 3
input()       # always returns string
```



## 6. Exception Format
Python 3 enforces a clearer and more readable exception syntax.

```python
# Python 2
except IOError, err:

# Python 3
except IOError as err:
```



## 7. Dictionary View Objects
| Method | Python 2 Output | Python 3 Output |
|--------|-----------------|-----------------|
| keys() |	list	|dynamic view
|values()|	list	|dynamic view
|items() |   list   |dynamic view

Python 3’s views update automatically if the dictionary changes and are more memory-friendly.


## 8. Library Adjustments

Many modules were renamed or reorganized in Python 3.\
Examples:
- ConfigParser → configparser
- Queue → queue
- Tkinter → tkinter

The new structure is more consistent and lowercase-based.


## 9. Python 2 End-of-Life

- Python 2 stopped receiving updates after January 1, 2020.

- Python 3 is the only actively maintained version and supports modern features like
type hints, f-strings, asyncio, and improved standard libraries.

## 10. Integer Handling

Python 2 separates int and long.\
Python 3 merges them into a single int type with unlimited precision.

```python
# Python 2
type(10)      # int
type(9999999999999999999)  # long

# Python 3
type(10)      # int
type(9999999999999999999)  # int (no long type)
```


## 11. Itertools & Generators

Python 3 emphasizes lazy evaluation.\
Functions like map(), filter(), zip() return iterators instead of lists.\
This makes Python 3 more memory-efficient.

```python
# Python 2
result = map(lambda x: x*x, [1,2,3])   # returns list

# Python 3
result = map(lambda x: x*x, [1,2,3])   # returns iterator
```


## 12. Error Messages & Syntax Improvements

Python 3 has clearer and more descriptive error messages.\
This makes debugging easier for beginners and developers.

Example:
```python
# Python 2 error might be cryptic
SyntaxError: invalid syntax

# Python 3 gives hints
SyntaxError: Missing parentheses in call to 'print'
```

