class Main {
  MODE prevMode;
  MODE mode;
  Title title;
  Game game;
  NextStage nextStage;
  Clear clear;
  Over over;
  Main() {
    prevMode = MODE.TITLE;
    mode = MODE.TITLE;
    title = new Title();
    game = new Game();
    nextStage = new NextStage();
    clear = new Clear();
    over = new Over();
  }
  void draw() {
    switch (mode) {
    case TITLE:
      if (prevMode != MODE.TITLE) {
        println("title.init();");
        title.init();
      }
      prevMode = mode;
      background(0);
      title.draw();
      break;
    case GAME:
      switch(prevMode) {
      case TITLE:
        game.init();
        break;
      case NEXT_STAGE:
        game.nextInit();
        break;
      }
      prevMode = mode;
      mode = game.draw();
      break;
    case NEXT_STAGE:
      nextStage.draw();
      break;
    case CLEAR:
      clear.draw();
      break;
    case OVER:
      over.draw();
      break;
    }
    /*0:titledraw
     1:titlewait
     2:maingame
     3:クリアー画面
     4:ゲームオーバー画面
     */
  }
  void mouseClicked() {
    switch (mode) {
    case TITLE:
      prevMode = mode;
      mode = title.mouseClicked();
      break;
    case GAME:
      game.mouseClicked();
      break;
    case NEXT_STAGE:
      prevMode = mode;
      mode = nextStage.mouseClicked();
      break;
    case CLEAR:
      prevMode = mode;
      mode = clear.mouseClicked();
      break;
    case OVER:
      prevMode = mode;
      mode = over.mouseClicked();
      break;
    }
  }
}
