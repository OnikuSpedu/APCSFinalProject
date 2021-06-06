class DrawTool extends Tool {
  
  color c;
  int thickness;
  
  DrawTool() {
    c = color(0);
    thickness = 10;
  }
  
  Layer apply(Layer layer, int x, int y) {
    for (int i = -1 * thickness / 2; i <= thickness - thickness / 2; i++) {
      for (int j = -1 * thickness / 2; j <= thickness - thickness / 2; j++) {
        layer.setPixel((int) layer.x + x + i, (int) layer.y + y + j, c);
      }
    }

    return layer;
  }
  
  ArrayList<Layer> apply(ArrayList<Layer> layers, int x, int y) {
    for (Layer layer : layers) {
      if (layer.selected) {
       apply(layer, x, y); 
      }
    }
    
    return layers;
  }
}
