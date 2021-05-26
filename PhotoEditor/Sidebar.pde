class Sidebar extends UiElement {
  private int x, y, w, h;
  private color c;
  
  Sidebar() { 
    x = 1006;
    y = 64;
    w = 360;
    h = 704;
    c = DARK3;
  }
  
  void click() {
    if(mouseX >= x && mouseX < x + w && mouseY >= 0 && mouseY < y + h) {
       println("Clicked"); 
    }
  }
  
  void display() {
    fill(c);
    noStroke();
    rect(x, y, w, h);
  }
}
