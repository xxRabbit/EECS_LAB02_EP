/**
EECS 1710 LAB 02
Author Shana Isaac
Student number 216753477
Exercise 02 Generative Landscape
**/
PImage bkgn;
float x;
float y;

void setup(){
  size(800, 600, P2D);
  bkgn = loadImage("bkgn.jpg");
  x = width/2;
  y = height/2;

  
  imageMode(CENTER);

  background(0);
  blendMode(ADD);
}

void draw(){
  int i = 0;
while ( i < 10) {
  i += 1;

  int j = 0;
  while (j < 1) {

    j += 1;
    int posX = i * 70;
    int posY = j * 70;
 
    float dist = 10;

    float col = 255;
    float sqSz = random(60);
    fill(col, 0, 0);
    rect(posX, posY, sqSz, sqSz);
    fill(0, col, 0);
    rect(posX + 10, posY + dist, sqSz, sqSz);
    fill(0, 0, col);
    rect(posX + 20, posY + dist * 2, sqSz, sqSz);
    

  }

}
 

}

/** WORKS CITED

References
  https://processing.org/reference/blendMode_.html
  https://www.youtube.com/watch?v=RtAPBvz6k0Y

background image
  https://pixabay.com/illustrations/snow-winter-snowflakes-wintry-2923054/

**/
