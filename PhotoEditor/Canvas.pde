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
    if (layerNum == layers.size() - 1) {
      return layers.get(layerNum).getPixel(x,y);
    } 
    
    Layer aLayer = layers.get(layerNum);
    color aColor = aLayer.getPixel(x,y);
    
    if(alpha(aColor) == 255) {
      return aColor;
    }
    
    color bColor = calculatePixel(x, y, layerNum + 1);

    return overOperator(aColor, bColor, aLayer.opacity, 1);
  }
  
  color overOperator(color aColor, color bColor, float aLayerOpacity, float bLayerOpacity) {
    float aRed = aColor >> 16 & 0xFF;
    float bRed = bColor >> 16 & 0xFF;
    
    float aGreen = aColor >> 8 & 0xFF;
    float bGreen = bColor >> 8 & 0xFF;
    
    float aBlue = aColor & 0xFF;
    float bBlue = bColor & 0xFF;
    
    float aAlpha = alpha(aColor) / 255 * aLayerOpacity;
    float bAlpha = alpha(bColor) / 255 * bLayerOpacity;    

    //Calculate A over B
    float compAlpha = aAlpha + bAlpha* (1 - aAlpha);
    float compRed = ((aRed * aAlpha) + (bRed * bAlpha * (1 - aAlpha))) / compAlpha;
    float compGreen = ((aGreen * aAlpha) + (bGreen * bAlpha * (1 - aAlpha))) / compAlpha;    
    float compBlue = ((aBlue * aAlpha) + (bBlue * bAlpha * (1 - aAlpha))) / compAlpha;

    return color(compRed, compGreen, compBlue, compAlpha * 255);
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

    for(int i = 0; i < h; i++) {
       for(int j = 0; j < w; j++) {
          set((int) (super.x+j), (int) (super.y+i), overOperator(composition[i][j], color(255), 1, 1));
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
