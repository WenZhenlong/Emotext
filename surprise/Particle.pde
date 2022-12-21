class Particle {
  PVector pos;
  PVector vel;
  float scale;
  PVector acc;
  PVector target;      
  float maxForce;            
  float repulsionRadius = 580;
  float radius;
  float move;

  Particle(float x, float y,float targetX, float targetY, float maxForce) {
    this.pos = new PVector(x, y);
    this.vel = new PVector(0, 0);
    this.acc = new PVector(0, 0);
    this.target = new PVector(targetX, targetY);
    this.maxForce = maxForce;
    move =10;
  }

  void update() {

  float distThreshold = 50;
 
  float distance = dist(this.pos.x, this.pos.y, this.target.x, this.target.y); 
 
  PVector steer = new PVector(this.target.x, this.target.y); 
  steer.sub(this.pos);
  steer.normalize();

  steer.mult( map(min(distance, distThreshold), 0, distThreshold, 0, this.maxForce) );

  this.acc.add(steer);    
   float mx = 980+1800*cos(frameCount*PI/200);
   float Distance1 = dist(this.pos.x, this.pos.y, mx,height/2);
  if (Distance1 < repulsionRadius){
    PVector repulse = new PVector(this.pos.x, this.pos.y);
    repulse.sub(mx,height/2);
    repulse.mult(map(Distance1, repulsionRadius, 0, 0, 0.003));
    this.acc.add(repulse);
  }
    for (Hand hand : leap.getHands ()) {  
    PVector handPosition       = hand.getPosition();
  float fingerDistance = dist(this.pos.x, this.pos.y, handPosition.x,handPosition.y);
    if (fingerDistance < 150){
      PVector repulse = new PVector(this.pos.x, this.pos.y);
      repulse.sub(handPosition.x,handPosition.y);
      repulse.mult(map(fingerDistance, repulsionRadius, 0, 0, 0.025));
      this.acc.add(repulse);
    }
    }
 
    this.vel.mult(0.95);
    this.vel.add(this.acc); 
    this.pos.add(this.vel); 
    this.acc.mult(0.05);    
  }

  void display() {    
    float mx = 980+1800*cos(frameCount*PI/200);
    float Distance1 = dist(this.pos.x, this.pos.y, mx,height/2);
    if (Distance1 < repulsionRadius){
      fill(#F3C12C);
      radius = map(Distance1,0,500,12,7);
    }  
    else{
      fill(#E47127);
      radius = 7.5;
    }
    ellipse(this.pos.x, this.pos.y,radius,radius);
  }
}
