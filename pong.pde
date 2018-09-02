//current features: ball moves on only diagonals at 1 speed, bounces off all walls, paddle can be moved with mouse up and down. ball bounces off face of bumper predictably, but if bounces corner of bumper, the ball may bounce off at more of an angle, ball spawns in random position, gameover screen if ball hits right wall, with reset button

//boolean variables
boolean gameover;
boolean bounceoffback;
boolean gameisover;
boolean framecounter;
boolean mainmenu;
boolean aimbot;
boolean frameratechange;
boolean cheatpage;

//ball variables
float ballX;   //ball x position (top left corner)
float ballY;   //ball y position (top left corner)
float ballwidth;  //width and height of ball
float ballcorner;  //size of the rounding at the corner of the ball, also used for paddles.
float startingballVX;   //speed ball starts at
float startingballVY;   //speed ball starts at
float ballVX;  //ball x-axis velocity (+ve is right)
float ballVY;  //ball y-axis velocity (+ve is down)

//paddle variables
float paddleX;  //paddle x position (top left corner)
float paddleY;  //paddle y position (top left corner)
float oppaddleX;  //opposing paddle x position (top left corner)
float oppaddleY;  //opposing paddle y position (top left corner)
float paddlewidth;  //width of both paddles
float paddleheight;  //height of both paddles

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

//resolution button variables
float restopY;
float resbottomY;
float resleftX;
float resrightX;

float reswidth;
float resheight;
float resbutwidth;
float resbutheight;

//cheat button variables
float cheatX;
float cheatY;
float cheatwidth;
float cheatheight;

//die button variables
float dieX;
float dieY;
float diewidth;
float dieheight;

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
  framerate = 60;
  frameRate(framerate);

  //info about ball
  ballX = width/2;
  ballY = height/2;
  ballwidth = width/60;
  ballcorner = width/240;
  startingballVX = width/framerate/5.333;
  startingballVY = width/framerate/5.333;
  ballVX = startingballVX;
  ballVY = startingballVY;

  //info about paddle
  paddleX = width*5/6;
  paddleY = height*5/12;
  paddlewidth = width/60;
  paddleheight = height/6;
  oppaddleX = width/6;
  oppaddleY = height*5/12;

  //info about start button
  startrectX = width/12;
  startrectY = height/3;
  startrectwidth = width/2.75;
  startrectheight = height/5;
  butcorn = width/240;

  //info about frame rate button
  framerectX = width - startrectX - startrectwidth;
  framerectY = startrectY;
  framerectwidth = startrectwidth;
  framerectheight = startrectheight;

  //info about size buttons
  reswidth = startrectwidth;
  resheight = startrectheight;
  resbutwidth = reswidth*2/5;
  resbutheight = resheight*2/5;

  resleftX = startrectX;
  restopY = startrectY + startrectheight + height/6;
  resrightX = resleftX + reswidth - resbutwidth;
  resbottomY = restopY + resheight - resbutheight;

  //info about cheat button
  cheatX = framerectX;
  cheatY = restopY;
  cheatwidth = startrectwidth;
  cheatheight = startrectheight;

  //info about die button
  dieX = width*7/8;
  dieY = height*3/12;
  diewidth = width/8;
  dieheight = height/12;


  //put true to enable aimbot
  aimbot = false;

  //put true to enable frame rate counter
  framecounter = false;

  //put true to enable gameover screen
  gameover = true;

  //put true to enable main menu
  mainmenu = true;

  //put true to let ball bounce off back wall (may be slightly glitchy)
  bounceoffback = false;

  //put true to make game be over
  gameisover = false;

  //put true if frame rate is changing
  frameratechange = false;

  //put true to start on cheat page
  cheatpage = false;

  //starts score off at 0
  score = 0;

  //randomise starting position of ball
  ballY = random (0, height - ballwidth);
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////   A C T I V E  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//active stuff (happens every frame)
void draw() {

  //black background (at start to cover old frame)
  background (0);

  //draw ball
  fill (255);
  rect (ballX, ballY, ballwidth, ballwidth, ballcorner);

  //move ball x&y-axis
  ballX += ballVX;  
  ballY += ballVY;

  //bounce off top or bottom
  if (ballY <= 0 || ballY + ballwidth -1 >= height) {
    ballVY = ballY <= 0 ? abs(ballVY) : -abs(ballVY);
  }

  //bounce off left
  if (ballX < oppaddleX + paddlewidth) { 
    ballVX = abs(ballVX);
  }  
  //if hits right wall, game over/bounce back/randomly respawn/respawn in middle
  if (ballX + ballwidth> width) { 
    if (bounceoffback) {
      ballVX = -abs(ballVX);
    } else if (gameover) {
      gameisover = true;
    } else {
      ballY = random (0, height - ballwidth);
      ballX = width/2;
      ballVX = startingballVX;
      ballVY = startingballVY;
    }
  }  

  //aimbot script
  if (aimbot) {
    paddleY = ballY - paddleheight/2;
  }

  //draw paddle
  rect (paddleX, paddleY, paddlewidth, paddleheight, ballcorner);

  //move paddle up or down
  if (mouseY < paddleY || mouseY > paddleY + paddleheight) {
    paddleY = mouseY < paddleY ? paddleY + -width/framerate/4 : paddleY + width/framerate/4;
  }

  //bounce off paddle when in middle
  if (ballX + ballwidth -1 > paddleX && ballX + ballwidth -1 < paddleX + paddlewidth && ballY > paddleY && ballY + ballwidth -1 < paddleY + paddleheight -1) {
    ballVX = -abs(ballVX);
    score++;
  }

  //bounce off top corner of paddle
  if (ballX + ballwidth -1 > paddleX && ballX + ballwidth -1 < paddleX + paddlewidth && ballY + ballwidth -1 < paddleY + paddleheight -1 && paddleY < ballY + ballwidth -1 && ballY < paddleY) {
    ballVX = -abs(ballVX);
    ballVY = -abs(ballVY);
    score++;
  }

  //bounce off bottom corner of paddle
  if (ballX + ballwidth -1 > paddleX && ballX + ballwidth -1 < paddleX + paddlewidth && ballY > paddleY && paddleY + paddleheight -1 > ballY && ballY + ballwidth -1 > paddleY + paddleheight -1) {
    ballVX = -abs(ballVX);
    ballVY = abs(ballVY);
    score++;
  }

  //bounce off top of paddle
  if (ballX < paddleX + paddlewidth && ballX > paddleX && ballY + ballwidth -1 > paddleY && ballY + ballwidth -1 < paddleY + paddleheight -1) {
    ballVY = -abs(ballVY);
  }     

  //bounce off bottom of paddle
  if (ballX < paddleX + paddlewidth && ballX > paddleX && ballY < paddleY + paddleheight -1 && ballY > paddleY) {
    ballVY = abs(ballVY);
  }

  //opposing paddle Y-level
  oppaddleY = ballY + ballwidth/2 - paddleheight/2;

  //make sure paddle does not leave screen
  if (oppaddleY < 0 || oppaddleY + paddleheight > height) {
    oppaddleY = oppaddleY < 0 ? 0 : height - paddleheight;
  }

  //draw opposition paddle
  fill (255);
  rect (oppaddleX, oppaddleY, paddlewidth, paddleheight, ballcorner);

  //display score
  textSize (height/6);
  textAlign (RIGHT, TOP);
  fill (255);
  text (score, width, 0);

  if (aimbot) {
    textSize (height/18);
    textAlign (RIGHT, TOP);
    fill (255);
    text ("AIMBOT", width, height/6);
  }

  //die button
  if (bounceoffback || aimbot) {
    fill (255);
    rect (dieX, dieY, diewidth, dieheight, butcorn);
    fill (0);
    textAlign (CENTER, CENTER);
    textSize (height/32);
    text("CLICK TO DIE", dieX, dieY, diewidth, dieheight);
  }

  ballVX *= (1 + 0.0001*60/framerate);
  ballVX *= (1 + 0.0001*60/framerate);

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
    fill (0);
    textAlign (CENTER, CENTER);
    textSize (height/11);
    text("MAIN MENU", framerectX, framerectY, framerectwidth, framerectheight);
  }

  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////  M A I N   M E N U   S C R E E N  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  //main menu
  if (mainmenu) {
    background (0);
    textSize (height/6);
    textAlign (CENTER, BOTTOM);
    fill (255);
    text ("PONG", width/2, height/6);
    gameisover = false;
    cheatpage = false;

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
    fill (0);
    textAlign (CENTER, CENTER);
    textSize (height/14);
    text("SHOW FRAME RATE", framerectX, framerectY, framerectwidth, framerectheight);

    //cheats button
    fill (255);
    rect (cheatX, cheatY, cheatwidth, cheatheight, butcorn);
    textSize (height/6);
    fill (0);
    textAlign (CENTER, CENTER);
    text ("CHEATS", cheatX + cheatwidth/2, cheatY + cheatheight/2.5);
  }

  ///////////////////////////////////////////////////////////////////////////////////////////////////////////   C H E A T   P A G E     ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////    

  if (cheatpage) {
    background (0);
    textSize (height/6);
    textAlign (CENTER, BOTTOM);
    fill (255);
    text ("CHEATS", width/2, height/6);
    mainmenu = false;
    gameisover = false;

    //cheats button
    fill (255);
    rect (cheatX, cheatY, cheatwidth, cheatheight, butcorn);
    fill (0);
    textAlign (CENTER, CENTER);
    textSize (height/11);
    text("MAIN MENU", cheatX, cheatY, cheatwidth, cheatheight);

    //aimbot colour changing rectangle
    if (aimbot) {
      fill (20, 255, 20);
    } else {
      fill (255, 20, 20);
    }
    rect (framerectX, framerectY, framerectwidth, framerectheight, butcorn);

    //invincibility button
    if (bounceoffback) {
      fill (20, 255, 20);
    } else {
      fill (255, 20, 20);
    }
    rect (startrectX, startrectY, startrectwidth, startrectheight, butcorn);
    fill (0);
    textSize (height/9);
    textAlign (CENTER, CENTER);
    text ("INVINCIBLE", startrectX + startrectwidth/2, startrectY + startrectheight/2.5);

    //frame rate text
    fill (0);
    textAlign (CENTER, CENTER);
    textSize (height/6);
    text("AIMBOT", framerectX, framerectY, framerectwidth, framerectheight);

    //tickrate buttons
    fill(255);
    rect (resleftX, restopY, resbutwidth, resbutheight, butcorn);
    rect (resrightX, restopY, resbutwidth, resbutheight, butcorn);
    rect (resleftX, resbottomY, resbutwidth, resbutheight, butcorn);
    rect (resrightX, resbottomY, resbutwidth, resbutheight, butcorn);

    //tick rate buttons text
    fill (0);
    textAlign (CENTER, CENTER);
    textSize (height/17);    
    text("30tick", resleftX, restopY, resbutwidth, resbutheight);
    text("60tick", resrightX, restopY, resbutwidth, resbutheight);
    text("120tick", resleftX, resbottomY, resbutwidth, resbutheight);
    text("240tick", resrightX, resbottomY, resbutwidth, resbutheight);
  }

  ///////////////////////////////////////////////////////////////////////////////////////////////////////////   E N D   O F   M E N U S   ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
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

  //framerate/aimbot/mainmenu button
  if ((mainmenu || cheatpage || gameisover) && mouseX >= framerectX && mouseX <= framerectX + framerectwidth && mouseY >= framerectY && mouseY <= framerectY + framerectheight) {
    framecounter = mainmenu ? !framecounter : framecounter;
    aimbot = cheatpage ? !aimbot : aimbot;
    if (gameisover) {
      gameisover = false;
      mainmenu = true;
      cheatpage = false;
    }
  }

  //cheats/main menu button
  if ((mainmenu || cheatpage) && mouseX >= cheatX && mouseX <= cheatX + cheatwidth && mouseY >= cheatY && mouseY <= cheatY + cheatheight) {
    mainmenu = mainmenu ? false : true;
    cheatpage = cheatpage ? false : true;
  }

  //start button main menu and game over
  else if (mouseX >= startrectX && mouseX <= startrectX + startrectwidth && mouseY >= startrectY && mouseY <= startrectY + startrectheight) {
    if (mainmenu || gameisover) {
      mainmenu = false;
      gameisover = false;
      score = 0;
      ballY = random (0, height - ballwidth);
      ballX = width/2;
      ballVX = startingballVX;
      ballVY = startingballVY;
    }
    bounceoffback = cheatpage ? !bounceoffback : bounceoffback;
  }

  //die button
  if ((aimbot || bounceoffback) && !mainmenu && !cheatpage && !gameisover && mouseX >= dieX && mouseX <= dieX + diewidth && mouseY >= dieY && mouseY <=dieY + dieheight) {
    gameisover = true;
  }

  //size buttons
  if (cheatpage) {
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
