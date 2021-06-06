import uibooster.*;
import java.util.Arrays;

UiBooster booster;

// Global Color Palette
color BLACK = color(0);
color DARK4 = color(30,30,30);
color DARK3 = color(37,37,38);
color DARK2 = color(45,45,48);
color DARK1 = color(55,55,60);
color PRIMARY = color(0,122,204);
color TRANSPARENT = color(0,0,0,255);


/*Scenes
0 - welcome
1 - editor
2 - filters
3 - saved confirmation
*/
int scene = 0;

// Set default size to 650 x 650
int canvasWidth = 650;
int canvasHeight = 650;

// Create variables for screens
EditorScreen editorScreen;
StartScreen startScreen;
FilterScreen filterScreen;
SaveScreen saveScreen;
Canvas canvas;

ArrayList<Screen> screens; // We can use an array instead

//Create variables for draw tools
DrawTool drawTool;
MoveTool moveTool;
ArrayList<Tool> tools;
  
/*---------------------------------------------------------------------------
   Setup 
   - Set window size and background
   - Initialize scenes and add them to screens ArrayList.
  ---------------------------------------------------------------------------*/ 

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
  
  drawTool = new DrawTool();
  moveTool = new MoveTool();
  
  tools = new ArrayList<Tool>();
  tools.add(drawTool);
  tools.add(moveTool);    
}

/*---------------------------------------------------------------------------
   Draw
  ---------------------------------------------------------------------------*/

void draw() {
  background(DARK4);
  screens.get(scene).display();
}

/*---------------------------------------------------------------------------
   All mouse interactions
  ---------------------------------------------------------------------------*/
  
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
