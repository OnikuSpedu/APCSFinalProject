abstract class Button extends UiElement {
  private float x, y, w, h;
  private color bgColor, fontColor;
  private String label;
  
  Button(String label, float x, float y, float w, float h, color bgColor, color fontColor) { 
    this.label = label;
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.bgColor = bgColor;
    this.fontColor = fontColor;
  }
  
  abstract void click();
  
  void display() {
    fill(bgColor);
    rect(x, y, w, h);
    textAlign(CENTER);
    textSize(16);
    fill(fontColor);
    text(label, x + (w / 2), y + h / 2 + 6); 
    
    if(isHovering()) {
        if (mousePressed) 
          pressedIndicator();
        else 
          onHover();
    }
    
  }
  
  void onHover() {
    fill(color(255,255,255, 100));
    rect(x, y, w, h);
  }
  
  void pressedIndicator() {
    fill(color(0,0,0, 100));
    rect(x, y, w, h);
  }
  
  boolean isHovering() {
    if(mouseX >= x && mouseX < x + w && mouseY >= y && mouseY < y + h) {
        return true;
    }
    return false;
  }
}
