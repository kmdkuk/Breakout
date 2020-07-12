class Clear {
  Button totitle = new Button("T I T L E", 50, 200, 550, 200, 50);
  void draw() {
    background(0);
    fill(255);
    textAlign(CENTER);
    textSize(30);
    text("Conglaturation!!", width / 2, 100);
    totitle.update();
    textAlign(LEFT);
  }

  MODE mouseClicked() {
    if (totitle.isOnMouse()) {
      totitle.exist = false;
      return MODE.TITLE;
    }
    return MODE.CLEAR;
  }
}
