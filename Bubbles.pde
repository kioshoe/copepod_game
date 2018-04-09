//Creates a bubble that floats vertically from bottom to top
class Bubbles {
  PVector pos, vel;
  PImage bubble;
  float Size, imgSize;
  boolean pop;

//Creates random settings for each bubble created
  Bubbles(PImage img){
    bubble = img;
    Size = random(4, 20);
    imgSize = Size*bubble.width/bubble.height;
    pos = new PVector(random(-10,width+10), random(height+1, height+imgSize));
    vel = new PVector(0,random(-5,-3));
  }

//Draws a bubble and updates its position according to its set velocity
  void blowBubble() {
    pos.add(vel);
    pushMatrix();
    imageMode(CENTER);
    image(bubble, pos.x, pos.y, imgSize, imgSize);
    popMatrix();
  }

//Checks if bubble has drifted past the screen boundaries
  boolean pop() {
    float buffer = imgSize/2;
    if (pos.y < -buffer) {
      return true;
    } else {
      return false;
    }
  }
}