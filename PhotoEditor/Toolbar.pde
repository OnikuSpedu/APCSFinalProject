class Toolbar extends UiElement {
  private int x, y, w, h;
  private color c;
  
  Toolbar() { 
    x = 0;
    y = 0;
    w = 1366;
    h = 64;
    c = DARK2;
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
