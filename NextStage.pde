class NextStage {

  Button next = new Button("N E X T", 50, 200, 550, 200, 50);
  void draw() {

    background(0);
    fill(255);
    textAlign(CENTER);
    textSize(30);
    text("NextStage!!", width / 2, 100);
    next.update();
  }
  
  MODE mouseClicked(){
   
    if (next.isOnMouse()) {
      next.exist = false;
      return MODE.GAME;
    }
    return MODE.NEXT_STAGE;
  }
}
