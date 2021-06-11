class Screen extends UiElement {
   private ArrayList<UiElement> elements;
   
   Screen() {
     super(0,0, width, height, DARK4);
     elements = new ArrayList<UiElement>();
   }
   
   void display() {
     super.display();
     
     for (UiElement e : elements) {
        e.display(); 
     }
   }
   
   void clicked() {
     for (UiElement e : elements) {
        e.clicked();
     }
   }
   
   void pressed() {
     for (UiElement e : elements) {
        e.pressed();
     }
   }
   
   void dragged() {
     for (UiElement e : elements) {
        e.dragged();
     }
   }
   
   void released() {
     for (UiElement e : elements) {
        e.released();
     }
   }
   ArrayList<UiElement> getElements() {
     return elements;
   }
}
