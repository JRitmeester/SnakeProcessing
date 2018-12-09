// 54 minutes

int blockSize = 40;
int blocksHor = 20;
int blocksVer = 20;

long lastUpdate = 0;;
int interval = 500;

ArrayList<Apple> apples = new ArrayList<Apple>();
ArrayList<Apple> deadApples = new ArrayList<Apple>();
int spawnDelay = round(random(10));

Snake snake = new Snake();

void setup() {
  size(801, 801);
}

void draw() {
  background(-1);
  for (int y = 0; y < height; y += blockSize) {
    for (int x = 0; x < width; x += blockSize) {
      strokeWeight(1);
      stroke(0);
      line(x, 0, x, height);
      line(0, y, width, y);
    }
  }
  
  if (millis() > lastUpdate + interval && !snake.dead) {
    spawnDelay--;
    lastUpdate = millis();
    snake.move();
    if (spawnDelay <= 0) {
      spawnDelay = round(random(10));
      apples.add(new Apple(round(random(blocksHor)) * blockSize, round(random(blocksVer))*blockSize));
    }
  }
  
  snake.update();
  snake.show();
  
  apples.removeAll(deadApples);
  deadApples.clear();
  for (Apple a : apples) {
    a.show();
  }
}