class EditorScreen extends Screen {

ArrayList<UiElement> elements;

EditorScreen() {
  elements = new ArrayList<UiElement>();
  Toolbar toolbar = new Toolbar();
  Sidebar sidebar = new Sidebar();
  elements.add(toolbar);
  elements.add(sidebar);
}

void display() {
  background(DARK4);
  for (UiElement e : elements) {
      e.display();
  }
}

void click() {
    for (UiElement e : elements) {
      e.click();
    }
    }
    class Sidebar extends UiElement {
  private float x, y, w, h;
  private color c;
  
  Sidebar() { 
    x = 1006;
    y = 64;
    w = 360;
    h = 704;
    c = DARK3;
  }
  
  void click() {
    if(mouseX >= x && mouseX < x + w && mouseY >= y && mouseY < y + h) {
       println("Sidebar clicked"); 
    }
  }
  
  void display() {
    fill(c);
    noStroke();
    rect(x, y, w, h);
  }
}
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
    image(imageToBeEdited, (1006-imageToBeEdited.width)/2, (704-imageToBeEdited.height)/2 + 64);
  }
  
  class TestButton extends Button {
    TestButton() {
      super("Back", 12, 12, 100, 40,DARK1, color(255));
    }
    
    void click() {
      if(mouseX >= super.x && mouseX < super.x + super.w && mouseY >= super.y && mouseY < super.y + super.h) {
        scene--;
      }
    }
    
    
  }
}
}
