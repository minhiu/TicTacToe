/**The board class which holds all our moves and our TicTacToe AI
   Homework Assignment: Prototype
   @author Sean Masterson, Alex Banh, Hieu Pham, and Brandon Walker
   @version 3.0 12/5/2019
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
  /**
   Message to display
  */
  private String message;
  /**
   The index of the last button we hovered over.
  */
  private int buttonHovered;
  /**
   Stores whether it's currently the player's (human's) turn.
  */
  private boolean isPlayerTurn;
  /**
   Stores at what time in milliseconds that the user made their last move.
  */
  private int lastMoveTime;
  /**
   Stores how much time in seconds player has to make a move before a move is randomly made for them.
  */
  private int maxTimeToMakeMove; // This value should be set via user input, as described in part 1 of the requirements.
  /**
   Stores the average time it took the player to make a move.
  */
  private int averageTimeToMakeMove;
  /**
   Decide whether or not the game will start
   */
  public boolean confirmedToStart = false;
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
    } // End else
    this.message = "\n Ready to lose???\n";
    print("X goes first.\n");
    this.buttonHovered = -2;
    if (confirmedToStart)
      this.lastMoveTime = millis();
    //this.maxTimeToMakeMove = 10; // Initialize to max value since the program needs input from user first
    this.averageTimeToMakeMove = 0;
    //this.noTurns = 0;
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
       if (this.allButtons[i].isInside(mouseX, mouseY)) {
         return i;
       } // End if
     }// End for loop. End button check
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
  
  /**
  * The AI makes a turn. Calls appropriate aiTurn...() function depending on value of constants.
  */
  private void aiTurn() {
    if (DEBUG) {
      this.isPlayerTurn = !this.isPlayerTurn;
    } // End if
    else {
      if (AI_PLAY_STYLE == 1) {
        aiTurnSmart();
      } // End if
      else if (AI_PLAY_STYLE == 2) {
        aiTurnSmartAndUnpredictable();
      } // End else if
      else {
        aiTurnRandom();
      } // End else
    } // End else
  } // End aiTurn() function
  
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
    } // End if
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
  * Remove duplicates from an ArrayList 
  * @param ArrayList<Integer> that contains duplicates.
  * @return ArrayList<Integer> with all duplicates removed.
  */
    private ArrayList<Integer> removeDuplicates(ArrayList<Integer> list) 
    { 
        ArrayList<Integer> newList = new ArrayList<Integer>(); // Create a new ArrayList 
        for (Integer element : list) {  // Go through the first list 
            // If this element is not present in newList 
            // then add it 
            if (!newList.contains(element)) { 
                newList.add(element); 
            } // End if
        } // End for loop
        // return the new list 
        return newList; 
    } // End removeDuplicates() function
    
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
        } // End if
      } // End if
    } // End for loop
    if (bestIndex != -1) {
      this.allButtons[bestIndex].setState(aiTurn);
      print("AI made a move on square " + (bestIndex + 1) + "\n");
    } // End if
    else {
      print("No more moves possible.\n");
    } // End else
  } // End aiTurnSmart() function
  
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
          bestScore = score;
          bestIndex = i;
        } // End if
      } // End if
    } // End for
    if (bestIndex != -1) {
      int randomButton = buttonIndiciesByScore[bestScore + 1][(int) random(noButtonScores[bestScore + 1])]; // Randomly picks an index in buttonIndiciesByScore[] from 0 to (noButtonScores[bestScore + 1] - 1) inclusive.
      this.allButtons[randomButton].setState(aiTurn);
      print("AI made a move on square " + (randomButton + 1) + "\n");
    } // End if
    else {
      print("No more moves possible.\n");
    } // End else
  } // End aiTurnSmartAndUnpredictable() function
  
 /**
  * Uses Minimax algorithm to determine optimal space to use.
  * @return 1 if the current board space will result in a win, 0 if it will result in a tie, -1 if it will result in a loss.
  */
  private int aiTurnMinimax(Button[] newButtons, States playerWeWantToWin, boolean isMax) {
    States otherPlayer = ((playerWeWantToWin == States.X) ? States.O : States.X);
    if (this.returnWinner(newButtons) == playerWeWantToWin) {
      return 1;
    } // End if
    else if (this.returnWinner(newButtons) == otherPlayer) {
      return -1;
    } // End else if
    else if (this.isTie(newButtons)) {
      return 0;
    } // End else if
    int best = -2 * (isMax ? 1 : -1);
    States currentMove = (isMax ? playerWeWantToWin : otherPlayer);
    int score = 0;
    for (int i = 0; i < 9; ++i) {
      if (newButtons[i].getState() == States.EMPTY) {
        this.allButtons[i].setState(currentMove);
        score = this.aiTurnMinimax(this.allButtons, playerWeWantToWin, !isMax);
        if (isMax) {
          best = max(best, score);
        } // End if
        else {
          best = min(best, score);
        } // End else
        this.allButtons[i].setState(States.EMPTY);
      } // End if
    } // End for loop
    return best;
  } // End aiTurnMinimax() function
 
 /**
  * Detects if the user is hovering over a new valid button and call functions that will display certain messages about the game if hovering over new button.
  */
 public void detectHovering() {
    if (this.getUserInput() != buttonHovered && this.getUserInput() > -1) {
      this.message = "";
      buttonHovered = board.getUserInput();
      //print("You hovered over button " + (buttonHovered + 1) + "\n");
      // Add your code here that will give the player advice based on the value of buttonHovered.
      this.displayBlockingSquare();
      this.displayForkBlock();
    } // End if
 } // End detectHovering() function
 
  /**
  * Display (if possible) an open square that would help the player block the winning of the bot
  * @return the index of the open square if found, otherwise, return -1
  */
  private ArrayList<Integer> findBlockingSquare(boolean isAI) {
    ArrayList<Integer> blockingSquares = new ArrayList<Integer>(0);
    States aiState = ((this.player.getXO() == States.X) ? States.O : States.X);
    States otherPlayerState = (isAI ? aiState : this.player.getXO());
    // Check the whole board to see if the bot have 2 square and one blank space within the same row/column/diagonal
    for (int i = 0; i < 3; i++) {
      // Check matching for all rows
      if (this.allButtons[i * 3].getState() == otherPlayerState && this.allButtons[i * 3 + 1].getState() == otherPlayerState && this.allButtons[i * 3 + 2].getState() == States.EMPTY) {
        blockingSquares.add(i * 3 + 2);
      } // End if
      if (this.allButtons[i * 3].getState() == otherPlayerState && this.allButtons[i * 3 + 1].getState() == States.EMPTY && this.allButtons[i * 3 + 2].getState() == otherPlayerState) {
        blockingSquares.add(i * 3 + 1);
      } // End if
      if (this.allButtons[i * 3].getState() == States.EMPTY && this.allButtons[i * 3 + 1].getState() == otherPlayerState && this.allButtons[i * 3 + 2].getState() == otherPlayerState) {
        blockingSquares.add(i * 3);  
      } // End if
  
      // Check matching for all columns
      if (this.allButtons[i].getState() == otherPlayerState && this.allButtons[i + 3].getState() == otherPlayerState && this.allButtons[i + 6].getState() == States.EMPTY) {
        blockingSquares.add(i + 6);
      } // End if
      if (this.allButtons[i].getState() == otherPlayerState && this.allButtons[i + 3].getState() == States.EMPTY && this.allButtons[i + 6].getState() == otherPlayerState) {
        blockingSquares.add(i + 3);
      } // End if
      if (this.allButtons[i].getState() == States.EMPTY && this.allButtons[i + 3].getState() == otherPlayerState && this.allButtons[i + 6].getState() == otherPlayerState) {
        blockingSquares.add(i);
      } // End if
    } // End for loop
    
    // Check for matching diagonal from top left to bot right
    if (this.allButtons[0].getState() == otherPlayerState && this.allButtons[4].getState() == otherPlayerState && this.allButtons[8].getState() == States.EMPTY)
      blockingSquares.add(8);
    if (this.allButtons[0].getState() == otherPlayerState && this.allButtons[4].getState() == States.EMPTY && this.allButtons[8].getState() == otherPlayerState)
      blockingSquares.add(4);
    if (this.allButtons[0].getState() == States.EMPTY && this.allButtons[4].getState() == otherPlayerState && this.allButtons[8].getState() == otherPlayerState)
      blockingSquares.add(0);
    
    // Check for matching diagonal from top right to bot left
    if (this.allButtons[2].getState() == otherPlayerState && this.allButtons[4].getState() == otherPlayerState && this.allButtons[6].getState() == States.EMPTY)
      blockingSquares.add(6);
    if (this.allButtons[2].getState() == otherPlayerState && this.allButtons[4].getState() == States.EMPTY&& this.allButtons[6].getState() == otherPlayerState)
      blockingSquares.add(4);
    if (this.allButtons[2].getState() == States.EMPTY && this.allButtons[4].getState() == otherPlayerState && this.allButtons[6].getState() == otherPlayerState)
      blockingSquares.add(2);
    
    return blockingSquares;
  } // End function findBlockingSquare()
  
  /**
  * Display a message if the mouse is hovering over an EMPTY square that would make either the player or AI win.
  */
  private void displayBlockingSquare() { 
    // Check if the AI is about to win
    ArrayList<Integer> blockingSquares = this.findBlockingSquare(true);
    java.util.Collections.sort(blockingSquares);
    blockingSquares = this.removeDuplicates(blockingSquares);
    if (blockingSquares.size() > 0) {
      if (this.validInput(this.getUserInput())) {
        boolean firstFound = true;
        for (int i = 0; i < blockingSquares.size(); ++i) {
          if (this.getUserInput() != blockingSquares.get(i)) {
            if (firstFound) {
              //print("The AI is about to win if you don't play at square position: " + (blockingSquares.get(i) + 1) + "\n");
              this.message += "\nThe AI is about to win if you don't play at square position: " + (blockingSquares.get(i) + 1);
              firstFound = false;
            }
            else {
              this.message += ", " + (blockingSquares.get(i) + 1);
            }
            //this.displayMessage(message);
          } // End if. Stop printing if the mouse stays at the same square
        }
        
      } // End if. Stop if the mouse doesn't hover over any squares
    } // End if. Stop if there's no blocking squares
    
    blockingSquares = this.findBlockingSquare(false);
    java.util.Collections.sort(blockingSquares);
    blockingSquares = this.removeDuplicates(blockingSquares);
    // Check if the player is about to win
    if (blockingSquares.size() > 0) {
      if (this.validInput(this.getUserInput())) {
        boolean firstFound = true;
        for (int i = 0; i < blockingSquares.size(); ++i) {
          if (this.getUserInput() != blockingSquares.get(i)) {
            if (firstFound) {
              if (DEBUG) {
                //print("The human player");
                this.message += "\nThe human player"; 
              } // End if
              else {
                //print("You");
                this.message += "\nYou";
              } // End else
              //print(" can make a move at this square position to win the game: " + (blockingSquares.get(i) + "\n"));
              this.message += " can make a move at this square position to win\nthe game: " + (blockingSquares.get(i) + 1);
              firstFound = false;
            }
            else {
              this.message += ", " + (blockingSquares.get(i) + 1);
            }
          //this.displayMessage(message);
          }
          //String message;
        } // End if. Stop printing if the mouse stays at the same square
      } // End if. Stop if the mouse doesn't hover over any squares
    } // End if. Stop if there's no blocking squares
  } // End if. End of displayBlockingSquare()
 
 /**
  * Find a spot that the user or AI will need to place to make or stop a fork
  * @param isAI Whether we are checking for potential forks from the AI or the player.
  * @return Button index that player or AI needs to create fork.
  */
  public ArrayList<Integer> forkBlockDetector(boolean isAI){
    ArrayList<Integer> forks = new ArrayList<Integer>(0);
    States aiState = ((this.player.getXO() == States.X) ? States.O : States.X); //Find AI state
    States otherPlayerState = (isAI ? aiState : this.player.getXO());
   
    //Triangle tactic
    if (this.allButtons[4].getState() == otherPlayerState) {
      if (this.allButtons[8].getState() == otherPlayerState && this.allButtons[5].getState() == States.EMPTY && this.allButtons[6].getState() == States.EMPTY && this.allButtons[2].getState() == States.EMPTY) {
        forks.add(2);
      }// End if. Bottom right check
      if (this.allButtons[2].getState() == otherPlayerState && this.allButtons[1].getState() == States.EMPTY && this.allButtons[8].getState() == States.EMPTY && this.allButtons[0].getState() == States.EMPTY) {
        forks.add(0);
      }// End else if. Top right check
      if (this.allButtons[6].getState() == otherPlayerState && this.allButtons[0].getState() == States.EMPTY && this.allButtons[7].getState() == States.EMPTY && this.allButtons[8].getState() == States.EMPTY) {
        forks.add(8);
      }// End else if. Bottom left check
      if (this.allButtons[0].getState() == otherPlayerState && this.allButtons[2].getState() == States.EMPTY && this.allButtons[3].getState() == States.EMPTY && this.allButtons[6].getState() == States.EMPTY) {
        forks.add(6);
      }// End else if. Top left check
    }//End if. DONE TRIANGLE TACTICS
    
    //Triangle tactic (Extras)
    if (this.allButtons[4].getState() == otherPlayerState) {
      if (this.allButtons[0].getState() == otherPlayerState && this.allButtons[5].getState() == States.EMPTY && this.allButtons[6].getState() == States.EMPTY && this.allButtons[3].getState() == States.EMPTY) {
        forks.add(3);
      }// End if. Top right check
      if (this.allButtons[6].getState() == otherPlayerState && this.allButtons[1].getState() == States.EMPTY && this.allButtons[8].getState() == States.EMPTY && this.allButtons[7].getState() == States.EMPTY) {
        forks.add(7);
      }// End else if. Top right check
      if (this.allButtons[8].getState() == otherPlayerState && this.allButtons[2].getState() == States.EMPTY && this.allButtons[3].getState() == States.EMPTY && this.allButtons[5].getState() == States.EMPTY) {
        forks.add(5);
      }// End else if. Bottom left check
      if (this.allButtons[2].getState() == otherPlayerState && this.allButtons[0].getState() == States.EMPTY && this.allButtons[7].getState() == States.EMPTY && this.allButtons[1].getState() == States.EMPTY) {
        forks.add(1);
      }// End else if. Top left check
    }//End if. DONE TRIANGLE TACTICS (EXTRAS)
    
    // "L" Fork
    if (this.allButtons[0].getState() == otherPlayerState && this.allButtons[8].getState() == otherPlayerState) {
      if (this.allButtons[3].getState() == States.EMPTY && this.allButtons[7].getState() == States.EMPTY && this.allButtons[6].getState() == States.EMPTY) {
        forks.add(6);
       }// Can it fork?
      }// Bottom Left
     if (this.allButtons[0].getState() == otherPlayerState && this.allButtons[8].getState() == otherPlayerState) {
      if (this.allButtons[1].getState() == States.EMPTY && this.allButtons[5].getState() == States.EMPTY && this.allButtons[6].getState() == States.EMPTY) {
        forks.add(2);
       }// Can it fork?
      }// Upper Right
     if (this.allButtons[2].getState() == otherPlayerState && this.allButtons[6].getState() == otherPlayerState) {
      if (this.allButtons[5].getState() == States.EMPTY && this.allButtons[7].getState() == States.EMPTY && this.allButtons[6].getState() == States.EMPTY) {
        forks.add(8);
       }// Can it fork?
      }// Bottom Left
     if (this.allButtons[2].getState() == otherPlayerState && this.allButtons[6].getState() == otherPlayerState) {
      if (this.allButtons[1].getState() == States.EMPTY && this.allButtons[3].getState() == States.EMPTY && this.allButtons[6].getState() == States.EMPTY) {
        forks.add(0);
       }// Can it fork?
      }// Upper Right
           
    //Arrowhead tactic
    if (this.allButtons[7].getState() == otherPlayerState) {
      if (this.allButtons[5].getState() == otherPlayerState && this.allButtons[2].getState() == States.EMPTY && this.allButtons[6].getState() == States.EMPTY && this.allButtons[8].getState() == States.EMPTY) {
        forks.add(8);
      }// End if. Right check
      if (this.allButtons[3].getState() == otherPlayerState && this.allButtons[0].getState() == States.EMPTY && this.allButtons[8].getState() == States.EMPTY && this.allButtons[6].getState() == States.EMPTY) {
        forks.add(6);
      }// End else if. Left check
    }// End if. Bottom arrow 1/4
    if (this.allButtons[1].getState() == otherPlayerState){
      if (this.allButtons[5].getState() == otherPlayerState && this.allButtons[0].getState() == States.EMPTY && this.allButtons[8].getState() == States.EMPTY && this.allButtons[2].getState() == States.EMPTY) {
        forks.add(2);
      }// End if. Left check
      if (this.allButtons[3].getState() == otherPlayerState && this.allButtons[2].getState() == States.EMPTY && this.allButtons[6].getState() == States.EMPTY && this.allButtons[0].getState() == States.EMPTY) {
        forks.add(0);
      }// End else if. Left check
    }// Top arrow 2/4
    if (this.allButtons[3].getState() == otherPlayerState) {
      if (this.allButtons[1].getState() == otherPlayerState && this.allButtons[2].getState() == States.EMPTY && this.allButtons[6].getState() == States.EMPTY && this.allButtons[0].getState() == States.EMPTY) {
        forks.add(0);
      }// End if. Top check
      if(this.allButtons[7].getState() == otherPlayerState && this.allButtons[0].getState() == States.EMPTY && this.allButtons[8].getState() == States.EMPTY && this.allButtons[6].getState() == States.EMPTY) {
        forks.add(6);
      }// End else if. Bottom check
    }// Right arrow arrow 3/4
    if (this.allButtons[5].getState() == otherPlayerState) {
      if (this.allButtons[1].getState() == otherPlayerState && this.allButtons[0].getState() == States.EMPTY && this.allButtons[8].getState() == States.EMPTY && this.allButtons[2].getState() == States.EMPTY) {
        forks.add(2);
      }// End if. End if. Top check
      if (this.allButtons[7].getState() == otherPlayerState && this.allButtons[2].getState() == States.EMPTY && this.allButtons[6].getState() == States.EMPTY && this.allButtons[8].getState() == States.EMPTY) {
        forks.add(8);
      }// End else if. End else if. Bottom check
    }// End else if. Left arrow 4/4 DONE ARROWHEADS
           
    // Encirclement Tactic
    if (this.allButtons[0].getState() == otherPlayerState && this.allButtons[8].getState() == otherPlayerState) {
      if (this.allButtons[4].getState() == player.getXO() && this.allButtons[6].getState() == player.getXO()&& this.allButtons[1].getState() == States.EMPTY && this.allButtons[5].getState() == States.EMPTY && this.allButtons[2].getState() == States.EMPTY) {
        forks.add(2);
      }//End if. Top right circle
      if (this.allButtons[4].getState() == player.getXO() && this.allButtons[2].getState() == player.getXO()&& this.allButtons[3].getState() == States.EMPTY && this.allButtons[7].getState() == States.EMPTY && this.allButtons[6].getState() == States.EMPTY) {
        forks.add(6);
      } // End if. Top left circle
    }// "\" Entanglement done 1/2
    if (this.allButtons[2].getState() == otherPlayerState && this.allButtons[6].getState() == otherPlayerState) {
      if (this.allButtons[4].getState() == player.getXO() && this.allButtons[8].getState() == player.getXO()&& this.allButtons[1].getState() == States.EMPTY && this.allButtons[3].getState() == States.EMPTY && this.allButtons[0].getState() == States.EMPTY) {
        forks.add(0);
      }//End if. Top left circle
      if (this.allButtons[4].getState() == player.getXO() && this.allButtons[0].getState() == player.getXO()&& this.allButtons[5].getState() == States.EMPTY && this.allButtons[7].getState() == States.EMPTY && this.allButtons[8].getState() == States.EMPTY) {
        forks.add(8);
      } // End if. Top right circle
    } // End if.  "/" Entanglement done 2/2
    
    // "X" fork Tactic
    if(this.allButtons[0].getState() == otherPlayerState && this.allButtons[2].getState() == otherPlayerState) {
      if (this.allButtons[4].getState() == States.EMPTY && this.allButtons[6].getState() == States.EMPTY && this.allButtons[8].getState() == States.EMPTY) {
        forks.add(4);
      }// Can the fork work
    }// End top "X"
    if(this.allButtons[6].getState() == otherPlayerState && this.allButtons[8].getState() == otherPlayerState) {
      if (this.allButtons[4].getState() == States.EMPTY && this.allButtons[0].getState() == States.EMPTY && this.allButtons[2].getState() == States.EMPTY) {
        forks.add(4);
      }// Can the fork work
    }// End bottom "X"
    if(this.allButtons[0].getState() == otherPlayerState && this.allButtons[6].getState() == otherPlayerState) {
      if (this.allButtons[4].getState() == States.EMPTY && this.allButtons[2].getState() == States.EMPTY && this.allButtons[8].getState() == States.EMPTY) {
        forks.add(4);
      }// Can the fork work
    }// End left "X"
    if(this.allButtons[2].getState() == otherPlayerState && this.allButtons[8].getState() == otherPlayerState) {
      if (this.allButtons[4].getState() == States.EMPTY && this.allButtons[0].getState() == States.EMPTY && this.allButtons[6].getState() == States.EMPTY) {
        forks.add(4);
      }// Can the fork work
    }// End right "X"
    
    // "+" fork Tactic
    if(this.allButtons[1].getState() == otherPlayerState && this.allButtons[7].getState() == otherPlayerState) {
      if (this.allButtons[3].getState() == States.EMPTY && this.allButtons[5].getState() == States.EMPTY && this.allButtons[4].getState() == States.EMPTY) {
        forks.add(4);
      }// Can the fork work
    }// End "|" fork
    if(this.allButtons[3].getState() == otherPlayerState && this.allButtons[5].getState() == otherPlayerState) {
      if (this.allButtons[1].getState() == States.EMPTY && this.allButtons[7].getState() == States.EMPTY && this.allButtons[4].getState() == States.EMPTY) {
        forks.add(4);
      }// Can the fork work
    }// End "-" fork
    if(this.allButtons[3].getState() == otherPlayerState && this.allButtons[7].getState() == otherPlayerState) {
      if (this.allButtons[1].getState() == States.EMPTY && this.allButtons[5].getState() == States.EMPTY && this.allButtons[4].getState() == States.EMPTY) {
        forks.add(4);
      }// Can the fork work
    }// End left and bottom
    if(this.allButtons[1].getState() == otherPlayerState && this.allButtons[5].getState() == otherPlayerState) {
      if (this.allButtons[3].getState() == States.EMPTY && this.allButtons[7].getState() == States.EMPTY && this.allButtons[4].getState() == States.EMPTY) {
        forks.add(4);
      }// Can the fork work
    }// End right and top
  
    // No fork detected
    return forks;
  }// End fork block detector

  /**
  * Display a message telling the user where to go to block the fork
  */
  private void displayForkBlock() {
    // Check forks for the AI
    ArrayList<Integer> forks = this.forkBlockDetector(true);
    java.util.Collections.sort(forks);
    forks = this.removeDuplicates(forks);
    if (forks.size() > 0) {
      if (this.validInput(this.getUserInput())) {
        boolean firstFound = true;
        for (int i = 0; i < forks.size(); ++i) {
          if (this.getUserInput() != forks.get(i)) {
            if (firstFound) {
              this.message += "\nThe AI will make a fork if you don't go : " + (forks.get(i) + 1);
              print("The AI will make a fork if you don't go : " + (forks.get(i) + 1) + "\n");
              //this.displayMessage(message);
              firstFound = false;
            } // Message fork loop for AI
            else {
              this.message += ", " + (forks.get(i) + 1);
            } // Forks squares shown for AI
            //this.displayMessage(message);
          } // End if. Stop printing if the mouse stays at the same square
        } // End if. All forks found for AI 
      } // End if. Stop if the mouse doesn'y hover any open squares
    } // End if. Stop if there's no forks
    
    forks = this.forkBlockDetector(false);
    java.util.Collections.sort(forks);
    forks = this.removeDuplicates(forks);
    // Check forks for the player
    if (forks.size() > 0) {
      if (this.validInput(this.getUserInput())) {
        boolean firstFound = true;
        for (int i = 0; i < forks.size(); ++i) {
          if (this.getUserInput() != forks.get(i)) {
            if (firstFound) {
              if (DEBUG) {
                print("The human player");
                this.message += "\nThe human player";
              } // End if
              else {
                print("You");
                this.message += "\nYou";
              } // End else
              print(" can make a fork if you go : " + (forks.get(i) + 1) + "\n");
              this.message += " can make a fork if you go : " + (forks.get(i) + 1);
              firstFound = false;
            } // Fork messages for user
            else {
              this.message += ", " + (forks.get(i) + 1);
            } // Forks displayed as part of the message for user
            //this.displayMessage(message);
          } // End if. Stop printing if the mouse stays at the same square
        } // End if. All forks found for user
      } // End if. Stop if the mouse doesn'y hover any open squares
    } // End if. Stop if there's no forks
  } // End of displayForkBlock() function
  
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
      print("It took you an average of " + this.averageTimeToMakeMove / 1000.0 + "s per turn to make a move.\n");
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
        this.message = "Haha loser!";
      } // End else
      print("Press any square to start another game, or you can exit.\n");
      return true;
    }// Finish win checking
    else {
      // Check if game ends in a tie.
      if (this.isTie()) {
        print("It's a tie.\n");
        print("It took you an average of " + this.averageTimeToMakeMove / 1000.0 + "s per turn to make a move.\n");
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
    this.message = "";
    
    if (DEBUG) {
      if (this.isPlayerTurn) {
        print("AI (" + ((this.player.getXO() == States.O) ? "X" : "O") + ")" );
      }
      else {
        print("Player (" + ((this.player.getXO() == States.X) ? "X" : "O") + ")" );
      }
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
      this.message = "\n Ready to lose???";
      print("X goes first.\n");
      this.buttonHovered = -2;
      this.lastMoveTime = millis();
      this.averageTimeToMakeMove = 0;
      //this.noTurns = 0;
    }
    else {
      if (!this.checkGameOver()) {
        if (this.validInput(buttonIndex)) {
          States aiState = (player.getXO() == States.X) ? States.O : States.X;
          States playerTurn = this.isPlayerTurn ? player.getXO() : aiState;
          int noTurns = 1;
          if (DEBUG) {
            noTurns += this.countTurns(playerTurn) + this.countTurns(aiState);
          }
          else {
            noTurns += this.countTurns(playerTurn);
          }
          //print("NO TURNS: " + noTurns + "\n");
          this.averageTimeToMakeMove = (this.averageTimeToMakeMove * (noTurns - 1) / noTurns) + (millis() - this.lastMoveTime) / noTurns; // Weighted average
          this.lastMoveTime = millis();
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
  
  /**
  * Displays messages on the bottom of the board
  */
  public void displayMessage() {
    //duration = 1000;
    textSize(15);
    fill(0,102, 153);
    //while(duration > 0) {
    if (!this.gameover) {
      text(this.message, 0, 410);
    } // End if
    //duration--;
    //}//End of while loop for the message durration
  }// End displayMessage(...) function
  
  /**
   * Automatically makes a move for the user if 
   * their alloted time they have chosen runs out
   */
  public void automaticMoveSelect() {
    maxTimeToMakeMove = (int) mySlider.getValue();
    if (confirmedToStart) {
      if (millis() - this.lastMoveTime >= this.maxTimeToMakeMove * 1000 && !this.gameover) {
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
        } // End if
        else {
          int randomButton = possibleStates[(int) random(count)]; // Randomly picks an index in possibleStates[] from 0 to (count - 1) inclusive.
          print("You took too long. A random move was made for you on square " + (randomButton + 1) + "\n");
          this.makeTurn(randomButton);
        } // End else
      } // End child if
    } // End parent if
  } // End automaticMoveSelect() function.

  /**
   * Detect whether or not the player has started the tic tac toe game yet 
   */
  public void confirmedToStartGame() {
      if (mousePressed)
        if (mouseX>150 && mouseX < 350 && mouseY > 350 && mouseY < 400)
          confirmedToStart = true;
  } // End confirmedToStartGame
   /**
   * Show the average amount of time per move 
   * the player made for each turn
   */
  public void printMaxTime() {
    textSize(15);
    fill(0,102,153);
    text("Max time per each move: " + (int) mySlider.getValue() + " seconds", 125, 80);
  } // End printMaxTime
  
  /**
   * Print Tic Tac Toe Title
   */
  public void printTitle() {
    textSize(40);
    fill(0, 102, 153);
    text(TITLE, 150, 50);
  }
  
  /**
   * Displays a welcome message for the user 
   * on program start up and allows them to 
   * choose the time needed for each move
   */
  public void welcomeMessage() {
    textSize(15);
    fill(0,102,153);
    text("   To begin the game, please adjust the slider to the desired time \n" +
    "                                    allowance for each move", 0, 200);
    text("Max time per each move: " + (int) mySlider.getValue() + " seconds", 125, 325);
  } // End welcomeMessage
  
} // End Board class
