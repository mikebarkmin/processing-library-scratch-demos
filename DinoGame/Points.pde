class Points extends ScratchSprite {
  
  int points = 0;
  PFont font;
  
  Points() {
    super("points", "assets/points.png");
    this.setSize(20);
    this.setPosition(width - 100, height - 40);
  }
  
  void draw() {
    super.draw();
    textAlign(CENTER);
    textSize(28);
    text(points, this.getX() + 8, this.getY() + 8);
  }
}
