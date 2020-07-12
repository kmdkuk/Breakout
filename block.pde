class Block
{
  float x, y;//左上の座標
  float w = width/Globals.block_width;
  float h = ((height-80) /2 ) / Globals.block_height;
  int life;
  Block(int i, int j)
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
