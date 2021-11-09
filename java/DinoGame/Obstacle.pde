class Obstacle extends ScratchSprite {
  Obstacle() {
    super("small", "assets/bush.png");
    this.addCostume("big", "assets/double_bush.png");

    this.setX(width + random(100));

    this.setY(height - this.getHeight()/2.0 - 64);
  }

  void reset() {
    this.setX(width + random(150));
    this.setY(height - this.getHeight()/2.0 - 64);
    if (Math.round(random(0, 2)) == 1) {
      this.switchCostume("big");
    } else {
      this.switchCostume("small");
    }
    this.setX(width + random(150));
    this.setY(height - this.getHeight()/2.0 - 64);
  }

  void draw() {
    super.draw();
    this.move(-speed);
    if (this.isTouchingSprite(dino)) {
      dino.state = DinoState.DEAD;
      gameState = GameState.DEAD;
    }
    if (this.getX() + this.getWidth() < 0) {
      this.reset();
      points.points++;
      speed += 0.1;
    }
  }
}
