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
  private Random random; // Randomize X or O for player
  // Sets player's character to a blank square.
  // For some reason, the value of this.xo does not seem to change in any function that modifies it, even the constructor. Needs to be fixed.
  /**
    * The player constructor, has the random assignment built in
    */
  public Player() {
    this.xo = States.EMPTY;
    random = new Random();
  }

  // Assign player's character to a X (TODO: Change this so it is randomly either X or O)
  // This function does not work for some reason??? 
  /**
    * Randomly assigns the player either X or O
    * //not sure if we need this since we can do random assignment in the constructor (both arent working)
    */
  public void assignXO() {
    
    if (getRandomBoolean())
      this.setXO(States.O);
    else
      this.setXO(States.X);
  }
  
  // Sets player character to given input
  /**
    * Sets the state of the player as either X or O
    */
  private void setXO(States nXO) {
    this.xo = nXO;
  } // End setXO() function
  
  public boolean getRandomBoolean() {
      return random.nextBoolean();
  }

  // Return the player's character
  // NOTE: This function will return null for some reason, even though the constructor assigns this.xo a value of States._ Calling a setter does not fix
  // Needs to be fixed
  /**
    * Returns the player's charater
    */
  public States getXO() {
    return this.xo;
  } // End getXO() function
} // End Player class
