package src;

import processing.core.*;

class Button extends AppBase {
  float x, y, w, h;
  float size;
  String text;
  boolean exist = false;

  // ボタンの文字,x座標,y座標,幅,高さ
  Button(String s, float si, float a, float b, float c, float d, PApplet parentApplet) {
    super(parentApplet);
    text = s;
    size = si;
    x = a;
    y = b;
    w = c;
    h = d;
  }

  void update() {
    exist = true;
    if (isOnMouse()) {
      parent.fill(0, 255, 0);
    } else {
      parent.fill(255, 255, 255, 200);
    }
    parent.rect(x, y, w, h);
    parent.textAlign(PApplet.CENTER);
    parent.textSize(size);
    parent.fill(0);
    parent.text(text, x + w / 2, y + h - 5);
    parent.textAlign(PApplet.LEFT);
  }

  boolean isOnMouse() {
    if (exist) {
      if (parent.mouseX > x && parent.mouseX < x + w && parent.mouseY > y && parent.mouseY < y + h) {
        return true;
      }
    }
    return false;
  }
}
