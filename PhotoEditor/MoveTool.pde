class MoveTool extends Tool {
   
  boolean locked; 
  
  MoveTool() {
    locked = true;
  }
  
  void apply(Layer layer, int x, int y) {
    layer.x += x; 
    layer.y += y; 
  }
  
  void pressed() {
   locked = false; 
  }
  
  void released() {
    locked = true;
  }
  
  void apply(int x, int y) {
    if (!locked) {
      for (Layer layer : canvas.layers) {
        if (layer.selected) {
         apply(layer, x, y); 
        }
      }
    }
  }
}
