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
  if (canvas != null) {
     canvas.display(); 
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
  
  AddLayerButton addLayerBtn;
  ImportLayerButton importLayerBtn;
  
  Sidebar() { 
    x = 1006;
    y = 64;
    w = 360;
    h = 704;
    c = DARK3;
    
    addLayerBtn = new AddLayerButton();
    importLayerBtn = new ImportLayerButton();
  }
  
  void click() {
    if(mouseX >= x && mouseX < x + w && mouseY >= y && mouseY < y + h) {
       println("Sidebar clicked"); 
       addLayerBtn.click();
       importLayerBtn.click();
    }
  }
  
  void display() {
    fill(c);
    noStroke();
    rect(x, y, w, h);
    
    addLayerBtn.display();
    importLayerBtn.display();
  }
  
  class ImportLayerButton extends Button {
      ImportLayerButton() {
        super("Import Layer", x+(w-48)/2+32, y+h-16-40, (w-48)/2, 40,DARK2, color(255));
      }
      void click() {
        if(mouseX >= super.x && mouseX < super.x + super.w && mouseY >= super.y && mouseY < super.y + super.h) {
          File selected = booster.showFileSelection();
          
          if (selected != null) {
            String pathToSelectedFile = selected.getAbsolutePath();
            if (pathToSelectedFile.toLowerCase().endsWith(".jpg") || pathToSelectedFile.toLowerCase().endsWith(".png") || pathToSelectedFile.toLowerCase().endsWith(".tga") || pathToSelectedFile.toLowerCase().endsWith(".gif")) {
              if (canvas != null) {
                PImage img = loadImage(pathToSelectedFile);
                canvas.addLayer(img);
              }          
            }
        }
      }
    }
  }
    
    class AddLayerButton extends Button {
      AddLayerButton() {
        super("Add Layer", x+16, y+h-16-40, (w-48)/2, 40,PRIMARY, color(255));
      }
      void click() {
        if(mouseX >= super.x && mouseX < super.x + super.w && mouseY >= super.y && mouseY < super.y + super.h) {
          if (canvas != null) {
            canvas.addLayer();
          }
        }
      }
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
    ContinueButton cont = new ContinueButton();
    toolbarButtons.add(testBtn);
    toolbarButtons.add(cont);
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
      super("Back", 12, 12, 100, 40,DARK1, color(255));
    }
    
    void click() {
      if(mouseX >= super.x && mouseX < super.x + super.w && mouseY >= super.y && mouseY < super.y + super.h) {
        scene--;
      }
    }
    
    
  }
  class ContinueButton extends Button {
    ContinueButton() {
      super("Continue", 1230, 17, 117, 31, PRIMARY, color(255));
    }
    void click() {
      if(mouseX >= super.x && mouseX < super.x + super.w && mouseY >= super.y && mouseY < super.y + super.h) {
        scene++;
      }
    }
  }
}
}
