package src;

import processing.core.*;

class Clear extends AppBase {
  Button totitle;

  public Clear(PApplet parentApplet) {
    super(parentApplet);
    totitle = new Button("T I T L E", 50, 200, 550, 200, 50, parent);
  }

  public void update() {
    parent.background(0);
    parent.fill(255);
    parent.textAlign(PApplet.CENTER);
    parent.textSize(30);
    parent.text("Conglaturation!!", parent.width / 2, 100);
    totitle.update();
    parent.textAlign(PApplet.LEFT);
  }

  Mode clicked() {
    if (totitle.isOnMouse()) {
      totitle.exist = false;
      return Mode.TITLE;
    }
    return Mode.CLEAR;
  }
}
