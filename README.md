# APCSFinalProject

**Team: The GausAsian Blurs**

**Members: Shadman Rakib and Rickey Dong**

[Click here to view prototype](https://docs.google.com/document/d/1v86gLCIc_fpCpbqTkr9O91Ksm-02LF-ZXFgFz6FKAlg/edit?usp=sharing)

**Brief Project Description:**

For our final project, we are going to create a photo editor similar to Photoshop in Processing. This photo editor would allow users to import a photo from their computer and edit it in the application, and they can save their work at the end. Some features include using kernels to convolute the image, drawing on the picture with various colors, and adding stickers. Image convolution with kernels should account for the border pixels by using edge extension.

## 📃 Development Log
### Day 1: May 24, 2021

- **Shadman** 
    Created initial files and global variables for color palette.
    
- **Rickey** 🎈  
    Experimented with file handling for importing and saving images. Discovered that you can successfully choose a file to load in, edit and save it under a specific directory name, and access all of the images under a directory as an array.
    
### Day 2: May 25, 2021
- **Rickey** 🎈  
    Created a Sandbox directory in dev branch where all the experimental code snippets can be stored for later use. Also found out that I was using wrong vocabulary term: it is not normalization that handles edges; it is edge extension.

- **Shadman** 
    Designed Figma sketches for how the different screens in the app.
    
### Day 3: May 25, 2021
- **Shadman** 
    Created an abstract class called UiElements so that UI elements can be displayed and interacted with easily. Create the initial parts of the toolbar and sidebar.
