import processing.sound.*;
import eu.barkmin.processing.scratch.*;

Player player;
ScratchStage stage;

int level;

void setup() {
  size(800, 1000, P2D);
  ScratchStage.init(this);
  stage = ScratchStage.getInstance();
  player = new Player();
  stage.addSprite(player);

  play();
}

void play() {
  level = 1;
  player.setPosition(width / 2, height - 40);

  generatePlatforms();
  generateEnemies();
}

void generatePlatforms() {

  // platform below player
  stage.removeSprites(Platform.class);
  stage.addSprite(new Platform(width / 2, height - 10));

  int neededPlatforms = Math.round(height / player.JUMP_HEIGHT);
  int numberOfPlatforms = Math.round(neededPlatforms + random(5));
  for (int i = 0; i < numberOfPlatforms; i++) {
    if (neededPlatforms > 0) {
      float y = constrain(height - i*player.JUMP_HEIGHT - random(5), 40, height - 40);
      float x = random(60, width - 60);
      stage.addSprite(new Platform(x, y));
      neededPlatforms--;
    } else {
      stage.addSprite(new Platform(random(60, width - 60), random(20, height - 20)));
    }
  }
}


void generateEnemies() {
  stage.removeSprites(Enemy.class);
  for (int i = 0; i < level; i++) {
    int e = Math.round(random(0, 3));
    Enemy enemy = null;
    switch (e) {
    case 0:
      enemy = new Frank();
      break;
    case 1:
      enemy = new Daisy();
      break;
    default:
      enemy = new Bernd();
      break;
    }
    float x = random(60, width - 60);
    float y = random(60, height - 60);
    
    while(x > player.getX() - player.getWidth() && x < player.getX() + player.getWidth()) {
      x = random(60, width - 60);
    }
    enemy.setPosition(x, y);
    
    stage.addSprite(enemy);
  }
}

void keyPressed() {
  if (keyCode == 82) {
    play();
  }
}

void draw() {
  if (stage.findSprites(Enemy.class).size() == 0) {
    level++;
    generateEnemies();
  }

  fill(0);
  textAlign(CENTER);
  text("Level: " + level, width / 2, 20);
}
