abstract class Button extends UiElement {
  private color fontColor;
  private String label;
  
  Button(String label, float x, float y, float w, float h, color bgColor, color fontColor) { 
    super(x, y, w, h, bgColor);
    this.label = label;
    this.fontColor = fontColor;
  }
  
  abstract void clicked();
  
  void display() {
    super.display();
    
    textAlign(CENTER);
    textSize(16);
    fill(fontColor);
    text(label, super.x + (super.w / 2), super.y + super.h / 2 + 6); 
    
    if(isHovering()) {
        if (mousePressed) 
          pressedIndicator();
        else 
          onHover();
    }
    
  }
  
  boolean isHovering() {
    return super.isHovering();
  }
  
  void onHover() {
    fill(color(255,255,255, 100));
    rect(x, y, w, h);
  }
  
  void pressedIndicator() {
    fill(color(0,0,0, 100));
    rect(x, y, w, h);
  }
}
