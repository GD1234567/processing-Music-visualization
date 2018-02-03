import ddf.minim.analysis.*;//引用库
import ddf.minim.*;//引用库
Minim       minim;//mini
AudioPlayer jingle;//播放音乐
FFT         fft;//傅里叶变换
float[] tx; //变量
float[] ty; //变量
float a = 0;//变量
float r = 0;//变量
int now = 0, time = 0;//变量
a aa;
float[] big; //变量
void setup() {//setup函数
  noCursor();//隐藏鼠标
  size(1280, 720);//画布
  smooth();//圆滑
  rectMode(CORNERS);//矩形模式
  colorMode(HSB, 360, 100, 100, 255);//颜色模式
  initme();//初始化
  minim = new Minim(this);//mini
  jingle = minim.loadFile("1.mp3", 512);//加载音乐
  fft = new FFT( jingle.bufferSize(), jingle.sampleRate() );//fft
  tx = new float[fft.specSize()];//x坐标数组
  ty = new float[fft.specSize()];//y坐标数组
  big = new float[fft.specSize()];//y坐标数组
  for (int i = 0; i < fft.specSize(); i++) {//所有的
    tx[i] = 320+cos(r)*200;//x坐标
    ty[i] = 500+sin(r)*200;//y坐标
    r+=2*PI/fft.specSize();//增加
  }
  jingle.loop();//循环
  aa = new a();
  colorMode(HSB);
  //jingle.setGain(-110);
}
float ang;//变量
float ang2;//变量
float ss;//变量
void initme() {//初始化
  ang=0;//参数1
  ang2=0;//参数2
  ss = random(2, 5);//参数3
  makeColors();//颜色
}
void draw() {//draw函数
  background(0);//背景
  fft.forward( jingle.mix );//变换
  if (now == 0 && time < 255)//状态1
    time++;//背景颜色变浅
  if (time >= 253 && now == 0)//状态2
  {
    now = 1;//状态2
  }
  if (now == 1)//状态2
    time--;//背景颜色变深
  if (time < 1 && now == 1)//状态1
    now = 0;//状态1

  for (int i = 0; i <fft.specSize(); i++) {//所有的
    if (big[i] > 0)
      big[i]--;
  }
  for (int i = 0; i <fft.specSize(); i++) {//所有的
    if (fft.getBand(i) > big[i])
      big[i] = fft.getBand(i);
  }
  
  // for(int i = 0; i < fft.specSize()-1; i++)
  //{
  // bezier( i*10+0, 500 - big[i]*8,i*10+10, 500 - big[i]*8, 
  // (i+1)*10-10, 500 - big[i+1]*8,(i+1)*10, 500 - big[i+1]*8 );
  //}
  
  noStroke();//没有线条

  for (int j =0; j< fft.specSize()-1; j++) {
    fill(j*360/256.0, 255, 255);
    bezier( 1280-j*5+0, big[j]*5, 1280-(j*5+5), big[j]*5, 
    1280-((j+1)*5-5), big[j+1]*5, 1280-((j+1)*5), big[j+1]*5 );
    rect( j*5, 720, (j+1)*5, 720-big[j]*5 );
  }
  translate(width/2, height/2);//移动
  //for (int iter=0; iter<250; iter++) {//循环
  //  pushMatrix();//矩阵
  //  rotate(ang+ang2/2.0);//旋转
  //  for (int i=0; i<5; i++) {//循环
  //    fill(c[i], 20+i*30);//填充
  //    rect(0, -(i+1)*10-30*noise(ang2+cos(-ang+i)*2), 10, -100-(50+(5-i)*40)*noise(sin(ang+i)*ss+i/2, ang2));//矩形频谱
  //  }
  //  popMatrix();  //矩阵  
  //  ang+=TWO_PI/250.0;//角度
  //}
  ang2+=TWO_PI/300;//角度
  ang=0.0;//角度
  translate(-width/2+-72, -height/2+-244);//移动
  translate(804, 606);//移动
  rotate(-0.5*PI);//旋转
  translate(-319, -589);//移动
  float w = -0.5*PI/fft.specSize();//角度
  stroke(#FC6ED2);//颜色
  noFill();//
  strokeWeight(2);//线宽

  for (int i = 0; i <fft.specSize(); i++) {//所有的
    stroke(i*360/272.8, 255, 255);//颜色
    if (i == fft.specSize()-1) {//没到边界
      line(tx[i]+big[i]*1.5*cos(w), ty[i]+big[i]*1.5*sin(w), tx[0]+big[0]*1.5*cos(w), ty[0]+big[0]*1.5*sin(w));//线条
      line(tx[i]-big[i]*1.5*cos(w), ty[i]-big[i]*1.5*sin(w), tx[0]-big[0]*1.5*cos(w), ty[0]-big[0]*1.5*sin(w));//线条
    } 
     else//否则
    { 
      line(tx[i]+big[i]*1.5*cos(w), ty[i]+big[i]*1.5*sin(w), tx[i+1]+big[i+1]*1.5*cos(w), ty[i+1]+big[i+1]*1.5*sin(w));//线条
      line(tx[i]-big[i]*1.5*cos(w), ty[i]-big[i]*1.5*sin(w), tx[i+1]-big[i+1]*1.5*cos(w), ty[i+1]-big[i+1]*1.5*sin(w));//线条
    }
    w+=2*PI/fft.specSize();//增加
  }
}
void makeColors() {//函数
  int h = (int)random(360);//变量
  int s = (int)random(50, 70);//变量
  int b = (int)random(70, 90);//变量
  c[0] = color(h, s, b);//颜色
  c[1] = color( (h+360-(25+random(-5, 5)))%360, s, b);//颜色
  c[2] = color( (h+25+random(-5, 5))%360, s, b);//颜色
  c[4] = color(h, s*0.6, b*0.6);//颜色
  c[3] = color( ((int)(h+180+random(-5, 5)))%360, s, b*0.9);//颜色
}
void mouseClicked() {//鼠标点击
  noiseSeed((int)random(0, 100000));//噪声
  initme();//初始化
}
color[] c = new color[5];//数组
class a {
  void makeColors() {//函数
    int h = (int)random(360);//变量
    int s = (int)random(50, 70);//变量
    int b = (int)random(70, 90);//变量
    c[0] = color(h, s, b);//颜色
    c[1] = color( (h+360-(25+random(-5, 5)))%360, s, b);//颜色
    c[2] = color( (h+25+random(-5, 5))%360, s, b);//颜色
    c[4] = color(h, s*0.6, b*0.6);//颜色
    c[3] = color( ((int)(h+180+random(-5, 5)))%360, s, b*0.9);//颜色
  }
}