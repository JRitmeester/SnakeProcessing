class Apple {

  PVector pos;
  public Apple(int x, int y) {
    pos = new PVector(x, y);
  }

  boolean hit() {
    PVector headPos = snake.getHeadPos();
    if (headPos.x == pos.x && headPos.y == pos.y) {
      deadApples.add(this);
      return true;
    } else {
      return false;
    }
  }

  public void show() {
    fill(255,0,0);
    noStroke();
    rect(pos.x, pos.y, blockSize, blockSize);
  }
}