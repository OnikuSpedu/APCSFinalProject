class Layer {
  private float x, y, w, h, opacity;
  private color[][] layerPixels;
  private String name;
  private boolean selected = false;
  private boolean shouldMove = false;
  private float xOffset = 0.0; 
  private float yOffset = 0.0; 
  
  Layer(float w, float h) {
    this.x = 0;
    this.y = 0;
    this.w = w;
    this.h = h;
    this.opacity = 1;
    
    name = "Untitled";
    
    layerPixels = new color[(int)h][(int)w];
    
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
  
  boolean isSelected() {
    return selected;
  }
  void setSelected(boolean other) {
    selected = other;
  }
  color[][] getLayerPixels() {
    return layerPixels;
  }
  
  float getX() {
    return x;
  }
  void setX(float other) {
    x = other;
  }
  float getY() {
    return y;
  }
  void setY(float other) {
  
  }
  float getW() {
   return w;
  }
  
  float getH() {
   return h;
  }
  
  float getOpacity() {
    return opacity;
  }
  void setOpacity(float other) {
    opacity = other;
  }
  color getPixel(int x, int y) {
      x -= (int) this.x;
      y -= (int) this.y;
      if (x >= 0 && x < layerPixels[0].length && y >= 0 && y < layerPixels.length) {
        return layerPixels[y][x];
      } 
      
      return color(0,0,0,0);
  }
  
  String getname() {
    return name;
  }
  void setname(String other) {
    name = other;
  }
  boolean setPixel(int x, int y, color c) {
      if (x >= 0 && x < layerPixels[0].length && y >= 0 && y < layerPixels.length) {
        layerPixels[y][x] = c;
        return true;
      } 
      
      return false;
  }
}
