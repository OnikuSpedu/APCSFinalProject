class EditorScreen extends Screen {
Toolbar toolbar = new Toolbar();
Sidebar sidebar = new Sidebar();
ArrayList<UiElement> elements;

EditorScreen() {
  elements = new ArrayList<UiElement>();
  elements.add(toolbar);
  elements.add(sidebar);
}

void display() {
  background(DARK4);
  for (UiElement e : elements) {
      e.display();
  }
}

void click() {
    for (UiElement e : elements) {
      e.click();
    }
    }
}
