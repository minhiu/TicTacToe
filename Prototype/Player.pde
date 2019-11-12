/**A player class that holds what state the player can be in
   Homework Assignment: TicTacToe Prototype
   @author Sean Masterson, Alex Banh, Hieu Pham, and Brandon Walker
   @version 1.0 10/22/2019
  */
  
/**
  *The Player class which holds all user states
  */
public class Player {
  private States xo; // Player's character, either an X, O, or blank space (non-functional character).
  /**
  * Default Player constructor, has the random assignment built in.
  * Sets player's character to a blank square.
  */
  public Player() {
    this.xo = States.EMPTY;
  }

  /**
  * Randomly assigns the player either X or O.
  */
  public void assignXO() {
    if (((int) random(2)) == 0)
      this.setXO(States.O);
    else
      this.setXO(States.X);
    //this.setXO(States.O);
  }
  
  /**
  * Sets the state of the player to given input.
  */
  private void setXO(States nXO) {
    this.xo = nXO;
  } // End setXO() function

  /**
  * Returns the player's charater
  */
  public States getXO() {
    return this.xo;
  } // End getXO() function
} // End Player class
