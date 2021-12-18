/**
 EECS 1710 LAB02
 Author: Shana Isaac
 Student number: 216753477
 Final Project: Visualizer, all elements in the space reacts to the tone, pitch and bass in the song. 
 **/

import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioPlayer song;
FFT fft;

float specLow = 0.3;
float specMid = 0.2;
float specHi = 0.4; 

float scoreLow = 0;
float scoreMid = 0;
float scoreHi = 0;

float oldScoreLow = scoreLow;
float oldScoreMid = scoreMid;
float oldScoreHi = scoreHi;
float scoreDecreaseRate = 5;

int nbCubes;
Cube[] cubes;

int nbWalls = 3000;
Wall[] Walls;

void setup()
{
  size (1000, 1000, P3D);

  minim = new Minim(this);
  song = minim.loadFile("KMS.wav");
  fft = new FFT(song.bufferSize(), song.sampleRate());

  nbCubes = (int)(fft.specSize()*specHi);
  cubes = new Cube[nbCubes];
  Walls = new Wall[nbWalls];

  for (int i = 0; i < nbCubes; i++) {
    cubes[i] = new Cube();
  }

  for (int i = 0; i < nbWalls; i+=4) {
    Walls[i] = new Wall(0, height/2, 10, height);
  }


  for (int i = 1; i < nbWalls; i+=4) {
    Walls[i] = new Wall(width, height/2, 10, height);
  }


  for (int i = 2; i < nbWalls; i+=4) {
    Walls[i] = new Wall(width/2, height, width, 10);
  }

  for (int i = 3; i < nbWalls; i+=4) {
    Walls[i] = new Wall(width/2, 0, width, 10);
  }

  background(0);

  song.play(0);
}

void draw()
{
  fft.forward(song.mix);

  oldScoreLow = scoreLow;
  oldScoreMid = scoreMid;
  oldScoreHi = scoreHi;

  scoreLow = 0;
  scoreMid = 0;
  scoreHi = 0;

  for (int i = 0; i < fft.specSize()*specLow; i++)
  {
    scoreLow += fft.getBand(i);
  }

  for (int i = (int)(fft.specSize()*specLow); i < fft.specSize()*specMid; i++)
  {
    scoreMid += fft.getBand(i);
  }

  for (int i = (int)(fft.specSize()*specMid); i < fft.specSize()*specHi; i++)
  {
    scoreHi += fft.getBand(i);
  }

  if (oldScoreLow > scoreLow) {
    scoreLow = oldScoreLow - scoreDecreaseRate;
  }

  if (oldScoreMid > scoreMid) {
    scoreMid = oldScoreMid - scoreDecreaseRate;
  }

  if (oldScoreHi > scoreHi) {
    scoreHi = oldScoreHi - scoreDecreaseRate;
  }

  float scoreGlobal = 0.66*scoreLow + 0.8*scoreMid + 1*scoreHi;
  background(scoreLow/100, scoreMid/100, scoreHi/100);

  for (int i = 0; i < nbCubes; i++)
  {

    float bandValue = fft.getBand(i);
    cubes[i].display(scoreLow, scoreMid, scoreHi, bandValue, scoreGlobal);
  }

  float previousBandValue = fft.getBand(0);
  float dist = -5;
  float heightMult = 0.5;

  for (int i = 1; i < fft.specSize(); i++)
  {

    float bandValue = fft.getBand(i)*(1 + (i/2));

    stroke(200+scoreLow, 200+scoreMid, 200+scoreHi, 255-i);
    strokeWeight(1 + (scoreGlobal/1000));

    line(0, height-(previousBandValue*heightMult), dist*(i-1), 0, height-(bandValue*heightMult), dist*i);
    line((previousBandValue*heightMult), height, dist*(i-1), (bandValue*heightMult), height, dist*i);
    line(0, width-(previousBandValue*heightMult), dist*(i-1), (bandValue*heightMult), height, dist*i);

    line(0, (previousBandValue*heightMult), dist*(i-1), 0, (bandValue*heightMult), dist*i);
    line((previousBandValue*heightMult), 0, dist*(i-1), (bandValue*heightMult), 0, dist*i);
    line(0, (previousBandValue*heightMult), dist*(i-1), (bandValue*heightMult), 0, dist*i);

    line(width, height-(previousBandValue*heightMult), dist*(i-1), width, height-(bandValue*heightMult), dist*i);
    line(width-(previousBandValue*heightMult), height, dist*(i-1), width-(bandValue*heightMult), height, dist*i);
    line(width, height-(previousBandValue*heightMult), dist*(i-1), width-(bandValue*heightMult), height, dist*i);

    line(width, (previousBandValue*heightMult), dist*(i-1), width, (bandValue*heightMult), dist*i);
    line(width-(previousBandValue*heightMult), 0, dist*(i-1), width-(bandValue*heightMult), 0, dist*i);
    line(width, (previousBandValue*heightMult), dist*(i-1), width-(bandValue*heightMult), 0, dist*i);



    previousBandValue = bandValue;
  }

  for (int i = 0; i < nbWalls; i++)
  {

    float intensity = fft.getBand(i%((int)(fft.specSize()*specHi)));
    Walls[i].display(scoreLow, scoreMid, scoreHi, intensity, scoreGlobal);
  }
}

class Cube {
  float startingZ = -40000;
  float maxZ = 500;
  float x, y, z;
  float rotX, rotY, rotZ;
  float sumRotX, sumRotY, sumRotZ;

  Cube() {
    x = random(0, height);
    y = random(0, width);
    z = random(startingZ, maxZ);
    rotX = random(0, 2);
    rotY = random(0, 2);
    rotZ = random(0, 2);
  }

  void display(float scoreLow, float scoreMid, float scoreHi, float intensity, float scoreGlobal) {
    color displayColor = color(scoreLow*0.2, scoreMid*0.2, scoreHi*0.2, intensity*0.2);
    fill(displayColor, 255);
    color strokeColor = color(255, 150-(20*intensity));
    stroke(strokeColor);
    strokeWeight(1 + (scoreGlobal/300));

    pushMatrix();
    translate(x, y, z);
    sumRotX += intensity*(rotX/1000);
    sumRotY += intensity*(rotY/1000);
    sumRotZ += intensity*(rotZ/1000);
    rotateX(sumRotX);
    rotateY(sumRotY);
    rotateZ(sumRotZ);
    line(10, 10, 10, 10);
    rect(120, 80, 10, 10, 28);
    circle(24, 84, 20);
    //color(100+(intensity/2));


    popMatrix();

    z+= (1+(intensity/5)+(pow((scoreGlobal/150), 2)));
    if (z >= maxZ) {
      x = random(0, width);
      y = random(0, height);
      z = startingZ;
    }
  }
}

class Wall {
  float startingZ = -10000;
  float maxZ = 50;
  float x, y, z;
  float sizeX, sizeY;

  Wall(float x, float y, float sizeX, float sizeY) {
    this.x = x;
    this.y = y;
    this.z = random(startingZ, maxZ);  
    this.sizeX = sizeX;
    this.sizeY = sizeY;
  }

  void display(float scoreLow, float scoreMid, float scoreHi, float intensity, float scoreGlobal) {
    color displayColor = color(scoreLow*0.67, scoreMid*0.67, scoreHi*0.67, scoreGlobal);
    fill(displayColor, ((scoreGlobal-5)/500)*(255+(z/25)));
    noStroke();

    pushMatrix();
    translate(x, y, z);
    if (intensity > 200) intensity = 1000;
    scale(sizeX*(intensity/200), sizeY*(intensity/200), 20);
    box(2);

    popMatrix();

    displayColor = color(scoreLow*0.5, scoreMid*0.5, scoreHi*0.5, scoreGlobal);
    fill(displayColor, (scoreGlobal/10000)*(255+(z/25)));

    pushMatrix();
    translate(x, y, z);
    scale(sizeX, sizeY, 100);
    box(2);
    popMatrix();


    z+= (pow((scoreGlobal/150), 2));
    if (z >= maxZ) {
      z = startingZ;
    }
  }
}
