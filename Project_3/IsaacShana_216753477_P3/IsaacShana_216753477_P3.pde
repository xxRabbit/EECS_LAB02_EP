/**
 EECS 1710 LAB02
 Author: Shana Isaac
 Student number: 216753477
 Project 3: Custom Pixel
 **/

PImage img1, img2, img3, img4, img5, img6, img7;
ArrayList<Dot> dots;
ArrayList<PVector> targets1, targets2, targets3, targets4, targets5, targets6, targets7;
int scaler = 1; 
int threshold = 200;
boolean imageToggled = false;
color col1, col2;

void setup() {
  size(50, 50, P2D);  
  img1 = loadImage("leaves.png");
  img2 = loadImage("tulips.png");
  img3 = loadImage("butterfly.png");
  img4 = loadImage("Aleaves.jpg");
  img5 = loadImage("pumpkin.png");
  img6 = loadImage("winter1.jpg");
  img7 = loadImage("gifts.png");

  // set the window size to the largest sides of each image
  int w, h;
  if (img1.width > img2.width) {
    w = img1.width;
  } else {
    w = img2.width;
  }
  if (img1.height > img2.height) {
    h = img1.height;
  } else {
    h = img2.height;
  }
 

   if (img3.width > img4.width) {
    w = img3.width;
  } else {
    w = img4.width;
  }
  if (img3.height > img4.height) {
    h = img3.height;
  } else {
    h = img4.height;
  }
  surface.setSize(w, h);

  img1.loadPixels();
  img2.loadPixels();
  img3.loadPixels();
  img4.loadPixels();
  img5.loadPixels();
  img6.loadPixels();
  img7.loadPixels();

  targets1 = new ArrayList<PVector>();
  targets2 = new ArrayList<PVector>();
  targets3 = new ArrayList<PVector>();
  targets4 = new ArrayList<PVector>();
  targets5 = new ArrayList<PVector>();
  targets6 = new ArrayList<PVector>();
  targets7 = new ArrayList<PVector>();

  col1 = color(255, 127, 0, 63);
  col2 = color(0, 127, 255, 63);

  for (int x = 0; x < img2.width; x += scaler) {
    for (int y = 0; y < img2.height; y += scaler) {
      // this translates x and y coordinates into a location in the pixels array
      int loc = x + y * img2.width;

      if (brightness(img2.pixels[loc]) > threshold) {
        targets2.add(new PVector(x, y));
      }
    }
  }

  for (int x = 0; x < img3.width; x += scaler) {
    for (int y = 0; y < img3.height; y += scaler) {
      // this translates x and y coordinates into a location in the pixels array
      int loc = x + y * img3.width;

      if (brightness(img3.pixels[loc]) > threshold) {
        targets3.add(new PVector(x, y));
      }
    }
  }

  dots = new ArrayList<Dot>();

  for (int x = 0; x < img1.width; x += scaler) {
    for (int y = 0; y < img1.height; y += scaler) {
      int loc = x + y * img1.width;

      if (brightness(img1.pixels[loc]) > threshold) {
        int targetIndex = int(random(0, targets2.size()));
        targets1.add(new PVector(x, y));
        Dot dot = new Dot(x, y, col1, targets2.get(targetIndex));
        dots.add(dot);
      }
    }
  }
}

void draw() { 
  background(0);

  blendMode(ADD);

  boolean flipTargets = true;

  for (Dot dot : dots) {
    dot.run();
    if (!dot.ready) flipTargets = false;
  }

  if (flipTargets) {
    for (Dot dot : dots) {
      if (!imageToggled) {
        int targetIndex = int(random(0, targets1.size()));
        dot.target = targets1.get(targetIndex);
        dot.col = col2;
      } else {
        int targetIndex = int(random(0, targets2.size()));
        dot.target = targets2.get(targetIndex);
        dot.col = col1;
      }
    }
    imageToggled = !imageToggled;
  }

  surface.setTitle("" + frameRate);
}

class Dot {

  PVector position, target;
  color col;
  float speed;
  float dotSize;
  boolean ready;

  Dot(float x, float y, color _col, PVector _target) {
    position = new PVector(x, y);
    col = _col;
    target = _target;
    speed = 0.02;
    dotSize = 5;
    ready = false;
  }

  void update() {
    position.lerp(target, speed);
    ready = position.dist(target) < 5;
  }

  void draw() {
    stroke(col);
    strokeWeight(dotSize);
    point(position.x, position.y);
  }

  void run() {
    update();
    draw();
  }
}
