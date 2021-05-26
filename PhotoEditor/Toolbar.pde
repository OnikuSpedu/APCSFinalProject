class Toolbar extends UiElement {
  private int x, y, w, h;
  private color c;
  private ArrayList<Button> toolbarButtons = new ArrayList<Button>();
  
  Toolbar() { 
    x = 0;
    y = 0;
    w = 1366;
    h = 64;
    c = DARK2;
    
    TestButton testBtn = new TestButton();
    
    toolbarButtons.add(testBtn);
  }
  
  void click() {
    if(mouseX >= x && mouseX < x + w && mouseY >= y && mouseY < y + h) {
       println("Toolbar clicked"); 
       
       for(Button b : toolbarButtons) {
          b.click(); 
       }
    }
  }
  
  void display() {
    fill(c);
    noStroke();
    rect(x, y, w, h);
    
    for(Button b : toolbarButtons) {
          b.display(); 
    }
  }
  
  class TestButton extends Button {
    TestButton() {
      super("Test", 0, 0, 40, 100,PRIMARY, color(255));
    }
    
    void click() {
      if(mouseX >= super.x && mouseX < super.x + super.w && mouseY >= super.y && mouseY < super.y + super.h) {
        println(super.label);
      }
    }
    
    
  }
}
