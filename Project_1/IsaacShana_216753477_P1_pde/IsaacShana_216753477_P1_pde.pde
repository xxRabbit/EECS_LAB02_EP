PVector position, target;
boolean
void setup() {
  size (800, 600, P2D);
  
  position = new PVector(width/2, height/2);
  target = new PVector(0, 0);
  
  ellipseMode(CENTER);

}

void draw() {
  background (127);
  position = position.lerp(target, 0.1);
  if (position.dist(target) < 5) {
    target = new PVector (random(width), random(height));
  }
  
  ellipse(mouseX, mouseY, 20, 20);

}
