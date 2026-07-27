# CSS Position Assignment

## Part A – Static Position

### Observation
When add `position: static` to the second box and used `top: 50px` and `left: 50px`, the box did not move. It remained in its original position.

### Explanation
`position: static` is the default positioning value in CSS. Elements follow the normal document flow, and properties such as `top`, `left`, `right`, and `bottom` do not affect them.

---

## Part B – Relative Position

### Observation
The box moved 40px to the right and 20px down from its original position. The original space occupied by the box remained reserved.

When one of two adjacent boxes was moved using relative positioning, the other box stayed in its original place.

### Explanation
Relative positioning moves an element visually while keeping its original space in the document flow.

---

## Part C – Absolute Position

### Observation
The child box was positioned at the top-right corner of the parent container. The notification badge was successfully placed on top of the image/card.

### Explanation
Absolute positioning removes an element from the normal document flow and positions it relative to the nearest positioned ancestor.

If the parent container does not have a positioning context (`relative`, `absolute`, `fixed`, or `sticky`), the child element is positioned relative to the page instead.

---

## Part D – Fixed Position

### Observation
The header remained visible at the top of the page while scrolling. The "Back to Top" button stayed visible at the bottom-right corner throughout scrolling.

### Explanation
Fixed positioning places an element relative to the browser viewport, allowing it to remain visible even when the page is scrolled.

---

## Part E – Sticky Position

### Observation
The navigation bar scrolled normally at first. Once it reached the top of the page, it stayed fixed there while the rest of the content continued scrolling.

### Explanation
Sticky positioning behaves like relative positioning until the specified position is reached, after which it behaves like fixed positioning.

### Difference Between Fixed and Sticky

- Fixed elements remain in the same position at all times.
- Sticky elements become fixed only after reaching the specified position during scrolling.

---

## Part F – z-index

### Observation
The three boxes overlapped each other. The blue box appeared above the red box, and the green box appeared above both.

### Explanation
The `z-index` property controls the stacking order of overlapping elements. Elements with higher `z-index` values appear above elements with lower values.

---

## Part G – Combined Application

### Observation
The webpage successfully demonstrated all five CSS positioning values:
- Sticky navigation bar
- Fixed chat button
- Relative banner
- Absolute notification badge
- Static content sections

### Explanation
Each positioning value was used in a practical scenario to demonstrate its purpose and behavior within a webpage layout.

---

