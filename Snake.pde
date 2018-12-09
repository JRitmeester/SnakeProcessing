class Snake {

  private ArrayList<PVector> body = new ArrayList<PVector>();
  private int dir;
  PVector startLocation = new PVector(blocksHor/2*blockSize, blocksVer/2*blockSize);
  PVector headPos = new PVector(startLocation.x, startLocation.y, 0);
  boolean stretch = false;
  int partCounter = 0;
  boolean dead = false;

  public Snake() {
    body.add(startLocation);
    dir = 0;
    partCounter++;
  }

  public void move() {
    //    3
    //  2 x 0
    //    1

    if (!stretch) {
      int min = Integer.MAX_VALUE;
      for (PVector part : body) {
        if (part.z < min) {
          part.z = min;
        }
      }
      for (PVector part : body) {
        body.remove(part);
        break;
      }
    }

    if (keyCode == UP && dir != 1) {
      dir = 3;
    }
    if (keyCode == DOWN && dir != 3) {
      dir = 1;
    }

    if (keyCode == LEFT && dir != 0) {
      dir = 2;
    }
    if (keyCode == RIGHT && dir != 2) {
      dir = 0;
    }
    
    PVector newHeadPos = null;
    if (dir == 0) {
      // Move right
      newHeadPos = new PVector(headPos.x + blockSize, headPos.y, partCounter);
    }
    if (dir == 1) {
      // Move down
      newHeadPos = new PVector(headPos.x, headPos.y + blockSize, partCounter);
    }
    if (dir == 2) {
      // Move left
      newHeadPos = new PVector(headPos.x - blockSize, headPos.y, partCounter);
    }
    if (dir == 3) {
      // Move up
      newHeadPos = new PVector(headPos.x, headPos.y - blockSize, partCounter);
    }

    boolean col = collision();
    println(col);
    if (col) {
      dead = true;
    }

    partCounter++;
    stretch = false;
    body.add(newHeadPos);
    headPos = newHeadPos;
  }

  public void update() {
    for (Apple a : apples) {
      if (a.hit()) {
        stretch = true;
        // Award score.
      }
    }
  }

  public void show() {
    for (PVector pv : body) {
      fill(127);
      noStroke();
      rect(pv.x, pv.y, blockSize, blockSize);
    }
  }

  public PVector getHeadPos() {
    return headPos;
  }

  boolean collision() {
    for (PVector p : body) {
      if (p == headPos) {
        continue;
      }
      if (headPos.x == p.x && headPos.y == p.y) {
        println("Crashed into yourself!");
        return true;
      }
    }
    if (headPos.x > width || headPos.y > height || headPos.x < 0 || headPos.y < 0) {
      println("You went out of the map!");
      return true;
    }
    return false;
  }
}