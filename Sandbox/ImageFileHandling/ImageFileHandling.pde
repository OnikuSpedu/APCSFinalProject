PImage img;
ArrayList<PImage> gallery = new ArrayList<PImage>(); //arraylist of images in the gallery/ directory
boolean chosen = false; //has the user imported an image yet?
void setup() {
  size(1400, 900);
  //selectInput("Select a file to process:", "fileSelected"); this makes a prompt where user imports a photo from device
  //while (!chosen){} //because processing is multithreaded, have to wait until user chose an image
  //image(img, 0, 0);
  //editImage();
  //image(img, img.width, 0);
  //img.save("gallery/new_redCar.jpg"); saves the newly edited image into a gallery directory and names it new_redCar.jpg
  String[] fileNames = listFileNames(sketchPath()+"/gallery"); //gets all the images located in gallery directory and puts it into array
  for (String f : fileNames)
  {
    gallery.add(loadImage(sketchPath()+"/gallery/"+f)); //add each image to gallery arraylist
  }
  int x = 0;
  int y = 0;
  for (PImage pimg : gallery)
  {
    image(pimg, x,y);
    x+=pimg.width;
  }
}

String[] listFileNames(String dir) { //function to return a string array of files in a directory
  File file = new File(dir);
  if (file.isDirectory()) {
    String names[] = file.list();
    return names;
  } else {
    // If it's not a directory
    return null;
  }
}

void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    img = loadImage(selection.getAbsolutePath()); //provided that user selected an image, it gets put into img variable
    chosen = true; //the user has chosen an image
  }
}

void editImage() {
  for (int x = 0; x < img.width; x++) {
    for (int y = 0; y < img.height; y++) {
        img.set(x,y,color(0));
    }
  }
}
