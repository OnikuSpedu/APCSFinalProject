class BucketTool extends Tool {
  
  color c;
  
  BucketTool() {
    c = color(0);
  }
  
  void apply(int x, int y) {
    for (Layer layer : canvas.layers) {
      if (layer.selected) {
         color previousColor = layer.getPixel(x, y);
         apply(layer, x, y, previousColor); 
      }
    }
  }
  void apply(Layer layer, int x, int y, color previous) {
    if (x < 0 || x >= layer.layerPixels[0].length || y < 0 || y >= layer.layerPixels.length) {
      return;
    }
    if (!isSomewhatEqual(layer.getPixel(x,y), previous)) {
      return;
    }
    layer.setPixel(x, y, this.c);
    apply(layer, x+1, y, previous);
    apply(layer, x-1, y, previous);
    apply(layer, x, y+1, previous);
    apply(layer, x, y-1, previous);
  }
}
