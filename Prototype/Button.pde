/**A Button class that outlines info about a button.
   Homework Assignment: TicTacToe Prototype
   @author Sean Masterson, Alex Banh, Hieu Pham, and Brandon Walker
   @version 2.0 11/18/2019
  */
 
public class Button
{
  /**
   The Button's x coordinate.
  */
  private int xCoordinate;
  /**
   The Button's y coordinate.
  */
  private int yCoordinate;
  /**
   The Button's width.
  */
  private int width;
  /**
   The Button's height.
  */
  private int height;
  /**
   The Button's label.
  */
  private String label;
  /**
   The Button's state.
  */
  private States state;
  
  /**
   * Default Button constructor.
   * Sets all integers to 0.
   */
  public Button() {
    this.setXCoordinate(0);
    this.setYCoordinate(0);
    this.setWidth(0);
    this.setHeight(0);
    this.setState(States.EMPTY); 
} // End Button() function (default constructor)
 
  /**
   * Overloaded Button constructor.
   * Sets all member variables to arguments.
   * @param newX new x coordinate of the Button.
   * @param newY new y coordinate of the Button.
   * @param newW new width of the Button.
   * @param newH new height of the Button.
   * @param newLabel new Button label.
   */
  public Button(int newXCoordinate, int newYCoordinate, int newWidth, int newHeight, String newLabel, States newState) {
    this.setXCoordinate(newXCoordinate);
    this.setYCoordinate(newYCoordinate);
    this.setWidth(newWidth);
    this.setHeight(newHeight);
    this.setLabel(newLabel);
    this.setState(newState);
  } // End Button(...) function (overloaded constructor)
 
 /**
   * Checks if input arguments is a coordinate that's within the Button's area.
   * Sets all member variables to arguments.
   * @param mx x coordinate to check if it's inside button area.
   * @param my y coordinate to check if it's inside button area.
   * @return whether the coordinates is inside the button area
   */
  public boolean isInside(int mx, int my) {
    return ((mx >= this.getXCoordinate() && mx <= this.getXCoordinate() + this.getWidth()) && (my >= this.getYCoordinate() && my <= this.getYCoordinate() + this.getHeight()));
  } // End isInside(...) function
 
 /**
  * Draws the button's state (States.X or States.O).
  */
  public void drawShape() {
     if (this.getState() == States.X) { // Draw X's consisting of two diagonal lines
       line(this.getXCoordinate(), this.getYCoordinate(), this.getXCoordinate() + this.getWidth(), this.getYCoordinate() + this.getHeight());
       line(this.getXCoordinate(), this.getYCoordinate() + this.getHeight(), this.getXCoordinate() + this.getWidth(), this.getYCoordinate());
     } // End draw X
     else if (this.getState() == States.O) { // Draw O's consisting of a circle
       circle(this.getXCoordinate() + (SQUARE_SIZE * 0.5), this.getYCoordinate() + (SQUARE_SIZE * 0.5), SQUARE_SIZE);
     }
 }
 
 /**
   * Displays the button with the coordinates and size as determined
   * by member variables.
   */
  public void display() {
    rect(this.getXCoordinate(), this.getYCoordinate(), this.getWidth(), this.getHeight());
    text(this.getLabel(), this.getXCoordinate(), this.getYCoordinate());
  } // End display() function
 
  /**
   * Gets Button's x coordinate.
   * @return Button's x coordinate.
   */
  public int getXCoordinate() {
    return this.xCoordinate;
  } // End getXCoordinate() function
 
  /**
   * Gets Button's y coordinate.
   * @return Button's y coordinate.
   */
  public int getYCoordinate() {
    return this.yCoordinate;
  } // End getYCoordinate() function
 
  /**
   * Gets Button's width.
   * @return Button's width.
   */
  public int getWidth() {
    return this.width;
  } // End getWidth() function
 
  /**
   * Gets Button's height.
   * @return Button's height.
   */
  public int getHeight() {
    return this.height;
  } // End getHeight() function
 
  /**
   * Gets Button's label.
   * @return Button's label.
   */
  public String getLabel() {
    return this.label;
  } // End getLabel() function
 
 /**
   * Gets Button's state.
   * @return Button's label.
   */
  public States getState() {
    return this.state;
  } // End getLabel() function
 
  /**
   * Sets Button's x coordinate.
   * @param newXCoordinate Button's x coordinate.
   */
  public void setXCoordinate(int newXCoordinate) {
    this.xCoordinate = newXCoordinate;
  } // End setXCoordinate(...) function
 
  /**
   * Sets Button's y coordinate.
   * @param newYCoordinate Button's y coordinate.
   */
  public void setYCoordinate(int newYCoordinate) {
    this.yCoordinate = newYCoordinate;
  } // End setYCoordinate(...) function
 
  /**
   * Sets Button's width.
   * @param newW Button's width.
   */
  public void setWidth(int newWidth) {
    this.width = newWidth;
  } // End setWidth(...) function
 
  /**
   * Sets Button's height.
   * @param newH Button's height.
   */
  public void setHeight(int newHeight) {
    this.height = newHeight;
  } // End setHeight(...) function
 
  /**
   * Sets Button's label.
   * @param newLabel Button's label.
   */
  public void setLabel(String newLabel) {
    this.label = newLabel;
  } // End setLabel(...) function
 
 /**
   * Sets Button's state.
   * @param newLabel Button's label.
   */
  public void setState(States newState) {
    this.state = newState;
  } // End setLabel(...) function
 
 
  /**
   * Returns String with info about the Button.
   * @return String with info about the Button.
   */
  public String toString() {
    return this.getLabel() + " x=" + this.getXCoordinate() + " y=" + this.getYCoordinate() + " width=" + this.getWidth() + " height=" + this.getHeight() + "\n";
  } // End toString() function
 
  /**
   * Checks whether two buttons are equal.
   * @return whether two buttons are equal.
   */
  public boolean equals(Button otherButton) {
    return (this.getLabel() == otherButton.getLabel() && this.getXCoordinate() == otherButton.getXCoordinate() && this.getYCoordinate() == otherButton.getYCoordinate() && this.getHeight() == otherButton.getHeight() && this.getWidth() == otherButton.getWidth());
  } // End equals(...) function
}
