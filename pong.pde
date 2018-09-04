//boolean variables
boolean framecounter;
boolean gameisover;
boolean mainmenu;
boolean cheatpage;
boolean aimbot;
boolean bounceoffback;

//ball variables
float ballX;   //ball x position (top left corner)
float ballY;   //ball y position (top left corner)
float ballwidth;  //width and height of ball
float ballcorner;  //size of the rounding at the corner of the ball, also used for paddles.
float ballVX;  //ball x-axis velocity (+ve is right)
float ballVY;  //ball y-axis velocity (+ve is down)

//paddle variables
float paddleX;  //paddle x position (top left corner)
float paddleY;  //paddle y position (top left corner)
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
  //size (1280, 720);

  //if you want it to be fullscreen, un // the fullScreen function
  fullScreen ();

  //framerate, adjust to speed up or down the game
  framerate = 60;
  frameRate(framerate);

  //info about ball
  ballX = width/2;
  ballY = height/2;
  ballwidth = width/60;
  ballcorner = width/240;
  ballVX = width/framerate/5.333;
  ballVY = width/framerate/5.333;

  //info about paddle
  paddleX = width*5/6;
  paddleY = height*5/12;
  paddlewidth = width/60;
  paddleheight = height/6;
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
  dieY = height/6;
  diewidth = width/8;
  dieheight = height/12;

  aimbot = false;//        put true to enable aimbot (can be accessed in cheat settings)
  framecounter = false;//  put true to enable frame rate counter (can be accessed in main menu settings)
  mainmenu = true;//       put true to start on main menu (don't change)
  bounceoffback = false;// put true to let ball bounce off back wall (may be slightly glitchy) (invincibility) (can be accessed in cheat settings)
  gameisover = false;//    put true to make game be over at start
  cheatpage = false;//     put true to start on cheat page at start
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////   A C T I V E  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//active stuff (happens every frame)
void draw() { 

  background (0); //black background to cover old frame

  //move ball x&y-axis
  ballX += ballVX;  
  ballY += ballVY;

  //bounce off top or bottom
  ballVY = ballY <= 0 ? abs(ballVY) : ballY + ballwidth -1 >= height ? -abs(ballVY) : ballVY;

  //bounce off left
  if (ballX < width/6 + paddlewidth) { 
    ballVX = abs(ballVX);
  }  
  
  //if hits right wall, game over/bounce back/randomly respawn/respawn in middle
  if (ballX + ballwidth> width) { 
    ballVX = -abs(ballVX);
    gameisover = bounceoffback ? gameisover : true;
  }  

  //xbounce off paddle
  if (ballVX > 0 && ballX + ballwidth -1 > paddleX && ballX + ballwidth < paddleX + paddlewidth && ((ballY > paddleY && ballY < paddleY + paddleheight -1) || (ballY + ballwidth -1 > paddleY && ballY + ballwidth < paddleY + paddleheight))) {
    score++;
    ballVX = -abs(ballVX);
  }  
  //ybounce off paddle  
  if (((ballY < paddleY && ballY + ballwidth -1 > paddleY) || (ballY < paddleY + paddleheight -1 && ballY + ballwidth > paddleY + paddleheight)) && ((ballX + ballwidth -1 > paddleX && ballX + ballwidth < paddleX + paddlewidth) || (ballX < paddleX + paddlewidth -1 && ballX > paddleX))) {
    ballVY = (ballY < paddleY && ballY + ballwidth -1 > paddleY) ? -abs(ballVY) : abs(ballVY);
  }

  //moving paddle
  paddleY = aimbot ? ballY + ballwidth/2 - paddleheight/2 <=0 ? 0 : ballY + ballwidth/2 + paddleheight/2 >= height ? height - paddleheight : ballY + ballwidth/2 - paddleheight/2 : mouseY < paddleY ? mouseY + width/framerate/4 >= paddleY ? mouseY : paddleY - width/framerate/4 : mouseY > paddleY + paddleheight ? mouseY - width/framerate/4 < paddleY + paddleheight ? mouseY - paddleheight +1 : paddleY + width/framerate/4 : paddleY;

  //opposite paddle Y
  oppaddleY = ballY + ballwidth/2 - paddleheight/2 <=0 ? 0 : ballY + ballwidth/2 + paddleheight/2 >= height ? height - paddleheight : ballY + ballwidth/2 - paddleheight/2;

  //display score and die button
  textSize (height/6);
  textAlign (RIGHT, TOP);
  fill (255);
  text (score, width, 0);
  if (bounceoffback || aimbot) {
    rect (dieX, dieY, diewidth, dieheight, butcorn);
    fill (0);
    textAlign (CENTER, CENTER);
    textSize (height/32);
    text("CLICK TO DIE", dieX, dieY, diewidth, dieheight);
  }

  //draw ball paddles (at end so most up to date)
  fill (255);
  rect (ballX, ballY, ballwidth, ballwidth, ballcorner);
  rect (paddleX, paddleY, paddlewidth, paddleheight, ballcorner);
  rect (width/6, oppaddleY, paddlewidth, paddleheight, ballcorner);

  //increase speed
  ballVX *= (1 + 0.0001*60/framerate);
  ballVY *= (1 + 0.0001*60/framerate);

  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////  U N I V E R S A L    S C R E E N   S T U F F   ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  if (gameisover || mainmenu || cheatpage) {
    mainmenu = mainmenu ? true : false;
    gameisover = gameisover ? true : false;
    cheatpage = cheatpage ? true : false;
    ballX = width/2;
    background (0);

    //title
    textSize (height/6);
    fill (255);
    textAlign (CENTER, BOTTOM);
    text (mainmenu ? "PONG" : gameisover ? "GAME OVER" : "CHEATS", width/2, height/6);

    //start/invincibility button
    fill (255);
    textSize (height/6);
    if (cheatpage) {
      textSize (height/9);
      if (bounceoffback) {
        fill (20, 255, 20);
      } else {
        fill (255, 20, 20);
      }
    }
    rect (startrectX, startrectY, startrectwidth, startrectheight, butcorn);
    fill (0);
    textAlign (CENTER, CENTER);
    text (cheatpage ? "INVINCIBLE" : "START", startrectX + startrectwidth/2, startrectY + startrectheight/2.5);

    //framerate/aimbot/mainmenu button
    textSize (height/11);
    fill (255);
    textAlign (CENTER, CENTER);
    if (cheatpage) {
      if (aimbot) {
        fill (20, 255, 20);
      } else {
        fill (255, 20, 20);
      }
    } 
    if (mainmenu) {
      textSize (height/14);
      if (framecounter) {
        fill (20, 255, 20);
      } else {
        fill (255, 20, 20);
      }
    }
    rect (framerectX, framerectY, framerectwidth, framerectheight, butcorn);
    fill (0);
    text (mainmenu ? "SHOW FRAME RATE" : gameisover ? "MAIN MENU" : "AIMBOT", framerectX, framerectY, framerectwidth, framerectheight);

    //cheats button
    if (!gameisover) {
      fill (255);
      rect (cheatX, cheatY, cheatwidth, cheatheight, butcorn);
      textSize (height/12);
      fill (0);
      textAlign (CENTER, CENTER);
      text (mainmenu ? "CHEATS" : "MAIN MENU", cheatX + cheatwidth/2, cheatY + cheatheight/2.5);
    }
  }

  //game is over state
  if (gameisover && !mainmenu) {

    //display score
    textSize (height/6);
    fill (255);
    textAlign (CENTER, BOTTOM);
    text(((aimbot || bounceoffback) ? "CHEATED SCORE: " : "SCORE: ") + score, width/2, height - 50);
  }    

  if (cheatpage) {

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
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////   D E P R E S S E D   M O U S E    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//stuff that happens when mouse is depressed
void mouseReleased () {

  //start button main menu and game over / invincibility button
  if (mouseX >= startrectX && mouseX <= startrectX + startrectwidth && mouseY >= startrectY && mouseY <= startrectY + startrectheight) {
    if (mainmenu || gameisover) {
      mainmenu = false;
      gameisover = false;
      score = 0;
      ballY = random (0, height - ballwidth);
      ballX = width/2;
      ballVX = width/framerate/5.333;
      ballVY = random (2) < 1 ? width/framerate/5.333 : -width/framerate/5.333;
    }
    bounceoffback = cheatpage ? !bounceoffback : bounceoffback;
  }

  //framerate/aimbot/mainmenu button
  else if ((mainmenu || cheatpage || gameisover) && mouseX >= framerectX && mouseX <= framerectX + framerectwidth && mouseY >= framerectY && mouseY <= framerectY + framerectheight) {
    framecounter = mainmenu ? !framecounter : framecounter;
    aimbot = cheatpage ? !aimbot : aimbot;
    if (gameisover) {
      mainmenu = true;
      cheatpage = false;
      gameisover = false;
    }
  }

  //cheats/main menu button
  else if ((mainmenu || cheatpage) && mouseX >= cheatX && mouseX <= cheatX + cheatwidth && mouseY >= cheatY && mouseY <= cheatY + cheatheight) {
    mainmenu = mainmenu ? false : true;
    cheatpage = cheatpage ? false : true;
  }  

  //size buttons
  else if (cheatpage) {
    framerate = (mouseX >= resleftX && mouseX <= resleftX + resbutwidth && mouseY >= restopY && mouseY <= restopY + resbutheight) ? 30 : (mouseX >= resrightX && mouseX <= resrightX + resbutwidth && mouseY >= restopY && mouseY <= restopY + resbutheight) ? 60 : (mouseX >= resleftX && mouseX <= resleftX + resbutwidth && mouseY >= resbottomY && mouseY <= resbottomY + resbutheight) ? 120 : (mouseX >= resrightX && mouseX <= resrightX + resbutwidth && mouseY >= resbottomY && mouseY <= resbottomY + resbutheight) ? 240 : framerate;
    frameRate(framerate);
  }

  //die button
  else if ((aimbot || bounceoffback) && !mainmenu && !cheatpage && !gameisover && mouseX >= dieX && mouseX <= dieX + diewidth && mouseY >= dieY && mouseY <=dieY + dieheight) {
    gameisover = true;
  }
}
