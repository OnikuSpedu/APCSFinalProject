class MoveTool extends Tool {
   
  boolean locked; 
  
  MoveTool() {
    locked = true;
  }
  
  void apply(Layer layer, int x, int y) {
    layer.setX(layer.getX() + x);
    layer.setY(layer.getY() + y);
  }
  
  void pressed() {
   locked = false; 
  }
  
  void released() {
    locked = true;
  }
  
  void apply(int x, int y) {
    if (!locked) {
      for (Layer layer : canvas.getLayers()) {
        if (layer.isSelected()) {
         apply(layer, x, y); 
        }
      }
    }
  }
}
