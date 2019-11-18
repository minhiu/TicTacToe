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
   The buttons on the board.
  */
  private Button[] allButtons;
  /**
   The human player.
  */
  private Player player;
  
  private int buttonHovered;
  private boolean isPlayerTurn;
  
  /**
  * Default Board constructor.
  * Sets all member variables.
  */
  public Board() {
    this.gameover = false;
    //sthis.resetBoard();
    this.resetButtons();
    this.player = new Player(); // Create new player
    this.player.assignXO(); // Assign a random sign for player
    if (this.player.getXO() == States.O) { // If the player is not X, make the AI go first.
      this.aiTurn();
      this.isPlayerTurn = DEBUG ? false : true;
      print("You are O and the AI is X.\n");
    } // End if
    else {
      this.isPlayerTurn = true;
      print("You are X and the AI is O.\n");
    }
    print("X goes first.\n");
    this.buttonHovered = -2;
  } // End board constructor
  
  /**
  * Clears board to start or restart the game.
  * Resets allButtons to all empty squares (States.EMPTY).
  */
  private void resetButtons() {
    this.allButtons = new Button[9];
    for (int i = 1; i < 4; i++) {
      for (int j = 1; j < 4; j++) {
        this.allButtons[(i - 1) * 3 + (j - 1)] = new Button(SQUARE_SIZE * j, SQUARE_SIZE * i, SQUARE_SIZE, SQUARE_SIZE, "b" + i * 3 + j + 1, States.EMPTY);
        this.allButtons[(i - 1) * 3 + (j - 1)].setState(States.EMPTY);
      }// End button initalization for height
    }// End button initalization for width
  }// End initalizeButtons() funciton
  
  /**
  * Initalizes 9 buttons for the game to use to get user input.
  */
  /*
  private void initializeButtons() {
    this.allButtons = new Button[9];
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        this.allButtons[i * 3 + j] = new Button(SQUARE_SIZE * j, SQUARE_SIZE * i, SQUARE_SIZE, SQUARE_SIZE, "b" + i * 3 + j + 1, States.EMPTY);
        this.allButtons[i * 3 + j].setState(States.EMPTY);
      }// End button initalization for height
    }// End button initalization for width
  }// End initalizeButtons() funciton
  */
  
  /**
  * Draws the lines that make up the board's grid which seperate the buttons.
  */
  private void drawLines() {
    for (int i = 1; i < 5; i++) {
      line (i * SQUARE_SIZE, SQUARE_SIZE, i * SQUARE_SIZE, SQUARE_SIZE * 4); // Draws vertical lines
      line (SQUARE_SIZE, i * SQUARE_SIZE, SQUARE_SIZE * 4, i * SQUARE_SIZE);  // Draws horizontal lines
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
        this.allButtons[3 * i + j].drawShape();  
      }// End height choice collum
    }// End width choie row 
  }// End drawShapes() function
  
  private void aiTurn() {
    if (DEBUG) {
      this.isPlayerTurn = !this.isPlayerTurn;
    }
    else {
      if (AI_PLAY_STYLE == 1) {
        aiTurnSmart();
      }
      else if (AI_PLAY_STYLE == 2) {
        aiTurnSmartAndUnpredictable();
      }
      else {
        aiTurnRandom();
      }
    }
  }
  
  /**
  * The AI makes a turn in a random empty square.
  * Fills the correct button for the AI's choice with the opposite state as the player.
  */
  
  private void aiTurnRandom() {
    int count = 0; // Number of empty squares found
    int[] possibleStates = new int[9]; // Holds all indicies of empty squares found
    for (int i = 0; i < 9; i++) {
      if (this.allButtons[i].getState() == States.EMPTY) {
        possibleStates[count] = i;
        ++count;
      }// Finish adding up all remaining open board states
    }// Checks board states left
    if (count == 0) {
      print("No more moves possible.\n");
    }
    else {
      int randomButton = possibleStates[(int) random(count)]; // Randomly picks an index in possibleStates[] from 0 to (count - 1) inclusive.
      States aiTurn; // Assigning AI Opposite sign with player
      if (player.getXO() == States.X)
        aiTurn = States.O;
      else
        aiTurn = States.X;
      this.allButtons[randomButton].setState(aiTurn);
      print("AI made a move on square " + (randomButton + 1) + "\n");
    }// Places AI's move on board
  }// End aiTurn() function
  
 /**
  * The AI makes a turn in a empty square that is most optimal.
  * Fills the correct button for the AI's choice with the opposite state as the player.
  */
  private void aiTurnSmart() {
    int bestScore = -1;
    int bestIndex = -1;
    States aiTurn = ((player.getXO() == States.X) ? States.O : States.X);
    for (int i = 0; i < 9; ++i) {
      if (this.allButtons[i].getState() == States.EMPTY) {
        this.allButtons[i].setState(aiTurn);
        int score = this.aiTurnMinimax(this.allButtons, aiTurn, false);
        //print("Square " + (i + 1) + " score: " + score + "\n");
        this.allButtons[i].setState(States.EMPTY);
        if (score > bestScore) {
          bestScore = score;
          bestIndex = i;
        }
      }
    }
    if (bestIndex != -1) {
      this.allButtons[bestIndex].setState(aiTurn);
      print("AI made a move on square " + (bestIndex + 1) + "\n");
    }
    else {
      print("No more moves possible.\n");
    }
  }
  
  /**
  * The AI makes a turn in a empty square that is most optimal.
  * Fills the correct button for the AI's choice with the opposite state as the player.
  */
  private void aiTurnSmartAndUnpredictable() {
    int bestScore = -1;
    int bestIndex = -1;
    States aiTurn = ((player.getXO() == States.X) ? States.O : States.X);
    int buttonIndiciesByScore[][] = new int[3][9]; // Store button index by score.
    int noButtonScores[] = {0, 0, 0}; // Number of indicies stored by that a certain score.
    for (int i = 0; i < 9; ++i) {
      if (this.allButtons[i].getState() == States.EMPTY) {
        this.allButtons[i].setState(aiTurn);
        int score = this.aiTurnMinimax(this.allButtons, aiTurn, false);
        buttonIndiciesByScore[score + 1][noButtonScores[score + 1]] = i; // Store button index by score.
        ++noButtonScores[score + 1]; // Increase number of indicies stored by that score.
        //print("Square " + (i + 1) + " score: " + score + "\n");
        this.allButtons[i].setState(States.EMPTY);
        if (score > bestScore) {
          bestIndex = i;
        }
      }
    }
    if (bestIndex != -1) {
      int randomButton;
      if (noButtonScores[2] > 0) { // Win
        randomButton = buttonIndiciesByScore[2][(int) random(noButtonScores[2])]; // Randomly picks an index in possibleStates[] from 0 to (count - 1) inclusive.
      }
      else if (noButtonScores[1] > 0) { // Tie
        randomButton = buttonIndiciesByScore[1][(int) random(noButtonScores[1])]; // Randomly picks an index in possibleStates[] from 0 to (count - 1) inclusive.
      }
      else { // Lose
        randomButton = buttonIndiciesByScore[0][(int) random(noButtonScores[0])]; // Randomly picks an index in possibleStates[] from 0 to (count - 1) inclusive.
      }
      this.allButtons[randomButton].setState(aiTurn);
      print("AI made a move on square " + (randomButton + 1) + "\n");
    }
    else {
      print("No more moves possible.\n");
    }
  }
  
 /**
  * Uses Minimax algorithm to determine optimal space to use.
  * @return 1 if the current board space will result in a win, 0 if it will result in a tie, -1 if it will result in a loss.
  */
  private int aiTurnMinimax(Button[] newButtons, States playerWeWantToWin, boolean isMax) {
    States otherPlayer = ((playerWeWantToWin == States.X) ? States.O : States.X);
    if (this.returnWinner(newButtons) == playerWeWantToWin) {
      return 1;
    }
    else if (this.returnWinner(newButtons) == otherPlayer) {
      return -1;
    }
    else if (this.isTie(newButtons)) {
      return 0;
    }
    int best = -2 * (isMax ? 1 : -1);
    States currentMove = (isMax ? playerWeWantToWin : otherPlayer);
    int score = 0;
    for (int i = 0; i < 9; ++i) {
      if (newButtons[i].getState() == States.EMPTY) {
        this.allButtons[i].setState(currentMove);
        score = this.aiTurnMinimax(this.allButtons, playerWeWantToWin, !isMax);
        if (isMax) {
          best = max(best, score);
        }
        else {
          best = min(best, score);
        }
        this.allButtons[i].setState(States.EMPTY);
      }
    }
    return best;
  }
  
  /**
  * Display (if possible) an open square that would help the player win the game
  * @return the index of the open square if found, otherwise, return -1
  */
  private int findWinningSquare() {
    // Check the whole board to see if the player have 2 square and one blank space within the same row/column/diagonal
    for (int i = 0; i < 3; i++) {
      // Check matching for all rows
     if (this.allButtons[i * 3].getState() == this.player.getXO() && this.allButtons[i * 3 + 1].getState() == this.player.getXO() && this.allButtons[i * 3 + 2].getState() == States.EMPTY)
        return (i * 3 + 2);
      else if (this.allButtons[i * 3].getState() == this.player.getXO() && this.allButtons[i * 3 + 1].getState() == States.EMPTY && this.allButtons[i * 3 + 2].getState() == this.player.getXO())
        return (i * 3 + 1);
      else if (this.allButtons[i * 3].getState() == States.EMPTY && this.allButtons[i * 3 + 1].getState() == this.player.getXO() && this.allButtons[i * 3 + 2].getState() == this.player.getXO())
        return (i * 3);  
      
    // Check matching for all columns
      if (this.allButtons[i].getState() == this.player.getXO() && this.allButtons[i + 3].getState() == this.player.getXO() && this.allButtons[i + 6].getState() == States.EMPTY)
        return (i + 6);
      else if (this.allButtons[i].getState() == this.player.getXO() && this.allButtons[i + 3].getState() == States.EMPTY && this.allButtons[i + 6].getState() == this.player.getXO())
        return (i + 3);
      else if (this.allButtons[i].getState() == States.EMPTY && this.allButtons[i + 3].getState() == this.player.getXO() && this.allButtons[i + 6].getState() == this.player.getXO())
        return (i);
    } // End for loop
    
    // Check for matching diagonal from top left to bot right
    if (this.allButtons[0].getState() == this.player.getXO() && this.allButtons[4].getState() == this.player.getXO() && this.allButtons[8].getState() == States.EMPTY)
      return 8;
    else if (this.allButtons[0].getState() == this.player.getXO() && this.allButtons[4].getState() == States.EMPTY && this.allButtons[8].getState() == this.player.getXO())
      return 4;
    else if (this.allButtons[0].getState() == States.EMPTY && this.allButtons[4].getState() == this.player.getXO() && this.allButtons[8].getState() == this.player.getXO())
      return 0;
    
    // Check for matching diagonal from top right to bot left
    if (this.allButtons[2].getState() == this.player.getXO() && this.allButtons[4].getState() == this.player.getXO() && this.allButtons[6].getState() == States.EMPTY)
      return 6;
    else if (this.allButtons[2].getState() == this.player.getXO() && this.allButtons[4].getState() == States.EMPTY && this.allButtons[6].getState() == this.player.getXO())
      return 4;
    else if (this.allButtons[2].getState() == States.EMPTY && this.allButtons[4].getState() == this.player.getXO() && this.allButtons[6].getState() == this.player.getXO())
      return 2;
    
    return -1;
  } // End function findWinningSquare()
  
  /**
  * Display (if possible) an open square that would help the player block the winning of the bot
  * @return the index of the open square if found, otherwise, return -1
  */
  private int findBlockingSquare() {
    States otherPlayerState = ((this.player.getXO() == States.X) ? States.O : States.X);
    // Check the whole board to see if the bot have 2 square and one blank space within the same row/column/diagonal
    for (int i = 0; i < 3; i++) {
    // Check matching for all rows
      if (this.allButtons[i * 3].getState() == otherPlayerState && this.allButtons[i * 3 + 1].getState() == otherPlayerState && this.allButtons[i * 3 + 2].getState() == States.EMPTY)
        return (i * 3 + 2);
      else if (this.allButtons[i * 3].getState() == otherPlayerState && this.allButtons[i * 3 + 1].getState() == States.EMPTY && this.allButtons[i * 3 + 2].getState() == otherPlayerState)
        return (i * 3 + 1);
      else if (this.allButtons[i * 3].getState() == States.EMPTY && this.allButtons[i * 3 + 1].getState() == otherPlayerState && this.allButtons[i * 3 + 2].getState() == otherPlayerState)
        return (i * 3);  
  
    // Check matching for all columns
      if (this.allButtons[i].getState() == otherPlayerState && this.allButtons[i + 3].getState() == otherPlayerState && this.allButtons[i + 6].getState() == States.EMPTY)
        return (i + 6);
      else if (this.allButtons[i].getState() == otherPlayerState && this.allButtons[i + 3].getState() == States.EMPTY && this.allButtons[i + 6].getState() == otherPlayerState)
        return (i + 3);
      else if (this.allButtons[i].getState() == States.EMPTY && this.allButtons[i + 3].getState() == otherPlayerState && this.allButtons[i + 6].getState() == otherPlayerState)
        return (i);
    } // End for loop
    
    // Check for matching diagonal from top left to bot right
    if (this.allButtons[0].getState() == otherPlayerState && this.allButtons[4].getState() == otherPlayerState && this.allButtons[8].getState() == States.EMPTY)
      return 8;
    else if (this.allButtons[0].getState() == otherPlayerState && this.allButtons[4].getState() == States.EMPTY && this.allButtons[8].getState() == otherPlayerState)
      return 4;
    else if (this.allButtons[0].getState() == States.EMPTY && this.allButtons[4].getState() == otherPlayerState && this.allButtons[8].getState() == otherPlayerState)
      return 0;
    
    // Check for matching diagonal from top right to bot left
    if (this.allButtons[2].getState() == otherPlayerState && this.allButtons[4].getState() == otherPlayerState && this.allButtons[6].getState() == States.EMPTY)
      return 6;
    else if (this.allButtons[2].getState() == otherPlayerState && this.allButtons[4].getState() == States.EMPTY&& this.allButtons[6].getState() == otherPlayerState)
      return 4;
    else if (this.allButtons[2].getState() == States.EMPTY && this.allButtons[4].getState() == otherPlayerState && this.allButtons[6].getState() == otherPlayerState)
      return 2;
    
    return -1;
  } // End function findBlockingSquare()
  
  /**
  * Display a message if the mouse hovers over EMPTY squares that are not the blocking square
  */
  public void displayBlockingSquare() {
    if (this.findBlockingSquare() != -1) {
      if (this.validInput(this.getUserInput())) {
        if (this.getUserInput() != buttonHovered && this.getUserInput() != this.findBlockingSquare()) {
            buttonHovered = getUserInput();            
            print("The bot is about to win if you don't play at square position: " + this.findBlockingSquare() + "\n"); 
        } // Stop printing if the mouse stays at the same square
      } // Stop if the mouse doesn't hover over any squares
    } // Stop if there's no blocking squares
  } // End of displayBlockingSquare()
 
 /**
  * Find a spot that the user will need to place to stop a fork
  * @return Move to make to block fork
  */
 public int forkBlockDetector(){
     //Find AI state
     States otherPlayerState = ((this.player.getXO() == States.X) ? States.O : States.X);
     
         //Triangle tactic
         if(this.allButtons[4].getState() == otherPlayerState)
         {
           if(this.allButtons[8].getState() == otherPlayerState && this.allButtons[5].getState() == States.EMPTY && this.allButtons[6].getState() == States.EMPTY)
           {
             return 2;
           }// Bottom right check
           else if(this.allButtons[2].getState() == otherPlayerState && this.allButtons[1].getState() == States.EMPTY && this.allButtons[8].getState() == States.EMPTY)
           {
             return 0;
           }// Top right check
           else if(this.allButtons[6].getState() == otherPlayerState && this.allButtons[0].getState() == States.EMPTY && this.allButtons[7].getState() == States.EMPTY)
           {
             return 8;
           }// Bottom left check
           else if(this.allButtons[0].getState() == otherPlayerState && this.allButtons[2].getState() == States.EMPTY && this.allButtons[3].getState() == States.EMPTY)
           {
             return 6;
           }// Top left check
         }//DONE TRIANGLE TACTICS
           
         //Arrowhead tactic
         if(this.allButtons[7].getState() == otherPlayerState)
         {
           if(this.allButtons[5].getState() == otherPlayerState && this.allButtons[2].getState() == States.EMPTY && this.allButtons[6].getState() == States.EMPTY)
           {
             return 8;
           }// Right check
           else if(this.allButtons[3].getState() == otherPlayerState && this.allButtons[0].getState() == States.EMPTY && this.allButtons[8].getState() == States.EMPTY)
           {
             return 6;
           }// Left check
         }// Bottom arrow 1/4
         else if(this.allButtons[1].getState() == otherPlayerState)
         {
           if(this.allButtons[5].getState() == otherPlayerState && this.allButtons[0].getState() == States.EMPTY && this.allButtons[8].getState() == States.EMPTY)
           {
             return 2;
           }// Left check
           else if(this.allButtons[3].getState() == otherPlayerState && this.allButtons[2].getState() == States.EMPTY && this.allButtons[6].getState() == States.EMPTY)
           {
             return 0;
           }// Left check
         }// Top arrow 2/4
         else if(this.allButtons[3].getState() == otherPlayerState)
         {
           if(this.allButtons[1].getState() == otherPlayerState && this.allButtons[2].getState() == States.EMPTY && this.allButtons[6].getState() == States.EMPTY)
           {
             return 0;
           }// Top check
           else if(this.allButtons[7].getState() == otherPlayerState && this.allButtons[0].getState() == States.EMPTY && this.allButtons[8].getState() == States.EMPTY)
           {
             return 6;
           }// Bottom check
         }// Right arrow arrow 3/4
         else if(this.allButtons[5].getState() == otherPlayerState)
         {
           if(this.allButtons[1].getState() == otherPlayerState && this.allButtons[0].getState() == States.EMPTY && this.allButtons[8].getState() == States.EMPTY)
           {
             return 2;
           }// Top check
           else if(this.allButtons[7].getState() == otherPlayerState && this.allButtons[2].getState() == States.EMPTY && this.allButtons[6].getState() == States.EMPTY)
           {
             return 8;
           }// Bottom check
         }// Left arrow 4/4 DONE ARROWHEADS
         
         // Encirclement Tactic
         if (this.allButtons[0].getState() == otherPlayerState && this.allButtons[8].getState() == otherPlayerState)
         {
             if(this.allButtons[4].getState() == player.getXO() && this.allButtons[6].getState() == player.getXO()&& this.allButtons[1].getState() == States.EMPTY && this.allButtons[5].getState() == States.EMPTY)
             {
               return 2;
             }//Top right circle
             else if(this.allButtons[4].getState() == player.getXO() && this.allButtons[2].getState() == player.getXO()&& this.allButtons[3].getState() == States.EMPTY && this.allButtons[7].getState() == States.EMPTY)
             {
               return 6;
             }//Top left circle
         }// "\" Entanglement done 1/2
         else if (this.allButtons[2].getState() == otherPlayerState && this.allButtons[6].getState() == otherPlayerState)
         {
           if(this.allButtons[4].getState() == player.getXO() && this.allButtons[8].getState() == player.getXO()&& this.allButtons[1].getState() == States.EMPTY && this.allButtons[3].getState() == States.EMPTY)
             {
               return 0;
             }//Top left circle
             else if(this.allButtons[4].getState() == player.getXO() && this.allButtons[0].getState() == player.getXO()&& this.allButtons[5].getState() == States.EMPTY && this.allButtons[7].getState() == States.EMPTY)
             {
               return 8;
             }//Top right circle
         }// "/" Entanglement done 2/2
         
     
       // No fork detected
       return -1;
      }// End fork block detector
    /**
      * Display a message telling the user where to go to block the fork
      */
    public void displayForkBlock() {
    if (this.forkBlockDetector() != -1) {
      if (this.validInput(this.getUserInput())) {
        if (this.getUserInput() != buttonHovered && this.getUserInput() != this.findBlockingSquare()) {
            buttonHovered = getUserInput();            
            print("The AI will make a fork if you don't go : " + (this.forkBlockDetector() + 1) + "\n"); 
        } // Stop printing if the mouse stays hovered
      } // Stop if the mouse doesn'y hover any open squares
    } // Stop if there's no forks
  } // End of displayForkBlock()
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
    if (buttonIndex == -1)
      return false;
    return (this.allButtons[buttonIndex].getState() == States.EMPTY);
  }// End validInput() function
  
  
  /**
  * Checks if either X won, O won, or if it's a tie.
  * If X won, return States.X
  * If O won, return States.O
  * If neither won, return States.EMPTY
  * @return The state of the player that won, or States.EMPTY if neither won.
  */
  private States returnWinner() {
    return this.returnWinner(this.allButtons); 
  }
    
  /**
  * Checks if either X won, O won, or if it's a tie.
  * If X won, return States.X
  * If O won, return States.O
  * If neither won, return States.EMPTY
  * @return The state of the player that won, or States.EMPTY if neither won.
  */
  private States returnWinner(Button [] buttonsToCheck) {
    for (int i = 0; i < 3; ++i) {
      // Check for matching rows
      // 0 1 2
      // 3 4 5
      // 6 7 8
      if (buttonsToCheck[i * 3].getState() != States.EMPTY && buttonsToCheck[i * 3 + 1].getState() != States.EMPTY && buttonsToCheck[i * 3 + 2].getState() != States.EMPTY) {
        if ((buttonsToCheck[i * 3].getState() == buttonsToCheck[i * 3 + 1].getState()) && (this.allButtons[i * 3 + 1].getState() == buttonsToCheck[i * 3 + 2].getState())) {
          return buttonsToCheck[i * 3].getState();
        }// Moves down from top
      }// Finish checking matching rows
      // Checking for matching columns
      // 0 3 6
      // 1 4 7
      // 2 5 8
      if (buttonsToCheck[i].getState() != States.EMPTY && buttonsToCheck[i + 3].getState() != States.EMPTY && buttonsToCheck[i + 6].getState() != States.EMPTY) {
        if ((buttonsToCheck[i].getState() == buttonsToCheck[i + 3].getState()) && (buttonsToCheck[i + 3].getState() == buttonsToCheck[i + 6].getState())) {
          return buttonsToCheck[i].getState();
        }// Moves right from top
      }// Finish checking matching collums
    }
    // Checking for matching diagonial top left to bottom right
    // 0 4 8
    if ((buttonsToCheck[0].getState() != States.EMPTY && buttonsToCheck[4].getState() != States.EMPTY && buttonsToCheck[8].getState() != States.EMPTY) && 
       ((buttonsToCheck[0].getState() == buttonsToCheck[4].getState()) && (buttonsToCheck[4].getState() == buttonsToCheck[8].getState())))
       return buttonsToCheck[0].getState();
    // Checking for matching diagonal top right to bottom left
    // 2 4 6
    if ((buttonsToCheck[2].getState() != States.EMPTY && buttonsToCheck[4].getState() != States.EMPTY && buttonsToCheck[6].getState() != States.EMPTY) && 
       (((buttonsToCheck[2].getState() == buttonsToCheck[4].getState()) && (buttonsToCheck[4].getState() == buttonsToCheck[6].getState()))))
       return buttonsToCheck[2].getState();
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
    return this.isTie(this.allButtons);
  }
  
  /**
  * Returns whether the game has ended in a tie.
  * @return Whether the game has ended in a tie.
  */
  private boolean isTie(Button[] buttonsToCheck) {
    boolean isTie = true;
    for (int i = 0; i < 9; ++i) {
      if (buttonsToCheck[i].getState() == States.EMPTY) {
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
      if (this.allButtons[i].getState() == stateToCount) {
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
    if (DEBUG) {
      if (this.isPlayerTurn)
        print("AI (" + ((this.player.getXO() == States.O) ? "X" : "O") + ")" );
      else
        print("Player (" + ((this.player.getXO() == States.X) ? "X" : "O") + ")" );
      print(" goes next.\n");
    }
    if (this.gameover) {
      this.gameover = false;
      this.resetButtons();
      this.player.assignXO(); // Assign a random sign for player
      if (this.player.getXO() == States.O) { // If the player is not X, make the AI go first.
        this.aiTurn();
        this.isPlayerTurn = DEBUG ? false : true;
        print("You are O and the AI is X.\n");
      } // End if
      else {
        this.isPlayerTurn = true;
        print("You are X and the AI is O.\n");
      }
      print("X goes first.\n");
    }
    else {
      if (!this.checkGameOver()) {
        if (this.validInput(buttonIndex)) {
          
           States aiState = (player.getXO() == States.X) ? States.O : States.X;
           States playerTurn = this.isPlayerTurn ? player.getXO() : aiState;
           
           this.allButtons[buttonIndex].setState(playerTurn);
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
  public String getAllButtonsString()  {
    String output = "";
    for (int i = 0; i < 9; i++) {
        if (this.allButtons[i].getState() == States.EMPTY)
          output += "_ ";
        else if (this.allButtons[i].getState() == States.X)
          output += "X ";
        else
          output += "O ";
        if (((i + 1) % 3) == 0)
          output += "\n";
    }
    return output;
  } // End getAllButtonsString() function
  
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
    return ("Gameover=" + (this.getGameover() ? "true" : "false") + " Board state="  + this.getAllButtonsString() + " Buttons:" + this.getButtonText() + " PlayerXO=" + ((this.getPlayer().getXO() == States.X) ? "X" : "O") + "\n");
  } // End toString() function
 
  /**
  * Checks whether two boards are equal.
  * @return whether two board are equal.
  */
  public boolean equals(Board otherBoard) {
    return (this.getGameover() == otherBoard.getGameover() && this.getAllButtonsString() == otherBoard.getAllButtonsString() && this.getButtonText() == otherBoard.getButtonText() && this.getPlayer() == otherBoard.getPlayer());
  } // End equals(...) function
}// End Board class
