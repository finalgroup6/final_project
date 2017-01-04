class Hero{
float hp;
int w, h;
int x = width/2;
int y = height/2;
int preX, preY;
int speed = 5;
int gunNum;
String nowDirection = "Down";
int nowDirectionNum; //用來傳送給player.shooted
PImage img;
PImage playerUp;
PImage playerDown;
PImage playerLeft;
PImage playerRight;
boolean shooting = false;
color green = (#00FF00);
color orange = (#FBA816);
color red = (#FF0000);

Hero(int x , int y ){
  this.x = x;
  this.y = y;
  w = 35;
  h = 65;
  hp = w;
  img = loadImage("img/player"+nowDirection+".png");
  playerUp = loadImage("img/playerUp.png");
  playerDown = loadImage("img/playerDown.png");
  playerLeft = loadImage("img/playerLeft.png");
  playerRight = loadImage("img/playerRight.png");
}

void display(){
  image(img,x,y);
  // hp
  noStroke();
  if(hp <= w*1.0/3){
    fill(red);
  }else if(hp > w*1.0/3 && hp <= w*2.0/3 ){
    fill(orange);
  }else if(hp > w*2.0/3 ){
    fill(green);
  }
  if(hp <= 0){
    hp = 0;
  }
  rect(x, y-10, hp, 4);
  stroke(0);
  noFill();
  rect(x, y-10, w, 4);
}

void move(boolean up, boolean down, boolean left, boolean right){
  preX = x;
  preY = y;
  if(up){
    y-= speed;
    img = playerUp;
    nowDirectionNum = Direction.UP;
  }
  if(down){
    y+= speed;
    img = playerDown;
    nowDirectionNum = Direction.DOWN;
  }
  if(left){
    x-= speed;
    img = playerLeft;
    nowDirectionNum = Direction.LEFT;
  }
  if(right){
    x+= speed;
    img = playerRight;
    nowDirectionNum = Direction.RIGHT;
  }

  // hero boundary detection
  image(img,x,y);
  if (x <= 0) {
    x = 0;
  }
  if (x >= width-w) {
    x = width-w;
  }    
  if (y <= 0) {
    y = 0;
  } 
  if (y >= height-h) {
    y = height-h;
  } // 讓hero走在畫布內
  
}

}