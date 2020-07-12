class block
{
  float x, y;//左上の座標
  float w = width/globals.block_width;
  float h = ((height-80) /2 ) / globals.block_height;
  int life;
  block(int i, int j)
  {
    x = w * j;
    y = h * i +100;
  }
  void update()
  {
    if (life > 0)
    {
      fill(255);
      rect(x, y, w, h);
    }
  }
}
