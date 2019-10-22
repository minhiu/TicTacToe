/**The board class which holds all our moves and our TicTacToe AI
   Homework Assignment: Prototype
   @author Sean Masterson, Alex Banh, Hieu Pham, and Brandon Walker
   @version 1.0 10/22/2019
  */
  
public class Board {
  /**
   Stores whether the board has reached a game over state.
  */
  private boolean gameover;
  /**
   The squares on the board.
  */
  private States[] boardState;
  /**
   The buttons on the board.
  */
  private Button[] allButtons;
  /**
   The human player.
  */
  private Player player;
  
  /**
  * Default Board constructor.
  * Sets all member variables.
  */
  public Board() {
    this.gameover = false;
    this.resetBoard();
    this.initializeButtons();
    this.player = new Player(); // Create new player
    this.player.assignXO(); // Assign a random sign for player
    if (this.player.getXO() == States.O) { // If the player is not X, make the AI go first.
        this.aiTurn();
    } // End if
  } // End board constructor
  
  /**
  * Clears board to start or restart the game.
  * Resets the boardState to all empty squares (States.EMPTY).
  */
  private void resetBoard() {
    print("New game started.\n");
    boardState = new States[9];
    for (int i = 0; i < 9; ++i) {
      boardState[i] = States.EMPTY;
    }// End boardState assignment for-loop
  }// End resetBoard() function
  
  /**
  * Initalizes 9 buttons for the game to use to get user input.
  */
  private void initializeButtons() {
    this.allButtons = new Button[9];
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        this.allButtons[i * 3 + j] = new Button(SQUARE_SIZE * j, SQUARE_SIZE * i, SQUARE_SIZE, SQUARE_SIZE, "b" + i * 3 + j + 1);
      }// End button initalization for height
    }// End button initalization for width
  }// End initalizeButtons() funciton
  
  /**
  * Draws the lines that make up the board's grid which seperate the buttons.
  */
  private void drawLines() {
    for (int i = 0; i < 3; i++) {
      line (i * SQUARE_SIZE, 0, i * SQUARE_SIZE, height); // Draws vertical lines
      line (0, i * SQUARE_SIZE, width, i * SQUARE_SIZE);  // Draws horizontal lines
    }// Finish line drawing
  }// End drawLines() function
  
  /**
  * Returns index of button that the mouse cursor is currently hovering over.
  * To do this, it calls isInside() of each of the 9 buttons with the mouse's current coordinates and return the index of the button whose isInside() function returns true.
  * If the mouse is not hovering over a button (this should not be possible, as the entire board should be covered with buttons), return -1.
  * @return The index of the button that the mouse is hovering over, or -1 if none.
  */
  public int getUserInput() {
     for (int i = 0; i < 9; i++) {
       if (this.allButtons[i].isInside(mouseX, mouseY))
         return i;
     }// End button check
     return -1; // Return -1 if mouse is not hovering over a button.
  }// End getUserInput() function
  
  /**
  * Draws the X's and O's onto the board
  */
  private void drawShapes() {
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
  
  /**
  * The AI makes a turn in a random empty square.
  * Fills the correct button for the AI's choice with the opposite state as the player.
  */
  private void aiTurn() {
    int count = 0; // Number of empty squares found
    int[] possibleStates = new int[9]; // Holds all indicies of empty squares found
    for (int i = 0; i < 9; i++) {
      if (boardState[i] == States.EMPTY) {
        possibleStates[count] = i;
        ++count;
      }// Finish adding up all remaining open board states
    }// Checks board states left
    int randomButton = possibleStates[(int) random(count)]; // Randomly picks an index in possibleStates[] from 0 to (count - 1) inclusive.
    States aiTurn; // Assigning AI Opposite sign with player
    if (player.getXO() == States.X)
      aiTurn = States.O;
    else
      aiTurn = States.X;
    if (count == 0) {
      print("No more moves possible.\n");
    }
    else {
      boardState[randomButton] = aiTurn;
      print("AI made a move on square " + (randomButton + 1) + "\n");
    }// Places AI's move on board
  }// End aiTurn() function
  
  /**
  * Draws the board with the lines and shapes
  * It calls functions to draw the lines (the grid) and shapes (X's and O's) of the board.
  */
  public void drawBoard() {
    this.drawLines();
    this.drawShapes();
  }// End drawBoard() function
  
  /**
  * Checks if the button specified by buttonIndexis empty.
  * @param buttonIndex The index of a button that corresponds to a space on the board.
  * @return Whether the spot on the board at index buttonIndex is empty or not.
  */
  private boolean validInput(int buttonIndex) {
    return (boardState[buttonIndex] == States.EMPTY);
  }// End validInput() function
  
  /**
  * Checks if either X won, O won, or if it's a tie.
  * If X won, return States.X
  * If O won, return States.O
  * If neither won, return States.EMPTY
  * @return The state of the player that won, or States.EMPTY if neither won.
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
  }// End returnWinner() function
  
  /**
  * Checks if either X won, O won, or if it's a tie and displays who won if the game is over.
  * @return Whether the game is over.
  */
  private boolean checkGameOver() {
    if (this.returnWinner() != States.EMPTY) {
      this.gameover = true;
      print("Game is over.\n");
      if (this.returnWinner() == States.X) {
         print("X won.\n");
      } // End if
      else {
         print("O won.\n");
      } // End else
      print("It took " + this.countTurns(this.returnWinner()) + " turns to win.\n");
      if (this.returnWinner() == player.getXO()) { // Check if the winner is the player
        print("You win. You are a master at tic-tac-toe.\n"); // "compliment their mastery of tic-tac-toe"
      } // End if
      else {
        print("You lose. Have you never played before?\n"); // "display a snarky remark about the user’s ability"
      } // End else
      print("Press any square to start another game, or you can exit.\n");
      return true;
    }// Finish win checking
    else {
      // Check if game ends in a tie.
      if (this.isTie()) {
        print("It's a tie.\n");
        print("Press any square to start another game, or you can exit.\n");
        this.gameover = true;
      } // End if
    } // End else
    return false;
  }// End checkGameOver() function
  
  /**
  * Returns whether the game has ended in a tie.
  * @return Whether the game has ended in a tie.
  */
  private boolean isTie() {
    boolean isTie = true;
    for (int i = 0; i < 9; ++i) {
      if (this.boardState[i] == States.EMPTY) {
        isTie = false;
      } // End if
    } // End for
    return isTie;
  } // End isTie() function
  
  /**
  * Counts number of squares on the board that have the state stateToCount.
  * @param stateToCount The type of square state that will be totaled up.
  * @return The number of times stateToCount was found on the board.
  */
  private int countTurns(States stateToCount) {
    int noTurns = 0;
    for (int i = 0; i < 9; ++i) {
      if (this.boardState[i] == stateToCount) {
        ++noTurns;
      } // End if statement
    } // End for statement
    return noTurns;
  } // End countTurns() function
  
  /**
  * Lets player and AI make a turn if the game has not yet finished
  * @param buttonIndex The index of the button that the player will attempt to make a move on.
  */
  public void makeTurn(int buttonIndex) {
    if (this.gameover) {
      this.gameover = false;
      this.resetBoard();
      this.player.assignXO(); // Assign a random sign for player
      if (this.player.getXO() == States.O) { // If the player is not X, make the AI go first.
        this.aiTurn();
      }
    }
    else {
      if (!this.checkGameOver()) {
        if (this.validInput(buttonIndex)) {
           this.boardState[buttonIndex] = player.getXO();
           if (!this.checkGameOver()) {
             this.aiTurn();
             this.checkGameOver();
           }// End loop for AI move check and allows the move
        }// End loop for player move check and allows the move
        else
          print("Invalid move.\n");
      }// End game over check and let's user know thier move is invalid
    }
  }// End makeTurn() function
  
  
  /**
   * Gets gameover state.
   * @return Whether we are in a gameover state.
   */
  public boolean getGameover() {
    return this.gameover;
  } // End getGameover() function
  
  /**
   * Gets Board's state as a String.
   * @return Board's state as a String.
   */
  public String getBoardStateString()  {
    String output = "";
    for (int i = 0; i < 9; i++) {
        if (this.boardState[i] == States.EMPTY)
          output += "_ ";
        else if (this.boardState[i] == States.X)
          output += "X ";
        else
          output += "O ";
        if (((i + 1) % 3) == 0)
          output += "\n";
    }
    return output;
  } // End getBoardStateString() function
  
  /**
   * Gets all of the button's outputs of their toString() methods and combines them.
   * @return All of the button's outputs of their toString() methods and combines them.
   */
  public String getButtonText() {
    String output = "";
    for (int i = 0; i < 9; ++i) {
      output += this.allButtons[i].toString();
    }
    return output;
  } // End getButtonText() function
  
  /**
   * Gets player.
   * @return player.
   */
  public Player getPlayer() {
    return this.player;
  } // End getPlayer() function
  
  /**
  * Returns String with info about the Board.
  * @return String with info about the Board.
  */
  public String toString() {
    return ("Gameover=" + (this.getGameover() ? "true" : "false") + " Board state="  + this.getBoardStateString() + " Buttons:" + this.getButtonText() + " PlayerXO=" + ((this.getPlayer().getXO() == States.X) ? "X" : "O") + "\n");
  } // End toString() function
 
  /**
  * Checks whether two boards are equal.
  * @return whether two board are equal.
  */
  public boolean equals(Board otherBoard) {
    return (this.getGameover() == otherBoard.getGameover() && this.getBoardStateString() == otherBoard.getBoardStateString() && this.getButtonText() == otherBoard.getButtonText() && this.getPlayer() == otherBoard.getPlayer());
  } // End equals(...) function
}// End Board class
