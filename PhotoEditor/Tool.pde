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
  
  abstract void apply(Layer layer, int x, int y);
  abstract void apply(int x, int y);
}
