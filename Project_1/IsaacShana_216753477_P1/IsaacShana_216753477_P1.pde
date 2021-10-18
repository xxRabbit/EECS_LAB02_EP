/**
 EECS 1710 Lab02
 Author: Shana Isaac
 Student Number: 216753477
 Project 1: Virtual Creature
 **/
float creature_x = 300;
float creature_y = 50;
float moveCreature_x = 2;
float moveCreature_y = 5; 
float creatureSize = random(50, 100);

void setup() {
  size (800, 600, P2D);
  background(0);
  
}

void draw() {

  //background(#24A3D3);
  fill(0, 20);
  rect(0, 0, width, height);
  
  fill(255);
  ellipse(creature_x, creature_y, creatureSize, creatureSize);

  creature_x = creature_x - moveCreature_x;
  creature_y = creature_y + moveCreature_y;
  stroke(random(255), random(255), random(255));

  if (creature_x > width) {
    creature_x = width;
    moveCreature_x = - moveCreature_x;
    strokeWeight(random(5, 10));
  }
  if (creature_y > height) {
    creature_y = height;
    moveCreature_y = - moveCreature_y;
    strokeWeight(random(20, 30));
  }

  if (creature_x < 0) {
    creature_x = 0;
    moveCreature_x = - moveCreature_x;
    strokeWeight(random(10, 20));
  }

  if (creature_y < 0) {
    creature_y = 0;
    moveCreature_y = - moveCreature_y;
    strokeWeight(random(1, 5));
  }

  if (random(100) > 90) {
    frameRate(25);
    fill(0);
  } else {
    fill(255);
  }
  
  ellipse(random(width), random(height), 10.0, 10.0);
}  



/**
 Works Cited
 https://happycoding.io/tutorials/processing/creating-classes
 **/
