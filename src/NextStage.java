package src;

import java.applet.Applet;

import processing.core.*;

class NextStage extends AppBase {

  Button next;

  public NextStage(PApplet parentApplet) {
    super(parentApplet);
    next = new Button("N E X T", 50, 200, 550, 200, 50, parentApplet);
  }

  void update() {

    parent.background(0);
    parent.fill(255);
    parent.textAlign(PApplet.CENTER);
    parent.textSize(30);
    parent.text("NextStage!!", parent.width / 2, 100);
    next.update();
  }

  Mode clicked() {
    if (next.isOnMouse()) {
      next.exist = false;
      return Mode.GAME;
    }
    return Mode.NEXT_STAGE;
  }
}
