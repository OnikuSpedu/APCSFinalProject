class FilterScreen extends Screen {
  ArrayList<UiElement> elements;
  
  FilterScreen() {
      elements = new ArrayList<UiElement>();
      Toolbar toolbar = new Toolbar();
      Sidebar sidebar = new Sidebar();
      elements.add(toolbar);
      elements.add(sidebar);
  }
  void display() {
    background(DARK4);
    for (UiElement e : elements) {
        e.display();
    }
    if (canvas != null) {
       canvas.display(); 
    }
  }
  void click() {
    for (UiElement e : elements) {
      e.click();
    }
  }
    
}
