import java.util.Arrays;
PImage stagedPhoto; //the photo that is displayed on the work area, gets changed by the kernels
class FilterScreen extends Screen {
  ArrayList<UiElement> elements;
  
  FilterScreen() {
      elements = new ArrayList<UiElement>();
      Navbar navbar = new Navbar();
      Sidebar sidebar = new Sidebar();
      elements.add(navbar);
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
    if (stagedPhoto != null) {
      image(stagedPhoto, (1006-stagedPhoto.width)/2, (704-stagedPhoto.height)/2 + 64);
    }
  }
  void clicked() {
    for (UiElement e : elements) {
      e.clicked();
    }
  }
  class Sidebar extends UiElement {
    private ArrayList<FilterOption> filters;
    
    Sidebar() { 
      super(1006, 64, 360, 704, DARK3);
      
      filters = new ArrayList<FilterOption>();
      Kernel emboss = new Kernel(new float[][] { {-2, -1, 0},
                                                  {-1, 1, 1},
                                                  {0, 1, 2} } );
      Kernel outline = new Kernel(new float[][] { {-1, -1, -1},
                                                  {-1, 8, -1},
                                                  {-1, -1, -1} } );
      Kernel blur = new Kernel(new float[][] { {0.111, 0.111, 0.111},
                                                  {0.111, 0.111, 0.111},
                                                  {0.111, 0.111, 0.111} } );
      Kernel sharpen = new Kernel(new float[][] { {-1, -1, -1},
                                                  {-1, 9, -1},
                                                  {-1, -1, -1} } );
      Kernel topSobel = new Kernel(new float[][] { {1, 2, 1},
                                                  {0, 0, 0},
                                                  {-1, -2, -1} } );
      Kernel bottomSobel = new Kernel(new float[][] { {-1, -2, -1},
                                                      {0, 0, 0},
                                                      {1, 2, 1} } );
      Kernel leftSobel = new Kernel(new float[][] { {1, 0, -1},
                                                      {2, 0, -2},
                                                      {1, 0, -1} } );
      Kernel rightSobel = new Kernel(new float[][] { {-1, 0, 1},
                                                      {-2, 0, 2},
                                                      {-1, 0, 1} } );
      
      filters.add(new FilterOption(emboss, 1047, 110));
      filters.add(new FilterOption(outline, 1219, 110));
      filters.add(new FilterOption(blur, 1047, 291));
      filters.add(new FilterOption(sharpen, 1219, 291));
      filters.add(new FilterOption(topSobel, 1047, 472));
      filters.add(new FilterOption(bottomSobel, 1219, 472));
      filters.add(new FilterOption(leftSobel, 1047, 655));
      filters.add(new FilterOption(rightSobel, 1219, 655));
    }
    
    void clicked() {
      if(super.isHovering()) {
         for (FilterOption choice : filters) {
           choice.clicked();
         }
      }
    }
    
    void display() {
      super.display();
      
      for (FilterOption choice : filters) {
        choice.display();
      }
    }
  }
  
  class FilterOption extends UiElement {
    PImage originalPhoto; //the one that the user has been working on
    PImage newPhoto; //like a newPhoto preview of the kernel option, a thumbnail
    int oneTime = 0;
    boolean selected = false;
    float[][] matrix;
    
    FilterOption(Kernel k, int xcor, int ycor) {
      super(xcor, ycor, 107, 67, TRANSPARENT);
      
      matrix = k.getKernelMatrix();
    }
    void clicked() {
      if(super.isHovering()) {
         println("filter option clicked");
         selected = !selected;
         if (selected) {
           stagedPhoto = originalPhoto.copy();
           Kernel another = new Kernel(matrix);
           another.apply(originalPhoto, stagedPhoto);
         }
         else {
           PImage tempPhoto = originalPhoto.copy();
           Kernel another = new Kernel(matrix);
           another.apply(originalPhoto, tempPhoto);
           loadPixels();
           color[] c = pixels.clone();
           image(tempPhoto, (1006-stagedPhoto.width)/2, (704-stagedPhoto.height)/2 + 64);
           loadPixels();
           if (Arrays.equals(pixels, c)) {
             stagedPhoto = originalPhoto.copy();
           }
           else {
             stagedPhoto = tempPhoto.copy();
           }
         }
      }
    }
    void display() {
      display(oneTime);
    }
    void display(int times) {
        canvas.calculateComposition();
        color[][] oldPhotoPixels = canvas.getComposition();
         originalPhoto = createImage(oldPhotoPixels[0].length, oldPhotoPixels.length, ARGB);
         for (int hght = 0; hght < originalPhoto.height; hght++) {
           for (int wdth = 0; wdth < originalPhoto.width; wdth++) {
              originalPhoto.set(wdth, hght, oldPhotoPixels[hght][wdth]);
            }
          }
        if (times == 0) { //have to do this variable wrapper function business or else it's gonna lag up a storm if apply keeps getting called
          newPhoto = originalPhoto.copy();
          Kernel k = new Kernel(matrix);
          k.apply(originalPhoto, newPhoto);
          //if (newPhoto.height > 67) {
          //   newPhoto.resize((int) ((float) newPhoto.width * ( 67.0 / newPhoto.height )), 67);
          //   h = newPhoto.height;
          //} //thumbnail resizing?
          //if (newPhoto.width > 107) {
          //   newPhoto.resize((int) 107, (int)  ((float) newPhoto.height * ( 107 / newPhoto.width )));
          //   w = newPhoto.width;
          //}
          newPhoto.resize(107, 67);
          oneTime++;
        }
      image(newPhoto, super.x, super.y);
    }
  }
  class Kernel {
    float[][] kernel;
    Kernel(float[][] init)
    {
      kernel = new float[3][3];
      for (int i = 0; i < init.length; i++)
      {
        for (int j = 0; j < init[i].length; j++)
        {
          kernel[i][j] = init[i][j];
        }
      }
    }
    float[][] getKernelMatrix() {
      return kernel;
    }
    color calcNewColorTopLeftCorner(PImage img, int x, int y) {
      float convolutedRed = 0.0;
      float convolutedGreen = 0.0;
      float convolutedBlue = 0.0;
      int row = 0;
      for (int i = y-1; i <= y+1; i++) {
        int col = 0;
        for (int j = x-1; j <= x+1; j++) {
          color c;
          if (j == -1 && i == -1) {
            c = img.get(0,0);
          }
          else if (i == -1) {
            c = img.get(j,i+1);
          }
          else if (j == -1) {
            c = img.get(j+1, i);
          }
          else {
            c = img.get(j,i);
          }
          float r = red(c);
          float g = green(c);
          float b = blue(c);
          convolutedRed += (r*kernel[row][col]);
          convolutedGreen += (g*kernel[row][col]);
          convolutedBlue += (b*kernel[row][col]);
          col++;
        }
        row++;
      }
      return color(convolutedRed, convolutedGreen, convolutedBlue);
    }
    color calcNewColorTopRightCorner(PImage img, int x, int y) {
      float convolutedRed = 0.0;
      float convolutedGreen = 0.0;
      float convolutedBlue = 0.0;
      int row = 0;
      for (int i = y-1; i <= y+1; i++) {
        int col = 0;
        for (int j = x-1; j <= x+1; j++) {
          color c;
          if (j == img.width && i == -1) {
            c = img.get(x,y);
          }
          else if (i == -1) {
            c = img.get(j, i+1);
          }
          else if (j == img.width) {
            c = img.get(j-1, i);
          }
          else {
            c = img.get(j,i);
          }
          float r = red(c);
          float g = green(c);
          float b = blue(c);
          convolutedRed += (r*kernel[row][col]);
          convolutedGreen += (g*kernel[row][col]);
          convolutedBlue += (b*kernel[row][col]);
          col++;
        }
        row++;
      }
      return color(convolutedRed, convolutedGreen, convolutedBlue);
    }
     color calcNewColorTopSide(PImage img, int x, int y) {
      float convolutedRed = 0.0;
      float convolutedGreen = 0.0;
      float convolutedBlue = 0.0;
      int row = 0;
      for (int i = y-1; i <= y+1; i++) {
        int col = 0;
        for (int j = x-1; j <= x+1; j++) {
           color c;
           if (i == -1) {
             c = img.get(j, i+1);
           }
           else {
             c = img.get(j,i);
           }
          float r = red(c);
          float g = green(c);
          float b = blue(c);
          convolutedRed += (r*kernel[row][col]);
          convolutedGreen += (g*kernel[row][col]);
          convolutedBlue += (b*kernel[row][col]);
          col++;
        }
        row++;
      }
      return color(convolutedRed, convolutedGreen, convolutedBlue);
    }
    color calcNewColorBottomLeftCorner(PImage img, int x, int y) {
      float convolutedRed = 0.0;
      float convolutedGreen = 0.0;
      float convolutedBlue = 0.0;
      int row = 0;
      for (int i = y-1; i <= y+1; i++) {
        int col = 0;
        for (int j = x-1; j <= x+1; j++) {
          color c;
          if (j == -1 && i == img.height) {
            c = img.get(x, y);
          }
          else if (j == -1) {
            c = img.get(j+1, i);
          }
          else if (i == img.height) {
            c = img.get(j, i-1);
          }
          else {
            c = img.get(j,i);
          }
          float r = red(c);
          float g = green(c);
          float b = blue(c);
          convolutedRed += (r*kernel[row][col]);
          convolutedGreen += (g*kernel[row][col]);
          convolutedBlue += (b*kernel[row][col]);
          col++;       
        }
        row++;
      }
      return color(convolutedRed, convolutedGreen, convolutedBlue);
    }
    color calcNewColorBottomRightCorner(PImage img, int x, int y) {
      float convolutedRed = 0.0;
      float convolutedGreen = 0.0;
      float convolutedBlue = 0.0;
      int row = 0;
      for (int i = y-1; i <= y+1; i++) {
        int col = 0;
        for (int j = x-1; j <= x+1; j++) {
          color c;
          if (j == img.width && i == img.height) {
            c = img.get(x, y);
          }
          else if (j == img.width) {
            c = img.get(j-1, i);
          }
          else if (i == img.height) {
            c = img.get(j, i-1);
          }
          else {
            c = img.get(j,i);
          }
          float r = red(c);
          float g = green(c);
          float b = blue(c);
          convolutedRed += (r*kernel[row][col]);
          convolutedGreen += (g*kernel[row][col]);
          convolutedBlue += (b*kernel[row][col]);
          col++;
        }
        row++;
      }
      return color(convolutedRed, convolutedGreen, convolutedBlue);
    }
    color calcNewColorLeftSide(PImage img, int x, int y) {
      float convolutedRed = 0.0;
      float convolutedGreen = 0.0;
      float convolutedBlue = 0.0;
      int row = 0;
      for (int i = y-1; i <= y+1; i++) {
        int col = 0;
        for (int j = x-1; j <= x+1; j++) {
          color c;
          if (j == -1) {
            c = img.get(j+1, i);
          }
          else {
            c = img.get(j, i);
          }
          float r = red(c);
          float g = green(c);
          float b = blue(c);
          convolutedRed += (r*kernel[row][col]);
          convolutedGreen += (g*kernel[row][col]);
          convolutedBlue += (b*kernel[row][col]);
          col++;
        }
        row++;
      }
      return color(convolutedRed, convolutedGreen, convolutedBlue);
    }
     color calcNewColorRightSide(PImage img, int x, int y) {
      float convolutedRed = 0.0;
      float convolutedGreen = 0.0;
      float convolutedBlue = 0.0;
      int row = 0;
      for (int i = y-1; i <= y+1; i++) {
        int col = 0;
        for (int j = x-1; j <= x+1; j++) {
          color c;
          if (j == img.width) {
            c = img.get(j-1, i);
          }
          else {
            c = img.get(j, i);
          }
          float r = red(c);
          float g = green(c);
          float b = blue(c);
          convolutedRed += (r*kernel[row][col]);
          convolutedGreen += (g*kernel[row][col]);
          convolutedBlue += (b*kernel[row][col]);
          col++;
        }
        row++;
      }
      return color(convolutedRed, convolutedGreen, convolutedBlue);
    }
    color calcNewColorBottomSide(PImage img, int x, int y) {
      float convolutedRed = 0.0;
      float convolutedGreen = 0.0;
      float convolutedBlue = 0.0;
      int row = 0;
      for (int i = y-1; i <= y+1; i++) {
        int col = 0;
        for (int j = x-1; j <= x+1; j++) {
           color c;
           if (i == img.height) {
             c = img.get(j, i-1);
           }
           else {
             c = img.get(j,i);
           }
          float r = red(c);
          float g = green(c);
          float b = blue(c);
          convolutedRed += (r*kernel[row][col]);
          convolutedGreen += (g*kernel[row][col]);
          convolutedBlue += (b*kernel[row][col]);
          col++;
        }
        row++;
      }
      return color(convolutedRed, convolutedGreen, convolutedBlue);
    }
    color calcNewColor(PImage img, int x, int y)
    {
      if (x == 0 || x == img.width - 1 || y == 0 || y == img.height - 1)
      {
        if (x == 0 && y == 0) {
          return calcNewColorTopLeftCorner(img, x, y);
        }
        else if (x == img.width - 1 && y == 0) {
          return calcNewColorTopRightCorner(img, x, y);
        }
        else if (y == 0) {
          return calcNewColorTopSide(img, x, y);
        }
        else if (x == 0 && y == img.height-1){
          return calcNewColorBottomLeftCorner(img, x, y);
        }
        else if (x == img.width - 1 && y == img.height - 1) {
          return calcNewColorBottomRightCorner(img, x, y);
        }
        else if (x == 0) {
          return calcNewColorLeftSide(img, x, y);
        }
        else if (x == img.width - 1) {
          return calcNewColorRightSide(img, x, y);
        }
        else {
          return calcNewColorBottomSide(img, x, y);
        }
      }
      else
      {
        float convolutedRed = 0.0;
        float convolutedGreen = 0.0;
        float convolutedBlue = 0.0;
        int row = 0;
        for (int i = y-1; i <= y+1; i++)
        {
          int col = 0;
          for (int j = x-1; j <= x+1; j++)
          {
            color c = img.get(j,i);
            float r = red(c);
            float g = green(c);
            float b = blue(c);
            convolutedRed += (r*kernel[row][col]);
            convolutedGreen += (g*kernel[row][col]);
            convolutedBlue += (b*kernel[row][col]);
            col++;
          }
          row++;
        }
        return color(convolutedRed, convolutedGreen, convolutedBlue);
      }
    }
    void apply(PImage source, PImage destination)
    {
      for (int i = 0; i < source.width; i++)
      {
        for (int j = 0; j < source.height; j++)
        {
          destination.set(i,j,calcNewColor(source, i, j));
        }
      }
    }
  }
  
  class Navbar extends UiElement {
    private ArrayList<Button> navbarButtons = new ArrayList<Button>();
    
    Navbar() { 
      super(0,0,1366,54,DARK2);
      
      navbarButtons.add(new BackButton());
      navbarButtons.add(new ContinueButton());
    }
    
    void clicked() {
      if(super.isHovering()) {
         println("Navbar clicked"); 
         
         for(Button b : navbarButtons) {
            b.clicked(); 
         }
      }
    }
    
    void display() {
      super.display();
      
      for(Button b : navbarButtons) {
        b.display(); 
      }
    }
    
    class BackButton extends Button {
      BackButton() {
        super("Back", 12, 12, 100, 40,DARK1, color(255));
      }
      
      void clicked() {
        if(mouseX >= super.x && mouseX < super.x + super.w && mouseY >= super.y && mouseY < super.y + super.h) {
          scene--;
          stagedPhoto = null;
        }
      }
      
      
    }
    class ContinueButton extends Button {
      ContinueButton() {
        super("Continue", 1230, 17, 117, 31, PRIMARY, color(255));
      }
      void clicked() {
        if(mouseX >= super.x && mouseX < super.x + super.w && mouseY >= super.y && mouseY < super.y + super.h) {
          scene++;
        }
      }
    }
  }
}
