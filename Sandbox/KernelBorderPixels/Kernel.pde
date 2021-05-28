public class Kernel
{
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
