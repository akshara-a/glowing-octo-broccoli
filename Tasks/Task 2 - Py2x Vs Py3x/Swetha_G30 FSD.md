Python 2 vs Python 3 
*Python 2 is old, Python 3 is the current version
*Python 2 isn’t updated anymore. Python 3 is what everyone uses now for new code.
Differences with Examples
1. Printing :

Python 2:

print "Hello"


Python 3:

print("Hello")

2. Text (strings):
Python 2 treats text as bytes:

s = "hello"
print type(s)   # <type 'str'>


Python 3 treats text as Unicode:

s = "hello"
print(type(s)) 

Python 3 can handle emojis also 

3. Division :

Python 2 does integer division by default:

print 3 / 2   # output: 1


Python 3 gives real division:

print(3 / 2)  # output: 1.5


To get integer division in Python 3:

print(3 // 2)  # output: 1

4. Libraries :

Modern libraries often drop Python 2 support.
For example, something like this might work only in Python 3:

import requests


finally , 
     Python 2 = old, retired
     Python 3 = newer, better, easier, and widely used
