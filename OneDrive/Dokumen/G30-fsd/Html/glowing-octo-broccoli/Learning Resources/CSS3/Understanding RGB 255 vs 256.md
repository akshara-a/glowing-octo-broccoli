# Understanding RGB: 255 vs 256

- Each RGB channel (Red, Green, Blue) uses **8 bits**, allowing `2^8 = 256` possible intensity levels.  
- **Values range from 0 to 255** — zero = no light, 255 = full light.  
- **Why not 256?** Counting starts at 0, so the **maximum value is 255**, not 256.

**Example:**
```css
color: rgb(255, 0, 0); /* Full red, no green or blue */
```

**Analogy:**  
A ladder with 256 steps, starting at 0 → last step = 255. Total steps = 256.

**Total possible colors on a screen:**
```
256 × 256 × 256 = 16,777,216 colors
```

| Concept | Value |
|---------|-------|
| Number of levels | 256 |
| Minimum | 0 |
| Maximum | 255 |

**Key takeaway:**  
There are **256 levels per channel**, but the **highest value is 255**.
