class Bernd extends Enemy {
  
  boolean scaled = false;
  
  Bernd(int x, int y) {
    super("bernd");
    this.setPosition(x, y);
  }
  
  Bernd() {
    super("bernd");
  }
  
  void run() {
    super.run();
    if (this.getTimer().everyMillis(1000)) {
      scaled = !scaled;
    }
    if (scaled) {
      this.setSize(150);
    } else {
      this.setSize(100);
    }
  }
}
