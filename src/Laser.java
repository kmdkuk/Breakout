package src;

import processing.core.*;

class Laser extends AppBase {
  float x;
  float y;
  boolean exist = false;

  public Laser(PApplet parentApplet) {
    super(parentApplet);
  }

  void update() {
    y -= 1;
    parent.fill(255, 255, 0);
    parent.rect(x, y, 5, 10);
    for (int i = 0; i < Globals.block_height; i++) {
      for (int j = 0; j < Globals.block_width; j++) {
        if (Globals.block[i][j].x < x && x < Globals.block[i][j].x + Globals.block[i][j].w && Globals.block[i][j].y < y
            && y < Globals.block[i][j].y + Globals.block[i][j].h) {
          if (Globals.block[i][j].life > 0) {
            Globals.block[i][j].life--;
            exist = false;
          }
        }
      }
    }
    if (y < 0) {
      exist = false;
    }
  }
}
