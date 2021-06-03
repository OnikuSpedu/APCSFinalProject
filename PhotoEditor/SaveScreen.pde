class SaveScreen extends Screen {
  ArrayList<UiElement> elements;
  
  SaveScreen() {
    elements = new ArrayList<UiElement>();
    Toolbar toolbar = new Toolbar();
    Sidebar sidebar = new Sidebar();
    elements.add(toolbar);
    elements.add(sidebar);
  }
}
