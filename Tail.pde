class Tail
{
  int x, y;
  Tail(int x, int y)
  {
    this.x = x;
    this.y = y;
  }
  
  void draw()
  {
    fill(25, 120, 225);
    rect(x, y, SCALE, SCALE);
  }
}
