class Clear {
  Button totitle = new Button("T I T L E", 50, 200, 550, 200, 50);
  void update() {
    background(0);
    fill(255);
    textAlign(CENTER);
    textSize(30);
    text("Conglaturation!!", width / 2, 100);
    totitle.update();
    textAlign(LEFT);
  }

  Mode clicked() {
    if (totitle.isOnMouse()) {
      totitle.exist = false;
      return Mode.TITLE;
    }
    return Mode.CLEAR;
  }
}
