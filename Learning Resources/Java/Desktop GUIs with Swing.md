# Desktop GUIs with Swing (15 Minutes)

Java Swing is a built-in toolkit used to create window-based applications. It provides graphical components (like buttons, text fields, and labels) that allow users to interact with your program.

## 1. The Core Components

*   **JFrame:** The main window of your application.
*   **JPanel:** A container to group and organize other components inside the window.
*   **JButton:** A clickable button.
*   **JLabel:** A display area for a short text string or an image.
*   **JTextField:** A single-line text input field.

## 2. Layout Managers

Instead of manually giving X and Y coordinates for every button (which breaks when a user resizes the window), Java uses Layout Managers to position things automatically.
*   **FlowLayout:** Places components in a row, wrapping to the next line if there's no space.
*   **BorderLayout:** Divides the window into 5 regions (North, South, East, West, Center).
*   **GridLayout:** Arranges components in a grid of rows and columns.

## 3. A Complete, Commented Swing Example

Here is a complete, heavily commented program that creates a small window. When you type your name and click a button, it greets you.

```java
import javax.swing.*;       // Imports all Swing components (JFrame, JButton, etc.)
import java.awt.*;          // Imports layout managers (FlowLayout, etc.)
import java.awt.event.*;    // Imports event handling (ActionListener, etc.)

public class SimpleSwingApp {

    public static void main(String[] args) {
        
        // 1. Create the Main Window (JFrame)
        JFrame frame = new JFrame("My First Swing App");
        
        // Tell the program to exit completely when the window is closed
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        
        // Set the width and height of the window in pixels
        frame.setSize(400, 200); 
        
        // Set a Layout Manager for the frame
        frame.setLayout(new FlowLayout());

        // 2. Create the Components
        // A label giving instructions
        JLabel instructionLabel = new JLabel("Enter your name:");
        
        // A text field for user input (width of 15 columns)
        JTextField nameField = new JTextField(15);
        
        // A clickable button
        JButton clickMeButton = new JButton("Say Hello");
        
        // A label to display the final result (starts empty)
        JLabel resultLabel = new JLabel("");

        // 3. Add Event Handling (Make the button DO something)
        // We add an ActionListener that "listens" for a button click
        clickMeButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                // This code runs ONLY when the button is clicked!
                
                // Get the text the user typed into the text field
                String name = nameField.getText();
                
                // Update the result label with a greeting
                resultLabel.setText("Hello there, " + name + "!");
            }
        });

        // 4. Add Components to the Frame
        // Order matters! They will appear in the order we add them.
        frame.add(instructionLabel);
        frame.add(nameField);
        frame.add(clickMeButton);
        frame.add(resultLabel);

        // 5. Make the Window Visible
        // This should usually be the very last step in setting up your GUI
        frame.setVisible(true);
    }
}
```

## Summary of the Workflow:
1. Create a `JFrame`.
2. Pick a `LayoutManager`.
3. Create your components (`JButton`, `JLabel`, etc.).
4. Write `ActionListeners` to give those components behavior.
5. `add()` the components to the frame.
6. Set the frame to `visible`.
