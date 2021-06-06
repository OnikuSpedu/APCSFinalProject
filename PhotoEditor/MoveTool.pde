class MoveTool extends Tool {
   
  MoveTool() {
  }
  
  void apply(Layer layer, int x, int y) {

    layer.x = x;
    layer.y = y;

  }
  
  void apply(int x, int y) {
    for (Layer layer : canvas.layers) {
      if (layer.selected) {
       apply(layer, x, y); 
      }
    }
  }
}
