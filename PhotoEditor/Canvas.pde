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
    
    color aColor = layers.get(layerNum).getPixel(x,y);
    color bColor = calculatePixel(x, y, layerNum + 1);

    float aRed = aColor >> 16 & 0xFF;
    float bRed = bColor >> 16 & 0xFF;
    
    float aGreen = aColor >> 8 & 0xFF;
    float bGreen = bColor >> 8 & 0xFF;
    
    float aBlue = aColor & 0xFF;
    float bBlue = bColor & 0xFF;
    
    float aAlpha = alpha(aColor) / 255;
    float bAlpha = alpha(bColor) / 255;    

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
          set((int) (super.x+j), (int) (super.y+i), composition[i][j]);
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
    }
  }
  
  void dragged() {
    if (super.isHovering()) {
      
      if(drawTool.isActive()) {
        drawTool.apply((int) (mouseX-super.x), (int) (mouseY-super.y));
      }
      
      for (Layer layer : canvas.layers) {
        layer.dragged();
      }
    }
  }
  
  //void released() {
  //   for (Layer layer : canvas.layers) {
  //      layer.released();
  //    }
  //}
}
