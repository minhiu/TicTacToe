public class Player {
  private States xo; // Player's character, either an X, O, or blank space (non-functional character).
  private Random random; // Randomize X or O for player
  // Sets player's character to a blank square.
  // For some reason, the value of this.xo does not seem to change in any function that modifies it, even the constructor. Needs to be fixed.
  public Player() {
    this.xo = States.EMPTY;
    random = new Random();
  }

  // Assign player's character to a X (TODO: Change this so it is randomly either X or O)
  // This function does not work for some reason??? 
  public void assignXO() {
    
    if (getRandomBoolean())
      this.setXO(States.O);
    else
      this.setXO(States.X);
  }

  // Sets player character to given input
  private void setXO(States nXO) {
    this.xo = nXO;
  }
  
  public boolean getRandomBoolean() {
      return random.nextBoolean();
  }

  // Return the player's character
  // NOTE: This function will return null for some reason, even though the constructor assigns this.xo a value of States._ Calling a setter does not fix
  // Needs to be fixed
  public States getXO() {
    return this.xo;
  }
}
