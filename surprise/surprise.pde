import de.voidplus.leapmotion.*;

ArrayList<Particle> particles = new ArrayList<Particle>();
int grid =8 ;
float[][] points;
PGraphics pg;
PFont font;
int FontSize=140;
PVector axis;

LeapMotion leap;

void setup() {
  fullScreen(); 
  smooth(); 
      noCursor();
  leap = new LeapMotion(this);  
  frameRate(90);

  pg = createGraphics(width, height);

  int numX = (int)(width/grid);
  int numY = (int)(height/grid);

  pg.beginDraw();
  pg.background(255);
  pg.fill(0);
  font = createFont("Helvetica-Bold-02.ttf", FontSize);
  pg.textFont(font);
  pg.textLeading(FontSize);
  pg.textAlign(LEFT,CENTER);
  pg.text("How soon hath Time,\nthe subtle thief of youth,\nStol’n on his wing my three-and-twentieth year! ", 80,0,width-80, height);
  pg.endDraw();

  points = new float[numX][numY];


  for (int i = 0; i < points.length; i++) {
    for (int j = 0; j < points[i].length; j++) {
      int x = grid * i;
      int y = grid * j;
      axis = new PVector(grid * i,grid * j);
      color c = pg.get(x, y);
      float value = map(brightness(c), 0, 100, 1.0, 0);
      points[i][j] = value;
      if(value>0){
        particles.add(new Particle(axis.x,axis.y,axis.x,axis.y,0.5));
      }
    }
  }
}


void draw() {
  background(0);
    
  for (int i = 0; i < particles.size(); i++) {
    Particle p = particles.get(i);
    fill(#014800);
    p.display();
    p.update();
  }
  noStroke();
  for (Hand hand : leap.getHands ()) {  
    PVector handPosition       = hand.getPosition();
  //fill(0,50);
  //ellipse(handPosition.x,handPosition.y,200,200);
  }
}
