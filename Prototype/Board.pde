public class Board {
  private boolean playerWin;
  private boolean aiWin;
  private boolean replay;
  private boolean canMove;
  private boolean playerTurn;
  private States[] boardState;
  
  public Board() {
    
  }
  
  public void resetBoard() {
    boardState = new States[9];
  }
}
