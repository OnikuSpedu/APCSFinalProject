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
    
    LayersOptions layersOptions;
    
    Sidebar() { 
      x = 1006;
      y = 64;
      w = 360;
      h = 704;
      c = DARK3;
      
      layersOptions = new LayersOptions();
    }
    
    void click() {
      if(mouseX >= x && mouseX < x + w && mouseY >= y && mouseY < y + h) {
        println("Sidebar clicked"); 
        layersOptions.click();
      }
    }
    
    void display() {
      fill(c);
      noStroke();
      rect(x, y, w, h);
      
      layersOptions.display();
    }    
      
    class LayersOptions {
      
      AddLayerButton addLayerBtn;
      ImportLayerButton importLayerBtn;
      ArrayList<LayerOptionCard> layerOptionCards;

      int layerSelected = 0;

      private float x, y, w, h;
      private color c;
        
      LayersOptions() {
        addLayerBtn = new AddLayerButton();
        importLayerBtn = new ImportLayerButton(); 
        
        x = 1006;
        y =  348;
        w = 360;
        h = 420;

        c = DARK3;
        
        layerOptionCards = new ArrayList<LayerOptionCard>(10); 
        
        for (int i = 0; i < 10; i++) {
          layerOptionCards.add(new LayerOptionCard(i));
        }

      }
    
      void click() {
        if(mouseX >= x && mouseX < x + w && mouseY >= y && mouseY < y + h) {
          println("Sidebar clicked"); 
          addLayerBtn.click();
          importLayerBtn.click();
        }
      }
    
      void display() {
        addLayerBtn.display();
        importLayerBtn.display();
                
        for (int i = 0; i < canvas.layers.size(); i++) {
          layerOptionCards.get(i).display();
        }
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

      class LayerOptionCard {
        private float x, y, w, h;
        private color c;
        private int index;

        LayerOptionCard(int index) {
          addLayerBtn = new AddLayerButton();
          importLayerBtn = new ImportLayerButton(); 

          x = 1026;
          y =  398 + index * 50;
          w = 321;
          h = 50;

          this.index = index;

          c = DARK2;
        }
        
        void display() {
          Layer layer = canvas.layers.get(index);

          fill(c);
          stroke(DARK3);
          rect(x, y, w, h);

          if (layer.selected) {
            fill(PRIMARY);
          } else {
            fill(DARK1);
          }

          ellipseMode(CENTER);
          ellipse(x + 14, y + 18, 15, 15);

          textAlign(LEFT, TOP);
          textSize(14);
          fill(color(240));
          text(layer.name, x+16, y+16);
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
