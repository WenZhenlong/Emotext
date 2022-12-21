import de.voidplus.leapmotion.*;

ArrayList<Particle> particles = new ArrayList<Particle>();
int grid = 8;
float[][] points;
PGraphics pg;
PFont font;
int FontSize=140;
PVector axis;
String letters = "Time's a thief; he steals away\nMany blossoms of to-day.\nJoys he steals and also tears, \nPilfers hopes and filches fears. ";

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
  pg.textAlign(LEFT,CENTER);
  pg.textLeading(FontSize);
  pg.text(letters, 80,0,width-80, height);
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
    fill(#335525);
    p.display();
    p.update();
  }
  noStroke();
  //fill(255,50);
  //for (Hand hand : leap.getHands ()) {  
    //PVector handPosition       = hand.getPosition();
  //ellipse(handPosition.x, handPosition.y,200,200);
  //}
}
