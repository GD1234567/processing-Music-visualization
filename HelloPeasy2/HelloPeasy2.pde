import peasy.PeasyCam;
PeasyCam cam;
int dist = 100;

import ddf.minim.analysis.*;
import ddf.minim.*;
//boolean a[][][];
Minim       minim;
AudioPlayer jingle;
FFT         fft;
int x, y, z;
boolean ww = false;
public void settings() {
  size(800, 800, P3D);
}
public void setup() {
  cam = new PeasyCam(this, 400);
  //minim = new Minim(this);
  //jingle = minim.loadFile("1.mp3", 1024);
  //fft = new FFT( jingle.bufferSize(), jingle.sampleRate() );
  colorMode(HSB);
  //jingle.loop();
  //a = new boolean[16][16][16];
  //for (int i = 0; i<16; i++)
  //  for (int j = 0; j<16; j++)
  //    for (int k = 0; k<16; k++)
  //      a[i][j][k] = false;
  
    lights();
  //directionalLight(51, 102, 126, -1, 0, 0);
  //scale(10);
  //strokeWeight(1 / 10f);
  background(0);
  noStroke();
  fill(0, 255, 255);
  //box(30);
  //x = (int)random(16);
  //y = (int)random(16);
  //z = (int)random(16);
  //if (!ww) {
  //if (a[x][y][z] == false)
  //a[x][y][z] = true;
  // }
  //if (ww) {
  //  if (a[x][y][z] == true)
  //    a[x][y][z] = false;
  //}
  //float sum  = 0;
  //for (int i = 0; i<16; i++)
  //  for (int j = 0; j<16; j++)
  //    for (int k = 0; k<16; k++)
  //    {
  //      if (a[x][y][z] == true)
  //        sum++;
  //    }
  //if (sum> 3000)
  //  ww = !ww;
  //|| sum < 200
  rotateX(-.5f);
  rotateY(-.5f);
  for (int x = 0; x<100; x++)
    for (int y = 0; y<100; y++)
      for (int z = 0; z<100; z++)
      {
        pushMatrix();
        translate(x, y, z);
        if (abs((x*x+9/4*y*y+z*z-1)*(x*x+9/4*y*y+z*z-1)*(x*x+9/4*y*y+z*z-1)-x*x*z*z*z-9/80*y*y*z*z*z) <10)
          box(1);
        // else
        // fill(0, 0, 0);

        popMatrix();
      }
}
public void draw() {
  //fft.forward( jingle.mix );
  //rotateX(-.5f);
  ///rotateY(-.5f);

}
void mousePressed() {
}