class Canvas extends UiElement{
  ArrayList<Layer> layers;
  int x, y, w, h;
  color[][] composition;
  
  Canvas(int w, int h) {
    x = (1006-w)/2;
    y = (704-h)/2 + 64;
    this.w = w;
    this.h = h;
    
    layers = new ArrayList<Layer>();
    
    layers.add(new Layer(w, h));
    
    composition = new color[w][h];
  }
  
  Canvas(PImage img) {
    x = (1006-img.width)/2;
    y = (704-img.height)/2 + 64;
    this.w = img.width;
    this.h = img.height;
    
    layers = new ArrayList<Layer>();
    
    layers.add(new Layer(img));
    
    composition = new color[h][w];
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
    calculateComposition();

    for(int i = 0; i < w; i++) {
       for(int j = 0; j < h; j++) {
          set(x+i,y+j, DARK4);
          set(x+i,y+j, composition[j][i]);
       }
    }
    
  }
  
  void click() {
    
  }
  color[][] getComposition() {
    return composition;
  }

  void pressed() {
    for (Layer layer : layers) {
      layer.pressed();
    }
  }

  void released() {
     for (Layer layer : canvas.layers) {
        layer.released();
      }
  }

  void dragged() {
    if (mouseX >= x && mouseX < x+w && mouseY >= y && mouseY < y + h) {
      drawTool((int) (mouseX-x), (int) (mouseY-y), penColor, 10);
      
      for (Layer layer : canvas.layers) {
        layer.dragged();
      }
    }
  }

  void drawTool(int x, int y, color c, int thickness) {
    for (Layer layer : canvas.layers) {
      if (layer.selected) {
        for (int i = 0 - thickness/2; i <= thickness - thickness/2; ++i) {
          layer.setPixel(x + i,y + i,c);
        }  
      }
    }
  }
}
