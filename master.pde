//class Gun裡面改
//void addbullet(){
//  if(treasure.treasureEaten == true){
   
//  int r =  floor(random(1,gunLimit));
  
//  if (bulletNow != bulletMax && bulletNow < bulletMax){
//   gunArray[r].bulletNow = gunArray[r].bulletMax;
 
//   treasure.treasureEaten = false;  
//  }
//}
    
//}

//class Treasure 增加假設人的血量夠就不能++
//void eaten(){
//  if(isHit(hero.x,hero.y,hero.img.width,hero.img.height,x,y,img.width,img.height)){
//    treasureEaten = true;
//    x = width;
//    y = height;
//   if(hero.hp < 100){
//    hero.hp += 20; 
//    println("hp++");
//   }
//  }
//}

boolean isMovingUp;
boolean isMovingDown;
boolean isMovingLeft;
boolean isMovingRight;
PImage block;
float bX1,bY1,bX2,bY2;

// 遊戲架構
int gameState = 0;
final int GAME_START = 0, GAME_RUN_1 = 1, GAME_RUN_2 = 2, GAME_OVER = 3; // 遊戲架構
PImage gameStart0, gameStart1, gameStart2, gameOver0, gameOver1, gameOver2; // 遊戲開始畫面、滑鼠在關卡1畫面、滑鼠在關卡2畫面、失敗畫面、重玩一次、回主選單

Hero hero;
//Block[] blockArray; 陳莉蓉block寫法

int zombieMax = 300;
int zombieNow = 0;
Zombie[] zombieArray = new Zombie[zombieMax];

int gunMax = 5;
int gunLimit = 3;//第n支槍還不能用
int gunNow = 1;
Gun[] gunArray = new Gun[gunMax];

JSONObject json;
int stageState = -1; //遊戲關卡 用來變換場景
int blockMax = 3; //每關的block數量 預設第一關3個
int bX[] = new int[blockMax]; //每個block的x
int bY[] = new int[blockMax];
Block[] blockArray = new Block[blockMax];

Treasure treasure;

class Direction
{
  static final int LEFT = 0;
  static final int RIGHT = 1;
  static final int UP = 2;
  static final int DOWN = 3;
}

void setup(){
size(640, 480);
hero = new Hero(width/2,height/2);
treasure = new Treasure();
gunArray[gunNow] = new Gun(gunNow); //預設使用第1隻槍
changeStage();
frameRate(60);
//// 遊戲開始&失敗畫面
//gameStart0 = loadImage("img/start0.png");
//gameStart1 = loadImage("img/start1.png");
//gameStart2 = loadImage("img/start2.png");
//gameOver0 = loadImage("img/over0.png");
//gameOver1 = loadImage("img/over1.png");
//gameOver2 = loadImage("img/over2.png");// 遊戲開始&失敗畫面

  // blockArray初始化 陳莉蓉寫法
  //blockArray = new Block[9];
  //for(int i = 0; i < blockArray.length; i++){
  //  blockArray[i] = new Block();
  //  blockArray[i].x = 130+(i%3)*150;
  //  blockArray[i].y = 80+(i/3)*120;
  //}
}

void draw(){
  
  ////遊戲架構
  //switch (gameState){
  //  case GAME_START:
  //      image(gameStart0,0,0);
  //        if(mouseX > 80 && mouseX < 240 && mouseY > 120 && mouseY < 360){ //玩第一關
  //          image(gameStart1,0,0);
  //          if(mousePressed){              
  //            gameState = GAME_RUN_1;
  //          }            
  //        }
  //        if(mouseX > 400 && mouseX < 560 && mouseY > 120 && mouseY < 360){ //玩第二關
  //          image(gameStart2,0,0);
  //          if(mousePressed){              
  //            gameState = GAME_RUN_2;
  //          }            
  //        }          
  //      break;
        
  //  case GAME_RUN_1:
  //      // 呼叫第一關的物件
  //      if(hero.hp <= 0){
  //        gameState = GAME_OVER;
  //      }
  //      break;
        
  //  case GAME_RUN_2:
  //      // 呼叫第二關的物件
  //      if(hero.hp <= 0){
  //        gameState = GAME_OVER;
  //      }          
  //      break;        
        
  //  case GAME_OVER:
  //      image(gameOver0,0,0);
  //        if(mouseX > 80 && mouseX < 240 && mouseY > 120 && mouseY < 360){ //重玩一次
  //          image(gameOver1,0,0);
  //          if(mousePressed){              
  //            gameState = GAME_RUN_1;
  //          }            
  //        }
  //        if(mouseX > 400 && mouseX < 560 && mouseY > 120 && mouseY < 360){ //回主選單
  //          image(gameOver2,0,0);
  //          if(mousePressed){              
  //            gameState = GAME_START;
  //          }            
  //        }     
  //      break;
  //}      
  
  background(#D6C38F);

  // Block display type 0 陳莉蓉寫法
  //for(int i = 0; i < blockArray.length; i++){
  //  blockArray[i].display(0);
  //}
  
  //Treasure
  treasure.display();
  treasure.eaten();
  
  //Hero
  hero.display();
  hero.move(isMovingUp,isMovingDown,isMovingLeft,isMovingRight);
  
  //Gun
  if(gunArray[gunNow] != null){
    gunArray[gunNow].display();
  }
  
  //Zombie
  for (int i=0; i<zombieNow; i++){
    if(zombieArray[i].x != width && zombieArray[i].y != height){
      zombieArray[i].move();
      zombieArray[i].display();
      zombieArray[i].hpCheck();
      if(hero.shooting){
        if(zombieArray[i].shooted (hero.nowDirectionNum, i)){
          zombieArray[i].hp -= gunArray[gunNow].power;
          hero.shooting = false;
        }
      }
    }
  }
  //Block
  for(int i=0; i<blockMax; i++){
    blockArray[i].display();
    blockArray[i].collision();
  }

  // Block display type 1 陳莉蓉寫法
  //for(int i = 0; i < blockArray.length; i++){
  //  blockArray[i].display(1);
  //}

}

/*-----------------操控--------------------*/
void keyPressed() {
  switch(keyCode) {
  case UP : 
    isMovingUp = true ;
    hero.nowDirectionNum =Direction.UP;
    break ;
  case DOWN : 
    isMovingDown = true ;
    hero.nowDirectionNum =Direction.DOWN;
    break ;
  case LEFT : 
    isMovingLeft = true ; 
    hero.nowDirectionNum =Direction.LEFT;
    break ;
  case RIGHT : 
    isMovingRight = true ;
    hero.nowDirectionNum =Direction.RIGHT;
    break ;
  case ENTER : //暫時用來變換場景
    changeStage();
    break;
  default :
    break ;
  }
  
  //槍枝變換 從1號開始 跟鍵盤按鍵、圖片編號一致
  if(key>='1' && key<='9'){
    gunNow = key-48;
    if(gunNow < gunLimit){
      if(gunArray[gunNow] == null){
        gunArray[gunNow] = new Gun(gunNow);
      }
    }
  }
  //開槍
  if(key == ' '){
    if(gunArray[gunNow].bulletNow>0){
      hero.shooting = true;
      gunArray[gunNow].bulletNow --;
    }
  }
  
  if(key == 'z'){
    if(zombieNow < zombieMax){
      zombieArray[zombieNow] = new Zombie();
      zombieNow++;
      println(zombieNow);
    }
  } 
}

void keyReleased() {
  switch(keyCode) {
  case UP : 
    isMovingUp = false ;
    break ;
  case DOWN : 
    isMovingDown = false ; 
    break ;
  case LEFT : 
    isMovingLeft = false ; 
    break ;
  case RIGHT : 
    isMovingRight = false ; 
    break ;
  default :
    break ;
  }
  if(key == ' '){
    hero.shooting = false;
  }
}

