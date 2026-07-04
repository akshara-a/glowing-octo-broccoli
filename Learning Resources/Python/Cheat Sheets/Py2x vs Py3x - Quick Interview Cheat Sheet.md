# Python 2 vs Python 3 — Quick Interview Cheat Sheet

## 1. Print
```python
# Python 2
print "Hello"

# Python 3
print("Hello")
```

## 2. Division
```python
# Python 2
5 / 2    # 2

# Python 3
5 / 2    # 2.5
5 // 2   # 2
```

## 3. Unicode
```python
# Python 2
"text"      # ASCII
u"text"     # Unicode

# Python 3
"text"      # Unicode (default)
```

## 4. Iteration
```python
# Python 2
range(5)   # list
xrange(5)  # iterator

# Python 3
range(5)   # iterator
```

## 5. Input
```python
# Python 2
raw_input()   # string
input()       # eval

# Python 3
input()       # string
```

## 6. Exception Syntax
```python
# Python 2
except ValueError, e:

# Python 3
except ValueError as e:
```

## 7. Dictionary Methods
| Method | Python 2 | Python 3 |
|--------|----------|-----------|
| dict.keys()   | list | view |
| dict.values() | list | view |
| dict.items()  | list | view |


## **1. Print Statement**
In Python 2, print is a statement, while in Python 3, print is a function. This provides consistency and allows additional functionality such as specifying output streams.

## **2. Division Behavior**
Python 2 performs integer division when dividing two integers, whereas Python 3 performs true division by default, returning a floating-point result.

## **3. Unicode Handling**
Python 2 treats strings as ASCII by default and requires a prefix for Unicode. Python 3 treats all strings as Unicode, improving global language support.

## **4. Iteration (range vs xrange)**
Python 2 includes both range (returns a list) and xrange (returns an iterator). Python 3 removes xrange and makes range behave like an efficient iterator.

## **5. Input Function**
Python 2 has two input functions — raw_input for strings and input for evaluation. Python 3 simplifies this by providing only input, which always returns a string.

## **6. Exception Syntax**
Python 2 uses an older exception format, while Python 3 uses a clearer and more standardized syntax (except Exception as e).

## **7. Dictionary Methods**
Python 2 returns lists for dictionary keys, values, and items. Python 3 returns dynamic view objects that are memory-efficient and reflect real-time dictionary changes.

## **8. Standard Library Changes**
Python 3 reorganized many standard libraries for better structure and readability, while Python 2 retains older naming and layout.

## **9. End-of-Life Status**
Python 2 reached end-of-life in January 2020 and is no longer maintained. Python 3 is actively developed and is the recommended version for all modern applications.