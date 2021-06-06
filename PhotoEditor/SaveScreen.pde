class SaveScreen extends Screen {
  ArrayList<UiElement> elements;
  
  SaveScreen() {
    elements = new ArrayList<UiElement>();
    Navbar navbar = new Navbar();
    Sidebar sidebar = new Sidebar();
    elements.add(navbar);
    elements.add(sidebar);
  }
  
  void display() {
    background(DARK4);
    for (UiElement e : elements) {
        e.display();
    }
    if (stagedPhoto != null) {
      image(stagedPhoto, (1006-stagedPhoto.width)/2, (704-stagedPhoto.height)/2 + 64);
    }
  }
  void clicked() {
    for (UiElement e : elements) {
      e.clicked();
    }
  }
  class Navbar extends UiElement {
    
    Navbar() { 
      super(0,0,1366,64,DARK2);
    }
    
    void clicked() {
      if(super.isHovering()) {
         println("Navbar clicked"); 
      }
    }
  }
  
  class Sidebar extends UiElement {
    private String confirmation;
    private YesButton yesBtn;
    private NoButton noBtn;
    
    Sidebar() { 
      super(1006, 64, 360, 704, DARK3);
      
      confirmation = "Is this the image you want to save?";
      yesBtn = new YesButton();
      noBtn = new NoButton();
    }
    
    void clicked() {
      if(super.isHovering()) {
         println("Sidebar clicked");
         yesBtn.clicked();
         noBtn.clicked();
      }
    }
    
    void display() {
      super.display();
      
      textAlign(CENTER);
      textSize(18);
      fill(color(255));
      text(confirmation, 1186, 313);
      yesBtn.display();
      noBtn.display();
    }
  }
  class YesButton extends Button {
    YesButton() {
      super("YES", 1048, 367, 117, 34, color(0,255,0), color(255));
    }
    
    void clicked() {
      if(super.isHovering()) {
        String fileName = booster.showTextInputDialog("What would you like this photo to be named? Also include the file extension name. This will be saved within the gallery/ directory within this sketch.");
        stagedPhoto.save("gallery/"+fileName);
        exit();
      }
    }
  }
  class NoButton extends Button {
    NoButton() {
      super("NO", 1207, 367, 117, 34, color(255,0,0), color(255));
    }
    
    void clicked() {
      if(super.isHovering()) {
        scene--;
      }
    }
  }
}
