Particle[] dots = new Particle[350];

float radius = 200;
float thickness = 50;
float velMin = 0.005;
float velMax = 0.010;
float distance = 30;
import ddf.minim.analysis.*;
import ddf.minim.*;
Minim       minim;
AudioPlayer jingle;
FFT         fft;
void setup() {

  size(700, 700);
  frameRate(60);
  smooth(2);
  colorMode(HSB, 1);

  for (int i = 0; i < dots.length; i++) {
    float r = radius + (random(thickness) - thickness/2);
    float v = random(velMin, velMax);
    if (random(1) > .5) v *= -1;
    dots[i] = new Particle(r, v);
  }
  minim = new Minim(this);
  jingle = minim.loadFile("1.mp3", 1024);

  fft = new FFT( jingle.bufferSize(), jingle.sampleRate() );
}

void draw() {
  background(#000000);
  fft.forward( jingle.mix );
  fill(#FC4B19);
  noStroke();
  pushMatrix();
  for (int i = 0; i < fft.specSize(); i++)
  {
    translate(width/2, height/2);
    rotate(2*PI/fft.specSize());
    translate(-width/2, -height/2);
    rect(320, 530, 6, -fft.getBand(i)*1.5);
  }
  popMatrix();
  translate(width/2, height/2);

  for (int i = 0; i < dots.length; i++) {
    dots[i].update();
    //dots[i].draw();
  }

  for (int i = 0; i < dots.length; i++) {
    for (int j = i + 1; j < dots.length; j++) {
      float d = dist(dots[i].pos.x, dots[i].pos.y, dots[j].pos.x, dots[j].pos.y);
      if (d < distance && i != j) {
        //strokeWeight(0.5);
        //stroke(#FFFFFF);
        //line (dots[i].pos.x, dots[i].pos.y, dots[j].pos.x, dots[j].pos.y);
        for (int k = j + 1; k < dots.length; k++) {
          float d1 = dist(dots[j].pos.x, dots[j].pos.y, dots[k].pos.x, dots[k].pos.y);
          float d2 = dist(dots[i].pos.x, dots[i].pos.y, dots[k].pos.x, dots[k].pos.y);
          if (d1 < distance && d2 < distance) {
            noStroke();
            fill(dots[i].rgb, 0.1);
            beginShape(TRIANGLES);
            vertex(dots[i].pos.x, dots[i].pos.y);
            vertex(dots[j].pos.x, dots[j].pos.y);
            vertex(dots[k].pos.x, dots[k].pos.y);
            endShape();
          }
        }
      }
    }
  }
}

class Particle {

  float radius, vel, angle;
  PVector pos = new PVector();
  color rgb;

  Particle(float r, float v) {
    radius = r;
    vel = v;
    angle = random(TWO_PI);
    //rgb = color(random(1), 1, 1);
    if (random(1) > 0.5) rgb = lerpColor(#FF0051, #FF0001, random(1));
    else                 rgb = lerpColor(#FF0000, #FF9100, random(1));
  }

  void update() {
    angle += vel;
    pos.x = cos(angle) * radius;
    pos.y = sin(angle) * radius;
  }

  void draw() {
    stroke(#FFFFFF);
    strokeWeight(2);
    point(pos.x, pos.y);
  }
}
void mousePressed() {
  jingle.loop();
}