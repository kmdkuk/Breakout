class laser
{
  float x;
  float y;
  boolean exist = false;
  laser()
  {
  }

  void update()
  {
    y -= 1;
    fill(255, 255, 0);
    rect(x, y, 5, 10);
    for (int i = 0; i < tate; i++)
    {
      for (int j = 0; j< yoko; j++)
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
