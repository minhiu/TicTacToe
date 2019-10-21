/**The board class which holds all our moves and our TicTacToe AI
   Homework Assignment: Prototype
   @author Sean Masterson, Alex Banh, Hieu Pham, and Brandon Walker
   @version 1.0 10/22/2019
  */
  
public class Board {
  private boolean newGame; // Added for fuction looping
  private boolean playerWin;
  private boolean aiWin;
  private boolean replay;
  private boolean canMove;
  private boolean playerTurn;
  private States[] boardState;
  private Button[] allButtons;
  private Player player;
  
/**
  * Default board constructor
  */
  public Board() {
    this.newGame = false; // Added for function looping
    this.playerWin = false;
    this.aiWin = false;
    this.replay = false;
    this.canMove = true; // Possibly random whether true or false
    this.playerTurn = true; // Possibly random whether true or false
    this.resetBoard();
    this.initializeButtons();
    this.player = new Player(); // Alex used a constructor to declare the player object 10/21/19
    //this.player.assignXO(); // For some reason, this line of code will make the program crash, and can't figure out why. It is supposed to assign the player object either an X or an O. For now, assume the player is always O.
  } // End board constructor
  
  // Resets the boardState to all empty squares (States.EMPTY)
/**
  * Clears board to restart the game
  */
  public void resetBoard() {
    boardState = new States[9];
    for (int i = 0; i < 9; ++i) {
      boardState[i] = States.EMPTY;
    }// End boardState assignment for-loop
  }// End resetBoard() function
  
  // Create 9 buttons with their coordinates
/**
  * Initalizes the buttons to start the game
  */
  private void initializeButtons() {
    this.allButtons = new Button[9];
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        this.allButtons[i * 3 + j] = new Button(SQUARE_SIZE * j, SQUARE_SIZE * i, SQUARE_SIZE, SQUARE_SIZE, "b" + i * 3 + j + 1);
      }// End button initalization for height
    }// End button initalization for width
  }// End initalizeButtons() funciton
  
  // Draws the lines that make up the board's grid
/**
  * Draws the lines on the board to seperate the buttons
  */
  private void drawLines() {
    for (int i = 0; i < 3; i++) {
      line (i * SQUARE_SIZE, 0, i * SQUARE_SIZE, height); // Draws vertical lines
      line (0, i * SQUARE_SIZE, width, i * SQUARE_SIZE);  // Draws horizontal lines
    }// Finish line drawing
  }// End drawLines() function
  
  // Returns index of button that the mouse cursor is currently hovering over
  // To do this, it calls isInside() of each of the 9 buttons with the mouse's current coordinates and return the index of the button whose isInside() function returns true.
  // If the mouse is not hovering over a button (this should not be possible, as the entire board should be covered with buttons), return -1.
/**
  * Checks to see what button the user is hovering over
  */
  public int getUserInput() {
     for (int i = 0; i < 9; i++) {
       if (this.allButtons[i].isInside(mouseX, mouseY))
         return i;
     }// End button check
     return -1; // Return -1 if mouse is not hovering over a button.
  }// End getUserInput() function
  
  // Draws all X's and O's on the board.
/**
  * Draws the X's and O's onto the board
  */
  public void drawShapes() {
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (this.boardState[i * 3 + j] == States.X) { // Draw X's consisting of two diagonal lines
          line(SQUARE_SIZE * j, SQUARE_SIZE * i, SQUARE_SIZE * (j + 1), SQUARE_SIZE * (i + 1));
          line(SQUARE_SIZE * j, SQUARE_SIZE * (i + 1), SQUARE_SIZE * (j + 1), SQUARE_SIZE * i);
        }// End draw X
        else if (this.boardState[i * 3 + j] == States.O) { // Draw O's consisting of a circle
          circle(SQUARE_SIZE * j + (SQUARE_SIZE * 0.5), SQUARE_SIZE * i + (SQUARE_SIZE * 0.5), SQUARE_SIZE);
        }// End draw O     
      }// End height choice collum
    }// End width choie row 
  }// End drawShapes() function
  
  // Remove this function in final version of project.
  // This function displays the board in the console.
  // Ideally, call this function at the end of mousePressed() in Prototype.pde.
  // Do not call from drawBoard() or draw() or else it'll spam the console.
  public void drawBoardDEBUG() {
    for (int i = 0; i < 9; i++) {
        if (this.boardState[i] == States.EMPTY)
          print ("_ ");
        else if (this.boardState[i] == States.X)
          print ("X ");
        else
          print ("O ");
        if (((i + 1) % 3) == 0)
          print ("\n");
    }
  }
  
  // The AI makes a turn in a random empty square
/**
  * Fills the correct button for the AI's choice with the opposite state as the player
  */
  public void aiTurn() {
    int count = 0; // Number of empty squares found
    int[] possibleStates = new int[9]; // Holds all indicies of empty squares found
    for (int i = 0; i < 9; i++) {
      if (boardState[i] == States.EMPTY) {
        possibleStates[count] = i;
        ++count;
      }// Finish adding up all remaining open board states
    }// Checks board states left
    int randomButton = possibleStates[(int) random(count)]; // Randomly picks an index in possibleStates[] from 0 to (count - 1) inclusive.
    if (count == 0)
      print("No more moves possible.\n");
    else {
      boardState[randomButton] = States.X;
      print("AI made a move on square " + (randomButton + 1) + "\n");
    }// Places AI's move on board
  }// End aiTurn() function
  
  // Calls functions to draw the lines (the grid) and shapes (X's and O's) of the board.
/**
  * Draws the board with the lines and shapes
  */
  public void drawBoard() {
    this.drawLines();
    this.drawShapes();
  }// End drawBoard() function
  
  // Checks if the button specified by buttonIndex is empty
/**
  * Checks if the button spot is empty
  */
  private boolean validInput(int buttonIndex) {
    return (boardState[buttonIndex] == States.EMPTY);
  }// End validInput() function
  
  // Checks if a player won
  // If X won, return States.X
  // If O won, return States.O
  // If neither won, return States.EMPTY
  // Consider modifying this to use the member variables 
/**
  *Checks if either X won, O won or if it's a tie
  */
  private States returnWinner() {
    for (int i = 0; i < 3; ++i) {
      // Check for matching rows
      // 0 1 2
      // 3 4 5
      // 6 7 8
      if (this.boardState[i * 3] != States.EMPTY && this.boardState[i * 3 + 1] != States.EMPTY && this.boardState[i * 3 + 2] != States.EMPTY) {
        if ((this.boardState[i * 3] == this.boardState[i * 3 + 1]) && (this.boardState[i * 3 + 1] == this.boardState[i * 3 + 2])) {
          return this.boardState[i * 3];
        }// Moves down from top
      }// Finish checking matching rows
      // Checking for matching columns
      // 0 3 6
      // 1 4 7
      // 2 5 8
      if (this.boardState[i] != States.EMPTY && this.boardState[i + 3] != States.EMPTY && this.boardState[i + 6] != States.EMPTY) {
        if ((this.boardState[i] == this.boardState[i + 3]) && (this.boardState[i + 3] == this.boardState[i + 6])) {
          return this.boardState[i];
        }// Moves right from top
      }// Finish checking matching collums
    }
    // Checking for matching diagonial top left to bottom right
    // 0 4 8
    if ((this.boardState[0] != States.EMPTY && this.boardState[4] != States.EMPTY && this.boardState[8] != States.EMPTY) && 
       ((this.boardState[0] == this.boardState[4]) && (this.boardState[4] == this.boardState[8])))
       return this.boardState[0];
    // Checking for matching diagonal top right to bottom left
    // 2 4 6
    if ((this.boardState[2] != States.EMPTY && this.boardState[4] != States.EMPTY && this.boardState[6] != States.EMPTY) && 
       (((this.boardState[2] == this.boardState[4]) && (this.boardState[4] == this.boardState[6]))))
       return this.boardState[2];
    return States.EMPTY;
  }// Finish returnWinner() function
  
  // Returns if the game is over and displays who won if the game is over.
  // Consider modifying this to use the member variables
/**
  * Checks if either X won, O won, or if it's a tie
  // The game auto resets on a victory but doesn't show the winning board state (need to fix this)
  */
  public boolean checkGameOver() {
    if (this.returnWinner() != States.EMPTY) {
      print("Game is over.\n");
      if (this.returnWinner() == States.X)  {
         print("X won.\n");
      }// X gets the win
      else  {
         print("O won.\n");
      }// O gets the win
      print("Do you want to play again? (Click any square to restart)\n");
      if(this.validInput(getUserInput()) || !this.validInput(getUserInput())) {
        newGame = true;  // New game so AI doesn't automatically go first
        resetBoard();
        return false;
      }
      else {
        return true;
      }
    }// Finish win checking
    return false;
  }// End checkGameOver() function
  
  // Lets the player make a turn if the game isn't over. After the play makes a turn, let the AI make a turn if the game still isn't over.
  // Consider modifying this to use the member variables
/**
  * Lets player and AI make a turn if the game has not yet finished
  */
  public void makeTurn(int buttonIndex) {
    if (!this.checkGameOver()) {
      if (this.validInput(buttonIndex)) {
         this.boardState[buttonIndex] = States.O; //player.getXO() - Strangely, player.getXO() returns null even though the constructor of Player assigns this.xo a value. For now, make the player always be O.
         if (!this.checkGameOver() && newGame == false) { // Edited for looping
           this.aiTurn();
           this.checkGameOver();
         }// End loop for AI move check and allows the move
          newGame = false; // Stop after the player makes the first move to allow AI to go
      }// End loop for player move check and allows the move
      else
        print("Invalid move.\n");
    }// End game over check and let's user know thier move is invalid
  }// End makeTurn() function
}// End Board class
