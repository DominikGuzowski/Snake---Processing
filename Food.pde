class Food
{
  color foodColor;
  int x, y;
  Food(int x, int y)
  {
    this.x = x;
    this.y = y;
  }
  
  void draw()
  {
    fill(50, 200, 0);
    rect(x, y, SCALE, SCALE);
  }
}
