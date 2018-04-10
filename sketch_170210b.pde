/* @pjs preload = "adult.png, copepodid.png, nauplii.png, egg.png, death.png, bubble.png, ceratium.png, coccolithus.png, coscinodiscus.png, dinophysis.png, skeletonema.png"; */

color b1, b2, e1;

PImage[] copepod = new PImage[3];
PImage[] phyto = new PImage[5];
PImage egg, bubbleImg, death;
float lvl;
int score;
int day;
int currentTime;
int startTime;
int spawnTime;
float[] spawn;
ArrayList <Bubbles> bubbles;
ArrayList <Copepod> growth;
ArrayList <Food> foods;
ArrayList <String> months;
boolean running;
boolean pass;
boolean stop;
PVector position;
int currentScreen;
int spawnTimer;

Copepod player;
Food food;



void setup() {
  size(1024, 640);
  b1 = color(0, 102, 204);
  b2 = color(0, 51, 102);

  phyto[0] = loadImage("coscinodiscus.png");
  phyto[1] = loadImage("dinophysis.png");
  phyto[2] = loadImage("skeletonema.png");
  phyto[3] = loadImage("ceratium.png");
  phyto[4] = loadImage("coccolithus.png");

  copepod[0] = loadImage("nauplii.png");
  copepod[1] = loadImage("copepodid.png");
  copepod[2] = loadImage("adult.png");
  
  bubbleImg = loadImage("bubble.png");
  egg = loadImage("egg.png");
  death = loadImage("death.png");
  
  foods = new ArrayList<Food>();
  foods.add(new Food(phyto[0]));

  months = new ArrayList<String>();
  months.add(new String("March"));

  player = new Copepod();

  running = true;
  pass = false;
  
  bubbles = new ArrayList<Bubbles>();
  bubbles.add(new Bubbles(bubbleImg));

}

void draw() {
  switch(currentScreen) {
  case 0: screenZero(); break;
  case 1: screenOne(); break;
  case 2: screenTwo(); break;
  case 3: screenThree(); break;
  case 4: screenFour(); break;
  case 5: screenFive(); break;
  case 6: screenSix(); break;
  case 7: screenSeven(); break;
  case 8: screenEight(); break;
  case 9: screenNine(); break;
  }
  
  if ((currentScreen == 3) || (currentScreen == 6)) {
    if (running == false) {
      startTime = millis();
      spawnTime = millis();
      running = true;
    }
      if ((stop) && (pass == true) && (currentScreen == 3)) {
        currentScreen = 4;
        pass = false;
      } else if ((stop) && (pass == true) && (currentScreen == 6)) {
        currentScreen = 8;
        pass = false;
      } else if ((stop) && (pass == false)) {
        currentScreen = 7;
      }
  } 
}

void keyPressed() {
  if (keyCode == UP) {
    player.move();
  } else if (keyCode == RIGHT) {
    player.turn(0.2);
  } else if (keyCode == LEFT) {
    player.turn(-0.2);
  } else if (keyCode == ' ') {
    if (currentScreen < 3) {
      currentScreen++;
    } else if ((currentScreen == 4) || (currentScreen == 5)) {
      currentScreen++;
    } else if (currentScreen > 9) {
      currentScreen = 0;
    }
  } 
  
  if (currentScreen == 0) {
    if ((keyCode == 'i') || (keyCode == 'I')) {
      currentScreen = 9;
    }
  }
  
  if ((currentScreen == 7) || (currentScreen == 8)) {
    if ((keyCode == 'y') || (keyCode == 'Y')) {
      currentScreen = 0;
    } else if ((keyCode == 'n') || (keyCode == 'N')) {
      currentScreen = 9;
    }
  }
  
  if (currentScreen == 9) {
    if (keyCode == ' ') {
      currentScreen = 0;
    }
  } 
}

//Intro
void screenZero() {
  linearGradient(0, 0, width, height, b1, b2);
  makeBubbles();
  
  String Title = "Carlos the Copepod";
  textSize(40);
  fill(255);
  textAlign(CENTER, BOTTOM);
  text(Title, width/2, height/2-100);
  
  String subTitle = "Press SPACE to start";
  textSize(20);
  fill(255);
  textAlign(CENTER, TOP);
  text(subTitle, width/2, height/2+100);
  
  String info = "For more information about copepods, press I.";
  textSize(20);
  fill(255);
  textAlign(CENTER, TOP);
  text(info, width/2, height/2+150);
  
  player.create(copepod[0], 100);
  player.update();
  player.edge();
  player.display();
}
//Instructions
void screenOne() {
  linearGradient(0, 0, width, height, b1, b2);
  makeBubbles();
  
  player.reset();
  
  String intro = "Help Carlos the copepod catch his food!";
  textSize(23);
  fill(255);
  textAlign(CENTER, TOP);
  text(intro, width/2, 200);
  
  imageMode(CENTER);
  image(phyto[0], width/2 - 200, height/2, 100*phyto[0].width/phyto[0].height, 100*phyto[0].width/phyto[0].height);
  textSize(12);
  fill(255);
  textAlign(CENTER, TOP);
  text("Coscinodiscus", width/2 - 200, height/2 + 50);

  textSize(10);
  fill(255);
  textAlign(CENTER, TOP);
  text("[Diatom]", width/2 - 200, height/2 + 65);
  
  imageMode(CENTER);
  image(phyto[1], width/2 - 100, height/2, 100*phyto[1].width/phyto[1].height, 100*phyto[1].width/phyto[1].height);
  textSize(12);
  fill(255);
  textAlign(CENTER, TOP);
  text("Dinophysis", width/2 - 100, height/2 + 50);
  
  textSize(10);
  fill(255);
  textAlign(CENTER, TOP);
  text("[Dinoflagellate]", width/2 - 100, height/2 + 65);

  imageMode(CENTER);
  image(phyto[2], width/2-10, height/2, 250*phyto[2].width/phyto[2].height, 300*phyto[2].width/phyto[2].height);
  textSize(12);
  fill(255);
  textAlign(CENTER, TOP);
  text("Skeletonema", width/2 - 10, height/2 + 50);
  
  textSize(10);
  fill(255);
  textAlign(CENTER, TOP);
  text("[Diatom]", width/2 - 10, height/2 + 65);

  imageMode(CENTER);
  image(phyto[3], width/2 + 80, height/2, 100*phyto[3].width/phyto[3].height, 100*phyto[3].width/phyto[3].height);
  textSize(12);
  fill(255);
  textAlign(CENTER, TOP);
  text("Ceratium", width/2 + 80, height/2 + 50);
  
  textSize(10);
  fill(255);
  textAlign(CENTER, TOP);
  text("[Dinoflagellate]", width/2 + 80, height/2 + 65);

  imageMode(CENTER);
  image(phyto[4], width/2 + 200, height/2, 100*phyto[4].width/phyto[4].height, 100*phyto[4].width/phyto[4].height);
  textSize(12);
  fill(255);
  textAlign(CENTER, TOP);
  text("Coccolithus", width/2 + 200, height/2 + 50);
  
  textSize(10);
  fill(255);
  textAlign(CENTER, TOP);
  text("[Coccolithophore]", width/2 + 200, height/2 + 65);
  
  String dir = "Use the up arrow to move forward. Turn using the left and right arrows.";
  textSize(20);
  fill(255);
  textAlign(CENTER, BOTTOM);
  text(dir, width/2, height/2 + 140);
}

void screenTwo() {
  linearGradient(0, 0, width, height, b1, b2);
  makeBubbles();
  running = false;
  pass = false;
  stop = false;
  score = 0;
  
  player.create(copepod[0], 100);
  player.update();
  player.edge();
  player.display();
  
  String stageName = "Stage One: Nauplii Stage";
  textSize(25);
  fill(255);
  textAlign(CENTER, TOP);
  text(stageName, width/2, 200);
  
  String Goal = "Catch 5 phytoplankton before the month ends";
  textSize(20);
  fill(255);
  textAlign(CENTER, TOP);
  text(Goal, width/2, height/2 + 140);
}

//Nauplii Stage (Tutorial Level)
void screenThree() {
  if (running == false) {
    startTime = millis();
    spawnTime = millis();
    running = true;
  }
  
  spawnTimer = 10000;
  
  linearGradient(0, 0, width, height, b1, b2);
  makeBubbles();
  Time("February");
  Score(score);
  Date(day);
  
  currentTime = millis() - startTime;
  if (currentTime <= 2000) {
    day = 1;
  } else if (currentTime > 2000) {
    day = round(currentTime/2000);
  }

  player.create(copepod[0], 60);
  player.update();
  player.edge();
  player.display();
  makeFood();
  if (currentTime >= 56000) {
    stop = true;
  }
  if ((stop) && (score >= 5)) {
    pass = true;
  } else if ((stop) && (score < 5)) {
    pass = false;
  } 
  
}

//Nauplii Stage Complete
void screenFour() {
  linearGradient(0, 0, width, height, b1, b2);
  makeBubbles();
  running = false;
  
  player.create(copepod[0], 100);
  player.update();
  player.edge();
  player.display();
  
  String stageName = "Nauplii Stage Complete";
  textSize(25);
  fill(255);
  textAlign(CENTER, TOP);
  text(stageName, width/2, 200);
  
  String fact = "Fun fact: The character 'Plankton' in Spongebob Squarepants is a copepod";
  textSize(20);
  fill(255);
  textAlign(CENTER, TOP);
  text(fact, width/2, height/2 + 140);
}

//Stage Two: Copepodid Stage
void screenFive() {
  linearGradient(0, 0, width, height, b1, b2);
  makeBubbles();
  running = false;
  pass = false;
  stop = false;
  score = 0;
  
  player.create(copepod[1], 200);
  player.update();
  player.edge();
  player.display();
  
  String stageName = "Stage Two: Copepodid Stage";
  textSize(25);
  fill(255);
  textAlign(CENTER, TOP);
  text(stageName, width/2, 175);
  
  String Goal = "Catch at least 25 phytoplankton";
  textSize(20);
  fill(255);
  textAlign(CENTER, TOP);
  text(Goal, width/2, height/2 + 140);
}

//Copepodid Stage
void screenSix() {
  if (running == false) {
    startTime = millis();
    spawnTime = millis();
    running = true;
  }
  
  linearGradient(0, 0, width, height, b1, b2);  
  makeBubbles();
  Score(score);

  currentTime = millis() - startTime;

  player.create(copepod[1], 120);
  player.update();
  player.edge();
  player.display();
  makeFood();
  Calendar();
  Date(day);
  
  if (currentTime <= 60000) {
    if (currentTime <= 2000) {
      day = 1;
    } else if (currentTime > 2000) {
      day = round(currentTime/2000);
    }
  }
  
  if (currentTime > 360000) {
    stop = true;
  }
  
  if ((stop) && (score >= 25)) {
    pass = true;
  } else if ((stop) && (score < 25)) {
    pass = false;
  } 
}

//Death - Game Over (Play again?)
void screenSeven() {
  linearGradient(0, 0, width, height, b1, b2);
  makeBubbles();

  running = false;
  
  String stageName = "Carlos starved to death.";
  textSize(25);
  fill(255);
  textAlign(CENTER, TOP);
  text(stageName, width/2, 200);
  
  imageMode(CENTER);
  image(death, width/2, height/2, 150*death.width/death.height, 150*death.width/death.height);
 
  String Goal = "Try again? (Y/N)";
  textSize(20);
  fill(255);
  textAlign(CENTER, TOP);
  text(Goal, width/2, height/2 + 140);
}

//Win - Game Over (Play again?)
void screenEight() {
  linearGradient(0, 0, width, height, b1, b2);
  makeBubbles();
  running = false;
  
  player.create(copepod[2], 100);
  player.update();
  player.edge();
  player.display();
  
  String stageName = "Carlos is ready to sleep off his big meal in the deep!";
  textSize(25);
  fill(255);
  textAlign(CENTER, TOP);
  text(stageName, width/2, 200);
  
  String Goal = "Play Again? (Y/N)";
  textSize(20);
  fill(255);
  textAlign(CENTER, TOP);
  text(Goal, width/2, height/2 + 140);
}

//Life Cycle Information
void screenNine() {
  linearGradient(0, 0, width, height, b1, b2);
  makeBubbles();
  running = false;
  
  String info = "Hatched from eggs, copepod begin their lives as nauplius larvae. The nauplii will moult five or six times before turning into a copepodid. A copepodid will moult another five times before taking on its adult form. This process can take anywhere between a week to a year depending on the copepod species and its environmental conditions.";
  textSize(25);
  fill(255);
  textAlign(LEFT, TOP);
  text(info, 30, height/1.75, width-30, height);
  
  image(egg, 130, 250, 50*egg.width/egg.height, 50*egg.width/egg.height);
  image(egg, 150, 220, 50*egg.width/egg.height, 50*egg.width/egg.height);
  image(egg, 165, 275, 50*egg.width/egg.height, 50*egg.width/egg.height);
  image(copepod[0], 370, 250, 75*copepod[0].width/copepod[0].height, 75*copepod[0].width/copepod[0].height);
  image(copepod[1], 600, 250, 150*copepod[1].width/copepod[1].height, 150*copepod[1].width/copepod[1].height);
  image(copepod[2], 850, 250, 150*copepod[2].width/copepod[2].height, 150*copepod[2].width/copepod[2].height);
}

void makeBubbles() {
  int bubbleTime = 0;
  for (int i = bubbles.size()-1; i >=0; i--) {
    Bubbles bubble = bubbles.get(i);
    bubble.blowBubble();
    if (millis() - bubbleTime > 5000) {
      bubbleTime = millis();
      bubbles.add(new Bubbles(bubbleImg));
    }
    if (bubble.pop()) {
      bubbles.remove(i);
    }
  }
}

void makeFood() {  
  for (int i = foods.size()-1; i >= 0; i--) {
    Food food = foods.get(i);
    food.drift();
    food.show();
    if (millis() - spawnTime > spawnTimer) {
      spawnTime = millis();
      foods.add(new Food(phyto[int(random(0, 4))]));
    }
    if (food.eaten(player.current())) {
      foods.remove(i);
      score++;
      foods.add(new Food(phyto[int(random(0, 4))]));
    } else if (food.range()) {
      foods.remove(i);
      foods.add(new Food(phyto[int(random(0, 4))]));
    }
  }
}

void Score(int scr) {
  textSize(20);
  fill(255);
  textAlign(RIGHT, TOP);
  text(scr, width-10, 10);
}

void Time(String mth) {
  textSize(20);
  fill(255);
  textAlign(LEFT, TOP);
  text(mth, 0+40, 10);
}

void Date(int date) {
  textSize(20);
  fill(255);
  textAlign(LEFT, TOP);
  text(date, 0+10, 10);
}

//Calendar
void Calendar() {
  for (int i = months.size()-1; i >= 0; i--) {
    String month = months.get(i);
    Time(month);
    if ((currentTime > 60000) && (currentTime < 120000)) {
      months.remove(i);
      months.add(new String("April"));
      if (currentTime <= 80000) {
        day = 1;
      } else if  (currentTime > 80000) {
        day = round((currentTime-60000)/2000);
      }
    }
    if ((currentTime > 120000) && (currentTime < 180000)) {
      months.remove(i);
      months.add(new String("May"));
      if (currentTime <= 140000) {
        day = 1;
      } else if  (currentTime > 140000) {
        day = round((currentTime-120000)/2000);
      }    
    }
    if ((currentTime > 180000) && (currentTime < 240000)) {
      months.remove(i);
      months.add(new String("June"));
      if (currentTime <= 200000) {
        day = 1;
      } else if  (currentTime > 200000) {
        day = round((currentTime-180000)/2000);
      }    
    }
    if ((currentTime > 240000) && (currentTime < 300000)) {
      months.remove(i);
      months.add(new String("July"));
      if (currentTime <= 260000) {
        day = 1;
      } else if  (currentTime > 260000) {
        day = round((currentTime-240000)/2000);
      }    
    }
    if ((currentTime > 300000) && (currentTime < 360000)) {
      months.remove(i);
      months.add(new String("August"));
      if (currentTime <= 320000) {
        day = 1;
      } else if  (currentTime > 320000) {
        day = round((currentTime-300000)/2000);
      }    
    }
  }
}

//Background
void linearGradient(int x, int y, float w, float h, color c1, color c2) {
  noFill();

  for (int i = y; i <= y+h; i++) {
    float inter = map(i, y, y+h, 0, 1);
    color c = lerpColor(c1, c2, inter);
    stroke(c);
    line(x, i, x+w, i);
  }
}