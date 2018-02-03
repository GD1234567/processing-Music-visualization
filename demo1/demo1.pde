import ddf.minim.analysis.*;
import ddf.minim.*;
Minim       minim;
AudioPlayer jingle;
FFT         fft;
int count = 10;
int speed = 5;
float offset = 0.5;
int twist = 15;
void setup() {
  size(1200, 800);
  fill(#2BEA4C);
  rectMode(CENTER);
  minim = new Minim(this);
  jingle = minim.loadFile("1.mp3", 1024);

  fft = new FFT( jingle.bufferSize(), jingle.sampleRate() );
}
void draw() {
  background(0);
    noFill();
 pushMatrix();
  translate(width/2, height/2);
  
  for (int j = 0; j < count; j++) {
    for (int i = 0; i < 600; i += 20) {
      float angle = sin(radians(i*offset-frameCount*speed))*twist;
      float colorHue = map(j, 0, count, 140, 220);
      float angleOffset = map(j, 0, count, 150, 250);
      float opacity = map(j, 0, count, 255, 100);
      float roundness = max(angle, 0)*2.5;
      
      stroke(colorHue, 255, 255, opacity);
      strokeWeight(max(angle*0.5, 1));
      
      pushMatrix();
      rotate(radians(i*angle/angleOffset));
      rect(0, 0, i, i, roundness);
      popMatrix();
    }
  }
  
  popMatrix();
  fft.forward( jingle.mix );
  stroke(#FF0A0A);
  strokeWeight(3);
  for(int i = 0; i < fft.specSize(); i++)
  {
   bezier( i*10+0, 500 - fft.getBand(i)*8,i*10+10, 500 - fft.getBand(i)*8, 
   (i+1)*10-10, 500 - fft.getBand(i+1)*8,(i+1)*10, 500 - fft.getBand(i+1)*8 );
  }
  fill(0);
  ellipse(600,500,160+fft.getBand(0),160+fft.getBand(0));
  ellipse(600,500,120+fft.getBand(0),120+fft.getBand(0));
  ellipse(600,500,80+fft.getBand(0),80+fft.getBand(0));
}
void mousePressed() {
  jingle.loop();
}