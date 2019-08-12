import java.util.Iterator;

enum PlayerState {
  IDLE, JUMP, FALL, DEAD
}
 
class Player extends Character {
  
  final float FRICTION = 0.99;
  final float GRAVITY = 0.5;
  final float JUMP_STRENGTH = 20;
  final float JUMP_HEIGHT = 280;
  final float SPEED = 10;
  
  float velocityX = 0;
  float velocityY = 0;
  
  PlayerState state = PlayerState.IDLE;
  
  // a sprite only for hit detection with plaforms
  ScratchSprite platformHit;
    
  Player() {
    super("assets/player_%d.png", 2);
    
    platformHit = new ScratchSprite("platform", "assets/player_hitbox.png");
    
    int[] xPoints = {0, 80, 80, 0};
    int[] yPoints = {0, 0, 35, 35};
    
    this.setHitbox(xPoints, yPoints);
    platformHit.setTransparency(0);
  }
  
  void accelerate(float accelerationX, float accelerationY) {
    velocityX += accelerationX;
    velocityY += accelerationY;
    if (velocityY < 0) {
      state = PlayerState.FALL;
    } else if (velocityY > 0) {
      state = PlayerState.JUMP;
    } else {
      state = PlayerState.IDLE;
    }
  }
  
  void move(float xDelta, float yDelta) {
    this.changeX(xDelta);
    this.changeY(yDelta);
    
    if(this.getX() < 0) {
      this.setX(width);
    }
    
    if(this.getX() > width) {
      this.setX(0);
    }
  }
  
  void moveRight() {
    move(SPEED, 0);
  }
  
  void moveLeft() {
    move(-SPEED, 0);
  }
  
  void jump() {
      accelerate(0, JUMP_STRENGTH);
      state = PlayerState.JUMP;
  }
  
  void draw() {
    super.draw();
    
    if(state == PlayerState.DEAD) {
      velocityY += -GRAVITY;
      setTint(255);
      move(-velocityX, -velocityY);
      return;
    }
    
    if(state != PlayerState.IDLE && isKeyPressed(37)) {
      moveLeft();
    }
    if(state != PlayerState.IDLE && isKeyPressed(39)) {
      moveRight();
    }
    move(-velocityX, -velocityY);
    velocityX *= FRICTION;
    velocityY *= FRICTION;
    
    accelerate(0, -GRAVITY);
    
    platformHit.setPosition(this.getX(), this.getY());
    platformHit.draw();
    
    // collesion detection
    if (state != PlayerState.JUMP) {
      for(Platform platform : platforms) {
        if (platform.isTouchingSprite(platformHit)) {
          velocityY = 0;
          state = PlayerState.IDLE;
          this.setY(platform.getY() - 20);
          jump();
        }
      }
    }
    
    // collision detection with enemy
    Iterator<Enemy> itr = enemies.iterator();
    while(itr.hasNext()) {
      Enemy enemy = itr.next();
      if(enemy.isTouchingSprite(platformHit)) {
        itr.remove();
        velocityY = 0;
        state = PlayerState.IDLE;
        jump();
      } else if(enemy.isTouchingSprite(this)) {
        state = PlayerState.DEAD;
      }
    }
  }
}
