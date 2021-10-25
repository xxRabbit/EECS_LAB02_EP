/**
 EECS 1710 LAB02
 Author: Shana Isaac
 Student Number: 216753477
 Midterm Project: One Button Game.
 **/
float[] x = new float[100];
float[] y = new float[100];
float[] speed = new float[100];

int amt = 50;

int[] x1 = new int[amt];
int[] x2 = new int[amt];
int[] y1 = new int[amt];
int[] y2 = new int[amt];
color[] c = new color[amt];
color bgcolor;

float a = 0;
int score = 0;
float dist = 0;

Timer countDownTimer;
int timeLeft;

void setup() {
  size(700, 700, P2D);
  colorMode(HSB, 100);
  rectMode(CORNERS);
  noStroke();

  background(0);
  stroke(255);
  noCursor();

  int k = 0;
  while (k < 100) {  
    x[k] = random(0, width);
    y[k] = random(0, height);
    speed[k] = random(1, 5);
    k = k + 1;
  }

  bgcolor =  color(random(100), 30, 30);

  for (int i = 0; i < amt; i++) {
    x1[i] = int(random(width));
    x2[i] = x1[i] + int(random(20, 100));
    y1[i] = int(random(height));
    y2[i] = y1[i] + int(random(20, 100));
    c[i] = color(random(100), 80, 80);
  }

  countDownTimer = new Timer(1000);
  timeLeft = 60;
  countDownTimer.start();
  
}
void draw() {
  background(bgcolor);
  int found = -1;
  for (int i = 0; i < amt; i++) {
    fill(c[i]);
    rect(x1[i], y1[i], x2[i], y2[i]);
      if (mouseX > x1[i] && mouseX < x2[i] && mouseY > y1[i] && mouseY < y2[i]) {
      found = i;
    }
    triangle(mouseX, mouseY-6, mouseX, mouseY+6, mouseX+30, mouseY);
    a = a + 0.01;
  }
  if (found >= 0) {
    if (mousePressed) {

      x1[found] = int(random(width));
      x2[found] = x1[found] + int(random(20, 100));
      y1[found] = int(random(height));
      y2[found] = y1[found] + int(random(20, 100));

      score = score + 10;
    } else {
      noFill();
      stroke(100);
      rect(x1[found], y1[found], x2[found], y2[found]);
      noStroke();
    }
  }

  int i = 0;
  while (i < 100) {
    float co = map(speed[i], 1, 5, 100, 255);
    stroke(co);
    strokeWeight(speed[i]);
    point(x[i], y[i]);

    x[i] = x[i] - speed[i] / 2;
    if (x[i] < 0) {
      x[i] = width;
    }
    i = i + 1;
  }

  textSize(40);
  fill(50, 70, 235);
  text("Score: " + score, 10, 30);

  text("Time: " + timeLeft, 10, 70);

 
  if (countDownTimer.complete() == true) {
    if (timeLeft >=0) {
      timeLeft --;
      countDownTimer.start();
    } else {
      text("Finished!", width/2, height/2 );
    }
  }
}
