abstract class Tool {
  abstract Layer apply(Layer layer, int x, int y);
  abstract ArrayList<Layer> apply(ArrayList<Layer> layers, int x, int y);
}
