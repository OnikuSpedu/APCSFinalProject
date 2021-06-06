class MoveTool extends Tool {
  
  boolean active;
  
  MoveTool() {
    active = false;
  }
  
  Layer apply(Layer layer, int x, int y) {

    layer.x = x;
    layer.y = y;

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
