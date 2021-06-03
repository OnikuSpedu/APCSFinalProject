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
  class Sidebar extends UiElement {
    private float x, y, w, h;
    private color c;
    private String confirmation;
    
    Sidebar() { 
      x = 1006;
      y = 64;
      w = 360;
      h = 704;
      c = DARK3;
      confirmation = "Is this the image you want to save?";
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
      textAlign(LEFT);
      textSize(20);
      fill(color(255));
      text(confirmation, 1030, 301);
    }
  }
  class YesButton extends Button {
    YesButton() {
      super("YES", 1048, 367, 117, 34,color(0,255,0), color(255));
    }
    
    void click() {
      if(mouseX >= super.x && mouseX < super.x + super.w && mouseY >= super.y && mouseY < super.y + super.h) {
        String fileName = booster.showTextInputDialog("What would you like this photo to be named? Also include the file extension name. This will be saved within the gallery/ directory within this sketch.");
        stagedPhoto.save("gallery/"+fileName);
        exit();
      }
    }
  }
}
