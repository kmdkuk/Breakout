package src;

import processing.core.*;

class Block extends AppBase {
  float x, y;// 左上の座標
  float w;
  float h;
  int life;

  Block(int i, int j, PApplet parentApplet) {
    super(parentApplet);
    w = parent.width / Globals.block_width;
    h = ((parent.height - 80) / 2) / Globals.block_height;
    x = w * j;
    y = h * i + 100;
  }

  void update() {
    if (life > 0) {
      parent.fill(255);
      parent.rect(x, y, w, h);
    }
  }
}
