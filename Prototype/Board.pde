public class Board {
  private boolean playerWin;
  private boolean aiWin;
  private boolean replay;
  private boolean canMove;
  private boolean playerTurn;
  private States[] boardState;
  private Button[] allButtons;
  private Player player;
  
  public Board() {
    this.playerWin = false;
    this.aiWin = false;
    this.replay = false;
    this.canMove = true; // Possibly random whether true or false
    this.playerTurn = true; // Possibly random whether true or false
    this.resetBoard();
    this.initializeButtons();
    //this.player.assignXO();
  }
  
  public void resetBoard() {
    boardState = new States[9];
    
    for (int i = 0; i < 9; ++i) {
      boardState[i] = States._;
    }
  }
  
  // Create 9 buttons:
  private void initializeButtons() {
    this.allButtons = new Button[9];
   
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        this.allButtons[i * 3 + j] = new Button(SQUARE_SIZE * j, SQUARE_SIZE * i, SQUARE_SIZE, SQUARE_SIZE, "b" + i * 3 + j + 1);
      }
    }
  }
  
  private void drawLines() {
    for (int i = 0; i < 3; i++) {
      line (i * SQUARE_SIZE, 0, i * SQUARE_SIZE, height);
    }
    for (int i = 0; i < 3; i++) {
      line (0, i * SQUARE_SIZE, width, i * SQUARE_SIZE);
    }
  }
  
  public int getUserInput() {
     for (int i = 0; i < 9; i++) {
       if (this.allButtons[i].isInside(mouseX, mouseY))
         return i;
     }
     return -1;
  }
  
  public void drawShapes() {
    
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (this.boardState[i * 3 + j] == States.X) {
          line(SQUARE_SIZE * j, SQUARE_SIZE * i, SQUARE_SIZE * (j + 1), SQUARE_SIZE * (i + 1));
          line(SQUARE_SIZE * j, SQUARE_SIZE * (i + 1), SQUARE_SIZE * (j + 1), SQUARE_SIZE * i);
        }
        else if (this.boardState[i * 3 + j] == States.O) {
          circle(SQUARE_SIZE * j + (SQUARE_SIZE * 0.5), SQUARE_SIZE * i + (SQUARE_SIZE * 0.5), SQUARE_SIZE);
        }     
      }
    }
  }
  
  public void drawStatesDEBUG() {
    
    for (int i = 0; i < 9; i++) {
        if (this.boardState[i] == States._)
          print ("_ ");
        else if (this.boardState[i] == States.X)
          print ("X ");
        else
          print ("O ");
        if (((i + 1) % 3) == 0)
          print ("\n");
    }
  }
  
  public void aiTurn() {
    int count = 0;
    int[] possibleStates = new int[9];
    
    for (int i = 0; i < 9; i++) {
      if (boardState[i] == States._) {
        possibleStates[count] = i;
        ++count;
      }
    }
    
    int randomButton = possibleStates[(int) random(count)]; // Randomly picks from button 0 to count - 1.
    
    if (count == 0)
      print("No more moves possible.\n");
    else {
      boardState[randomButton] = States.X;
      print("AI made a move on button " + (randomButton + 1) + "\n");
    }
    
  }
  public void drawBoard() {
    this.drawLines();
    this.drawShapes();
  }
  
  private boolean validInput(int buttonIndex) {
    return (boardState[buttonIndex] == States._);
  }
  
  private States returnWinner() {
    for (int i = 0; i < 3; ++i) {
      
      // Check for matching rows
      // 0 1 2
      // 3 4 5
      // 6 7 8
      if (this.boardState[i * 3] != States._ && this.boardState[i * 3 + 1] != States._ && this.boardState[i * 3 + 2] != States._) {
        if ((this.boardState[i * 3] == this.boardState[i * 3 + 1]) && (this.boardState[i * 3 + 1] == this.boardState[i * 3 + 2])) {
          return this.boardState[i * 3];
        }
      }
      
      // Checking for matching columns
      // 0 3 6
      // 1 4 7
      // 2 5 8
      if (this.boardState[i] != States._ && this.boardState[i + 3] != States._ && this.boardState[i + 6] != States._) {
        if ((this.boardState[i] == this.boardState[i + 3]) && (this.boardState[i + 3] == this.boardState[i + 6])) {
          return this.boardState[i];
        }
      }
    }
    
    // Checking for matching diagonial top left to bottom right
    // 0 4 8
    if ((this.boardState[0] != States._ && this.boardState[4] != States._ && this.boardState[8] != States._) && 
       ((this.boardState[0] == this.boardState[4]) && (this.boardState[4] == this.boardState[8])))
       return this.boardState[0];
       
    // Checking for matching diagonal top right to bottom left
    // 2 4 6
    if ((this.boardState[2] != States._ && this.boardState[4] != States._ && this.boardState[6] != States._) && 
       (((this.boardState[2] == this.boardState[4]) && (this.boardState[4] == this.boardState[6]))))
       return this.boardState[2];
       
    return States._;
  }
  
  public boolean checkGameOver() {
    if (this.returnWinner() != States._) {
      print("Game is over.\n");
      if (this.returnWinner() == States.X)
         print("X won.\n");
      else
         print("O won.\n");
      return true;
    }
    return false;
  }
  
  public void makeTurn(int buttonIndex) {

    if (!this.checkGameOver()) {

      if (this.validInput(buttonIndex)) {
         this.boardState[buttonIndex] = States.O;//player.getXO();
         if (!this.checkGameOver()) {
           this.aiTurn();
           this.checkGameOver();
         }
      }
      else
        print("Invalid move.\n");
    }
  }
}
