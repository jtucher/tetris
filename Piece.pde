class Piece
{
  int xPos;
  int yPos;
  int speed;
  int blockSize;
  int w;
  int h;
  String name;
  int index;
  int rotationState;
  Block  [] blocks;

  Piece(int xPos, int yPos, String [] names, int index)
  {
    this.xPos = xPos;
    this.yPos = yPos;
    blockSize = 40;
    this.speed = 40;
    name = names[index];
    this.index = index;
    rotationState = 0;
    blocks = new Block[4];
    assignSize();
  }

  boolean checkIntersect(ArrayList <Block> totalBlocks, int add)
  {
    for (Block e : totalBlocks)
    {
      for (int i = 0; i < 4; i++)
      {
        if ((blocks[i].yPos + add == e.getYPos()) &&
          (blocks[i].xPos == e.getXPos()))
        {
          return true;
        }
      }
    }
    return false;
  }

  void shootDown(ArrayList <Block> totalBlocks)
  {
    int yTemp = yPos;
    for (int a = 0; a < totalBlocks.size(); a++)
    {
      Block hi = totalBlocks.get(a);
      for (int b = 0; b < 4; b++)
      {
        if (hi.xPos == blocks[b].xPos)
        {
          if (yTemp == yPos)
          {
            yPos = hi.yPos - h;
          }
        }
      }
    }
    if (yTemp == yPos)
    {
      yPos = height - h;
    }
  }


  void moveLeft(ArrayList <Block> totalBlocks)
  {
    if (checkIntersect(totalBlocks, 0) == false)
    {
      int xMin = width + 10;
      for (Block e : blocks)
      {
        if (e.xPos < xMin)
          xMin = e.xPos;
      }
      if (xMin - blockSize >= 0)
        xPos -= blockSize;
    }
  }

  void moveRight(ArrayList <Block> totalBlocks)
  {
    if (checkIntersect(totalBlocks, 0) == false)
    {
      int xMax = -10;
      for (Block e : blocks)
      {
        if (e.xPos > xMax)
          xMax = e.xPos;
      }
      if (xMax + blockSize < width)
        xPos += blockSize;
    }
  }

  void updatePosition(ArrayList <Block> totalBlocks)
  {
    if (checkIntersect(totalBlocks, blockSize) == false)
    {
      for (Block e : blocks)
      {
        if (e.getYPos() + blockSize == height)
          speed = 0;
      }
      yPos = yPos + speed;
    }
  }

  void rotate()
  {
    int tempW = w;
    w = h;
    h = tempW;
    rotationState++;
  }

  void display()
  {
    if (name == "Line")
    {
      for (int i = 0; i < 4; i++)
      {
        if (w > h)
          blocks[i] = new Block(xPos + (blockSize * i) - (blockSize * 2), yPos);
        if (h > w)
          blocks[i] = new Block(xPos, yPos + (blockSize * i) - (blockSize * 2));
      }
    }
    if (name == "Square")
    {
      blocks[0] = new Block(xPos, yPos);
      blocks[1] = new Block(xPos + blockSize, yPos);
      blocks[2] = new Block(xPos + blockSize, yPos + blockSize);
      blocks[3] = new Block(xPos, yPos + blockSize);
    }
    if (name == "T")
    {
      for (int i = 0; i < 3; i++)
      {
        if (w > h)
          blocks[i] = new Block(xPos + (blockSize * i), yPos);
        if (h > w)
          blocks[i] = new Block(xPos, yPos + (blockSize * i));
      }
      if (rotationState % 4 == 0)
        blocks[3] = new Block(xPos + blockSize, yPos - blockSize);
      if (rotationState % 4 == 1)
        blocks[3] = new Block(xPos + blockSize, yPos + blockSize);
      if (rotationState % 4 == 2)
        blocks[3] = new Block(xPos + blockSize, yPos + blockSize);
      if (rotationState % 4 == 3)
        blocks[3] = new Block(xPos - blockSize, yPos + blockSize);
    }
    if (name == "RightL")
    { 
      for (int i = 0; i < 3; i++)
      {
        if (w > h)
          blocks[i] = new Block(xPos + (blockSize * i), yPos);
        if (h > w)
          blocks[i] = new Block(xPos, yPos + (blockSize * i));
      }
      if (rotationState % 4 == 0)
        blocks[3] = new Block(xPos, yPos - blockSize);
      if (rotationState % 4 == 1)
        blocks[3] = new Block(xPos + blockSize, yPos);
      if (rotationState % 4 == 2)
        blocks[3] = new Block(xPos + (blockSize * 2), yPos + blockSize);
      if (rotationState % 4 == 3)
        blocks[3] = new Block(xPos - blockSize, yPos + (blockSize * 2));
    }
    if (name == "LeftL")
    {
      for (int i = 0; i < 3; i++)
      {
        if (w > h)
          blocks[i] = new Block(xPos + (blockSize * i), yPos);
        if (h > w)
          blocks[i] = new Block(xPos, yPos + (blockSize * i));
      }
      if (rotationState % 4 == 0)
        blocks[3] = new Block(xPos + (blockSize * 2), yPos - blockSize);
      if (rotationState % 4 == 1)
        blocks[3] = new Block(xPos + blockSize, yPos + (blockSize * 2));
      if (rotationState % 4 == 2)
        blocks[3] = new Block(xPos, yPos + blockSize);
      if (rotationState % 4 == 3)
        blocks[3] = new Block(xPos - blockSize, yPos);
    }
    if (name == "S")
    {
      if ((rotationState % 4 == 0) || (rotationState % 4 == 2))
      {
        blocks[0] = new Block(xPos + blockSize, yPos);
        blocks[1] = new Block(xPos + (blockSize * 2), yPos);
        blocks[2] = new Block(xPos, yPos + blockSize); 
        blocks[3] = new Block(xPos + blockSize, yPos + blockSize);
      }
      if ((rotationState % 4 == 1) || (rotationState % 4 == 3))
      {
        blocks[0] = new Block(xPos, yPos);
        blocks[1] = new Block(xPos, yPos + blockSize);
        blocks[2] = new Block(xPos + blockSize, yPos + blockSize);
        blocks[3] = new Block(xPos + blockSize, yPos + (blockSize * 2));
      }
    }
    if (name == "Z")
    {
      if ((rotationState % 4 == 0) || (rotationState % 4 == 2))
      {
        blocks[0] = new Block(xPos, yPos);
        blocks[1] = new Block(xPos + blockSize, yPos);
        blocks[2] = new Block(xPos + blockSize, yPos + blockSize);
        blocks[3] = new Block(xPos + (blockSize * 2), yPos + blockSize);
      }
      if ((rotationState % 4 == 1) || (rotationState % 4 == 3))
      {
        blocks[0] = new Block(xPos + blockSize, yPos);
        blocks[1] = new Block(xPos + blockSize, yPos + blockSize);
        blocks[2] = new Block(xPos, yPos + blockSize);
        blocks[3] = new Block(xPos, yPos + (blockSize * 2));
      }
    }
    for (Block e : blocks)
    {
      e.display();
    }
  }

  void assignSize()
  {
    if (index == 0)
    {
      w = blockSize * 4;
      h = blockSize;
    }
    if (index == 1)
    {
      w = blockSize * 2;
      h = blockSize * 2;
    }
    if (index >= 2)
    {
      w = blockSize * 3;
      h = blockSize * 2;
    }
  }

  String toString()
  {
    return("my yPos = " + yPos + ", my xPos = " + xPos + "my type = " + name);
  }
}