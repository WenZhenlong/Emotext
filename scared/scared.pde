import de.voidplus.leapmotion.*;

int grid = 8;
float[][] points;
PGraphics pg;
PFont font;
int FontSize=140;
float wave;
float scaredr;
float shade;
float valueY;

LeapMotion leap;

void setup() {
  fullScreen(); 
  smooth();  
      noCursor();
  leap = new LeapMotion(this);
  frameRate(90);
}

void draw() {
  background(0);
  noStroke();
    
  pg = createGraphics(width, height);

  pg.beginDraw();
  pg.background(255);
  pg.fill(0);
  font = createFont("Helvetica-Bold-02.ttf", FontSize);
  pg.textFont(font);
  pg.textAlign(LEFT,CENTER);
  pg.textLeading(FontSize);
  pg.text("AS the time draws nigh,\nglooming, a cloud,\nA dread beyond, of I\nknow not what, darkens\nme.", 80,0,width-80, height);
  pg.endDraw();

  int numX = (int)(width/grid);
  int numY = (int)(height/grid);
  
  points = new float[numX][numY];

  for (int i = 0; i < points.length; i++) {
    for (int j = 0; j < points[i].length; j++) {
      int x = grid * i;
      int y = grid * j;
      color c = pg.get(x, y);
      float value = map(brightness(c), 0, 100, 1.0, 0);
      points[i][j] = value;
      if (x > grid && y > grid) {
        if(value>0){
          //float valueX = sin(speed*(800-y)/400*frameCount+(x+y*width)*0.003)*r;
          float mouseR = sqrt(pow(width,2)+pow(height,2));
          //float mouseR = 200;
          for (Hand hand : leap.getHands ()) {  
            PVector handPosition       = hand.getPosition();
            if(pow((x-handPosition.x),2)+pow((y-handPosition.y),2)<pow(mouseR,2)){
              wave = map(sqrt(pow((x-handPosition.x),2)+pow((y-handPosition.y),2)),0,mouseR,8,0);
              scaredr = map(sqrt(pow((x-handPosition.x),2)+pow((y-handPosition.y),2)),0,mouseR,4,12);
              shade = map(sqrt(pow((x-handPosition.x),2)+pow((y-handPosition.y),2)),0,mouseR,50,255);
              valueY = sin(36*frameCount+(y+x*width)*0.01)*wave;
              fill(255,shade);
              ellipse(x, y+valueY, scaredr,scaredr);
            }else{
              valueY = sin(36*frameCount+(y+x*width)*0.01);
              fill(255);
              ellipse(x, y+valueY,12,12);
            }
          }            
        }
      }
    }
  }
}
