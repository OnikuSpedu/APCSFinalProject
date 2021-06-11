import java.util.ArrayDeque;
class BucketTool extends Tool {
  
  color c;
  float tolerance;

  BucketTool() {
    c = color(0);
    tolerance = 0.001;
  }
  
  void apply(int x, int y) {
    ArrayDeque<int[]> q = new ArrayDeque<int[]>();
    for (Layer layer : canvas.layers) {
      if (layer.selected) {
         color original = layer.getPixel(x,y);
         boolean[][] visited = new boolean[layer.layerPixels.length][layer.layerPixels[0].length];
         q.add(new int[] {x, y});
         while (!q.isEmpty()) {
           int[] point = q.remove();
           if (apply(layer, visited, point, original)) {
             q.add(new int[] {point[0]+1, point[1]});
             q.add(new int[] {point[0]-1, point[1]});
             q.add(new int[] {point[0], point[1]+1});
             q.add(new int[] {point[0], point[1]-1});
           }
         }
      }
    }
  }
  void apply(Layer layer, int x, int y) {
    
  }
  
  boolean apply(Layer layer, boolean[][] visits, int[] coord, color previous) {
    int x = coord[0];
    int y = coord[1];
    
    int layerX = x - (int)layer.x;
    int layerY = y - (int)layer.y;
         
    if (layerX < 0 || layerX >= layer.layerPixels[0].length || layerY < 0 || layerY >= layer.layerPixels.length) {
      return false;
    }
    if (!isSomewhatEqual(layer.getPixel(x,y), previous)) {
      return false;
    }
    if (visits[layerY][layerX]) {
      return false;
    }

    layer.setPixel(layerX, layerY, this.c);
    visits[layerY][layerX] = true;
    return true;
  }
  boolean isSomewhatEqual(color a, color b) {
    float rDiff = (red(a) - red(b)) / 255;
    float gDiff = (green(a) - green(b)) / 255;
    float bDiff = (blue(a) - blue(b)) / 255;
    float aDiff = (alpha(a) - alpha(b)) / 255;
    return ((rDiff*rDiff) + (gDiff*gDiff) + (bDiff*bDiff) + (aDiff*aDiff)) <= tolerance * tolerance;
  }
  void setColor(color other) {
    this.c = other;
  }
  color getColor() {
    return c;
  }
  float getTolerance() {
    return tolerance;
  }
}
