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

  void clicked() {
      for (UiElement e : elements) {
        e.clicked();
      }
    }

      
  class Sidebar extends UiElement {
    private float x, y, w, h;
    private color c;
    
    LayersOptions layersOptions;
    ColorPicker colorPicker;
    
    ArrayList<UiElement> elements;
    Sidebar() { 
      x = 1006;
      y = 64;
      w = 360;
      h = 704;
      c = DARK3;
      
      elements = new ArrayList<UiElement>();
      
      layersOptions = new LayersOptions();
      colorPicker = new ColorPicker();
      
      elements.add(layersOptions);
      elements.add(colorPicker);
    }
    
    void clicked() {
      if(mouseX >= x && mouseX < x + w && mouseY >= y && mouseY < y + h) {
        for( UiElement e : elements) {
          e.clicked();
        }
      }
    }
    
    void display() {
      fill(c);
      noStroke();
      rect(x, y, w, h);
      
      for( UiElement e : elements) {
          e.display();
      }
    }    
    
    class ColorPicker extends UiElement {
      private float x, y, w, h;
       
      ColorPicker() {
        x = 1026;
        y = 72;
        w = 50;
        h = 50;
      }
      void display() {
        stroke(255);
        fill(color(0));
        rect(x, y, w, h);
      }
      
      //void clicked() {
      //  if(mouseX >= x && mouseX < x + w && mouseY >= y && mouseY < y + h) {
      //    Integer chosenColor = booster.showColorPickerAndGetRGB("Choose your favorite color", "Color picking");
      //    if(chosenColor != null) {
      //      penColor = chosenColor.intValue();
      //    }
      //  }
      //}
    }
      
    class LayersOptions extends UiElement {
      
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
    
      void clicked() {
        if(mouseX >= x && mouseX < x + w && mouseY >= y && mouseY < y + h) {
          println("Sidebar clicked"); 
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

  class Toolbar extends UiElement {
    private int x, y, w, h;
    private color c;
    private ArrayList<Button> navButtons = new ArrayList<Button>();
    ToolOptions toolOptions;
    Toolbar() { 
      x = 0;
      y = 0;
      w = 1366;
      h = 64;
      c = DARK2;
      
      BackButton back = new BackButton();
      ContinueButton cont = new ContinueButton();
      navButtons.add(back);
      navButtons.add(cont);
      
      toolOptions = new ToolOptions();
    }
    
    void clicked() {
      if(mouseX >= x && mouseX < x + w && mouseY >= y && mouseY < y + h) {
        println("Toolbar clicked"); 
        
        for(Button b : navButtons) {
          b.clicked(); 
        }
      }
    }
    
    void display() {
      fill(c);
      noStroke();
      rect(x, y, w, h);
      
      for(Button b : navButtons) {
        b.display(); 
      }

      toolOptions.display();
    }
    
    int getToolSelected() {
      return toolOptions.getToolSelected();
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
    
    class ToolOptions {
      
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
    }
  }
}
