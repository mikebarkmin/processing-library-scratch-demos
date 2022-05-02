class Enemy extends ScratchAnimatedSprite {
  Enemy(String name) {
    this.addAnimation("default", "assets/" + name + "_%1d.png", 2);
  }
  
  void run() {
    this.playAnimation("default");
  }
}
