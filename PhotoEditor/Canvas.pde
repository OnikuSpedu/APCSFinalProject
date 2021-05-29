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
    calculateComposition();
  }
  
  Canvas(PImage img) {
    x = (1006-img.width)/2;
    y = (704-img.height)/2 + 64;
    this.w = img.width;
    this.h = img.height;
    
    layers = new ArrayList<Layer>();
    
    layers.add(new Layer(img));
    
    composition = new color[w][h];
    calculateComposition();
  }
  
  void calculateComposition() {
    for (int i = 0; i < composition.length; i++) {
      for (int j = 0; j < composition[0].length; j++) {
        for (int l = layers.size() - 1; l >= 0; l--) {
          Layer layer = layers.get(l);
          composition[i][j] = layer.getPixel((int) (i - layer.x), (int) (j - layer.y));
        }
      }
    }
  }
  
  color[][] getComposition() {
    
     // Implement calculations
     
     return composition;
  }
  
  void display() {
    for(int i = 0; i < w; i++) {
       for(int j = 0; j < h; j++) {
          set(x+i,y+j, composition[i][j]);
      }
    }
    
  }
  
  void click() {
    
  }
}
