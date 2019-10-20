public class Player {
  
  private States xo;
  
  public Player() {
  }
  
  public void assignXO() {
   this.setXO(States.X); 
  }
  
  private void setXO(States nXO) {
    this.xo = nXO;
  }
  
  public States getXO() {
    return this.xo;
  }
}
