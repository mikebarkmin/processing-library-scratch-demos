class Character extends ScratchSprite {
  
  String[] animation;
  int animationFrame = 0;
  boolean animationPlayed = false;
  
  Character(String pattern, int frames) {
    animation = new String[frames];
    for(int i = 0; i < frames; i++) {
      String name = "animation_" + i;
      this.addCostume(name, String.format(pattern, i));
      animation[i] = name;
    }
    this.addTimer("animation");
  }

  void resetAnimation() {
    animationFrame = 0;
    animationPlayed = false;
  }

  void playAnimation(boolean once) {
    if (this.getTimer("animation").everyMillis(400)) {
      if (!animationPlayed && animationFrame != animation.length - 1|| !once) {
        animationFrame = (animationFrame + 1) % animation.length;
        this.switchCostume(animation[animationFrame]);
      }
    }
  }
  
  void draw() {
    super.draw();
    this.playAnimation(false);
  }
}
