//current features: ball moves on only diagonals at 1 speed, bounces off all walls, paddle can be moved with mouse up and down. ball bounces off face of bumper predictably, but if bounces corner of bumper, the ball may bounce off at more of an angle, ball spawns in random position, gameover screen if ball hits right wall, with reset button

//boolean variables
boolean gameover;
boolean randomballspawn;
boolean bounceoffback;
boolean gameisover;
boolean framecounter;
boolean mainmenu;


//ball variables
float ballX;   //ball x position (top left corner)
float ballY;   //ball y position (top left corner)
float ballVX;  //ball x-axis velocity (+ve is right)
float ballVY;  //ball y-axis velocity (+ve is down)

//paddle variables
float paddleX;  //paddle x position (top left corner)
float paddleY;  //paddle y position (top left corner)
float oppaddleX;  //opposing paddle x position (top left corner)
float oppaddleY;  //opposing paddle y position (top left corner)

//main menu variables

//start button rectangle variables
float startrectX;
float startrectY;
float startrectwidth;
float startrectheight;

//frame rate shown button rectange variables
float framerectX;
float framerectY;
float framerectwidth;
float framerectheight;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////   1   T I M E   S E T U P    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

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
  oppaddleX = width/6;
  oppaddleY = height*5/12;
  
  //info about start button
  startrectX = width/12;
  startrectY = height/3;
  startrectwidth = width/3;
  startrectheight = height/5;
  
  //info about frame rate button
  framerectX = width - startrectX - startrectwidth;
  framerectY = startrectY;
  framerectwidth = startrectwidth;
  framerectheight = startrectheight;
    
  //put true to enable frame rate counter
  framecounter = false;
  
  //put true to enable gameover screen
  gameover = true;
  
  //put true to enable main menu
  mainmenu = true;
  
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

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////   A C T I V E  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

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
  if (ballX < width/6 + width/60) { 
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
  
  //opposing paddle Y-level
  oppaddleY = ballY + width/120 - height/12;
  
  //make sure paddle does not leave screen
  if (oppaddleY < 0) {
    oppaddleY = 0;
  }
  else if (oppaddleY + height/6 > height) {
    oppaddleY = height - height/6;
  }

  //draw opposition paddle
  fill (255, 255, 255);
  rect (oppaddleX, oppaddleY, width/60, height/6, width/240);
  
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////  G A M E   O V E R   S C R E E N  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////  
  
  //game is over state
  if (gameisover && !mainmenu) {
    background (0);
    textSize (height/6);
    fill (255);
    textAlign (CENTER, BOTTOM);
    text ("GAME OVER", width/2, height/6);
    
    //start button
    fill (255);
    rect (startrectX, startrectY, startrectwidth, startrectheight, width/240);
    fill (0);
    textAlign (CENTER, CENTER);
    text ("START", startrectX + startrectwidth/2, startrectY + startrectheight/2.5);
    
    //main menu button
    fill (255);
    rect (framerectX, framerectY, framerectwidth, framerectheight, width/240);
    String frame = "MAIN MENU";
    fill (0);
    textAlign (CENTER, CENTER);
    textSize (height/11);
    text(frame, framerectX, framerectY, framerectwidth, framerectheight);
  }

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////  M A I N   M E N U   S C R E E N  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  //main menu
  if (mainmenu) {
    background (0);
    textSize (height/6);
    textAlign (LEFT, BOTTOM);
    fill (255);
    text ("PONG", width/2 - width/8, height/6);
    gameisover = false;
    
    //start button
    fill (255);
    rect (startrectX, startrectY, startrectwidth, startrectheight, width/240);
    fill (0);
    textAlign (CENTER, CENTER);
    text ("START", startrectX + startrectwidth/2, startrectY + startrectheight/2.5);
    
    //frame rate colour changing rectangle
    if (framecounter) {
      fill (20, 255, 20);
    }
    else {
      fill (255, 20, 20);
    }
    rect (framerectX, framerectY, framerectwidth, framerectheight, width/240);
    
    //frame rate text
    String frame = "SHOW FRAME RATE";
    fill (0);
    textAlign (CENTER, CENTER);
    textSize (height/14);
    text(frame, framerectX, framerectY, framerectwidth, framerectheight);
    
  }

///////////////////////////////////////////////////////////////////////////////////////////////////////////   E N D   O F   M A I N   M E N U   ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////    
    
  //frame rate displayed if enabled
  if (framecounter) {
    fill(255);
    textSize(12);
    textAlign (LEFT, TOP);
    text("Frame rate: " + int(frameRate), 0, 0);
  }
  
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////   E N D   O F   V O I D   D R A W   ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//stuff that happens when mouse is depressed
void mouseReleased () {
  
  //frame rate button
  if (mainmenu && mouseX >= framerectX && mouseX <= framerectX + framerectwidth && mouseY >= framerectY && mouseY <= framerectY + framerectheight) {
    framecounter = !framecounter;
  }
  
  //main menu button
  if (gameisover && mouseX >= framerectX && mouseX <= framerectX + framerectwidth && mouseY >= framerectY && mouseY <= framerectY + framerectheight) {
    gameisover = false;
    mainmenu = true;
  }
  
  //start button main menu
  else if (mainmenu && mouseX >= startrectX && mouseX <= startrectX + startrectwidth && mouseY >= startrectY && mouseY <= startrectY + startrectheight) {
    mainmenu = false;
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
    
  //start button game over
  else if (gameisover && mouseX >= startrectX && mouseX <= startrectX + startrectwidth && mouseY >= startrectY && mouseY <= startrectY + startrectheight) {
    mainmenu = false;
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
