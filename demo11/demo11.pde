objet[] objets;
float rx=0, ry=0;
import ddf.minim.analysis.*;
import ddf.minim.*;
Minim       minim;
AudioPlayer jingle;
FFT         fft;
void setup() {
  size(480, 480, P3D);
  strokeWeight(4);
  objets=new objet[0];
  for (int a=0; a<400; a++) {
    new objet(random(TWO_PI), random(TWO_PI), random(130, 160));
  }
  fill(#2BEA4C);
  minim = new Minim(this);
  jingle = minim.loadFile("1.mp3", 1024);
  rectMode(CENTER);
  fft = new FFT( jingle.bufferSize(), jingle.sampleRate() );
}

void draw() {
  background(0);
  fft.forward( jingle.mix );
  stroke(#E6F72D);
  translate(-width/2+-40, -height/2+104);
  for (int j =0; j< fft.specSize(); j++) {
    line( j+512, 400, j+512, 400 - fft.getBand(j)*2 );
    line( j+380-382, 400, j+380-382, 400 - fft.getBand(fft.specSize()-j)*2 );
  }
  stroke(255);
  ry-=0.002;
  //rx+=0.031;
  float r=200;
  translate(width/2+279, height/2+155);
  rotateX(rx);
  rotateY(ry);
  for (objet o : objets) {
    o.dessine();
  }
}

class objet {
  float phi=0, theta=0, ray=100, t=0, v=0;
  objet(float _phi, float _theta, float _ray) {
    t=floor(random(50));
    v=random(0.05, 0.9);
    phi=_phi;
    theta=_theta;
    ray=_ray;
    objets = (objet[]) append(objets, this);
  }
  void dessine() {
    t-=v;
    if (t<0) {
      t=50;
    }
    strokeWeight(map(t, 0, 50, 0.5, 8));
    float x=(sin(phi)*cos(theta))*ray;
    float  y=(sin(phi)*sin(theta))*ray;
    float z=(cos(phi))*ray; 
    point(x, y, z);
  }
}
void mousePressed() {
  jingle.loop();
}