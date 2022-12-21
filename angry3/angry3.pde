import de.voidplus.leapmotion.*;

int grid = 8;
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
  frameRate(60);


}

void draw() {
  background(0);
  noStroke();
  for (Hand hand : leap.getHands ()) {  
    PVector handPosition       = hand.getPosition();
    speed=map(handPosition.x,0,width,5,15);
  }
  pg = createGraphics(width, height);

  pg.beginDraw();
  pg.background(255);
  pg.fill(0);
  font = createFont("Helvetica-Bold-02.ttf", FontSize);
  pg.textFont(font);
  pg.textAlign(LEFT,CENTER);
  pg.textLeading(FontSize);
  pg.text("They say that 'time assuages,'--\nTime never did assuage;\nAn actual suffering strengthens,\nAs sinews do, with age.", 80,0,width-80, height);
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
        if(points[i][j]>0){
          int r =8;
          if ((x/grid)%2==0){
            //fill(#890101);
            fill(#990011);
          }
          if((x/grid)%2==1){
            //fill(#D80202);
            fill(#D22809);
          }
        ellipse(x+random(-speed,speed), y+random(-speed,speed), r, r);
        }
      }
    }
  }
}
