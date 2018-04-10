class Food {
  PImage food;
  
  PVector pos, vel;
  
  float theta;
  float scl, speed;
  float imgSize, buffer;
  
  int index;
  
  boolean eaten, range;

//Initial settings when food is created
  Food(PImage img) {
    pos = new PVector(random(width), random(height));
    vel = new PVector(random(-1,1), random(-1,1));
    scl = random(35,60);
    speed = random(0.7, 1.4);
    theta = random(360);
    
    eaten = false;
    range = false;
    
    index = int(random(0,4));
    food = img;
    imgSize = scl*food.width/food.height;
    buffer = imgSize/2;
  }
  
//Movement & rotation of food as it drifts
  void drift() {
    pos.x = pos.x + vel.x * speed;
    pos.y = pos.y + vel.y * speed;
    theta = theta + 0.1;
  }
  
//Draws food onto screen
  void show() {
    pushMatrix();
    translate(pos.x, pos.y);
    imageMode(CENTER);
    rotate(theta);
    image(food, 0, 0, imgSize, imgSize);
    popMatrix();
  }

//Checks if food was eaten by player
  boolean eaten(PVector loc) {
    float d = dist(pos.x, pos.y, loc.x, loc.y);
    if (d < imgSize+15){
      return true;
    } else {
      return false;
    }
  }

//Checks if the food has drifted off the screen
  boolean range() {
    if ((pos.x > width + buffer) || (pos.y > height + buffer)) {
      return true;
    } else if ((pos.x < -buffer) || (pos.y < -buffer)) {
      return true;
    } else {
      return false;
    }
  }
}