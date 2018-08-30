//current features: ball moves on only diagonals at 1 speed, bounces off all walls, paddle can be moved with mouse up and down. ball bounces off face of bumper predictably, but if bounces corner of bumper, the ball may bounce off at more of an angle, ball spawns in random position, gameover screen if ball hits right wall, with reset button

//gameover screen
boolean gameover;
boolean randomballspawn;
boolean bounceoffback;
boolean gameisover;


//ball variables
float ballX;   //ball x position (top left corner)
float ballY;   //ball y position (top left corner)
float ballVX;  //ball x-axis velocity (+ve is right)
float ballVY;  //ball y-axis velocity (+ve is down)

//paddle variables
float paddleX;  //paddle x position (top left corner)
float paddleY;  //paddle y position (top left corner)

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//run at start of game
void setup () {

  //size of game (can be changed since all lengths depend on size of game, designed for 16x9)
  size (1280, 720);
  
  //info about ball
  ballX = width/2;
  ballY = height/2;
  ballVX = 1;
  ballVY = 1;
  
  //info about paddle
  paddleX = width*5/6;
  paddleY = height*5/12;
  
  //put true to enable gameover screen
  gameover = true;
  
  //put true to randomise ball starting position
  randomballspawn = true;
  
  //put true to let ball bounce off back wall (may be slightly glitchy)
  bounceoffback = false;
  
  //put true to make game be over
  gameisover = false;
  
    //randomise starting position of ball
  if (randomballspawn) {
    ballY = random (0, height - width/60);
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//active stuff (happens every frame)
void draw() {
  
  //black background (at start to cover old frame)
  background (0);
  
  //draw ball
  fill (255, 255, 255);
  rect (ballX, ballY, width/60, width/60, width/240);
  
  //move ball right (if x-axis velocity is +ve)
  if (ballVX > 0) { 
    ballX = ballX + width/320;
  }  
  //move ball left (if x-axis velocity is -ve)
  else if (ballVX < 0) { 
    ballX = ballX + -width/320;
  }  

  //move ball down (if y-axis velocity is +ve)
  if (ballVY > 0) { 
    ballY = ballY + width/320;
  }  
  //move ball up (if y-axis velocity is -ve)
  else if (ballVY < 0) { 
    ballY = ballY + -width/320;
  }  
  
  //bounce off top
  if (ballY <= 0) { 
    ballVY = ballVY * -1;
  }  
  //bounce off bottom
  if (ballY + width/60 -1 >= height) { 
    ballVY = ballVY * -1;
  }  
  
  //bounce off left
  if (ballX < 2) { 
    ballVX = ballVX * -1;
  }  
  //if hits right wall, game over/bounce back/randomly respawn/respawn in middle
  if (ballX + width/60> width) { 
    if (gameover) {
      gameisover = true;
    }
    else if (bounceoffback) {
      ballVX = ballVX * -1;
    }
    else if (randomballspawn) {
      ballY = random (0, height - width/60);
      ballX = width/2;
    }
    else {
      ballX = width/2;
      ballY = height/2;
    }
  }  
  
  //draw paddle
  rect (paddleX, paddleY, width/60, height/6, width/240);
  
  //move paddle up
  if (mouseY < paddleY) {
    paddleY = paddleY + -width/320;
  }
  
  //move paddle down
  else if (mouseY > paddleY + height/6) {
    paddleY = paddleY + width/320;
  }
  
  //bounce off paddle when in middle
  if (ballX + width/60 -1 > paddleX && ballX + width/60 -1 < paddleX + width/160 && ballY > paddleY && ballY + width/60 -1 < paddleY + height/6 -1) {
    ballVX = -1;
  }
  
  //bounce off top corner of paddle
  if (ballX + width/60 -1 > paddleX && ballX + width/60 -1 < paddleX + width/160 && ballY + width/60 -1 < paddleY + height/6 -1 && paddleY < ballY + width/60 -1 && ballY < paddleY) {
    ballVX = -1;
    ballVY = -1;
  }
  
  //bounce off bottom corner of paddle
  if (ballX + width/60 -1 > paddleX && ballX + width/60 -1 < paddleX + width/160 && ballY > paddleY && paddleY + height/6 -1 > ballY && ballY + width/60 -1 > paddleY + height/6 -1) {
    ballVX = -1;
    ballVY = +1;
  }
  
  //bounce off top of paddle
  if (ballX < paddleX + width/160 && ballX > paddleX && ballY + width/60 -1 > paddleY && ballY + width/60 -1 < paddleY + height/6 -1) {
    ballVY = -1;
  }     
      
  //bounce off bottom of paddle
  if (ballX < paddleX + width/160 && ballX > paddleX && ballY < paddleY + height/6 -1 && ballY > paddleY) {
    ballVY = +1;
  }
  
  //game is over state
  if (gameisover) {
    background (0);
    textSize (100);
    fill (255, 255, 255);
    text ("GAME OVER", 100, 100);
    fill (255, 0, 255);
    rect (100, 300, 500, 100);
    fill (0, 0, 0);
    text ("RESET", 150, 380);
    if (mousePressed == true && mouseX >=100 && mouseX <= 600 && mouseY >= 300 && mouseY <= 400) {
      gameisover = false;
      if (randomballspawn) {
        ballY = random (0, height - width/60);
        ballX = width/2;
      }
      else {
        ballX = width/2;
        ballY = height/2;
      }
    }
  }
    
}
