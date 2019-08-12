import processing.sound.*;
import eu.barkmin.processing.scratch.*;

ArrayList<Enemy> enemies;
ArrayList<Platform> platforms;
Player player;

int level;

void setup() {
  size(800, 1000, P2D);
  ScratchStage.init(this);

  play();
}

void play() {
  level = 1;
  player = new Player();
  player.setPosition(width / 2, height - 40);

  platforms = new ArrayList();

  // platform below player
  platforms.add(new Platform(width / 2, height - 10));

  int neededPlatforms = Math.round(height / player.JUMP_HEIGHT) + 4;
  int numberOfPlatforms = Math.round(neededPlatforms + random(5));
  for (int i = 0; i < numberOfPlatforms - 1; i++) {
    if (neededPlatforms > 0) {
      platforms.add(new Platform(random(60, width - 60), height - i*player.JUMP_HEIGHT - random(5)));
      neededPlatforms--;
    } else {
      platforms.add(new Platform(random(60, width - 60), random(20, height - 20)));
    }
  }

  generateEnemies();
}


void generateEnemies() {
  enemies = new ArrayList();

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
    enemy.setPosition(random(60, width - 60), random(60, height - 60));
    enemies.add(enemy);
  }
}

void keyPressed() {
  if (keyCode == 82) {
    play();
  }
}

void draw() {
  for (Platform platform : platforms) {
    platform.draw();
  }
  for (Enemy enemy : enemies) {
    enemy.draw();
  }
  player.draw();

  if (enemies.size() == 0) {
    level++;
    generateEnemies();
  }

  fill(0);
  textAlign(CENTER);
  text("Level: " + level, width / 2, 20);
}
