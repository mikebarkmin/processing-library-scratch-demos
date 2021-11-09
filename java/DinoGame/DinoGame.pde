import processing.sound.*;
import eu.barkmin.processing.scratch.*;

ScratchStage stage;
Button play, restart;
Dino dino;
Ground ground;
Points points;
Obstacle obstacle;
float speed;

enum GameState {
  START, RUN, DEAD
}

GameState gameState = GameState.START;

void setup() {
  size(800, 300, P2D);
  ScratchStage.init(this, false);
  stage = ScratchStage.getInstance();
  stage.addBackdrop("bg", "assets/background.png");

  play = new PlayButton();
  restart = new RestartButton();
  ground = new Ground();
  dino = new Dino();
  points = new Points();
  obstacle = new Obstacle();
}

void startGame() {
  speed = 2;
  points.points = 0;
  gameState = GameState.RUN;
  dino.state = DinoState.RUN;
  obstacle.reset();
}

void draw() {
  switch(gameState) {
  case START:
    play.draw();
    ground.draw();
    dino.draw();
    break;
  case RUN:  
    ground.draw();
    dino.draw(); 
    obstacle.draw();
    points.draw();
    break;
  case DEAD:
    ground.draw();
    dino.draw();
    restart.draw();
    points.draw();
    break;
  }
}
