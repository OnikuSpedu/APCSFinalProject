abstract class UiElement {
 
 float x, y, w, h;
 color bgColor;
 
 UiElement(float x, float y, float w, float h, color bgColor) {
   this.x = x;
   this.y = y;
   this.w = w;
   this.h = h;
   this.bgColor = bgColor;

 }
 
 abstract void display();

 boolean isHovering() {
   return mouseX >= x && mouseX < x + w && mouseY >= y && mouseY < y + h;
 }
 
 void clicked() {};
 void released() {};
 void pressed() {};
 void dragged() {};
 
}
