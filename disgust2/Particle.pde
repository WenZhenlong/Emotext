class Particle {
  PVector pos;
  PVector vel;
  float scale;
  PVector acc;
  PVector target;      
  float maxForce;            
  float repulsionRadius = FontSize;
  int radius;
  float move;

  Particle(float x, float y,float targetX, float targetY, float maxForce) {
    this.pos = new PVector(x, y);
    this.vel = new PVector(0, 0);
    this.acc = new PVector(0, 0);
    this.target = new PVector(targetX, targetY);
    this.maxForce = maxForce * random(0.8, 1.2);
    scale=random(1.5,2.4);
    radius=int(scale*8);
    move =10;
  }

  void update() {

  float distThreshold = 75;
 
  float distance = dist(this.pos.x, this.pos.y, this.target.x, this.target.y); 
 
  PVector steer = new PVector(this.target.x, this.target.y); 
  steer.sub(this.pos);
  steer.normalize();

  steer.mult( map(min(distance, distThreshold), 0, distThreshold, 0, this.maxForce) );

  this.acc.add(steer);
  
  float xx= this.pos.x+random(-move,move);
  float yy= this.pos.y+random(-move,move);
  float Distance = dist(this.pos.x, this.pos.y, xx,yy);
  
  if (Distance < repulsionRadius){
    PVector repulse = new PVector(this.pos.x, this.pos.y);
    repulse.sub(xx,yy);
    repulse.mult(map(Distance, repulsionRadius, 0, 0, -0.01));
    this.acc.add(repulse);
  }
  
  for (Hand hand : leap.getHands ()) {  
    PVector handPosition       = hand.getPosition();
   float Distance1 = dist(this.pos.x, this.pos.y, handPosition.x, handPosition.y);
  if (Distance1 < 150){
    PVector repulse = new PVector(this.pos.x, this.pos.y);
    repulse.sub(handPosition.x, handPosition.y);
    repulse.mult(map(Distance1, repulsionRadius, 0, 0, -0.05));
    this.acc.add(repulse);
  }
  }
 
    this.vel.mult(0.95);
    this.vel.add(this.acc); 
    this.pos.add(this.vel); 
    this.acc.mult(0.05);    
  }

  void display() {    
    ellipse(this.pos.x, this.pos.y,radius,radius);
  }
}
