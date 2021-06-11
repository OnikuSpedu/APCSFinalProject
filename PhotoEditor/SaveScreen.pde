class SaveScreen extends Screen {
  
  SaveScreen() {
    elements = new ArrayList<UiElement>();
    Navbar navbar = new Navbar();
    Sidebar sidebar = new Sidebar();
    super.getElements().add(navbar);
    super.getElements().add(sidebar);
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
    
    void pressed() {
      if(super.isHovering()) {
         println("Sidebar clicked");
         yesBtn.pressed();
         noBtn.pressed();
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
    
    void pressed() {
      if(super.isHovering()) {
        String fileName = booster.showTextInputDialog("File Name: (Include the file extension name)");
        if (fileName != null && (fileName.endsWith(".jpg") || fileName.endsWith(".png") || fileName.endsWith(".tga") || fileName.endsWith(".gif"))) {
          stagedPhoto.save("gallery/"+fileName);
          booster.showInfoDialog("Saved! Going to exit now");
          exit();
        } else {
          booster.showErrorDialog("You must provide a file name including the file extension. The file extensions supported are jpg, png, tga, and gif. \nExample: savedPicture.png", "ERROR");
        }
      }
    }
  }
  class NoButton extends Button {
    NoButton() {
      super("NO", 1207, 367, 117, 34, color(255,0,0), color(255));
    }
    
    void pressed() {
      if(super.isHovering()) {
        scene--;
      }
    }
  }
}
