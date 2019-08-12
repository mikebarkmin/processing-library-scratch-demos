enum DinoState {
  IDLE, JUMP, RUN, DEAD, FALL
}

class Dino extends ScratchSprite {

  DinoState state;
  String path = "assets/dino/";
  HashMap<DinoState, String[]> animations;
  int animationFrame = 0;
  boolean animationPlayed = false;

  final int FALL_SPEED = 3;
  final int JUMP_SPEED = 3;
  final int JUMP_HEIGHT = 50;
  final int GROUND_LEVEL = height - 108;

  Dino() {
    state = DinoState.IDLE;
    animations = new HashMap();
    this.addAnimationForState("Idle (%d).png", 10, DinoState.IDLE);
    this.addAnimationForState("Jump (%d).png", 6, DinoState.JUMP);
    this.addAnimationForState("Fall (%d).png", 6, DinoState.FALL);
    this.addAnimationForState("Run (%d).png", 8, DinoState.RUN);
    this.addAnimationForState("Dead (%d).png", 8, DinoState.DEAD);
    this.setX(120);
    this.setY(GROUND_LEVEL);
    this.addTimer("animation");

    int[] xPoints = {20, 64, 64, 20};
    int[] yPoints = {12, 12, 88, 88};
    this.setHitbox(xPoints, yPoints);
  }

  void addAnimationForState(String filePattern, int frames, DinoState state) {
    String[] animation = new String[frames];
    for (int i = 0; i < animation.length; i++) {
      String name = state.name() + "_" + i;
      String file = String.format(filePattern, i+1);
      this.addCostume(name, path + file);
      animation[i] = name;
    }
    animations.put(state, animation);
  }

  void resetAnimation() {
    animationFrame = 0;
    animationPlayed = false;
  }

  void playAnimation(boolean once) {

    if (this.getTimer("animation").everyMillis(120)) {
      String[] animation = animations.get(state);
      if (!animationPlayed && animationFrame != animation.length - 1|| !once) {
        animationFrame = (animationFrame + 1) % animation.length;
        this.switchCostume(animation[animationFrame]);
      }
    }
  }

  void draw() {
    super.draw();
    switch (state) {
    case IDLE:
    case RUN:
      if (isKeyPressed(32)) {
        state = DinoState.JUMP;
        resetAnimation();
      }
      this.playAnimation(false);
      break;
    case JUMP:
      if (this.getY() > JUMP_HEIGHT) {
        this.setY(this.getY() - JUMP_SPEED);
      } else {
        this.setY(JUMP_HEIGHT);
        state = DinoState.FALL;
        resetAnimation();
      }
      this.playAnimation(true);
      break;
    case FALL:
      if (this.getY() <= GROUND_LEVEL) {
        this.setY(this.getY() + FALL_SPEED);
      } else {
        this.setY(GROUND_LEVEL);
        state = DinoState.RUN;
        resetAnimation();
      }
      this.playAnimation(true);
      break;
    case DEAD:
      this.setY(GROUND_LEVEL);
      this.playAnimation(true);
      break;
    }
  }
}
