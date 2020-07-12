class main {
  MODE mode;
  Title title;
  Game game;
  Clear clear;
  Over over;
  main(){
    mode = MODE.TITLE;
    title = new Title();
    game = new Game();
    clear = new Clear();
    over = new Over();
  }
  void draw() {
    switch (mode) {
    case TITLE:
      background(0);
      // boundrect();
      title.draw();
      break;
    case GAME:
      game.draw();
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
    switch (mode){
      case TITLE:
        mode = title.mouseClicked();
        break;
      case GAME:
        game.mouseClicked();
        break;
      case CLEAR:
        mode = clear.mouseClicked();
        break;
      case OVER:
        mode = over.mouseClicked();
        break;
    }
    
  }
}
