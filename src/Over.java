package src;

import processing.core.*;

class Over extends AppBase {
  Button totitle;

  public Over(PApplet parentPApplet) {
    super(parentPApplet);
    totitle = new Button("T I T L E", 50, 200, 550, 200, 50, parentPApplet);
  }

  void update() {
    parent.background(0);
    parent.fill(255);
    parent.textAlign(PApplet.CENTER);
    parent.textSize(30);
    parent.text("GameOver!!", parent.width / 2, 100);
    parent.textAlign(PApplet.LEFT);
    totitle.update();
  }

  Mode clicked() {
    if (totitle.isOnMouse()) {
      totitle.exist = false;
      return Mode.TITLE;
    }
    return Mode.CLEAR;
  }
}
