PImage img;
void setup() {
  size(200,200);
  img = loadImage("redcar.jpg");
  img.resize(200,200);
  PImage output = img.copy();
  Kernel k = new Kernel( new float[][]    { {0, -1, 0},
                                            {-1, 5, -1},
                                            {0, -1, 0} } );
  k.apply(img,output);
  //for (int x = 0; x <= 200; x++){
  //  output.set(x,199,color(255,0,0)); //IN A 200x200 IMAGE, IT IS EXCLUSIVE SO YOU CAN ONLY ACCESS 199, NOT 200
  //}
  //img.width or .height returns 200
  image(output,0,0);
}
