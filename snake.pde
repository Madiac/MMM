
int[] sx = new int[100];
int[] sy = new int[100];
int[] dx = new int[100];
int[] dy = new int[100];

int ax, ay;

int size;
boolean vert;
boolean start = true;
boolean apple = false;
boolean gameOver = false;

void setup(){
  smooth();
  sx[0] = 240;
  sy[0] = 240;

  dx[0] = 0;
  dy[0] = 0;

  size = 2;
  
  frameRate(10);
  size(500,500);
  background(0,0,255); 

}

void draw(){

  apple(); 
  
  keypressed();

  // Schlange Zeichnen
  
  noStroke();
  fill(0,0,255);
  rect(sx[size-1],sy[size-1],20,20);
  

  fill(255);
  rect(sx[0],sy[0],20,20);
  
  //SnakeArray beschreiben
  for(int i=size; i > 0; i--){
    sx[i] = sx[i-1];
    sy[i] = sy[i-1];
  }
  //Bewegen   
  sx[0] = sx[0] + dx[0];
  sy[0] = sy[0] + dy[0];

  keypressed();
  

  
  
 
  //Apple malen
  fill(255,0,0);
  rect(ax,ay,20,20);
  

  
  
   
  
 


  
   
  if(gameOver == true)background(0); 


  
  collision();

}

void collision(){

  //Schlange trifft auf Apfel
  if(sx[0]==ax && sy[0]==ay){
    size++;
    apple = false;
  }  

  //Außerhalb des Spielfeldes
  if(sx[0] < 0 || sx[0] >= width || sy[0] < 0 || sy[0] >= height){
    gameOver = true;
  }
  
  //Kollision mit sich selbst
  if(size > 2){
    for(int i=0; i < size-1; i++){
      if(sx[0]==sx[i+1] && sy[0]==sy[i+1]){
        gameOver = true;
      } 
    }
  } 
}

void apple(){
  boolean Hit= true;
    if(apple == false){
  
    while(Hit){  
    ax = (int)random(0,25)*20;
    ay = (int)random(0,25)*20;
    for(int i=0; i < size; i++){
      if(!(sx[i]==ax && sy[i]==ay)){
       Hit = false;
    } 
    
  }
 }
    rect(ax,ay,20,20); 
    apple = true;
    
    

 }
}

void keypressed(){
   if(keyCode == UP && vert==false){
     dy[0] = -20;
     dx[0] = 0;
     vert = true;
   } 
   if(keyCode == DOWN&& vert==false){
     dy[0] = 20;
     dx[0] = 0;
     vert = true;
   }
   if(keyCode == RIGHT && (vert==true||start == true)){
     dx[0] = 20;
     dy[0] = 0;
     vert = false;
     start = false;
   }
   if(keyCode == LEFT && (vert==true||start == true)){
     dx[0] = -20;
     dy[0] = 0;
     vert = false;
     start = false;
   }
   if(key == ' ' ){
      gameOver = false; 
      setup();      
   }
   
}

class Animation {
  PImage[] images;
  int imageCount;
  int frame;
  
  Animation(String imagePrefix, int count) {
    imageCount = count;
    images = new PImage[imageCount];

    for (int i = 0; i < imageCount; i++) {
      // Use nf() to number format 'i' into four digits
      String filename = imagePrefix + nf(i, 4) + ".gif";
      images[i] = loadImage(filename);
    }
  }

  void display(float xpos, float ypos) {
    frame = (frame+1) % imageCount;
    image(images[frame], xpos, ypos);
  }
  
  int getWidth() {
    return images[0].width;
  }
}

