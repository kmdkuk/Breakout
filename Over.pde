class Over {
  Button totitle = new Button("T I T L E", 50, 200, 550, 200, 50);
  void update() {
    background(0);
    fill(255);
    textAlign(CENTER);
    textSize(30);
    text("GameOver!!", width / 2, 100);
    textAlign(LEFT);
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
