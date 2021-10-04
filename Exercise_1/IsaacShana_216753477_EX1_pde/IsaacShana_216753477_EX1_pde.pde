/**
EECS 1710 LAB02
Author: Shana Isaac
Student number: 216753477
Exercise 1 : Drawing machine
**/


void setup(){
  size(800, 800);
  background(106, 90, 205);
}

void draw(){
  background(106, 90, 205);
  translate(width/2, height/2);
  for (int n = 0; n < 360; n ++){
     stroke(random(179), random(255), random(255));
  }
  for(int a = 0; a < 360; a += 3){
    float x = random(50, 100);
    float xx = random(100, 350);
    pushMatrix();
    rotate(radians(a));
    strokeCap(CORNER);
    strokeWeight(5);
    line(x, 100, xx, 100);
    ellipse(0, 0, 90, 90 );
    fill(random(255), random(60), random(90));
    ellipse(0, 0, 10, 10);
    popMatrix();
  }
  


}

void keyPressed(){
  redraw();
}
/** WORKS CITED
https://processing.org/examples/colorvariables.html

**/
