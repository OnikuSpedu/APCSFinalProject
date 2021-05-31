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

EditorScreen editorScreen;
StartScreen startScreen;
Canvas canvas = new Canvas(canvasWidth,canvasHeight);

void setup() {
  size(1366,768);
  background(DARK4);
  
  booster = new UiBooster();

  editorScreen = new EditorScreen();
  startScreen = new StartScreen();
}

void draw() {
  if (scene == 0) {
    startScreen.display();
  } else if (scene == 1) {
    editorScreen.display();
  } else if (scene == 2) {
    startScreen.display();
  }
}

void mousePressed() {
  if (scene == 0) {
      startScreen.click();
  } else if (scene == 1) {
      editorScreen.click();
  } else if (scene == 2) {
      startScreen.click();
  }
}
