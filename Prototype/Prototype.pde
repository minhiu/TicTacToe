/**A processing program to TicTacToe.
   Homework Assignment: Prototype
   @author Sean Masterson, Alex Banh, Hieu Pham, and Brandon Walker
   @version 1.0 10/17/2019
  */

import java.util.*;

final int INITIAL_FRAMERATE = 60;

/**
 * Starts up and makes the board for the buttons to appear
 */
void setup() {
  // Make window
  size(600, 600);
  frameRate(INITIAL_FRAMERATE);
  
  // Create 9 buttons
   initializeButtons();
   
   drawBoard();
    
} // End setup() function

/**
 * Draws the board
 */
void draw() {
  background(255);
  for (int i = 0; i < 3; i++) {
    line (i*200, 0, i*200, height);
  }
  for (int i = 0; i < 3; i++) {
    line (0, i*200, width, i*200);
  }
}

// Create 9 buttons:
public void initializeButtons() {
  Button[] allButtons = new Button[9];
 
  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 3; j++) {
      allButtons[i*3 + j] = new Button(200 * i, 200 * j, 200, 200, "b" + i*3 + j);
    }
  }
}

public void drawBoard() {
  
}
