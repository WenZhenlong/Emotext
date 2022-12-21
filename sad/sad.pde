import de.voidplus.leapmotion.*;

int grid = 9;
float[][] points;
PGraphics pg;
PFont font;
int FontSize=140;
float speed;

LeapMotion leap;

void setup() {
  fullScreen(); 
      noCursor();
  smooth(); 
  leap = new LeapMotion(this);
  frameRate(90);

  pg = createGraphics(width, height);

  pg.beginDraw();
  pg.background(255);
  pg.fill(0);
  font = createFont("Helvetica-Bold-02.ttf", FontSize);
  pg.textFont(font);
  pg.textAlign(LEFT,CENTER);
  pg.textLeading(FontSize);
  pg.text("We have no time to lose,\nand having no time we\nmust scramble for a\nchance.\nWe are too poor to be\nlate.", 80,0,width-80, height);
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
    }
  }
}

void draw() {
  background(0);
  noStroke();
  for (Hand hand : leap.getHands ()) {  
    PVector handPosition       = hand.getPosition();
    speed=map(handPosition.x,0,width,0.04,0.08);
  }
  for (int i = 0; i < points.length; i++) {
    for (int j = 0; j < points[i].length; j++) {
      int x = grid * i;
      int y = grid * j;
      if (x > grid && y > grid) {
        if(points[i][j]>0){
          float r =8.5;
          //float valueX = sin(speed*(800-y)/400*frameCount+(x+y*width)*0.003)*r;
          float valueX = sin(speed*frameCount+(x+y*width)*0.00005)*0.6*r;
          if ((x+y)*grid%2==0){
            //fill(#0074A0);
            fill(#54B2E9);
          }
          if((x+y)*grid%2==1){
            //fill(#00B7FC);
            fill(#2B759D);
          }
        ellipse(x+valueX, y, r, r);
        }
      }
    }
  }          
}
