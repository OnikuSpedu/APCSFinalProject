class DrawTool extends Tool {
  
  color c;
  int radius;
  float roundness;

  DrawTool() {
    c = color(0);
    radius = 10;
    roundness = 1;
  }
  
  void apply(Layer layer, int x, int y) {
    for (int i = 0 - radius; i <= radius; i++) {
      for (int j = 0 - radius; j <= radius; j++) {
        if(Math.pow(i*i + j*j, 0.5) <= (radius) + roundness * (Math.pow(2* Math.pow(radius, 2),0.5) - radius))
          layer.setPixel(x + i - (int)layer.x,y + j - (int)layer.y, c);
      }  
    }
  }
  
  void apply(int x, int y) {
    for (Layer layer : canvas.layers) {
      if (layer.selected) {
         apply(layer, x, y); 
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
  void setColor(color other) {
    this.c = other;
  }
  color getColor() {
    return c;
  }
}
