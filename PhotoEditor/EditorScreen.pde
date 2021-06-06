class EditorScreen extends Screen {
  
  //Create variables for draw tools
  DrawTool drawTool;
  MoveTool moveTool;

  EditorScreen() {    
    Navbar navbar = new Navbar();
    Sidebar sidebar = new Sidebar();
    
    super.elements.add(navbar);
    super.elements.add(sidebar);
    
    drawTool = new DrawTool();
    moveTool = new MoveTool();
  }

  void display() {
    super.display();
    
    if (canvas != null) {
      canvas.display(); 
    }
  }
      
  class Sidebar extends UiElement {

    LayersOptions layersOptions;
    //ColorPicker colorPicker;
    
    ArrayList<UiElement> elements;
    
    Sidebar() { 
      super(1006, 64, 360, 704, DARK3);
      
      elements = new ArrayList<UiElement>();
      
      layersOptions = new LayersOptions();
      elements.add(layersOptions);

      //colorPicker = new ColorPicker();
      //elements.add(colorPicker);
    }
    
    void clicked() {
      if(super.isHovering()) {
        for( UiElement e : elements) {
          e.clicked();
        }
      }
    }
    
    void display() {
      super.display();
      
      for( UiElement e : elements) {
          e.display();
      }
    }    
      
    class LayersOptions extends UiElement {
      
      ArrayList<LayerOptionCard> layerOptionCards;

      AddLayerButton addLayerBtn;
      ImportLayerButton importLayerBtn;

      int layerSelected = 0;

      LayersOptions() {
        super(1006, 348, 360, 420, DARK3);
        
        addLayerBtn = new AddLayerButton();
        importLayerBtn = new ImportLayerButton(); 

        layerOptionCards = new ArrayList<LayerOptionCard>(7); 
        
        for (int i = 0; i < 7; i++) {
          layerOptionCards.add(new LayerOptionCard(i));
        }

      }
    
      void clicked() {
        if(super.isHovering()) {          
          addLayerBtn.clicked();
          importLayerBtn.clicked();

          for (int i = 0; i < canvas.layers.size(); i++) {
            layerOptionCards.get(i).clicked();
          }
        }
      }
    
      void display() {
        addLayerBtn.display();
        importLayerBtn.display();
        
        textAlign(LEFT, TOP);
        textSize(16);
        fill(color(240));
        text("Layer(s)", 1026, y + 16);

        for (int i = 0; i < canvas.layers.size(); i++) {
          layerOptionCards.get(i).display();
        }
      } 
    
      class ImportLayerButton extends Button {
          ImportLayerButton() {
            super("Import", 1277, 359, 69, 32, DARK2, color(255));
          }
          void clicked() {
            if(super.isHovering()) {
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
          super("Add", 1208, 359, 59, 32,PRIMARY, color(255));
        }
        void clicked() {
          if(mouseX >= super.x && mouseX < super.x + super.w && mouseY >= super.y && mouseY < super.y + super.h) {
            if (canvas != null) {
              canvas.addLayer();
            }
          }
        }
      }

      class LayerOptionCard extends UiElement{
        private int index;

        LayerOptionCard(int index) {
          super(1026, 398 + index * 50,321, 50, DARK2);
          this.index = index;

          addLayerBtn = new AddLayerButton();
          importLayerBtn = new ImportLayerButton(); 
        }
        
        void display() {
          super.display();
          Layer layer = canvas.layers.get(index);

          if (layer.selected) {
            fill(PRIMARY);
          } else {
            fill(DARK1);
          }
          
          noStroke();
          ellipseMode(LEFT);
          ellipse(x + 16, y + 18, 16, 16);

          textAlign(LEFT, TOP);
          textSize(14);
          fill(color(240));
          text(layer.name, x+ 32 + 8, y + 16);
        }

        void clicked() {
          Layer layer = canvas.layers.get(index);
          
          if(mouseX >= x + 16 && mouseX < x + 16 + 16 && mouseY >= y + 18 && mouseY < y + 16 + 18) {
            layer.selected = !layer.selected;
            println("Toggled");
          }

          if(mouseX >= x + 32 + 8 && mouseX < x + 32 + + 8 + textWidth(layer.name) && mouseY >= y + 16 && mouseY < y + 16 + 16) {
            layer.name = booster.showTextInputDialog("Layer name:");
          }
        }
      }
    }
  }

  class Navbar extends UiElement {

    private ArrayList<Button> navButtons = new ArrayList<Button>();
    Toolbar toolbar = new Toolbar();
    
    Navbar() { 
      super(0, 0, 1366, 64, DARK2);
      
      navButtons.add(new BackButton());
      navButtons.add(new ContinueButton());
    }
    
    void clicked() {
      if(super.isHovering()) {
        for(Button b : navButtons) {
          b.clicked(); 
        }
      }
    }
    
    void display() {
      super.display();
      
      for(Button b : navButtons) {
        b.display(); 
      }
    }
    
    class BackButton extends Button {
      BackButton() {
        super("Back", 12, 12, 100, 40,DARK1, color(255));
      }
      
      void clicked() {
        if(mouseX >= super.x && mouseX < super.x + super.w && mouseY >= super.y && mouseY < super.y + super.h) {
          scene--;
        }
      }      
    }
    
    class ContinueButton extends Button {
      ContinueButton() {
        super("Continue", 1230, 17, 117, 31, PRIMARY, color(255));
      }
      void clicked() {
        if(mouseX >= super.x && mouseX < super.x + super.w && mouseY >= super.y && mouseY < super.y + super.h) {
          scene++;
        }
      }
    }
    
    class Toolbar extends UiElement {
      
      Toolbar() {
        super(300, 17, 117, 32, DARK1);
      }
      
      void display() {
        super.display();
      }
    }
  }
}

/* class ToolOptions {
      
      private int toolSelected = 0;
      
      ArrayList<ToolOption> tools;
      
      float x, y, w, h;
      
      ToolOptions() {
        tools = new ArrayList<ToolOption>();
        x = 300;
        y = 17;
        w = 117; 
        h = 32;
        tools.add(new ToolOption(x, y, 40, h, "Move", 0));
      }
      
      int getToolSelected() {
        return toolSelected;
      }
    
      void display() {
        for (ToolOption option : tools) {
          option.display();
        }
      }
      
      void clicked() {
        for (ToolOption option : tools) {
          option.clicked();
        }
      }
 
      class ToolOption {
        String label;
        float x, y, w, h;
        boolean selected;
        int index;
        
        ToolOption(float x, float y, float w, float h, String label, int index) {
          this.label = label;
          this.x = x;
          this.y = y;
          this.w = w;
          this.h = h;
          this.index = index;
          selected = false;
        }
        
        void display() {
          if (selected) {
            fill(DARK1);
          }
          else fill(DARK2);
          
          rect(x, y, w, h);
          
          textAlign(CENTER);
          textSize(16);
          fill(color(255));
          text(label, x + (w / 2), y + h / 2 + 6); 
          
          if(isHovering()) {
              if (mousePressed) 
                pressedIndicator();
              else 
                onHover();
          }
        }
        
        void clicked() {
          if(isHovering()) {
            selected = true;
            toolSelected = index;
          }
        }
        void setSelected(boolean isSelected) {
          selected = isSelected;
        }
        
        void onHover() {
          fill(color(255,255,255, 100));
          rect(x, y, w, h);
        }
        
        void pressedIndicator() {
          fill(color(0,0,0, 100));
          rect(x, y, w, h);
        }
        
        boolean isHovering() {
          if(mouseX >= x && mouseX < x + w && mouseY >= y && mouseY < y + h) {
              return true;
          }
          return false;
        }
      }
    } */
    
//class ColorPicker extends UiElement {
    //  private float x, y, w, h;
       
    //  ColorPicker() {
    //    x = 1026;
    //    y = 72;
    //    w = 50;
    //    h = 50;
    //  }
    //  void display() {
    //    stroke(255);
    //    fill(color(0));
    //    rect(x, y, w, h);
    //  }
      
    //  //void clicked() {
    //  //  if(mouseX >= x && mouseX < x + w && mouseY >= y && mouseY < y + h) {
    //  //    Integer chosenColor = booster.showColorPickerAndGetRGB("Choose your favorite color", "Color picking");
    //  //    if(chosenColor != null) {
    //  //      penColor = chosenColor.intValue();
    //  //    }
    //  //  }
    //  //}
    //}
