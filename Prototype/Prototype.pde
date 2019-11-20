 /**A processing program to TicTacToe.
   Homework Assignment: TicTacToe Prototype
   @author Sean Masterson, Alex Banh, Hieu Pham, and Brandon Walker
   @version 2.0 11/18/2019
  */

//import java.util.*;

final String TITLE = "Tic Tac Toe"; //Game title
final int FRAMERATE = 60;
final int SQUARE_SIZE = 100; // Size of the buttons and squares
final int AI_PLAY_STYLE = 2; // 0 = dumb (random), 1 = smart, 2 = smart and unpredictable
final boolean DEBUG = false;

Board board = new Board();

/**
 * Starts up and makes the window in which the board will appear in
 */
void setup() {
  // Make window
  size(500, 500);
  frameRate(FRAMERATE);
} // End setup() function

/**
 * Draws the board, including the grid and all shapes
 */
void draw() {
  background(255);
  board.drawBoard();
  board.detectHovering();
  textSize(40);
  fill(0, 102, 153);
  text(TITLE, 150, 50);
  board.displayMessage();
  fill(255, 255, 255);
}// End draw() function

/**
  * Checks to see if the player pressed a button
  */
void mousePressed() {
  int buttonPressed = board.getUserInput(); // Get index of button that the player pressed based on the location of the mouse.
  print("You pressed button " + (buttonPressed + 1) + "\n"); // Display index of button that was pressed. plus 1. Buttons are indexed 0 through 8, but are displayed as 1 through 9.
  board.makeTurn(buttonPressed); // Attempt to make a turn at the index of the button that was pressed.
} // End mousePressed() function
