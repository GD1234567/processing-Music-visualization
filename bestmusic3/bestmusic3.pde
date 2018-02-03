import ddf.minim.analysis.*;
import ddf.minim.*;
Minim       minim;
AudioPlayer jingle;
FFT         fft;
PImage o;

int numE = 2; 

int eSize[]= new int[numE]; 

int[] eSpeedX = new int[numE];
int[] eSpeedY = new int[numE]; 

int[] ePosX = new int [numE]; 
int[] ePosY = new int [numE]; 
final float PHI = (1 + sqrt(5))/2;  //golden ratio
ArrayList<Ball> balls;
int counter = 0;
void setup()
{
  size(1540, 765);
  minim = new Minim(this);
  jingle = minim.loadFile("1.mp3", 1024);
  fft = new FFT( jingle.bufferSize(), jingle.sampleRate() );
  colorMode(HSB);
  noStroke();
  o = loadImage("1.png");
  balls = new ArrayList<Ball>();
  balls.add (new Ball(10, 0));
  
     for(int i = 0; i<numE; i++){
    ePosX[i] = int(random(0, width)); 
    ePosY[i] = int(random(0, height)); 
    
    eSpeedX[i] = int(random(-5,5));
    eSpeedY[i] = int(random(-5,5));
    
    eSize[i] = int(random(10,100)); 
    if(eSpeedX[i] == 0){
      eSpeedX[i] = 1; 
    }
    if(eSpeedY[i] == 0){
      eSpeedY[i] = 1; 
    }
  }
}
void draw()
{
    for(int i =0; i<numE; i++){
    ePosX[i] = ePosX[i] + eSpeedX[i]; 
    ePosY[i] = ePosY[i] + eSpeedY[i]; 
  }
  
  //setup boundaries for ellipses
  for(int i =0; i<numE; i++){
    if(ePosX[i] <= 0 || ePosX[i]>= width){
      eSpeedX[i] = eSpeedX[i]*-1; 
    }
    if(ePosY[i] <= 0 || ePosY[i]>= height){
      eSpeedY[i] = eSpeedY[i]*-1; 
    }
  }
  
  background(0);
  //fill(#FAEF12);
  //text("12345",100,100);
  //  for (int i = balls.size() - 1; i >= 0; i--)
  //{
  //  Ball b = balls.get(i);
  //  b.move(i, balls);
  //  b.display();
  //  if (b.isDead())  balls.remove(i);
  //}
  fft.forward( jingle.mix );
  for (int i = 0; i < fft.specSize(); i+=3)
  {

    
    int a = 2*(int)fft.getBand(i);
    for (int j = 0; j < 160; j++)
    {
      for(int t =0; i<numE; i++)
      if(dist(ePosX[t],ePosY[t],i*3,765-j*6)< 30)
      rect(i*3, 765-j*6, 5, 3);
      
    }
    for (int j = 0; j < a; j++)
    {
      fill(j*1.3, 255, 255);
      rect(i*3, 765-j*6, 5, 3);
    }
  }



  
  //  for (int i = 0; i < fft.specSize(); i+=3)
  //{
  //  fill(#000000);
  //  for (int j = 0; j < 160; j++)
  //    {rect(i*3+5, 765-j*6, 5, 3);
  //    rect(i*3, 765-j*6+3, 5, 3);
  //    }
  //}

  //for(int i =0; i<numE; i++){
  //  fill(23,78,56); 
  //  ellipse(ePosX[i], ePosY[i], eSize[i], eSize[i]); 
  //}
  counter++;
  balls.add (new Ball(10 - (counter%500)/50, counter*PHI*TAU));
}
void mousePressed() {
  jingle.loop();
}

class Ball
{
  PVector center, //screen center
    pos, //position
    dir;  //direction
  float diam;  //diameter

  ////////////

  Ball(float diam_, float angle)
  {
    center = new PVector(width/2, height/2, 1); 
    pos = center.get();
    dir = new PVector(cos(angle), sin(angle), 0);
    diam = diam_;
  }

  ///////////

  void move(int id, ArrayList<Ball> balls)
  {
    //tests if balls created afterwards are too close
    for (int i = id + 1; i < balls.size() - 1; i++)
    {
      Ball b = balls.get(i);
      if (PVector.dist(pos, b.pos) < 12)  pos.add(dir);
    }
  }

  /////////// 

  void display()
  {
    float d = dist(pos.x, pos.y, width/2, height/2);
    fill(d, 255, 255);
    rect(pos.x, pos.y,5,3);
  }

  ///////////

  boolean isDead()
  {
    if (PVector.dist(pos, center) > 320) return true;
    else return false;
  }
}