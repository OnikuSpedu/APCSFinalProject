class DrawTool extends Tool {
  
  color c;
  int thickness;
  
  DrawTool() {
    c = color(0);
    thickness = 10;
  }
  
  void apply(Layer layer, int x, int y) {
    for (int i = 0 - thickness/2; i <= thickness - thickness/2; i++) {
      for (int j = 0 - thickness/2; j <= thickness - thickness/2; j++) {
        layer.setPixel(x + i,y + j, BLACK);
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
}
