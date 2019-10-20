public class Board {
  private boolean playerWin;
  private boolean aiWin;
  private boolean replay;
  private boolean canMove;
  private boolean playerTurn;
  private States[] boardState;
  
  public Board() {
    initializeButtons();
  }
  
  public void resetBoard() {
    boardState = new States[9];
  }
  
  // Create 9 buttons:
  private void initializeButtons() {
    Button[] allButtons = new Button[9];
   
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        allButtons[i * 3 + j] = new Button(SQUARE_SIZE * i, SQUARE_SIZE * j, SQUARE_SIZE, SQUARE_SIZE, "b" + i * 3 + j);
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
  
  public void drawBoard() {
    this.drawLines();
  }
}
