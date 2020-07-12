class Laser
{
  float x;
  float y;
  boolean exist = false;

  void update()
  {
    y -= 1;
    fill(255, 255, 0);
    rect(x, y, 5, 10);
    for (int i = 0; i < Globals.block_height; i++)
    {
      for (int j = 0; j< Globals.block_width; j++)
      {
        if (block[i][j].x < x && x < block[i][j].x + block[i][j].w && block[i][j].y < y && y < block[i][j].y + block[i][j].h)
        {
          if (block[i][j].life > 0)
          {
            block[i][j].life --;
            exist = false;
          }
        }
      }
    }
    if (y<0)
    {
      exist = false;
    }
  }
}
