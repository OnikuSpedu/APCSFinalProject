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
  color calcNewColor(PImage img, int x, int y)
  {
    if (x == 0 || x == img.width - 1 || y == 0 || y == img.height - 1)
    {
      return color(0);
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
