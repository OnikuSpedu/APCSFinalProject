class Canvas extends UiElement{
  ArrayList<Layer> layers;
  color[][] composition;
  
  Canvas(float w, float h) {
    super((1006-w)/2, (704-h)/2 + 64, w, h, BLACK);
    
    layers = new ArrayList<Layer>();
    
    layers.add(new Layer((int) w, (int) h));
    
    composition = new color[(int) w][(int) h];
  }
  
  Canvas(PImage img) {
    super((1006-650)/2, (704-650)/2 + 64, 650, 650, BLACK);
    
    if (img.width < 650) {
        super.x = (1006-img.width)/2;
        super.w = img.width;
    }
    
    if (img.height < 650) {
        super.y = (704-img.height)/2 + 64;
        super.h = img.height;
    }
    
    layers = new ArrayList<Layer>();
    
    layers.add(new Layer(img));
    
    composition = new color[(int) h][(int) w];
  }
  
  void calculateComposition() {
    for (int i = 0; i < composition.length; i++) {
      for (int j = 0; j < composition[0].length; j++) {
         composition[i][j] = calculatePixel(j, i);
      }
    }
  }
  
  color calculatePixel(int x, int y) {
    return calculatePixel(x, y, 0);
  }
  
  color calculatePixel(int x, int y, int layerNum) {
    Layer aLayer = layers.get(layerNum);
    
    if (millis() % 500 == 0) {
      println(aLayer.x + " " + aLayer.y);
      println(x + " " +y);
    }
    color aColor = aLayer.getPixel(x,y);
    
    if (layerNum == layers.size() - 1) {
      return color(aColor >> 16 & 0xFF, aColor >> 8 & 0xFF, aColor & 0xFF, 255 * ((alpha(aColor) / 255) * aLayer.opacity)) ;
    }
    
    if ((layerNum == layers.size() - 1) || (alpha(aColor) == 255 && aLayer.opacity == 1)) {
      return aColor;
    }
    
    color bColor = calculatePixel(x, y, layerNum + 1);

    return overOperator(aColor, bColor, alpha(aColor) / 255 * aLayer.opacity, alpha(bColor) / 255);
  }
  
  color overOperator(color aColor, color bColor, float aAlphaDecimal, float bAlphaDecimal) {
    float aRed = aColor >> 16 & 0xFF;
    float bRed = bColor >> 16 & 0xFF;
    
    float aGreen = aColor >> 8 & 0xFF;
    float bGreen = bColor >> 8 & 0xFF;
    
    float aBlue = aColor & 0xFF;
    float bBlue = bColor & 0xFF;

    //Calculate A over B
    float compAlphaDecimal = aAlphaDecimal + bAlphaDecimal* (1 - aAlphaDecimal);
    float compRed = ((aRed * aAlphaDecimal) + (bRed * bAlphaDecimal * (1 - aAlphaDecimal))) / compAlphaDecimal;
    float compGreen = ((aGreen * aAlphaDecimal) + (bGreen * bAlphaDecimal * (1 - aAlphaDecimal))) / compAlphaDecimal;    
    float compBlue = ((aBlue * aAlphaDecimal) + (bBlue * bAlphaDecimal * (1 - aAlphaDecimal))) / compAlphaDecimal;

    return color(compRed, compGreen, compBlue, compAlphaDecimal * 255);
  }
  
  void addLayer(PImage img) {
    layers.add(0, new Layer(img));
  }
  
  void addLayer() {
    layers.add(0, new Layer(w, h, color(0,0,0,0)));
  }
  
  void display() {
    super.display();
    
    calculateComposition();
    color bgCheckerBoardColor = color(255);
    boolean updatedPixel = false;
    
    for(int i = 0; i < h; i++) {
       for(int j = 0; j < w; j++) {
          updatedPixel = false;
          if ((i / 10) % 2 == (j / 10) % 2) {
            bgCheckerBoardColor = color(240);
          } else {
            bgCheckerBoardColor = color(255);
          }
          
          for (int l = 0; l < layers.size() && !updatedPixel; l++) {
            Layer layer = layers.get(l);
            
            if (layer.selected) {
              if (millis() % 500 == 0)
              println(layer.x + " " + layer.y);
              if((layer.x == j && layer.y == i)) { //|| i == layer.y || i == layer.y + h
                  updatedPixel = true;
                  set((int) (super.x+j), (int) (super.y+i), BLACK);
              }
            }
          } 
          
          if (!updatedPixel) {
            set((int) (super.x+j), (int) (super.y+i), overOperator(composition[i][j], bgCheckerBoardColor, alpha(composition[i][j]) / 255, 1));
          }
       }
    }
  }
  
  color[][] getComposition() {
    return composition;
  }
  
  void pressed() {
    if (super.isHovering()) {
      
      if(drawTool.isActive()) {
        drawTool.apply((int) (mouseX-super.x), (int) (mouseY-super.y));
      }
      
      if(moveTool.isActive()) {
         moveTool.pressed();
      }
    }
    
  }
  
  void released() {
    if (super.isHovering()) {
      
      if(moveTool.isActive()) {
         moveTool.released();
      }
    }
    
  }
  
  void dragged() {
    if (super.isHovering()) {
      
      if(drawTool.isActive()) {
        drawTool.apply((int) (mouseX-super.x), (int) (mouseY-super.y));
      }
      
      if(moveTool.isActive()) {
        moveTool.apply(mouseX-pmouseX,mouseY-pmouseY);
      }
    }
  }
}
