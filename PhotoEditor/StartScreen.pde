class StartScreen extends Screen {

  ArrayList<UiElement> elements;
  PImage logo, bgPhoto;
  
  StartScreen() {
    elements = new ArrayList<UiElement>();

    CreateCanvas createCanvas = new CreateCanvas();
    ImportCanvas importCanvas = new ImportCanvas();

    elements.add(createCanvas);
    elements.add(importCanvas);


    logo = loadImage("Phixel.png");
    bgPhoto = loadImage("dark-theme-background-0.jpg");
    
    bgPhoto.resize(width,height);
  }


  void display() {
    background(DARK4);
    //image(bgPhoto, 0, 0);
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

  void clicked() {
    for (UiElement e : elements) {
      e.clicked();
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
      textSize(20);
      fill(color(240));
      text("Create A Canvas", x+36,y+36);
      textSize(16);
      text("Width:", x+36,362);
      text("Height:", x+36,423);
      
      for (Button button : buttons) {
         button.display(); 
      }
    }
    
    void clicked() {
      if(mouseX >= x && mouseX < x + w && mouseY >= y && mouseY < y + h) {
        for (Button button : buttons) {
         button.clicked(); 
        }
      }
    }
    
    class CreateButton extends Button {
      CreateButton() {
        super("Create", x+36, y+h-48-36, w-36-36, 48,PRIMARY, color(255));
      }
      void clicked() {
        if(mouseX >= super.x && mouseX < super.x + super.w && mouseY >= super.y && mouseY < super.y + super.h) {
          canvas = new Canvas(canvasWidth, canvasHeight);
          scene++;
        }
      }
    }
    
    class WidthButton extends Button {
      WidthButton() {
        super(Integer.toString(canvasWidth), x+100, 350, 132, 40, DARK2, color(255));
      }
      void clicked() {
        if(mouseX >= super.x && mouseX < super.x + super.w && mouseY >= super.y && mouseY < super.y + super.h) {

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
        super(Integer.toString(canvasHeight), x+100, 411, 132, 40, DARK2, color(255));
      }
      void clicked() {
        if(mouseX >= super.x && mouseX < super.x + super.w && mouseY >= super.y && mouseY < super.y + super.h) {

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
  
  class ImportCanvas extends UiElement {
    float x, y, w, h;
    
    ImportButton importBtn;
    UploadButton uploadBtn;

    String pathToSelectedFile;
    
    ArrayList<Button> buttons;
    
    ImportCanvas() {
      x = 710;
      y = 257;
      w = 369;
      h = 396;
     
      pathToSelectedFile = "";
      
       buttons = new ArrayList<Button>();
     
       importBtn = new ImportButton();
       uploadBtn = new UploadButton();
     
       buttons.add(importBtn);
       buttons.add(uploadBtn);
    }
    
    void display() {
      noStroke();
      fill(DARK3);
      rect(x, y, w, h);
      
      textAlign(LEFT, TOP);
      textSize(20);
      fill(color(240));
      text("Import An Image", x+36,293);
      
      for (Button button : buttons) {
         button.display(); 
      }
    }
    
    void clicked() {
      if(mouseX >= x && mouseX < x + w && mouseY >= y && mouseY < y + h) {
        for (Button button : buttons) {
         button.clicked(); 
        }
      }
    }
    
    class ImportButton extends Button {
      ImportButton() {
        super("Import", x+36, y+h-36-48, w-72, 48,PRIMARY, color(255));
      }
      void clicked() {
        if(mouseX >= super.x && mouseX < super.x + super.w && mouseY >= super.y && mouseY < super.y + super.h) {
          if(!pathToSelectedFile.equals("") && ((pathToSelectedFile.toLowerCase().endsWith(".jpg") || pathToSelectedFile.toLowerCase().endsWith(".png") || pathToSelectedFile.toLowerCase().endsWith(".tga") || pathToSelectedFile.toLowerCase().endsWith(".gif")))) {
             PImage selectedImage = loadImage(pathToSelectedFile);
             canvas = new Canvas(selectedImage);
             scene++;
          }
        }
      }
    }
    
    class UploadButton extends Button {
      PImage thumbnail;
      UploadButton() {
        super("Upload An Image", x+36, 350, w-72, 100, DARK2, color(255));
      }
      
      void display() {
        if (pathToSelectedFile != null && !pathToSelectedFile.equals("")) {
          super.y = 520;
          super.h = 40;
          super.label = "Replace Image";
          
          if (thumbnail != null && thumbnail.width > 0 && thumbnail.height > 0) {
              image(thumbnail, x+36, 330);
          }
          
        } else {
          super.label = "Upload An Image";
          super.y = 350;
          super.h = 100;
        }
        
        super.display();
      }
      
      void clicked() {
        if(mouseX >= super.x && mouseX < super.x + super.w && mouseY >= super.y && mouseY < super.y + super.h) {

          File selected = booster.showFileSelection();
          
          if (selected != null) {
            pathToSelectedFile = selected.getAbsolutePath();
            if (pathToSelectedFile.toLowerCase().endsWith(".jpg") || pathToSelectedFile.toLowerCase().endsWith(".png") || pathToSelectedFile.toLowerCase().endsWith(".tga") || pathToSelectedFile.toLowerCase().endsWith(".gif")) {
                          
              thumbnail = loadImage(pathToSelectedFile);
              
              if (thumbnail.height > 150) {
                thumbnail.resize((int) ((float) thumbnail.width * ( 150.0 / thumbnail.height )), 150);
              } 
              
              if (thumbnail.width > w-72) {
                thumbnail.resize((int) (w-72), (int)  ((float) thumbnail.height * ( (w-72) / thumbnail.width )));
              }
            
            }
            
        }

        }
      }
    }
  }
}
