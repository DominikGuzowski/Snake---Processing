class Player
{
  int x, y;
  int xSpeed, ySpeed;
  int speed;
  int points;
  ArrayList<Tail> tail;
  Player(int x, int y)
  {
    speed = SCALE;
    this.x = x;
    this.y = y;
    xSpeed = 0;
    ySpeed = 0;
    points = 0;
    tail = new ArrayList<Tail>();
  }

  void draw()
  {
    update();
    for (int i = 0; i < tail.size(); i++)
    {
      tail.get(i).draw();
    }
    fill(255, 0, 0);
    rect(x, y, SCALE, SCALE);
  }

  void update()
  {
    if (tail.size() > 0)
    {
      for (int i = tail.size()-1; i > 0; i--)
      {
        tail.set(i, tail.get(i-1));
      }
      tail.set(0, new Tail(x, y));
    }

    if (x >= 0 && x <= SCREENX-SCALE)
    {
      x += xSpeed;
    }
    if (y >= 0 && y <= SCREENY-SCALE)
    {
      y += ySpeed;
    }

    if (x < 0)
    {
      x = SCREENX-SCALE;
    }
    if (x > SCREENX-SCALE)
    {
      x = 0;
    }

    if (y < 0)
    {
      y = SCREENY-SCALE;
    }
    if (y > SCREENY-SCALE)
    {
      y = 0;
    }
  }  

  void direction(int xS, int yS)
  {
    xSpeed = speed*xS;
    ySpeed = speed*yS;
  }

  boolean eatFood(Food food)
  {
    if (x == food.x && y == food.y)
    {
      println("Collided!");
      points++;
      tail.add(new Tail(oldX, oldY));
      return true;
    }
    return false;
  }

  void checkCollision()
  {
    if (tail.size() > 0)
    {
      for (int i = 0; i < tail.size(); i++)
      {
        if (x == tail.get(i).x && y == tail.get(i).y)
        {
          tail = new ArrayList<Tail>();
          if (highScore > loadedScore)
          {
            temp[0] = Integer.toString(highScore);
            saveStrings("highScore.txt", temp);
            temp = loadStrings("highScore.txt");
            loadedScore = Integer.parseInt(temp[0]);
            highScore = loadedScore;
          }
          stopGame = !stopGame;
        }
      }
    }
  }
}
