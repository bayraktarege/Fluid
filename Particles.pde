// Daniel Shiffman
// http://youtube.com/thecodingtrain
// http://codingtra.in
//
// Coding Challenge #24: Perlin Noise Flow  Field
// https://youtu.be/BjoM9oKOAKY

public class Particle {
  PVector pos;
  PVector vel;
  PVector acc;
  PVector previousPos;
  PVector colour;
  float maxSpeed;
  float r, g, b;
  float phase;
   
  Particle(PVector start, float maxspeed) {
    maxSpeed = maxspeed;
    pos = start;
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    previousPos = pos.copy();
    phase = random(TWO_PI);
    
    //r = random(250);
    //g = random(250);
    //b = random(200);
    
  }
  void run() {
    update();
    edges();
    show();
  }
  void update() {
    pos.add(vel);
    vel.limit(maxSpeed);
    vel.add(acc);
    acc.mult(0);
  }
  void applyForce(PVector force) {
    acc.add(force); 
  }
  void show() {
    //stroke(255, 255, 50);
    //strokeWeight(50);
    //line(pos.x, pos.y, previousPos.x, previousPos.y);
    //point(pos.x, pos.y);
    updatePreviousPos();
  }
  void edges() {
    if (pos.x > width) {
      pos.x = 0;
      updatePreviousPos();
    }
    if (pos.x < 0) {
      pos.x = width;    
      updatePreviousPos();
    }
    if (pos.y > height) {
      pos.y = 0;
      updatePreviousPos();
    }
    if (pos.y < 0) {
      pos.y = height;
      updatePreviousPos();
    }
  }
  void updatePreviousPos() {
    this.previousPos.x = pos.x;
    this.previousPos.y = pos.y;
  }
  void follow(FlowField flowfield) {
    int x = floor(pos.x / flowfield.scl);
    int y = floor(pos.y / flowfield.scl);
    int index = x + y * flowfield.cols;
    
    PVector force = flowfield.vectors[index];
    this.r = 255* (sin(pow(this.phase, pow(TWO_PI, force.x)))+1);
    this.g = 100* (cos(-pow(this.phase, pow(TWO_PI, force.x)))+1);
    this.b = 150* (tan(pow(this.phase, pow(TWO_PI, force.x)))+1);
    this.phase+=0.1;
    applyForce(force);
  }
}
