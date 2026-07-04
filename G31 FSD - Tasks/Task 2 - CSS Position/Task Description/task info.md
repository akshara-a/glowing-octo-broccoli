# CSS Position Assignment 

## Part A – Static Position

1. Create a webpage containing three boxes.
2. Apply `position: static` to the second box.
3. Try using `top: 50px` and `left: 50px` on the static box.
4. Observe and explain the result.

---

## Part B – Relative Position

5. Create a box and apply `position: relative`.
6. Move the box 40px to the right and 20px down.
7. Explain how the box's original space is affected.
8. Create two adjacent boxes and move one using relative positioning. Describe the behavior of the other box.

---

## Part C – Absolute Position

9. Create a parent container and a child box.
10. Position the child at the top-right corner of the parent using `position: absolute`.
11. Place a notification badge on an image using absolute positioning.
12. Explain what happens when the parent container does not have a positioning context (`relative`, `absolute`, etc.).

---

## Part D – Fixed Position

13. Create a "Back to Top" button fixed at the bottom-right corner of the screen.
14. Add enough content to make the page scrollable.
15. Verify that the button remains visible while scrolling.
16. Create a fixed header that stays at the top of the page.

---

## Part E – Sticky Position

17. Create a navigation bar using `position: sticky`.
18. Make the navbar stick to the top of the page when scrolling.
19. Add multiple content sections to test the sticky behavior.
20. Explain the difference between `fixed` and `sticky`.

---

## Part F – z-index

21. Create three overlapping boxes.
22. Use `z-index` to place the blue box above the red box.
23. Place the green box above both.
24. Explain how `z-index` affects stacking order.

---

## Part G – Combined Application

25. Design a webpage that includes:
   - A sticky navigation bar
   - A fixed chat/support button
   - A product card with an absolute notification badge
   - A relative-positioned banner
   - Static content sections

26. Ensure all five position values are used at least once.
27. Add comments in the CSS explaining why each position type was chosen.

---

## Challenge Questions

28. What is the default value of the `position` property?
29. Which position type removes an element from the normal document flow?
30. Which position type keeps an element visible during scrolling?
31. Which position type requires a `top`, `left`, `right`, or `bottom` value to create a sticky effect?
32. What happens when multiple elements have the same `z-index` value?
33. When would you use `absolute` positioning instead of `relative` positioning?
34. Give one real-world example each for:
   - Static
   - Relative
   - Absolute
   - Fixed
   - Sticky

35. Build a complete webpage that demonstrates all CSS positioning concepts in a single layout.