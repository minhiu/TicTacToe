// Button

/**A Button class that outlines info about a button.
   Homework Assignment: Percussion
   @author Sean Masterson, Alex Banh, Hieu Pham, and Brandon Walker
   @version 1.0 10/3/2019
  */
 
public class Button
{
  /**
   The Button's x coordinate.
  */
  private int x;
  /**
   The Button's y coordinate.
  */
  private int y;
  /**
   The Button's width.
  */
  private int w;
  /**
   The Button's height.
  */
  private int h;
  /**
   The Button's sound.
  */
  private String label;
 
  /**
   * Default Button constructor.
   * Sets all integers to 0.
   */
  public Button() {
  this.setX(0);
  this.setY(0);
  this.setW(0);
  this.setH(0);
  } // End Button() function (default constructor)
 
  /**
   * Overloaded Button constructor.
   * Sets all member variables to arguments.
   * @param newX new x coordinate of the Button.
   * @param newY new y coordinate of the Button.
   * @param newW new width of the Button.
   * @param newH new height of the Button.
   * @param newSound new sound of the Button.
   * @param newLabel new Button label.
   */
  public Button(int newX, int newY, int newW, int newH, String newLabel) {
  this.setX(newX);
  this.setY(newY);
  this.setW(newW);
  this.setH(newH);
  this.setLabel(newLabel);
  } // End Button(...) function (overloaded constructor)
 
 /**
   * Checks if input arguments is a coordinate that's within the Button's area.
   * Sets all member variables to arguments.
   * @param mx x coordinate to check if it's inside button area.
   * @param my y coordinate to check if it's inside button area.
   * @return whether the coordinates is inside the button area
   */
  public boolean isInside(int mx, int my) {
  return ((mx >= this.getX() && mx <= this.getX() + this.getW()) && (my >= this.getY() && my <= this.getY() + this.getH()));
  } // End isInside(...) function
 
 /**
   * Displays the button with the coordinates and size as determined
   * by member variables.
   */
  public void display() {
  rect(this.getX(), this.getY(), this.getW(), this.getH());
  text(this.getLabel(), this.getX(), this.getY());
  } // End display() function
 
  /**
   * Gets Button's x coordinate.
   * @return Button's x coordinate.
   */
  public int getX() {
  return this.x;
  } // End getX() function
 
  /**
   * Gets Button's y coordinate.
   * @return Button's y coordinate.
   */
  public int getY() {
  return this.y;
  } // End getY() function
 
  /**
   * Gets Button's width.
   * @return Button's width.
   */
  public int getW() {
  return this.w;
  } // End getW() function
 
  /**
   * Gets Button's height.
   * @return Button's height.
   */
  public int getH() {
  return this.h;
  } // End getH() function
 
  /**
   * Gets Button's label.
   * @return Button's label.
   */
  public String getLabel() {
  return this.label;
  } // End getLabel() function
 
  /**
   * Sets Button's x coordinate.
   * @param newX Button's x coordinate.
   */
  public void setX(int newX) {
   this.x = newX;
  } // End setX(...) function
 
  /**
   * Sets Button's y coordinate.
   * @param newY Button's y coordinate.
   */
  public void setY(int newY) {
   this.y = newY;
  } // End setY(...) function
 
  /**
   * Sets Button's width.
   * @param newW Button's width.
   */
  public void setW(int newW) {
   this.w = newW;
  } // End setW(...) function
 
  /**
   * Sets Button's height.
   * @param newH Button's height.
   */
  public void setH(int newH) {
   this.h = newH;
  } // End setH(...) function
 
  /**
   * Sets Button's label.
   * @param newLabel Button's label.
   */
  public void setLabel(String newLabel) {
   this.label = newLabel;
  } // End setLabel(...) function
 
  /**
   * Returns String with info about the Button.
   * @return String with info about the Button.
   */
  public String toString() {
  return this.getLabel() + " x=" + this.getX() + " y=" + this.getY() + " width=" + this.getW() + " height=" + this.getH();
  } // End toString() function
 
  /**
   * Checks whether two buttons are equal.
   * @return whether two buttons are equal.
   */
  public boolean equals(Button otherButton) {
  return (this.getLabel() == otherButton.getLabel() && this.getX() == otherButton.getX() && this.getY() == otherButton.getY() && this.getH() == otherButton.getH() && this.getW() == otherButton.getW());
  } // End equals(...) function
}
