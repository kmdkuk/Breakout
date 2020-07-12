class Clear {
  button totitle = new button("T I T L E", 50, 200, 550, 200, 50);
  button next = new button("N E X T", 50, 200, 550, 200, 50);
  void draw() {
    background(0);
    fill(255);
    textAlign(CENTER);
    textSize(30);
    if (s < 9) {
      text("NextStage!!", width / 2, 100);
      next.update();
    } else {
      text("Conglaturation!!", width / 2, 100);
      totitle.update();
    }
    textAlign(LEFT);
  }
  
  MODE mouseClicked(){
    if (totitle.isOnMouse()) {
      dnow = 0; // title描画のための変数初期化
      for (int i = 0; i < 6; i++) {
        for (int j = 0; j < 32; j++) {
          dtitle[i][j] = false;
          titley[i][j] = 0;
        }
      }
      for (int i = 0; i < 40; i++) {
        while (dboundx[i] == 0 || dboundy[i] == 0) {
          boundx[i] = int(random(380));
          boundy[i] = int(random(280));
          dboundx[i] = int(random(-3, 3));
          dboundy[i] = int(random(-3, 3));
        }
      }
      s = 0; //ステージリセット
      totitle.exist = false;
      return MODE.TITLE;
    }
    return MODE.CLEAR;
  }
}
