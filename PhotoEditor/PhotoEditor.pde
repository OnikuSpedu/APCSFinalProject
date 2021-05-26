color BLACK = color(0);
color DARK4 = color(30,30,30);
color DARK3 = color(37,37,38);
color DARK2 = color(45,45,48);
color DARK1 = color(55,55,60);
color PRIMARY = color(0,122,204);

/*Scenes
0 - welcome
1 - select images
2 - editor
3 - filters
4 - saved confirmation
*/
int scene = 0;

Toolbar toolbar = new Toolbar();
Sidebar sidebar = new Sidebar();

ArrayList<UiElement> elements;

void setup() {
  size(1366,768);
  background(DARK4);
  
  elements = new ArrayList<UiElement>();
  
  elements.add(toolbar);
  elements.add(sidebar);

}

void draw() {
  for (UiElement e : elements) {
      e.display();
  }
}

void mouseClicked() {
    for (UiElement e : elements) {
      e.click();
    }
}
