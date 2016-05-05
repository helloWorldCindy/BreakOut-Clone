

//control the paddle by pressing the left and right button.


float ballX,ballY;
int speedY=-4;
float paddleX,paddleY;
float paddleWidth,paddleHeight;
int[] brickX=new int[10];
int[] brickY=new int[8];
color[] brickColor={color(255,215,0)/*yellow*/,color(192,255,62)/*green*/,color(255,150,36)/*orange*/,color(255,0,0)/*red*/};
float speedX;
final int brickHeight=30;
boolean[][] touched=new boolean[10][8];
boolean touch=false;
int radius=20;
int touchTime=0;
int score;
int turn=2;
boolean gameEnd=false;
int hit=0;
int shrink=0;
int resetBrick=0;
boolean win=false;
int speedCount=0;
boolean touchOrange=false;
boolean touchRed=false;
boolean looseBall=false;
void setup()
{
  size(600,600);
  frameRate(80);
  ballX=width/2;
  paddleX=width/2;
  paddleY=height-paddleHeight;
  ballY=paddleY-radius/2;
  paddleWidth=200;
  paddleHeight=30;
  speedX=random(-3,3);
//store x positions of every single brick in the brickX[] array
  for(int i=0;i<brickX.length;i++)
  {
    brickX[i]=i*60+30;
  }
  //store y positions of every single brick in the brickY[] array
  for(int i=0;i<brickY.length;i++)
  {
    brickY[i]=i*brickHeight+brickHeight/2;
  }
  //set every brick is untouched at the first time
  for(int i=0;i<10;i++)
  {
    for(int j=0;j<8;j++)
    {
      touched[i][j]=false;
    }
  }
  
}
void draw()
{
  background(0);
  //if the game dosen't end
  if(gameEnd==false)
 { 
  paddle();
  drawBrick(60);
  drawBall();
  key();
  showScore();
 }
 //if the game ends
 else
 {
   fill(255);
   textSize(48);
     //if the player hit all the bricks
     if(win==true)
     {
      text("You Win",width/3,height/2);
     }
     //if the player lose all the turns
     else
     {
       text("Game Over",width/3-50,height/2);
     }
 }
 
}
void drawBall()
{
  
  ballY+=speedY;
  ballX+=speedX;
 
  if((((ballX+radius/2>=paddleX-paddleWidth/2)&&(ballX-radius/2<=paddleX+paddleWidth/2)&&(ballY+radius/2>=paddleY-paddleHeight/2))))
   {
     //change the speed of Y 
    if((touchOrange==false)&&(touchRed==false))
    {
      if(hit<4)
     {
       speedY=-4;//if the ball hit the bricks less than 4 times
      }
      if(hit>=4&&hit<12)
      {
       speedY=-6;//if the ball hit the bricks  4 times
       }
       if(hit>=12)
       {
       speedY=-8;//if the ball hit the bricks 12 times
       }
     }
      else
       {
        if(touchOrange==true)//if the ball make the contact with the orange bricks
         {
          speedY=-10;
         }
         if(touchRed==true)//if the ball make the contact with the red bricks
          {
           speedY=-11;
          }
        }
        if(looseBall==true)//if the ball touch the buttom of the window
        {
          hit=0;
          touchOrange=false;
          touchRed=false;
          looseBall=false;
         }
   }
   if(ballY-radius/2<=0)//if the ball hit the top of the window at the first time
   {
     shrink++;
     speedY*=-1;
     if(shrink==1)
     {
       paddleWidth=180;
     }
   }
   if((ballX-radius/2<=0)||(ballX+radius/2>=width))//if the ball hit the left and right edge of the window
   {
     speedX*=-1;
   }
   if(turn<0||win==true)//if the player lose all the turns or hit all the bricks
   {
     gameEnd=true;
   }
    if(score==320)//if the player clear the first screen of bricks
   {
    reset();
    speedY=12;
    resetBrick++;
    score++;
   }
  if(score>=640)//when the player clear two screens of bricks
  {
    win=true;
  }
  ellipseMode(CENTER);
  fill(0,0,255);
  ellipse(ballX,ballY,radius,radius);
}
void paddle()
{
  //draw the paddle
  paddleX=constrain(paddleX,paddleWidth/2,width-paddleWidth/2);
  rectMode(CENTER);
  fill(0,255,0);
  rect(paddleX,paddleY,paddleWidth,paddleHeight);
  
}
void key()
{
  //use the left button and right button to control the paddle
  if(keyPressed)
  {
    if(key==CODED)
   {
    if(keyCode==LEFT)
    {
      paddleX-=7;
    }
    if(keyCode==RIGHT)
    {
      paddleX+=7;
    }
   }
  }
}
void drawBrick(int brickLength)
{ 
  rectMode(CORNER);
  float xBrick=0;
  float yBrick=0;
  color colorBrick=color(0);
  strokeWeight(4);
  for(int i=0;i<10;i++)
  {
    //draw all the bricks
    rectMode(CENTER);
    for(int j=0;j<2;j++)//draw the red bricks
    {
    fill(brickColor[3]);
     if(touched[i][j]==false)
     {
     rect(brickX[i],brickY[j],60,brickHeight);
     }
    }
    for(int j=2;j<4;j++)//draw the orange bricks
    {
    fill(brickColor[2]);
    if(touched[i][j]==false)
     {
     rect(brickX[i],brickY[j],60,brickHeight);
     }
    }
    for(int j=4;j<6;j++)//draw the green bricks
    {
    fill(brickColor[1]);
     if(touched[i][j]==false)
     {
     rect(brickX[i],brickY[j],60,brickHeight);
     }
    }
    for(int j=6;j<8;j++)//draw the yellow bricks
    {
    fill(brickColor[0]);
     if(touched[i][j]==false)
     {
     rect(brickX[i],brickY[j],60,brickHeight);
     }
    }
    for(int j=0;j<8;j++)
    {
      if(((ballY-radius/2)<=brickY[j]+brickHeight/2) && ((ballY+radius/2)>=brickY[j]-brickHeight/2 )&& (abs(brickX[i]-ballX)<=30))//when the ball hit the bottom of the bricks
      {
         if(touched[i][j]==false)
        {
            if(j==7||j==6)//if the yellow brick is hit,the user get 1 score
         {
           score+=1;
         }
         else if(j==5||j==4)//if the grenn brick is hit,the user get 3 score
         {
           score+=3;
         }
         else if(j==3||j==2)//if the orange brick is hit,the user get 5 score
         {
           score+=5;
          touchOrange=true;
         }
         else if(j==1||j==0)//if the red brick is hit,,the user get 7 score
         {
           score+=7;
           touchRed=true;
         }
         hit++;
         if((touchOrange==false)&&(touchRed==false))
         {
           if(hit<4)
         {
          speedY=4;
         }
        if(hit>=4&&hit<12)
         {
          speedY=6;//change the speed when the ball hit the bricks more than 4 times
         }
         if(hit>=12)
         {
           speedY=8;//change the speed when the ball hit the bricks more than 12 times
         }}
         else
         {
           if(touchOrange==true)
           {
             speedY=10;//change the speed when the ball make contact with the orange bricks
           }
           if(touchRed==true)
           {
             speedY=11;//change the speed when the ball makes contact with the red bricks
           }
         }
        }
        touched[i][j]=true;
     }
    if(ballX+radius/2>=brickX[i]-30 && ballX-radius/2<=brickX[i]+30 && abs(((brickY[j]-ballY)))<=brickHeight/2)//when the ball hit the left or right side of the bricks
     {
       if(touched[i][j]==false)
        {
         if(j==7||j==6)
         {
           score+=1;
         }
         else if(j==5||j==4)
         {
           score+=3;
         }
         else if(j==3||j==2)
         {
           score+=5;
         
           touchRed=true;
         }
         else if(j==1||j==0)
         {
           score+=7;
           
           touchRed=true;
          
         }
          speedX*=-1;
          hit++;
        if((touchOrange==false)&&(touchRed==false))
         {if(hit<4)
         {
          speedY=4;
         }
        if(hit>=4&&hit<12)
         {
          speedY=6;
         }
         if(hit>=12)
         {
           speedY=8;
         }}
         else
         {
           if(touchOrange==true)
           {
             speedY=10;
           }
           if(touchRed==true)
           {
             speedY=11;
           }
        }
       }
      touched[i][j]=true;
      }
   }
    if(ballY>=height)//if the ball hit the bottom of the window
   {
     ballX=width/2;
     paddleX=width/2;
     paddleY=height-paddleHeight+30;
     ballY=paddleY-radius/2;
     looseBall=true;
     turn-=1;
    }
   }
}  
    
 
 

void showScore()//show the score
{
  fill(255);
  textSize(20);
  if(resetBrick==0)
 { 
  text("Score: "+score,10,400);
 }
 else
 {
   text("Score: "+(score-1),10,400);
 }
  text("Turns: "+turn,10,500);
}
void reset()//reset all the bricks ,the ball and the paddle when the player clear one screen of the bricks
{
     ballX=width/2;
     paddleX=width/2;
     paddleY=height-paddleHeight+30;
     ballY=paddleY-paddleHeight/2-radius/2;
     if(shrink==1)
     {
       paddleWidth=180;
     }
     speedX=random(-3,3);
     for(int i=0;i<10;i++)
    {
      for(int j=0;j<8;j++)
      {
       touched[i][j]=false;//all the bricks turn to be untouched again
      }
    }
  
}
