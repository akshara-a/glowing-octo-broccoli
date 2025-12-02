DIFFERENCE BETWEEN PYTHON2 AND PYTHON3

Print syntax:
Python 2: print "Hello"
Python 3: print("Hello")

Division behavior:
Python 2: 7 / 2 = 3 (integer division)
Python 3: 7 / 2 = 3.5 (true division)

Unicode support:
Python 2: default strings = ASCII
Python 3: default strings = Unicode

range vs xrange:
Python 2: xrange() for iteration, range() returns list
Python 3: range() acts like xrange (lazy, memory efficient)

Input function:
Python 2: raw_input()
Python 3: input()

Error handling syntax:
Python 2: except Exception, e:
Python 3: except Exception as e:

Dictionary iteration:
Python 2: d.items() → list
Python 3: d.items() → view object (iterator-like)

Long integers:
Python 2: separate int & long
Python 3: only int, supports large integers automatically

Metaclass syntax:
Python 2: __metaclass__ = Meta
Python 3: class A(metaclass=Meta)

next() usage:
Python 2: iterator.next()
Python 3: next(iterator)

Supporting libraries:
Python 2: Many new libraries no longer supported
Python 3: New libraries are Python 3 only

End of life (EOL):
Python 2: No longer maintained (stopped in 2020)
Python 3: Actively maintained and recommended

f-strings (formatted strings):
Python 2:  not available
Python 3:  available → f"Hello {name}"

Type hints:
Python 2:  no support
Python 3:  supported

Dictionary order preservation:
Python 2: order not guaranteed
Python 3: insertion order preserved (3.7+)

Final Conclusion
Python 3 is faster, safer, cleaner, supports modern features
 Python 2 is outdated, unsupported, and should not be used for new projects