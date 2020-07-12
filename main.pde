class Main {
  Mode prevMode;
  Mode Mode;
  Title title;
  Game game;
  NextStage nextStage;
  Clear clear;
  Over over;
  Main() {
    prevMode = Mode.TITLE;
    Mode = Mode.TITLE;
    title = new Title();
    game = new Game();
    nextStage = new NextStage();
    clear = new Clear();
    over = new Over();
  }
  void update() {
    switch (Mode) {
    case TITLE:
      if (prevMode != Mode.TITLE) {
        println("title.init();");
        title.init();
      }
      prevMode = Mode;
      background(0);
      title.update();
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
      prevMode = Mode;
      Mode = game.update();
      break;
    case NEXT_STAGE:
      nextStage.update();
      break;
    case CLEAR:
      clear.update();
      break;
    case OVER:
      over.update();
      break;
    }
    /*0:titledraw
     1:titlewait
     2:maingame
     3:クリアー画面
     4:ゲームオーバー画面
     */
  }
  void clicked() {
    switch (Mode) {
    case TITLE:
      prevMode = Mode;
      Mode = title.clicked();
      break;
    case GAME:
      game.clicked();
      break;
    case NEXT_STAGE:
      prevMode = Mode;
      Mode = nextStage.clicked();
      break;
    case CLEAR:
      prevMode = Mode;
      Mode = clear.clicked();
      break;
    case OVER:
      prevMode = Mode;
      Mode = over.clicked();
      break;
    }
  }
}
