class EraserTool extends Tool {
  
  int radius;
  float roundness;

  EraserTool() {
    radius = 10;
    roundness = 1;
  }
  
  void apply(Layer layer, int x, int y) {
    for (int i = 0 - radius; i <= radius; i++) {
      for (int j = 0 - radius; j <= radius; j++) {
        if(Math.pow(i*i + j*j, 0.5) <= (radius) + (1 - roundness) * (Math.pow(2* Math.pow(radius, 2),0.5) - radius))
          layer.setPixel(x + i - (int)layer.x,y + j - (int)layer.y, color(0,0,0,0));
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
}
