final int N = 500;
final int iter = 4;
final int SCALE = 1;

FlowField flowfield;
ArrayList<Particle> particles;


Fluid fluid;

void settings(){
  size(N*SCALE, N*SCALE);
}

void setup() {
  fluid = new Fluid(0.1, 0.0000001, 0.0000001);
  flowfield = new FlowField(SCALE);
  flowfield.update();

  particles = new ArrayList<Particle>();
  for (int i = 0; i < 2000; i++) {
    PVector start = new PVector(random(width), random(height));
    particles.add(new Particle(start, 0.08));
  }

}

void mouseDragged() {
  //fluid.add_density(mouseX/SCALE, mouseY/SCALE, 100);
  //float amtX = mouseX - pmouseX;
  //float amtY = mouseY - pmouseY;
  //fluid.add_velocity(mouseX/SCALE, mouseY/SCALE, amtX, amtY);
}

void draw(){
  background(0);
  //fluid.add_density(mouseX/SCALE, mouseY/SCALE, 10);
  flowfield.update();
  
  
  for (Particle p : particles) {
    p.follow(flowfield);
    p.run();
    float amtX = -p.vel.x;
    float amtY = -p.vel.y;
    fluid.add_density(floor(p.pos.x), floor(p.pos.y), p.r, p.g, p.b);
    fluid.add_velocity(floor(p.pos.x), floor(p.pos.y), amtX, amtY);
    //fluid.step();
    //fluid.renderD();
  }
  fluid.step();
  fluid.renderV();
  fluid.renderD();
  fluid.fadeD();
  
  //saveFrame("output6/####.png");

}
