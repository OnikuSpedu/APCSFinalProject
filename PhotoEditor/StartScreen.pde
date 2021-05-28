class StartScreen extends Screen {

  ArrayList<UiElement> elements;
  PImage logo;
  
  StartScreen() {
    elements = new ArrayList<UiElement>();

    CreateCanvas createCanvas = new CreateCanvas();

    elements.add(createCanvas);
    
    logo = loadImage("Phixel.png");
  }


  void display() {
    background(DARK4);
    image(logo, width/2-logo.width/2, 64);
    textAlign(CENTER);
    textSize(16);
    fill(color(240));
    text("To get started, either create a new canvas or upload an image", width / 2,196);
    text("By Shadman Rakib & Rickey Dong", width / 2,height-16-36); 
    
    for (UiElement e : elements) {
      e.display();
    }
  }

  void click() {
    for (UiElement e : elements) {
      e.click();
    }
  }
  
  class CreateCanvas extends UiElement {
    float x, y, w, h;
    
    CreateButton createBtn;
    WidthButton widthBtn;
    HeightButton heightBtn;

    ArrayList<Button> buttons;
    
    CreateCanvas() {
      x = 286;
      y = 257;
      w = 369;
      h = 396;
      
     buttons = new ArrayList<Button>();
     
     createBtn = new CreateButton();
     widthBtn = new WidthButton();
     heightBtn = new HeightButton();
     
     buttons.add(createBtn);
     buttons.add(widthBtn);
     buttons.add(heightBtn);
    }
    
    void display() {
      noStroke();
      fill(DARK3);
      rect(x, y, w, h);
      
      textAlign(LEFT, TOP);
      textSize(18);
      fill(color(240));
      text("Create a Canvas", 312,293);
      textSize(16);
      text("Width:", 312,362);
      text("Height:", 312,423);
      
      for (Button button : buttons) {
         button.display(); 
      }
    }
    
    void click() {
      if(mouseX >= x && mouseX < x + w && mouseY >= y && mouseY < y + h) {
        for (Button button : buttons) {
         button.click(); 
        }
      }
    }
    
    class CreateButton extends Button {
      CreateButton() {
        super("Create", 317, 572, 307, 48,PRIMARY, color(255));
      }
      void click() {
        if(mouseX >= super.x && mouseX < super.x + super.w && mouseY >= super.y && mouseY < super.y + super.h) {
          //Add Create Processing
          scene++;
        }
      }
    }
    
    class WidthButton extends Button {
      WidthButton() {
        super(Integer.toString(canvasWidth), 378, 350, 132, 40, DARK2, color(255));
      }
      void click() {
        if(mouseX >= super.x && mouseX < super.x + super.w && mouseY >= super.y && mouseY < super.y + super.h) {
          //Add Create Processing
          String inputWidth = booster.showTextInputDialog("Width:");
          
          try {
            canvasWidth = Integer.parseInt(inputWidth);
            super.label = inputWidth;
          } catch (Exception e) {
            e.printStackTrace();
          }
        }
      }
    }
    
    class HeightButton extends Button {
      HeightButton() {
        super(Integer.toString(canvasHeight), 378, 411, 132, 40, DARK2, color(255));
      }
      void click() {
        if(mouseX >= super.x && mouseX < super.x + super.w && mouseY >= super.y && mouseY < super.y + super.h) {
          //Add Create Processing
          String inputHeight = booster.showTextInputDialog("Height:");
          
          try {
            canvasHeight = Integer.parseInt(inputHeight);
            super.label = inputHeight;
          } catch (Exception e) {
            e.printStackTrace();
          }
        }
      }
    }
  }
}
