class Ground extends ScratchSprite {
  
  ArrayList<GroundTile> groundTiles;
  int numberGroundTiles;
  
  Ground() {
    // hitbox and tiles are 128 x 128
    super("ground", "assets/ground_hitbox.png");
    numberGroundTiles = (int) Math.ceil(width / 128.0) + 4;
    groundTiles = new ArrayList();
    
    this.setY(height - 16);
    
    for(int i = 0; i < numberGroundTiles; i++) {
      GroundTile g = new GroundTile();
      groundTiles.add(g);
      g.setY(this.getY());
      g.setX(i * 127);
    }
  }
  
  void draw() {
    super.draw();
    for(GroundTile groundTile : groundTiles) {
      groundTile.draw();
      if(gameState == GameState.RUN) {
        groundTile.move(-speed);
      }
      float offset = groundTile.getX() + groundTile.getWidth();
      if(offset < 0) {
         groundTile.setX((numberGroundTiles - 1) * 127 + offset);
      }
    }
  }
}
