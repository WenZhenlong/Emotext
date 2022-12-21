int grid = 8;
float[][] points;
PGraphics pg;
PFont font;
int FontSize=140;

void setup() {
  fullScreen(); 
  smooth(); 
  
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
  pg.text("As the Chinese saying\ngoes, seeing the\nhandwriting in your letter\nis like seeing you in\nperson.", 80,0,width-160, height);
  pg.endDraw();

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
  for (int i = 0; i < points.length; i++) {
    for (int j = 0; j < points[i].length; j++) {
      int x = grid * i;
      int y = grid * j;
      if (x > grid && y > grid) {
        if(points[i][j]>0){
          float r =7.5;
          fill(255);
          ellipse(x, y, r, r);
        }
      }
    }
  }
}
void keyPressed() {
  if (key == 's' || key == 'S') saveFrame("#####.png");
}
