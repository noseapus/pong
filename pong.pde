//current features: ball moves on only diagonals at 1 speed, bounces off all walls, paddle can be moved with mouse up and down. ball bounces off face of bumper predictably, but if bounces corner of bumper, the ball may bounce off at more of an angle, ball spawns in random position, gameover screen if ball hits right wall, with reset button

//boolean variables
boolean gameover;
boolean randomballspawn;
boolean bounceoffback;
boolean gameisover;
boolean framecounter;
boolean mainmenu;
boolean aimbot;
boolean frameratechange;


//ball variables
float ballX;   //ball x position (top left corner)
float ballY;   //ball y position (top left corner)
float startingballVX;   //speed ball starts at
float startingballVY;   //speed ball starts at
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
float butcorn;

//frame rate shown button rectange variables
float framerectX;
float framerectY;
float framerectwidth;
float framerectheight;

//resolution button variables (obseleted)
float restopY;
float resbottomY;
float resleftX;
float resrightX;

float reswidth;
float resheight;
float resbutwidth;
float resbutheight;

//score
int score;

//frame rate
int framerate;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////   1   T I M E   S E T U P    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//run at start of game
void setup () {

  //size of game (can be changed since all lengths depend on size of game, designed for 16x9)
  size (1280, 720);

  //if you want it to be fullscreen, un // the fullScreen function
  //fullScreen ();

  //framerate, adjust to speed up or down the game
  framerate = 120;
  frameRate(framerate);

  //info about ball
  ballX = width/2;
  ballY = height/2;
  startingballVX = width/framerate/5.333;
  startingballVY = width/framerate/5.333;
  ballVX = startingballVX;
  ballVY = startingballVY;

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
  butcorn = width/240;

  //info about frame rate button
  framerectX = width - startrectX - startrectwidth;
  framerectY = startrectY;
  framerectwidth = startrectwidth;
  framerectheight = startrectheight;

  //info about size buttons (obseleted)
  reswidth = startrectwidth;
  resheight = startrectheight;
  resbutwidth = reswidth*2/5;
  resbutheight = resheight*2/5;

  resleftX = startrectX;
  restopY = startrectY + startrectheight + height/6;
  resrightX = resleftX + reswidth - resbutwidth;
  resbottomY = restopY + resheight - resbutheight;

  //put true to enable aimbot
  aimbot = false;

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

  //put true if frame rate is changing
  frameratechange = false;


  //starts score off at 0
  score = 0;

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
  fill (255);
  rect (ballX, ballY, width/60, width/60, width/240);

  //move ball x-axis
  ballX += ballVX;  

  //move ball y-axis
  ballY += ballVY;

  //bounce off top
  if (ballY <= 0) { 
    ballVY = abs(ballVY);
  }  
  //bounce off bottom
  if (ballY + width/60 -1 >= height) { 
    ballVY = -abs(ballVY);
  }  

  //bounce off left
  if (ballX < width/6 + width/60) { 
    ballVX = abs(ballVX);
  }  
  //if hits right wall, game over/bounce back/randomly respawn/respawn in middle
  if (ballX + width/60> width) { 
    if (gameover) {
      gameisover = true;
    } else if (bounceoffback) {
      ballVX = -abs(ballVX);
    } else if (randomballspawn) {
      ballY = random (0, height - width/60);
      ballX = width/2;
      ballVX = startingballVX;
      ballVY = startingballVY;
    } else {
      ballX = width/2;
      ballY = height/2;
      ballVX = startingballVX;
      ballVY = startingballVY;
    }
  }  

  //aimbot script
  if (aimbot) {
    paddleY = ballY - height/12;
  }

  //draw paddle
  rect (paddleX, paddleY, width/60, height/6, width/240);

  //move paddle up
  if (mouseY < paddleY) {
    paddleY = paddleY + -width/framerate/4;
  }

  //move paddle down
  else if (mouseY > paddleY + height/6) {
    paddleY = paddleY + width/framerate/4;
  }

  //bounce off paddle when in middle
  if (ballX + width/60 -1 > paddleX && ballX + width/60 -1 < paddleX + width/160 && ballY > paddleY && ballY + width/60 -1 < paddleY + height/6 -1) {
    ballVX = -abs(ballVX);
    score++;
  }

  //bounce off top corner of paddle
  if (ballX + width/60 -1 > paddleX && ballX + width/60 -1 < paddleX + width/160 && ballY + width/60 -1 < paddleY + height/6 -1 && paddleY < ballY + width/60 -1 && ballY < paddleY) {
    ballVX = -abs(ballVX);
    ballVY = -abs(ballVY);
    score++;
  }

  //bounce off bottom corner of paddle
  if (ballX + width/60 -1 > paddleX && ballX + width/60 -1 < paddleX + width/160 && ballY > paddleY && paddleY + height/6 -1 > ballY && ballY + width/60 -1 > paddleY + height/6 -1) {
    ballVX = -abs(ballVX);
    ballVY = abs(ballVY);
    score++;
  }

  //bounce off top of paddle
  if (ballX < paddleX + width/160 && ballX > paddleX && ballY + width/60 -1 > paddleY && ballY + width/60 -1 < paddleY + height/6 -1) {
    ballVY = -abs(ballVY);
  }     

  //bounce off bottom of paddle
  if (ballX < paddleX + width/160 && ballX > paddleX && ballY < paddleY + height/6 -1 && ballY > paddleY) {
    ballVY = abs(ballVY);
  }

  //opposing paddle Y-level
  oppaddleY = ballY + width/120 - height/12;

  //make sure paddle does not leave screen
  if (oppaddleY < 0) {
    oppaddleY = 0;
  } else if (oppaddleY + height/6 > height) {
    oppaddleY = height - height/6;
  }

  //draw opposition paddle
  fill (255, 255, 255);
  rect (oppaddleX, oppaddleY, width/60, height/6, width/240);

  //display score
  textSize (height/6);
  textAlign (RIGHT, TOP);
  fill (255);
  text (score, width, 0);

  ballVX *= 1.0001;
  ballVY *= 1.0001;

  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////  G A M E   O V E R   S C R E E N  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////  

  //game is over state
  if (gameisover && !mainmenu) {
    background (0);
    textSize (height/6);
    fill (255);
    textAlign (CENTER, BOTTOM);
    text ("GAME OVER", width/2, height/6);

    //display score
    textSize (height/6);
    fill (255);
    textAlign (CENTER, BOTTOM);
    text(("Score: " + score), width/2, height - 50);

    //start button
    fill (255);
    rect (startrectX, startrectY, startrectwidth, startrectheight, butcorn);
    fill (0);
    textAlign (CENTER, CENTER);
    text ("START", startrectX + startrectwidth/2, startrectY + startrectheight/2.5);

    //main menu button
    fill (255);
    rect (framerectX, framerectY, framerectwidth, framerectheight, butcorn);
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
    rect (startrectX, startrectY, startrectwidth, startrectheight, butcorn);
    fill (0);
    textAlign (CENTER, CENTER);
    text ("START", startrectX + startrectwidth/2, startrectY + startrectheight/2.5);

    //frame rate colour changing rectangle
    if (framecounter) {
      fill (20, 255, 20);
    } else {
      fill (255, 20, 20);
    }
    rect (framerectX, framerectY, framerectwidth, framerectheight, butcorn);

    //frame rate text
    String frame = "SHOW FRAME RATE";
    fill (0);
    textAlign (CENTER, CENTER);
    textSize (height/14);
    text(frame, framerectX, framerectY, framerectwidth, framerectheight);

    //size buttons (obselete)
    fill(255);
    rect (resleftX, restopY, resbutwidth, resbutheight, butcorn);
    rect (resrightX, restopY, resbutwidth, resbutheight, butcorn);
    rect (resleftX, resbottomY, resbutwidth, resbutheight, butcorn);
    rect (resrightX, resbottomY, resbutwidth, resbutheight, butcorn);

    fill (0);
    textAlign (CENTER, CENTER);
    textSize (height/17);

    String threesixty = "30tick";
    text(threesixty, resleftX, restopY, resbutwidth, resbutheight);
    String seventwenty = "60tick";
    text(seventwenty, resrightX, restopY, resbutwidth, resbutheight);
    String teneighty = "120tick";
    text(teneighty, resleftX, resbottomY, resbutwidth, resbutheight);
    String fourteenforty = "240tick";
    text(fourteenforty, resrightX, resbottomY, resbutwidth, resbutheight);
  }

  ///////////////////////////////////////////////////////////////////////////////////////////////////////////   E N D   O F   M A I N   M E N U   ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////    

  //frame rate displayed if enabled
  if (framecounter) {
    fill(255);
    textSize(12);
    textAlign (LEFT, TOP);
    text("Frame rate: " + int(frameRate), 0, 0);
  }

  //change in frame rate
  if (frameratechange) {
    frameRate (framerate);
    frameratechange = false;
    startingballVX = width/framerate/5.333;
    startingballVY = width/framerate/5.333;
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

  //start button main menu and game over
  else if ((mainmenu || gameisover) && mouseX >= startrectX && mouseX <= startrectX + startrectwidth && mouseY >= startrectY && mouseY <= startrectY + startrectheight) {
    mainmenu = false;
    gameisover = false;
    score = 0;
    if (randomballspawn) {
      ballY = random (0, height - width/60);
      ballX = width/2;
    } else {
      ballX = width/2;
      ballY = height/2;
    }
    ballVX = startingballVX;
    ballVY = startingballVY;
  }

  //size buttons (obseleted)
  if (mainmenu) {
    if (mouseX >= resleftX && mouseX <= resleftX + resbutwidth && mouseY >= restopY && mouseY <= restopY + resbutheight) {
      framerate = 30;
      frameratechange = true;
    } else if (mouseX >= resrightX && mouseX <= resrightX + resbutwidth && mouseY >= restopY && mouseY <= restopY + resbutheight) {
      framerate = 60;
      frameratechange = true;
    } else if (mouseX >= resleftX && mouseX <= resleftX + resbutwidth && mouseY >= resbottomY && mouseY <= resbottomY + resbutheight) {
      framerate = 120;
      frameratechange = true;
    } else if (mouseX >= resrightX && mouseX <= resrightX + resbutwidth && mouseY >= resbottomY && mouseY <= resbottomY + resbutheight) {
      framerate = 240;
      frameratechange = true;
    }
  }
}
