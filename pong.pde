//current features: ball moves on only diagonals at 1 speed, bounces off all walls, paddle can be moved with mouse up and down. ball bounces off face of bumper predictably, but if bounces corner of bumper, the ball may bounce off at more of an angle

//ball variables
float ballX;   //ball x position (top left corner)
float ballY;   //ball y position (top left corner)
float ballVX;  //ball x-axis velocity (+ve is right)
float ballVY;  //ball y-axis velocity (+ve is down)

//paddle variables
float paddleX;  //paddle x position (top left corner)
float paddleY;  //paddle y position (top left corner)

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
}



//active stuff (happens every frame)
void draw() {
  
  //black background (at start to cover old frame
  background (0);
  
  //draw ball
  rect (ballX, ballY, width/60, width/60, width/240);
  
  //move ball right (if x-axis velocity is +ve)
  if (ballVX > 0) { 
    ballX = ballX + width/320;
  }  
  //move ball left (if x-axis velocity is -ve)
  if (ballVX < 0) { 
    ballX = ballX + -width/320;
  }  

  //move ball down (if y-axis velocity is +ve)
  if (ballVY > 0) { 
    ballY = ballY + width/320;
  }  
  //move ball up (if y-axis velocity is -ve)
  if (ballVY < 0) { 
    ballY = ballY + -width/320;
  }  
  
  //bounce off top
  if (ballY < 2) { 
    ballVY = 1;
  }  
  //bounce off bottom
  if (ballY + width/60> height) { 
    ballVY = -1;
  }  
  
  //bounce off left
  if (ballX < 2) { 
    ballVX = 1;
  }  
  //bounce off right (will be changed to game over)
  if (ballX + width/60> width) { 
    ballVX = -1;
  }  
  
  //draw paddle
  rect (paddleX, paddleY, width/60, height/6, width/240);
  
  //move paddle up
  if (mouseY < paddleY) {
    paddleY = paddleY + -width/320;
  }
  
  //move paddle down
  if (mouseY > paddleY + height/6) {
    paddleY = paddleY + width/320;
  }
  
  //bounce off paddle when in middle
  if (ballX + width/60 -1 > paddleX) {
    if (ballX + width/60 -1 < paddleX + width/160) {
      if (ballY > paddleY) {
        if (ballY + width/60 -1 < paddleY + height/6 -1) {
          ballVX = -1;
        }
      }
    }
  }
  
  //bounce off top of paddle
  if (ballX + width/60 -1 > paddleX) {
    if (ballX + width/60 -1 < paddleX + width/160) {
      if (ballY + width/60 -1 < paddleY + height/6 -1) {
        if (paddleY < ballY + width/60 -1) { 
          if (ballY < paddleY) {
            ballVX = -1;
            ballVY = -1;
          }
        }
      }
    }
  }
  
  //bounce off bottom of paddle
  if (ballX + width/60 -1 > paddleX) {
    if (ballX + width/60 -1 < paddleX + width/160) {
      if (ballY > paddleY) {
        if (paddleY + height/6 -1 > ballY) { 
          if (ballY + width/60 -1 > paddleY + height/6 -1) {
            ballVX = -1;
            ballVY = +1;
          }
        }
      }
    }
  }
}
