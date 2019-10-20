/**A processing program to TicTacToe.
   Homework Assignment: Prototype
   @author Sean Masterson, Alex Banh, Hieu Pham, and Brandon Walker
   @version 1.0 10/22/2019
  */

import java.util.*;

final int INITIAL_FRAMERATE = 60;
final int SQUARE_SIZE = 200;

Board board = new Board();

/**
 * Starts up and makes the board for the buttons to appear
 */
void setup() {
  // Make window
  size(600, 600);
  frameRate(INITIAL_FRAMERATE);
} // End setup() function

/**
 * Draws the board
 */
void draw() {
  background(255);
  board.drawBoard();
  
}
