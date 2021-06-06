abstract class Tool {
  boolean active;
  
  Tool() {
    active = false;
  }
  
  boolean isActive() {
    return active;
  }
  
  void setActive(boolean newActive) {
    active = newActive;
  }
  
  abstract Layer apply(Layer layer, int x, int y);
  abstract ArrayList<Layer> apply(ArrayList<Layer> layers, int x, int y);
}
