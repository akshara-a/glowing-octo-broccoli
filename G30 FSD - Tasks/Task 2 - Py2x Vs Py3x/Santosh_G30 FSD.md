# Python2 vs Python3 Comparision.

1. Print Statement.
Python 2:
print "Hello"

Python 3:
print("Hello")  // In Python 3, print is a function.

2. Integer Division
Python 2:
5 / 2  # Output: 2

Python 3:
5 / 2  # Output: 2.5  // Python 3 gives true division.

3. Unicode Support
Python 2:
Strings are ASCII by default.

"hello"

Python 3:
Strings are Unicode by default.

"hello"

4. Input
Python 2:
raw_input()

Python 3:
input()

5. Range
Python 2:
range(5)  # returns list

Python 3:
range(5)  # returns iterable (faster)

6. Error Handling
Python 2:
except Exception, e:

Python 3:
except Exception as e:

7. Library Support
Python 2 is officially dead (EOL in 2020)

Python 3 is actively supported. // Modern libraries support Python 3 only.

8. Performance
Python 3 is faster, more optimized, and supports new features like:

> async/await
> f-strings
> type hints

# Example f-string:

name = "Santosh"
print(f"Hello {name}")


Output: Hello Santosh


_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
| Feature     | Python 2  | Python 3  |
| ----------- | --------- | --------- |
| Print       | Statement | Function  |
| Division    | 5/2 = 2   | 5/2 = 2.5 |
| Strings     | ASCII     | Unicode   |
| Input       | raw_input | input     |
| Performance | Slower    | Faster    |
| Support     | Ended     | Active    |
---------------------------------------
