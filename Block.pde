class Block
{
  int xPos;
  int yPos;
  int h;
  int w;
  color fill;
  color stroke;

  Block(int xPos, int yPos)
  {
    fill = color(255);
    this.xPos = xPos;
    this.yPos = yPos;
    h = 40;
    w = 40;
  }

  int getYPos()
  {
    return yPos;
  }

  int getXPos()
  {
    return xPos;
  }

  void setYPos(int y)
  {
    yPos = y;
  }

  void fillMeIn (color fill_)
  {
    fill = fill_;
  }

  void display()
  {
    fill(fill);
    stroke(255);
    rect(xPos, yPos, w, h);
  }

  String toString()
  {
    return (new String("my yPos = " + yPos + ", my xPos = " + xPos));
  }
}