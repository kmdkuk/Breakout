class ball
{
  float x;
  float y;
  float w = 10.0;
  float h = 10.0;
  float anglex = sin(radians(45));//角度
  float angley = cos(radians(45));
  float speed = 3.0;
  float sx = anglex * speed;
  float sy = angley * speed;
  float dx = sx;//１フレームごとの距離
  float dy = sy;
  boolean exist = false;


  ball()
  {
  }
  void update(boolean sflag)
  {
    if (exist == true)
    {
      if (sflag)
      {
        // move ball
        x = x + dx; 
        y = y + dy;
        //background(0);
      } else
      {
        x = pad_x + pad_w/2;
        y = height-h/2-50;
      }
      fill(random(255), random(255), random(255));
      ellipse(x, y, w, h); // ball
    }
  }

  void supdate()
  {
    sx = anglex * speed;
    sy = angley * speed;
  }
}
