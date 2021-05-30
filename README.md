# APCSFinalProject

**Team: The GausAsian Blurs**

**Members: Shadman Rakib and Rickey Dong**

[Click here to view prototype](https://docs.google.com/document/d/1v86gLCIc_fpCpbqTkr9O91Ksm-02LF-ZXFgFz6FKAlg/edit?usp=sharing)

**Brief Project Description:**

For our final project, we are going to create a photo editor similar to Photoshop in Processing. This photo editor would allow users to import a photo from their computer and edit it in the application, and they can save their work at the end. Some features include using kernels to convolute the image, drawing on the picture with various colors, and adding stickers. Image convolution with kernels should account for the border pixels by using edge extension.

## 📃 Development Log
### May 24, 2021 (Monday)
- **Shadman** 🧰  
    Created a dev branch to ensure that the main branch always has functioning code. Created initial files and global variables for color palette.
    
- **Rickey** 🎈  
    Experimented with file handling for importing and saving images. Discovered that you can successfully choose a file to load in, edit and save it under a specific directory name, and access all of the images under a directory as an array.
    
### May 25, 2021 (Tuesday)
- **Shadman** 🧰  
    Designed Figma sketches for how the different screens in the app would look.

- **Rickey** 🎈  
    Created a Sandbox directory in the dev branch where all the experimental code snippets can be stored for later use. Also found out that I was using wrong vocabulary term: it is not normalization that handles edges; it is edge extension.
    
### May 26, 2021 (Wednesday)
- **Shadman** 🧰  
    Created an abstract class called UiElement so that UI elements can be displayed and interacted with easily. Created the initial parts of the toolbar and sidebar. Created Button class with on press and on hover rendering.

- **Rickey** 🎈  
    Worked on creating abstract UiElement class and Button class along with Shadman while he screenshared.
    
### May 28, 2021 (Friday)
- **Shadman** 🧰  
    Created start screen. Implemented buttons to move between the start screen and upload screen. Created controlled input elements to take canvas width and height.

- **Rickey** 🎈  
    Implemented modified kernel convolution algorithm complete with edge extension to handle the border pixels.

### May 29, 2021 (Saturday)
- **Shadman** 🧰  
    Created canvas and layer classes. Connected start screen create and import buttons to the editor screen through initializing a canvas. Loaded images into 2D color arrays. Created buttons and corresponding methods to create new transparent layers and import a new image as a layer. Created a display method for canvas that uses alpha compositing to render the layers and preserve the transparent effect. Merged and resolved conflicts in Rickey's code and my code.

- **Rickey** 🎈  
    Completely overhauled/updated the UML diagram and added it to the prototype.
