class Daisy extends Enemy {

  int distance = Math.round(random(40, 80));
  int currentDistance = 0;
  boolean up = false;

  Daisy(int x, int y) {
    super("daisy");
    this.setPosition(x, y);
  }

  Daisy() {
    super("daisy");
  }

  void draw() {
    super.draw();
    if (currentDistance >= distance) {
      up = true;
    } else if (currentDistance <= -distance) {
      up = false;
    }

    if (!up) {
      this.changeY(+1);
      currentDistance++;
    } else {
      this.changeY(-1);
      currentDistance--;
    }
  }
}
