class SaveScreen extends Screen {
  ArrayList<UiElement> elements;
  
  SaveScreen() {
    elements = new ArrayList<UiElement>();
    Toolbar toolbar = new Toolbar();
    Sidebar sidebar = new Sidebar();
    elements.add(toolbar);
    elements.add(sidebar);
  }
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
      if(mouseX >= x && mouseX < x + w && mouseY >= y && mouseY < y + h) {
         println("Toolbar clicked"); 
      }
    }
    
    void display() {
      fill(c);
      noStroke();
      rect(x, y, w, h);
    }
  }
}
