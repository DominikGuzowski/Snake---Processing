Player snake;
static Food food;
int SCALE = 16;
int SCREENX = 512;
int SCREENY = 512;
int cols = floor(SCREENX/SCALE);
int rows = floor(SCREENY/SCALE);
PFont font;
int oldX;
int oldY;
boolean stopGame = true;
int highScore = 0;
int loadedScore;
String[] temp;

void settings()
{
  size(SCREENX, SCREENY);
  font = loadFont("CourierNewPS-BoldMT-24.vlw");
  temp = loadStrings("highScore.txt");
  loadedScore = Integer.parseInt(temp[0]);
  highScore = loadedScore;
}
void setup()
{
  frameRate(10);
  snake = new Player((floor(random(cols)))*SCALE, (floor(random(rows))*SCALE));
  food = new Food((floor(random(cols)))*SCALE, (floor(random(rows))*SCALE));
}

void draw()
{
  background(51);
  drawGrid();

  if (!stopGame)
  {
    updateGame();
    snake.draw();
    snake.checkCollision();
  } else
  {
    if (highScore == 0)
    {
      text("Press SPACE to play!", 125, 250);
    } else
    {
      text("Game Over!", 195, 250);
    }
  }
  displayScore();
}

void drawGrid()
{
  stroke(255, 10);
  for (int i = 0; i < rows; i++)
  {
    line(0, SCALE*i, SCREENX, SCALE*i);
  }
  for (int i = 0; i < cols; i++)
  {
    line(SCALE*i, 0, SCALE*i, SCREENY);
  }
}

void displayScore()
{
  fill(255);
  textFont(font);
  text("Score: " + snake.tail.size(), 0, SCALE);
  text("HS: " + highScore, 420, SCALE);
}

void updateGame()
{
  if (snake.tail.size() > highScore)
  {
    highScore = snake.tail.size();
  }
  if (snake.tail.size() > 0)
  {
    oldX = snake.tail.get(snake.tail.size()-1).x;
    oldY = snake.tail.get(snake.tail.size()-1).y;
  } else
  {
    oldX = snake.x;
    oldY = snake.y;
  }

  if (snake.eatFood(food))
  {
    food = null;
  }
  if (food != null)
  {
    food.draw();
  } else
  {
    respawnFood(snake.tail);
  }
}

void keyPressed()
{
  if (stopGame)
  {
    if (keyCode == ' ')
    {
      stopGame = !stopGame;
      setup();
    }
  } else
  {
    if (keyCode == UP && snake.ySpeed != 1*SCALE)
    {
      snake.direction(0, -1);
    } else if (keyCode == DOWN && snake.ySpeed != -1*SCALE)
    {
      snake.direction(0, 1);
    } else if (keyCode == RIGHT && snake.xSpeed != -1*SCALE)
    {
      snake.direction(1, 0);
    } else if (keyCode == LEFT && snake.xSpeed != 1*SCALE)
    {
      snake.direction(-1, 0);
    }
  }
}

void respawnFood(ArrayList<Tail> tail)
{
  food = new Food((floor(random(cols)))*SCALE, (floor(random(rows))*SCALE));
  for (Tail t : tail)
  {
    if (food.x == t.x && food.y == t.y)
    {
      respawnFood(tail);
      break;
    }
  }
}
