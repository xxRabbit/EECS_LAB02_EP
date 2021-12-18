/**
EECS 1710 LAB02
Author: Shana Isaac
Student number: 216753477
Exercise 5 : Voice machine
**/
import ddf.minim.Minim;
import ddf.minim.AudioOutput;
import ddf.minim.AudioRecorder;

int bps = 6;
int maxNote = 500;
int deltaNote = 100;

int note = 0;
boolean playing = true;
int stoppedPlayingTime;

AudioOutput out;
AudioRecorder recorder;

void setup() {
  size(300, 100);

  Minim minim = new Minim(this);
  out = minim.getLineOut();
  recorder = minim.createRecorder(out, "notes.wav");

  frameRate(bps);

  recorder.beginRecord();
}

void draw() {
  if (playing) {
    // Move the note
    note += random(-deltaNote * .5, deltaNote);
    note = constrain(note, 0, maxNote);
    out.playNote(note);

    // Draw a line just for fun
    stroke(random(256), random(256), random(256));
    line(width * note / maxNote, 0, width * note / maxNote, height);

 
    if (note >= maxNote) {
      playing = false;
      stoppedPlayingTime = millis();
    }
  }

  else if(millis() > stoppedPlayingTime + 1000){
    recorder.endRecord();
    recorder.save();
    println("Done!");
    noLoop();
  }
}
