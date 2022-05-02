class Frank extends Enemy {

  int distance = Math.round(random(20, 40));
  int currentDistance = 0;
  boolean back = false;
  
  Frank(int x, int y) {
    super("frank");
    this.setPosition(x, y);
  }

  Frank() {
    super("frank");
  }
  
  void run() {
    super.run();
    if (currentDistance >= distance) {
      back = true;
    } else if (currentDistance <= -distance) {
      back = false;
    }
    
    if(!back) {
      this.move(1);
      currentDistance++;
    } else {
      this.move(-1);
      currentDistance--;
    }
  }
}
