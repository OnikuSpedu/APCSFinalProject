class Canvas extends UiElement{
  private ArrayList<Layer> layers;
  private color[][] composition;
  
  Canvas(float w, float h) {
    super((1006-w)/2, (704-h)/2 + 64, w, h, BLACK);
    
    layers = new ArrayList<Layer>();
    
    layers.add(new Layer((int) w, (int) h));
    
    composition = new color[(int) h][(int) w];
  }
  
  Canvas(PImage img) {
    super((1006-650)/2, (704-650)/2 + 64, 650, 650, BLACK);
    
    if (img.width < 650) {
        super.setX((1006-img.width)/2);
        super.setW(img.width);
    }
    
    if (img.height < 650) {
        super.setY((704-img.height)/2 + 64);
        super.setH(img.height);
    }
    
    layers = new ArrayList<Layer>();
    
    layers.add(new Layer(img));
    
    composition = new color[(int) h][(int) w];
  }
  
  ArrayList<Layer> getLayers() {
    return layers;
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
    
    color aColor = aLayer.getPixel(x,y);
    
    if (layerNum == layers.size() - 1) {
      return color(aColor >> 16 & 0xFF, aColor >> 8 & 0xFF, aColor & 0xFF, 255 * ((alpha(aColor) / 255) * aLayer.getOpacity())) ;
    }
    
    if ((layerNum == layers.size() - 1) || (alpha(aColor) == 255 && aLayer.getOpacity() == 1)) {
      return aColor;
    }
    
    color bColor = calculatePixel(x, y, layerNum + 1);
    
    if ((layerNum < layers.size() - 1 && alpha(aColor) == 0)) {
      return bColor;
    }

    return overOperator(aColor, bColor, alpha(aColor) / 255 * aLayer.getOpacity(), alpha(bColor) / 255);
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
            
            if (layer.isSelected()) {

              if(
                ((j == layer.getX() - 1 || j == layer.getX() + layer.getW()) && (i >= layer.getY() - 1 && i < layer.getY() + layer.getH())) ||
                ((i == layer.getY() - 1 || i == layer.getY() + layer.getH()) && (j >= layer.getX() - 1 && j < layer.getX() + layer.getW()))
              ) {
                  updatedPixel = true;
                  set((int) (super.getX()+j), (int) (super.getY()+i), PRIMARY);
              }
            }
          } 
          
          if (!updatedPixel) {
            set((int) (super.getX()+j), (int) (super.getY()+i), overOperator(composition[i][j], bgCheckerBoardColor, alpha(composition[i][j]) / 255, 1));
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
        drawTool.apply((int) (mouseX-super.getX()), (int) (mouseY-super.getY()));
      }
      
      if(moveTool.isActive()) {
         moveTool.pressed();
      }
      
      if (bucketTool.isActive()) {
        bucketTool.apply((int) (mouseX-super.getX()), (int) (mouseY-super.getY()));
      }
      
      if (eraserTool.isActive()) {
        eraserTool.apply((int) (mouseX-super.getX()), (int) (mouseY-super.getY()));
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
        drawTool.apply((int) (mouseX-super.getX()), (int) (mouseY-super.getY()));
      }
      
      if(moveTool.isActive()) {
        moveTool.apply(mouseX-pmouseX,mouseY-pmouseY);
      }
      
      if (eraserTool.isActive()) {
        eraserTool.apply((int) (mouseX-super.getX()), (int) (mouseY-super.getY()));
      }
    }
  }
}
