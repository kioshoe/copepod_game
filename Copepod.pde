class Copepod {
  PVector pos, vel, acc;
  
  PImage player;
  
  float theta = 0;
  float friction = 0.995;
  float maxSpd, imgSize;

//Initial settings
  Copepod() {
    pos = new PVector(width/2, height/2);
    vel = new PVector();
    acc = new PVector();
    maxSpd = 15;
  }

//Resets player position and movement to intial settings
  void reset() {
    pos.x = width/2;
    pos.y = height/2;
    vel.x = 0;
    vel.y = 0;
    theta = 0;
  }
  
//Determines avatar and size
  void create(PImage img, float size) {
    player = img;
    imgSize = size*player.width/player.height;
  }
  
//Checks if player has moved past boundary of screen and repositions player
  void edge(){
    float buffer = imgSize/2;
    if (pos.x > width +  buffer) {
      pos.x = -buffer;
    } else if (pos.x < -buffer) {
      pos.x = width+buffer;
    }
    if (pos.y > height + buffer) {
      pos.y = -buffer;
    } else if (pos.y < -buffer) {
      pos.y = height + buffer;
    }
  }
  
//Draws player avatar
  void display(){
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(theta);
    imageMode(CENTER);
    image(player, 0, 0, imgSize, imgSize);
    popMatrix();
  }

//Updates position  
  void update() {
    vel.add(acc);
    vel.mult(friction);
    vel.limit(maxSpd);
    pos.add(vel);
    acc.mult(0);
  }

//Changes movement force
  void Force(PVector force) {
    PVector f = force.copy();
    acc.add(f);
  }

//Changes movement speed according to player input
  void move() {
    float offset = theta - PI/2;
    PVector force = new PVector(cos(offset),sin(offset));
    force.mult(0.1);
    Force(force);
  }

//Changes direction according to player input
  void turn(float r){
    theta += r;
  }

//Returns player's current coordinates for food function in order to check if player has eaten the food
  PVector current() {
    return pos;
  }
}