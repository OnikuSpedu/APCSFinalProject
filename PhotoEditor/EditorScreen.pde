class EditorScreen extends Screen {
  
  EditorScreen() {    
    Navbar navbar = new Navbar();
    Sidebar sidebar = new Sidebar();
    
    super.elements.add(navbar);
    super.elements.add(sidebar);
  }
      
  void display() {
    super.display();
    canvas.display();
  }
  
  void dragged() {
    super.dragged();
    canvas.dragged();
  }
  
  
  void pressed() {
    super.pressed();
    canvas.pressed();
  }
  
  void released() {
    super.released();
    canvas.released();
  }
  
  void clicked() {
    super.clicked();
    canvas.clicked();
  }
  
  class Sidebar extends UiElement {

    LayersOptions layersOptions;
    ColorPicker colorPicker;
    
    ArrayList<UiElement> elements;
    
    Sidebar() { 
      super(1006, 64, 360, 704, DARK3);
      
      elements = new ArrayList<UiElement>();
      
      layersOptions = new LayersOptions();
      elements.add(layersOptions);

      colorPicker = new ColorPicker();
      elements.add(colorPicker);
    }
    
    void clicked() {
      if(super.isHovering()) {
        for( UiElement e : elements) {
          e.clicked();
        }
      }
    }
    
    void dragged() {
      if(super.isHovering()) {
        for( UiElement e : elements) {
          e.dragged();
        }
      }
    }
    
    void display() {
      super.display();
      
      for( UiElement e : elements) {
          e.display();
      }
          }    
    
    class ColorPicker extends UiElement {      
      ColorPicker() {
        super(1026,72,50,50, TRANSPARENT);
      }
      void display() {
        stroke(255);
        fill(drawTool.c);
        rect(super.x, super.y, super.w, super.h);
      }
      
      void clicked() {
        if(super.isHovering()) {
          Integer chosenColor = booster.showColorPickerAndGetRGB("Choose your favorite color", "Color picking");
          if(chosenColor != null) {
            drawTool.c = (chosenColor.intValue());
          }
        }
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
          if(super.isHovering()) {
            if (canvas != null) {
              canvas.addLayer();
            }
          }
        }
      }

      class LayerOptionCard extends UiElement{
        private int index;
        DeleteLayerButton deleteBtn;
        LayerOpacityButton opacityBtn;
        LayerOptionCard(int index) {
          super(1026, 398 + index * 50,321, 50, DARK2);
          this.index = index;
          
          deleteBtn = new DeleteLayerButton(1026 + 321 - 32, 398 + index * 50 + 18, index);
          opacityBtn = new LayerOpacityButton(1026 + 321 - 32 - 40 - 16 - 8, 398 + index * 50 + 12, index);
        }
        
        void display() {
          super.display();
          Layer layer = canvas.layers.get(index);
          
          deleteBtn.display();
          opacityBtn.display();
          
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
        
        class LayerOpacityButton extends Button {
          int index;
          LayerOpacityButton(float x, float y, int index) {
            super("Loading", x, y, 48, 26, color(40), color(255));
            this.index = index;
            
            super.fontSize = 10;
          }
          
          void display() {
            super.label = "" + canvas.layers.get(index).opacity;
            super.display();
          }
          
          void clicked() {
            if(super.isHovering()) {
    
              String inputWidth = booster.showTextInputDialog("Width:");
              
              try {
                Float userLayerOpacity  = Float.parseFloat(inputWidth);
                canvas.layers.get(index).opacity = userLayerOpacity;
              } catch (Exception e) {
                e.printStackTrace();
              }
            }
          }
        }

        class DeleteLayerButton extends Button {
          int index;
          DeleteLayerButton(float x, float y, int index) {
            super("x", x, y, 16, 16, DARK1, color(255));
            this.index = index;
          }
          
          void display() {
            if(canvas.layers.size() > 1) {
              noStroke();
              ellipseMode(LEFT);
              if(isHovering()) {
                fill(color(255,80,80));
              } else {
                fill(super.bgColor);
              }
              ellipse(x, y, 16, 16);
            }
          }
          
          void clicked() {
            if(super.isHovering()) {
              if(canvas.layers.size() > 1)
                canvas.layers.remove(this.index);
            }
          }
        }

        void clicked() {
          Layer layer = canvas.layers.get(index);
          if (super.isHovering()) {
            if(mouseX >= x + 16 && mouseX < x + 16 + 16 && mouseY >= y + 18 && mouseY < y + 16 + 18) {
              layer.selected = !layer.selected;
              println("Toggled");
            }
            
            deleteBtn.clicked();
            opacityBtn.clicked();
            
            if(mouseX >= x + 32 + 8 && mouseX < x + 32 + + 8 + textWidth(layer.name) && mouseY >= y + 16 && mouseY < y + 16 + 16) {
              String newLayerNameInput = booster.showTextInputDialog("Layer name:");
              
              if (newLayerNameInput != null && !newLayerNameInput.equals("")) {
                layer.name = newLayerNameInput;
              }
            }
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
        
        toolbar.clicked();
      }
    }
    
    void display() {
      super.display();
      
      for(Button b : navButtons) {
        b.display(); 
      }
      
      toolbar.display();
    }
    
    class BackButton extends Button {
      BackButton() {
        super("Back", 12, 12, 100, 40,DARK1, color(255));
      }
      
      void clicked() {
        if(super.isHovering()) {
          scene--;
        }
      }      
    }
    
    class ContinueButton extends Button {
      ContinueButton() {
        super("Continue", 1230, 17, 117, 31, PRIMARY, color(255));
      }
      void clicked() {
        if(super.isHovering()) {
          scene++;
        }
      }
    }
    
    class Toolbar extends UiElement {
      
      private ArrayList<Button> toolButtons = new ArrayList<Button>();

      Toolbar() {
        super(300, 17, 117, 32, DARK1);
        toolButtons.add(new DrawToggleButton());
        toolButtons.add(new MoveToggleButton());        
      }
      
      void display() {
        super.display();
        
        for (Button btn : toolButtons) {
          btn.display();
        }
      }
      
      void clicked() {
        for (Button btn : toolButtons) {
          btn.clicked();
        }
      }
      
      class DrawToggleButton extends Button {
        DrawToggleButton() {
          super("Draw", 300, 17, 117, 32, DARK1, color(255));
        }
        
        void display() {
         if(drawTool.isActive()) {
           super.bgColor = PRIMARY;
         } else {
           super.bgColor = DARK1;
         }
         
         super.display();
        }
        
        void clicked() {
          if (super.isHovering()) {
            drawTool.setActive(!drawTool.isActive());          
            for (Tool tool : tools) {
              if (tool != drawTool) {
                tool.setActive(false);
              }
            }
            
            println("Draw");
          }
        }
      }
      
      class MoveToggleButton extends Button {
        MoveToggleButton() {
          super("Move", 300 + 117, 17, 117, 32, DARK1, color(255));
        }
        
        void display() {
         if(moveTool.isActive()) {
           super.bgColor = PRIMARY;
         } else {
           super.bgColor = DARK1;
         }
         
         super.display();
        }
        
        void clicked() {
          if (super.isHovering()) {
            moveTool.setActive(!moveTool.isActive()); 
            
            println("Move");
            for (Tool tool : tools) {
              if (tool != moveTool) {
                tool.setActive(false);
              }
            }
          }
        }
      }
    }
  }
}
