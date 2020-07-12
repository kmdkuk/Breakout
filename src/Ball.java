package src;

import processing.core.*;

class Ball extends AppBase {
  float x;
  float y;
  float w = (float) 10.0;
  float h = (float) 10.0;
  float anglex = PApplet.sin(PApplet.radians(45));// 角度
  float angley = PApplet.cos(PApplet.radians(45));
  float speed = (float) 3.0;
  float sx = anglex * speed;
  float sy = angley * speed;
  float dx = sx;// １フレームごとの距離
  float dy = sy;
  boolean exist = false;

  public Ball(PApplet parentApplet) {
    super(parentApplet);
  }

  void update(boolean sflag) {
    if (exist == true) {
      if (sflag) {
        // move ball
        x = x + dx;
        y = y + dy;
        // background(0);
      } else {
        x = Globals.pad_x + Globals.pad_w / 2;
        y = parent.height - h / 2 - 50;
      }
      parent.fill(parent.random(255), parent.random(255), parent.random(255));
      parent.ellipse(x, y, w, h); // ball
    }
  }

  void update() {
    sx = anglex * speed;
    sy = angley * speed;
  }
}
