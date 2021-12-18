/**
EECS 1710 LAB02
Author: Shana Isaac
Student number: 216753477
Exercise 4 : Modular Alphabet
**/
PImage a, b, c;
String input = "b";

LetterGenerator lg1, lg2, lg3;

void setup() {
  size(800, 600, P2D);
  
  a = loadImage("a.png");
  b = loadImage("b.png");
  c = loadImage("c.png");
  
  lg1 = new LetterGenerator("a", 0, 0);
  lg2 = new LetterGenerator("b", 200, 50);
  lg3 = new LetterGenerator("c", 400, 100);
}

void draw() {
  background(127);
  
  lg1.draw();
  lg2.draw();
  lg3.draw();
}

class LetterGenerator {
  
  String input;
  PVector position;
  PImage img;
  color col;
  
  LetterGenerator(String _input, float x, float y) {
    input = _input;
    position = new PVector(x, y);
    col = getRandomColor();

    switch(input) {
      case "a":
        img = a;
        break;
      case "b":
        img = b;
        break;
      case "c":
        img = c;
        break;
    }
  }
  
  color getRandomColor() {
    return color(127 + random(127), 127 + random(127), 127 + random(127));
  }
  
  void draw() {
    // shadow
    tint(0, 127);
    image(img, position.x + 10, position.y + 10);
    
    tint(col);
    image(img, position.x, position.y);
    noTint();
  }

}
