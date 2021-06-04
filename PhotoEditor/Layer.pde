class Layer {
  float x, y, w, h, opacity;
  color[][] layerPixels;
  String name;
  
  Layer(float w, float h) {
    this.x = 0;
    this.y = 0;
    this.w = w;
    this.h = h;
    this.opacity = 1;
    
    name = "Untitled";
    
    layerPixels = new color[(int)w][(int)h];
    
    for (int row = 0; row < layerPixels.length; row++) {
      for (int col = 0; col < layerPixels[row].length; col++) {
        layerPixels[row][col] = color(255);
      }
    }
  }
  
  Layer(float w, float h, color c) {
    this.x = 0;
    this.y = 0;
    this.w = w;
    this.h = h;
    this.opacity = 1;

    name = "Untitled";

    layerPixels = new color[(int)h][(int)w];

    for (int row = 0; row < layerPixels.length; row++) {
      for (int col = 0; col < layerPixels[row].length; col++) {
        layerPixels[row][col] = c;
      }
    }
  }
  
  Layer(PImage img) {
    this.x = 0;
    this.y = 0;
    this.w = img.width;
    this.h = img.height;
    this.opacity = 1;

    layerPixels = new color[(int)h][(int)w];

    name = "Untitled";

    for (int row = 0; row < layerPixels.length; row++) {
      for (int col = 0; col < layerPixels[row].length; col++) {
        layerPixels[row][col] = img.get(col,row);
      }
    }
  }
  
  Layer(float w, float h, float opacity) {
    this.x = 0;
    this.y = 0;
    this.w = w;
    this.h = h;
    this.opacity = opacity;
    
    name = "Untitled";

    layerPixels = new color[(int)h][(int)w];
    
    for (int row = 0; row < layerPixels.length; row++) {
      for (int col = 0; col < layerPixels[row].length; col++) {
        layerPixels[row][col] = color(255);
      }
    }
  }
  
  Layer(float w, float h, color c, float opacity) {
    this.x = 0;
    this.y = 0;
    this.w = w;
    this.h = h;
    this.opacity = opacity;

    name = "Untitled";

    layerPixels = new color[(int)h][(int)w];

    for (int row = 0; row < layerPixels.length; row++) {
      for (int col = 0; col < layerPixels[row].length; col++) {
        layerPixels[row][col] = c;
      }
    }
  }
  
  Layer(PImage img, float opacity) {
    this.x = 0;
    this.y = 0;
    this.w = img.width;
    this.h = img.height;
    this.opacity = opacity;
    
    layerPixels = new color[(int)h][(int)w];

    name = "Untitled";

    for (int row = 0; row < layerPixels.length; row++) {
      for (int col = 0; col < layerPixels[row].length; col++) {
        layerPixels[row][col] = img.get(col,row);
      }
    }
  }
  
  color getPixel(int x, int y) {
      x += (int) this.x;
      y += (int) this.y;
      if (x >= 0 && x < layerPixels[0].length && y >= 0 && y < layerPixels.length) {
        return layerPixels[y][x];
      } 
      
      return color(0,0,0,0);
  }
  
  boolean setPixel(int x, int y, color c) {
      if (x >= 0 && x < layerPixels[0].length && y >= 0 && y < layerPixels.length) {
        layerPixels[y][x] = c;
        return true;
      } 
      
      return false;
  }
}
