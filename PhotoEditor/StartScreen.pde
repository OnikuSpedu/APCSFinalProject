class StartScreen extends Screen {

  ArrayList<UiElement> elements;
  PImage logo;
  
  ContinueButton testBtn = new ContinueButton();

  StartScreen() {
    elements = new ArrayList<UiElement>();
    elements.add(testBtn);
    
    logo = loadImage("Phixel.png");
  }


  void display() {
    background(DARK4);
    image(logo, 0, 0);
    for (UiElement e : elements) {
      e.display();
    }
  }

  void click() {
    for (UiElement e : elements) {
      e.click();
    }
  }
  
  
  class ContinueButton extends Button {
    ContinueButton() {
      super("Continue", 0, 0, 100, 40,PRIMARY, color(255));
    }
    
    void click() {
      if(mouseX >= super.x && mouseX < super.x + super.w && mouseY >= super.y && mouseY < super.y + super.h) {
        scene++;
      }
    }
    
    
  }
}
