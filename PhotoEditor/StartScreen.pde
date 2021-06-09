class StartScreen extends Screen {

  PImage logo, bgPhoto;
  
  StartScreen() {
    elements = new ArrayList<UiElement>();

    CreateCanvas createCanvas = new CreateCanvas();
    ImportCanvas importCanvas = new ImportCanvas();

    super.elements.add(createCanvas);
    super.elements.add(importCanvas);


    logo = loadImage("Phixel.png");    
  }


  void display() {
    super.display();
    //image(bgPhoto, 0, 0);
    image(logo, width/2-logo.width/2, 64);
    textAlign(CENTER);
    textSize(16);
    fill(color(240));
    text("To get started, either create a new canvas or upload an image", width / 2,196);
    text("By Shadman Rakib & Rickey Dong", width / 2,height-16-36); 
  }
  
  class CreateCanvas extends UiElement {   
    ArrayList<Button> buttons;
    
    CreateCanvas() {
      super(286, 257, 369, 396, DARK3);
      
      buttons = new ArrayList<Button>();
     
     buttons.add(new CreateButton());
     buttons.add(new WidthButton());
     buttons.add(new HeightButton());
    }
    
    void display() {
      super.display();
      
      textAlign(LEFT, TOP);
      textSize(20);
      fill(color(240));
      text("Create A Canvas", super.x+36,super.y+36);
      textSize(16);
      text("Width:",super.x+36,362);
      text("Height:", super.x+36,423);
      
      for (Button button : buttons) {
         button.display(); 
      }
    }
    
    void pressed() {
      if(super.isHovering()) {
        for (Button button : buttons) {
         button.pressed(); 
        }
      }
    }
    
    class CreateButton extends Button {
      CreateButton() {
        super("Create", 286+36, 257+396-48-36, 369-36-36, 48,PRIMARY, color(255));
      }
      void pressed() {
        if(super.isHovering()) {
          canvas = new Canvas(canvasWidth, canvasHeight);
          scene++;
        }
      }
    }
    
    class WidthButton extends Button {
      WidthButton() {
        super(Integer.toString(canvasWidth), 286+100, 350, 132, 40, DARK2, color(255));
      }
      void pressed() {
        if(super.isHovering()) {

          String inputWidth = booster.showTextInputDialog("Width:");
          
          try {
            Integer parsedInput = Integer.parseInt(inputWidth);
            if(parsedInput > 0 && parsedInput <= 650) {
              canvasWidth = parsedInput;
              super.label = inputWidth;
            } else {
               booster.showErrorDialog("Width must be between 1 and 650 inclusive.", "ERROR");  
            }
          } catch (Exception e) {
            booster.showErrorDialog("Width must be between 1 and 650 inclusive.", "ERROR");  
            e.printStackTrace();
          }
        }
      }
    }
    
    class HeightButton extends Button {
      HeightButton() {
        super(Integer.toString(canvasHeight), 286+100, 411, 132, 40, DARK2, color(255));
      }
      void pressed() {
        if(super.isHovering()) {

          String inputHeight = booster.showTextInputDialog("Height:");
          
          try {
            Integer parsedInput = Integer.parseInt(inputHeight);
            if(parsedInput > 0 && parsedInput <= 650) {
              canvasWidth = parsedInput;
              super.label = inputHeight;
            } else {
               booster.showErrorDialog("Height must be between 1 and 650 inclusive.", "ERROR");  
            }
          } catch (Exception e) {
            booster.showErrorDialog("Height must be between 1 and 650 inclusive.", "ERROR");  
            e.printStackTrace();
          }
        }
      }
    }
  }
  
  class ImportCanvas extends UiElement {    
    ImportButton importBtn;
    UploadButton uploadBtn;

    String pathToSelectedFile;
    
    ArrayList<Button> buttons;
    
    ImportCanvas() {
      super(710,257,369,396, DARK3);
     
      pathToSelectedFile = "";
      
       buttons = new ArrayList<Button>();
     
       importBtn = new ImportButton();
       uploadBtn = new UploadButton();
     
       buttons.add(importBtn);
       buttons.add(uploadBtn);
    }
    
    void display() {
      super.display();
      
      textAlign(LEFT, TOP);
      textSize(20);
      fill(color(240));
      text("Import An Image", 710+36,293);
      
      for (Button button : buttons) {
         button.display(); 
      }
    }
    
    void pressed() {
      if(super.isHovering()) {
        for (Button button : buttons) {
         button.pressed(); 
        }
      }
    }
    
    class ImportButton extends Button {
      ImportButton() {
        super("Import", 710+36, 257+396-36-48, 369-72, 48,PRIMARY, color(255));
      }
      void pressed() {
        if(super.isHovering()) {
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
        super("Upload An Image", 710+36, 350, 369-72, 100, DARK2, color(255));
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
      
      void pressed() {
        if(super.isHovering()) {

          File selected = booster.showFileSelection();
          
          if (selected != null) {
            pathToSelectedFile = selected.getAbsolutePath();
            if (pathToSelectedFile.toLowerCase().endsWith(".jpg") || pathToSelectedFile.toLowerCase().endsWith(".png") || pathToSelectedFile.toLowerCase().endsWith(".tga") || pathToSelectedFile.toLowerCase().endsWith(".gif")) {
                          
              thumbnail = loadImage(pathToSelectedFile);
              
              if (thumbnail.height > 150) {
                thumbnail.resize((int) ((float) thumbnail.width * ( 150.0 / thumbnail.height )), 150);
              } 
              
              if (thumbnail.width > 369-72) {
                thumbnail.resize((int) (369-72), (int)  ((float) thumbnail.height * ( (369-72) / thumbnail.width )));
              }
            
            }
            
          }
        }
      }
    }
  }
}
