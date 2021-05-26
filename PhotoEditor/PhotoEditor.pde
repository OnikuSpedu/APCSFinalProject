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

EditorScreen editor = new EditorScreen();
void setup() {
  size(1366,768);
  background(DARK4);
  
}

void draw() {
  editor.display();
}

void mouseClicked() {
  editor.click();
}
