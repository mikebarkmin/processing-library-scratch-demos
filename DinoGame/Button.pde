enum ButtonState {
  IDLE, HOVER, DOWN
}

class Button extends ScratchSprite {
  
  ButtonState state;
  
  Button(String path) {
    state = ButtonState.IDLE;
    this.addCostume("idle", path + "idle.png");
    this.addCostume("down", path + "down.png");
    this.addCostume("hover", path + "hover.png");
    
    this.setSize(20);
  }
  
  void onDown() {}
  
  void draw() {
    super.draw();
    
    switch (state) {
      case IDLE:
        this.switchCostume("idle");
        if(isTouchingMousePointer()) {
          state = ButtonState.HOVER;
        }
        break;
      case HOVER:
        this.switchCostume("hover");
        if(isTouchingMousePointer()) {
          if(isMouseDown()) {
            state = ButtonState.DOWN;
            onDown();
          }
        } else {
          state = ButtonState.IDLE;
        }
        break;
      case DOWN:
        this.switchCostume("down");
        if (!isMouseDown()) {
          state = ButtonState.IDLE;
        }
        break;        
    }
  }
}
