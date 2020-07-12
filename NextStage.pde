class NextStage {

  Button next = new Button("N E X T", 50, 200, 550, 200, 50);
  void update() {

    background(0);
    fill(255);
    textAlign(CENTER);
    textSize(30);
    text("NextStage!!", width / 2, 100);
    next.update();
  }
  
  Mode clicked(){
   
    if (next.isOnMouse()) {
      next.exist = false;
      return Mode.GAME;
    }
    return Mode.NEXT_STAGE;
  }
}
