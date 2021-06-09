import java.util.ArrayDeque;
class BucketTool extends Tool {
  
  color c;
  
  BucketTool() {
    c = color(0);
  }
  
  void apply(int x, int y) {
    for (Layer layer : canvas.layers) {
      if (layer.selected) {
         color original = layer.getPixel(x,y);
         boolean[][] visited = new boolean[layer.layerPixels.length][layer.layerPixels[0].length];
         ArrayDeque<int[]> q = new ArrayDeque<int[]>();
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
    if (x < 0 || x >= layer.layerPixels[0].length || y < 0 || y >= layer.layerPixels.length) {
      return false;
    }
    if (!isSomewhatEqual(layer.getPixel(x,y), previous)) {
      return false;
    }
    if (visits[y][x]) {
      return false;
    }
    layer.setPixel(x, y, this.c);
    visits[y][x] = true;
    return true;
  }
  boolean isSomewhatEqual(color a, color b) {
    float rDiff = red(a) - red(b);
    float gDiff = green(a) - green(b);
    float bDiff = blue(a) - blue(b);
    return ((rDiff*rDiff) + (gDiff*gDiff) + (bDiff*bDiff)) <= 50*50;
  }
  void setColor(color other) {
    this.c = other;
  }
  color getColor() {
    return c;
  }
}
