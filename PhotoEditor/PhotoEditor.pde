import uibooster.*;
import java.util.Arrays;

UiBooster booster;

color BLACK = color(0);
color DARK4 = color(30,30,30);
color DARK3 = color(37,37,38);
color DARK2 = color(45,45,48);
color DARK1 = color(55,55,60);
color PRIMARY = color(0,122,204);

/*Scenes
0 - welcome
1 - editor
2 - filters
3 - saved confirmation
*/
int scene = 0;

int canvasWidth = 650;
int canvasHeight = 650;

color penColor = color(0);

EditorScreen editorScreen;
StartScreen startScreen;
FilterScreen filterScreen;
SaveScreen saveScreen;
Canvas canvas;
ArrayList<Screen> screens;

void setup() {
  size(1366,768);
  background(DARK4);
  
  booster = new UiBooster();

  canvas = new Canvas(canvasWidth,canvasHeight);
  
  startScreen = new StartScreen();
  editorScreen = new EditorScreen();
  filterScreen = new FilterScreen();
  saveScreen = new SaveScreen();
  
  screens = new ArrayList<Screen>();
  screens.add(startScreen);
  screens.add(editorScreen);
  screens.add(filterScreen);
  screens.add(saveScreen);
}

void draw() {
  screens.get(scene).display();
}

void mouseClicked() {
  screens.get(scene).clicked();
}

void mouseDragged() {
  screens.get(scene).dragged();
}

void mousePressed() {
  screens.get(scene).pressed();
}

void mouseReleased() {
  screens.get(scene).released();
}
