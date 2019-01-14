String [] names = {"Line", "Square", "T", "LeftL", "RightL", "S", "Z"}; 
Piece currentPiece;
int timer;
int linesCleared;
ArrayList <Block> totalBlocks = new ArrayList <Block> ();

void setup()
{
  size(400, 720);
  currentPiece = new Piece(200, 0, names, int(random(names.length)));
}

void draw()
{
  timer++;
  background(0);
  frameRate((linesCleared * 3) + 60); 
  if (timer % 20 == 0)
  {
    currentPiece.updatePosition(totalBlocks);
  }
  if ((currentPiece.checkIntersect(totalBlocks, currentPiece.blockSize) == true) && (timer % 40 == 0))
  {
    currentPiece.speed = 0;
  }
  color [] gp = new color [2];
  gp[0] = color(random(100, 200), 50, random(150, 250));
  gp[1] = color(50, random(75, 215), 75);
  int num = (int)(random(20))/11;
  if (currentPiece.speed == 0)
  {
    for (int i = 0; i < 4; i++)
    {
      Block b = currentPiece.blocks[i];
      b.fillMeIn(gp[num]);
      totalBlocks.add(b);
    }
    currentPiece = new Piece(200, 0, names, int(random(names.length)));
  }
  fullLine(totalBlocks, currentPiece);
  for (Block e : totalBlocks)
  {
    e.display();
  }
  currentPiece.display(); 
  fill(255);
  textSize(16);
  text(new String("Lines Cleared: " + linesCleared), 10, 20);
  for (Block e : totalBlocks)
  {
    if (e.yPos <= 0)
      gameOver();
  }
}

void gameOver()
{
  currentPiece.yPos = height + 400;
  for (Block e : totalBlocks)
  {
    e.setYPos(-10);
  }
  textSize(16);
  text("GAME OVER", 4, height/2);
  noLoop();
}

void gamePause()
{
}

void fullLine(ArrayList <Block> totalBlocks, Piece currentPiece)
{
  int fullLine = -10;
  for (int gridY = 0; gridY < height; gridY += currentPiece.blockSize)
  {
    int sum = 0;
    for (Block e : totalBlocks)
    {
      if ((e.yPos == gridY) && (0 <= e.xPos) && (width >= e.xPos)) 
      {
        sum++;
      }
    }
    if (sum >= 10)
    {
      fullLine = gridY;
      linesCleared++;
    }
  }
  for (int index = totalBlocks.size() - 1; index >= 0; index--)
  {
    Block b = totalBlocks.get(index);
    if (b.yPos == fullLine)
    {
      totalBlocks.remove(index);
    }
  }
  for (Block e : totalBlocks)
  {
    int yPos_ = e.yPos;
    if (yPos_ < fullLine)
    {
      e.setYPos(yPos_ + currentPiece.blockSize);
    }
  }
}

void keyReleased()
{
  if (key == CODED)
  {
    if (keyCode == UP)
    {
      currentPiece.rotate();
    }
    if (keyCode == RIGHT)
    {
      currentPiece.moveRight(totalBlocks);
    }
    if (keyCode == LEFT)
    {
      currentPiece.moveLeft(totalBlocks);
    }
    if (keyCode == DOWN)
    {
      currentPiece.updatePosition(totalBlocks);
    }
  }
  if (key == ' ')
    currentPiece.shootDown(totalBlocks);
}
