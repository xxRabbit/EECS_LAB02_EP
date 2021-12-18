/**
EECS 1710 LAB02
Author: Shana Isaac
Student number: 216753477
Exercise 7 : Interactive Pattern
**/
float[] x = new float[0];
float[] y = new float[0];
float[] r = new float[0];
float[] g = new float[0];
float[] b = new float[0];

void setup() {
  size(800, 800, P2D);

  background(200);

  noSmooth();
  frameRate(1000);
}

void draw() {
  for (int i = 0; i < x.length; i++) {
    x[i] += random(-1, 1);
    y[i] += random(-1, 1);

    if (x[i] < 0) {
      x[i] = width;
    }
    if (x[i] > width) {
      x[i] = 0;
    }

    if (y[i] < 0) {
      y[i] = height;
    }
    if (y[i] > height) {
      y[i] = 0;
    }

    stroke(r[i], g[i], b[i]);
    point(x[i], y[i]);
  }
}

void mousePressed() {
  x = append(x, mouseX);
  y = append(y, mouseY);
  r = append(r, random(256));
  g = append(g, random(256));
  b = append(b, random(256));
}
