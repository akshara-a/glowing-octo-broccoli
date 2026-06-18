

# CSS Position Assignment Test

## Project Title
CSS Position Property Demonstration Website


## Files Used

- index.html
- style.css
- test.md


# Testing Report


## Part A - Static Position Test

### Test:
Applied:

```css
position: static;
top:50px;
left:50px;
Result:

The box did not move.

Explanation:

Static is the default position value.
The properties top, left, right, and bottom do not work with static positioning.

Part B - Relative Position Test
Test:

Applied:

position:relative;
left:40px;
top:20px;
Result:

The box moved 40px right and 20px down.

Explanation:

The element moved from its original position but the original space remained reserved.

Other boxes did not move because relative positioning does not remove the element from normal flow.

Part C - Absolute Position Test
Test:

Created parent and child box.

Applied:

position:absolute;
top:0;
right:0;
Result:

The child moved to the top-right corner of the parent.

Explanation:

Absolute positioning removes the element from normal document flow.

The child position depends on the nearest parent with:

position:relative;

If the parent has no positioning context, the child positions itself according to the webpage.

Part D - Fixed Position Test
Test:

Created Back To Top button.

Applied:

position:fixed;
bottom:20px;
right:20px;
Result:

Button stayed visible while scrolling.

Explanation:

Fixed elements stay attached to the browser window.

Example:

Chat buttons and floating support buttons.

Part E - Sticky Position Test
Test:

Created navigation bar.

Applied:

position:sticky;
top:0;
Result:

Navbar stayed at the top while scrolling.

Explanation:

Sticky works like relative position until the scrolling reaches the set location.

After that it behaves like a fixed element.

Part F - z-index Test
Test:

Created three overlapping boxes:

Red
Blue
Green

CSS:

red z-index:1
blue z-index:2
green z-index:3
Result:

Green appeared above blue and red.

Blue appeared above red.

Explanation:

z-index controls the stacking order of positioned elements.

Higher z-index values appear on top.

Part G - Combined Application Test
Used Position Values:
Position	Used For
Static	Normal content boxes
Relative	Banner movement
Absolute	Product notification badge
Fixed	Support button
Sticky	Navigation bar

28. static

29. absolute and fixed

30. fixed

31. sticky

32. The element written later in HTML appears above.

33. Absolute positioning is used to place an element at an exact position inside a parent container.

34. 
Static: Paragraph text on a webpage.

Relative: Moving a button slightly from its original position.

Absolute: Notification badge on an image.

Fixed: Chat or support button.

Sticky: Navigation bar.


35.

Created a complete webpage using all CSS positioning concepts:
