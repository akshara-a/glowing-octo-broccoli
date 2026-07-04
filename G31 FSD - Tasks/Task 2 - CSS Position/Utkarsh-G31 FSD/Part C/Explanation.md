# Explanation

When the parent had position as relative or absolute, the child is inside the parent and was at its top-right corner.
After removing position from the parent, the child moved to the top-right corner of the webpage.

An absolute element looks for the nearest parent with a position property like `relative`. If no such parent is found, it uses the browser window as its reference. Hence, the child box moved to the top-right corner of the webpage.