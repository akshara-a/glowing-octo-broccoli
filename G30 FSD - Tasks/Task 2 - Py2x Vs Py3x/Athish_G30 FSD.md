## **Differences Between Python 2.x and Python 3.x**

### **1. Interpreter & Performance**
- Python 3 has an improved CPython interpreter with optimized opcodes, faster execution, and better memory management.  
- Dictionaries use **shared-key (split-table)** structure => 30-60% less memory.  
- Python 3.11+ introduces huge performance boosts over Python 2.

### **2. Unicode & String Model**
- **Python 2:** Two types → `str` (bytes), `unicode`  
- **Python 3:** Single model → `str` is Unicode, `bytes` separated  
- Improves global text handling (APIs, ML, databases).

### **3. Concurrency and Async**
- **Python 2:** No async/await, limited concurrency.  
- **Python 3:** Full async I/O (`asyncio`), async web frameworks (FastAPI, aiohttp).


### **4. Division Behavior**
- **Python 2:** `5 / 2 = 2`  
- **Python 3:** `5 / 2 = 2.5` (true division), use `//` for floor division.

### **5. Library Ecosystem**
- **Python 2:** Deprecated → no updates, no new libraries.  
- **Python 3:** Supports ML, AI, Data Science, APIs, and modern frameworks.

### **6. Interpreter Internal Changes**
- Improved garbage collector  
- Better bytecode generation  
- More efficient function calls  
- Removal of outdated modules (e.g., `commands`, `StringIO`)

### **7. Better Error Handling**
- **Python 2:** `except Exception, e`  
- **Python 3:** `except Exception as e`

### **8. Iterables & Ranges**
- **Python 2:** `range()` returns list, `xrange()` is generator  
- **Python 3:** `range()` is generator-like (memory-efficient)

### **9. Community & Support**
- **Python 2:** EOL (no updates)  
- **Python 3:** Actively developed, more secure, faster

